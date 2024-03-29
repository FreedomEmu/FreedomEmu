/*
 * Copyright (C) 2008 - 2011 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 - 2012 Myth Project <http://mythprojectnetwork.blogspot.com/>
 *
 * Myth Project's source is based on the Trinity Project source, you can find the
 * link to that easily in Trinity Copyrights. Myth Project is a private community.
 * To get access, you either have to donate or pass a developer test.
 * You can't share Myth Project's sources! Only for personal use.
 */

#include "ScriptPCH.h"
#include "utgarde_pinnacle.h"

enum Spells
{
    SPELL_SVALA_TRANSFORMING1     = 54140,
    SPELL_SVALA_TRANSFORMING2     = 54205,
    SPELL_TRANSFORMING_CHANNEL    = 54142,

    SPELL_CALL_FLAMES             = 48258, // caster effect only, triggers event 17841
    SPELL_BALL_OF_FLAME           = 48246,
    SPELL_SINSTER_STRIKE          = 15667,
    H_SPELL_SINSTER_STRIKE        = 59409,

    SPELL_RITUAL_PREPARATION      = 48267,
    SPELL_RITUAL_OF_THE_SWORD     = 48276,
    SPELL_RITUAL_STRIKE_TRIGGER   = 48331, // triggers 48277 & 59930, needs NPC_RITUAL_TARGET as spell_script_target
    SPELL_RITUAL_DISARM           = 54159,
    SPELL_RITUAL_STRIKE_EFF_1     = 48277,
    SPELL_RITUAL_STRIKE_EFF_2     = 59930,

    SPELL_SUMMONED_VIS            = 64446,
    SPELL_RITUAL_CHANNELER_1      = 48271,
    SPELL_RITUAL_CHANNELER_2      = 48274,
    SPELL_RITUAL_CHANNELER_3      = 48275,

    // Ritual Channeler spells
    SPELL_PARALYZE                = 48278,
    SPELL_SHADOWS_IN_THE_DARK     = 59407,

    // Scourge Hulk spells
    SPELL_MIGHTY_BLOW             = 48697,
    SPELL_VOLATILE_INFECTION      = 56785,
    H_SPELL_VOLATILE_INFECTION    = 59228
};

enum Yells
{
    SAY_DIALOG_WITH_ARTHAS_1      = -1575015,
    SAY_DIALOG_WITH_ARTHAS_2      = -1575016,
    SAY_DIALOG_WITH_ARTHAS_3      = -1575017,
    SAY_AGGRO                     = -1575018,
    SAY_SLAY_1                    = -1575019,
    SAY_SLAY_2                    = -1575020,
    SAY_SLAY_3                    = -1575021,
    SAY_DEATH                     = -1575022,
    SAY_SACRIFICE_PLAYER_1        = -1575023,
    SAY_SACRIFICE_PLAYER_2        = -1575024,
    SAY_SACRIFICE_PLAYER_3        = -1575025,
    SAY_SACRIFICE_PLAYER_4        = -1575026,
    SAY_SACRIFICE_PLAYER_5        = -1575027,
    SAY_DIALOG_OF_ARTHAS_1        = -1575003,
    SAY_DIALOG_OF_ARTHAS_2        = -1575014
};

enum Creatures
{
    CREATURE_ARTHAS               = 29280, // Image of Arthas
    CREATURE_SVALA_SORROWGRAVE    = 26668, // Svala after transformation
    CREATURE_SVALA                = 29281, // Svala before transformation
    CREATURE_RITUAL_CHANNELER     = 27281,
    CREATURE_SPECTATOR            = 26667,
    CREATURE_RITUAL_TARGET        = 27327,
    CREATURE_FLAME_BRAZIER        = 27273,
    CREATURE_SCOURGE_HULK         = 26555
};

enum Objects
{
    OBJECT_UTGARDE_MIRROR         = 191745
};

enum SvalaPhase
{
    IDLE,
    INTRO,
    NORMAL,
    SACRIFICING,
    SVALADEAD
};

#define DATA_INCREDIBLE_HULK 2043

static const float spectatorWP[2][3] =
{
    {296.95f, -312.76f, 86.36f},
    {297.69f, -275.81f, 86.36f}
};

static Position ArthasPos = { 295.81f, -366.16f, 92.57f, 1.58f };

class boss_svala : public CreatureScript
{
public:
    boss_svala() : CreatureScript("boss_svala") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_svalaAI (creature);
    }

    struct boss_svalaAI : public ScriptedAI
    {
        boss_svalaAI(Creature* c) : ScriptedAI(c), summons(c)
        {
            instance = c->GetInstanceScript();
            Phase = IDLE;

            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_RITUAL_STRIKE_EFF_1, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_RITUAL_STRIKE_EFF_2, true);
        }

        InstanceScript* instance;
        SummonList summons;
        SvalaPhase Phase;

        Position pos;
        float x, y, z;

        uint32 uiIntroTimer;
        uint8 uiIntroPhase;
        uint8 uiSacrePhase;

        TempSummon* pArthas;
        uint64 uiArthasGUID;

        uint32 uiSinsterStrikeTimer;
        uint32 uiCallFlamesTimer;
        uint8 uiFlamesCount;
        uint32 uiSacrificeTimer;
        uint64 uiFlameBrazier_1;
        uint64 uiFlameBrazier_2;

        bool bSacrificed;
        bool bFlames;

        void Reset()
        {
            bSacrificed = false;
            SetCombatMovement(true);
            uiFlamesCount = 0;
            uiFlameBrazier_1 = instance? instance->GetData64(DATA_FLAME_BRAZIER_1) : NULL;
            uiFlameBrazier_2 = instance? instance->GetData64(DATA_FLAME_BRAZIER_2) : NULL;
            bFlames = false;

            summons.DespawnAll();
            me->RemoveAllAuras();

            if(Phase > INTRO)
            {
                me->SetFlying(true);
                me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
            }

            if(Phase > NORMAL)
                Phase = NORMAL;

            uiIntroTimer = 1 * IN_MILLISECONDS;
            uiIntroPhase = 0;
            uiArthasGUID = 0;

            if(instance)
            {
                instance->SetData(DATA_SVALA_SORROWGRAVE_EVENT, NOT_STARTED);
                instance->SetData64(DATA_SACRIFICED_PLAYER, 0);
            }
        }

        void JustReachedHome()
        {
            if(Phase > INTRO)
            {
                me->SetFlying(false);
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                me->SetOrientation(1.58f);
                me->SendMovementFlagUpdate();
            }
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(SAY_AGGRO, me);

            uiSinsterStrikeTimer = 7 * IN_MILLISECONDS;
            uiCallFlamesTimer = urand(10 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);

            if(instance)
                instance->SetData(DATA_SVALA_SORROWGRAVE_EVENT, IN_PROGRESS);
        }

        void JustSummoned(Creature* summon)
        {
            if(summon->GetEntry() == CREATURE_RITUAL_CHANNELER)
                summon->CastSpell(summon, SPELL_SUMMONED_VIS, true);

            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon)
        {
            summons.Despawn(summon);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if(!who)
                return;

            if(Phase == IDLE && me->IsHostileTo(who) && me->IsWithinDistInMap(who, 40))
            {
                Phase = INTRO;
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                if(GameObject *mirror = GetClosestGameObjectWithEntry(me, OBJECT_UTGARDE_MIRROR, 100.0f))
                    mirror->SetGoState(GO_STATE_READY);

                if(Creature* pArthas = me->SummonCreature(CREATURE_ARTHAS, ArthasPos, TEMPSUMMON_MANUAL_DESPAWN))
                {
                    pArthas->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    uiArthasGUID = pArthas->GetGUID();
                }
            }
        }

        void KilledUnit(Unit* /*pVictim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2, SAY_SLAY_3), me);
        }

        void DamageTaken(Unit* attacker, uint32 &damage)
        {
            if(Phase == SVALADEAD)
            {
                if(attacker != me)
                    damage = 0;
                return;
            }

            if(damage >= me->GetHealth())
            {
                if(Phase == SACRIFICING)
                    SetEquipmentSlots(false, EQUIP_UNEQUIP, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);

                me->GetPosition(x, y, z);
                z = me->GetMap()->GetHeight(x, y, z, true, 50);

                if(me->GetPositionZ() > z)
                {
                    damage = 0;
                    Phase = SVALADEAD;
                    me->InterruptNonMeleeSpells(true);
                    me->RemoveAllAuras();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetHealth(1);

                    SetCombatMovement(false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_FLYDEATH);
                    me->GetMotionMaster()->MoveFall(z, 1);
                }
            }
        }

        void MovementInform(uint32 uiMotionType, uint32 uiPointId)
        {
            if(uiMotionType != POINT_MOTION_TYPE)
                return;

            if(uiPointId == 1)
            {
                me->Relocate(x, y, z, me->GetOrientation());
                me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }
        }

        void JustDied(Unit* /*pKiller*/)
        {
            summons.DespawnAll();

            if(instance)
                instance->SetData(DATA_SVALA_SORROWGRAVE_EVENT, DONE);

            DoScriptText(SAY_DEATH, me);
        }

        void SpellHitTarget(Unit* pTarget, const SpellEntry* pSpell)
        {
            if(pSpell->Id == SPELL_RITUAL_STRIKE_EFF_1 && Phase != NORMAL && Phase != SVALADEAD)
            {
                Phase = NORMAL;
                SetCombatMovement(true);

                if(pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 300, true))
                    me->GetMotionMaster()->MoveChase(pTarget);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(Phase == IDLE)
                return;

            if(Phase == INTRO)
            {
                if(uiIntroTimer <= diff)
                {
                    Creature* pArthas = Unit::GetCreature(*me, uiArthasGUID);
                    if(!pArthas)
                        return;

                    switch (uiIntroPhase)
                    {
                        case 0:
                            DoScriptText(SAY_DIALOG_WITH_ARTHAS_1, me);
                            ++uiIntroPhase;
                            uiIntroTimer = 8100;
                            break;
                        case 1:
                            DoScriptText(SAY_DIALOG_OF_ARTHAS_1, pArthas);
                            ++uiIntroPhase;
                            uiIntroTimer = 10000;
                            break;
                        case 2:
                            pArthas->CastSpell(me, SPELL_TRANSFORMING_CHANNEL, false);
                            me->SetFlying(true);
                            me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                            pos.Relocate(me);
                            pos.m_positionZ += 8.0f;
                            me->GetMotionMaster()->MoveTakeoff(0, pos, 3.30078125f);
                            // spectators flee event
                            if(instance)
                            {
                                std::list<Creature*> lspectatorList;
                                GetCreatureListWithEntryInGrid(lspectatorList, me, CREATURE_SPECTATOR, 100.0f);
                                for(std::list<Creature*>::iterator itr = lspectatorList.begin(); itr != lspectatorList.end(); ++itr)
                                {
                                    if((*itr)->isAlive())
                                    {
                                        (*itr)->SetStandState(UNIT_STAND_STATE_STAND);
                                        (*itr)->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                        (*itr)->GetMotionMaster()->MovePoint(1, spectatorWP[0][0], spectatorWP[0][1], spectatorWP[0][2]);
                                    }
                                }
                            }
                            ++uiIntroPhase;
                            uiIntroTimer = 4200;
                            break;
                        case 3:
                            me->CastSpell(me, SPELL_SVALA_TRANSFORMING1, false);
                            ++uiIntroPhase;
                            uiIntroTimer = 6200;
                            break;
                        case 4:
                            me->CastSpell(me, SPELL_SVALA_TRANSFORMING2, false);
                            pArthas->InterruptNonMeleeSpells(true);
                            me->RemoveAllAuras();
                            me->UpdateEntry(CREATURE_SVALA_SORROWGRAVE);
                            me->SetFacingToObject(pArthas);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            ++uiIntroPhase;
                            uiIntroTimer = 3200;
                            break;
                        case 5:
                            DoScriptText(SAY_DIALOG_WITH_ARTHAS_2, me);
                            ++uiIntroPhase;
                            uiIntroTimer = 10000;
                            break;
                        case 6:
                            DoScriptText(SAY_DIALOG_OF_ARTHAS_2, pArthas);
                            ++uiIntroPhase;
                            uiIntroTimer = 7200;
                            break;
                        case 7:
                            DoScriptText(SAY_DIALOG_WITH_ARTHAS_3, me);
                            me->SetOrientation(1.58f);
                            me->SendMovementFlagUpdate();
                            pArthas->SetVisible(false);
                            ++uiIntroPhase;
                            uiIntroTimer = 13800;
                            break;
                        case 8:
                            me->SetFlying(false);
                            me->RemoveUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                            me->SendMovementFlagUpdate();
                            pos.Relocate(me);
                            pos.m_positionX = me->GetHomePosition().GetPositionX();
                            pos.m_positionY = me->GetHomePosition().GetPositionY();
                            pos.m_positionZ = 90.6065f;
                            me->GetMotionMaster()->MoveLand(0, pos, 6.247422f);
                            ++uiIntroPhase;
                            uiIntroTimer = 3000;
                            break;
                        case 9:
                            if(GameObject *mirror = GetClosestGameObjectWithEntry(me, OBJECT_UTGARDE_MIRROR, 100.0f))
                                mirror->SetGoState(GO_STATE_ACTIVE);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            pArthas->DespawnOrUnsummon();
                            uiArthasGUID = 0;
                            Phase = NORMAL;
                            break;
                    }
                } else uiIntroTimer -= diff;

                return;
            }

            if(Phase == NORMAL)
            {
                //Return since we have no target
                if(!UpdateVictim())
                    return;

                if(me->IsWithinMeleeRange(me->getVictim()) && me->HasUnitMovementFlag(MOVEMENTFLAG_LEVITATING))
                {
                    me->SetFlying(false);
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                    me->SendMovementFlagUpdate();
                }

                if(uiSinsterStrikeTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_SINSTER_STRIKE);
                    uiSinsterStrikeTimer = urand(5 * IN_MILLISECONDS, 9 * IN_MILLISECONDS);
                } else uiSinsterStrikeTimer -= diff;

                if(uiCallFlamesTimer <= diff) //move to send event scripts?
                {
                    if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        if(!bFlames)
                        {
                            DoCast(pTarget, SPELL_CALL_FLAMES);
                            bFlames = true;
                        }

                        if(uiFlamesCount < 3)
                        {
                            if(Creature* pBrazier = Creature::GetCreature(*me, RAND(uiFlameBrazier_1, uiFlameBrazier_2)))
                            {
                                if(IsHeroic())   // find correct spell
                                {
                                    int dmg = 3825 + rand()%1350;
                                    pBrazier->CastCustomSpell(pBrazier, SPELL_BALL_OF_FLAME, &dmg, 0, 0, true);
                                }
                                else
                                    pBrazier->CastSpell(pBrazier, SPELL_BALL_OF_FLAME, true);
                            }
                            uiCallFlamesTimer = 1*IN_MILLISECONDS;
                            ++uiFlamesCount;
                        } else {
                            bFlames = false;
                            uiCallFlamesTimer = urand(8 * IN_MILLISECONDS, 12 * IN_MILLISECONDS);
                            uiFlamesCount = 0;
                        }
                    }
                } else uiCallFlamesTimer -= diff;

                if(!bSacrificed)
                {
                    if(HealthBelowPct(50))
                    {
                        if(Unit* pSacrificeTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 80, true))
                        {
                            if(instance)
                                instance->SetData64(DATA_SACRIFICED_PLAYER, pSacrificeTarget->GetGUID());

                            DoScriptText(RAND(SAY_SACRIFICE_PLAYER_1, SAY_SACRIFICE_PLAYER_2, SAY_SACRIFICE_PLAYER_3,
                                              SAY_SACRIFICE_PLAYER_4, SAY_SACRIFICE_PLAYER_5), me);

                            DoCast(pSacrificeTarget, SPELL_RITUAL_PREPARATION);

                            SetCombatMovement(false);
                            me->SetFlying(true);
                            me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);

                            Phase = SACRIFICING;
                            uiSacrePhase = 0;
                            uiSacrificeTimer = 1 * IN_MILLISECONDS;

                            DoCast(me, SPELL_RITUAL_OF_THE_SWORD);
                            bSacrificed = true;
                        }
                    }
                }

                DoMeleeAttackIfReady();
            }
            else //SACRIFICING
            {
                if(uiSacrificeTimer <= diff)
                {
                    switch (uiSacrePhase)
                    {
                        case 0:
                            // spawn ritual channelers
                            if(instance)
                            {
                                DoCast(me, SPELL_RITUAL_CHANNELER_1, true);
                                DoCast(me, SPELL_RITUAL_CHANNELER_2, true);
                                DoCast(me, SPELL_RITUAL_CHANNELER_3, true);
                            }
                            ++uiSacrePhase;
                            uiSacrificeTimer = 2 * IN_MILLISECONDS;
                            break;
                        case 1:
                            me->StopMoving();
                            me->GetMotionMaster()->MoveIdle();
                            me->InterruptNonMeleeSpells(true);
                            DoCast(me, SPELL_RITUAL_STRIKE_TRIGGER, true);
                            ++uiSacrePhase;
                            uiSacrificeTimer = 200;
                            break;
                        case 2:
                            DoCast(me, SPELL_RITUAL_DISARM);
                            ++uiSacrePhase;
                            break;
                        case 3:
                            break;
                    }
                } else uiSacrificeTimer -= diff;
            }
        }
    };

};

class npc_ritual_channeler : public CreatureScript
{
public:
    npc_ritual_channeler() : CreatureScript("npc_ritual_channeler") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ritual_channelerAI(creature);
    }

    struct npc_ritual_channelerAI : public Scripted_NoMovementAI
    {
        npc_ritual_channelerAI(Creature* c) :Scripted_NoMovementAI(c)
        {
            instance = c->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 uiParalyzeTimer;

        void Reset()
        {
            uiParalyzeTimer = 1600;
            if(instance)
                if(IsHeroic())
                    DoCast(me, SPELL_SHADOWS_IN_THE_DARK);
        }

        void UpdateAI(const uint32 diff)
        {
            if(me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if(uiParalyzeTimer <= diff)
            {
                if(instance)
                    if(Unit* victim = me->GetUnit(*me, instance->GetData64(DATA_SACRIFICED_PLAYER)))
                        DoCast(victim, SPELL_PARALYZE, false);

                uiParalyzeTimer = 200;
            }
            else
                uiParalyzeTimer -= diff;
        }
    };
};

class npc_spectator : public CreatureScript
{
public:
    npc_spectator() : CreatureScript("npc_spectator") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_spectatorAI(creature);
    }

    struct npc_spectatorAI : public ScriptedAI
    {
        npc_spectatorAI(Creature* c) : ScriptedAI(c) { }

        void Reset() { }

        void MovementInform(uint32 uiMotionType, uint32 uiPointId)
        {
            if(uiMotionType == POINT_MOTION_TYPE)
            {
                if(uiPointId == 1)
                    me->GetMotionMaster()->MovePoint(2,spectatorWP[1][0],spectatorWP[1][1],spectatorWP[1][2]);
                else if(uiPointId == 2)
                    me->DespawnOrUnsummon(1000);
            }
        }
    };
};

class checkRitualTarget
{
public:
    explicit checkRitualTarget(Unit* _caster) : caster(_caster) { }

    bool operator() (Unit* unit)
    {
        if(InstanceScript* instance = caster->GetInstanceScript())
            if(instance->GetData64(DATA_SACRIFICED_PLAYER) == unit->GetGUID())
                return false;

        return true;
    }

private:
    Unit* caster;
};

class npc_scourge_hulk : public CreatureScript
{
public:
    npc_scourge_hulk() : CreatureScript("npc_scourge_hulk") { }

    struct npc_scourge_hulkAI : public ScriptedAI
    {
        npc_scourge_hulkAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiMightyBlow;
        uint32 uiVolatileInfection;

        void Reset()
        {
            uiMightyBlow = urand(4000, 9000);
            uiVolatileInfection = urand(10000, 14000);
            killedByRitualStrike = false;
        }

        uint32 GetData(uint32 type)
        {
            return type == DATA_INCREDIBLE_HULK ? killedByRitualStrike : 0;
        }

        void DamageTaken(Unit* attacker, uint32 &damage)
        {
            if(damage >= me->GetHealth() && attacker->GetEntry() == CREATURE_SVALA_SORROWGRAVE)
                killedByRitualStrike = true;
        }

        void UpdateAI(uint32 const Diff)
        {
            if(!UpdateVictim())
                return;

            if(uiMightyBlow <= Diff)
            {
                if(Unit* victim = me->getVictim())
                    if(!victim->HasUnitState(UNIT_STAT_STUNNED)) // Prevent knocking back a ritual player
                        DoCast(victim, SPELL_MIGHTY_BLOW);
                uiMightyBlow = urand(12000, 17000);
            }
            else
                uiMightyBlow -= Diff;

            if(uiVolatileInfection <= Diff)
            {
                DoCastVictim(SPELL_VOLATILE_INFECTION);
                uiVolatileInfection = urand(13000, 17000);
            }
            else
                uiVolatileInfection -= Diff;

            DoMeleeAttackIfReady();
        }

    private:
        bool killedByRitualStrike;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_scourge_hulkAI(creature);
    }
};

class achievement_incredible_hulk : public AchievementCriteriaScript
{
public:
    achievement_incredible_hulk() : AchievementCriteriaScript("achievement_incredible_hulk") { }

    bool OnCheck(Player* /*pPlayer*/, Unit* target)
    {
        return target && target->IsAIEnabled && target->GetAI()->GetData(DATA_INCREDIBLE_HULK);
    }
};

void AddSC_boss_svala()
{
    new boss_svala;
    new npc_ritual_channeler;
    new npc_spectator;
    new npc_scourge_hulk;
    new achievement_incredible_hulk;
}
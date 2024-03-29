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
#include "utgarde_keep.h"

enum Yells
{
    //Yells Ingvar
    YELL_AGGRO_1                                = -1574005,
    YELL_AGGRO_2                                = -1574006,

    YELL_DEAD_1                                 = -1574007,
    YELL_DEAD_2                                 = -1574008,

    YELL_KILL_1                                 = -1574009,
    YELL_KILL_2                                 = -1574010,
};

enum Creatures
{
    MOB_INGVAR_HUMAN                            = 23954,
    MOB_ANNHYLDE_THE_CALLER                     = 24068,
    MOB_INGVAR_UNDEAD                           = 23980,
    MOB_SMASH_TARGET                            = 89,
    DISPLAY_INVISIBLE                           = 11686
};

enum Spells
{
    //Ingvar Spells human form
    SPELL_CLEAVE                                = 42724,
    SPELL_SMASH                                 = 42669,
    H_SPELL_SMASH                               = 59706,
    SPELL_STAGGERING_ROAR                       = 42708,
    H_SPELL_STAGGERING_ROAR                     = 59708,
    SPELL_ENRAGE                                = 42705,
    H_SPELL_ENRAGE                              = 59707,

    SPELL_INGVAR_FEIGN_DEATH                    = 42795,
    SPELL_SUMMON_BANSHEE                        = 42912,
    SPELL_SCOURG_RESURRECTION                   = 42863, // Spawn resurrect effect around Ingvar

    //Ingvar Spells undead form
    SPELL_DARK_SMASH                            = 42723,
    H_SPELL_DARK_SMASH                          = 59709,
    SPELL_DREADFUL_ROAR                         = 42729,
    H_SPELL_DREADFUL_ROAR                       = 59734,
    SPELL_WOE_STRIKE                            = 42730,
    H_SPELL_WOE_STRIKE                          = 59735,

    ENTRY_THROW_TARGET                          = 23996,
    SPELL_SHADOW_AXE_SUMMON                     = 42749
};

class boss_ingvar_the_plunderer : public CreatureScript
{
public:
    boss_ingvar_the_plunderer() : CreatureScript("boss_ingvar_the_plunderer") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ingvar_the_plundererAI(pCreature);
    }

    struct boss_ingvar_the_plundererAI : public ScriptedAI
    {
        boss_ingvar_the_plundererAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        bool bIsUndead;
        bool bEventInProgress;

        uint32 uiCleaveTimer;
        uint32 uiSmashTimer;
        uint32 uiEnrageTimer;
        uint32 uiRoarTimer;
        uint32 uiSpawnResTimer;

        void Reset()
        {
            if(bIsUndead)
                me->UpdateEntry(MOB_INGVAR_HUMAN);

            bIsUndead = false;
            bEventInProgress = false;

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
            me->SetStandState(UNIT_STAND_STATE_STAND);

            uiCleaveTimer = 2000;
            uiSmashTimer = 5000;
            uiEnrageTimer = 10000;
            uiRoarTimer = 15000;

            uiSpawnResTimer = 3000;

            if(pInstance)
                pInstance->SetData(DATA_INGVAR_EVENT, NOT_STARTED);
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage)
        {
            if(damage >= me->GetHealth() && !bIsUndead)
            {
                //DoCast(me, SPELL_INGVAR_FEIGN_DEATH, true);  // Dont work ???
                // visuel hack
                me->SetHealth(0);
                me->InterruptNonMeleeSpells(true);
                me->RemoveAllAuras();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
                me->GetMotionMaster()->MovementExpired(false);
                me->GetMotionMaster()->MoveIdle();
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                // visuel hack end

                bEventInProgress = true;
                bIsUndead = true;

                DoScriptText(YELL_DEAD_1,me);
            }

            if(bEventInProgress)
            {
                damage = 0;
            }
        }

        void StartZombiePhase()
        {
            bIsUndead = true;
            bEventInProgress = false;
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
            me->UpdateEntry(MOB_INGVAR_UNDEAD);
            me->SetInCombatWith(me->getVictim());
            me->GetMotionMaster()->MoveChase(me->getVictim());

            DoScriptText(YELL_AGGRO_2,me);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(YELL_AGGRO_1,me);

            if(pInstance)
                pInstance->SetData(DATA_INGVAR_EVENT, IN_PROGRESS);
        }

        void JustDied(Unit* /*pKiller*/)
        {
            DoScriptText(YELL_DEAD_2,me);

            if(pInstance)
                pInstance->SetData(DATA_INGVAR_EVENT, DONE);
        }

        void KilledUnit(Unit* /*pVictim*/)
        {
            if(bIsUndead)
                DoScriptText(YELL_KILL_1,me);
            else
                DoScriptText(YELL_KILL_2,me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(bEventInProgress)
            {
                if(uiSpawnResTimer)
                {
                    if(uiSpawnResTimer <= diff)
                    {
                        DoCast(me, SPELL_SUMMON_BANSHEE); // Summons directly on caster position
                        // DoCast(me, SPELL_SCOURG_RESURRECTION, true); // Not needed ?
                        uiSpawnResTimer = 0;
                    } else uiSpawnResTimer -= diff;
                }

                return;
            }

            if(uiCleaveTimer <= diff)
            {
                if(!me->HasUnitState(UNIT_STAT_CASTING))
                {
                    if(bIsUndead)
                    DoCast(me->getVictim(), DUNGEON_MODE(SPELL_WOE_STRIKE,H_SPELL_WOE_STRIKE));
                    else
                        DoCast(me->getVictim(), SPELL_CLEAVE);
                    uiCleaveTimer = rand()%5000 + 2000;
                }
            } else uiCleaveTimer -= diff;

            if(uiSmashTimer <= diff)
            {
                if(!me->HasUnitState(UNIT_STAT_CASTING))
                {
                    float x, y, z;
                    z = me->GetPositionZ();
                    me->GetNearPoint2D(x, y, 0.0f, me->GetOrientation());

                    if(Creature* pTempTarget = me->SummonCreature(MOB_SMASH_TARGET, x, y, z, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 3100))
                    {
                        me->SetFacingToObject(pTempTarget);
                        pTempTarget->SetReactState(REACT_PASSIVE);
                        pTempTarget->SetDisplayId(DISPLAY_INVISIBLE);
                        pTempTarget->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE|UNIT_FLAG_NON_ATTACKABLE |UNIT_FLAG_NOT_SELECTABLE);
                        me->CastSpell(pTempTarget, bIsUndead ? SPELL_DARK_SMASH : DUNGEON_MODE(SPELL_SMASH,H_SPELL_SMASH), false);
                    }
                    uiSmashTimer = 10000;
                }
            } else uiSmashTimer -= diff;

            if(!bIsUndead)
            {
                if(uiEnrageTimer <= diff)
                {
                DoCast(me, DUNGEON_MODE(SPELL_ENRAGE,H_SPELL_ENRAGE));
                    uiEnrageTimer = 10000;
                } else uiEnrageTimer -= diff;
            } else // In Undead form used to summon weapon
            {
                if(uiEnrageTimer <= diff)
                {
                    if(!me->HasUnitState(UNIT_STAT_CASTING))
                    {
                        // Spawn target for Axe
                        Unit* pTarget = SelectTarget(SELECT_TARGET_TOPAGGRO, 1);
                        if(pTarget)
                        {
                            me->SummonCreature(ENTRY_THROW_TARGET,pTarget->GetPositionX(),pTarget->GetPositionY(),pTarget->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,2000);

                            DoCast(me, SPELL_SHADOW_AXE_SUMMON);
                        }
                        uiEnrageTimer = 30000;
                    }
                } else uiEnrageTimer -= diff;
            }

            if(uiRoarTimer <= diff)
            {
                if(!me->HasUnitState(UNIT_STAT_CASTING))
                {
                    if(bIsUndead)
                        DoCast(me, DUNGEON_MODE(SPELL_DREADFUL_ROAR,H_SPELL_DREADFUL_ROAR));
                    else
                        DoCast(me, DUNGEON_MODE(SPELL_STAGGERING_ROAR,H_SPELL_STAGGERING_ROAR));
                    uiRoarTimer = 10000;
                }
            } else uiRoarTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

enum eSpells
{
//we don't have that text in db so comment it until we get this text
//    YELL_RESSURECT                      = -1574025,

//Spells for Annhylde
    SPELL_SCOURG_RESURRECTION_HEAL              = 42704, //Heal Max + DummyAura
    SPELL_SCOURG_RESURRECTION_BEAM              = 42857, //Channeling Beam of Annhylde
    SPELL_SCOURG_RESURRECTION_DUMMY             = 42862, //Some Emote Dummy?
    SPELL_INGVAR_TRANSFORM                      = 42796
};

class mob_annhylde_the_caller : public CreatureScript
{
public:
    mob_annhylde_the_caller() : CreatureScript("mob_annhylde_the_caller") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_annhylde_the_callerAI (pCreature);
    }

    struct mob_annhylde_the_callerAI : public ScriptedAI
    {
        mob_annhylde_the_callerAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        float x,y,z;
        InstanceScript* pInstance;
        uint32 uiResurectTimer;
        uint32 uiResurectPhase;

        void Reset()
        {
            me->AddUnitMovementFlag(MOVEMENTFLAG_FLYING | MOVEMENTFLAG_HOVER);
            me->SetSpeed(MOVE_SWIM, 1.0f);
            me->SetSpeed(MOVE_RUN, 1.0f);
            me->SetSpeed(MOVE_WALK, 1.0f);
            //me->SetSpeed(MOVE_FLIGHT, 1.0f);

            me->GetPosition(x,y,z);
            DoTeleportTo(x+1,y,z+30);

            Unit* ingvar = Unit::GetUnit(*me, pInstance ? pInstance->GetData64(DATA_INGVAR) : 0);
            if(ingvar)
            {
                me->GetMotionMaster()->MovePoint(1,x,y,z+15);
    //            DoScriptText(YELL_RESSURECT,me);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if(type != POINT_MOTION_TYPE)
                return;
            Unit* ingvar = Unit::GetUnit((*me), pInstance ? pInstance->GetData64(DATA_INGVAR) : 0);
            if(ingvar)
            {
                switch(id)
                {
                case 1:
                    ingvar->RemoveAura(SPELL_SUMMON_BANSHEE);
                    ingvar->CastSpell(ingvar,SPELL_SCOURG_RESURRECTION_DUMMY, true);
                    DoCast(ingvar, SPELL_SCOURG_RESURRECTION_BEAM);
                    uiResurectTimer = 8000;
                    uiResurectPhase = 1;
                    break;
                case 2:
                    me->SetVisible(false);
                    me->DealDamage(me,me->GetHealth());
                    me->RemoveCorpse();
                    break;
                }
            }
        }

        void AttackStart(Unit* /*pWho*/) { }
        void MoveInLineOfSight(Unit* /*pWho*/) { }
        void EnterCombat(Unit* /*pWho*/) { }

        void UpdateAI(const uint32 diff)
        {
            if(uiResurectTimer)
            {
                if(uiResurectTimer <= diff)
                {
                    if(uiResurectPhase == 1)
                    {
                        Unit* ingvar = Unit::GetUnit(*me, pInstance ? pInstance->GetData64(DATA_INGVAR) : 0);
                        if(ingvar)
                        {
                            ingvar->SetStandState(UNIT_STAND_STATE_STAND);
                            ingvar->CastSpell(ingvar,SPELL_SCOURG_RESURRECTION_HEAL,false);
                        }
                        uiResurectTimer = 3000;
                        uiResurectPhase = 2;
                    }
                    else if(uiResurectPhase == 2)
                    {
                        if(Creature* ingvar = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_INGVAR) : 0))
                        {
                            ingvar->RemoveAurasDueToSpell(SPELL_SCOURG_RESURRECTION_DUMMY);

                            if(boss_ingvar_the_plunderer::boss_ingvar_the_plundererAI* pAI = CAST_AI(boss_ingvar_the_plunderer::boss_ingvar_the_plundererAI, ingvar->AI()))
                                pAI->StartZombiePhase();

                            me->GetMotionMaster()->MovePoint(2,x+1,y,z+30);
                            ++uiResurectPhase;
                            uiResurectTimer = 0;
                        }
                    }
                } else uiResurectTimer -= diff;
            }
        }
    };
};

enum eShadowAxe
{
    SPELL_SHADOW_AXE_DAMAGE                     = 42750,
    H_SPELL_SHADOW_AXE_DAMAGE                   = 59719
};

class mob_ingvar_throw_dummy : public CreatureScript
{
public:
    mob_ingvar_throw_dummy() : CreatureScript("mob_ingvar_throw_dummy") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_ingvar_throw_dummyAI (pCreature);
    }

    struct mob_ingvar_throw_dummyAI : public ScriptedAI
    {
        mob_ingvar_throw_dummyAI(Creature* c) : ScriptedAI(c) { }

        uint32 uiDespawnTimer;

        void Reset()
        {
            Unit* pTarget = me->FindNearestCreature(ENTRY_THROW_TARGET,50);
            if(pTarget)
            {
                DoCast(me, DUNGEON_MODE(SPELL_SHADOW_AXE_DAMAGE,H_SPELL_SHADOW_AXE_DAMAGE));
                float x,y,z;
                pTarget->GetPosition(x,y,z);
                me->GetMotionMaster()->MovePoint(0,x,y,z);
            }
            uiDespawnTimer = 7000;
        }

        void AttackStart(Unit* /*pWho*/) { }
        void MoveInLineOfSight(Unit* /*pWho*/) { }
        void EnterCombat(Unit* /*pWho*/) { }

        void UpdateAI(const uint32 diff)
        {
            if(uiDespawnTimer <= diff)
            {
                me->DealDamage(me,me->GetHealth());
                me->RemoveCorpse();
                uiDespawnTimer = 0;
            } else uiDespawnTimer -= diff;
        }
    };
};

void AddSC_boss_ingvar_the_plunderer()
{
    new boss_ingvar_the_plunderer;
    new mob_annhylde_the_caller;
    new mob_ingvar_throw_dummy;
}

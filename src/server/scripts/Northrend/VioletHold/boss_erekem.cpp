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
#include "violet_hold.h"

enum Spells
{
    SPELL_BLOODLUST                             = 54516,
    SPELL_BREAK_BONDS                           = 59463,
    SPELL_CHAIN_HEAL                            = 54481,
    H_SPELL_CHAIN_HEAL                          = 59473,
    SPELL_EARTH_SHIELD                          = 54479,
    H_SPELL_EARTH_SHIELD                        = 59471,
    SPELL_EARTH_SHOCK                           = 54511,
    SPELL_LIGHTNING_BOLT                        = 53044,
    SPELL_STORMSTRIKE                           = 51876
};

enum Yells
{
    SAY_AGGRO                                   = -1608010,
    SAY_SLAY_1                                  = -1608011,
    SAY_SLAY_2                                  = -1608012,
    SAY_SLAY_3                                  = -1608013,
    SAY_DEATH                                   = -1608014,
    SAY_SPAWN                                   = -1608015,
    SAY_ADD_KILLED                              = -1608016,
    SAY_BOTH_ADDS_KILLED                        = -1608017
};

class boss_erekem : public CreatureScript
{
public:
    boss_erekem() : CreatureScript("boss_erekem") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_erekemAI (pCreature);
    }

    struct boss_erekemAI : public ScriptedAI
    {
        boss_erekemAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        uint32 uiBloodlustTimer;
        uint32 uiChainHealTimer;
        uint32 uiEarthShockTimer;
        uint32 uiLightningBoltTimer;
        uint32 uiEarthShieldTimer;
        uint32 uiBreakBoundsTimer;

        InstanceScript* pInstance;

        void Reset()
        {
            uiBloodlustTimer = 15000;
            uiChainHealTimer = 0;
            uiEarthShockTimer = urand(2000,8000);
            uiLightningBoltTimer = urand(5000,10000);
            uiEarthShieldTimer = 20000;
            uiBreakBoundsTimer = urand(10000, 20000);

            if(pInstance)
            {
                if(pInstance->GetData(DATA_WAVE_COUNT) == 6)
                    pInstance->SetData(DATA_1ST_BOSS_EVENT, NOT_STARTED);
                else if(pInstance->GetData(DATA_WAVE_COUNT) == 12)
                    pInstance->SetData(DATA_2ND_BOSS_EVENT, NOT_STARTED);
            }

            if(Creature* pGuard1 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_1) : 0))
            {
                if(!pGuard1->isAlive())
                    pGuard1->Respawn();
            }
            if(Creature* pGuard2 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_2) : 0))
            {
                if(!pGuard2->isAlive())
                    pGuard2->Respawn();
            }
        }

        void AttackStart(Unit* pWho)
        {
            if(me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            if(me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 0.0f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);
                DoStartMovement(pWho);

                if(Creature* pGuard1 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_1) : 0))
                {
                    pGuard1->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_NON_ATTACKABLE);
                    if(!pGuard1->getVictim() && pGuard1->AI())
                        pGuard1->AI()->AttackStart(pWho);
                }
                if(Creature* pGuard2 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_2) : 0))
                {
                    pGuard2->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_NON_ATTACKABLE);
                    if(!pGuard2->getVictim() && pGuard2->AI())
                        pGuard2->AI()->AttackStart(pWho);
                }
            }
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(SAY_AGGRO, me);
            DoCast(me, SPELL_EARTH_SHIELD);

            if(pInstance)
            {
                if(GameObject* pDoor = pInstance->instance->GetGameObject(pInstance->GetData64(DATA_EREKEM_CELL)))
                    if(pDoor->GetGoState() == GO_STATE_READY)
                    {
                        EnterEvadeMode();
                        return;
                    }

                if(pInstance->GetData(DATA_WAVE_COUNT) == 6)
                    pInstance->SetData(DATA_1ST_BOSS_EVENT, IN_PROGRESS);
                else if(pInstance->GetData(DATA_WAVE_COUNT) == 12)
                    pInstance->SetData(DATA_2ND_BOSS_EVENT, IN_PROGRESS);
            }
        }

        void MoveInLineOfSight(Unit* /*pWho*/) { }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if(!UpdateVictim())
                return;

            //spam stormstrike in hc mode if spawns are dead
            if(IsHeroic())
            {
                if(Creature* pGuard1 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_1) : 0))
                {
                    if(Creature* pGuard2 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_2) : 0))
                    {
                        if(!pGuard1->isAlive() && !pGuard2->isAlive())
                            DoCast(me->getVictim(), SPELL_STORMSTRIKE);
                    }
                }
            }

            if(uiEarthShieldTimer <= diff)
            {
                DoCast(me, DUNGEON_MODE(SPELL_EARTH_SHIELD,H_SPELL_EARTH_SHIELD));
                uiEarthShieldTimer = 20000;
            } else uiEarthShieldTimer -= diff;

            if(uiChainHealTimer <= diff)
            {
                if(uint64 TargetGUID = GetChainHealTargetGUID())
                {
                    if(Creature* pTarget = Unit::GetCreature(*me, TargetGUID))
                        DoCast(pTarget, DUNGEON_MODE(SPELL_CHAIN_HEAL,H_SPELL_CHAIN_HEAL));

                    //If one of the adds is dead spawn heals faster
                    Creature* pGuard1 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_1) : 0);
                    Creature* pGuard2 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_2) : 0);
                    uiChainHealTimer = ((pGuard1 && !pGuard1->isAlive()) || (pGuard2 && !pGuard2->isAlive()) ? 3000 : 8000) + rand()%3000+6000;
                }
            } else uiChainHealTimer -= diff;

            if(uiBloodlustTimer <= diff)
            {
                DoCast(me, SPELL_BLOODLUST);
                uiBloodlustTimer = urand(35000, 45000);
            } else uiBloodlustTimer -= diff;

            if(uiEarthShockTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_EARTH_SHOCK);
                uiEarthShockTimer = urand(8000, 13000);
            } else uiEarthShockTimer -= diff;

            if(uiLightningBoltTimer <= diff)
            {
                if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(pTarget, SPELL_LIGHTNING_BOLT);
                uiLightningBoltTimer = urand(18000, 24000);
            } else uiLightningBoltTimer -= diff;

            if(uiBreakBoundsTimer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(me, SPELL_BREAK_BONDS);
                    uiBreakBoundsTimer = urand(10000,20000);
                }
            } else uiBreakBoundsTimer -= diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            DoScriptText(SAY_DEATH, me);

            if(pInstance)
            {
                if(pInstance->GetData(DATA_WAVE_COUNT) == 6)
                {
                    if(IsHeroic() && pInstance->GetData(DATA_1ST_BOSS_EVENT) == DONE)
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

                    pInstance->SetData(DATA_1ST_BOSS_EVENT, DONE);
                    pInstance->SetData(DATA_WAVE_COUNT, 7);
                }
                else if(pInstance->GetData(DATA_WAVE_COUNT) == 12)
                {
                    if(IsHeroic() && pInstance->GetData(DATA_2ND_BOSS_EVENT) == DONE)
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

                    pInstance->SetData(DATA_2ND_BOSS_EVENT, DONE);
                    pInstance->SetData(DATA_WAVE_COUNT, 13);
                }
            }
        }

        void KilledUnit(Unit* victim)
        {
            if(victim == me)
                return;
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        uint64 GetChainHealTargetGUID()
        {
            if(HealthBelowPct(85))
                return me->GetGUID();

            Creature* pGuard1 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_1) : 0);
            if(pGuard1 && pGuard1->isAlive() && !pGuard1->HealthAbovePct(75))
                return pGuard1->GetGUID();

            Creature* pGuard2 = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_EREKEM_GUARD_2) : 0);
            if(pGuard2 && pGuard2->isAlive() && !pGuard2->HealthAbovePct(75))
                return pGuard2->GetGUID();

            return 0;
        }
    };
};

enum GuardSpells
{
    SPELL_GUSHING_WOUND                   = 39215,
    SPELL_HOWLING_SCREECH                 = 54462,
    SPELL_STRIKE                          = 14516
};

class mob_erekem_guard : public CreatureScript
{
public:
    mob_erekem_guard() : CreatureScript("mob_erekem_guard") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_erekem_guardAI (pCreature);
    }

    struct mob_erekem_guardAI : public ScriptedAI
    {
        mob_erekem_guardAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        uint32 uiGushingWoundTimer;
        uint32 uiHowlingScreechTimer;
        uint32 uiStrikeTimer;

        InstanceScript* pInstance;

        void Reset()
        {
            uiStrikeTimer = urand(4000,8000);
            uiHowlingScreechTimer = urand(8000,13000);
            uiGushingWoundTimer = urand(1000,3000);
        }

        void AttackStart(Unit* pWho)
        {
            if(me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            if(me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 0.0f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);
                DoStartMovement(pWho);
            }
        }

        void MoveInLineOfSight(Unit* /*pWho*/) { }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            DoMeleeAttackIfReady();

            if(uiStrikeTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_STRIKE);
                uiStrikeTimer = urand(4000,8000);
            } else uiStrikeTimer -= diff;

            if(uiHowlingScreechTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_HOWLING_SCREECH);
                uiHowlingScreechTimer = urand(8000,13000);
            } else uiHowlingScreechTimer -= diff;

            if(uiGushingWoundTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_GUSHING_WOUND);
                uiGushingWoundTimer = urand(7000,12000);
            } else uiGushingWoundTimer -= diff;
        }
    };
};

void AddSC_boss_erekem()
{
    new boss_erekem;
    new mob_erekem_guard;
}

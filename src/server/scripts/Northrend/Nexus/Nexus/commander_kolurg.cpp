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
#include "nexus.h"

enum eKolurg
{
    //Spells
    SPELL_BATTLE_SHOUT                           = 31403,
    SPELL_CHARGE                                 = 60067,
    SPELL_FRIGHTENING_SHOUT                      = 19134,
    SPELL_WHIRLWIND                              = 38619,
    SPELL_WHIRLWIND_ADD                          = 38618,
    SPELL_FROZEN_PRISON                          = 47543, //Frozen block around them - on creature create and leave combat

    //Yells
    SAY_AGGRO                                    = -1576024,
    SAY_KILL                                     = -1576025,
    SAY_DEATH                                    = -1576026,

    //Add Spells
    //Horde Cleric
    SPELL_POWER_WORD_SHIELD                      = 35944,
    SPELL_SHADOW_WORD_DEATH                      = 56920, //47697,
    SPELL_FLASH_HEAL                             = 17843,

    //Horde Ranger
    SPELL_INCENDIARY_SHOT                        = 47777,
    SPELL_RAPID_SHOT                             = 48191,
    SPELL_SHOOT                                  = 15620,

    //Horde Berserker
    SPELL_BLOODLUST                              = 21049,
    SPELL_FRENZY                                 = 47774,
    SPELL_WAR_STOMP                              = 38682,
};

class boss_commander_kolurg : public CreatureScript
{
public:
    boss_commander_kolurg() : CreatureScript("boss_commander_kolurg") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_commander_kolurgAI (creature);
    }

    struct boss_commander_kolurgAI : public BossAI
    {
        boss_commander_kolurgAI(Creature* pCreature) : BossAI(pCreature, DATA_COMMANDER)
        {
            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        uint32 uiBattleShout_Timer;
        uint32 uiCharge_Timer;
        uint32 uiFrighteningShout_Timer;
        uint32 uiWhirlwind_Timer;
        uint32 uiWhirlwindAdd_Timer;

        bool IsWhirlwindTime;

        void Reset()
        {
            uiBattleShout_Timer = urand(200000,215000);
            uiCharge_Timer = urand(15000,17500);
            uiFrighteningShout_Timer = urand(10000,12500);
            uiWhirlwind_Timer = 10000;
            uiWhirlwindAdd_Timer = 10500;

            IsWhirlwindTime = false;

            me->CastSpell(me, SPELL_FROZEN_PRISON, true);

            if(instance)
                instance->SetData(DATA_COMMANDER, NOT_STARTED);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(SAY_AGGRO, me);
            DoCast(me, SPELL_BATTLE_SHOUT);

            me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);

            if(instance)
                instance->SetData(DATA_COMMANDER, IN_PROGRESS);
        }

        void KilledUnit(Unit* /*pWho*/)
        {
            DoScriptText(SAY_KILL, me);
        }

        void JustDied(Unit* /*pKiller*/)
        {
            DoScriptText(SAY_DEATH, me);

            if(instance)
                instance->SetData(DATA_COMMANDER, DONE);
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if(!UpdateVictim())
                return;

            if(uiCharge_Timer <= diff)
            {
                if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(pTarget, SPELL_CHARGE);
                uiCharge_Timer = urand(10500,12000);
            } else uiCharge_Timer -= diff;

            if(uiBattleShout_Timer <= diff)
            {
                DoCastAOE(SPELL_BATTLE_SHOUT);
                uiBattleShout_Timer = 200000;
            } else uiBattleShout_Timer -= diff;

            if(uiFrighteningShout_Timer <= diff)
            {
                DoCastAOE(SPELL_FRIGHTENING_SHOUT);
                uiFrighteningShout_Timer = urand(8000,10000);
            } else uiFrighteningShout_Timer -= diff;

            if(uiWhirlwind_Timer <= diff && !IsWhirlwindTime)
            {
                DoCastAOE(SPELL_WHIRLWIND);
                uiWhirlwindAdd_Timer = 500;
                IsWhirlwindTime = true;
            } else uiWhirlwind_Timer -= diff;

            if(uiWhirlwindAdd_Timer <= diff && IsWhirlwindTime)
            {
                DoCastAOE(SPELL_WHIRLWIND_ADD);
                uiWhirlwind_Timer = urand(10000,12500);
                IsWhirlwindTime = false;
            } else uiWhirlwindAdd_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_horde_cleric : public CreatureScript
{
public:
    mob_horde_cleric() : CreatureScript("mob_horde_cleric") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_horde_clericAI (pCreature);
    }

    struct mob_horde_clericAI : public ScriptedAI
    {
        mob_horde_clericAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        uint32 uiFlashHeal_Timer;
        uint32 uiShadowWordDeath_Timer;
        uint32 uiPowerWordShield_Timer;

        void Reset()
        {
            uiFlashHeal_Timer = urand(9000,10500);
            uiShadowWordDeath_Timer = urand(5500,8500);
            uiPowerWordShield_Timer = urand(2000,4000);

            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(Unit* pTarget = DoSelectLowestHpFriendly(40.0f))
            {
                if(uiFlashHeal_Timer <= diff)
                {
                    DoCast(pTarget, SPELL_FLASH_HEAL);
                    uiFlashHeal_Timer = urand(7000,8000);
                } else uiFlashHeal_Timer -= diff;

                if(uiPowerWordShield_Timer <= diff)
                {
                    DoCast(pTarget, SPELL_POWER_WORD_SHIELD);
                    uiPowerWordShield_Timer = urand(9000,10000);
                } else uiPowerWordShield_Timer -= diff;
            }

            if(uiShadowWordDeath_Timer <= diff)
            {
                if(Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1))
                    DoCast(pTarget, SPELL_SHADOW_WORD_DEATH);
                uiShadowWordDeath_Timer = urand(4500,5500);
            } else uiShadowWordDeath_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_horde_ranger : public CreatureScript
{
public:
    mob_horde_ranger() : CreatureScript("mob_horde_ranger") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_horde_rangerAI (pCreature);
    }

    struct mob_horde_rangerAI : public ScriptedAI
    {
        mob_horde_rangerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        uint32 uiRapidShot_Timer;
        uint32 uiIncendiaryShot_Timer;
        uint32 uiShoot_Timer;

        uint8 i;

        void Reset()
        {
            uiRapidShot_Timer = urand(12500,14000);
            uiIncendiaryShot_Timer = urand(6500,8000);
            uiShoot_Timer = urand(2500,3000);

            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
        }

        Unit* FindTarget()
        {
            i = 0;
            Unit* pTarget;

            while(i < 5)
            {
                pTarget = SelectTarget(SELECT_TARGET_TOPAGGRO, i);
                i++;

                if(!me->IsWithinDistInMap(pTarget, 5.0f))
                    return pTarget;
            }
            return 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
            return;

            if(uiIncendiaryShot_Timer <= diff)
            {
                if(Unit* pTarget = FindTarget())
                    DoCast(pTarget, SPELL_INCENDIARY_SHOT);
                uiIncendiaryShot_Timer = urand(6500,7500);
            } else uiIncendiaryShot_Timer -= diff;

            if(uiShoot_Timer <= diff)
            {
                if(Unit* pTarget = FindTarget())
                    DoCast(pTarget, SPELL_SHOOT);
                uiShoot_Timer = urand(2500,3000);
            } else uiShoot_Timer -= diff;

            if(uiRapidShot_Timer <= diff)
            {
                DoCastAOE(SPELL_RAPID_SHOT);
                uiRapidShot_Timer = urand(12500,14000);
            } else uiRapidShot_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_horde_berserker : public CreatureScript
{
public:
    mob_horde_berserker() : CreatureScript("mob_horde_berserker") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_horde_berserkerAI (pCreature);
    }

    struct mob_horde_berserkerAI : public ScriptedAI
    {
        mob_horde_berserkerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        uint32 uiBloodlust_Timer;
        uint32 uiFrenzy_Timer;
        uint32 uiWarStomp_Timer;

        void Reset()
        {
            uiBloodlust_Timer   = urand(5000, 7500);
            uiFrenzy_Timer      = urand(2500, 4000);
            uiWarStomp_Timer    = urand(6000, 8000);

            me->CastSpell(me, SPELL_FROZEN_PRISON, true);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
        }

        Creature* SelectRandomFriendlyMissingBuff(uint32 spell)
        {
            std::list<Creature* > lst = DoFindFriendlyMissingBuff(40.0f, spell);
            std::list<Creature* >::const_iterator itr = lst.begin();
            if(lst.empty())
                return NULL;
            advance(itr, rand()%lst.size());
            return (*itr);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
            return;

            if(uiBloodlust_Timer <= diff)
            {
                if(Creature* pTarget = SelectRandomFriendlyMissingBuff(SPELL_BLOODLUST)) //He should casts this only on allies, not on self...
                    DoCast(pTarget, SPELL_BLOODLUST);
                uiBloodlust_Timer = urand(12000,15000);
            } else uiBloodlust_Timer -= diff;

            if(uiFrenzy_Timer <= diff)
            {
                DoCast(me, SPELL_FRENZY);
                uiFrenzy_Timer = 200000;
            } else uiFrenzy_Timer -= diff;

            if(uiWarStomp_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_WAR_STOMP);
                uiWarStomp_Timer = urand(7000,8500);
            } else uiWarStomp_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_commander_kolurg()
{
    new boss_commander_kolurg;
    new mob_horde_cleric;
    new mob_horde_ranger;
    new mob_horde_berserker;
}
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
#include "ScriptedEscortAI.h"

enum eEnums
{
    QUEST_RETURN_TO_AG_A    = 12499,
    QUEST_RETURN_TO_AG_H    = 12500,
    MOVIE_ID_GATES          = 14
};

#define GOSSIP_ITEM_WHAT_HAPPENED   "Alexstrasza, can you show me what happened here?"

class npc_alexstrasza_wr_gate : public CreatureScript
{
public:
    npc_alexstrasza_wr_gate() : CreatureScript("npc_alexstrasza_wr_gate") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if(player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_A) || player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_H))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WHAT_HAPPENED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if(uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

#define QUEST  12277
#define SPELL  48742

class npc_wintergarde_mine_bomb : public CreatureScript
{
public:
    npc_wintergarde_mine_bomb() : CreatureScript("npc_wintergarde_mine_bomb") { }

    struct npc_wintergarde_mine_bombAI : public ScriptedAI
    {
        npc_wintergarde_mine_bombAI(Creature* c) : ScriptedAI(c) { }

        uint32 uiExplosionTimer;
        void Reset()
        {
            uiExplosionTimer = urand(5000, 10000);
        }
        void UpdateAI(uint32 const diff)
        {
            if(uiExplosionTimer < diff)
            {
                DoCast(SPELL);
                for(uint8 i = 0; i < 4; ++i)
                {
                    if(Creature* cCredit = me->FindNearestCreature(27436 + i, 10.0f))
                    {
                        if(Unit* uOwner = me->GetOwner())
                        {
                            Player* pOwner = uOwner->ToPlayer();
                            if(pOwner && pOwner->GetQuestStatus(QUEST) == QUEST_STATUS_INCOMPLETE)
                                pOwner->KilledMonsterCredit(cCredit->GetEntry(), cCredit->GetGUID());
                        }
                    }
                }
                me->Kill(me);
                return;
            }
            else uiExplosionTimer -= diff;
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_wintergarde_mine_bombAI(creature);
    }
};

enum Spells
{
    SPELL_EXPLOSIVE              = 47305,
    SPELL_EXPLOSIVE_INSTAKILL    = 47306,
    SPELL_EXPLOSION_VISUAL       = 47311,

    SPELL_SUMMON_MEAT_SHORT      = 47309,
    SPELL_SUMMON_MEAT_MEDIUM     = 47924,
    SPELL_SUMMON_MEAT_LONG       = 47925,
};

class npc_hulking_jormungar : public CreatureScript
{
public:
    npc_hulking_jormungar() : CreatureScript("npc_hulking_jormungar") { }

    struct npc_hulking_jormungarAI : public ScriptedAI
    {
        npc_hulking_jormungarAI(Creature* creature) : ScriptedAI(creature) { }

        bool mouthOpen;
        bool OnDeath;
        uint32 deathTimer;
        uint32 timer;

        void Reset()
        {
            mouthOpen = false;
            OnDeath = false;
            deathTimer = 500;
            timer = 3000;
        }

        void SpellHit(Unit* /*pCaster*/, const SpellEntry* pSpell)
        {
            if(pSpell->Id == SPELL_EXPLOSIVE && mouthOpen)
            {
                DoCast(SPELL_EXPLOSION_VISUAL);
                OnDeath = true;
                deathTimer = 500;
                switch(urand(0, 2))
                {
                    case 0:
                        DoCast(SPELL_SUMMON_MEAT_SHORT);
                        break;
                    case 1:
                        DoCast(SPELL_SUMMON_MEAT_MEDIUM);
                        break;
                    case 2:
                        DoCast(SPELL_SUMMON_MEAT_LONG);
                        break;
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            Unit* victim = me->getVictim();
            if(victim->GetTypeId() == TYPEID_PLAYER)
            {
                if(urand(0, 500) <= 250 && !mouthOpen)
                {
                    mouthOpen = true;
                    timer = 3000;
                }
            }

            if(mouthOpen)
            {
                if(timer <= diff)
                    mouthOpen = false;
                else
                    timer -= diff;
            }

            if(OnDeath)
            {
                if(deathTimer <= diff)
                {
                    DoCast(SPELL_EXPLOSIVE_INSTAKILL);

                    Player* pPlayer = victim->ToPlayer();
                    if(pPlayer && pPlayer->GetQuestStatus(12049) == QUEST_STATUS_INCOMPLETE)
                    {
                        // check space and find places
                        ItemPosCountVec dest;
                        InventoryResult msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 36731, 1, 0);

                        if(msg == EQUIP_ERR_OK) {
                            Item* item = pPlayer->StoreNewItem(dest, 36731, true, Item::GenerateItemRandomPropertyId(36731));
                            pPlayer->SendNewItem(item, 1, true, false);
                        }
                    }
                }
                else
                    deathTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hulking_jormungarAI(creature);
    }
};

class npc_rojections_and_plans_Kill_credit_bunny: public CreatureScript
{
public:
    npc_rojections_and_plans_Kill_credit_bunny() : CreatureScript("npc_rojections_and_plans_Kill_credit_bunny") { }

    struct npc_rojections_and_plans_Kill_credit_bunnyAI : public ScriptedAI
    {
        npc_rojections_and_plans_Kill_credit_bunnyAI(Creature* c) : ScriptedAI(c) { }

        void MoveInLineOfSight(Unit* who)
        {
            ScriptedAI::MoveInLineOfSight(who);

            if(who->GetTypeId() == TYPEID_PLAYER)
            {
                if((((Player*)who)->GetQuestStatus(12061) == QUEST_STATUS_INCOMPLETE)||(((Player*)who)->GetQuestStatus(12060) == QUEST_STATUS_INCOMPLETE))
                    ((Player*)who)->KilledMonsterCredit(27853,0);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_rojections_and_plans_Kill_credit_bunnyAI(creature);
    }
};

class npc_wartook_iceborn: public CreatureScript
{
public:
    npc_wartook_iceborn() : CreatureScript("npc_wartook_iceborn") { }

    struct npc_wartook_icebornAI : public ScriptedAI
    {
        npc_wartook_icebornAI(Creature* c) : ScriptedAI(c) { }

        void MoveInLineOfSight(Unit* pWho)
        {
            ScriptedAI::MoveInLineOfSight(pWho);

            if(pWho->GetTypeId() == TYPEID_PLAYER)
            {
                if(Player* pPlayer = pWho->ToPlayer())
                {
                    if(pWho->IsWithinDist(me, 40.0f) && pPlayer->GetQuestStatus(11930) == QUEST_STATUS_INCOMPLETE && pPlayer->HasAura(46657))
                    {
                        pPlayer->CompleteQuest(11930);
                        pPlayer->RemoveAura(46657);

                        if(Creature* pCreature = me->FindNearestCreature(26167, 40.0f))
                            pCreature->DespawnOrUnsummon();
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wartook_icebornAI(creature);
    }
};

class npc_woodlands_walker : public CreatureScript
{
public:
    npc_woodlands_walker() : CreatureScript("npc_woodlands_walker") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if(pPlayer->hasQuest(12096))
            pCreature->setFaction(14);
        return true;
    }
};

void AddSC_dragonblight()
{
    new npc_woodlands_walker;
    new npc_alexstrasza_wr_gate;
    new npc_wintergarde_mine_bomb;
    new npc_hulking_jormungar;
    new npc_rojections_and_plans_Kill_credit_bunny;
    new npc_wartook_iceborn;
}

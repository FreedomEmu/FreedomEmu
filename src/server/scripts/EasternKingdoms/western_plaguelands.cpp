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

#define GOSSIP_HDA1 "What does the Felstone Field Cauldron need?"
#define GOSSIP_HDA2 "What does the Dalson's Tears Cauldron need?"
#define GOSSIP_HDA3 "What does the Writhing Haunt Cauldron need?"
#define GOSSIP_HDA4 "What does the Gahrron's Withering Cauldron need?"

#define GOSSIP_SDA1 "Thanks, i need a Vitreous Focuser"

class npcs_dithers_and_arbington : public CreatureScript
{
public:
    npcs_dithers_and_arbington() : CreatureScript("npcs_dithers_and_arbington") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(3980, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(3981, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(3982, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(3983, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->CLOSE_GOSSIP_MENU();
                creature->CastSpell(player, 17529, false);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());
        if(creature->isVendor())
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if(player->GetQuestRewardStatus(5237) || player->GetQuestRewardStatus(5238))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HDA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HDA3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HDA4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(3985, creature->GetGUID());
        } else
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

enum eMyranda
{
    QUEST_SUBTERFUGE        = 5862,
    QUEST_IN_DREAMS         = 5944,
    SPELL_SCARLET_ILLUSION  = 17961
};

#define GOSSIP_ITEM_ILLUSION    "I am ready for the illusion, Myranda."

class npc_myranda_the_hag : public CreatureScript
{
public:
    npc_myranda_the_hag() : CreatureScript("npc_myranda_the_hag") { }

    bool OnGossipSelect(Player* player, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if(uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->CastSpell(player, SPELL_SCARLET_ILLUSION, false);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if(player->GetQuestStatus(QUEST_SUBTERFUGE) == QUEST_STATUS_COMPLETE &&
            !player->GetQuestRewardStatus(QUEST_IN_DREAMS) && !player->HasAura(SPELL_SCARLET_ILLUSION))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ILLUSION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(4773, creature->GetGUID());
            return true;
        }
        else
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

class npc_the_scourge_cauldron : public CreatureScript
{
public:
    npc_the_scourge_cauldron() : CreatureScript("npc_the_scourge_cauldron") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_the_scourge_cauldronAI (creature);
    }

    struct npc_the_scourge_cauldronAI : public ScriptedAI
    {
        npc_the_scourge_cauldronAI(Creature* c) : ScriptedAI(c) { }

        void Reset() { }

        void EnterCombat(Unit* /*pWho*/) { }

        void DoDie()
        {
            //summoner dies here
            me->DealDamage(me, me->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            //override any database `spawntimesecs` to prevent duplicated summons
            uint32 rTime = me->GetRespawnDelay();
            if(rTime<600)
                me->SetRespawnDelay(600);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if(!who || who->GetTypeId() != TYPEID_PLAYER)
                return;

            if(who->GetTypeId() == TYPEID_PLAYER)
            {
                switch(me->GetAreaId())
                {
                    case 199:                                   //felstone
                        if(CAST_PLR(who)->GetQuestStatus(5216) == QUEST_STATUS_INCOMPLETE ||
                            CAST_PLR(who)->GetQuestStatus(5229) == QUEST_STATUS_INCOMPLETE)
                        {
                            me->SummonCreature(11075, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                            DoDie();
                        }
                        break;
                    case 200:                                   //dalson
                        if(CAST_PLR(who)->GetQuestStatus(5219) == QUEST_STATUS_INCOMPLETE ||
                            CAST_PLR(who)->GetQuestStatus(5231) == QUEST_STATUS_INCOMPLETE)
                        {
                            me->SummonCreature(11077, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                            DoDie();
                        }
                        break;
                    case 201:                                   //gahrron
                        if(CAST_PLR(who)->GetQuestStatus(5225) == QUEST_STATUS_INCOMPLETE ||
                            CAST_PLR(who)->GetQuestStatus(5235) == QUEST_STATUS_INCOMPLETE)
                        {
                            me->SummonCreature(11078, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                            DoDie();
                        }
                        break;
                    case 202:                                   //writhing
                        if(CAST_PLR(who)->GetQuestStatus(5222) == QUEST_STATUS_INCOMPLETE ||
                            CAST_PLR(who)->GetQuestStatus(5233) == QUEST_STATUS_INCOMPLETE)
                        {
                            me->SummonCreature(11076, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                            DoDie();
                        }
                        break;
                }
            }
        }
    };
};

enum eAndorhalTower
{
    GO_BEACON_TORCH                             = 176093
};

class npc_andorhal_tower : public CreatureScript
{
public:
    npc_andorhal_tower() : CreatureScript("npc_andorhal_tower") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_andorhal_towerAI (creature);
    }

    struct npc_andorhal_towerAI : public Scripted_NoMovementAI
    {
        npc_andorhal_towerAI(Creature* c) : Scripted_NoMovementAI(c) { }

        void MoveInLineOfSight(Unit* who)
        {
            if(!who || who->GetTypeId() != TYPEID_PLAYER)
                return;

            if(me->FindNearestGameObject(GO_BEACON_TORCH, 10.0f))
                CAST_PLR(who)->KilledMonsterCredit(me->GetEntry(), me->GetGUID());
        }
    };
};

enum eTruuen
{
    NPC_GHOST_UTHER             = 17233,
    NPC_THEL_DANIS              = 1854,
    NPC_GHOUL                   = 1791,      //ambush

    QUEST_TOMB_LIGHTBRINGER     = 9446,

    SAY_WP_0                    = -1800064,  //Beware! We are attacked!
    SAY_WP_1                    = -1800065,  //It must be the purity of the Mark of the Lightbringer that is drawing forth the Scourge to attack us. We must proceed with caution lest we be overwhelmed!
    SAY_WP_2                    = -1800066,  //This land truly needs to be cleansed by the Light! Let us continue on to the tomb. It isn't far now...
    SAY_WP_3                    = -1800067,  //Be welcome, friends!
    SAY_WP_4                    = -1800068,  //Thank you for coming here in remembrance of me. Your efforts in recovering that symbol, while unnecessary, are certainly touching to an old man's heart.
    SAY_WP_5                    = -1800069,  //Please, rise my friend. Keep the Blessing as a symbol of the strength of the Light and how heroes long gone might once again rise in each of us to inspire.
    SAY_WP_6                    = -1800070   //Thank you my friend for making this possible. This is a day that I shall never forget! I think I will stay a while. Please return to High Priestess MacDonnell at the camp. I know that she'll be keenly interested to know of what has transpired here.
};

class npc_anchorite_truuen : public CreatureScript
{
public:
    npc_anchorite_truuen() : CreatureScript("npc_anchorite_truuen") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const *quest)
    {
        npc_escortAI* pEscortAI = CAST_AI(npc_anchorite_truuen::npc_anchorite_truuenAI, creature->AI());

        if(quest->GetQuestId() == QUEST_TOMB_LIGHTBRINGER)
            pEscortAI->Start(true, true, player->GetGUID());
        return false;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_anchorite_truuenAI(creature);
    }

    struct npc_anchorite_truuenAI : public npc_escortAI
    {
        npc_anchorite_truuenAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        uint64 UghostGUID;
        uint64 TheldanisGUID;

        Creature* Ughost;
        Creature* Theldanis;

        void Reset()
        {
            m_uiChatTimer = 7000;
        }

        void JustSummoned(Creature* summoned)
        {
            if(summoned->GetEntry() == NPC_GHOUL)
                summoned->AI()->AttackStart(me);
        }

        void WaypointReached(uint32 i)
        {
            Player* player = GetPlayerForEscort();
            switch(i)
            {
                case 8:
                    DoScriptText(SAY_WP_0, me);
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+7.0f, me->GetPositionY()+7.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+5.0f, me->GetPositionY()+5.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    break;
                case 9:
                    DoScriptText(SAY_WP_1, me);
                    break;
                case 14:
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+7.0f, me->GetPositionY()+7.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+5.0f, me->GetPositionY()+5.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+10.0f, me->GetPositionY()+10.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    me->SummonCreature(NPC_GHOUL, me->GetPositionX()+8.0f, me->GetPositionY()+8.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                    break;
                case 15:
                    DoScriptText(SAY_WP_2, me);
                case 21:
                    Theldanis = GetClosestCreatureWithEntry(me, NPC_THEL_DANIS, 150);
                    DoScriptText(SAY_WP_3, Theldanis);
                    break;
                case 22:
                    break;
                case 23:
                    Ughost = me->SummonCreature(NPC_GHOST_UTHER, 971.86f, -1825.42f, 81.99f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    Ughost->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                    DoScriptText(SAY_WP_4, Ughost, me);
                    m_uiChatTimer = 4000;
                    break;
                case 24:
                    DoScriptText(SAY_WP_5, Ughost, me);
                    m_uiChatTimer = 4000;
                    break;
                case 25:
                    DoScriptText(SAY_WP_6, Ughost, me);
                    m_uiChatTimer = 4000;
                    break;
                case 26:
                    if(player)
                        player->GroupEventHappens(QUEST_TOMB_LIGHTBRINGER, me);
                    break;
            }
        }

        void EnterCombat(Unit* /*pWho*/){ }

         void JustDied(Unit* /*pKiller*/)
        {
           Player* player = GetPlayerForEscort();
            if(player)
                player->FailQuest(QUEST_TOMB_LIGHTBRINGER);
        }

        void UpdateAI(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);
            DoMeleeAttackIfReady();
            if(HasEscortState(STATE_ESCORT_ESCORTING))
                m_uiChatTimer = 6000;
        }
    };
};

void AddSC_western_plaguelands()
{
    new npcs_dithers_and_arbington;
    new npc_myranda_the_hag;
    new npc_the_scourge_cauldron;
    new npc_andorhal_tower;
    new npc_anchorite_truuen;
}
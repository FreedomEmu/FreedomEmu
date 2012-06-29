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

enum eGeargrindersJumpbot
{
    Q_KING_OF_THE_MOUNTAIN_A            = 13280,
    Q_KING_OF_THE_MOUNTAIN_H            = 13283,

    SPELL_ENTER_GEARGRINDER_JUMPBOT     = 59592
};

class npc_geargrinders_jumpbot : public CreatureScript
{
public:
    npc_geargrinders_jumpbot() : CreatureScript("npc_geargrinders_jumpbot") { }

    struct npc_geargrinders_jumpbotAI : public ScriptedAI
    {
        npc_geargrinders_jumpbotAI(Creature* pCreature) : ScriptedAI(pCreature) { }
    };

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if(pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if(pPlayer->GetQuestStatus(Q_KING_OF_THE_MOUNTAIN_A) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(Q_KING_OF_THE_MOUNTAIN_H) == QUEST_STATUS_INCOMPLETE)
        {
            pPlayer->CastSpell(pPlayer, SPELL_ENTER_GEARGRINDER_JUMPBOT, false);
        }
        return true;
    }

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_geargrinders_jumpbotAI(creature);
    }
};

enum eBattleStandard
{
    NPC_KING_OF_THE_MOUNTAINT_CREDIT        = 31766
};

class spell_plant_alliance_battle_standard: public SpellScriptLoader
{
public:
    spell_plant_alliance_battle_standard() : SpellScriptLoader("spell_plant_alliance_battle_standard") { }

    class spell_plant_alliance_battle_standard_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_plant_alliance_battle_standard_SpellScript)
        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* pCaster = GetCaster();
            if(pCaster && pCaster->IsVehicle())
            {
                Unit* pPlayer = pCaster->GetVehicleKit()->GetPassenger(0);
                if(pPlayer)
                    pPlayer->ToPlayer()->KilledMonsterCredit(NPC_KING_OF_THE_MOUNTAINT_CREDIT,0);
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_plant_alliance_battle_standard_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_plant_alliance_battle_standard_SpellScript();
    }
};

enum eSlim
{
    QUEST_ITEM_SLIM     = 36765,
    QUEST_SLIM_PICKING  = 12075
};

class npc_slim_giant : public CreatureScript
{
public:
    npc_slim_giant() : CreatureScript("npc_slim_giant") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if(pPlayer->GetQuestStatus(QUEST_SLIM_PICKING) == QUEST_STATUS_INCOMPLETE)
        {
            pPlayer->PlayerTalkClass->ClearMenus();
            pPlayer->AddItem(QUEST_ITEM_SLIM, 1);
        }

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }
};

enum eSoldier
{
    SAY_KILL_QUEST1                              = -1603511,
    SAY_KILL_QUEST2                              = -1603512,
    SAY_KILL_QUEST3                              = -1603513,
    SAY_KILL_QUEST4                              = -1603514,
    SAY_KILL_QUEST5                              = -1603515,
    SAY_QUEST_SOLDIER1                           = -1603516,
    SAY_QUEST_SOLDIER2                           = -1603517,
    SAY_QUEST_SOLDIER3                           = -1603518,
    SAY_QUEST_SOLDIER4                           = -1603519,
    SAY_QUEST_SOLDIER5                           = -1603520,
    SAY_QUEST_SOLDIER6                           = -1603521,
    SAY_QUEST_SOLDIER7                           = -1603522,
    SAY_QUEST_BERSERKER1                         = -1603523,
    SAY_QUEST_BERSERKER2                         = -1603524,
    SAY_QUEST_BERSERKER3                         = -1603525,
    SAY_QUEST_BERSERKER4                         = -1603526,
    SAY_QUEST_BERSERKER5                         = -1603527,
    SAY_QUEST_BERSERKER6                         = -1603528,
    SAY_QUEST_BERSERKER7                         = -1603529,
    SAY_QUEST_BERSERKER8                         = -1603530,

    CREATURE_DYING_SOLDIER_KC                    = 31312,
    CREATURE_DYING_BERSERKER_KC                  = 31272,

    QUEST_FINISH_ME                              = 13232,
    QUEST_THE_BROKEN_FRONT_A                     = 13231,
    QUEST_THE_BROKEN_FRONT_H                     = 13228,
};

#define GOSSIP_ITEM_DYING_SOLDIER "Travel well, hero of the Alliance!"
#define GOSSIP_ITEM_DYING_SOLDIER1 "Stay with me, friend. I must know what happened here."
#define GOSSIP_ITEM_DYING_BERSERKER "Stay with me, friend. I must know what happened here."

class npc_dying_soldier : public CreatureScript
{
public:
    npc_dying_soldier() : CreatureScript("npc_dying_soldier") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if(pPlayer->GetQuestStatus(QUEST_FINISH_ME) == QUEST_STATUS_INCOMPLETE)
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DYING_SOLDIER, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

        if(pPlayer->GetQuestStatus(QUEST_THE_BROKEN_FRONT_A) == QUEST_STATUS_INCOMPLETE)
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DYING_SOLDIER1, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO+1);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();

        if(uiAction == GOSSIP_SENDER_INFO)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            if(pPlayer->GetQuestStatus(QUEST_FINISH_ME) == QUEST_STATUS_INCOMPLETE)
                pPlayer->KilledMonsterCredit(CREATURE_DYING_SOLDIER_KC, 0);
            pCreature->Kill(pCreature);
            DoScriptText(RAND(SAY_KILL_QUEST1, SAY_KILL_QUEST2, SAY_KILL_QUEST3, SAY_KILL_QUEST4, SAY_KILL_QUEST5), pCreature);
        }

        if(uiAction == GOSSIP_SENDER_INFO+1)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            DoScriptText(SAY_QUEST_SOLDIER1, pCreature);
            CAST_AI(npc_dying_soldier::npc_dying_soldierAI, pCreature->AI())->uiPlayerGUID = pPlayer->GetGUID();
            CAST_AI(npc_dying_soldier::npc_dying_soldierAI, pCreature->AI())->uiTalkTimer = 3000;
            CAST_AI(npc_dying_soldier::npc_dying_soldierAI, pCreature->AI())->bTalkTime = true;
        }

        return true;
    }

    struct npc_dying_soldierAI : public ScriptedAI
    {
        npc_dying_soldierAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint64 uiPlayerGUID;
        uint32 uiTalkTimer;
        uint32 uiStep;
        bool bTalkTime;

        void Reset()
        {
            uiPlayerGUID = 0;
            bTalkTime = false;
            uiStep = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if(bTalkTime && uiTalkTimer <= diff)
            {
                if(Player* pPlayer = Unit::GetPlayer(*me, uiPlayerGUID))
                {
                    switch(uiStep)
                    {
                        case 0:
                            DoScriptText(SAY_QUEST_SOLDIER2, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 1:
                            DoScriptText(SAY_QUEST_SOLDIER3, pPlayer);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 2:
                            DoScriptText(SAY_QUEST_SOLDIER4, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 3:
                            DoScriptText(SAY_QUEST_SOLDIER5, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 4:
                            DoScriptText(SAY_QUEST_SOLDIER6, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 5:
                            DoScriptText(SAY_QUEST_SOLDIER7, me);
                            if(pPlayer->GetQuestStatus(QUEST_THE_BROKEN_FRONT_A) == QUEST_STATUS_INCOMPLETE)
                                pPlayer->KilledMonsterCredit(CREATURE_DYING_SOLDIER_KC, 0);
                            bTalkTime = false;
                            uiStep = 0;
                            break;
                    }
                }
            }
            else
                uiTalkTimer -= diff;
        }
    };

    CreatureAI *GetAI(Creature* pCreature) const
    {
        return new npc_dying_soldierAI(pCreature);
    }
};

class npc_dying_berserker : public CreatureScript
{
public:
    npc_dying_berserker() : CreatureScript("npc_dying_berserker") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if(pPlayer->GetQuestStatus(QUEST_THE_BROKEN_FRONT_H) == QUEST_STATUS_INCOMPLETE)
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DYING_BERSERKER, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();

        if(uiAction == GOSSIP_SENDER_INFO)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            DoScriptText(SAY_QUEST_BERSERKER1, pCreature);
            CAST_AI(npc_dying_berserker::npc_dying_berserkerAI, pCreature->AI())->uiPlayerGUID = pPlayer->GetGUID();
            CAST_AI(npc_dying_berserker::npc_dying_berserkerAI, pCreature->AI())->uiTalkTimer = 3000;
            CAST_AI(npc_dying_berserker::npc_dying_berserkerAI, pCreature->AI())->bTalkTime = true;
        }

        return true;
    }

    struct npc_dying_berserkerAI : public ScriptedAI
    {
        npc_dying_berserkerAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint64 uiPlayerGUID;
        uint32 uiTalkTimer;
        uint32 uiStep;
        bool bTalkTime;

        void Reset()
        {
            uiPlayerGUID = 0;
            bTalkTime = false;
            uiStep = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if(bTalkTime && uiTalkTimer <= diff)
            {
                if(Player* pPlayer = Unit::GetPlayer(*me, uiPlayerGUID))
                {
                    switch(uiStep)
                    {
                        case 0:
                            DoScriptText(SAY_QUEST_BERSERKER2, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 1:
                            DoScriptText(SAY_QUEST_BERSERKER3, pPlayer);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 2:
                            DoScriptText(SAY_QUEST_BERSERKER4, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 3:
                            DoScriptText(SAY_QUEST_BERSERKER5, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 4:
                            DoScriptText(SAY_QUEST_BERSERKER6, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 5:
                            DoScriptText(SAY_QUEST_BERSERKER7, me);
                            uiTalkTimer = 3000;
                            ++uiStep;
                            break;
                        case 6:
                            DoScriptText(SAY_QUEST_BERSERKER8, me);
                            if(pPlayer->GetQuestStatus(QUEST_THE_BROKEN_FRONT_H) == QUEST_STATUS_INCOMPLETE)
                                pPlayer->KilledMonsterCredit(CREATURE_DYING_BERSERKER_KC, 0);
                            bTalkTime = false;
                            uiStep = 0;
                            break;
                    }
                }
            }
            else
                uiTalkTimer -= diff;
        }
    };

    CreatureAI *GetAI(Creature* pCreature) const
    {
        return new npc_dying_berserkerAI(pCreature);
    }
};

#define GOSSIP_ARETE_ITEM1 "Lord-Commander, I would hear your tale."
#define GOSSIP_ARETE_ITEM2 "<You nod slightly but do not complete the motion as the Lord-Commander narrows his eyes before he continues.>"
#define GOSSIP_ARETE_ITEM3 "I thought that they now called themselves the Scarlet Onslaught?"
#define GOSSIP_ARETE_ITEM4 "Where did the grand admiral go?"
#define GOSSIP_ARETE_ITEM5 "That's fine. When do I start?"
#define GOSSIP_ARETE_ITEM6 "Let's finish this!"
#define GOSSIP_ARETE_ITEM7 "That's quite a tale, Lord-Commander."

enum eArete
{
    GOSSIP_TEXTID_ARETE1        = 13525,
    GOSSIP_TEXTID_ARETE2        = 13526,
    GOSSIP_TEXTID_ARETE3        = 13527,
    GOSSIP_TEXTID_ARETE4        = 13528,
    GOSSIP_TEXTID_ARETE5        = 13529,
    GOSSIP_TEXTID_ARETE6        = 13530,
    GOSSIP_TEXTID_ARETE7        = 13531,

    QUEST_THE_STORY_THUS_FAR    = 12807
};

class npc_arete : public CreatureScript
{
public:
    npc_arete() : CreatureScript("npc_arete") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if(player->GetQuestStatus(QUEST_THE_STORY_THUS_FAR) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE1, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE3, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE4, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE5, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE6, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE7, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(QUEST_THE_STORY_THUS_FAR);
                break;
        }

        return true;
    }
};

enum eDameEnvikiKapsalis
{
    TITLE_CRUSADER    = 123
};

class npc_dame_evniki_kapsalis : public CreatureScript
{
public:
    npc_dame_evniki_kapsalis() : CreatureScript("npc_dame_evniki_kapsalis") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(player->HasTitle(TITLE_CRUSADER))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if(uiAction == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());
        return true;
    }
};

enum eSquireDavid
{
    QUEST_THE_ASPIRANT_S_CHALLENGE_H                    = 13680,
    QUEST_THE_ASPIRANT_S_CHALLENGE_A                    = 13679,

    NPC_ARGENT_VALIANT                                  = 33448,

    GOSSIP_TEXTID_SQUIRE                                = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_david : public CreatureScript
{
public:
    npc_squire_david() : CreatureScript("npc_squire_david") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if(player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_H) == QUEST_STATUS_INCOMPLETE ||
            player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_A) == QUEST_STATUS_INCOMPLETE)//We need more info about it.
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if(uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->SummonCreature(NPC_ARGENT_VALIANT, 8575.451f, 952.472f, 547.554f, 0.38f);
        }
        return true;
    }
};

enum eSquireDanny
{
    NPC_ARGENT_CHAMPION                                        = 33707,
};

struct QUEST_VALIANTS_CHALLENGE
{
  uint32 quest_id;
};

QUEST_VALIANTS_CHALLENGE m_quest[] = {13727, 13728, 13729, 13731, 13726, 13725, 13713, 13723, 13724, 13699};
#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"

class npc_squire_danny : public CreatureScript
{
public:
    npc_squire_danny() : CreatureScript("npc_squire_danny") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        for(int i = 0; i < 10; i++)
        {
            if(player->GetQuestStatus(m_quest[i].quest_id) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if(uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->SummonCreature(NPC_ARGENT_CHAMPION, 8549.169f, 1142.776f, 557.353f, 4.93f);
        }
        return true;
    }
};

enum eArgentChampion
{
    SPELL_CHARGER                = 63010,
    SPELL_SHIELD_BREAKERD        = 65147,

    NPC_ARGENT_CHAMPION_CREDIT   = 33707
};

class npc_argent_champion : public CreatureScript
{
public:
    npc_argent_champion() : CreatureScript("npc_argent_champion") { }

    struct npc_argent_championAI : public ScriptedAI
    {
        npc_argent_championAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->CastSpell(me, 62719, true);
            me->CastSpell(me, 62719, true);
            pCreature->GetMotionMaster()->MovePoint(0,8544.384f,1125.818f,556.787f);
            pCreature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
        uint32 uidefTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
            uidefTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if(uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
            if(pDoneBy)
            {
                if(uiDamage >= me->GetHealth()&& (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                {
                    uiDamage = 0;
                    Map* pMap = me->GetMap();
                    Map::PlayerList const& players = pMap->GetPlayers();
                    if(!players.isEmpty()) {
                        for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr) {
                            if(Player* player = itr->getSource())
                                player->KilledMonsterCredit(NPC_ARGENT_CHAMPION_CREDIT, 0);
                        }
                    }

                    me->setFaction(35);
                    me->DespawnOrUnsummon(5000);
                    me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    EnterEvadeMode();
               }
            }
        }

        void DoMeleeAttackIfReady()
        {
            if(me->isAttackReady()) {
                if(me->IsWithinMeleeRange(me->getVictim())) {
                    DoCastVictim(62544);
                    me->resetAttackTimer();
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(uidefTimer<=diff)
            {
                 me->CastSpell(me, 62719, true);
                 uidefTimer = 10000;
            } else  uidefTimer -= diff;

            if(uiChargeTimer <= diff)
            {
                DoCastVictim(SPELL_CHARGER);
                uiChargeTimer = 7000;
            } else uiChargeTimer -= diff;

            if(uiShieldBreakerTimer <= diff)
            {
                DoCastVictim(SPELL_SHIELD_BREAKERD);
                uiShieldBreakerTimer = 10000;
            } else uiShieldBreakerTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_argent_championAI(creature);
    }
};

enum eArgentValiant
{
    SPELL_CHARGE                = 63010,
    SPELL_SHIELD_BREAKER        = 65147,

    NPC_ARGENT_VALIANT_CREDIT   = 24108
};

class npc_argent_valiant : public CreatureScript
{
public:
    npc_argent_valiant() : CreatureScript("npc_argent_valiant") { }

    struct npc_argent_valiantAI : public ScriptedAI
    {
        npc_argent_valiantAI(Creature* creature) : ScriptedAI(creature)
        {
            me->CastSpell(me, 62719, true);
            me->CastSpell(me, 62719, true);

            creature->GetMotionMaster()->MovePoint(0, 8599.258f, 963.951f, 547.553f);
            creature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
        uint32 uidefTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
            uidefTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if(uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
            if(pDoneBy)
            {
                if(uiDamage >= me->GetHealth()&& (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                {
                    uiDamage = 0;
                    Map* pMap = me->GetMap();
                    Map::PlayerList const& players = pMap->GetPlayers();
                        if(!players.isEmpty()) {
                            for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr) {
                                if(Player* player = itr->getSource()) {
                                        player->KilledMonsterCredit(33448, 0);
                                }
                            }
                        }

                    me->setFaction(35);
                    me->DespawnOrUnsummon(5000);
                    me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    EnterEvadeMode();
               }
            }
        }

        void DoMeleeAttackIfReady()
        {
            if(me->isAttackReady()) {
                if(me->IsWithinMeleeRange(me->getVictim())) {
                    DoCastVictim(62544);
                    me->resetAttackTimer();
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(uidefTimer<=diff)
            {
                 me->CastSpell(me, 62719, true);
                 uidefTimer = 10000;
            } else  uidefTimer -= diff;

            if(uiChargeTimer <= diff)
            {
                DoCastVictim(SPELL_CHARGE);
                uiChargeTimer = 7000;
            } else uiChargeTimer -= diff;

            if(uiShieldBreakerTimer <= diff)
            {
                DoCastVictim(SPELL_SHIELD_BREAKER);
                uiShieldBreakerTimer = 10000;
            } else uiShieldBreakerTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_argent_valiantAI(creature);
    }
};

enum ealorah_and_grimmin
{
    SPELL_CHAIN                     = 68341,
    NPC_FJOLA_LIGHTBANE             = 36065,
    NPC_EYDIS_DARKBANE              = 36066,
    NPC_PRIESTESS_ALORAH            = 36101,
    NPC_PRIEST_GRIMMIN              = 36102
};

class npc_alorah_and_grimmin : public CreatureScript
{
public:
    npc_alorah_and_grimmin() : CreatureScript("npc_alorah_and_grimmin") { }

    struct npc_alorah_and_grimminAI : public ScriptedAI
    {
        npc_alorah_and_grimminAI(Creature* creature) : ScriptedAI(creature) { }

        bool uiCast;

        void Reset()
        {
            uiCast = false;
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            if(uiCast || !UpdateVictim())
                return;

            uiCast = true;
            Creature* target = NULL;

            switch(me->GetEntry())
            {
                case NPC_PRIESTESS_ALORAH:
                    target = me->FindNearestCreature(NPC_EYDIS_DARKBANE, 10.0f);
                    break;
                case NPC_PRIEST_GRIMMIN:
                    target = me->FindNearestCreature(NPC_FJOLA_LIGHTBANE, 10.0f);
                    break;
            }

            if(target)
                DoCast(target, SPELL_CHAIN);
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_alorah_and_grimminAI(creature);
    }
};

enum eGuardianPavilion
{
    SPELL_TRESPASSER_H                            = 63987,
    AREA_SUNREAVER_PAVILION                       = 4676,

    AREA_SILVER_COVENANT_PAVILION                 = 4677,
    SPELL_TRESPASSER_A                            = 63986,
};

class npc_guardian_pavilion : public CreatureScript
{
public:
    npc_guardian_pavilion() : CreatureScript("npc_guardian_pavilion") { }

    struct npc_guardian_pavilionAI : public Scripted_NoMovementAI
    {
        npc_guardian_pavilionAI(Creature* creature) : Scripted_NoMovementAI(creature) { }

        void MoveInLineOfSight(Unit* who)
        {
            if(me->GetAreaId() != AREA_SUNREAVER_PAVILION && me->GetAreaId() != AREA_SILVER_COVENANT_PAVILION)
                return;

            if(!who || who->GetTypeId() != TYPEID_PLAYER || !me->IsHostileTo(who) || !me->isInBackInMap(who, 5.0f))
                return;

            if(who->HasAura(SPELL_TRESPASSER_H) || who->HasAura(SPELL_TRESPASSER_A))
                return;

            if(who->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                who->CastSpell(who, SPELL_TRESPASSER_H, true);
            else
                who->CastSpell(who, SPELL_TRESPASSER_A, true);

        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

class npc_jeran : public CreatureScript
{
public:
    npc_jeran() : CreatureScript("npc_jeran") { }

    bool OnGossipHello(Player* player, Creature* pCreature)
    {
        if((player->GetQuestStatus(13828) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(13829) == QUEST_STATUS_INCOMPLETE))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Explain to me how to train with a dummy for the melee.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(14431, pCreature->GetGUID());
        } else player->SEND_GOSSIP_MENU(14453, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        if(uiAction==GOSSIP_ACTION_INFO_DEF+1)
        {
            player->KilledMonsterCredit(33973, 0);
            player->CLOSE_GOSSIP_MENU();
        }
        return true;
    }
};

class npc_valis : public CreatureScript
{
public:
    npc_valis() : CreatureScript("npc_valis") { }

    bool OnGossipHello(Player* player, Creature* pCreature)
    {
        if((player->GetQuestStatus(13835) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(13838) == QUEST_STATUS_INCOMPLETE))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Explain to me how to train with a target for long-range combat.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(14438, pCreature->GetGUID());
        } else player->SEND_GOSSIP_MENU(14453, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        if(uiAction==GOSSIP_ACTION_INFO_DEF+1)
        {
            player->KilledMonsterCredit(33974, 0);
            player->CLOSE_GOSSIP_MENU();
        }
        return true;
    }
};

class npc_rugan : public CreatureScript
{
public:
    npc_rugan() : CreatureScript("npc_rugan") { }

    bool OnGossipHello(Player* player, Creature* pCreature)
    {
        if((player->GetQuestStatus(13839) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(13837) == QUEST_STATUS_INCOMPLETE))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Explain to me how to train with a dummy for a rapid attack.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(14436, pCreature->GetGUID());
        } else player->SEND_GOSSIP_MENU(14453, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        if(uiAction==GOSSIP_ACTION_INFO_DEF+1)
        {
            player->KilledMonsterCredit(33972, 0);
            player->CLOSE_GOSSIP_MENU();
        }
        return true;
   }
};

enum eThrowWrithingMass
{
    NPC_CAULDORN_KILL_CREDIT        = 605030,
    QUEST_RETEST_NOW_A              = 13321,
    QUEST_RETEST_NOW_H              = 13356,
    QUEST_RETEST_NOW_DAILY_A        = 13322,
    QUEST_RETEST_NOW_DAILY_H        = 13357
};

class spell_throw_writhing_mass: public SpellScriptLoader
{
public:
    spell_throw_writhing_mass() : SpellScriptLoader("spell_throw_writhing_mass") { }

    class spell_throw_writhing_mass_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_throw_writhing_mass_SpellScript)
        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* pCaster = GetCaster();
            if(pCaster) {
                Player* pPlayer = pCaster->ToPlayer();
                if(pPlayer && (pPlayer->GetQuestStatus(QUEST_RETEST_NOW_A) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(QUEST_RETEST_NOW_H) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(QUEST_RETEST_NOW_DAILY_H) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(QUEST_RETEST_NOW_DAILY_A) == QUEST_STATUS_INCOMPLETE))
                    pPlayer->KilledMonsterCredit(NPC_CAULDORN_KILL_CREDIT, 0);
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_throw_writhing_mass_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_throw_writhing_mass_SpellScript();
    }
};

enum eNeutralizePlague
{
    CREDIT_PLAGUE_CAULDRON_NEUTRALIZED      = 31767,
};

class spell_q_neutralize_plague : public SpellScriptLoader
{
public:
    spell_q_neutralize_plague() : SpellScriptLoader("spell_q_neutralize_plague") { }

    class spell_q_neutralizing_doze_applied_SpellScript : public SpellScript
    {
    public:
        PrepareSpellScript(spell_q_neutralizing_doze_applied_SpellScript)

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if(Unit* pCaster = GetCaster()) {
                if(pCaster->GetTypeId() == TYPEID_PLAYER)
                    pCaster->ToPlayer()->KilledMonsterCredit(CREDIT_PLAGUE_CAULDRON_NEUTRALIZED, 0);
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_q_neutralizing_doze_applied_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q_neutralizing_doze_applied_SpellScript();
    }
};

void AddSC_icecrown()
{
    new npc_dying_soldier;
    new npc_dying_berserker;
    new npc_geargrinders_jumpbot;
    new spell_plant_alliance_battle_standard;
    new npc_slim_giant;
    new npc_jeran;
    new npc_valis;
    new npc_rugan;
    new npc_arete;
    new npc_dame_evniki_kapsalis;
    new npc_squire_david;
    new npc_argent_valiant;
    new npc_alorah_and_grimmin;
    new npc_guardian_pavilion;
    new spell_throw_writhing_mass;
    new spell_q_neutralize_plague;
    new npc_squire_danny;
    new npc_argent_champion;
}
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

#include "ScriptMgr.h"
#include "Chat.h"

class achievement_commandscript : public CommandScript
{
public:
    achievement_commandscript() : CommandScript("achievement_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand achievementCommandTable[] =
        {
            { "add",            SEC_ADMINISTRATOR,  false,  &HandleAchievementAddCommand,      "", NULL },
            //{ "delete",         SEC_ADMINISTRATOR,  false,  &HandleAchievementDeleteCommand,   "", NULL },
            { "status",         SEC_ADMINISTRATOR,  false,  &HandleAchievementStatusCommand,   "", NULL },
            { NULL,             0,                  false,  NULL,                              "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "achievement",    SEC_ADMINISTRATOR,  false, NULL,            "", achievementCommandTable },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        return commandTable;
    }

    static bool HandleAchievementAddCommand(ChatHandler* handler, const char *args)
    {
        if(!*args)
            return false;

        uint32 achievementId = atoi((char*)args);
        if(!achievementId)
        {
            if(char* cId = handler->extractKeyFromLink((char*)args, "Hachievement"))
                achievementId = atoi(cId);
            if(!achievementId)
                return false;
        }

        Player* target = handler->getSelectedPlayer();
        if(!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AchievementEntry const* pAE = GetAchievementStore()->LookupEntry(achievementId);
        if (pAE)
            target->CompletedAchievement(pAE);
        else
        {
            handler->PSendSysMessage(LANG_INVALID_ACHIEVEMENT_ENTRY, achievementId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandleAchievementStatusCommand(ChatHandler* handler, const char *args)
    {
        char* aId = handler->extractKeyFromLink((char*)args,"Hachievement");
        if (!aId)
            return false;

        uint32 entry = atol(aId);

        AchievementEntry const* pAE = GetAchievementStore()->LookupEntry(entry);
        if (!pAE)
        {
            handler->PSendSysMessage(LANG_INVALID_ACHIEVEMENT_ENTRY, entry);
            handler->SetSentErrorMessage(true);
            return false;
        }
        char *result = strtok(NULL, " ");

        Player* player;
        uint64 player_guid;
        std::string player_name;
        if (!handler->extractPlayerTarget((char*)result,&player,&player_guid,&player_name))
            player = handler->getSelectedPlayer();

        if (!player)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AchievementCriteriaEntryList const* lcrit = sAchievementMgr->GetAchievementCriteriaByAchievement(entry);
        if (lcrit->empty())  //should never happen
            sLog->outError("CommandScript Achievement: no criteria found for achievement %u!", entry);
        else
        {
            handler->PSendSysMessage(LANG_ACHIEVEMENT_STATUS, entry, player->GetName());
            for (AchievementCriteriaEntryList::const_iterator it = lcrit->begin(); it != lcrit->end(); ++it)
                handler->PSendSysMessage(LANG_ACHIEVEMENT_STATUS_CRITERIA, (*it)->ID, player->GetAchievementMgr().IsCompletedCriteria(*it, pAE) ? "completed" : "incomplete");
        }
        return true;
    }

    //static bool HandleAchievementDeleteCommand(ChatHandler* handler, const char *args)
    //{
    //    char* aId = handler->extractKeyFromLink((char*)args,"Hachievement");
    //    if (!aId)
    //        return false;

    //    uint32 entry = atol(aId);

    //    AchievementEntry const* pAE = GetAchievementStore()->LookupEntry(entry);
    //    if (!pAE)
    //    {
    //        handler->PSendSysMessage(LANG_INVALID_ACHIEVEMENT_ENTRY, entry);
    //        handler->SetSentErrorMessage(true);
    //        return false;
    //    }
    //    char *result = strtok(NULL, " ");

    //    Player* player;
    //    uint64 player_guid;
    //    std::string player_name;
    //    if (!handler->extractPlayerTarget((char*)result,&player,&player_guid,&player_name))
    //        player = handler->getSelectedPlayer();

    //    if (!player)
    //    {
    //        handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
    //        handler->SetSentErrorMessage(true);
    //        return false;
    //    }

    //    AchievementCriteriaEntryList const* lcrit = sAchievementMgr->GetAchievementCriteriaByAchievement(entry);
    //    if (lcrit->empty())  //should never happen
    //        sLog->outError("CommandScript Achievement: no criteria found for achievement %u!", entry);
    //    else
    //    {
    //        for (AchievementCriteriaEntryList::const_iterator it = lcrit->begin(); it != lcrit->end(); ++it)
    //            player->GetAchievementMgr().RemoveCriteriaProgress(*it);
    //        if (AchievementReward const* ar = sAchievementMgr->GetAchievementReward(pAE))
    //        {
    //            if (ar->itemId)
    //            {
    //                if (player->HasItemCount(ar->itemId, 1, true))
    //                    player->DestroyItemCount(ar->itemId, 1, true);
    //                else
    //                {
    //                    if (ItemPrototype const* proto = sObjectMgr->GetItemPrototype(ar->itemId))
    //                        if (proto->Class == ITEM_CLASS_MISC && proto->SubClass == ITEM_SUBCLASS_FOOD)
    //                            if (proto->Spells[0].SpellId == 55884 && proto->Spells[1].SpellId != 0)
    //                                player->removeSpell(proto->Spells[1].SpellId);
    //                }
    //            }
    //            if (ar->titleId)
    //                if (CharTitlesEntry const *cte = sCharTitlesStore.LookupEntry(ar->titleId[player->GetTeamId()]))
    //                    player->SetTitle(cte, true);
    //        }
    //        player->SaveToDB();
    //    }
    //    return true;
    //}
};

void AddSC_achievement_commandscript()
{
    new achievement_commandscript;
}

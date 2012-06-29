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

#include "Common.h"
#include "ArenaTeamMgr.h"

ArenaTeamMgr::ArenaTeamMgr()
{
    NextArenaTeamId = 1;
}

ArenaTeamMgr::~ArenaTeamMgr()
{
    for(ArenaTeamContainer::iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
        delete itr->second;
}

// Arena teams collection
ArenaTeam* ArenaTeamMgr::GetArenaTeamById(uint32 arenaTeamId) const
{
    ArenaTeamContainer::const_iterator itr = ArenaTeamStore.find(arenaTeamId);
    if(itr != ArenaTeamStore.end())
        return itr->second;

    return NULL;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByName(const std::string& arenaTeamName) const
{
    std::string search = arenaTeamName;
    std::transform(search.begin(), search.end(), search.begin(), ::toupper);
    for(ArenaTeamContainer::const_iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
    {
        std::string teamName = itr->second->GetName();
        std::transform(teamName.begin(), teamName.end(), teamName.begin(), ::toupper);
        if(search == teamName)
            return itr->second;
    }
    return NULL;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByCaptain(uint64 const& guid) const
{
    for(ArenaTeamContainer::const_iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
        if(itr->second->GetCaptain() == guid)
            return itr->second;

    return NULL;
}

void ArenaTeamMgr::AddArenaTeam(ArenaTeam* arenaTeam)
{
    ArenaTeamStore[arenaTeam->GetId()] = arenaTeam;
}

void ArenaTeamMgr::RemoveArenaTeam(uint32 arenaTeamId)
{
    ArenaTeamStore.erase(arenaTeamId);
}

uint32 ArenaTeamMgr::GenerateArenaTeamId()
{
    if(NextArenaTeamId >= 0xFFFFFFFE)
    {
        sLog->outError("Arena team ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return NextArenaTeamId++;
}

void ArenaTeamMgr::LoadArenaTeams()
{
    uint32 oldMSTime = getMSTime();

    // Clean out the trash before loading anything
    CharacterDatabase.Execute("DELETE FROM arena_team_member WHERE arenaTeamId NOT IN (SELECT arenaTeamId FROM arena_team)");

    //                                                                   0        1         2         3          4              5            6            7           8
    QueryResult result = CharacterDatabase.Query("SELECT arena_team.arenaTeamId, name, captainGuid, type, backgroundColor, emblemStyle, emblemColor, borderStyle, borderColor, "
        //                                               9        10        11         12           13       14
        "rating, weekGames, weekWins, seasonGames, seasonWins, rank FROM arena_team ORDER BY arena_team.arenaTeamId ASC");

    if(!result)
    {
        sLog->outString(">> Loaded 0 arena teams. DB table `arena_team` is empty!");
        sLog->outString();
        return;
    }

    QueryResult result2 = CharacterDatabase.Query(
        //              0              1           2             3              4                 5          6     7          8                  9
        "SELECT arenaTeamId, atm.guid, atm.weekGames, atm.weekWins, atm.seasonGames, atm.seasonWins, c.name, class, personalRating, matchMakerRating FROM arena_team_member atm"
        " INNER JOIN arena_team ate USING (arenaTeamId)"
        " LEFT JOIN characters AS c ON atm.guid = c.guid"
        " LEFT JOIN character_arena_stats AS cas ON c.guid = cas.guid AND (cas.slot = 0 AND ate.type = 2 OR cas.slot = 1 AND ate.type = 3 OR cas.slot = 2 AND ate.type = 5)"
        " ORDER BY atm.arenateamid ASC");

    uint32 count = 0;
    do
    {
        ArenaTeam* newArenaTeam = new ArenaTeam;

        if(!newArenaTeam->LoadArenaTeamFromDB(result) || !newArenaTeam->LoadMembersFromDB(result2))
        {
            newArenaTeam->Disband(NULL);
            delete newArenaTeam;
            continue;
        }

        AddArenaTeam(newArenaTeam);

        ++count;
    }
    while(result->NextRow());

    sLog->outString(">> Loaded %u arena teams in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void ArenaTeamMgr::DistributeArenaPoints()
{
    // Used to distribute arena points based on last week's stats
    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_START);

    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_ONLINE_START);

    // Temporary structure for storing maximum points to add values for all players
    std::map<uint32, uint32> PlayerPoints;

    // At first update all points for all team members
    for(ArenaTeamContainer::iterator teamItr = GetArenaTeamMapBegin(); teamItr != GetArenaTeamMapEnd(); ++teamItr)
        if(ArenaTeam * at = teamItr->second)
            at->UpdateArenaPointsHelper(PlayerPoints);

    // Cycle that gives points to all players
    for(std::map<uint32, uint32>::iterator playerItr = PlayerPoints.begin(); playerItr != PlayerPoints.end(); ++playerItr)
    {
        // Update database
        CharacterDatabase.PExecute("UPDATE characters SET arenaPoints = arenaPoints + '%u' WHERE `guid` = '%u'", playerItr->second, playerItr->first);

        // Add points to player if online
        Player* pl = sObjectMgr->GetPlayer(playerItr->first);
        if(pl)
            pl->ModifyArenaPoints(playerItr->second);
    }

    PlayerPoints.clear();

    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_ONLINE_END);

    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_TEAM_START);
    for(ArenaTeamContainer::iterator titr = GetArenaTeamMapBegin(); titr != GetArenaTeamMapEnd(); ++titr)
    {
        if(ArenaTeam * at = titr->second)
        {
            at->FinishWeek();
            at->SaveToDB();
            at->NotifyStatsChanged();
        }
    }

    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_TEAM_END);

    sWorld->SendWorldText(LANG_DIST_ARENA_POINTS_END);
}

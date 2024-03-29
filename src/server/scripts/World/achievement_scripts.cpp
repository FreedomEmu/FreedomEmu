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

#include "BattlegroundAB.h"
#include "BattlegroundWS.h"
#include "BattlegroundIC.h"
#include "BattlegroundSA.h"
#include "BattlegroundAV.h"

class achievement_everything_counts : public AchievementCriteriaScript
{
    public:
        achievement_everything_counts() : AchievementCriteriaScript("achievement_everything_counts") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if(!bg)
                return false;

            if(source->GetBattlegroundTypeId() != BATTLEGROUND_AV)
                return false;

            if(static_cast<BattlegroundAV*>(bg)->IsBothMinesControlledByTeam(source->GetTeam()))
                return true;

            return false;
        }
};

class achievement_bg_av_perfection : public AchievementCriteriaScript
{
    public:
        achievement_bg_av_perfection() : AchievementCriteriaScript("achievement_bg_av_perfection") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if(!bg)
                return false;

            if(source->GetBattlegroundTypeId() != BATTLEGROUND_AV)
                return false;

            if(static_cast<BattlegroundAV*>(bg)->IsAllTowersControlledAndCaptainAlive(source->GetTeam()))
                return true;

            return false;
        }
};

class achievement_storm_glory : public AchievementCriteriaScript
{
    public:
        achievement_storm_glory() : AchievementCriteriaScript("achievement_storm_glory") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(source->GetBattlegroundTypeId() != BATTLEGROUND_EY)
                return false;

            Battleground *pEotS = source->GetBattleground();
            if(!pEotS)
                return false;

            return pEotS->IsAllNodesConrolledByTeam(source->GetTeam());
        }
};

class achievement_resilient_victory : public AchievementCriteriaScript
{
    public:
        achievement_resilient_victory() : AchievementCriteriaScript("achievement_resilient_victory") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if(!bg)
                return false;

            if(bg->GetTypeID(true) != BATTLEGROUND_AB)
                return false;

            if(!static_cast<BattlegroundAB*>(bg)->IsTeamScores500Disadvantage(source->GetTeam()))
                return false;

            return true;
        }
};

class achievement_bg_control_all_nodes : public AchievementCriteriaScript
{
    public:
        achievement_bg_control_all_nodes() : AchievementCriteriaScript("achievement_bg_control_all_nodes") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            if(!bg)
                return false;

            if(!bg->IsAllNodesConrolledByTeam(source->GetTeam()))
                return false;

            return true;
        }
};

class achievement_save_the_day : public AchievementCriteriaScript
{
    public:
        achievement_save_the_day() : AchievementCriteriaScript("achievement_save_the_day") { }

        bool OnCheck(Player* source, Unit* target)
        {
            if(!target)
                return false;

            if(Player const* player = target->ToPlayer())
            {
                if(source->GetBattlegroundTypeId() != BATTLEGROUND_WS || !source->GetBattleground())
                    return false;

                BattlegroundWS* pWSG = static_cast<BattlegroundWS*>(source->GetBattleground());
                if(pWSG->GetFlagState(player->GetTeam()) == BG_WS_FLAG_STATE_ON_BASE)
                    return true;
            }
            return false;
        }
};

class achievement_bg_ic_resource_glut : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_resource_glut() : AchievementCriteriaScript("achievement_bg_ic_resource_glut") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(source->HasAura(SPELL_OIL_REFINERY) && source->HasAura(SPELL_QUARRY))
                return true;

            return false;
        }
};

class achievement_bg_ic_glaive_grave : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_glaive_grave() : AchievementCriteriaScript("achievement_bg_ic_glaive_grave") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if(vehicle->GetEntry() == NPC_GLAIVE_THROWER_H ||  vehicle->GetEntry() == NPC_GLAIVE_THROWER_A)
                    return true;
            }

            return false;
        }
};

class achievement_bg_ic_mowed_down : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_mowed_down() : AchievementCriteriaScript("achievement_bg_ic_mowed_down") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if(vehicle->GetEntry() == NPC_KEEP_CANNON)
                    return true;
            }

            return false;
        }
};

class achievement_bg_sa_artillery : public AchievementCriteriaScript
{
    public:
        achievement_bg_sa_artillery() : AchievementCriteriaScript("achievement_bg_sa_artillery") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(Creature* vehicle = source->GetVehicleCreatureBase())
            {
                if(vehicle->GetEntry() == NPC_ANTI_PERSONNAL_CANNON)
                    return true;
            }

            return false;
        }
};

class achievement_arena_kills : public AchievementCriteriaScript
{
    public:
        achievement_arena_kills(char const* name, uint8 arenaType) : AchievementCriteriaScript(name),
            _arenaType(arenaType) { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if(!source->InArena())
                return false;

            return source->GetBattleground()->GetArenaType() == _arenaType;
        }

    private:
        uint8 const _arenaType;
};

class achievement_sickly_gazelle : public AchievementCriteriaScript
{
public:
    achievement_sickly_gazelle() : AchievementCriteriaScript("achievement_sickly_gazelle") { }

    bool OnCheck(Player* /*pSource*/, Unit* target)
    {
        if(!target)
            return false;

        if(Player* victim = target->ToPlayer())
            if(victim->IsMounted())
                return true;

        return false;
    }
};

class achievement_bg_ab_letsgetthisdone : public AchievementCriteriaScript
{
public:
    achievement_bg_ab_letsgetthisdone() : AchievementCriteriaScript("achievement_bg_ab_letsgetthisdone") { }

    bool OnCheck(Player* pSource, Unit* /*pTarget*/)
    {
        Battleground* pBg = pSource->GetBattleground();
        if(!pBg && pBg->GetTypeID(true) != BATTLEGROUND_AB && static_cast<BattlegroundAB*>(pBg)->m_TimerAchievementLetsGetThisDone <= 0)
            return false;

        if((static_cast<BattlegroundAB*>(pBg)->GetWinner() == 1 && pSource->GetTeam() == 469) || (static_cast<BattlegroundAB*>(pBg)->GetWinner() == 0 && pSource->GetTeam() == 67)) {
            if(AchievementEntry const* pAchievement = GetAchievementStore()->LookupEntry(159))
                pSource->CompletedAchievement(pAchievement);
            return true;
        }

        return false;
    }
};

void AddSC_achievement_scripts()
{
    new achievement_storm_glory;
    new achievement_resilient_victory;
    new achievement_bg_control_all_nodes;
    new achievement_save_the_day;
    new achievement_bg_ic_resource_glut;
    new achievement_bg_ic_glaive_grave;
    new achievement_bg_ic_mowed_down;
    new achievement_bg_sa_artillery;
    new achievement_sickly_gazelle;
    new achievement_everything_counts;
    new achievement_bg_av_perfection;
    new achievement_arena_kills("achievement_arena_2v2_kills", ARENA_TYPE_2v2);
    new achievement_arena_kills("achievement_arena_3v3_kills", ARENA_TYPE_3v3);
    new achievement_arena_kills("achievement_arena_5v5_kills", ARENA_TYPE_5v5);
    new achievement_bg_ab_letsgetthisdone;
}

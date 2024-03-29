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

#ifndef __BATTLEGROUNDRV_H
#define __BATTLEGROUNDRV_H

class Battleground;

enum BattlegroundRVObjectTypes
{
    BG_RV_OBJECT_BUFF_1,
    BG_RV_OBJECT_BUFF_2,
    BG_RV_OBJECT_FIRE_1,
    BG_RV_OBJECT_FIRE_2,
    BG_RV_OBJECT_FIREDOOR_1,
    BG_RV_OBJECT_FIREDOOR_2,

    BG_RV_OBJECT_PILLAR_1,
    BG_RV_OBJECT_PILLAR_3,
    BG_RV_OBJECT_GEAR_1,
    BG_RV_OBJECT_GEAR_2,

    BG_RV_OBJECT_PILLAR_2,
    BG_RV_OBJECT_PILLAR_4,
    BG_RV_OBJECT_PULLEY_1,
    BG_RV_OBJECT_PULLEY_2,

    BG_RV_OBJECT_PILLAR_COLLISION_1,
    BG_RV_OBJECT_PILLAR_COLLISION_2,
    BG_RV_OBJECT_PILLAR_COLLISION_3,
    BG_RV_OBJECT_PILLAR_COLLISION_4,

    BG_RV_OBJECT_ELEVATOR_1,
    BG_RV_OBJECT_ELEVATOR_2,
    BG_RV_OBJECT_MAX,
};

enum BattlegroundRVObjects
{
    BG_RV_OBJECT_TYPE_BUFF_1                     = 184663,
    BG_RV_OBJECT_TYPE_BUFF_2                     = 184664,
    BG_RV_OBJECT_TYPE_FIRE_1                     = 192704,
    BG_RV_OBJECT_TYPE_FIRE_2                     = 192705,

    BG_RV_OBJECT_TYPE_FIREDOOR_2                 = 192387,
    BG_RV_OBJECT_TYPE_FIREDOOR_1                 = 192388,
    BG_RV_OBJECT_TYPE_PULLEY_1                   = 192389,
    BG_RV_OBJECT_TYPE_PULLEY_2                   = 192390,
    BG_RV_OBJECT_TYPE_GEAR_1                     = 192393,
    BG_RV_OBJECT_TYPE_GEAR_2                     = 192394,
    BG_RV_OBJECT_TYPE_ELEVATOR_1                 = 194582,
    BG_RV_OBJECT_TYPE_ELEVATOR_2                 = 194586,

    BG_RV_OBJECT_TYPE_PILLAR_COLLISION_1         = 194580, // axe
    BG_RV_OBJECT_TYPE_PILLAR_COLLISION_2         = 194579, // arena
    BG_RV_OBJECT_TYPE_PILLAR_COLLISION_3         = 194581, // lightning
    BG_RV_OBJECT_TYPE_PILLAR_COLLISION_4         = 194578, // ivory

    BG_RV_OBJECT_TYPE_PILLAR_1                   = 194583, // axe
    BG_RV_OBJECT_TYPE_PILLAR_2                   = 194584, // arena
    BG_RV_OBJECT_TYPE_PILLAR_3                   = 194585, // lightning
    BG_RV_OBJECT_TYPE_PILLAR_4                   = 194587, // ivory
};

enum BattlegroundRVData
{
    BG_RV_STATE_OPEN_FENCES,
    BG_RV_STATE_OPEN_PILLARS,
    BG_RV_STATE_CLOSE_PILLARS,
    BG_RV_STATE_OPEN_FIRE,
    BG_RV_STATE_CLOSE_FIRE,
    BG_RV_FIRE_TO_PILLAR_TIMER                   = 20000,
    BG_RV_PILLAR_TO_FIRE_TIMER                   = 5000,
    BG_RV_FIRST_TIMER                            = 20133,
    BG_RV_WORLD_STATE_A                          = 0xe10,
    BG_RV_WORLD_STATE_H                          = 0xe11,
    BG_RV_WORLD_STATE                            = 0xe1a,
};

#define BG_RV_PILLAR_SMALL_RADIUS  2.0f
#define BG_RV_PILLAR_SMALL_HEIGHT  5.0f
#define BG_RV_PILLAR_BIG_RADIUS    4.0f
#define BG_RV_PILLAR_BIG_HEIGHT    8.25f

class BattlegroundRVScore : public BattlegroundScore
{
    public:
        BattlegroundRVScore() { };
        virtual ~BattlegroundRVScore() { };
};

class BattlegroundRV : public Battleground
{
    friend class BattlegroundMgr;
    public:
        BattlegroundRV();
        ~BattlegroundRV();
        void Update(uint32 diff);

        /* inherited from BattlegroundClass */
        virtual void AddPlayer(Player* plr);
        virtual void StartingEventCloseDoors();
        virtual void StartingEventOpenDoors();
        virtual void Reset();
        virtual void FillInitialWorldStates(WorldPacket &d);

        void RemovePlayer(Player* plr, uint64 guid, uint32 team);
        void HandleAreaTrigger(Player* Source, uint32 Trigger);
        bool SetupBattleground();
        void HandleKillPlayer(Player* player, Player* killer);
        bool HandlePlayerUnderMap(Player* plr);
    private:
        uint32 Timer;
        uint32 State;
        bool   PillarCollision;

    protected:
        uint32 m_DynLos[4];
        uint32 getTimer() { return Timer; };
        void setTimer(uint32 timer) { Timer = timer; };

        uint32 getState() { return State; };
        void setState(uint32 state) { State = state; };
        void TogglePillarCollision();
        bool GetPillarCollision() { return PillarCollision; }
        void SetPillarCollision(bool apply) { PillarCollision = apply; }
};
#endif

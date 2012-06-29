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

#include "Creature.h"
#include "MapManager.h"
#include "Opcodes.h"
#include "ConfusedMovementGenerator.h"
#include "DestinationHolderImp.h"
#include "VMapFactory.h"

#ifdef MAP_BASED_RAND_GEN
#define rand_norm() unit.rand_norm()
#define urand(a, b) unit.urand(a, b)
#endif

template<class T>
void ConfusedMovementGenerator<T>::Initialize(T &unit)
{
    const float wander_distance = 3;
    float x, y, z;
    x = unit.GetPositionX();
    y = unit.GetPositionY();
    z = unit.GetPositionZ();

    Map const* map = unit.GetBaseMap();

    i_nextMove = 1;

    bool is_water_ok, is_land_ok;
    _InitSpecific(unit, is_water_ok, is_land_ok);

    for(uint8 idx = 0; idx <= MAX_CONF_WAYPOINTS; ++idx)
    {
        float wanderX = x + wander_distance*(float)rand_norm() - wander_distance/2;
        float wanderY = y + wander_distance*(float)rand_norm() - wander_distance/2;
        Trinity::NormalizeMapCoord(wanderX);
        Trinity::NormalizeMapCoord(wanderY);

        if (unit.IsWithinLOS(wanderX, wanderY, z))
        {
            bool is_water = map->IsInWater(wanderX, wanderY, z);

            if ((is_water && !is_water_ok) || (!is_water && !is_land_ok))
            {
                //! Cannot use coordinates outside our InhabitType. Use the current or previous position.
                wanderX = idx > 0 ? i_waypoints[idx-1][0] : x;
                wanderY = idx > 0 ? i_waypoints[idx-1][1] : y;
            }
        }
        else
        {
            //! Trying to access path outside line of sight. Skip this by using the current or previous position.
            wanderX = idx > 0 ? i_waypoints[idx-1][0] : x;
            wanderY = idx > 0 ? i_waypoints[idx-1][1] : y;
        }

        unit.UpdateAllowedPositionZ(wanderX, wanderY, z);

        //! Positions are fine - apply them to this waypoint
        i_waypoints[idx][0] = wanderX;
        i_waypoints[idx][1] = wanderY;
        i_waypoints[idx][2] = z;
    }

    unit.SetTarget(0);
    unit.SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_CONFUSED);
    unit.CastStop();
    unit.StopMoving();
    unit.RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
    unit.AddUnitState(UNIT_STAT_CONFUSED);
}

template<>
void ConfusedMovementGenerator<Creature>::_InitSpecific(Creature &creature, bool &is_water_ok, bool &is_land_ok)
{
    is_water_ok = creature.canSwim();
    is_land_ok  = creature.canWalk();
}

template<>
void ConfusedMovementGenerator<Player>::_InitSpecific(Player &, bool &is_water_ok, bool &is_land_ok)
{
    is_water_ok = true;
    is_land_ok  = true;
}

template<class T>
void ConfusedMovementGenerator<T>::Reset(T &unit)
{
    i_nextMove = 1;
    i_nextMoveTime.Reset(0);
    i_destinationHolder.ResetUpdate();
    unit.StopMoving();
}

template<class T>
bool ConfusedMovementGenerator<T>::Update(T &unit, const uint32 &diff)
{
    if(!&unit)
        return true;

    if(unit.HasUnitState(UNIT_STAT_ROOT | UNIT_STAT_STUNNED | UNIT_STAT_DISTRACTED))
        return true;

    if(i_nextMoveTime.Passed())
    {
        // currently moving, update location
        Traveller<T> traveller(unit);
        if(i_destinationHolder.UpdateTraveller(traveller, diff))
        {
            if(i_destinationHolder.HasArrived())
            {
                // arrived, stop and wait a bit
                unit.ClearUnitState(UNIT_STAT_MOVE);

                i_nextMove = urand(1, MAX_CONF_WAYPOINTS);
                i_nextMoveTime.Reset(urand(0, 1500-1));     // TODO: check the minimum reset time, should be probably higher
            }
        }
    }
    else
    {
        // waiting for next move
        i_nextMoveTime.Update(diff);
        if(i_nextMoveTime.Passed())
        {
            // start moving
            ASSERT(i_nextMove <= MAX_CONF_WAYPOINTS);
            const float x = i_waypoints[i_nextMove][0];
            const float y = i_waypoints[i_nextMove][1];
            const float z = i_waypoints[i_nextMove][2];
            Traveller<T> traveller(unit);
            i_destinationHolder.SetDestination(traveller, x, y, z);
        }
    }
    return true;
}

template<class T>
void ConfusedMovementGenerator<T>::Finalize(T &unit)
{
    unit.RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_CONFUSED);
    unit.ClearUnitState(UNIT_STAT_CONFUSED);
    if(unit.GetTypeId() == TYPEID_UNIT && unit.getVictim())
        unit.SetTarget(unit.getVictim()->GetGUID());
}

template void ConfusedMovementGenerator<Player>::Initialize(Player &player);
template void ConfusedMovementGenerator<Creature>::Initialize(Creature &creature);
template void ConfusedMovementGenerator<Player>::Finalize(Player &player);
template void ConfusedMovementGenerator<Creature>::Finalize(Creature &creature);
template void ConfusedMovementGenerator<Player>::Reset(Player &player);
template void ConfusedMovementGenerator<Creature>::Reset(Creature &creature);
template bool ConfusedMovementGenerator<Player>::Update(Player &player, const uint32 &diff);
template bool ConfusedMovementGenerator<Creature>::Update(Creature &creature, const uint32 &diff);
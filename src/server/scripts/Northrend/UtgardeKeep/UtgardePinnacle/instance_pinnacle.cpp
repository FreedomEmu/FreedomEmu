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
#include "utgarde_pinnacle.h"

#define MAX_ENCOUNTER     4

/* Utgarde Pinnacle encounters:
0 - Svala Sorrowgrave
1 - Gortok Palehoof
2 - Skadi the Ruthless
3 - King Ymiron
*/

enum GameObjects
{
    ENTRY_SKADI_THE_RUTHLESS_DOOR                 = 192173,
    ENTRY_KING_YMIRON_DOOR                        = 192174,
    ENTRY_GORK_PALEHOOF_SPHERE                    = 188593
};

class instance_utgarde_pinnacle : public InstanceMapScript
{
public:
    instance_utgarde_pinnacle() : InstanceMapScript("instance_utgarde_pinnacle", 575) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_pinnacle(pMap);
    }

    struct instance_pinnacle : public InstanceScript
    {
        instance_pinnacle(Map* pMap) : InstanceScript(pMap) { }

        uint64 uiSvalaSorrowgrave;
        uint64 uiGortokPalehoof;
        uint64 uiSkadiTheRuthless;
        uint64 uiGrauf;
        uint64 uiKingYmiron;

        uint64 uiSkadiTheRuthlessDoor;
        uint64 uiKingYmironDoor;
        uint64 uiGortokPalehoofSphere;

        uint64 uiFrenziedWorgen;
        uint64 uiRavenousFurbolg;
        uint64 uiFerociousRhino;
        uint64 uiMassiveJormungar;
        uint64 uiPalehoofOrb;
        uint64 uiRitualTarget;

        uint64 uiSvala;
        uint64 uiSacrificedPlayer;
        uint64 uiFlameBrazier_1;
        uint64 uiFlameBrazier_2;

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        uint64 uiDoodad_Utgarde_Mirror_FX01;

        std::string str_data;

        void Initialize()
        {
            uiFlameBrazier_1 = 0;
            for(uint8 i = 0; i < MAX_ENCOUNTER; ++i)
               m_auiEncounter[i] = NOT_STARTED;

            uiSacrificedPlayer = 0;
        }

        bool IsEncounterInProgress() const
        {
            for(uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if(m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case 26668:    uiSvalaSorrowgrave = creature->GetGUID();               break;
                case 26687:    uiGortokPalehoof = creature->GetGUID();                 break;
                case 26693:    uiSkadiTheRuthless = creature->GetGUID();               break;
                case 26893:    uiGrauf = creature->GetGUID();                          break;
                case 26861:    uiKingYmiron = creature->GetGUID();                     break;
                case 26683:    uiFrenziedWorgen = creature->GetGUID();                 break;
                case 26684:    uiRavenousFurbolg = creature->GetGUID();                break;
                case 26685:    uiMassiveJormungar = creature->GetGUID();               break;
                case 26686:    uiFerociousRhino = creature->GetGUID();                 break;
                case 29281:    uiSvala = creature->GetGUID();                          break;
                case 26688:    uiPalehoofOrb = creature->GetGUID();                    break;
                case 27273:
                    (uiFlameBrazier_1 ? uiFlameBrazier_2 : uiFlameBrazier_1) =  creature->GetGUID();
                                                                                        break;
                case 27327:    uiRitualTarget = creature->GetGUID();                   break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch(go->GetEntry())
            {
                case ENTRY_SKADI_THE_RUTHLESS_DOOR:
                    uiSkadiTheRuthlessDoor = go->GetGUID();
                    if(m_auiEncounter[2] == DONE) HandleGameObject(0, true, go);
                    break;
                case ENTRY_KING_YMIRON_DOOR:
                    uiKingYmironDoor = go->GetGUID();
                    if(m_auiEncounter[3] == DONE) HandleGameObject(0, true, go);
                    break;
                case ENTRY_GORK_PALEHOOF_SPHERE:
                    uiGortokPalehoofSphere = go->GetGUID();
                    if(m_auiEncounter[1] == DONE)
                    {
                        HandleGameObject(0, true, go);
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    break;
                case 191745:
                    uiDoodad_Utgarde_Mirror_FX01 = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_SVALA_SORROWGRAVE_EVENT:
                    m_auiEncounter[0] = data;
                    break;
                case DATA_GORTOK_PALEHOOF_EVENT:
                    m_auiEncounter[1] = data;
                    break;
                case DATA_SKADI_THE_RUTHLESS_EVENT:
                    if(data == DONE)
                        HandleGameObject(uiSkadiTheRuthlessDoor, true);
                    m_auiEncounter[2] = data;
                    break;
                case DATA_KING_YMIRON_EVENT:
                    if(data == DONE)
                        HandleGameObject(uiKingYmironDoor, true);
                    m_auiEncounter[3] = data;
                    break;
            }

            if(data == DONE)
                SaveToDB();
        }

        void SetData64(uint32 type, uint64 data)
        {
            switch (type)
            {
                case DATA_SACRIFICED_PLAYER:
                    uiSacrificedPlayer = data;
                    break;
            }
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
                case DATA_SVALA_SORROWGRAVE_EVENT:        return m_auiEncounter[0];
                case DATA_GORTOK_PALEHOOF_EVENT:          return m_auiEncounter[1];
                case DATA_SKADI_THE_RUTHLESS_EVENT:       return m_auiEncounter[2];
                case DATA_KING_YMIRON_EVENT:              return m_auiEncounter[3];
            }
            return 0;
        }

        uint64 GetData64(uint32 identifier)
        {
            switch(identifier)
            {
                case DATA_SVALA_SORROWGRAVE:      return uiSvalaSorrowgrave;
                case DATA_GORTOK_PALEHOOF:        return uiGortokPalehoof;
                case DATA_SKADI_THE_RUTHLESS:     return uiSkadiTheRuthless;
                case DATA_GRAUF:                       return uiGrauf;
                case DATA_KING_YMIRON:            return uiKingYmiron;
                case DATA_MOB_FRENZIED_WORGEN:    return uiFrenziedWorgen;
                case DATA_MOB_RAVENOUS_FURBOLG:   return uiRavenousFurbolg;
                case DATA_MOB_MASSIVE_JORMUNGAR:  return uiMassiveJormungar;
                case DATA_MOB_FEROCIOUS_RHINO:    return uiFerociousRhino;
                case DATA_MOB_ORB:                return uiPalehoofOrb;
                case DATA_SVALA:                  return uiSvala;
                case DATA_GORTOK_PALEHOOF_SPHERE: return uiGortokPalehoofSphere;
                case DATA_FLAME_BRAZIER_1:             return uiFlameBrazier_1;
                case DATA_FLAME_BRAZIER_2:             return uiFlameBrazier_2;
                case DATA_DOODAD_UTGARDE_MIRROR_FX01:  return uiDoodad_Utgarde_Mirror_FX01;
                case DATA_RITUAL_TARGET:               return uiRitualTarget;
                case DATA_SACRIFICED_PLAYER:      return uiSacrificedPlayer;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "U P " << m_auiEncounter[0] << " " << m_auiEncounter[1] << " "
                << m_auiEncounter[2] << " " << m_auiEncounter[3];

            str_data = saveStream.str();

            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in)
        {
            if(!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0, data1, data2, data3;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if(dataHead1 == 'U' && dataHead2 == 'K')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                m_auiEncounter[3] = data3;

                for(uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if(m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_utgarde_pinnacle()
{
    new instance_utgarde_pinnacle;
}

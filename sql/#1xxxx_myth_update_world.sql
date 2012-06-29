/* Copyright (C) 2010 - 2012 Myth Project <https://bitbucket.org/MythProject/myth-core>
 *
 * Myth Project's source is based on the Trinity Project source, you can find the
 * link to that easily in Trinity Copyrights. Myth Project is a private community.
 * To get access, you either have to donate or pass a developer test.
 * You can't share Myth Project's sources! Only for personal use. */
-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "World" Database Update ------------------
-- -------------------------------------------------------------------------{
 TRUNCATE `version`;
INSERT INTO `version` VALUES (NULL, NULL,"MythDB v12.26","MythAI v12.26", 604);
-- -------------------------------------------------------------------------}
-- ---------------------------- Icecrown Citadel ---------------------------
-- -------------------------------------------------------------------------{
-- NPC: Big Ooze, http://old.wowhead.com/npc=36899
-- NPC: Gas Cloud, http://old.wowhead.com/npc=37562
-- NPC: Volatile Ooze, http://old.wowhead.com/npc=37697
-- NPC: Little Ooze, http://old.wowhead.com/npc=36897
-- NPC: Precious, http://old.wowhead.com/npc=37217
-- NPC: Stinky, http://old.wowhead.com/npc=37025
UPDATE `creature_template` SET `mechanic_immune_mask` = 667631615 WHERE `entry` IN (36899, 37562, 37697, 36897, 37217, 37025);
-- -------------------------------------------------------------------------}
-- -------------------------------- Ulduar ---------------------------------
-- -------------------------------------------------------------------------{
-- NPC: Algalon, http://old.wowhead.com/npc=32871
-- Achievment: Observed (10 player), http://www.wowhead.com/achievement=3036
-- Achievment: Observed (25 player), http://www.wowhead.com/achievement=3037
DELETE FROM achievement_criteria_data WHERE `criteria_id` IN (10567, 10569) AND `type` = 1;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 and `SourceEntry` = 65184;
INSERT INTO `conditions` VALUES (13, 0, 65184, 0, 18, 1, 0, 0, 0,'','Algalon KC: target player');
-- -------------------------------------------------------------------------}
-- --------------------------- Vault of Archavon ---------------------------
-- -------------------------------------------------------------------------{
-- NPC: Toravon the Ice Watcher, http://old.wowhead.com/npc=38462
DELETE FROM `creature_loot_template` WHERE `entry` = 38462;
INSERT INTO `creature_loot_template` VALUES
 (38462, 51364, 1.4, 1, 4, 1, 1),   (38462, 44083, 2, 1, 0, 1, 1),  (38462, 51351, 1.4, 1, 4, 1, 1),    (38462, 51512, 1.66, 1, 3, 1, 1),
 (38462, 51504, 1.66, 1, 3, 1, 1),  (38462, 51488, 2.5, 1, 3, 1, 1),(38462, 51366, 1.4, 1, 4, 1, 1),    (38462, 51493, 5, 1, 3, 1, 1),
 (38462, 51336, 1.4, 1, 4, 1, 1),   (38462, 51350, 1.4, 1, 4, 1, 1),(38462, 51506, 1.66, 1, 3, 1, 1),   (38462, 51367, 1.4, 1, 4, 1, 1),
 (38462, 51328, 1.4, 1, 4, 1, 1),   (38462, 51537, 5, 1, 3, 1, 1),  (38462, 51510, 1.66, 1, 3, 1, 1),   (38462, 51498, 1.66, 1, 3, 1, 1),
 (38462, 51217, 5, 1, 2, 1, 1),     (38462, 51209, 10, 1, 2, 1, 1), (38462, 51500, 1.66, 1, 3, 1, 1),   (38462, 51213, 5, 1, 2, 1, 1),
 (38462, 51207, 10, 1, 2, 1, 1),    (38462, 51539, 5, 1, 3, 1, 1),  (38462, 51544, 5, 1, 3, 1, 1),      (38462, 51211, 1.4, 1, 2, 1, 1),
 (38462, 51216, 5, 1, 2, 1, 1),     (38462, 51475, 2.5, 1, 3, 1, 1),(38462, 51477, 2.5, 1, 3, 1, 1),    (38462, 51469, 2.5, 1, 3, 1, 1),
 (38462, 51485, 2.5, 1, 3, 1, 1),   (38462, 51471, 2.5, 1, 3, 1, 1),(38462, 51459, 5, 1, 3, 1, 1),      (38462, 51360, 1.4, 1, 4, 1, 1),
 (38462, 51422, 1.66, 1, 3, 1, 1),  (38462, 51352, 1.4, 1, 4, 1, 1),(38462, 51414, 5, 1, 3, 1, 1),      (38462, 51461, 5, 1, 3, 1, 1),
 (38462, 51466, 5, 1, 3, 1, 1),     (38462, 51434, 1.66, 1, 3, 1, 1),
 (38462, 51416, 5, 1, 3, 1, 1),     (38462, 51420, 1.66, 1, 3, 1, 1),
 (38462, 51483, 2.5, 1, 3, 1, 1),   (38462, 51426, 1.66, 1, 3, 1, 1),
 (38462, 51464, 5, 1, 3, 1, 1),     (38462, 51428, 1.66, 1, 3, 1, 1),
 (38462, 51542, 1.4, 1, 3, 1, 1),   (38462, 51495, 5, 1, 3, 1, 1),  (38462, 51436, 1.66, 1, 3, 1, 1),   (38462, 51363, 1.4, 1, 4, 1, 1),
 (38462, 51490, 2.5, 1, 3, 1, 1),   (38462, 51132, 5, 1, 1, 1, 1),  (38462, 51128, 5, 1, 1, 1, 1),      (38462, 51131, 5, 1, 1, 1, 1),
 (38462, 51126, 5, 1, 1, 1, 1),     (38462, 51146, 3.33, 1, 1, 1, 1),
 (38462, 51136, 3.33, 1, 1, 1, 1),  (38462, 51148, 3.33, 1, 1, 1, 1),
 (38462, 51138, 3.33, 1, 1, 1, 1),  (38462, 51142, 3.33, 1, 1, 1, 1),
 (38462, 51144, 3.33, 1, 1, 1, 1),  (38462, 51152, 10, 1, 1, 1, 1), (38462, 51154, 10, 1, 1, 1, 1),     (38462, 51159, 10, 1, 1, 1, 1),
 (38462, 51169, 3.33, 1, 1, 1, 1),  (38462, 51157, 10, 1, 1, 1, 1), (38462, 51163, 3.33, 1, 1, 1, 1),   (38462, 51168, 3.33, 1, 1, 1, 1),
 (38462, 51171, 3.33, 1, 1, 1, 1),  (38462, 51161, 1.4, 1, 1, 1, 1),
 (38462, 51172, 3.33, 1, 1, 1, 1),  (38462, 51179, 5, 1, 2, 1, 1),  (38462, 51183, 5, 1, 2, 1, 1),      (38462, 51181, 5, 1, 2, 1, 1),
 (38462, 51177, 5, 1, 2, 1, 1),     (38462, 51196, 3.33, 1, 2, 1, 1),
 (38462, 51203, 3.33, 1, 2, 1, 1),  (38462, 51191, 3.33, 1, 2, 1, 1),
 (38462, 51188, 10, 1, 2, 1, 1),    (38462, 51201, 3.33, 1, 2, 1, 1),
 (38462, 51186, 10, 1, 2, 1, 1),    (38462, 51198, 3.33, 1, 2, 1, 1),
 (38462, 51193, 3.33, 1, 2, 1, 1),  (38462, 51341, 1.4, 1, 4, 1, 1),(38462, 51375, 1.4, 1, 4, 1, 1),    (38462, 51345, 1.4, 1, 4, 1, 1),
 (38462, 51342, 1.4, 1, 4, 1, 1),   (38462, 51348, 1.4, 1, 4, 1, 1),(38462, 51332, 1.4, 1, 4, 1, 1),    (38462, 51362, 1.4, 1, 4, 1, 1),
 (38462, 51327, 1.4, 1, 4, 1, 1),   (38462, 51370, 1.4, 1, 4, 1, 1),(38462, 51359, 1.4, 1, 4, 1, 1),    (38462, 51368, 1.4, 1, 4, 1, 1),
 (38462, 51369, 1.4, 1, 4, 1, 1),   (38462, 51333, 1.4, 1, 4, 1, 1),(38462, 51353, 1.4, 1, 4, 1, 1),    (38462, 51365, 1.4, 1, 4, 1, 1),
 (38462, 51356, 1.4, 1, 4, 1, 1),   (38462, 51340, 1.4, 1, 4, 1, 1),(38462, 51374, 1.4, 1, 4, 1, 1),    (38462, 51355, 1.4, 1, 4, 1, 1),
 (38462, 51358, 1.4, 1, 4, 1, 1),   (38462, 51372, 1.4, 1, 4, 1, 1),(38462, 51371, 1.4, 1, 4, 1, 1),    (38462, 51373, 1.4, 1, 4, 1, 1),
 (38462, 51343, 1.4, 1, 4, 1, 1),   (38462, 51331, 1.4, 1, 4, 1, 1),(38462, 51349, 1.4, 1, 4, 1, 1),    (38462, 51334, 1.4, 1, 4, 1, 1),
 (38462, 51330, 1.4, 1, 4, 1, 1),   (38462, 51354, 1.4, 1, 4, 1, 1),(38462, 51357, 1.4, 1, 4, 1, 1),    (38462, 51329, 1.4, 1, 4, 1, 1),
 (38462, 51361, 1.4, 1, 4, 1, 1),   (38462, 51344, 1.4, 1, 4, 1, 1),(38462, 51376, 1.4, 1, 4, 1, 1),    (38462, 51347, 1.4, 1, 4, 1, 1),
 (38462, 51346, 1.4, 1, 4, 1, 1),   (38462, 51335, 1.4, 1, 4, 1, 1),(38462, 43959, 2, 1, 0, 1, 1),      (38462, 49426, 100, 1, 0, 2, 2);
-- -------------------------------------------------------------------------}
-- -------------------------- Blackrock Depths -----------------------------
-- -------------------------------------------------------------------------{
-- NPC: Coren Direbrew, http://old.wowhead.com/npc=23872
DELETE FROM `creature_loot_template` WHERE `entry` = 23872;
INSERT INTO `creature_loot_template` VALUES
 (23872, 38280, 100, 1, 0, 1, 1),
 (23872, 38281, 100, 1, 0, 1, 1),
 (23872, 49074, 17, 1, 1, 1, 1),
 (23872, 49076, 17, 1, 1, 1, 1),
 (23872, 49078, 17, 1, 1, 1, 1),
 (23872, 49080, 17, 1, 1, 1, 1),
 (23872, 49116, 16, 1, 1, 1, 1),
 (23872, 49118, 16, 1, 1, 1, 1);
-- -------------------------------------------------------------------------}
-- -------------------------- Blackrock Spire ------------------------------
-- -------------------------------------------------------------------------{
-- GO: Urok's Tribute Pile o:175621 (spellfocus) correct placement
DELETE FROM `gameobject` WHERE `guid` = 71671;
INSERT INTO `gameobject` VALUES (71671, 175621, 229, 1, 1, -29.2666, -379.26, 48.7189, 3.22672, 0, 0, 0.444111, -0.895972, 43200, 0, 1);
-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "Achievements" Update --------------------
-- -------------------------------------------------------------------------{
-- Achievement: Spring Fling, http://old.wowhead.com/achievement=2497
-- NPC: Spring Rabbit, http://old.wowhead.com/npc=32791
UPDATE `creature_template` SET `ScriptName` = 'npc_spring_rabbit' WHERE `entry` = 32791;
-- Achievement: Noble Garden (Aliance), http://old.wowhead.com/achievement=2421
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 9123 AND `type` IN (6, 14);
-- Achievement: Lightning Struck, http://old.wowhead.com/achievement=1834
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 6835;
INSERT INTO `achievement_criteria_data`(`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
 (6835, 12, 1, 0, ''),
 (6835, 7, 52092, 0, '');
-- NPC: General Bjarngrim, http://old.wowhead.com/npc=28586
UPDATE `creature_addon` SET `auras` = '' WHERE `guid` = 115219;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -52098 AND `spell_effect` = 52092;
INSERT INTO `spell_linked_spell`(`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
 (-52098, 52092, 0, 'Charge Up - Temporary Electrical Charge');
UPDATE `waypoint_data` SET `delay` = 10000 WHERE `id` = 115219 AND `point` IN (2, 5, 11, 14);
UPDATE `waypoint_data` SET `action` = 11521901 WHERE `id` = 115219 AND `point` IN (5, 14);
UPDATE `waypoint_data` SET `action` = 11521902 WHERE `id` = 115219 AND `point` IN (2, 3, 4, 11, 12, 13);
DELETE FROM `waypoint_scripts` WHERE `id` = 11521901;
INSERT INTO `waypoint_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`guid`) VALUES
 (11521901, 0, 14, 52092, 1, 0, 0, 0, 0, 0, 3000),
 (11521901, 2, 15, 52098, 1, 0, 0, 0, 0, 0, 3001);
DELETE FROM `waypoint_scripts` WHERE `id` = 11521902;
INSERT INTO `waypoint_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`guid`) VALUES
 (11521902, 0, 14, 52092, 1, 0, 0, 0, 0, 0, 3002);
 -- Achievement: The Incredible Hulk, http://old.wowhead.com/achievement=2043
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7322 AND `type` = 11;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7322 AND `type` = 18;
INSERT INTO `achievement_criteria_data`(`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(7322, 11, 0, 0, 'achievement_incredible_hulk');
-- NPC: Arthas, Lich King(Image of Arthas), http://www.wowhead.com/npc=24266
-- NPC: Scourge Hulk, http://old.wowhead.com/npc=26555
-- NPC: Svala Sorrowgrave, http://old.wowhead.com/npc=26668
-- NPC: Ritual Channeler, http://old.wowhead.com/npc=27281
-- NPC: Dragonflayer Spectator, http://old.wowhead.com/npc=26667
UPDATE `script_texts` SET `sound` = 13855, `type` = 1 WHERE `entry` = -1575022;
UPDATE `script_texts` SET `sound` = 13848, `type` = 1 WHERE `entry` = -1575021;
UPDATE `script_texts` SET `sound` = 13847, `type` = 1 WHERE `entry` = -1575020;
UPDATE `script_texts` SET `sound` = 13845, `type` = 1 WHERE `entry` = -1575019;
UPDATE `script_texts` SET `sound` = 13842, `type` = 1 WHERE `entry` = -1575018;
UPDATE `script_texts` SET `sound` = 13856, `type` = 1 WHERE `entry` = -1575015;
UPDATE `script_texts` SET `sound` = 13857, `type` = 1 WHERE `entry` = -1575016;
UPDATE `script_texts` SET `sound` = 13858, `type` = 1 WHERE `entry` = -1575017;
DELETE FROM `script_texts` WHERE `entry` IN (-1575003, -1575014);
INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
 (24266, -1575003, 'Your sacrifice is a testament to your obedience. Indeed you are worthy of this charge. Arise, and forever be known as Svala Sorrowgrave!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14732, 1, 0, 0,'SAY_DIALOG_OF_ARTHAS_1'),
 (24266, -1575014, 'Your first test awaits you. Destroy our uninvited guests.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14733, 1, 0, 0,'SAY_DIALOG_OF_ARTHAS_2');
UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` IN (29281, 30809);
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE `id` = 29281;
UPDATE `creature_template` SET `rank` = 1 WHERE `entry` IN (29281, 30809);
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 30809;
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` = 617299967  WHERE `entry` IN (29281, 30809, 26668, 30810);
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 26668;
UPDATE `creature_template` SET `ScriptName` = 'npc_spectator' WHERE `entry` = 26667;
UPDATE `creature_template` SET `ScriptName` = 'npc_ritual_channeler' WHERE `entry` = 27281;
DELETE FROM `creature_template_addon` WHERE `entry` = 29280;
INSERT INTO `creature_template_addon`(`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
 (29280, 0, 0, 0, 1, 0, 54134);
DELETE FROM `spell_target_position` WHERE `id` IN (48267, 48276, 48271, 48274, 48275);
INSERT INTO `spell_target_position`(`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
 (48267, 575, 296.632, -346.075, 90.5474, 4.60767),
 (48276, 575, 296.651, -346.293, 108.5474, 1.58),
 (48271, 575, 296.42, -355.01, 90.94, 1.58),
 (48274, 575, 302.36, -352.01, 90.54, 2.20),
 (48275, 575, 291.39, -352.01, 90.54, 0.91);
DELETE FROM `conditions` WHERE `SourceEntry` IN (48246, 48277, 48331) AND `SourceTypeOrReferenceId` = 13;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
 (13, 0, 48331, 0, 18, 1, 27327, 0, 0, '', NULL),
 (13, 0, 48246, 0, 18, 1, 0, 0, 0, '', NULL),
 (13, 0, 48277, 0, 18, 1, 26555, 0, 0, '', NULL),
 (13, 0, 48277, 0, 18, 1, 27327, 0, 0, '', NULL);
UPDATE `creature_template` SET `InhabitType` = 7, `flags_extra` = 130 WHERE `entry` = 30805;
UPDATE `creature_template` SET `InhabitType` = 7, `flags_extra` = 128 WHERE `entry` = 30771;
DELETE FROM `spell_script_names` WHERE `spell_id` = 48278;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 26555;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_scourge_hulk' WHERE `entry` = 26555;
-- -------------------------------------------------------------------------}
-- ---------------------- Myth Project "Quests" Update ---------------------
-- -------------------------------------------------------------------------{
-- Quest: Thassarian, My Brother, http://www.wowhead.com/quest=11599
-- NPC: William Allerton, http://www.wowhead.com/npc=25385
UPDATE `creature_template` SET `faction_A` = 1094, `faction_H` = 1094 WHERE `entry` = 25385;
-- Quest: Demons Deck, http://old.wowhead.com/quest=13311
-- Item: Demons Deck, http://old.wowhead.com/item=44158
UPDATE `quest_template` SET `SkillOrClassMask` = 0,`RequiredSkillValue` = 0,`ZoneOrSort` = 0 WHERE `entry` = 13311;
-- Quest: The Scryer's Scryer, http://old.wowhead.com/quest=11490
-- NPC: Magisters' Terrace - Scryer Quest Bunny, http://old.wowhead.com/npc=25042
-- NPC: Tyrith, http://old.wowhead.com/npc=24822
-- NPC: Kalecgos, http://old.wowhead.com/npc=24848
DELETE FROM `creature_questrelation` WHERE `quest` = 11490;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 11490;
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 11490;
INSERT INTO `creature_questrelation`(`id`,`quest`) VALUES (24822, 11490);
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` = 24822;
UPDATE `creature_template` SET `unit_flags` = 8 WHERE `entry` = 25042;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 11490;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 11490;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES (24848, 11490);
UPDATE `quest_template` SET `Method` = 2 WHERE `entry` = 11490;
-- Quest: Chill Out, Mon, http://old.wowhead.com/quest=12137
-- NPC: Ancient Drakkari Soothsayer, http://old.wowhead.com/npc=26812
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 26812;
INSERT INTO `creature_ai_scripts` VALUES
 (25804, 26812, 0, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Stop Movement on Aggro'),
 (25805, 26812, 0, 6, 100, 1, 3400, 4700, 3400, 4700, 0, 0, 0, 0, 11, 9734, 1, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Cast Fireball (Phase 1)'),
 (25806, 26812, 0, 0, 100, 1, 5000, 6000, 15000, 16000, 11, 52468, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Cast Prophecy of Blood'),
 (25807, 26812, 2, 0, 100, 0, 15, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Set Phase 3 at 15% HP'),
 (25808, 26812, 2, 3, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0,'Ancient Drakkari Soothsayer - Start Movement and Flee at 15% HP (Phase 3)'),
 (25809, 26812, 3, 6, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 22, 5, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Start Movement and Set Phase 2 when Mana is at 15%'),
 (25810, 26812, 3, 5, 100, 1, 100, 30, 100, 100, 22, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Set Phase 1 when Mana is above 30% (Phase 2)'),
 (25811, 26812, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9734, 1, 0, 22, 6, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Cast Fireball and Set Phase 1 on Aggro'),
 (25812, 26812, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47798, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0,'ytdb-q12137'),
 (25813, 26812, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - On Evade set Phase to 0'),
 (25814, 26812, 9, 6, 100, 1, 25, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Ancient Drakkari Soothsayer - Start Movement Beyond 25 Yards');
-- Quest: Jin'arrak's End, http://old.wowhead.com/quest=12152
-- NPC: Kraz, http://old.wowhead.com/npc=26886
DELETE FROM `creature_questrelation` WHERE `quest` = 12152;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 12152;
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 12152;
INSERT INTO `creature_questrelation`(`id`,`quest`) VALUES (26886, 12152);
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` = 26886;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 12152;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 12152;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES (26886, 12152);
-- Quest: Chill Out, Mon, http://old.wowhead.com/quest=12137
-- Item: Snow of Eternal Slumber, http://old.wowhead.com/item=36859
UPDATE `item_template` SET `spellid_2` = 64365,`spellcooldown_2` = 15000 WHERE `entry` = 36859;
-- Quest: A Time for Negotiation... (Alliance), http://old.wowhead.com/quest=1222
-- Quest: A Time for Negotiation... (Horde), http://old.wowhead.com/quest=1270
-- NPC: "Stinky" Ignatz, http://old.wowhead.com/npc=4880
-- NPC: Morgan Stern, http://old.wowhead.com/npc=4794
DELETE FROM `creature_questrelation` WHERE `quest` IN (1222, 1270);
DELETE FROM `gameobject_questrelation` WHERE `quest` IN (1222, 1270);
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` IN (1222, 1270);
INSERT INTO `creature_questrelation`(`id`,`quest`) VALUES
 (4880, 1222),
 (4880, 1270);
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` IN (4794, 4880);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (1222, 1270);
DELETE FROM `gameobject_involvedrelation` WHERE `quest` IN (1222, 1270);
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
 (4794, 1222),
 (4794, 1270);
DELETE FROM `quest_template` WHERE `entry` IN (1222, 1270);
INSERT INTO `quest_template` VALUES
 (1222, 2, 15, 0, 30, 0, 37, 84, 1101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0,"Stinky\'s Escape","Great, finally something that doesn\'t want to eat me!$B$BI need help handling the critters around here, and you fit the mold, $gbuddy:lady;.$B$BThe cook Morgan Stern is researching a new recipe, and he sent me out here to gather bogbean leaves. I guess he thinks they\'re tasty.$B$BAnyway, while looking for a bogbean plant... I got myself surrounded!  Can you help me out of here, and watch my back as I look for the bogbean?","Escort \"Stinky\" Ignatz, then speak with Morgan Stern in Theramore.","Mr. Ignatz was just here with the bogbean leaves, and he told me you helped him out of some real trouble.$B$BThank you, $N. I will ask my uncle to treat you to a feast the next time you visit the Blue Recluse in Stormwind.","Have you seen Mr. Ignatz? I sent him into the swamp some time ago and he hasn\'t returned!","Help Stinky find Bogbean Leaves","Return to Morgan Stern at Dreadmurk Shore in Dustwallow Marsh.","","","","", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3825, 0, 0, 0, 1, 0, 0, 0, 72, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4000, 2220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 12340),
 (1270, 2, 15, 0, 30, 0, 37, 84, 690, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0,"Stinky\'s Escape","Great, finally something that doesn\'t want to eat me!$B$BI need help handling the critters around here, and you fit the mold, $gbuddy:lady;.$B$BThe cook Morgan Stern is researching a new recipe, and he sent me out here to gather bogbean leaves. I guess he thinks they\'re tasty.$B$BAnyway, while looking for a bogbean plant... I got myself surrounded!  Can you help me out of here, and watch my back as I look for the bogbean?","Escort \"Stinky\" Ignatz, then speak with Morgan Stern in Theramore.","Mr. Ignatz was just here with the bogbean leaves, and he told me you helped him out of some real trouble.$B$BThank you, $N. I will ask my uncle to treat you to a feast the next time you visit the Blue Recluse in Stormwind.","Have you seen Mr. Ignatz? I sent him into the swamp some time ago and he hasn\'t returned!","Help Stinky find Bogbean Leaves","Return to Morgan Stern at Dreadmurk Shore in Dustwallow Marsh.","","","","", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3825, 0, 0, 0, 1, 0, 0, 0, 72, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4000, 2220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 12340);
-- Quest: A Time for Negotiation..., http://old.wowhead.com/quest=10682
-- NPC: Overseer Nuaar, http://old.wowhead.com/npc=21981
DELETE FROM `creature` WHERE `id` = 21981;
INSERT INTO `creature` VALUES
 (76121, 21981, 530, 1, 1, 0, 0, 2725.66, 5433, 137.267, 5.78059, 300, 0, 0, 5060, 2933, 2, 0, 0, 0);
DELETE FROM `waypoint_data` WHERE `id` = 21981;
INSERT INTO `waypoint_data` VALUES
 (21981, 1, 2725.66, 5433.1, 137.267, 0, 0, 0, 100, 0), (21981, 2, 2919.15, 5367.12, 147.256, 0, 0, 0, 100, 0),
 (21981, 3, 2915.57, 5540.67, 145.648, 0, 0, 0, 100, 0),(21981, 4, 2947.11, 5572.19, 146.29, 0, 0, 0, 100, 0),
 (21981, 5, 2971.12, 5648.68, 146.466, 0, 0, 0, 100, 0),(21981, 6, 2967.27, 5682.05, 146.157, 0, 0, 0, 100, 0),
 (21981, 7, 3070.1, 5633.48, 142.664, 0, 0, 0, 100, 0), (21981, 8, 3113.86, 5584.68, 146.296, 0, 0, 0, 100, 0),
 (21981, 9, 3102.04, 5565.29, 148.712, 0, 0, 0, 100, 0),(21981, 10, 3162.78, 5477.62, 147.454, 0, 0, 0, 100, 0),
 (21981, 11, 3291.52, 5451.29, 143.74, 0, 0, 0, 100, 0),(21981, 12, 3386.5, 5458.22, 146.632, 0, 0, 0, 100, 0),
 (21981, 13, 3433.62, 5425.82, 144.423, 0, 0, 0, 100, 0);
-- Quest: Signs Of The Times, http://old.wowhead.com/quest=25282
-- NPC: Captain Anton, http://old.wowhead.com/npc=39508
DELETE FROM `creature_questrelation` WHERE `quest` = 25282;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 25282;
UPDATE `item_template` SET `StartQuest` = 0 WHERE `StartQuest` = 25282;
INSERT INTO `creature_questrelation`  VALUES (39508, 25282);
UPDATE `creature_template` SET `npcflag` = `npcflag`|2 WHERE `entry` = 39508;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 25282;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 25282;
INSERT INTO `creature_involvedrelation`  VALUES (39508, 25282);
-- Quest: Forging a Head, http://old.wowhead.com/quest=12985
-- NPC: Stormforged Ambusher, http://old.wowhead.com/npc=30208
DELETE FROM `creature` WHERE `id` = 30208;
INSERT INTO `creature` VALUES
 (169113, 30208, 571, 1, 2, 0, 888, 7372.8, -3226.53, 847.787, 4.39016, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169114, 30208, 571, 1, 2, 0, 888, 7347.68, -3171.01, 837.45, 1.85254, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169115, 30208, 571, 1, 2, 0, 888, 7319.82, -3113.56, 837.45, 1.24385, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169116, 30208, 571, 1, 2, 0, 888, 7385.17, -3061.23, 837.474, 1.32239, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169117, 30208, 571, 1, 2, 0, 888, 7432.48, -3075.56, 837.452, 2.70077, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169118, 30208, 571, 1, 2, 0, 888, 7476.1, -3132.13, 837.468, 2.88926, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169119, 30208, 571, 1, 2, 0, 888, 7504.61, -3197.18, 837.464, 2.46515, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169120, 30208, 571, 1, 2, 0, 888, 7534.23, -3104.49, 842.984, 2.02925, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169121, 30208, 571, 1, 2, 0, 888, 7502.23, -3264.83, 851.892, 2.08815, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169122, 30208, 571, 1, 2, 0, 888, 7459.18, -3267.88, 854.142, 2.22167, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169123, 30208, 571, 1, 2, 0, 888, 7318.1, -3256.65, 843.44, 2.55546, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169124, 30208, 571, 1, 2, 0, 888, 7256.35, -3265.14, 837.475, 2.76595, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169125, 30208, 571, 1, 2, 0, 888, 7222.8, -3303.52, 837.59, 1.45041, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169126, 30208, 571, 1, 2, 0, 888, 7191.07, -3230.81, 850.517, 0.963459, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169127, 30208, 571, 1, 2, 0, 888, 7224.23, -3192.1, 839.428, 0.0154827, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169128, 30208, 571, 1, 2, 0, 888, 7221.16, -3112.12, 837.466, 0.0602509, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169129, 30208, 571, 1, 2, 0, 888, 7321.14, -3068.93, 839.12, 1.34438, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169130, 30208, 571, 1, 2, 0, 888, 7275.71, -3047.9, 838.641, 0.310012, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169131, 30208, 571, 1, 2, 0, 888, 7208.87, -3051.06, 849.277, 5.7587, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169132, 30208, 571, 1, 2, 0, 888, 7177.36, -3078.65, 862.579, 1.12877, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
 (169133, 30208, 571, 1, 2, 0, 888, 7259.4, -3134.78, 837.452, 0.292327, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
 (169134, 30208, 571, 1, 2, 0, 888, 7371.88, -3282.9, 859.009, 1.41073, 300, 0, 0, 5885, 0, 0, 0, 0, 0);
-- Quest: Jack Likes His Drink, http://old.wowhead.com/quest=11466
-- NPC: Jack Adams, http://old.wowhead.com/npc=24788
-- NPC: Olga, the Scalawag Wench, http://old.wowhead.com/npc=24639
SET @ENTRY_OLGA := 24639;
SET @ENTRY_JACK := 24788;
SET @GOSSIP := 9015;
SET @QUEST := 11466;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = @ENTRY_JACK;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (@ENTRY_OLGA, @ENTRY_JACK);
UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP+10 WHERE `entry` = @ENTRY_JACK;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_OLGA, @ENTRY_OLGA*100, @ENTRY_OLGA*100+1, @ENTRY_OLGA*100+2, @ENTRY_JACK, @ENTRY_JACK*100);
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (@ENTRY_OLGA, 0, 0, 0, 62, 0, 100, 0, @GOSSIP+1, 0, 0, 0, 80, @ENTRY_OLGA*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Gossip Select - Run Script"),
 (@ENTRY_OLGA*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 0, @ENTRY_OLGA, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script - Start WP"),
 (@ENTRY_OLGA*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script - Close Gossip"),
 (@ENTRY_OLGA*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script - Whisper Line 0"),
 (@ENTRY_OLGA*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script - Remove Gossip Flag"),
 (@ENTRY_OLGA, 0, 1, 0, 40, 0, 100, 0, 2, @ENTRY_OLGA, 0, 0, 80, @ENTRY_OLGA*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On WP 2 - Run Script 2"),
 (@ENTRY_OLGA*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 11, @ENTRY_JACK, 15, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script 2 - Face Jack Adams"),
 (@ENTRY_OLGA*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script 2 - Say Line 1"),
 (@ENTRY_OLGA*100+1, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @ENTRY_JACK, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script 2 - Set Data 1 1 Jack Adams"),
 (@ENTRY_OLGA*100+1, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script 2 - Say Line 2"),
 (@ENTRY_OLGA*100+1, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @ENTRY_JACK, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Script 2 - Set Data 2 2 Jack Adams"),
 (@ENTRY_OLGA, 0, 2, 0, 38, 0, 100, 0, 3, 3, 0, 0, 53, 0, @ENTRY_OLGA*10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Olga,  the Scalawag Wench - On Data 3 3 Set - Start WP 2"),
 (@ENTRY_JACK, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - Out of Combat - Start Dancing"),
 (@ENTRY_JACK, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Data 1 1 Set - Say Line 0"),
 (@ENTRY_JACK, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Data 1 1 Set - Set Faction 35"),
 (@ENTRY_JACK, 0, 3, 4, 62, 0, 100, 0, @GOSSIP+10, 0, 0, 0, 56, 34116, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Gossip Select - Give Quest Item"),
 (@ENTRY_JACK, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Gossip Select - Close Gossip"),
 (@ENTRY_JACK, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Gossip Select - Remove Gossip Flag"),
 (@ENTRY_JACK, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, @ENTRY_OLGA, 0, 0, 0, 0, 0, 0, "Jack Adams - On Gossip Select - Set Data Olga,  the Scalawag Wench"),
 (@ENTRY_JACK, 0, 7, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, @ENTRY_JACK*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Data 2 2 Set - Run Script"),
 (@ENTRY_JACK*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Say Line 1"),
 (@ENTRY_JACK*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 26, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Stop Dancing"),
 (@ENTRY_JACK*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - EMOTE_ONESHOT_KNEEL"),
 (@ENTRY_JACK*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - EMOTE_ONESHOT_EAT"),
 (@ENTRY_JACK*100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Say Line 2"),
 (@ENTRY_JACK*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 43391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Cast Vomit"),
 (@ENTRY_JACK*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Cast Permanent Feign Death"),
 (@ENTRY_JACK*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Add Gossip Flag"),
 (@ENTRY_JACK*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jack Adams - On Script - Forced Despawn");
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY_OLGA, @ENTRY_JACK);
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (@ENTRY_OLGA, 0, 0, "Keep quiet, will you? If anyone catches on, we're both dead.", 15, 0, 100, 0, 0, 0, "Olga,  the Scalawag Wench"),
 (@ENTRY_OLGA, 1, 0, "All right, fellas! Who ordered the spiced rum? Was it you,  Jackie boy?", 12, 0, 100, 0, 0, 0, "Olga,  the Scalawag Wench"),
 (@ENTRY_OLGA, 2, 0, "It's okay, sweetheart. This one's on the house.", 12, 0, 100, 0, 0, 0, "Olga,  the Scalawag Wench"),
 (@ENTRY_JACK, 0, 0, "Sure thing, love. Put it on Harry's tab,  will ya? He owes me a drink!", 12, 0, 100, 0, 0, 0, "Jack Adams"),
 (@ENTRY_JACK, 1, 0, "Free rum? Why... that's me favorite kind!", 12, 0, 100, 0, 0, 0, "Jack Adams"),
 (@ENTRY_JACK, 2, 0, "Sweet Neptulon! That was... one drink... too many!", 12, 0, 100, 0, 0, 0, "Jack Adams");
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP, @GOSSIP+1, @GOSSIP+10);
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`box_money`,`box_text`) VALUES
 (@GOSSIP+0, 0, 0, "I'd like to buy Jack a drink. Perhaps something... extra strong.", 1, 1, @GOSSIP+1, 0,''),
 (@GOSSIP+1, 0, 0, "Here's a gold, buy yourself something nice.", 1, 1, 0, 10000,'Do you really want to bribe Olga?'),
 (@GOSSIP+10, 0, 0, "<Discreetly search the pirate's pockets for Taruk's payment.>", 1, 1, 0, 0,'');
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY_OLGA, @ENTRY_OLGA*10);
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (@ENTRY_OLGA, 1, -89.466621, -3539.939941, 7.715524,'Olga, the Scalawag Wench'),
 (@ENTRY_OLGA, 2, -86.451447, -3544.374268, 7.716601,'Olga, the Scalawag Wench'),
 (@ENTRY_OLGA*10, 1, -86.451447, -3544.374268, 7.716601,'Olga, the Scalawag Wench'),
 (@ENTRY_OLGA*10, 2, -89.466621, -3539.939941, 7.715524,'Olga, the Scalawag Wench');
DELETE FROM `conditions` WHERE `SourceGroup` IN (@GOSSIP, @GOSSIP+10) AND `ConditionValue1` IN (@QUEST);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
 (15, @GOSSIP, 0, 0, 9, @QUEST, 0, 0, 0,'', "Only show first gossip if player is on quest Gambling Debt"),
 (15, @GOSSIP+10, 0, 0, 9, @QUEST, 0, 0, 0,'', "Only show first gossip if player is on quest Gambling Debt");
-- Quest: Ribbly Screwspigot, http://old.wowhead.com/quest=4136
-- NPC: Ribbly Screwspigot, http://old.wowhead.com/npc=9543
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 9543;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9543;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 9543;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (9543, 0, 0, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "On Gossip Select - Set Faction 14"),
 (9543, 0, 1, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 2, 14, 0, 0, 0, 0, 0, 19, 10043, 0, 0, 0.0, 0.0, 0.0, 0.0, "On Gossip Select - Set Faction 14 to Corny"),
 (9543, 0, 2, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "On Gossip Select - Text"),
 (9543, 0, 3, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 12, 10043, 6, 10000, 0, 0, 0, 8, 0, 0, 0, 880.15, -164.51, -49.757, 2.04372, "On Gossip Select - Summon Creature"),
 (9543, 0, 4, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 12, 10043, 6, 10000, 0, 0, 0, 8, 0, 0, 0, 881.86, -165.24, -49.758, 2.04372, "On Gossip Select - Summon Creature 2"),
 (9543, 0, 5, 0, 62, 0, 100, 0, 1970, 1, 0, 0, 12, 10043, 6, 10000, 0, 0, 0, 8, 0, 0, 0, 878.493, -166.7, -49.7577, 1.94928, "On Gossip Select - Summon Creature 3"),
 (9543, 0, 6, 0, 0, 0, 100, 0, 5500, 5500, 12000, 13000, 11, 12540, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "Ribbly Screwspigot - Gouge"),
 (9543, 0, 7, 0, 0, 0, 100, 0, 6000, 6000, 15000, 15000, 11, 9080, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "Ribbly Screwspigot - Cast Hamstring");
DELETE FROM `creature_text` WHERE `entry` = 9543;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`probability`,`comment`)  VALUES
 (9543, 0, 0,'No! Get away from me! Help!!', 12, 100,'Ribbly');
-- NPC: Ribbly's Crony, http://old.wowhead.com/npc=10043
DELETE FROM `creature` WHERE `id` = 10043;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 10043;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10043;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 10043;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (10043, 0, 0, 0, 0, 0, 70, 0, 5500, 5500, 14000, 19000, 11, 15581, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "Ribbly's Crony - Sinister Strike"),
 (10043, 0, 1, 0, 0, 0, 100, 0, 5500, 5500, 12000, 15000, 11, 15692, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "Ribbly's Crony - Eviscerate"),
 (10043, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, "On Summon - Set Faction 14");
-- Quest: Fel Reavers, No Thanks!, http://old.wowhead.com/quest=10855
UPDATE `quest_template` SET `ReqSourceId1` = 31653, `ReqSourceCount1` = 5 WHERE `entry` = 10855;
-- Quest: Killing Two Scourge With One Skeleton, http://old.wowhead.com/quest=13144
-- NPC: Burning Skeleton, http://old.wowhead.com/npc=31048
SET @Immolation := 58627;
SET @CheckTrigger := 58594;
SET @Check := 58593;
SET @Explosion := 58596;
SET @Skeleton := 31048;
SET @KC := 30995;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @Skeleton;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Skeleton;
INSERT INTO `smart_scripts` VALUES
 (@Skeleton, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 11, @Immolation, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Burning Skeleton - On spawn - Cast Immolation on self'),
 (@Skeleton, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, @CheckTrigger, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Burning Skeleton - Linked with event 0 - Cast Skeleton Check Master on self'),
 (@Skeleton, 0, 2, 3, 31, 0, 100, 0, @Check, 0, 0, 0, 33, @KC, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0,'Burning Skeleton - On target hit by spell Check  - Cast Credit Trigger on self'),
 (@Skeleton, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 28, @CheckTrigger, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Burning Skeleton - Linked with event 2 - Remove auras from spell CheckTrigger'),
 (@Skeleton, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, @Explosion, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Burning Skeleton - Linked with event 3 - Cast explosion on self');
-- Quest: Blast the Infernals!, http://old.wowhead.com/quest=10564
DELETE FROM `event_scripts` WHERE `id` = 13874;
INSERT INTO `event_scripts` VALUES (13874, 1, 8, 21512, 0, 0, 0, 0, 0, 0);
-- Quest: The Nightmare Manifests, http://old.wowhead.com/quest=8736
DELETE FROM `quest_start_scripts` WHERE `id` = 8736;
-- NPC: Keeper Remulos, http://old.wowhead.com/npc=11832
UPDATE `creature_template` SET AIName = 'SmartAI', speed_walk = 2.5, speed_run = 3.75, type_flags = 0, unit_flags = 32768, faction_H = 1254, faction_A = 1254 WHERE entry = 11832;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (11832, 1183200);
INSERT INTO `smart_scripts` VALUES
 (11832, 0, 0, 0, 19, 0, 100, 1, 8736, 0, 0, 0, 1, 0, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Quest Accepted - Say 0'),
 (11832, 0, 1, 0, 52, 0, 100, 0, 0, 11832, 0, 0, 53, 0, 11832, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 0 - Start WayPoint'),
 (11832, 0, 2, 0, 52, 0, 100, 0, 0, 11832, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Quest Accepted - Remove npcflag'),
 (11832, 0, 3, 0, 40, 0, 100, 0, 13, 11832, 0, 0, 54, 95000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 13 - Pause'),
 (11832, 0, 4, 0, 40, 0, 100, 0, 13, 11832, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 13 - Say 1'),
 (11832, 0, 5, 0, 52, 0, 100, 0, 1, 11832, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 1 - Say 2'),
 (11832, 0, 6, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 11, 25813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 3 - Cast Conjure Dream Rift'),
 (11832, 0, 7, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 12, 15491, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7900.3569, -2654.0896, 497.0288, 0.63583,'Keeper Remulos - Say 3 - Summon Eranikus'),
 (11832, 0, 8, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 1, 3, 23000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 2 - Say 3'),
 (11832, 0, 9, 0, 52, 0, 100, 0, 3, 11832, 0, 0, 1, 4, 31000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 3 - Say 4'),
 (11832, 0, 10, 0, 52, 0, 100, 0, 4, 11832, 0, 0, 1, 5, 22000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 4 - Say 5'),
 (11832, 0, 11, 0, 52, 0, 100, 0, 5, 11832, 0, 0, 1, 6, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 5 - Say 6'),
 (11832, 0, 12, 0, 40, 0, 100, 0, 20, 11832, 0, 0, 54, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 20 - Pause'),
 (11832, 0, 13, 0, 40, 0, 100, 0, 20, 11832, 0, 0, 1, 7, 20000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 20 - Say 7'),
 (11832, 0, 14, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 12, 15629, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7829.066, -2562.347, 489.299, 5.234,'Keeper Remulos - Say 7 - Summon 1'),
 (11832, 0, 15, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 12, 15629, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7828.889, -2580.694, 489.299, 0.753,'Keeper Remulos - Say 7 - Summon 2'),
 (11832, 0, 16, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 7 - Aggresive'),
 (11832, 0, 17, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 15629, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Say 7 - Attack'),
 (11832, 0, 18, 0, 0, 0, 100, 0, 7000, 14000, 6000, 12000, 11, 20665, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Combat - Cast Regrowth'),
 (11832, 0, 19, 0, 0, 0, 100, 0, 26000, 52000, 34000, 46000, 11, 20664, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Combat - Cast Regrowth'),
 (11832, 0, 20, 0, 0, 0, 100, 0, 25000, 25000, 25000, 50000, 11, 23381, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Combat - Cast Healing Touch'),
 (11832, 0, 21, 0, 0, 0, 100, 0, 10000, 40000, 40000, 40000, 11, 25817, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Combat - Cast Tranquility'),
 (11832, 0, 22, 0, 0, 0, 100, 0, 16000, 21000, 19000, 25000, 11, 21668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Combat - Cast Starfall'),
 (11832, 0, 23, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 8, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Data Set - Say 8'),
 (11832, 0, 24, 0, 52, 0, 100, 0, 8, 11832, 0, 0, 1, 9, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Said 8 8 - Say 9'),
 (11832, 0, 25, 0, 40, 0, 100, 1, 21, 11832, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 15491, 30, 0, 0, 0, 0, 0,'Keeper Remulos - Attack - Summon'),
 (11832, 0, 26, 0, 6, 0, 100, 0, 0, 0, 0, 0, 6, 8736, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Death - Fail'),
 (11832, 0, 27, 0, 40, 0, 100, 1, 23, 11832, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 23 - Pause'),
 (11832, 0, 28, 0, 40, 0, 100, 1, 23, 11832, 0, 0, 66, 2.835, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 23 - Face'),
 (11832, 0, 29, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 53, 1, 1183200, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - Said 9 - Go Home'),
 (11832, 0, 30, 0, 40, 0, 100, 0, 12, 1183200, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 12 - npcflags'),
 (11832, 0, 31, 0, 40, 0, 100, 0, 12, 1183200, 0, 0, 66, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 12 - Face'),
 (11832, 0, 32, 0, 40, 0, 100, 0, 24, 11832, 0, 0, 80, 1183200, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Keeper Remulos - WayPoint 24 - Run Script Only When OOC'),
 (1183200, 9, 0, 0, 1, 0, 100, 1, 60000, 60000, 0, 0, 53, 1, 1183200, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Script - OOC 1 Mintues - Go Home');
DELETE FROM `creature_text` WHERE `entry` = 11832;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (11832, 0, 0,"We will locate the origin of the Nightmare through the fragments you collected, $n. From there, we will pull Eranikus through a rift in the Dream. Steel yourself, $c. We are inviting the embodiment of the Nightmare into our world.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 0'),
 (11832, 1, 1,"The rift will be opened there, above the Lake Elun'ara. Prepare yourself, $n. Eranikus's entry into our world will be wrought with chaos and strife.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 1'),
 (11832, 2, 2,"He will stop at nothing to get to Malfurion's physical manifistation. That must not happen... We must keep the beast occupied long enough for Tyrande to arrive.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 2'),
 (11832, 3, 3,"Defend Nighthaven, hero...", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 3'),
 (11832, 4, 4,"Fiend! Face the might of Cenarius!", 14, 0, 100, 0, 0, 0,'Keeper Remulos Say 4'),
 (11832, 5, 5,"Who is the predictable one, beast? Surely you did not think that we would summon you on top of Malfurion? Your redemption comes, Eranikus. You will be cleansed of this madness - this corruption.", 14, 0, 100, 0, 0, 0,'Keeper Remulos Say 4'),
 (11832, 6, 6,"Hurry, $N! We must find protective cover!", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 6'),
 (11832, 7, 7,"Please, champion, protect our people.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 7'),
 (11832, 8, 8,"It will be done, Eranikus. Be well, ancient one.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 8'),
 (11832, 9, 9,"Let us leave Nighthaven, hero Seek me out at the grove.", 12, 0, 100, 0, 0, 0,'Keeper Remulos Say 9');
DELETE FROM `waypoints` WHERE entry = 11832;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (11832, 1, 7829.66, -2244.87, 463.87,'Keeper Remulos'),
 (11832, 2, 7817.25, -2306.20, 456.00,'Keeper Remulos'),
 (11832, 3, 7866.54, -2312.20, 463.32,'Keeper Remulos'),
 (11832, 4, 7908.488, -2309.086, 467.677,'Keeper Remulos'),
 (11832, 5, 7933.290, -2314.777, 473.674,'Keeper Remulos'),
 (11832, 6, 7942.543457, -2320.170654, 476.770355,'Keeper Remulos'),
 (11832, 7, 7953.036133, -2357.953613, 486.379303,'Keeper Remulos'),
 (11832, 8, 7962.706055, -2411.155518, 488.955231,'Keeper Remulos'),
 (11832, 9, 7976.860352, -2552.697998, 490.081390,'Keeper Remulos'),
 (11832, 10, 7949.307617, -2569.120361, 489.716248,'Keeper Remulos'),
 (11832, 11, 7950.945801, -2597.000000, 489.765564,'Keeper Remulos'),
 (11832, 12, 7948.758301, -2610.823486, 492.368988,'Keeper Remulos'),
 (11832, 13, 7928.785156, -2629.920654, 492.524933,'Keeper Remulos'),
 (11832, 14, 7948.697754, -2610.551758, 492.363983,'Keeper Remulos'),
 (11832, 15, 7952.019531, -2591.974609, 490.081238,'Keeper Remulos'),
 (11832, 16, 7940.567871, -2577.845703, 488.946808,'Keeper Remulos'),
 (11832, 17, 7908.662109, -2566.450439, 488.634644,'Keeper Remulos'),
 (11832, 18, 7873.132324, -2567.422363, 486.946442,'Keeper Remulos'),
 (11832, 19, 7839.844238, -2570.598877, 489.286224,'Keeper Remulos'),
 (11832, 20, 7830.678597, -2572.878974, 489.286224,'Keeper Remulos'),
 (11832, 21, 7890.504, -2567.259, 487.306,'Keeper Remulos'),
 (11832, 22, 7906.447, -2566.105, 488.435,'Keeper Remulos'),
 (11832, 23, 7925.861, -2573.601, 489.642,'Keeper Remulos'),
 (11832, 24, 7912.283, -2568.500, 488.891,'Keeper Remulos');
DELETE FROM `waypoints` WHERE entry = 1183200;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (1183200, 12, 7847.066, -2217.571, 470.403,'Keeper Remulos'),
 (1183200, 11, 7829.66, -2244.87, 463.87,'Keeper Remulos'),
 (1183200, 10, 7817.25, -2306.20, 456.00,'Keeper Remulos'),
 (1183200, 9, 7866.54, -2312.20, 463.32,'Keeper Remulos'),
 (1183200, 8, 7908.488, -2309.086, 467.677,'Keeper Remulos'),
 (1183200, 7, 7933.290, -2314.777, 473.674,'Keeper Remulos'),
 (1183200, 6, 7942.543457, -2320.170654, 476.770355,'Keeper Remulos'),
 (1183200, 5, 7953.036133, -2357.953613, 486.379303,'Keeper Remulos'),
 (1183200, 4, 7962.706055, -2411.155518, 488.955231,'Keeper Remulos'),
 (1183200, 3, 7976.860352, -2552.697998, 490.081390,'Keeper Remulos'),
 (1183200, 2, 7949.307617, -2569.120361, 489.716248,'Keeper Remulos'),
 (1183200, 1, 7940.567871, -2577.845703, 488.946808,'Keeper Remulos');
-- NPC: Tyrande, http://old.wowhead.com/npc=15633
UPDATE `creature_template` SET AIName = 'SmartAI', flags_extra = 0, type_flags = 0, unit_flags = 32768, faction_H = 1254, faction_A = 1254 WHERE entry = 15633;
DELETE FROM `creature_text` WHERE `entry` = 15633;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (15633, 0, 0,"Seek absolution, Eranikus. All will be forgiven..", 14, 0, 100, 0, 0, 0,'Tyrande Say 0'),
 (15633, 1, 1,"You will be forgiven, Eranikus. Elune will always love you. Break free of the bonds that command you!", 14, 0, 100, 0, 0, 0,'Tyrande Say 0'),
 (15633, 2, 2,"The grasp of the Old Gods is unmoving. He is consumed by their dark thoughts... I... I... I cannot... cannot channel much longer... Elune aide me.", 12, 0, 100, 0, 0, 0,'Tyrande Say 0');
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15633;
INSERT INTO `smart_scripts` VALUES
 (15633, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Tyrande - Summon - Aggresive'),
 (15633, 0, 1, 0, 1, 0, 100, 1, 95000, 95000, 95000, 95000, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Tyrande - OOC 60 Sec - Unseen'),
 (15633, 0, 2, 0, 1, 0, 100, 1, 96000, 96000, 96000, 96000, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Tyrande - OOC 61 Sec - Kill'),
 (15633, 0, 3, 0, 0, 0, 100, 0, 1000, 2000, 2300, 2500, 11, 21668, 0, 0, 0, 0, 0, 11, 15491, 20, 0, 0, 0, 0, 0,'Tyrande - Combat - Cast Starfall');
-- NPC: Eranikus, Tyrant of the Dream, http://old.wowhead.com/npc=15491
DELETE FROM `creature_ai_scripts` WHERE creature_id = 15491;
UPDATE `creature_template` SET AIName = 'SmartAI', InhabitType = 7, Faction_A = 35, Faction_H = 35, unit_flags = 0, Type_flags = 0, dynamicflags = 128, speed_walk = 2 WHERE entry = 15491;
DELETE FROM `creature_text` WHERE `entry` = 15491;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (15491, 0, 0,"Pitful predictable mortals... You know not what you have done! The master\'s will fulfilled. The Moonglade shall be destroyed and Malfurion along with it!", 14, 0, 100, 0, 0, 0,'Eranikus Say 0'),
 (15491, 1, 1,"Eranikus, Tyrant of the Dream lets loose a sinister laugh.", 16, 0, 100, 0, 0, 0,'Eranikus Say 1'),
 (15491, 2, 2,"You are certanly not your father, insect. Should it interest me, I would crush you with but a swipe of my claws. Turn Shan\'do Stormrage over to me and your pitiful life will be spared along with the lives of your people.", 14, 0, 100, 0, 0, 0,'Eranikus Say 2'),
 (15491, 3, 3,"My redemption? You are bold, little one. My redemption comes by the will of my god.", 14, 0, 100, 0, 0, 0,'Eranikus Say 3'),
 (15491, 4, 4,"Eranikus, Tyrant of the Dream roars furiously", 16, 0, 100, 0, 0, 0,'Eranikus Say 4'),
 (15491, 5, 5,"Rise, servants of the Nightmare! Rise and destroy this world! Let there be no survivors...", 14, 0, 100, 0, 0, 0,'Eranikus Say 5'),
 (15491, 6, 6,"Where is your savior? How long can you hold out against my attacks?", 14, 0, 100, 0, 0, 0,'Eranikus Say 6'),
 (15491, 7, 7,"Remulos, look how easy they fall before me? You can stop this, fool. Turn the druid over to me and it will all be over...", 14, 0, 100, 0, 0, 0,'Eranikus Say 7'),
 (15491, 8, 8,"Defeated my minions? Then face me, mortals!", 14, 0, 100, 0, 0, 0,'Eranikus Say 8'),
 (15491, 9, 9,"IT BURNS! THE PAIN.. SEARING...", 14, 0, 100, 0, 0, 0,'Eranikus Say 9'),
 (15491, 10, 10,"WHY? Why did this happen to... to me? Where were you Tyrande? Where were you when I fell from the grace of Elune?", 14, 0, 100, 0, 0, 0,'Eranikus Say 10'),
 (15491, 11, 11,"I... I feel... I feel the touch of Elune upon my being once more... She smiles upon me... Yes... I...", 14, 0, 100, 0, 0, 0,'Eranikus Say 11'),
 (15491, 12, 12,"Tyrande falls to one knee.", 16, 0, 100, 0, 0, 0,'Eranikus Say 12');
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (15491, 1549100, 1549101);
INSERT INTO `smart_scripts` VALUES
 (15491, 0, 0, 0, 1, 0, 100, 1, 13000, 13000, 13000, 13000, 1, 0, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - OOC 13 Sec - Say 0'),
 (15491, 0, 1, 0, 52, 0, 100, 0, 0, 15491, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 0 - Say 1'),
 (15491, 0, 2, 0, 52, 0, 100, 0, 1, 15491, 0, 0, 1, 2, 34000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 1 - Say 2'),
 (15491, 0, 3, 0, 52, 0, 100, 0, 2, 15491, 0, 0, 1, 3, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - Say 3'),
 (15491, 0, 4, 0, 52, 0, 100, 0, 3, 15491, 0, 0, 1, 4, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 3 - Say 4'),
 (15491, 0, 5, 0, 52, 0, 100, 0, 4, 15491, 0, 0, 53, 0, 15491, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 4 - Start WayPoint'),
 (15491, 0, 6, 0, 40, 0, 100, 0, 3, 15491, 0, 0, 54, 130000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - WayPoint 3 - Pause'),
 (15491, 0, 7, 0, 40, 0, 100, 0, 3, 15491, 0, 0, 1, 5, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - WayPoint 3 - Say 5'),
 (15491, 0, 8, 0, 52, 0, 100, 0, 5, 15491, 0, 0, 80, 1549100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 5 - Start Script'),
 (1549100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 11, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 14, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 15, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549100, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 6, 35000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - On Script - Say 6'),
 (15491, 0, 9, 0, 52, 0, 100, 0, 6, 15491, 0, 0, 80, 1549101, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 6 - Start Script'),
 (1549101, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 11, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7865.966, -2554.104, 486.967, 5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7873.412, -2587.454, 486.946, 0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 14, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7901.544, -2581.989, 487.178, 2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 15, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 15629, 3, 600000, 0, 0, 0, 8, 0, 0, 0, 7918.844, -2553.987, 486.911, 3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
 (1549101, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 7, 35000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - On Script - Say 7'),
 (15491, 0, 10, 0, 40, 0, 100, 0, 4, 15491, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Waypont 4 - Enemy'),
 (15491, 0, 38, 0, 40, 0, 100, 0, 4, 15491, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Waypont 4 - Aggresive'),
 (15491, 0, 11, 0, 2, 0, 100, 0, 30, 65, 12000, 35000, 12, 15629, 3, 600000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Combat - Summon Nightmare Phantasm'),
 (15491, 0, 12, 0, 4, 1, 100, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - AGGRO - Say 8'),
 (15491, 0, 13, 0, 4, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - AGGRO - Aggresive'),
 (15491, 0, 14, 0, 4, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Eranikus - AGGRO - Attack'),
 (15491, 0, 15, 0, 0, 0, 100, 0, 2000, 4000, 55000, 60000, 11, 24818, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Combat - Cast Noxious Breath'),
 (15491, 0, 16, 0, 0, 0, 100, 0, 9000, 14000, 50000, 55000, 11, 24839, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Combat - Cast Acid Spit'),
 (15491, 0, 17, 0, 0, 0, 100, 0, 10000, 20000, 15000, 25000, 11, 22878, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Combat - Cast Shadow Bolt Volley'),
 (15491, 0, 18, 0, 2, 0, 100, 1, 0, 70, 0, 0, 12, 15633, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7900.216, -2572.621, 488.176, 2.330,'Eranikus - 70% - Summon Tyrande'),
 (15491, 0, 34, 0, 2, 0, 100, 1, 0, 69, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 15633, 30, 0, 0, 0, 0, 0,'Eranikus - 69% - Tyrande Say 0'),
 (15491, 0, 35, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 15633, 30, 0, 0, 0, 0, 0,'Eranikus - 30% - Tyrande Say 1'),
 (15491, 0, 19, 0, 2, 0, 100, 1, 0, 25, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - 25% - Say 9'),
 (15491, 0, 20, 0, 2, 0, 100, 1, 0, 22, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - 22% - Say 10'),
 (15491, 0, 21, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - 20% - Say 11'),
 (15491, 0, 22, 0, 52, 0, 100, 0, 11, 15491, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - Friendly'),
 (15491, 0, 23, 0, 52, 0, 100, 0, 11, 15491, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - Passive'),
 (15491, 0, 24, 0, 52, 0, 100, 0, 11, 15491, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - Flags'),
 (15491, 0, 25, 0, 52, 0, 100, 0, 11, 15491, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - No AutoAttack'),
 (15491, 0, 26, 0, 52, 0, 100, 0, 11, 15491, 0, 0, 1, 12, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 11 - Say 12'),
 (15491, 0, 27, 0, 52, 0, 100, 0, 12, 15491, 0, 0, 12, 15628, 3, 60000, 0, 0, 0, 8, 0, 0, 0, 7904.248, -2564.867, 488.156, 5.116,'Eranikus - Say 12 - Summon Eranikus the Redeemed'),
 (15491, 0, 28, 0, 52, 0, 100, 0, 12, 15491, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 12 - Kill'),
 (15491, 0, 31, 0, 7, 0, 100, 0, 0, 0, 0, 0, 6, 8736, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0,'Eranikus - Evade - Quest Fail'),
 (15491, 0, 32, 0, 6, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Death - Unseen'),
 (15491, 0, 33, 0, 40, 0, 100, 0, 5, 15491, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - WayPoint 5 - Unseen'),
 (15491, 0, 36, 0, 40, 0, 100, 0, 5, 15491, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - WayPoint 5 - Die'),
 (15491, 0, 37, 0, 40, 0, 100, 0, 5, 15491, 0, 0, 6, 8736, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0,'Eranikus - WayPoint 5 - Quest Fail');
DELETE FROM `waypoints` WHERE `entry` = 15491;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (15491, 1, 7949.812, -2605.4748, 513.591,'Eranikus'),
 (15491, 2, 7931.3330, -2575.2097, 489.6286,'Eranikus'),
 (15491, 3, 7925.129, -2573.747, 493.901,'Eranikus'),
 (15491, 4, 7910.554, -2565.5534, 488.616,'Eranikus'),
 (15491, 5, 7867.442, -2567.334, 486.946,'Eranikus');
-- NPC: Nightmare Phantasm, http://old.wowhead.com/npc=15629
DELETE FROM `creature_text` WHERE `entry` = 15629;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (15629, 0, 0,"Nightmare Phantasm drinks in the suffering of the fallen.", 16, 0, 100, 0, 0, 0,'Nightmare Phantasm Say 0');
UPDATE `creature_template` SET AIName = 'SmartAI', Faction_A = 14, Faction_H = 14 WHERE entry = 15629;
DELETE FROM `smart_scripts` WHERE entryorguid = 15629;
INSERT INTO `smart_scripts` VALUES
 (15629, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 53, 1, 15629, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - Summon - Start WayPoint'),
 (15629, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - Summon - Aggresive'),
 (15629, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - Summon - Attack Player'),
 (15629, 0, 3, 0, 6, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - Death - Say 0'),
 (15629, 0, 4, 0, 40, 0, 100, 0, 4, 15629, 0, 0, 53, 1, 15629, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - WayPoint 20 - Start Again'),
 (15629, 0, 5, 0, 1, 0, 100, 1, 60000, 60000, 60000, 60000, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - OOC 60 Secs - Unseen'),
 (15629, 0, 6, 0, 1, 0, 100, 1, 63000, 63000, 63000, 63000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - OOC 63 Secs - Despawn'),
 (15629, 0, 7, 0, 1, 0, 100, 1, 5000, 5000, 5000, 5000, 53, 1, 15629, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Nightmare Phantasm - OOC 5 Secs - Start WayPoint');
DELETE FROM `waypoints` WHERE entry = 15629;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (15629, 1, 7891.990, -2566.737, 487.385,'Phantasm'),
 (15629, 2, 7865.966, -2554.104, 486.967,'Phantasm'),
 (15629, 3, 7901.544, -2581.989, 487.178,'Phantasm'),
 (15629, 4, 7918.844, -2553.987, 486.911,'Phantasm'),
 (15629, 5, 7873.412, -2587.454, 486.946,'Phantasm');
-- NPC: Eranikus the Redeemed, http://old.wowhead.com/npc=15628
DELETE FROM `creature_text` WHERE entry = 15628;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (15628, 0, 0,"For so long, I was lost... The Nightmare's corruption had consumed me... And now, you... all of you.. you have saved me. Released me from its grasp.", 12, 0, 100, 0, 0, 0,'Eranikus the Redeemed Say 0'),
 (15628, 1, 1,"But... Malfurion, Cenarius, Ysera... They still fight. They need me. I must return to the Dream at once.", 12, 0, 100, 0, 0, 0,'Eranikus the Redeemed Say 0'),
 (15628, 2, 2,"My lady, I am unworthy of your prayer. Truly, you are an angel of light. Please, assist me in returning to the barrow den so that I may return to the Dream. I like Malfurion, also have a love awaiting me... I must return to her... to protect her...", 12, 0, 100, 0, 0, 0,'Eranikus the Redeemed Say 0'),
 (15628, 3, 3,"And heroes... I hold that which you seek. May it once more see the evil dissolved. Remulos, see to it that our champion receives the shard of the Green Flight.", 12, 0, 100, 0, 0, 0,'Eranikus the Redeemed Say 0');
UPDATE `creature_template` SET `AIName` = 'SmartAI', `modelid1` = 6984 WHERE `entry` = 15628;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15628;
INSERT INTO `smart_scripts` VALUES
 (15628, 0, 0, 0, 1, 0, 100, 1, 7000, 7000, 7000, 7000, 1, 0, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus the Redeemed - OOC 7 Secs - Say 0'),
 (15628, 0, 1, 0, 52, 0, 100, 0, 0, 15628, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 0 - Say 1'),
 (15628, 0, 2, 0, 52, 0, 100, 0, 1, 15628, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 1 - Say 2'),
 (15628, 0, 3, 0, 52, 0, 100, 0, 2, 15628, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Eranikus - Say 2 - Say 3'),
 (15628, 0, 5, 0, 52, 0, 100, 0, 3, 15628, 0, 0, 15, 8736, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0,'Eranikus - Say 3 - Credit'),
 (15628, 0, 6, 0, 52, 0, 100, 0, 3, 15628, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 11832, 40, 0, 0, 0, 0, 0,'Eranikus - Say 3 - Cast Trigger');
-- Quest: I Sense a Disturbance, http://old.wowhead.com/quest=12665
-- NPC: Har'koa's Kitten, http://old.wowhead.com/npc=28665
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28665;
UPDATE creature_template SET `AIName` = "SmartAI" WHERE `entry` = 28665;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (28665, 0, 0, 0, 27, 0, 100, 0, 0, 0, 0, 0, 53, 1, 28665, 0, 12665, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Summon - Start Waypoint"),
 (28665, 0, 1, 0, 39, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint satart - Talk"),
 (28665, 0, 2, 0, 40, 0, 100, 0, 9, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's point  9 - Talk"),
 (28665, 0, 3, 0, 40, 0, 100, 0, 17, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's point  17 - Talk"),
 (28665, 0, 4, 0, 40, 0, 100, 0, 20, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's point 20 - Talk"),
 (28665, 0, 5, 0, 40, 0, 100, 0, 31, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint point 31 - Talk"),
 (28665, 0, 6, 0, 58, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's end - Talk"),
 (28665, 0, 7, 0, 58, 0, 100, 0, 0, 0, 0, 0, 15, 12665, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's end - Quest Credit"),
 (28665, 0, 8, 0, 58, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Har'koa's Kitten - On Waypoint's end - Despawn");
DELETE FROM `creature_text` WHERE `entry` = 28665;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
 (28665, 0, 0, "Thank you for saving me, $n. This is the least that I could do to return the favor. Hold on tight. Here we go.", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten"),
 (28665, 1, 0, "This doesn't look good. Whatever you do, don't fall off. There's a ton of nasty things in there!", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten"),
 (28665, 2, 0, "Oh no... Quetz'lun is dead! Stay still. We'll sneak past the prophet.", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten"),
 (28665, 3, 0, "We're spotted! Hang on. We have to get out of here!", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten"),
 (28665, 4, 0, "I think we're safe now. Let's get back!", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten"),
 (28665, 5, 0, "We made it! Take care, $n, and thanks again!", 15, 0, 100, 0, 0, 0,"Har'koa's Kitten");
DELETE FROM `waypoints` WHERE `entry` = 28665;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
 (28665, 1, 5334.57, -3770.34, 371.738, "Har'koa's Kitten"),
 (28665, 2, 5341.49, -3763.27, 373.082, "Har'koa's Kitten"),
 (28665, 3, 5359.41, -3745.77, 360.961, "Har'koa's Kitten"),
 (28665, 4, 5419.57, -3779.82, 361.97, "Har'koa's Kitten"),
 (28665, 5, 5488.22, -3792.21, 359.627, "Har'koa's Kitten"),
 (28665, 6, 5520.7, -3823.19, 360.316, "Har'koa's Kitten"),
 (28665, 7, 5540.3, -3840.06, 371.987, "Har'koa's Kitten"),
 (28665, 8, 5713.77, -3894.3, 371.987, "Har'koa's Kitten"),
 (28665, 9, 5714.99, -3946.71, 371.987, "Har'koa's Kitten"),
 (28665, 10, 5715.95, -4017.95, 372.113, "Har'koa's Kitten"),
 (28665, 11, 5717.52, -4056.45, 353.828, "Har'koa's Kitten"),
 (28665, 12, 5715.8, -4185.27, 354.05, "Har'koa's Kitten"),
 (28665, 13, 5715.45, -4205.83, 362.833, "Har'koa's Kitten"),
 (28665, 14, 5731.33, -4235.67, 362.812, "Har'koa's Kitten"),
 (28665, 15, 5719.13, -4261.2, 373.995, "Har'koa's Kitten"),
 (28665, 16, 5721.82, -4331.67, 374.16, "Har'koa's Kitten"),
 (28665, 17, 5723.08, -4353.09, 385.48, "Har'koa's Kitten"),
 (28665, 18, 5730.15, -4373.79, 386.154, "Har'koa's Kitten"),
 (28665, 19, 5732.12, -4383.98, 386.963, "Har'koa's Kitten"),
 (28665, 20, 5704.71, -4384.82, 386.039, "Har'koa's Kitten"),
 (28665, 21, 5700.17, -4369.4, 385.802, "Har'koa's Kitten"),
 (28665, 22, 5711.85, -4354.38, 386.067, "Har'koa's Kitten"),
 (28665, 23, 5716.23, -4329.61, 373.994, "Har'koa's Kitten"),
 (28665, 24, 5715.73, -4259.08, 374.341, "Har'koa's Kitten"),
 (28665, 25, 5708.79, -4237.19, 362.789, "Har'koa's Kitten"),
 (28665, 26, 5708.68, -4205.41, 362.85, "Har'koa's Kitten"),
 (28665, 27, 5715.09, -4186.25, 353.89, "Har'koa's Kitten"),
 (28665, 28, 5717.31, -4053.01, 354.093, "Har'koa's Kitten"),
 (28665, 29, 5717.52, -4017.17, 372.313, "Har'koa's Kitten"),
 (28665, 30, 5714.48, -3888.2, 371.715, "Har'koa's Kitten"),
 (28665, 31, 5605.33, -3900.46, 372.897, "Har'koa's Kitten"),
 (28665, 32, 5549, -3829.23, 372.155, "Har'koa's Kitten"),
 (28665, 33, 5535.53, -3809.89, 360.648, "Har'koa's Kitten"),
 (28665, 34, 5367.99, -3754.56, 360.487, "Har'koa's Kitten"),
 (28665, 35, 5340.69, -3762.64, 373.08, "Har'koa's Kitten"),
 (28665, 36, 5321.37, -3787.91, 371.341, "Har'koa's Kitten");
-- Quest: You Reap What You Sow, http://old.wowhead.com/quest=12685
UPDATE `quest_template` SET `Method` = 2, `ReqSourceId1` = 39187, `ReqSourceId2` = 0, `ReqSourceCount1` = 1, `ReqSourceCount2` = 0 WHERE `entry` = 12685;
-- Quest: Delivering the Message, http://old.wowhead.com/quest=10406
-- NPC: Protectorate Demolitionist, http://old.wowhead.com/npc=20802
UPDATE `quest_template` SET `SrcSpell` = 35679 WHERE `entry` = 10406;
UPDATE `creature_template` SET `ScriptName` = 'npc_protectorate_demolitionist' WHERE `entry` = 20802;
-- Quest: The Plains of Nasam, http://old.wowhead.com/quest=11652
-- NPC: Horde Siege Tank, http://old.wowhead.com/npc=25334
-- NPC: Injured Warsong Mage, http://old.wowhead.com/npc=27107
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 27107;
INSERT INTO `creature_ai_scripts`(`id`,`creature_id`,`event_type`,`event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action1_param2`,`action2_type`) VALUES (27107, 27107, 8, 47962, -1, 33, 27109, 6, 37);
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 27107;
UPDATE `creature_template` SET `npcflag` = 16777216 WHERE `entry` = 25334;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 25334;
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`) VALUES (25334, 47917, 11652, 1, 0, 1);
DELETE FROM `conditions` WHERE SourceEntry = 25334;
-- INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES (16, 0, 25334, 0, 0, 23, 0, 4027, 0, 0, 0);
DELETE FROM `spell_area` WHERE `spell` = 47917;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES (47917, 4027, 11652, 1, 11652, 0, 0, 2, 0), (47917, 4130, 11652, 1, 11652, 0, 0, 2, 0);
-- Quest: Coward Delivery... Under 30 Minutes or it's Free, http://old.wowhead.com/quest=11711
UPDATE `quest_template` SET `Method` = 2 WHERE `entry` = 11711;
-- Item: Warsong Flare Gun, http://old.wowhead.com/item=34971
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45958;
INSERT INTO `spell_linked_spell` VALUES (45958, 45956, 0, 'Wasrong Flare Gun');
-- NPC: Ug'thor Bloodfrenzy, http://old.wowhead.com/npc=25426
-- NPC: Warden Nork Bloodfrenzy, http://old.wowhead.com/npc=25379
DELETE FROM `creature_ai_texts` WHERE entry IN (-160065, -160066);
DELETE FROM `creature_text` WHERE `entry` IN (25379, 25426);
INSERT INTO `creature_text` VALUES
 (25379, 0, 0, 'Look at this deserters,son!They are like this pigs - dirty,useless and stupid!', 12, 0, 100, 1, 0, 0, 'Borean Tundra'),
 (25426, 0, 0, 'Yes,dad,i see...', 12, 0, 100, 1, 0, 0, 'Borean Tundra');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 25426;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25426;
UPDATE creature_template SET `AIName` = "SmartAI" WHERE `entry` = 25426;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (25426, 0, 0, 0, 1, 0, 100, 0, 50000, 50000, 90000, 90000, 1, 0, 0, 0, 0, 0, 0, 19, 25379, 0, 0, 0.0, 0.0, 0.0, 0.0,"Borean Tundra - Random OOC Say");
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25379;
UPDATE creature_template SET `AIName` = "SmartAI" WHERE `entry` = 25379;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (25379, 0, 0, 0, 1, 0, 100, 0, 45000, 45000, 85000, 85000, 1, 0, 0, 0, 0, 0, 0, 19, 25426, 0, 0, 0.0, 0.0, 0.0, 0.0,"Borean Tundra - Random OOC Say"),
 (25379, 0, 1, 0, 19, 0, 100, 0, 11711, 0, 0, 0, 11, 45975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"On Quest Accept - Summon Deserter");
-- NPC: Valiance Keep Officer, http://old.wowhead.com/npc=25759
DELETE FROM `creature` WHERE `id` = 25759;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 25759;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25759;
UPDATE creature_template SET `AIName` = "SmartAI" WHERE `entry` = 25759;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (25759, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 45981, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"On Summon - Quest credit"),
 (25759, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"On Summon - Faction"),
 (25759, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"On Summon - Despawn");
-- NPC: Scout Tungok, http://old.wowhead.com/npc=25440
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 25440;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25440;
UPDATE creature_template SET `AIName` = "SmartAI" WHERE `entry` = 25440;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (25440, 0, 0, 0, 2, 0, 100, 0, 30, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,"Scout Tungok - Casts Enrage at 30% HP"),
 (25440, 0, 1, 0, 20, 0, 100, 0, 11711, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 19, 25761, 0, 0, 0.0, 0.0, 0.0, 0.0,"Kill Alliance Deserter.");
-- NPC: Alliance Deserter, http://old.wowhead.com/npc=25761
DELETE FROM `creature_template_addon` WHERE `entry` = 25761;
INSERT INTO `creature_template_addon` VALUES (25761, 0, 0, 0, 0, 0, 45957);
UPDATE `creature_template` SET `speed_run` = 2 WHERE `entry` = 25761;
-- Quest: The Deathstalkers, http://old.wowhead.com/quest=1886
-- NPC: Astor Hadren, http://old.wowhead.com/npc=6497
UPDATE `creature_template` SET `gossip_menu_id` = 126,`AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 6497;
DELETE FROM `gossip_menu` WHERE `entry` = 126 AND `text_id` = 623;
INSERT INTO `gossip_menu`(`entry`,`text_id`) VALUES (126, 623);
DELETE FROM `gossip_menu` WHERE `entry` = 125 AND `text_id` = 624;
INSERT INTO `gossip_menu`(`entry`,`text_id`) VALUES (125, 624);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (126, 125);
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
 (126, 0, 0, "You''re Astor Hadren, right?", 1, 1, 125),
 (125, 0, 0, "You''ve got something I need, Astor. And I''ll be taking it now.", 1, 1, 0);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6497;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
 (6497, 0, 0, 0, 62, 0, 100, 0, 125, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - Make Hostile on Gossip Select');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 126;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES
 (15, 126, 0, 0, 9, 14420, 'Show Gossip Option If quest The Deathstalkers(new) is Incomplete');
-- Quest: Return to the Earth, http://old.wowhead.com/quest=12417
-- Quest: Return to the Earth, http://old.wowhead.com/quest=12449
-- Item: Ruby Acorn, http://old.wowhead.com/item=37727
DELETE FROM `conditions` WHERE `SourceEntry` = 37727;
-- INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES (13, 37727, 24, 1, 27530);
UPDATE `quest_template` SET `ReqSourceId1` = 37727,`ReqSourceCount1` = 6,`ReqItemId1` = 0,`ReqItemCount1` = 0,`ReqCreatureOrGOCount1` = 6,`ReqCreatureOrGOId1` = 27530 WHERE `entry` = 12449;
-- Quest: If Chaos Drives, Let Suffering.. http://www.wowhead.com/quest=12678
DELETE FROM `creature_ai_scripts` WHERE `id` IN (17374,17619,17691,17692,17693,17618);
UPDATE `creature_template` SET `KillCredit1` = 28764 WHERE `entry` IN (28557,28841);
-- Quest: Down at the Docks, http://www.wowhead.com/quest=910
-- Quest: Gateway to the Frontier, http://www.wowhead.com/quest=911
-- Quest: Lordaeron Throne Room, http://www.wowhead.com/quest=1800
-- Quest: The Bough of the Eternals, http://www.wowhead.com/quest=1479
-- Quest: Spooky Lighthouse, http://www.wowhead.com/quest=1687
-- Quest: Defense of the Stonewrought Dam, http://www.wowhead.com/quest=13652
-- Quest: A Trip to the Dark Portal (Alliance), http://www.wowhead.com/quest=10952
-- Quest: A Trip to the Dark Portal (Horde), http://www.wowhead.com/quest=10951
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (3551, 3549, 3547, 3546, 3552, 3548, 4356);
INSERT INTO `areatrigger_scripts`(`entry`,`ScriptName`) VALUES
 (3551,'at_bring_your_orphan_to'),
 (3549,'at_bring_your_orphan_to'),
 (3547,'at_bring_your_orphan_to'),
 (3546,'at_bring_your_orphan_to'),
 (3552,'at_bring_your_orphan_to'),
 (3548,'at_bring_your_orphan_to'),
 (4356,'at_bring_your_orphan_to');
-- Quest: The Way to His Heart..., http://old.wowhead.com/quest=11472
-- NPC: Reef Bull, http://old.wowhead.com/npc=24786
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 24786;
UPDATE creature_template SET `AIName` = 'SmartAI' WHERE `entry` = 24786;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24786;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
 (24786, 0, 0, 1, 8, 0, 100, 0, 44454, 0, 0, 0, 11, 44456, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reef Bull - On Spell Hit - Cast Spell'),
 (24786, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reef Bull - On Spell Hit - Despawn');
-- NPC: Attracted Reef Bull, http://old.wowhead.com/npc=24804
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 24804;
UPDATE `creature_template` SET `ScriptName` = 'npc_attracted_reef_bull', `AIName` = '' WHERE `entry` = 24804;
-- Item: Anuniaq's Net, http://old.wowhead.com/item=40946
-- Spell: Anuniaq's Net, http://old.wowhead.com/spell=21014
DELETE FROM `spell_script_names` WHERE `spell_id` = 21014;
INSERT INTO `spell_script_names` VALUES 
 (21014, 'spell_anuniaqs_net');
-- -------------------------------------------------------------------------}
-- ---------------------- Myth Project "NPCs" Update -----------------------
-- -------------------------------------------------------------------------{
-- NPC: Horde Gunship Cannon, http://old.wowhead.com/npc=34935
UPDATE `creature_template` SET `VehicleId` = 453 WHERE `entry` = 34935;
-- NPC: Alliance Gunship Cannon, http://old.wowhead.com/npc=34929
UPDATE `creature_template` SET `VehicleId` = 452 WHERE `entry` = 34929;
-- NPC: Runeforge (SE), http://old.wowhead.com/npc=28481
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 28481;
-- NPC: Acherus Dummy, http://old.wowhead.com/npc=28367 - correct spawning
UPDATE `creature` SET `MovementType` = 0 WHERE `id` = 28367 AND `MovementType` = 2;
-- NPC: Val'kyr Guardian/Protector, http://old.wowhead.com/npc=38392#comments
UPDATE `smart_scripts` SET `event_type` = 63 WHERE `entryorguid` IN (38391, 38392) AND `event_type` = 25;
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` IN (38391, 38392);
-- -------------------------------------------------------------------------}
-- -------------------- Myth Project "Events" Update -----------------------
-- -------------------------------------------------------------------------{
-- Game Event: Noblegarden, http://old.wowhead.com/event=181
UPDATE `game_event` SET `start_time` = "2012-04-08 02:00:00",`end_time` = "2012-04-15 00:00:00" WHERE `eventEntry` = 9;
-- -------------------------------------------------------------------------}
-- -------------------- Myth Project "Spells" Update -----------------------
-- -------------------------------------------------------------------------{
-- Enchant: Enchant Weapon - Fiery Weapon, http://www.wowhead.com/spell=13898
-- UNKNOWN SPELL: Fiery Weapon, http://ru.wowhead.com/spell=13897
DELETE FROM `spell_bonus_data` WHERE `entry` IN (13898, 13897);
INSERT INTO `spell_bonus_data` VALUES
 (13897, 0, 0, 0, 0,"Enchant Weapon - Fiery Weapon");
-- Death Knight: Rune of Cinderglacier, http://wotlk.openwow.com/?spell=53341
DELETE FROM `spell_proc_event` WHERE `entry` = 53386;
INSERT INTO `spell_proc_event`(`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
 (53386, 0x30, 0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0, 0, 0);
-- Death Knight: Threat of Thassarian, http://wotlk.openwow.com/?spell=66192
DELETE FROM spell_proc_event WHERE entry IN (65661, 66191, 66192);
INSERT INTO spell_proc_event VALUES
 (65661, 0, 15, 0x00400011, 0x20020004, 0x00000000, 0x00000010, 0x00000003, 0, 30.000000, 0),
 (66191, 0, 15, 0x00400011, 0x20020004, 0x00000000, 0x00000010, 0x00000003, 0, 60.000000, 0),
 (66192, 0, 15, 0x00400011, 0x20020004, 0x00000000, 0x00000010, 0x00000003, 0, 100.000000, 0);
-- Druid: T10 P4 (Balance)
DELETE FROM `spell_proc_event` WHERE `entry` = 70723;
-- Priest: Shadowfiend, http://old.wowhead.com/spell=34433
DELETE FROM `spell_proc_event` WHERE `entry` = 28305;
INSERT INTO `spell_proc_event` VALUES (28305, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);
-- Mage: Missile Barrage (Rank 5), http://wotlk.openwow.com/?spell=54490
-- NOTE: Arcane Blast a $h% chance, and your Arcane Barrage, Fireball, Frostbolt and Frostfire Bolt spells a ${$h/2}% chance
UPDATE `spell_proc_event` SET `CustomChance` = 0,`Cooldown` = 0,`SpellFamilyName` = 0 WHERE `entry` IN (44404, 54486, 54488, 54489, 54490);
-- Paladin: http://base.wow-legendary.net/?spell=20165
DELETE FROM `spell_proc_event` WHERE `entry` = 20165;
INSERT INTO `spell_proc_event` VALUES (20165, 1, 10, 0xC0000000, 0x1010000, 0, 0, 0, 20, 0, 0);
-- Death Knight: Summon Gargoyle, http://www.wowhead.com/spell=49206
INSERT INTO `spell_linked_spell` VALUES (61777, 50514, 2, 'Part of DK Summon Gargoyle scheme');
INSERT INTO `spell_script_names` VALUES (50514, 'spell_dk_summon_gargoyle_trigger');
-- -------------------------------------------------------------------------}
-- -------------------- Myth Project "Items" Update ------------------------
-- -------------------------------------------------------------------------{
-- Item: Abracadaver, http://old.wowhead.com/item=50966
-- Item: Abracadaver (Heroic), http://old.wowhead.com/item=51887
-- NPC: Futuresight Rune, http://old.wowhead.com/item=38763
UPDATE `creature_template` SET `minlevel` = 80,`maxlevel` = 80,`mindmg` = 701,`maxdmg` = 801 WHERE `entry` = 38763;
-- Item: Ephemeral Snowflake, http://www.wowhead.com/item=50260
ALTER TABLE `spell_proc_event` DROP PRIMARY KEY;
ALTER TABLE `spell_proc_event` ADD PRIMARY KEY (`entry`,`SpellFamilyName`);
DELETE FROM `spell_proc_event` WHERE `entry` = 71567;
INSERT INTO `spell_proc_event` VALUES
 (71567, 0, 7, 0xF0, 0x6212010, 0x0, 0, 0, 180, 0, 0),
 (71567, 0, 6, 0x5F401A40, 0x9C19025, 0x80009A04, 0, 0, 180, 0, 0),
 (71567, 0, 5, 0x1080008, 0, 0, 0, 0, 180, 0, 0),
 (71567, 0, 9, 0x800000, 0, 0x80000000, 0, 0, 180, 0, 0),
 (71567, 0, 10, 0xC0A88000, 0x1032001, 0x80000000, 0, 0, 180, 0, 0),
 (71567, 0, 11, 0x240821C4, 0x4085802, 0x80000251, 0, 0, 180, 0, 0);
-- Item: Meteoric Crystal, http://old.wowhead.com/item=46051
-- UNKNOWN SPELL: Meteoric Inspiration, http://old.wowhead.com/spell=64999
-- UNKNOWN SPELL: Meteoric Inspiration, http://old.wowhead.com/spell=65000
UPDATE `spell_proc_event` SET `ppmRate` = 0,`CustomChance` = 100 WHERE `entry` = 64999;
-- Item: Trauma, http://old.wowhead.com/item=50028
-- Item: Trauma (Heroic), http://old.wowhead.com/item=50685
DELETE FROM `spell_proc_event` WHERE `entry` IN (71868, 71865);
INSERT INTO `spell_proc_event`(`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`CoolDown`) VALUES
 (71868, 1, 10, 0, 0, 0, 278528, 24, 0, 1, 0),
 (71865, 1, 10, 0, 0, 0, 278528, 24, 0, 1, 0);
-- Item: Tiny Abomination in a Jar, http://old.wowhead.com/item=50351
-- Item: Tiny Abomination in a Jar (Heroic), http://old.wowhead.com/item=50706
UPDATE `spell_proc_event` SET `procFlags` = 4, `CustomChance` = 45, `Cooldown` = 0 WHERE `entry`  IN (71406, 71545);
-- Item: Storm Gauntlets, http://old.wowhead.com/item=12632
-- UNKNOWN SPELL: Increase Spell Dam 18, http://old.wowhead.com/spell=9346
-- UNKNOWN SPELL: Add Lightning Dam - Weap 03, http://old.wowhead.com/spell=16615
DELETE FROM `spell_bonus_data` WHERE `entry` IN (9346, 16615);
INSERT INTO `spell_bonus_data` VALUES
 (9346, 0, 0, 0, 0, NULL), (16615, 0, 0, 0, 0, NULL);
-- Item: Scarlet Courier's Message, http://old.wowhead.com/item=39647 - page text enUS
UPDATE `page_text` SET `text` = "High General,\n\r\n\rThe armies of Hearthglen and Tirisfal are less than a day\'s ride from New Avalon. We ride with the Light shining upon our backs and the wind at our heels. Soon the Scourge will have to contend with the full might of the Scarlet Crusade!\n\r\n\rLight Bless You,\n\r\n\rHigh Commander Galvar Pureblood" WHERE `entry` = 3120;
-- Item: Turning the Other Cheek, http://old.wowhead.com/item=39361 - page text enUS
UPDATE `page_text` SET `text` = "The topic of indulgences is a difficult one, but at times in our lives, it becomes a necessary evil. A lapse of judgment, a harsh word too quickly spoken, a punch or kick thrown in anger - all these things are failings of mortal men, and the Church must acknowledge that.\r\n\r\nHowever, such acknowledgement does not come without a price. For sins of harsh words, a mere handful of silver will cleanse the soul. For sins of physical force, a handful of gold will expurgate the failings of mortal flesh. For those other sins, a full confession and a more generous contribution will be necessary." WHERE `entry` = 3117;
UPDATE `page_text` SET `text` = "Punching:\r\n  Punch to the Face : 2 gold\r\n  Punch to the Groin: 3 gold\r\n  Punch in the Chest: 1 gold 45 silver\r\n\r\n<A detailed list of prices and sins continues for pages>" WHERE `entry` = 3118;
-- Item: News From The North, http://old.wowhead.com/item=39317 - page text enUS
UPDATE `page_text` SET `text` = "To High General Abbendis\r\nNew Avalon, Scarlet Lands\r\n\r\nHigh General Abbendis,\r\n\r\nI hope this letter finds you in good health. My name is Dansel Adams, hunter by trade, Scarlet Crusader by blood. I am writing this letter to inform you that I have witnessed a miracle." WHERE `entry` = 3110;
UPDATE `page_text` SET `text` = "During a routine purging of heathens in the Scourge infested Plaguewood, my party and I were interrupted by a deafening screech coming from the sky. When we looked to the heavens, towards Naxxramas, our jaws dropped to the floor. I tell you this now, High General, \'twas a sight not to be believed! The dread citadel was moving. Slowly at first and then with a thunderous roar - poof - it was gone!\r\n\r\nThat\'s right, High General, Naxxramas is gone! No more! Could it be anything other than a miracle of the Light? I say not!" WHERE `entry` = 3111;
UPDATE `page_text` SET `text` = "May it be that the impure, unkempt barbarians, are judged and sentenced next. Praise be the Light!\r\n\r\nPlease let our brothers and sisters know of this miracle, High General.\r\n\r\nMay the Light preserve you for all eternity so that you may spread the good word until the end of days.\r\n\r\nRespectfully,\r\n\r\nD. Adams\r\n'The Closer'" WHERE `entry` = 3112;
-- -------------------------------------------------------------------------}
-- ---------------- Myth Project "World" Database Cleaner ------------------
-- -------------------------------------------------------------------------{
UPDATE `creature_addon` SET `auras` = REPLACE(`auras`," 0",'');
UPDATE `creature_template_addon` SET `auras` = REPLACE(`auras`," 0",'');
UPDATE `creature_addon` SET `auras` = TRIM(`auras`);
UPDATE `creature_template_addon` SET `auras` = TRIM(`auras`);
ALTER TABLE `creature_ai_scripts` CHANGE `id` `id` int(5);
-- -------------------------------------------------------------------------
DELETE FROM `command` WHERE `name` = 'wchange';
-- -------------------------------------------------------------------------
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` IN (15381, 15414, 15422, 15423, 15424, 15454);
UPDATE `creature_template_addon` SET `auras` = 68269 WHERE `entry` = 36021;
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` = 180633;
UPDATE `gameobject_loot_template` SET `groupid` = 3 WHERE `entry` = 179697 AND `item` = 18706;
UPDATE `npc_spellclick_spells` SET `spell_id` = 55029 WHERE `spell_id` = 55028;
-- -------------------------------------------------------------------------
 DROP TABLE IF EXISTS
 `db_version_ytdb`,         -- DEPRICATED TABLE
 `npc_gossip`,              -- DEPRICATED TABLE
 `game_event_npc_gossip`,   -- DEPRICATED TABLE
 `lfg_dungeon_encounters`,  -- DEPRICATED TABLE
 `gameobject_respawn`,      -- DEPRICATED TABLE
 `creature_respawn`,        -- DEPRICATED TABLE
 `reserved_name`,           -- DEPRICATED TABLE
 `custom_texts`,            -- DEPRICATED TABLE
 `id`,                      -- DEPRICATED TABLE
 `locales_item_set_name`;   -- DEPRICATED TABLE
/* -- -------------------------------------------------------------------------
SET @MINUS := xxx; SET @MAXG := xxx;
-- CREATURES
UPDATE `creature` SET `guid` = `guid` - @MINUS WHERE `guid` > @MAXG;
UPDATE `creature_addon` SET `guid` = `guid` - @MINUS WHERE `guid` > @MAXG;
UPDATE `creature_formations` SET `leaderGUID` = `leaderGUID` - @MINUS WHERE `leaderGUID` > @MAXG;
UPDATE `creature_formations` SET `memberGUID` = `memberGUID` - @MINUS WHERE `memberGUID` > @MAXG;
-- GAMEOBJECTS
UPDATE `gameobject` SET `guid` = `guid` - @MINUS WHERE `guid` > @MAXG;
UPDATE `pool_gameobject` SET `guid` = `guid` - @MINUS WHERE `guid` > @MAXG; */
-- -------------------------------------------------------------------------
-- CREATURES
 DELETE FROM `creature` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);                            -- Dinamic // "creature" table
 DELETE FROM `creature_template_addon` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);          -- Dinamic // "creature_template_addon" table
 DELETE FROM `creature_formations` WHERE `leaderGUID` NOT IN (SELECT `guid` FROM `creature`)
OR `memberGUID` NOT IN (SELECT `guid` FROM `creature`);                                                         -- Dinamic // "creature_formations" table
 DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`); -- Dinamic // "creature_onkill_reputation" table
 DELETE FROM `linked_respawn` WHERE `linkedguid` NOT IN (SELECT `guid` FROM `creature`);                        -- Dinamic // "linked_respawn" table
 DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);                              -- Dinamic // "creature_addon" table
 DELETE FROM `battlemaster_entry` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);               -- Dinamic // "battlemaster_entry" table
-- -------------------------------------------------------------------------
-- GAMEOBJECTS
 DELETE FROM `gameobject` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);                        -- Dinamic // "gameobject" table
 DELETE FROM `gameobject_scripts` WHERE `id` NOT IN (SELECT `guid` FROM `gameobject`);                          -- Dinamic // "gameobject_scripts" table
 DELETE FROM `gameobject_involvedrelation` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);       -- Dinamic // "gameobject_involvedrelation" table
 DELETE FROM `gameobject_loot_template` WHERE `entry` NOT IN (SELECT `entry` FROM `gameobject_template`);       -- Dinamic // "gameobject_loot_template" table
 DELETE FROM `gameobject_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `gameobject_template`);          -- Dinamic // "gameobject_questrelation" table
-- -------------------------------------------------------------------------
-- EVENT AI
 DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (
SELECT `entry` FROM `creature_template` WHERE `AIName` NOT IN ("EventAI"));                                     -- Dinamic // "creature_ai_scripts" table
-- -------------------------------------------------------------------------
-- POOLS
 DELETE FROM `pool_creature` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);                               -- Dinamic // "creature_pool" table
 DELETE FROM `pool_gameobject` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);                           -- Dinamic // "gameobject_pool" table
-- -------------------------------------------------------------------------}
-- ----------------- Myth Project "Anti - Cheating" System -----------------
-- -------------------------------------------------------------------------{
DROP TABLE IF EXISTS `warden_data_result`;
CREATE TABLE `warden_data_result` (
  `id` int(4) NOT NULL,
  `check` int(3) DEFAULT NULL,
  `data` varchar(48) DEFAULT NULL,
  `str` varchar(20) DEFAULT NULL,
  `address` int(8) DEFAULT NULL,
  `length` int(2) DEFAULT NULL,
  `result` varchar(24) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `warden_data_result` VALUES
 (1, 178,"07F223143C69271AA2A851FECF6DC883A9D3A7DBA6FE26CC",'', 710730, 23,'', null),
 (2, 191,"C7D18F99DBC446A4B36E78B9130B6FA2E365B3D2D4199DF5",'', 28940, 17,'', null),
 (3, 191,"AA1A8559776F873F26954F15E49E6041EDC2C3766AD87A59",'', 21826, 11,'', null),
 (4, 178,"5F342A4D0EA9DB35F93FAE6E32670D810F017309817AA7C0",'', 676970, 23,'', null),
 (5, 178,"C57BD89DD447131EA2083784AB4DA8BD58CF3E182F1D8AF6",'', 690106, 23,'', null),
 (6, 191,"69AA85EFE8A1A990DA5ECFED4FAFD5B14F1D52EF2548FD15",'', 12905, 36,'', null),
 (7, 191,"083ECAD073DE2D61E3564B4BF767C9D1F8F15AA0495F5A76",'', 41096, 24,'', null),
 (8, 178,"C774D64EF60AD5A141FC56F3D02AE78AC147770FAE25D8FE",'', 3037164, 22,'', null),
 (9, 191,"502C59CAFEA11E9584C13BFE75F85EB79936AEEE31B44165",'', 12194860, 37,'', null),
 (10, 178,"4FBE8978A662428C616AABD71DA5562E4AC21F54BEB8ADBF",'', 3037164, 22,'', null),
 (11, 178,"83D3F7FD7DCA144AD8219A6A4E20F0CFC6E7EA208C4144FF",'', 3033068, 22,'', null),
 (12, 243,'','', 4623652, 7,"578B7D08578BF1","Pointer to realmlist address"),
 (13, 178,"00523153EE2298A8D80D7B26B7067CA7B26AC06FF374FE7B",'', 673210, 23,'', null),
 (14, 191,"91BC368FA14A3FE3E13D0B1056F485F846925E613D8E8903",'', 12194860, 37,'', null),
 (15, 243,'','', 10010636, 12,"8166443FFF1FFFD9565CD95E", null),
 (16, 178,"8FEFDBC58301AB0E0D0F6EBC5FBDA5ED9A7126873A9AB337",'', 682394, 23,'', null),
 (17, 191,"B40FF92D4F092599EA9014C88B474DE4352C3F1635109882",'', 448492, 48,'', null),
 (18, 191,"42B596FF923054531E4918DC39E08F8564FED16D559B494A",'', 29852, 20,'', null),
 (19, 178,"24291D6733A7CEFA3D54C3BCCAE95D56D8365BAB42AEE1CE",'', 3037164, 22,'', null),
 (20, 178,"6C4E321E2D5A153F2BB664EB6EEDF8D67FDE7ECC8076D087",'', 3990720, 23,'', null),
 (21, 178,"FB649706C8F1AFF5990B5F3118DFE54FF6F9609C6991C161",'', 3045776, 31,'', null),
 (22, 191,"D1B451C906B81261B048FD4025217245950C11660815367F",'', 28920, 23,'', null),
 (23, 191,"40079A1083A6B57E3B713992BD395FB6650B631E4C4B8D4E",'', 29852, 20,'', null),
 (24, 178,"3F8FEFE08CB358D6613656AFDB498AB8C599BA18B5574FB6",'', 682378, 23,'', null),
 (25, 191,"EECA71B5536EE1992FD7825A5CCC4B7F9F3B413C0DA498B6",'', 29884, 20,'', null),
 (26, 191,"B8786BFF2421ED1F1FB30F3F0BAF671FC1DAD5B3B33124C8",'', 28956, 17,'', null),
 (27, 191,"BF0C842D635D9D8B3F6FF84EF6DF7C963C485EBAF02D17B0",'', 28920, 23,'', null),
 (28, 191,"9672ED2A27C4972E04DF4471C95492C721024E241995170C",'', 36924, 24,'', null),
 (29, 191,"63532B056020A261251BD24AB026BBC5D4468AF863136044",'', 17906, 11,'', null),
 (30, 178,"7D38C80FEAB10B857A4A7BEF15D27A58FB43FD875E29C73C",'', 3990720, 23,'', null),
 (31, 178,"B158752316672A90BF29846E7AD64BA4FD1699C638BFD3B6",'', 2299116, 33,'', null),
 (32, 178,"4549AE7CA28700562D996CBC78FA7341DC05F644C01474E4",'', 3000288, 31,'', null),
 (33, 178,"EE77806A4F5723FD9C6FC6F43308C8AB448E0A139CB43700",'', 690106, 23,'', null),
 (34, 191,"046D6EA3E99E275F51CAA591BD8C478B6F964A3072018F43",'', 21660, 15,'', null),
 (35, 178,"B1682CE919907AD7D8990F3D8272CFF24A996162565D52B4",'', 676970, 23,'', null),
 (36, 178,"22E057649A8BF1D9672841EF47A4DA175AAC082FFEF059DA",'', 710730, 23,'', null),
 (37, 178,"7BA62D5F5CFEB545D1AE646962F4EB9A91B93EF8FFD5D1B0",'', 710554, 23,'', null),
 (38, 178,"702802D919D9E5C3FD42CA9188936C73E47F87CFA419025A",'', 3033068, 22,'', null),
 (39, 178,"FDA6D997BFB8A991B57755633D1AB3C7E567A74C1EC09937",'', 3070052, 22,'', null),
 (40, 191,"84F6BDD28490937867774E7BF8D5B78F68BF9EB43DE90F10",'', 477912, 60,'', null),
 (41, 191,"5A5B4BA32BD937FF253016AE836DD44B794F8D05982860A6",'', 447736, 48,'', null),
 (42, 178,"A243986665C7FCA1E60A9F209DE9431C3098D082DF1C4528",'', 682378, 23,'', null),
 (43, 178,"7CC89374CE3A9C07DCD685006690B828931D60085EE5FEE8",'', 710554, 23,'', null),
 (44, 191,"01F10590E6DFED79523D26C043D5424174BEF1011F3F4974",'', 477928, 60,'', null),
 (45, 178,"C9728BDC4B77BAA7B3515AFD3628EDB0986DFA20B46917B4",'', 672746, 23,'', null),
 (46, 191,"179B80E5E054521E44BA8F5978D5FC489CC9E514B350A3FF",'', 28956, 17,'', null),
 (47, 243,'','', 5417948, 5,"7734FF2485","FrameXML Signature Check"),
 (48, 191,"7769A67D6E2460450873133B0CFF99B67A58CE6C404A17F8",'', 17282, 15,'', null),
 (49, 178,"CF3896074EEBC0F93B539FD44E4D825227D4C1556B8F2279",'', 3990720, 23,'', null),
 (50, 178,"88F2833B5267A71A0CA72509C40819B99283A6E556FD9038",'', 198, 10,'', null),
 (51, 243,'','', 8491566, 5,"8B4D10890D","Lua DoString"),
 (52, 178,"F7229DF2D879A9E8D5BCEDCDC7046D75BAEE1C9D4DA41E55",'', 3638348, 23,'', null),
 (53, 191,"AE78585CD862134059B13669FC416B8124752EC6471DDCE6",'', 28940, 17,'', null),
 (54, 191,"B408E9F9B475E4B6A81F9B7F2E060824F618FFDABBFFE805",'', 13634, 11,'', null),
 (55, 178,"A9DA016B83961F95097E08F2DEBE69517C7573FFF06D8C4B",'', 668874, 23,'', null),
 (56, 191,"0E74160C242EF826D09BCE4ED535E9A9D251B1CD20E31891",'', 24812, 14,'', null),
 (57, 178,"A58E4D44D952C1F9DB7B5E423167EE4C28AD02668C5B86AF",'', 710730, 23,'', null),
 (58, 191,"35A9FC42ACBF3A147B0C8CF67BA04EC979C6534B20249B45",'', 28956, 12,'', null),
 (59, 243,'','', 5345746, 7,"746583F9177760","Lua Protection Patch"),
 (60, 191,"1430DC4A627EA5FA2CFF9C010CE16022F259F81DB6047879",'', 13634, 11,'', null),
 (61, 191,"85A005398AF851382267C01BB6FB04AEF2093213C20EC200",'', 360508, 13,'', null),
 (62, 191,"96916CD89649027A9A8BBFBD28AE190CD5D590E24BBAD451",'', 13033, 36,'', null),
 (63, 191,"056D57A5C1A46883400E1F69405750B23DE18C3032C3D91C",'', 27270, 13,'', null),
 (64, 191,"87C641E1EDBD96D9F170C7BE0FA13F45611DCDF41AC02526",'', 41127, 24,'', null),
 (65, 191,"1F378DF1E7BD99164DDC7401A98CA5E9551BD50B4A35D5AA",'', 34176, 25,'', null),
 (66, 178,"B5ED443D6CA2F6095BAC8DAFDC8F3413F7B473916357C17E",'', 209352, 75,'', null),
 (67, 191,"A2BC3FF01787A38CB88B3EF45C1CD97DA113157FC395D38C",'', 30012, 16,'', null),
 (68, 191,"190862E5018F1428E5B12BFDAD08283ECD057B34AD722846",'', 41228, 24,'', null),
 (69, 191,"6E0E55BE8690F64442E275559E6C9F8A3FDCAA00937D1C13",'', 49347, 24,'', null),
 (70, 191,"B6FC4C07BB2CBE7C5C854CD99DAFEC0D1AE4101FC51460F9",'', 477912, 60,'', null),
 (71, 178,"3B5955C3B498489869990F08A4CAE566A7D689C23990518B",'', 156, 8,'', null),
 (72, 243,'','', 7246064, 6,"8950108B450C","Movement State related"),
 (73, 178,"F24317DAA28AA477996EEBB9538A89569ABF9B185A3EA4E4",'', 718842, 23,'', null),
 (74, 178,"DA25A4134671325719833878E2556455EC4321A2207B6728",'', 198, 10,'', null),
 (75, 191,"DC9490A7BEB43C64585E013B5260BE843D126EB3BCEBAC11",'', 50040, 26,'', null),
 (76, 178,"4BB92BBD5CA8C192C9D0E1EDB6C21FF3F4A61ED1B151365F",'', 673210, 23,'', null),
 (77, 178,"13E8DD1C9F5501A270A59CC4B61311F6D5D18DC3F2AA351A",'', 3037164, 22,'', null),
 (78, 191,"346CFA39FF98198BDE1C23673FBF51A50CFF5ADED784F077",'', 17522, 15,'', null),
 (79, 113,"0590FC57AB448975FA46C314A8AB75AF96DF0FD0A3D9FB23","Afd32uu", 0, 0,'', null),
 (80, 178,"E37D413DC96A92D3CEAB8A482B8F5397587A0E654C9A0166",'', 672954, 23,'', null),
 (81, 178,"E7D5551799C2C7F0072BC3149A22F37D09EA1EB83F64C655",'', 3045912, 31,'', null),
 (82, 191,"7CC5260578671130CA5B3392BA5CFD0F3DE0BE1085E556B6",'', 9977, 32,'', null),
 (83, 191,"F44A40945F24385D089E040A733553EEFF92EFAAB0636323",'', 134968, 32,'', null),
 (84, 178,"D3122CF30EE55310CF4A710E61B190D2B108227B746B41AD",'', 679578, 23,'', null),
 (85, 191,"7E3CC1BC53477D84F05F623BBC94B9DE8D01A2607CA935DB",'', 41188, 24,'', null),
 (86, 191,"DC06565CC1512B5A91A848E08BC4FBC6DA705F6503667852",'', 41127, 24,'', null),
 (87, 191,"03DC47CDFBB14C5CF0D0010FA5424556F951585588A2180A",'', 29916, 16,'', null),
 (88, 191,"29EC91C4D87891FECDED381CE65A86A259F00DD788833E4D",'', 174688, 37,'', null), -- ATI TRAY TOOLS
 (89, 191,"31F024003681765368F6EFB667E83CE1D12799723AA99BF9",'', 685304, 44,'', null),
 (90, 191,"6A82AC1D0BFEF5DA7385510CBC57189FACD42E45E0D2A65E",'', 30012, 16,'', null),
 (91, 191,"3901FBD52655E12ADA4EEDED3B365B1DDFAAA925A140097F",'', 448492, 48,'', null),
 (92, 191,"6E9991A25EC347BEA5813EDE0A842D746779C97606565B5A",'', 17906, 11,'', null),
 (93, 191,"0AC9F2B104AC5AA9131FB14E669B98D30D056936625B0245",'', 27270, 13,'', null),
 (94, 178,"A338B3DA78A6683CBEE08A63C5EEFBE1AF33BF54983D583D",'', 684876, 29,'', null),
 (95, 178,"38759C29F2ACF42DA9D16EF35837A470DC7C42C3284B2A3C",'', 3049492, 22,'', null),
 (96, 191,"F35817564FC39F4DB7994021352FEEB86E2FEE86C11B8DBB",'', 360508, 13,'', null),
 (97, 191,"09FAC087283873DAEE0AD074ABF7DDB1B395F5CF6BC2141E",'', 28956, 17,'', null),
 (98, 178,"87FE57916743AF3C97CC3B583B29E89B6E503D31D1747B64",'', 676970, 23,'', null),
 (99, 178,"97D854645011BAD1F6625679511D78D1B7367A51EB0FCC6E",'', 668874, 23,'', null),
 (100, 178,"12369F6F1B875FB5CC5E67445ADEAE2B295D196596679317",'', 0, 9,'', null),
 (101, 191,"5034278808E93A3DFC9BEFFD8E180FEFA24DFC5056ED3BE1",'', 433168, 48,'', null),
 (102, 178,"55EF16220A7EF3F74A9D895821610DFBD2A757FB05C792D5",'', 209352, 75,'', null),
 (103, 191,"67445533AA0BB737D2F74C9258148C6C667794F0E3D07498",'', 45324, 24,'', null),
 (104, 178,"AA8649100B17A9C5BE227F47F867FADE51AD242BAAD39821",'', 3045632, 31,'', null),
 (105, 191,"85545FE9242B2474574EEBABBF452FBD11497073CB1E46A5",'', 41080, 24,'', null),
 (106, 191,"9DACD6981681F53650B681EAE68065D26F4803682058709D",'', 448456, 48,'', null),
 (107, 191,"96B74F1436A05E658E3282164BC3CBDF4DBBB2CF6A5B866F",'', 9977, 32,'', null),
 (108, 191,"033BD6861DF7878DC9470EC2F699772BB2F3D5000490866F",'', 90202, 13,'', null),
 (109, 113,"B797D0AF3164EE83167D5C054A511A5B209A70C6655C408B","IPSect", 0, 0,'', null),
 (110, 178,"D91A2764435C5091D3F9471AB8B5F397E609330294694488",'', 710730, 23,'', null),
 (111, 191,"94EED02DCDB71789E50917DA401A03F4B91BDBEA050D8BCA",'', 3766400, 37,'', null),
 (112, 178,"2DF33CBB544E2D5238FB591F2547AC507B4D8A652D789F2B",'', 2303444, 33,'', null),
 (113, 243,'','', 7860712, 5,"742DF6407C", null),
 (114, 178,"81A74F35F0F887144D59F93647C18C70C5FEEF542A7F3782",'', 709322, 22,'', null),
 (115, 178,"2E1F8A68FDDF084A950B786A1EE7E0CE43E62449A56F92A3",'', 3045632, 31,'', null),
 (116, 191,"B1F8988B6664A90E79503FA5D843C3CB97BFDC23EB8C7690",'', 433168, 48,'', null),
 (117, 178,"0277E26DE31814DFD675A59E526669E39080E033BAE88859",'', 0, 9,'', null),
 (118, 243,'','', 10714892, 8,"BB8D243FD4D0313E","Wall Climb"),
 (119, 178,"09BBFC19FCADC69D6B5BF655A5BB6350B4A8120C3EB557D2",'', 3990720, 23,'', null),
 (120, 178,"BF4ABDEB726B0060E74701C03180C3CB02170ADCB7DCB61C",'', 3049872, 31,'', null),
 (121, 243,'','', 9990741, 9,"8B878000000089463C","No Fall Damage Patch"),
 (122, 178,"D259A46A6D1855C436BFC96FB9376BDCDF5E9FFAE8B4147C",'', 3045616, 31,'', null),
 (123, 178,"F425A62A44097742D72A05669B6BE93AD9CEFE9E40D71E48",'', 3045976, 31,'', null),
 (124, 191,"B134291F515D136B6576FFBC0133C7859755974611170D07",'', 20512, 16,'', null),
 (125, 191,"125BE691985D8DB37068DC14D74EA2DA1260E4A63D3F74BF",'', 45324, 24,'', null),
 (126, 178,"E06E3C5B356B34BA92F6765108556AD53ABB74B986D5810E",'', 3070052, 22,'', null),
 (127, 178,"8CC87DFF61F2EC82DE033865C9879010D94E1614369FE286",'', 710554, 23,'', null),
 (128, 191,"E1F5233450FEFFB6F0E8F2B17683047A485828FEDD3E5B80",'', 448456, 48,'', null),
 (129, 191,"31BA6EA4DF2362676AB71F4CB60B0D40FA51A3AABD25D5CB",'', 36924, 24,'', null),
 (130, 191,"C14630E1D519EB85C254C536FE81DC490977E869BD5CD884",'', 12985, 36,'', null),
 (131, 191,"B337F892EEDD52A5B978C116A19D927134273626EFC4DAA3",'', 17890, 11,'', null),
 (132, 191,"D97560108AA21A487EC9278759F7615BFA304A933776A201",'', 18680, 35,'', null),
 (133, 178,"DA59505BA61459508532CBEAD246DCD2C8E7BF5C6D3CE676",'', 3037164, 22,'', null),
 (134, 191,"5803CA69E5B7F1DF08D95219894D75F52EDB1AD429E562D9",'', 174688, 37,'', null),
 (135, 178,"8A1099E19139D91573286DBB3DED2CC093A99FD178F7FEC8",'', 3033068, 22,'', null),
 (136, 178,"0331B438B085F55C06F7F697160845BE953D9CE789AA62A4",'', 3000288, 31,'', null),
 (137, 191,"E844078A5671FF7DB0621E7F1C7EDDF9C92F5A9FA0477FCB",'', 41023, 24,'', null),
 (138, 178,"AAD7F47B231861913F353341FD26E5AA89AFB586FB6A5366",'', 672746, 23,'', null),
 (139, 178,"136DFB3FE66D2830DF46EE155FCAEADC9624FFE1410088DA",'', 3041472, 31,'', null),
 (140, 191,"C6015A0D5C9109768BA4233639A51F163CC7ED58749E5026",'', 25724, 20,'', null),
 (141, 178,"9C668CE4D328EEA9B6AB7AD5FF54169289B35B230275A43C",'', 3049872, 31,'', null),
 (142, 178,"FC3C95E71F968C46BD5DB5C9EF9B0A5BDCC5619B805046F5",'', 2299060, 33,'', null),
 (143, 178,"FBE3808C0E36BFBC1D1F5A0E508CA89E81E550CD2FDEEC48",'', 149, 5,'', null),
 (144, 178,"35A8252DBC65514E858256C497141153812EE61C724BF5A9",'', 710730, 23,'', null),
 (145, 178,"CC79AA9AE29A52A998181D183D38974221B8BAC0AB534E7D",'', 0, 9,'', null),
 (146, 178,"B89F25A249D295580E649F5ABE0C65EC24401F4889A4FB16",'', 668874, 23,'', null),
 (147, 178,"742A0A9997B9E857C355AA75797466506BAE73D44D26399D",'', 3037164, 22,'', null),
 (148, 178,"E7975701601B2FDF8262098521B7BB4FF5CCC484F8E919E7",'', 3045776, 31,'', null),
 (149, 178,"43E81BE830F169F4EDD23B84ABFA9D15EF12C978FE134346",'', 60648, 56,'', null),
 (150, 178,"66CA9E464A2122E301A72FAEF13A4853D8CB1A45C177E854",'', 178504, 96,'', null),
 (151, 113,"0A3C294B0799FD2C9EC17C1CCBCD174A51B6A2ECC62FEF17","IPSect", 0, 0,'', null),
 (152, 178,"6E9CE81BFCAF0C250705FCC599981D2D9E4D474A7E857B37",'', 2299108, 33,'', null),
 (153, 178,"8734D6E081D5C993DCE8161CFDFC6197F39A487E4083A3E1",'', 149, 5,'', null),
 (154, 178,"A33355AF7B5FF3CECB3A6059F6621F30AEE695D69421EA2B",'', 3049492, 22,'', null),
 (155, 191,"BF8CEA63013511BDE0B551DAAC492DFBB9608645140B88F7",'', 29916, 16,'', null),
 (156, 178,"8D5D5E99EAB2ED21A104913B05D6BD7A8E63ADA56B66CDED",'', 3022016, 31,'', null),
 (157, 191,"778256BFEF82EA60C4E0F25083655FB2BB75B83FD60A9C06",'', 18680, 35,'', null),
 (158, 178,"43FB8007D7DD7B01FFBEEA3EF9D0242778565544281EC761",'', 0, 9,'', null),
 (159, 191,"94DCF5D21FE2106F5303216C14AD55EEDC1B19FDC91D5F76",'', 28704, 16,'', null),
 (160, 191,"7EBBF90F7D8462D1453479DF9AC5943AF483FE2828C74FDD",'', 477928, 60,'', null),
 (161, 191,"A171148491E099B12CCD1708B784D8C3B09737772C7780C0",'', 401992, 14,'', null),
 (162, 191,"5350ACB75F9FA498FE0D2A371649C9FD9716BDDE2C32F5FB",'', 13634, 11,'', null),
 (163, 191,"85E53280630956C58D4CA7FD8DC5FE73C9A2A03314DFF294",'', 45223, 24,'', null),
 (164, 191,"391BC8A81D4EB6D526BAF0DC3468CAA36C9207B82E194B7A",'', 130380, 14,'', null),
 (165, 191,"0F88FA5CD9B9950F850C18FE76C948FF43CDDE3E75638FF1",'', 17938, 11,'', null),
 (166, 178,"EB63FC60164AFF92726DA658882BF1CE47CF0BF6C80B1B97",'', 690106, 23,'', null),
 (167, 178,"E30B2494142B416BBE95DA3DAE4A82CBDF3A020715F10E8B",'', 4011280, 23,'', null),
 (168, 191,"6CA1C19D0E9191CBC9CA3D5BC3CF1D19764D8F17C6B54AE4",'', 59620, 13,'', null),
 (169, 178,"4730B7A7EC70544A688211A5C754C357A090116092D3EC4D",'', 682378, 23,'', null),
 (170, 243,'','', 10000022, 6,"894644894E54", null),
 (171, 191,"713A7B79619AEF3C47E44102F86EDCE0D6AFBC5ABE87F861",'', 13538, 11,'', null),
 (172, 191,"575F1C6AF7C71085C7D9CB2291844D9F2DA3B71391C0B941",'', 36907, 24,'', null),
 (173, 178,"296F233E4FAC4CF419D5FBF2701AC4D5AA0866CB4D0DAEC6",'', 3045976, 31,'', null),
 (174, 178,"933C1A228C99E35DF309838B25B7D5EA3A8E961E81D81D32",'', 673194, 23,'', null),
 (175, 191,"9EC125252C3738478CA942DCB59030097194B284A9162B32",'', 59620, 13,'', null),
 (176, 178,"6665F3FB8DC6BE71C152C3674B5783D6E57FE8BF796D190C",'', 3634252, 23,'', null),
 (177, 191,"E120DD63042FEFF9E7FCEC0CA44D2544F03C5D4CDBA1C008",'', 12985, 36,'', null),
 (178, 113,"09BDABA6CB17BE561B4104124A3D0266C858D194A8765198","drvsys_mon", 0, 0,'', null),
 (179, 178,"3AAE69E7088E4060EA32EF95E9B6D9532460F5B84EE4EC80",'', 684876, 29,'', null),
 (180, 191,"990D4E1C2D63C8E447F034642686D57B727064E3EDE13B00",'', 448500, 48,'', null),
 (181, 191,"E88F31BDC5513216CF3701CAF8BE954CCC7EAE0E7AC7D942",'', 594348, 26,'', null),
 (182, 178,"81229C1E56FA72E01B52E8CBB8BB5F55ED48A11B72E7729B",'', 710554, 23,'', null),
 (183, 191,"B4D0CDE7D53493A1549328F711013F07DBD3A9BE88DB2EF9",'', 685304, 44,'', null),
 (184, 178,"D6CA6F94FF248F722F97037C1AE7C8DE0191D5F4D1E3A5B8",'', 156, 8,'', null),
 (185, 178,"9C9DF1E868BB33D43676F21096C4F75759C0807096EEB886",'', 60648, 56,'', null),
 (186, 178,"1C79B3B5A74A4F09A1FAE19BB15CDCF26B5F917861071F1C",'', 198, 10,'', null),
 (187, 178,"AC1AD3E831A4C758858350A8A197A24FE82583F4B0E39A85",'', 3049888, 31,'', null),
 (188, 178,"56E4980485E3129E94F370E7066E80B07141C4A669B9FC0F",'', 672746, 23,'', null),
 (189, 178,"C21574305E0377A3D2B72D1E1546B9D62DCFA8B1A4405F16",'', 3638348, 23,'', null),
 (190, 178,"AA74121AF835978BC1C1BB402A8B7388CB7C075C1227C253",'', 3049888, 31,'', null),
 (191, 178,"D6457A86DFADF9825D6093090AED2A807FE7DA6ECF5922AF",'', 3065956, 22,'', null),
 (192, 191,"1BAB7E6B5ACBEED8F54B667EDF13A385B9E146C0C50D9FB7",'', 448456, 48,'', null),
 (193, 243,'','', 7517484, 7,"7518683B010000","Follow Unit Check"),
 (194, 178,"01000FEAC61ED76FE04ED1169C40289D96C71A1564E38FCB",'', 690106, 23,'', null),
 (195, 191,"F095338ED87C658C916CC604A427F4ED95309C4A07B7898C",'', 34176, 25,'', null),
 (196, 191,"800E120187DF74A231722FB887B3944AD16A703FB8CB9D39",'', 28920, 23,'', null),
 (197, 191,"2CFCE981C322A54724E1418B6A6D1896B95D584630EEEA43",'', 38300, 21,'', null),
 (198, 243,'','', 5081862, 8,"6840AAB600C60200", null),
 (199, 178,"481751066D6C97AD5EE90173E8ED107BB1C9FD873B0CE55A",'', 3037164, 22,'', null),
 (200, 178,"7FC57D49535798CDA7E4DC5DCEA2E085AAB9A68BF7F9469D",'', 149, 5,'', null),
 (201, 191,"33357C112DE0195F013FAAC4D57AB1BE77417934CE03A2B9",'', 3766400, 37,'', null),
 (202, 191,"BF8AC678DC3CD354BADBFE46C9173D34CC84D13302190EBB",'', 21826, 11,'', null),
 (203, 178,"4E2F9721D52A7552AE2728B9695F1523DD62DC0569237C3F",'', 2299108, 33,'', null),
 (204, 191,"9F015E7D8A11F30AA1954D9FEA7142D0247E3C09FF2BFF72",'', 12194860, 37,'', null),
 (205, 178,"1EB5AD39B94DB5CDC3294DF49FA589DFBE2C674D07E4B211",'', 710730, 23,'', null),
 (206, 178,"E9D67F07E035A64B89C9E91614DC1930FEF61DC3A5C1BBA6",'', 690106, 23,'', null),
 (207, 191,"36411C2FF2C3AC51B7F6A6B8DF61DBD4E5895C27438847BE",'', 59620, 13,'', null),
 (208, 178,"A77F30CBB8057E0DB37782367C8462FA98D4DB21DE936ECD",'', 3049492, 22,'', null),
 (209, 243,'','', 7452688, 10,"8B81CC07000025000000","WoWEmuHacker Injection"),
 (210, 178,"A8C806E1FB7CA3625E6BB6F5E4D9E2BF0EBDBE70BA7226F7",'', 3049872, 31,'', null),
 (211, 191,"B3DD04807DEA2679045F4F197BDDAED5C7CCEEFE19622B43",'', 360508, 13,'', null),
 (212, 178,"B075C8B4D8C5D83FE703677319491DC816EA5103901B44A8",'', 682394, 23,'', null),
 (213, 191,"53DB506C0341B50BEA3897E2E3C0DD74C2CA2D8F5F34A2E4",'', 59620, 13,'', null),
 (214, 191,"E112F38956124FE0F48BF569F5E81B40E293DC6E16B544D6",'', 17282, 15,'', null),
 (215, 191,"0363EF2B1AAE09E6C2B1FA555E706F4EE094BE678DA27598",'', 3766400, 37,'', null),
 (216, 191,"EA256F01B6340C99E27611B39C5ED28CF2FA202436F0972F",'', 49564, 24,'', null),
 (217, 178,"A86C95C4E58495A10F5F1C9B5B62D3365132E8DC62863E8B",'', 198, 12,'', null),
 (218, 191,"56DD8D99991F83AFA2E169315B395BD388B248340E9C64D3",'', 30044, 16,'', null),
 (219, 191,"684B23E010C3D6B88CC12BD9F0B6B0CE00D692C71BFB84A8",'', 28940, 17,'', null),
 (220, 178,"83AEEFCDF4C2E80B18DDF93D99120A89F916C19206D257AB",'', 668874, 23,'', null),
 (221, 178,"D68651921F5CD387C7E860FB7C3B143409735748E3B2FB7F",'', 682394, 23,'', null),
 (222, 113,"A4D501A9DB9D84BD8695A8BF61FC853BF434D2D4B352C7A0","HideEx", 0, 0,'', null),
 (223, 191,"5E77F12C032D4FEF559F9B837B85BDB9D95ADB10C9F56649",'', 448504, 48,'', null),
 (224, 178,"F08406AEDFA8F19B6FB7C9ADDE0BFEE82CB0D2E275593150",'', 2303444, 33,'', null),
 (225, 178,"AC0EC72522ADA5B2BFFAFAC92D6D0A0225E1D5C727CDFFA7",'', 672602, 23,'', null),
 (226, 178,"4D1A7D1C88AB04438510E3255184E51EAE2036BB09DB553A",'', 700714, 23,'', null),
 (227, 178,"68BBC36F75DC763B573DACAB1D6D8F70E667638AA894BEE9",'', 717898, 23,'', null),
 (228, 178,"2AC3C23FBDE2C1EC46C9ECFF71BD7F603F17C9DFC1328D1C",'', 3638348, 23,'', null),
 (229, 191,"C365E9FE00580EBB14EE863A5CE3C8139B1A59A610520AE7",'', 3766400, 37,'', null),
 (230, 178,"DB2A0451B9753100085C9D149B61CE47A195D77C8B709143",'', 178504, 96,'', null),
 (231, 178,"0871F69205FA62C74C2DDE200A3911FC3E41A4FB8BAB9817",'', 682378, 23,'', null),
 (232, 191,"0017307F2FF889462B0FA06018D99EB1F847F189B6CC9B99",'', 21826, 11,'', null),
 (233, 178,"0FEFCD6B0BF8C2816A9259AB5FD7B89231AEB8D92DE53D26",'', 3045356, 22,'', null),
 (234, 178,"87EAD79656133B3183C2E452886D8F00C5EC6C9D741673A2",'', 3037164, 22,'', null),
 (235, 178,"C2B6C5E19FA98D121B2CDE51789BD2883A324015E7D131E0",'', 710554, 23,'', null),
 (236, 178,"B6F3A7D557A3E3BC4833C3D9B6B0B0609255591CC8AB3B65",'', 3022016, 31,'', null),
 (237, 243,'','', 5283280, 12,"558BECB8084E0000E8731DF0","AddChatMessage"),
 (238, 191,"AEA87B23CD9463E9693B6C053C1D9030F8E229DA308DBF29",'', 90202, 13,'', null),
 (239, 178,"8C16C7E8EEAD49AE67E4E91E229FFBCE2F6590A48348914E",'', 3049888, 31,'', null),
 (240, 178,"7B2DCA97CD348E45490C288EADE9303CE270CF57F28EB1E4",'', 690106, 23,'', null),
 (241, 191,"BC10B10BE398F2397FA6962C4E59C8CF11FDD7158EC222A5",'', 29916, 16,'', null),
 (242, 178,"8E53EC1B8ABE90C9A5C087671DE0A3007BEA4488EE5415D0",'', 3037164, 22,'', null),
 (243, 191,"65B5CE07A794164101F7E379D21A7A544EF1EC2A3A39A2D8",'', 27270, 13,'', null),
 (244, 191,"C6C8597824F249180A53196699421ADF7857A5C4E4F80D6F",'', 13033, 36,'', null),
 (245, 178,"FE677759E719178BC5CB49DA252D9B635F76030FC4C9876C",'', 673194, 23,'', null),
 (246, 243,'','', 5265823, 5,"72118B5518","Language Patch"),
 (247, 178,"BA2D161EF412084B0229A08E64D5A445C4E9F9F2645535E5",'', 706314, 23,'', null),
 (248, 191,"0174B647A535F206711D3EEEF08D3F421BCABD7016A2F103",'', 17282, 15,'', null),
 (249, 178,"5F5F754FD6E7BAC9650B715387646CF992813730A2BA37DA",'', 2303444, 33,'', null),
 (250, 178,"D2CC7F98209E9A9BBA483BD1E9A916E40EB971EE2129AFF8",'', 3990720, 23,'', null),
 (251, 178,"E8C741CC79005898FFD0026821F61A2E4E67C695C6E1CE1C",'', 198, 10,'', null),
 (252, 191,"23B364A9012EF40A39EC4D04A91F9B60FC7EF7D85E3F240A",'', 18680, 35,'', null),
 (253, 191,"C9363F808D37F13FC09EBB7F700AD09EEB27DA046E41FD52",'', 36907, 24,'', null),
 (254, 191,"2D92FC5B8603E18F50D9CAA0922F5C7BB89E42A4656ED2D5",'', 3766400, 37,'', null),
 (255, 178,"EDEDBC5B1A3D92D2A91192118898FDBF840C967C82968D70",'', 3045912, 31,'', null),
 (256, 113,"BFEF06E80472106B57B15D711F94A25243F6ABA7FE354C95","ndis_x86", 0, 0,'', null),
 (257, 178,"FB20B0EB9ACF571FE37C6B69CBE86F7906F96B996D7E5EFA",'', 2303444, 33,'', null),
 (258, 191,"917AC1C48C1FF354FD594A3705C70A2C356FE981275E7FB5",'', 22792, 25,'', null),
 (259, 178,"48CD29D8B39DC07B0FD071FD8C643E07A8FC2C9AFC2A3083",'', 3045356, 22,'', null),
 (260, 243,'','', 11154396, 8,"D893FEC0488C11C1","Jump Momentum"),
 (261, 191,"FB13A8360C8E23B83ED7309625A7EFBAEE7DCF737068C5A6",'', 174688, 37,'', null),
 (262, 191,"3C8D85F85ED5DD0354561F84EACA575123DE05EE941C28D2",'', 56063, 25,'', null),
 (263, 191,"FBC20EEA52B5882209BC016EC14818376CA7BAF28780BCED",'', 22792, 25,'', null),
 (264, 191,"210D85A84F7BE48F3EB427E0CBCCD9C146320ABAAB5E28D8",'', 41096, 24,'', null),
 (265, 178,"953107F9F718795B6DF9E5E5BEE0EA949800CAD0EB71F891",'', 3037164, 22,'', null),
 (266, 113,"FBBA36D0FC5434D12EE1509E148FF908D51F18719CCBEABC","IPSect", 0, 0,'', null),
 (267, 178,"82CB32BA2A05B228F2F8D0313C185EB6FDC50A94340F40C8",'', 209352, 75,'', null),
 (268, 191,"079172B91B1768A2650A87BAB06AF700BB4C9A0B5E5B983B",'', 17522, 15,'', null),
 (269, 191,"881751DF112F817E799953E00E94543DA4610968437DB7C6",'', 12194860, 37,'', null),
 (270, 191,"9A47B274EAAC888FA2007B4EC0623580365458E3621CC416",'', 28956, 17,'', null),
 (271, 191,"77344CE014111FAAA66DEF35B670B2E76AE878B054F85285",'', 61874, 42,'', null),
 (272, 191,"0A74CBD8DFF245DA5E8691C1174F037D7ABE823E265226AB",'', 685656, 44,'', null),
 (273, 178,"0E13ADDD413B679E2984060D929440064FAC308FC2B90742",'', 3049872, 31,'', null),
 (274, 178,"D0D8CE5001596C6F4A766FE94726FE7E337F42469CB96CA1",'', 3065956, 22,'', null),
 (275, 191,"313C58F8401B47F716B220B88411CAD0E85966D95B301591",'', 13033, 36,'', null),
 (276, 178,"ACBDC68A4D748C48ED1180DD3DA52632EA6FC275BFC35D5B",'', 0, 9,'', null),
 (277, 191,"BACA83A742B9E09CD07787BC6B50389707EA94C41886BAD0",'', 448504, 48,'', null),
 (278, 178,"549B42D266E7F17B7F30B72E301A9CB3C5E3865DE9B7E90B",'', 60648, 56,'', null),
 (279, 178,"86DB854557D75BEEE7DA820FCA15669B08C760E8B165B06F",'', 3037164, 22,'', null),
 (280, 178,"02D5FBD9E30D43ACED0EFD00CF16DAA69EDD262C292136AB",'', 178504, 96,'', null),
 (281, 191,"B9D920131EFC38767012340CF0FFBFE154DBA28E6EF3B859",'', 61874, 42,'', null),
 (282, 191,"96E6CAE70AF690F5D552E0948C29CA9AA527DEBF9731B16B",'', 20512, 16,'', null),
 (283, 191,"375B22B4990997348A8AEDD53319897BE196398B4F1DBAC3",'', 30012, 16,'', null),
 (284, 178,"932F4622AE9F1B3990900F1F88375FA1DD7C238F7C6133C6",'', 684876, 29,'', null),
 (285, 178,"43583C7BCCD9DF14C64CC84710BEE44DD30E199F579890AE",'', 3049872, 31,'', null),
 (286, 191,"97CF98F0BCABA04BC2BAD40FBD4EBFB3C1FD8A7139D5C9B9",'', 433168, 48,'', null),
 (287, 178,"97A0E0F8F8ACE7F1E6492DAFADE8F45B366446E79C1B0419",'', 3049452, 22,'', null),
 (288, 243,'','', 5284488, 9,"7507C7451400000000","Language Patch"),
 (289, 191,"C3546D16052E0DC1838E7A6E18936B88CC8A40C2AEC0BE3B",'', 21826, 11,'', null),
 (290, 178,"4179D6BD8C2F11AD5D5C103A7877504074009AB53AE4D8A6",'', 3045356, 22,'', null),
 (291, 191,"2C360CEAB996C8D6E5DE3FFAC30E412DED48E7814D1CE110",'', 20512, 16,'', null),
 (292, 191,"6F1486BE58078BD453F1B249947BB99CB8E17E9A355CE024",'', 41228, 24,'', null),
 (293, 178,"924F4631DC3167BCFAB02F92DDB49A871DA0C55122EF9EB8",'', 0, 9,'', null),
 (294, 178,"411029C5B28D942ED3C7BC1F4299162D874838A661410894",'', 700714, 23,'', null),
 (295, 191,"B9093BAED730E86AF004119B3B7258938C56902915C2E8BA",'', 501956, 48,'', null),
 (296, 178,"63BD2D7FF6C5442795361031E5768C396A37AE38AF98DB11",'', 668874, 23,'', null),
 (297, 191,"754A2FE56037B971E128FFAA669032C511BDA3A62524CE03",'', 28956, 12,'', null),
 (298, 178,"9AEFDCDB62EBC2DABD6CEBF8C411C1145274FCA7CED890CB",'', 3037164, 22,'', null),
 (299, 178,"3AC57BAC3B782AE5ADBB899CCC060D4E8F66E5217F7DF654",'', 676970, 23,'', null),
 (300, 191,"2F0D9702A58D6D5A8599529A0A816AA101AFE581D98416B2",'', 56063, 25,'', null),
 (301, 178,"77804219E627B4D38C9F95194301A895180B598AEFA9963F",'', 3022016, 31,'', null),
 (302, 178,"0D1B99EDC8E458705A88E72F7FDEEE9233DB21290A0098E6",'', 149, 5,'', null),
 (303, 191,"BB795B4069F985BF44C7418DE264C3B0E9BA6D61A116FF81",'', 90202, 13,'', null),
 (304, 191,"5A6EEBA1E6B9EE71BD4A5F63014E9928302C36FC806DC796",'', 3766400, 37,'', null),
 (305, 191,"BA5777AF7FFF3895935669878D662B585912A759A2DFCE68",'', 24812, 14,'', null),
 (306, 178,"5E690DB1AD8910886334158C6D4452FA2CE896634BCDDF40",'', 580768, 52,'', null),
 (307, 191,"42A8F651F55F697E783ADA1959A2833276F970F1EE0410C7",'', 41280, 16,'', null),
 (308, 243,'','', 5296496, 12,"558BEC81ECE80D00006A0AE8","SendChatMessage"),
 (309, 191,"445A6894B8C1838462D7D0D29FBE6BF815B5E6C344971349",'', 31924, 23,'', null),
 (310, 178,"C010786A38F396503B7411FBADA0C1A68795F54A7AAE228E",'', 679578, 23,'', null),
 (311, 113,"E3185EE4428291F9D2E4080C2EB1B19ADB005AD26EF0A993","IPSect", 0, 0,'', null),
 (312, 243,'','', 7739760, 11,"01BE80000000E805B6FFFF","Jump related?"),
 (313, 191,"1995FA3235ADA4B25232DC6403E7463A8D1864528BF9FDD4",'', 12905, 36,'', null),
 (314, 243,'','', 5124558, 5,"8BF08D4608","GetCharacterInfo"),
 (315, 191,"30A26827798B7F1646003A9E846E8A9A8FF10A9DF926825A",'', 49564, 24,'', null),
 (316, 178,"A567BBE4CA9D8E976083024E8D68903CF15CEA88C47C9961",'', 2299060, 33,'', null),
 (317, 191,"BEA7165D7DD8E24E31B1C3D791A47A28731E1BACD1189A17",'', 24812, 14,'', null),
 (318, 191,"0971A7CEB84D392670C7B8CBB61776762C25259D8E772CA5",'', 13538, 11,'', null),
 (319, 178,"13200A59A28561A413FADAADFFFE4521A209CB691EA199A5",'', 690106, 23,'', null),
 (320, 243,'','', 5090917, 8,"E886EE1D0083C40C", null),
 (321, 191,"56CABE081991356465BDE1DA3B8DED099DF9B6E746D1B531",'', 25724, 20,'', null),
 (322, 191,"F98469C704F8B8ABC1A251EF8FC1E4CB5CEF1E007BAB5EA5",'', 57602, 42,'', null),
 (323, 178,"6A64BF5AC652747B47E0B8E6593B7EEAC1EF38E0A84F4F5D",'', 3049452, 22,'', null),
 (324, 191,"978BCD17BC9C81B05A2F0A50EC2CC206EC5F6AB1FE40D38D",'', 28956, 12,'', null),
 (325, 178,"A28EDC898CEB14FB52591754DEF981C7168DD2421D0742FA",'', 3037164, 22,'', null),
 (326, 191,"35E88DF07F0D48A0B7ABD53F4865DB762E6935529DC826DF",'', 360508, 13,'', null),
 (327, 178,"BF1FB7E4C3CDD5D5A93AA1B24FC822AA5537DBB59F696818",'', 3037164, 22,'', null),
 (328, 178,"343F1AFF6DA7A967D2DB958C608A6E2A19F83E862F8E3954",'', 149, 5,'', null),
 (329, 243,'','', 10694516, 8,"2F549A416F12033B","Wall Climb"),
 (330, 178,"0B008034F97BD411A9F900D87578258AA1B79873850BC12B",'', 3049888, 31,'', null),
 (331, 178,"C5A35B72E6BC604BAC9AA218908B3747D6850769CEA79C0F",'', 2299092, 33,'', null),
 (332, 191,"FDDB2AA7F8884C8E3A7ED646B3E9E4AF5A8C0704130C39A7",'', 29852, 20,'', null),
 (333, 178,"F57343CEA7133DE6469B1CFD1A749845D553B8D806B2BAA4",'', 3037164, 22,'', null),
 (334, 178,"565A63583AC736E3CAFB95EE5AF9A64D3A7D3C3A8B234121",'', 3045912, 31,'', null),
 (335, 191,"E26CF0E2ED92F608A80733CE703D7EA2C3DB83FE46182519",'', 3766400, 37,'', null),
 (336, 191,"2F44EE3A34EFF98303B3724005EF3A8AC89CB25F9CA1B8BC",'', 12985, 36,'', null),
 (337, 191,"C32F7CDB33BEF7B3093262F89263884DBB44E57D74D646B7",'', 12985, 36,'', null),
 (338, 113,"2357AD2012CEBA72283F93460AC5FF55E4E5719A5AB9F5B9","drvsys_mon", 0, 0,'', null),
 (339, 178,"1C1595A1A64016D8725619CBC2FC7ABD41835320958A97FD",'', 676970, 23,'', null),
 (340, 191,"DB5765A8B8D5F636D619E44669E9D3EF968BD8011C5D6999",'', 36907, 24,'', null),
 (341, 191,"70B78734AC394D83D45427E0B7C88351E9BB108ED59C7E71",'', 37136, 40,'', null),
 (342, 191,"85F2A5072D2D7557155CBF5157CAA460B19470DEE8AF96BB",'', 22792, 25,'', null),
 (343, 243,'','', 4609669, 5,"8986100F00","Login Password Pointer"),
 (344, 191,"6C33FD80565B2860A76C87BB772E794E2FF444D813079A2F",'', 685656, 44,'', null),
 (345, 178,"F09BEAD15FDEBD09240316D9E2E736028B54972B13F14E5E",'', 673194, 23,'', null),
 (346, 191,"302E114D921D40EE54585BD9D63B9BDDFF7A2BD4D678DA97",'', 30044, 16,'', null),
 (347, 178,"24807D7810C58A4B9A070A21B8AE50A0385DD4B4C6BD8B6F",'', 3049872, 31,'', null),
 (348, 178,"B6BDECA858773B6F995AC6496923F5D0CBFDB1F76DB29C58",'', 198, 12,'', null),
 (349, 243,'','', 5296823, 7, 75166824020000,"Language patch (speak all)"),
 (350, 191,"C125EB3FD1B222ACE1B518959D96C5AC83EEAF109E9C6D20",'', 12194860, 37,'', null),
 (351, 178,"8AFF28C3E6367B10340FB963B093AB52E61B267C541D5659",'', 2299108, 33,'', null),
 (352, 191,"734D3EDDA69D9DD307032245FA0806456E2F02E90C2291E2",'', 36907, 24,'', null),
 (353, 191,"9CB5A848D90B7FA4F58801ABD8A68EF8FDF8C602063C2CD6",'', 13033, 36,'', null),
 (354, 178,"C8BCF785F8B7118D0270016E620E2C3DF6802E034471E5E4",'', 3033068, 22,'', null),
 (355, 178,"8FB282098C8BB4EC10C8398E44C630677C6E2785227E31D3",'', 0, 9,'', null),
 (356, 191,"2381BB2B613C58C364E962738335EBC2F3EFF81009DE49E4",'', 37180, 24,'', null),
 (357, 191,"AA2A24A7C90D149C7817640B0D2D46C8A4B4D52146837605",'', 501956, 48,'', null),
 (358, 191,"6815D749CCA8C1738A5F3236A737F0B70AE037E82D46033A",'', 448500, 48,'', null),
 (359, 178,"F9F131F27BCC37FEF638FB8EDDAC29400652020C290D4F75",'', 676970, 23,'', null),
 (360, 191,"319CBACC4CD2E1F54F8C8FC41EF44A3A9C492A652B00C622",'', 18700, 32,'', null),
 (361, 178,"A4A7DB31BF51180F1ACFEA6C0E59AC84B43D022CB4BB817D",'', 2299116, 33,'', null),
 (362, 191,"0DF639ED45B0C578DD616DD191014727A3C22C346E9FF73C",'', 50040, 26,'', null),
 (363, 191,"72944B7FED63C1D2FC9D2CF6A07B5788731BE2B02215CEE4",'', 447736, 48,'', null),
 (364, 191,"9148E18CF9213B25197C247F08CCA4C0DC60FEA73E3A247C",'', 13250, 15,'', null),
 (365, 191,"ADA39A6A805BDF59271BBCE21734E8F28182164563CA15AA",'', 29916, 16,'', null),
 (366, 191,"D5C852D85FA4393D027615506B7DEE07A1074AA4633019D8",'', 41023, 24,'', null),
 (367, 191,"D06EE8DDC2115E5895E96D26A2A2F11FC566297D1D21BD26",'', 56063, 25,'', null),
 (368, 191,"3AFE3B981D50B26FCAAC9DBE5A4BCB24F5BC3E9348AAA04B",'', 25724, 20,'', null),
 (369, 191,"058E826BD75C26BACE712DF9D67B0A751896515802E9DDAE",'', 501956, 48,'', null),
 (370, 178,"6E4C9CA0F7140E32D9284AF2E0EEB76419696771D4DDE887",'', 3634252, 23,'', null),
 (371, 178,"29E43B1309ACB344AC777636BE838F0BFE6A04570B7FB09C",'', 700714, 23,'', null),
 (372, 191,"5B7AC53977D57C5756A2F61582DD386EC93F5FE180FAB5DC",'', 27270, 13,'', null),
 (373, 191,"22BF8D63A306178F368016E4657CCFCA5B2B21EBC90B8DB2",'', 50040, 26,'', null),
 (374, 178,"1E8729EE000CD5BD8BABC49C368E0FF5AC08BC2B30921BC4",'', 709322, 22,'', null),
 (375, 178,"8A1304B9AB2579F392F92D8A592308728EF76B26AE258A41",'', 4011280, 23,'', null),
 (376, 178,"8A90AA547378BD5930D24FC415AEC08EF52E29B22073335F",'', 710730, 23,'', null),
 (377, 113,"4BBF42A918109CC23F231B8E657076A213601AD681C032D1","HideEx", 0, 0,'', null),
 (378, 191,"06D9E92AE3953D13A0AC5FA31EC24B16C6A2260E2D32BF8E",'', 41096, 24,'', null),
 (379, 178,"D4D3A9950FA07FAEDAD0658F9128007ADE282C043210A201",'', 683146, 23,'', null),
 (380, 191,"94530FBCCC455105E8BB67E5B19BE0A4534A6F39A1201B52",'', 13291422, 37,'', null),
 (381, 243,'','', 4198410, 6,"CCCCCCCCCCCC", null),
 (382, 178,"2313AF1E20F446936533F9440B220BEA966D9EB3A0502DCF",'', 178504, 96,'', null),
 (383, 191,"F982BFDF01EB3BC6FFB70E897BFE21376232B2EEEFB25E58",'', 20512, 16,'', null),
 (384, 178,"26308A71C6F483CC7795A01A2F2CF7E7EE97787C12CACC52",'', 2299108, 33,'', null),
 (385, 113,"368334F9A3A549DFD3ABC9793E4EB83E837AA43F010354D1","ndis_x86", 0, 0,'', null),
 (386, 113,"5DA702DF95570780875ADB4C64259E887CE0A867D9B67711","Afd32uu", 0, 0,'', null),
 (387, 191,"B51E8DA25AAE556552404F5172642D0808A89E2AFE870B23",'', 694376, 44,'', null),
 (388, 191,"4748EAC0350B1B56D8549157AAAAF4FF35438078A7E37AB5",'', 34176, 25,'', null),
 (389, 191,"FBE20B03C75572D992273F192CE72CE78A65E6764BF8E6F6",'', 36907, 24,'', null),
 (390, 191,"D8C1B9DEF3CA9CA59C5B827F055729B636FD55BA6242F9F0",'', 694376, 44,'', null),
 (391, 191,"448475EBCA685E5A4ECC5F810740C9181825B49613CDDDA8",'', 477928, 60,'', null),
 (392, 191,"2AF2DEE0CA5F307895E5773A083AEB862EA3D5210E037F06",'', 41080, 24,'', null),
 (393, 178,"1708C050FF0C98DE59FE8F070273D80F9C1A612D336AB9FC",'', 3049452, 22,'', null),
 (394, 178,"ED6BB184C9DD307229A023C1905E6EE73981D3E088D69FE6",'', 676970, 23,'', null),
 (395, 191,"EB63A86D51668323A18AE2F8CE2BDD1ADAE57375B5F76C6B",'', 45223, 24,'', null),
 (396, 178,"5837373EE8D4CCB5687045C04A4297450ACDE774FE973917",'', 673194, 23,'', null),
 (397, 191,"65CCA5E079D38DCF32053D8DEE6C5ECF88E6AD8E1CF5379B",'', 31924, 23,'', null),
 (398, 178,"FB895125A69DE5DB112B4731F6216668EB09C4F57943D85A",'', 706314, 23,'', null),
 (399, 191,"A388E8CE523DB7C3C501AC5DB2C8AAE58FD1831E75665C48",'', 401992, 14,'', null),
 (400, 178,"77C74B5E4CBCA9150FB64261E497AC4E7642A316C89B291A",'', 3045356, 22,'', null),
 (401, 178,"8A2C4F7F3367A4648744D8964BB9A6833182ECABFE015B00",'', 3022016, 31,'', null),
 (402, 243,'','', 4609675, 5,"5E5DC20800","Loggin Result"), -- CHECK THIS
 (403, 191,"E8A24A78E6A716734CC666B48263B424804A42155C0BDB51",'', 18700, 32,'', null),
 (404, 191,"3C881D2F0634D9223A36DF5266A7CF36B503DCF424441FA5",'', 28928, 17,'', null),
 (405, 191,"7B3D92577810CAB5DA0134FDDA91CE6F36003C5373526774",'', 41023, 24,'', null),
 (406, 178,"7F794E0811DA99DABA76CD9925B3E78045425E32880F05D3",'', 672746, 23,'', null),
 (407, 178,"08235E08E4F83DDEA588D9FE32BD084FB26BDA6DEBB1E416",'', 668874, 23,'', null),
 (408, 191,"5EF7C22867612F48FE5B41E219A1CA389AE8D32D8F0FC46B",'', 21660, 15,'', null),
 (409, 178,"C7C78789911D6B30FA6E67198EF03B73CEE37576AEBFF5EA",'', 3045356, 22,'', null),
 (410, 178,"62BF4E6440FE3F28138094B46FB469CDEB35008DEB652B8B",'', 3045776, 31,'', null),
 (411, 191,"E24027620A1723C203E8084AD6269A852CD50D6F79D50530",'', 36544, 55,'', null),
 (412, 113,"49CA50FCF2699AE5F4A867156A5D8053C4239B36DACE170C","HideEx", 0, 0,'', null),
 (413, 191,"073F4A76F248FE7C38F799437D475B9A2E9E81FA08B0C6BB",'', 17666, 11,'', null),
 (414, 178,"6ECA7966F2845B9B61C6D9356E4FE4C913FE917808C8AFFE",'', 684876, 29,'', null),
 (415, 178,"30BA488B3964465B142E75F6D1E1BA42DC9F489C3AC70BDA",'', 2299092, 33,'', null),
 (416, 178,"55492051D368975D444428D6218A7D731555ABF7C3391E7D",'', 3049888, 31,'', null),
 (417, 191,"94E0CEC4F7BDE7844C4D4ACF62E5C96ECF1D11FC2169CF8E",'', 433168, 48,'', null),
 (418, 191,"5003A599A1162170A30F1906C0AD5B16DC7041E72D28A4B4",'', 28956, 17,'', null),
 (419, 178,"686F700B2223502053CAFDF9977D8774E905E76B8C960E7C",'', 3049492, 22,'', null),
 (420, 191,"F5A776E794B34ABBF93CA93E9230B7224CA088AB741DCB57",'', 13291422, 37,'', null),
 (421, 191,"4A67D56DDA6B0E7D9117CFDB17EC6572E68B9300609FFE3C",'', 28956, 17,'', null),
 (422, 178,"1B695DF78AA0708221E0EC2F5A69AB7078ED8143B2EAD174",'', 668874, 23,'', null),
 (423, 191,"7C8CD40E29AE999923CD8EAFC233E619C73885A0258A6E3D",'', 21826, 11,'', null),
 (424, 191,"73407824E9064DF5F1161A204A272A9CD69026EB4DF1004A",'', 29916, 16,'', null),
 (425, 191,"B21609972E46C9BC8C6A77A18161A77D0C1D4001DC892DF1",'', 41080, 24,'', null),
 (426, 191,"BB66A6AC45D02568067987834ECD8BF0A2BD0DAD06D12753",'', 17762, 11,'', null),
 (427, 191,"2550EB7C358B7FB86FAF0EACDDC3111118769F448D93BF7A",'', 49347, 24,'', null),
 (428, 178,"B6E4EF9350CA859576DB74D02C115D5A19C79AA58B0F6681",'', 684876, 29,'', null),
 (429, 191,"451D2C8FF751743B52109FF5D95ED633DDBD8BCDB80EB7A9",'', 17906, 11,'', null),
 (430, 191,"4A0161A4E5D50F11F58E1B23B281ABDA106625E3DC5A179C",'', 685304, 44,'', null),
 (431, 178,"E4F21910D4B5D3E7B5461ED384889F6D0969645AE83F7601",'', 3037164, 22,'', null),
 (432, 113,"B9756E3E1093B54511AC5A7B85711E53CEBEA373EF4866EE","Afde32uu", 0, 0,'', null),
 (433, 178,"A5AD6C8506004101E42165CD95051A7B5F13FBADD027461B",'', 710730, 23,'', null),
 (434, 178,"B8AE30A02C59219D144EE95228C6CC9F99916F6FE423C940",'', 700714, 23,'', null),
 (435, 178,"DAFD84BA8F977F5CFEEC9310C0EEF8F949F8EB6B827EBE71",'', 3990720, 23,'', null),
 (436, 191,"B42986974893A82D73CC497B3252E9B844A11A99ACF46BEA",'', 41188, 24,'', null),
 (437, 243,'','', 11287980, 8,"04000000903C9F00","Parental Controls related"), -- CHECK THIS
 (438, 191,"0DC0953AE42E913121092DF17BC2BEE8BE133D1C53C8BFFD",'', 17762, 11,'', null),
 (439, 178,"72C81E9BA425C54DE57BF4B7745D9C8D6B44D56E8FE933BA",'', 3049888, 31,'', null),
 (440, 191,"100426CD22E80090502AA7A087B094B49ACFF4E7A09773ED",'', 30044, 16,'', null),
 (441, 178,"46C797D1E60CC458E6C9D874650B996D10FC52641C2E7AA7",'', 676970, 23,'', null),
 (442, 178,"DEA2C8A5775AA8CA86B8241BD418979D10DF4587E8E95C87",'', 250, 11,'', null),
 (443, 113,"8807783067F9FF2697A61DEE925760682EB894C6F0A798AE","Afd32uu", 0, 0,'', null),
 (444, 178,"F63823A1F60619FDE6B4D6F3915EFB03EC03DEBEC82AFB9E",'', 673210, 23,'', null),
 (445, 191,"E4DFD66163F2A65ECDD2EE9CA8062D707CC51882336F6483",'', 130380, 14,'', null),
 (446, 178,"88182C96807A6025E628C90CE436C9EC54EC5FEC858A12B2",'', 690106, 23,'', null),
 (447, 178,"EC322863C90B861E66A0008554BB8702EA92E1406F6F1711",'', 3070052, 22,'', null),
 (448, 178,"9C851C7C05E54E5514E7BE038ABC5C669A3F5747EC573333",'', 3022016, 31,'', null),
 (449, 178,"46D70E5C13F6D16BDD01A7481D9AFA51B73202070CA5D712",'', 673210, 23,'', null),
 (450, 178,"CBEBB5F6F4EFB1324D17AB6CB48C573B639A37EAFD6299B4",'', 683146, 23,'', null),
 (451, 191,"684575AAC0D8BC30D5325D56D3D522380E85ABFF380FA80F",'', 17938, 11,'', null),
 (452, 178,"952BC8983C2CAEB6239BB2774F176A7F87A9F2DC10261205",'', 3045356, 22,'', null),
 (453, 191,"4EAE0459E341062DB99658136D494BD79511B883F00BCE6A",'', 57602, 42,'', null),
 (454, 178,"67E6E0A4006561DC5A67026886D1FF37AD14C5AA1AEA3CAD",'', 149, 5,'', null),
 (455, 191,"222FE6B0A70CE2CEE633597E018706B3F78C338D96F6D9DC",'', 38300, 21,'', null),
 (456, 113,"79747D68A5D6CD203671EF43029F17591E42BBCDB60B8B93","IPSect", 0, 0,'', null),
 (457, 178,"77ECC7613D44E56210F7CCDD6046226B41C8F087E901C94D",'', 682394, 23,'', null),
 (458, 191,"77A59932BC8D497D992A213256ABD52C4D5F4FFB8A06002E",'', 49564, 24,'', null),
 (459, 113,"2D14DD3BC859535580D8D9DC3BE7D59865A4E3FD112598A5","drvsys_mon", 0, 0,'', null),
 (460, 178,"9B487CD5032D00424A24FF3185AC4C17246729ECCE431951",'', 3049872, 31,'', null),
 (461, 191,"978D8D1F3E1EF11CEBC4B65B13F1C5CE6E9E220E71B255B9",'', 13033, 36,'', null),
 (462, 191,"1F5AD2397EB3CA814C5D156C6777C040F5D73085F3751C35",'', 433168, 48,'', null),
 (463, 178,"912807952F9397C8F2B718C9164424D720E4EFC681DA3099",'', 3045356, 22,'', null),
 (464, 191,"095F1A232F56B3DDA3338B5DE2CA310E5CF0EC0B6F72E87F",'', 17890, 11,'', null),
 (465, 178,"2A5E27A3EE36254F61795E168A98C055772F88CEA5CCD6F1",'', 3033068, 22,'', null),
 (466, 178,"4319BA4F2139568E87BAAC5F7C95121DD98D710B1C901E2B",'', 718842, 23,'', null),
 (467, 191,"74E55BA8CDEFB5BD54BF1C0B0D326721D756440BA33C3ECE",'', 27270, 13,'', null),
 (468, 191,"ED9FED6EE63B6C5E35C9E4615AC444603F6BF1FBC669D8B5",'', 13033, 36,'', null),
 (469, 191,"DF967A96C67C8D6CB1955D1CA06556F37EEFC88D26F1D684",'', 90202, 13,'', null),
 (470, 191,"2BDB1F4509561B2F846AAE7A5354008215C1EF4BDD0EA1D1",'', 49347, 24,'', null),
 (471, 178,"0F3B3F0934C1B1E32DC9F83F67308BF9CFCCEB0EFE10B2FA",'', 672602, 23,'', null),
 (472, 178,"E89980FFE6987D22DF5379283F53DA8DC3B5CD4862BA22C4",'', 335122, 23,'', null),
 (473, 191,"156B3F2929664A16C3DA2D47CE3050B3A1BC32F9C30E4776",'', 27270, 13,'', null),
 (474, 191,"65B03F581DEAA68B6A07C679C6B620A2623FD83EB4C4978B",'', 28940, 17,'', null),
 (475, 178,"044C63CB9F480E28E02D68426C1F3D69BD146B39A7F081B5",'', 0, 9,'', null),
 (476, 178,"B3BC7201BF77B362B943C8C13F9E70A751906F304F9AE133",'', 673210, 23,'', null),
 (477, 191,"4783BF04A6BD423D63CD955407780BE0E15A70BC2643F853",'', 28928, 17,'', null),
 (478, 178,"A71B471FFB4C58A2C99FC6818DD0269C4AE4C5686D5FDA87",'', 690106, 23,'', null),
 (479, 191,"3EA0347F1F7D9BC9CAE387816DFBE4F492F53533400315B4",'', 17762, 11,'', null),
 (480, 178,"AA5ADEE929B0B2FB655080B35D19607695F611672E6AD364",'', 3045616, 31,'', null),
 (481, 191,"2DAAB5C524CA576967A7B0B713C1C34DA8EBF3990A86730C",'', 28704, 16,'', null),
 (482, 191,"D0042CAE82A7121F7783A1382F542074B34ABFDF50A1B13A",'', 22792, 25,'', null),
 (483, 191,"4D30286AD524AB2EB05C1A361A81036F787B1C0ACA36DD74",'', 30012, 16,'', null),
 (484, 191,"03F9E0F9328E7C7025C0D5C59585700F19E29E8C8F9BF5B4",'', 49564, 24,'', null),
 (485, 191,"430C4F44FD7CDF1A51F7A8FA5852ECCDA6CFA92C2A6ACB3A",'', 28920, 23,'', null),
 (486, 178,"A2886E2080C54F25867AEDACDADD8F5175545F44512A3B58",'', 672746, 23,'', null),
 (487, 178,"8438939BFCD0C550664ADE2DD75DD15FA23DC435EB5FC011",'', 3638348, 23,'', null),
 (488, 191,"66480AAA84C5C00B64EEABE96DD21EB3773228B144E25D0E",'', 20512, 16,'', null),
 (489, 191,"76C1B0FAC29E4E41FC6DAC31A0592CB0087BCE0D052904FE",'', 61874, 42,'', null),
 (490, 191,"DA219765DA22ABBDBE5486CF7DB01C283FBF9986732C9A91",'', 37180, 24,'', null),
 (491, 178,"F58BFE40291DD85F45C47E0E255594382DE0180AAE1F1FC9",'', 149, 5,'', null),
 (492, 178,"8D8A305C43A3DD47DE550F256BD5F4B1753EDCC079AF279E",'', 3070052, 22,'', null),
 (493, 191,"69CA60928A9A85D79ED39596C018DF899BD14C6219EFE088",'', 41080, 24,'', null),
 (494, 191,"8D9AA947B904C003D06ACDF4EA0C84104612B274696999C4",'', 17890, 11,'', null),
 (495, 178,"289CBF469FC750449980BFC2CA6AD7E42A69E14595D140A3",'', 209352, 75,'', null),
 (496, 178,"49961CDE71B612E5432EAB389E7AD193476E05BB2778B751",'', 700714, 23,'', null),
 (497, 178,"43818F9575A04BF426F4BE167052859015CC63622F7D4F3A",'', 672746, 23,'', null),
 (498, 191,"7828B55FDE24719EC377E29FAE55BA6324020D00CD42A99D",'', 360508, 13,'', null),
 (499, 178,"5432916108AFDFA313B6D88C886D87B5722E43EEBCAFC627",'', 0, 8,'', null),
 (500, 191,"106F24060B7A4FC87A7971A4B0EFC1021F7181A09598C336",'', 17906, 11,'', null),
 (501, 191,"13AA99805639421566A2652F0A7104939EA52EF0F77CFB03",'', 24812, 14,'', null),
 (502, 178,"D0938B578EC70162A30A25571CD5DC7E765780F6191EAE1B",'', 710730, 23,'', null),
 (503, 178,"70FA2C3749960F1B0D881FDB186DB9992D6EFD30C6674104",'', 580768, 52,'', null),
 (504, 191,"BCA2CC6F5740DEF5D01D314146879036A5B6965C01424B0C",'', 45223, 24,'', null),
 (505, 178,"47DD279576A64BCB3A4AF23D55895600C73BB5C214B70AEF",'', 3049452, 22,'', null),
 (506, 178,"09C9B53C215456866BF764553A7B7E4F1F20F33A8D2CB613",'', 3638348, 23,'', null),
 (507, 178,"3EC2D3876D82F424718D3B8E0B87562244C3F5A11A29F0E8",'', 682394, 23,'', null),
 (508, 191,"7B4E9BBDC89694CCAE5BA6996D4240EB2E0C9C7F03CC5D40",'', 59620, 13,'', null),
 (509, 178,"E2333772B05ABC620076EB66CFBB4AFE2313CCB6D719399F",'', 3065956, 22,'', null),
 (510, 178,"2EB4C04C0946264F5BC8EFBAA832CA97381A8A6523BAB093",'', 178504, 96,'', null),
 (511, 178,"0E3DE8374276C08D5DD241ABA2AC0AC1D2319F5CD22AAB52",'', 2303444, 33,'', null),
 (512, 178,"FDB8DF478DADD2E36619D63D04D106EDB86EBF8FB9EC8CB4",'', 3000288, 31,'', null),
 (513, 191,"BA76761FA5F569497047C3484FBC6FDDD8AFA71B96FE93C8",'', 24812, 14,'', null),
 (514, 191,"2496E15413F7008A01FA53AC109C01E45B80BF2C3BC2F205",'', 56063, 25,'', null),
 (515, 191,"CACB6383E8613E41489D93D7FE7235BE61214F9AE0825F44",'', 13291422, 37,'', null),
 (516, 178,"931C403D2562AEE58EEB2586D73D51323A3A739860290AA6",'', 690106, 23,'', null),
 (517, 191,"1A95AFB270B9C0D170E7280816891492C21E87D92E9EA6E5",'', 433168, 48,'', null),
 (518, 191,"7483929857AE7A16C2D9EB0857EB1D5E9477479C2EEF0B5C",'', 37180, 24,'', null),
 (519, 113,"379E1F6905F203E1026DB54A58AF588EF5726D9F50FCF369","Afde32uu", 0, 0,'', null),
 (520, 113,"08394625CCD77F36897EF283FAA0C019EE9F36775182584F","Afd32uu", 0, 0,'', null),
 (521, 191,"D9ADFC0283E75A86A3E1672BF50F5D1AD8E8466AE7086437",'', 27270, 13,'', null),
 (522, 178,"D37F6219417C0E5196D3A4473D57ED767E6D9B49BB2B9555",'', 0, 9,'', null),
 (523, 191,"93AAFBD4B8B50D6AE72F3BA7002D76791942D0EC0E61253A",'', 41127, 24,'', null),
 (524, 191,"F9B132A5E1FFF379EC7175C12A58683C85272CC96E03E161",'', 41023, 24,'', null),
 (525, 178,"1867D3CEC9379D1E6B8A1B9B667BDB1B6084B02ED9A60864",'', 3037164, 22,'', null),
 (526, 178,"86548378A25632100F7E6E872ECF4D591B7542D977B623AE",'', 3049452, 22,'', null),
 (527, 191,"9E00F6F9AF1D63FA2628E60B7BF2B1D63EFDD42D69929A73",'', 41080, 24,'', null),
 (528, 178,"7DDD4CF1352822A1F9D19775498EE865FABB26C69F8FDEFE",'', 209352, 75,'', null),
 (529, 191,"3D793384AD147BDDE98743EBE1E943263EFD6CAD542E2757",'', 17522, 15,'', null),
 (530, 191,"9014AFDE93FDAC6C20971BEE76898FBB300A744CCBC24DA1",'', 28956, 12,'', null),
 (531, 178,"D1212D7155D2C3114DA596070139C0B3610597CA0CE1CB17",'', 149, 5,'', null),
 (532, 178,"BE18517661568A9D7F3CC9548592867F3A987A705866F60F",'', 3049888, 31,'', null),
 (533, 191,"5D833D8DF05A7AF50DF945F5AF6880D325AC52B3ABC815AF",'', 41188, 24,'', null),
 (534, 178,"1AA3B0D9AD368562F181E4E5D498652B3859210C126824D8",'', 672602, 23,'', null),
 (535, 191,"331E027A700CAFDBEAC9E80B68B8304D0895D52947447448",'', 501956, 48,'', null),
 (536, 191,"8E704337CE9F823A8A93947130ED1EE14A99F2EDB5458B94",'', 12194860, 37,'', null),
 (537, 178,"BB1C818F79DB2F1FF71B7CB181021EB4F425311D09DAAE81",'', 0, 9,'', null),
 (538, 178,"F1AD484D3F189A08EBF420C235D16ECAF1B485092FB063D6",'', 3045776, 31,'', null),
 (539, 191,"1CF7028BE4D68B7AC6BB8061BECBFF402860541D04C90C0C",'', 17906, 11,'', null),
 (540, 191,"2550D8249054E57086D4F4CF80396C686A71673C070711DA",'', 17890, 11,'', null),
 (541, 191,"E864BD00AEB4F3D18CFFA7AADEAC7926A9A1E3EA7588F17A",'', 29884, 20,'', null),
 (542, 191,"9E70338B4C8C845F8514925463DB624FC4423F9C467F5E62",'', 685304, 44,'', null),
 (543, 178,"FC5EF49EDEE7A5268395298071BBA270822547A7416AEFB1",'', 3634252, 23,'', null),
 (544, 191,"8282F57B7C3CD9B449B6363D5C9E792C2044EA2C3F381F9F",'', 17282, 15,'', null),
 (545, 191,"B793EEE20E44B2942C6522F79343C58738A1A8489A381FB0",'', 24812, 14,'', null),
 (546, 191,"6178EE9E575927A3505835AC88DA31BE15F0622DA55B31EB",'', 28956, 12,'', null),
 (547, 178,"7BFD2D88793D6AB1A2351A3E8873B1E20CF44BF6563A0930",'', 3049888, 31,'', null),
 (548, 191,"4102F13984A4E146C134D3F607AE7CA1B3263A22B52308C6",'', 447736, 48,'', null),
 (549, 178,"EA1C4CA2A64548757BC2ED1C5BB6D2B5094AAD5B5C331F7D",'', 683146, 23,'', null),
 (550, 178,"BEB42A9DB2B656B2DFF3DD7D1B8D87033F1D99A019CD4BB5",'', 3045632, 31,'', null),
 (551, 191,"4E209437251EBB0CF31CF8A7CCF2C873A4D759B9563D573E",'', 34176, 25,'', null),
 (552, 191,"85EB9C8A36B32287F096CF73F7FAE8B57405321342E9B779",'', 17666, 11,'', null),
 (553, 191,"2EDE42629DD4A72669FFC9BBFBE15F357BF241853DBF7B2E",'', 27270, 13,'', null),
 (554, 191,"FF47A1D9514F4DD81BDA23FC9018F03D894F9096E26EF809",'', 18680, 35,'', null),
 (555, 191,"65185BBCA1D9995EA4B796E908B9F78923FDAE2D0C2500BC",'', 594348, 26,'', null),
 (556, 191,"BD55E51B55A8FAB82CBF45012D761B1BEEE9BC0DAD8A83CD",'', 28920, 17,'', null),
 (557, 178,"AACC3E694ACD478B1F99714734B5A43BD7D7A2A3565ED9B2",'', 3049492, 22,'', null),
 (558, 191,"F3C07663325C5358F58A547725FBDF8DEF591021CD94513D",'', 685304, 44,'', null),
 (559, 191,"503B5AB938616DE7672103919957B421FA8B6C98F72375F6",'', 20512, 16,'', null),
 (560, 191,"3B6EFA3FF9443BEF4CBD2E7CAE08DA1753C79E5EDFA8510F",'', 37136, 40,'', null),
 (561, 191,"3E5D1B5BBAD191442388FBD5236F5406CB2CA68EDF986328",'', 17666, 11,'', null),
 (562, 178,"D8AB51DCC7840369846821B2A6B229CBA2E42C0CA566792D",'', 0, 9,'', null),
 (563, 178,"F8004FA24C4925FAA3ED4993B0D457C5E4C5371915BB93D0",'', 3037164, 22,'', null),
 (564, 178,"EAF4A696D564F6BC800BF0F6D732E4E92B50133DE02EE8C4",'', 0, 9,'', null),
 (565, 191,"30BDC2BC3E4A2055426FA0EC67DBDEB7705C58047EFFA4D6",'', 61874, 42,'', null),
 (566, 191,"3C8BCED97B2F9E5A52587E725004E136DED2B53AB2DB9D4F",'', 20512, 16,'', null),
 (567, 178,"0B586F15A8CFD6B7A96632FF2B48D0F71E9D06BFAC174002",'', 3049888, 31,'', null),
 (568, 191,"B2B3043BF9CDF3DB535D52ABC45BE586E6B8097B58D82C45",'', 17890, 11,'', null),
 (569, 191,"9ED22064CDACF86DAC8C365C325EE428A87B628D137E038E",'', 28920, 17,'', null),
 (570, 178,"2254B046D6D8D1A47E5F9275474B5EEE7A96CD99E8D952E9",'', 682378, 23,'', null),
 (571, 113,"0A268B6DB28320A1956B54C36C61C625B02A48A4768A0823","Afd32uu", 0, 0,'', null),
 (572, 191,"41B3450DB8D10C506A561C7B95354A7792286D837C08B437",'', 12194860, 37,'', null),
 (573, 191,"5CEDF5982800D9C6D16F9D357AEA17BBBAABADC8F3A12EC6",'', 45223, 24,'', null),
 (574, 178,"3399D1DE6156FDE8614333B6C4AB0F5B2354381AAB7AF818",'', 3049872, 31,'', null),
 (575, 178,"31DA5322A7B1F1715CA35F0976C201122A76D46A719F0C28",'', 335122, 23,'', null),
 (576, 178,"36172791F3ACC5EFD406A7AD6F5D218279B94D458BDD60C3",'', 700714, 23,'', null),
 (577, 178,"C64DDA3E5D94BD0DEFEDDB867DD304177B554C5771CF4DEF",'', 682378, 23,'', null),
 (578, 178,"701D57AFE1315795AFE1340C35E923FE69C36EFC670C0BA5",'', 0, 9,'', null),
 (579, 191,"D55BBE3C196C2FE07829CC54717C0A2A27C13A38ED4CF582",'', 30012, 16,'', null),
 (580, 178,"DAD3C22D23FAB30C9AA6796E19EAB23CB7DCCD639854C14F",'', 3045976, 31,'', null),
 (581, 178,"B3EC9710B55079104420F126BA7257F8FD7DC39D46880E5B",'', 2299060, 33,'', null),
 (582, 191,"7762CCDD012D51167BF42F775CC307238C35EA5DA55B999E",'', 41096, 24,'', null),
 (583, 191,"CEB7B2C893B8410CA8716C77DB679AB860F7F0E86BCF2D8E",'', 12194860, 37,'', null),
 (584, 113,"C584FF543FABE32DBA3206AB324CAFAD92497C4926BBF8B2","HideEx", 0, 0,'', null),
 (585, 178,"122B96C9AD3D43FA5EE82ADFA464904F304EB7FD4CB5622D",'', 2299108, 33,'', null),
 (586, 178,"3EFBC5B273BFF42D9F704C74DC2381B8A0D50D61C2F1512E",'', 717898, 23,'', null),
 (587, 178,"8C5824E4A6D16714A2BFB5FC9D0CBF4706B8A2170DA87D7B",'', 0, 9,'', null),
 (588, 191,"402282B90E06579656CF454305C0B5A925C95FBF6A7CF265",'', 477928, 60,'', null),
 (589, 191,"71B36C6D650EF0D049328643E5B12E73DF95B58B2F30D0DC",'', 17938, 11,'', null),
 (590, 178,"7C49C303394E1493D897E802528CA8E558B6A7BFE8320F08",'', 3037164, 22,'', null),
 (591, 178,"2C190F9E920AF2EF67DA4D06905C2A6A0A2BC63D0192BAC5",'', 3045632, 31,'', null),
 (592, 191,"E59168C40E1A0C9F8896EA9E2D684988D81A522FFCDC51D5",'', 3766400, 37,'', null),
 (593, 191,"3C825803D3ABF20A11495E54718A2D83A0B35FD7D741B5E1",'', 12905, 36,'', null),
 (594, 191,"DCF32E3E1C5DF813DFB137A2D9B21D95B0AF66CC2AD0F245",'', 41023, 24,'', null),
 (595, 178,"7B66BDB4A0A713A7B315888708B88F90CCF7313832CCE35E",'', 3045356, 22,'', null),
 (596, 178,"FFAF20DD14D7018A4156F000D1455DF36966513EB76F93E7",'', 2299116, 33,'', null),
 (597, 178,"0C59AA1F05D2D9D3C0C5ECF6A38D9FF57187A7A461DEE908",'', 717898, 23,'', null),
 (598, 191,"913AA6D16EBE73143FA4B4EF89C786668C6E7DD0B936DD18",'', 90202, 13,'', null),
 (599, 191,"A9F5CA81A547D8F8051928A287DD280F7FE835B2858CEED5",'', 20512, 16,'', null),
 (600, 178,"16B4D8897AEED4732A47239CDC99603D2F505D0AD602847F",'', 673210, 23,'', null),
 (601, 191,"23F29E10D55E8701A1A699A1C05CED4553676E9FBA5B51F5",'', 13634, 11,'', null),
 (602, 178,"9A65A024256C0D7D677C9F24A9C16A48BEA9B03CCA016098",'', 3000288, 31,'', null),
 (603, 191,"AA0004288ED58DE4324FA521F849807DB1EF33634C7FE8C3",'', 61874, 42,'', null),
 (604, 191,"E400A401BD0376A0475F1216731F5EE0DDF42C9A4FA805D2",'', 59620, 13,'', null),
 (605, 178,"FD434987A57E848192562B61CA0D67BDCEA2392514CDD0AF",'', 3000288, 31,'', null),
 (606, 191,"88C140A6580061C775D9141887FABD3F20E574DC4C0C4BBB",'', 9977, 32,'', null),
 (607, 178,"3623B441A5D414AFD6650C8B8623ECF3C3A9129E1F5A81C1",'', 672954, 23,'', null),
 (608, 178,"393A06D430D287FEC1C02F9945C34BA2A7954241C6357909",'', 335122, 23,'', null),
 (609, 191,"0955A3267A3E576B9BD823BB210E8200F37CCB0421BF208C",'', 685656, 44,'', null),
 (610, 191,"1A00ED18B456ADC1A1F39A5DEF572250FB0CCAC8BECA9DD8",'', 477928, 60,'', null),
 (611, 178,"370B9B6E3AA987595F986C5716BF9FFCF0369438D5DC5D11",'', 156, 8,'', null),
 (612, 191,"E8E85DFE24D8D20852A37D702CDF029C3B1FA30B99CAA4BE",'', 447736, 48,'', null),
 (613, 178,"FA24C5FEEAF4538DD4913F10C99F3F64380B7354EB318386",'', 3041472, 31,'', null),
 (614, 191,"C6AD92AC13B340575AB5D0769A1A7EED47BC42A5968E67D6",'', 37136, 40,'', null),
 (615, 191,"990EFFE367D44A29E82F62C57B6041A66F66C1D100B05639",'', 28956, 12,'', null),
 (616, 191,"631E42C3B6ED8A22F5AFA903176A7EB011754F5ABF2081EF",'', 3766400, 37,'', null),
 (617, 191,"D8AB4091C51177D7BBA7384EE12E0384A7EDB73E38D15920",'', 13291422, 37,'', null),
 (618, 178,"54AAA1926869D259C427870A620AE0C24AFC9B472F424633",'', 3049888, 31,'', null),
 (619, 191,"CC0E40919988E53DA0B447F0984A30D51CC42E9DB54A8F1F",'', 49564, 24,'', null),
 (620, 191,"396E7EC540DC2C74CD6709753CC627517E3A2DB8A1EF3633",'', 29916, 16,'', null),
 (621, 191,"84A5A077180DFB9841E8DF4A4EC49EADE886D905768EE032",'', 57602, 42,'', null),
 (622, 178,"072300C283F8DF72B3ED5F3CD8B7DF47574AECF7B21FBB59",'', 668874, 23,'', null),
 (623, 191,"D4FC9A6022B7CFA81904503E43B813631D4735D80BC61868",'', 9977, 32,'', null),
 (624, 178,"47B5A19B87234257CB6C1485AB2C0CB25513260F60094BEE",'', 3037164, 22,'', null),
 (625, 191,"B8B6F4BA5FD45F0ABDCB060F72987987B6EF62B80C9E378F",'', 12194860, 37,'', null),
 (626, 178,"261F2915266F20B7289A1560176F24198930C61540BEFA01",'', 3638348, 23,'', null),
 (627, 191,"019A378006B0677C0B2F42C6CA882EC571D504E7D8F5B05B",'', 17282, 15,'', null),
 (628, 178,"4E82DD9F04571D6DAB2FFCFCD638699D1D4C84917F720F32",'', 717898, 23,'', null),
 (629, 178,"EAA75F6AE049552C55AFFDABB7268682428B1A9BF028C4D4",'', 673194, 23,'', null),
 (630, 178,"F1431C669453FE0BD95430ECD8328EA0D3CD37BA658F094E",'', 198, 12,'', null),
 (631, 178,"8AD8C581E8BAF7A2140211C4298A93E229493F272F4EFF4A",'', 3045912, 31,'', null),
 (632, 191,"C154E3B6CE0B979BA98FEDAA1829DCCF2A7172642DEF9EFC",'', 37180, 24,'', null),
 (633, 191,"295A29C81B1B9CC9B6758440BED913ED4D8B5E05A90D7CE7",'', 41023, 24,'', null),
 (634, 178,"3ED9105E3D1F31AD1D4376C54B07D18348C56E7453D161B2",'', 690106, 23,'', null),
 (635, 178,"74C75B8F0147ADA8610F6C9BB80C4BDA543C1D95943ADCEB",'', 0, 8,'', null),
 (636, 191,"7BE7A7D3F4AD8B30A0A144D5D4AC5E569BB9A0D18AB590FC",'', 37180, 24,'', null),
 (637, 191,"0B5C54A4850924038D95A3F1C44F300921CEA1E13644842E",'', 57602, 42,'', null),
 (638, 191,"876743AA30D61C83444427F4F18203B2FF443C337E5DD190",'', 22792, 25,'', null),
 (639, 191,"C83A14C21D1E66345574E3E0E3613E924F702883A30A1809",'', 31924, 23,'', null),
 (640, 191,"2545F02B4FC2F5425960A2E5C0299936C99FF2EC68A5ECDB",'', 501956, 48,'', null),
 (641, 191,"85EF9C6353712A8D0E2E27B1702B510A95B1305473F86345",'', 41023, 24,'', null),
 (642, 191,"35282392AA86692A153FC159D6E13C74F9DF01661E4867D6",'', 13538, 11,'', null),
 (643, 191,"0D6CC3008615CD5BFB96A90620805B78D5BFBC6100B1AF0D",'', 13538, 15,'', null),
 (644, 191,"D573179188521C485CFD24A9EE9CDA77C540A31EE68E3E78",'', 41228, 24,'', null),
 (645, 191,"8FA80694C3766FC1B041103EB35EBA3B7C77081A5DA8FFD8",'', 28940, 17,'', null),
 (646, 113,"CD6B8F9D23612C807F7653D29F1F1C54BC8F917C5C5BD8F1","Afd32uu", 0, 0,'', null),
 (647, 178,"FCB5CF830DB536208D4C58E5838D1C8798F0738247EF0867",'', 672602, 23,'', null),
 (648, 178,"4451680A3F41926C1545701887F93A0A49CC29C3E114AADB",'', 4011280, 23,'', null),
 (649, 191,"6BE2C4F29ADF49AE5BF0485A27A854087E775FA28047168C",'', 27270, 13,'', null),
 (650, 191,"016FF5D8685E37969B1B7C310756DCD93D4AB34256837031",'', 38300, 21,'', null),
 (651, 191,"6726DA4A8F112CC25DD78500CA9BF792DB688F7D8D1FBC4B",'', 57602, 42,'', null),
 (652, 191,"9F8B3A3C70027496420A619969CF1EB7AF447D245DA766A0",'', 29884, 20,'', null),
 (653, 178,"E74FFC8ADF5FE8A0FE0F10BCABCFCEDB3B2B9C2307340D7C",'', 3041472, 31,'', null),
 (654, 178,"B31302D6A47971059B2643B57D2D50EBEBEAA89BE483F1F4",'', 3037164, 22,'', null),
 (655, 191,"2F761DEA3CD3394A0091D745FD2976B52F3B16BB0A48BC80",'', 29884, 20,'', null),
 (656, 178,"8E44EC966A93870696359D3E2474D12C071A381B9403B1B9",'', 673210, 23,'', null),
 (657, 191,"2424AFA7FEC48FF09E5E3BDAF93FAA74743A7551B6FB1495",'', 56063, 25,'', null),
 (658, 178,"ACCF5804D419F30643F87A650C4DC6E0E10266922692AECE",'', 682378, 23,'', null),
 (659, 191,"6EC19D6D1244E3FE787AE448EC905C509DBA3C01FBE34F24",'', 41280, 16,'', null),
 (660, 178,"5B2D2EE40383C33D381998995210918AC6B1AD67C5880F6D",'', 710554, 23,'', null),
 (661, 178,"83FFE0F8F224D5E56C38D731EFE8AD5AD1285B1AD4FA019B",'', 683146, 23,'', null),
 (662, 191,"9D67A809FD8FDA1E1504F0C038E21E1D5FC4C6D11F426228",'', 28940, 17,'', null),
 (663, 191,"2965EC092EC0A4B3D4A3C781F0A0A542824C77B7300BF50C",'', 45324, 24,'', null),
 (664, 191,"FE31901F5558E6555DA6BC5B1BC3415E82CB97DECBB486BB",'', 41096, 24,'', null),
 (665, 191,"B35406A77D6501A50F41981C7C137AD5272EB612F4A74109",'', 29884, 20,'', null),
 (666, 178,"7275397E511B45264BCFA30E3A3F8101894AA3923D91BE6E",'', 3037164, 22,'', null),
 (667, 178,"CA7D8D0E1F20385DCF6FC209799750CE9D0160B0C67196E7",'', 700714, 23,'', null),
 (668, 191,"F5CCDA244D826B3180E7C49193B3B0B5DBF651EC67DCB47A",'', 594348, 26,'', null),
 (669, 191,"7977F1E72B30179072EE1784396AB0406D06162051CA1EDB",'', 37136, 40,'', null),
 (670, 178,"603F8A015D8436CCBCD68B26FF6006E7A81BA9A8D9524B1F",'', 3045356, 22,'', null),
 (671, 178,"9631E9EBC78E0333010E522045852C7BEA44655080D418F3",'', 3049888, 31,'', null),
 (672, 191,"43BE7C00605D9FECAEFAE38D8FFEAED78B8382563A245F10",'', 9977, 32,'', null),
 (673, 191,"E493F1BAED1DBE7A0D429BF1A5D665636D29069060310BF0",'', 13291422, 37,'', null),
 (674, 191,"6C53203FA95EBE4DBB0A7F3E85994058DECA069A5244C29E",'', 130380, 14,'', null),
 (675, 178,"5A07E5A0525DBD5005CBDE16F7393EC8B795ADB2327C2F96",'', 3045356, 22,'', null),
 (676, 178,"D7665366F333BD580C5F8E2FF8971294F69E99EC7E3623F3",'', 717898, 23,'', null),
 (677, 191,"FB87EB8F178C69D9F7576AC7FF75D0479467057A2B6C956D",'', 9977, 32,'', null),
 (678, 178,"292911AC98E7ED34DF021B562D5DEBE8DAA15570B552978B",'', 3000288, 31,'', null),
 (679, 178,"6618F45C49D47C4105070C085FD5C384254A62E4AB614DB9",'', 3634252, 23,'', null),
 (680, 191,"316E531545999AFC533814888434999501FEA8ABFBAF8655",'', 134968, 32,'', null),
 (681, 191,"9945ED64886F68664A4BDF50731F4B4DC680273AB2E0DBCB",'', 20512, 16,'', null),
 (682, 191,"1D4D6EC7B6B26553FC914D28BF9B62FD81D0B865DE606D97",'', 29884, 20,'', null),
 (683, 178,"63B2D2ACF6E912CDC68282B080A2D610BE6AFE8EBB95FD31",'', 3070052, 22,'', null),
 (684, 191,"B0955BAC042D5441496103E7C45E38609A9AE3799D534BD9",'', 18680, 35,'', null),
 (685, 178,"6488E44D4E965581650F73F6E68DD8F863795162D99104F8",'', 682378, 23,'', null),
 (686, 191,"CC0D3F7D8FCF928A55F92F6414F4AEF7AD75DED5819BF870",'', 13538, 15,'', null),
 (687, 191,"CD3835965AF27EC338F828666CD06089B847B04A2DD56AE0",'', 17938, 11,'', null),
 (688, 178,"D04E9CF6A03D4767AFF1E4EE0EFBC333AEBA5B0552F15957",'', 0, 9,'', null),
 (689, 178,"120904F033D78A13DB0971F095C809852B7EB876D1A8AA01",'', 3045632, 31,'', null),
 (690, 191,"7DDD19DCF77E27DF0A31BC21C7F716FF85076AF065F102DC",'', 36924, 24,'', null),
 (691, 178,"5486E2CDD98AC3F25C223FD515CE7EF3FB09AC12ED338C86",'', 198, 10,'', null),
 (692, 178,"F8D6423F01E5369D16F6F70180083B936F0DDE3737B23308",'', 2299092, 33,'', null),
 (693, 191,"EC10CC349A8E654240B27B03EE1232B9CCED28F7104CCB71",'', 49347, 24,'', null),
 (694, 178,"29E064ACC509206873A1D548F4816DB60D29D6EE9FF63A56",'', 682378, 23,'', null),
 (695, 178,"E1A8A2A81920A7BA9F419A6D19CAC3DD9E292EF39F963234",'', 676970, 23,'', null),
 (696, 191,"32393EB09F7C829F58612E5E47018F7203C43218C3506C79",'', 20512, 16,'', null),
 (697, 178,"AFC4D19CACEDE8E9A2FDE3CC3D29CF8556AF4980872DFE1A",'', 3033068, 22,'', null),
 (698, 178,"09A2B97FD351B1D339030233AC51C741E0ECDC21AA7A152B",'', 3049452, 22,'', null),
 (699, 191,"2B2AF2171B8A9FC0D44EFE0ECDCB9DE1A55ACC8D83661E16",'', 41023, 24,'', null),
 (700, 178,"D111B236DC42EB338870E72FF6EE3141714D0437864B02AE",'', 3045356, 22,'', null),
 (701, 178,"E6DC6898929D1DA9F5768A9BFCBE848F8C1F31E8B6910FB8",'', 335122, 23,'', null),
 (702, 113,"85A32F8B5F8430A086D27E62EB17D878E49CE815F6AC91CA","IPSect", 0, 0,'', null),
 (703, 191,"B6CB7B905A6BDD64BC032BE71927C1FE31153D14D6CF87E1",'', 447736, 48,'', null),
 (704, 178,"40EE7F4EEE1D707ECB770CDBBB54730CB863CC8E268D4208",'', 3634252, 23,'', null),
 (705, 178,"D74E308262D8C52ACE81B66F1D90C160AC86B2E0508176C1",'', 0, 8,'', null),
 (706, 178,"E15287D29EE155299619F8E93E66B55B564FD921FA41CF50",'', 3049452, 22,'', null),
 (707, 191,"58DFAEE44A52F0D5A58B0C94F0E5E63C1C7F76206D7FA7CA",'', 22792, 25,'', null),
 (708, 191,"83705EAE8AAD9709494E52EB05AC0481C998C15730E61099",'', 30012, 16,'', null),
 (709, 178,"0271F4D624304A48CB7CDFA016E3A735DCA3170FAD557468",'', 3070052, 22,'', null),
 (710, 178,"217DFFE3C12F984992E1E0AE7B5864061572BA301B21D869",'', 178504, 96,'', null),
 (711, 178,"C5C7AC33D1E4CF33E661033006BFEDE08523B643CCF51261",'', 3045356, 22,'', null),
 (712, 243,'','', 4618113, 10,"FF1554F79D003B470C89","WS2_32.Send"),
 (713, 191,"D45144FC835266270E67CFB1F2900FD227B63204698A3EA7",'', 50040, 26,'', null),
 (714, 191,"B5BB832AEEC591196864E08A392592C5789D76D3DDDD4DBF",'', 27270, 13,'', null),
 (715, 191,"93582814E00150E2DD750ACAD7BD1719C4EBCD4C06F482AB",'', 28940, 17,'', null),
 (716, 191,"FD6B6AC7FA5F2E7828CB1B429A9442383BD93E762A5D7D00",'', 31924, 23,'', null),
 (717, 191,"51DF4EDECBBE42CC7C5D6723318F98E43E14A45F41CBD124",'', 41080, 24,'', null),
 (718, 191,"F2B2260FDD23E5F268FAAE4D1A48E74C452F2AC5D114765D",'', 57602, 42,'', null),
 (719, 191,"69FBDB69EC2E113EF691E47EDD46E40F03D1EBE226A1F7CE",'', 29884, 20,'', null),
 (720, 178,"E3E431D8F8FB38F0F2586D0F50D809BCCEB13651C5EF2619",'', 682394, 23,'', null),
 (721, 178,"2294015927F07D884FE2923FA17B3A8BCABC0A378930CF84",'', 679578, 23,'', null),
 (722, 191,"0A022AB25C52F94404A01F96687B2D6E6BE774237254BD05",'', 20512, 16,'', null),
 (723, 191,"65EEE243504EDC3319C3528B1A1E8061A3E75F4C25B61F95",'', 41228, 24,'', null),
 (724, 178,"877C654036A29FC108FE8D69D416361732D7A0270E51189D",'', 3022016, 31,'', null),
 (725, 178,"1A223564DF9E7BADD3CF858FB8250FE59F892232AC3B412D",'', 4011280, 23,'', null),
 (726, 191,"4FEDF58FB4DE45289C97ACCF16EB2DEA6FBC85C74A52D3C9",'', 37180, 24,'', null),
 (727, 191,"D4BE47EA1D68B92E2AD8307D139877705BE2B6A98B6A916E",'', 13033, 36,'', null),
 (728, 191,"9658AC7EF426A52C327BBC1ED71C6FA6DC5940E35DCC18C7",'', 18680, 35,'', null),
 (729, 113,"1B17998CD8E0CDA4D84B0A0F9DB05E536DACE0348A883D24","ndis_x86", 0, 0,'', null),
 (730, 178,"BB9B86ED12359A465B02387A1D727F11F78D35C8B7FCC2FC",'', 2299092, 33,'', null),
 (731, 191,"842BC1A8C53902D26018B1C5E05ADCD70D973A968E298331",'', 50040, 26,'', null),
 (732, 178,"3E894F9682573CC0AD54C7E9873C9026AC050929392D0B93",'', 3049452, 22,'', null),
 (733, 191,"4A31E3D24FD6D576D84EF1BFB813D0F066870DEB38C32E47",'', 21826, 11,'', null),
 (734, 191,"EEA122B4C066EC0B196F67511E633EBACB37C4EA6AE4BFF7",'', 41096, 24,'', null),
 (735, 191,"66211671BEF80FB973B1C9595A70B462AD79EC83530DFE89",'', 12905, 36,'', null),
 (736, 178,"3760BBD6FE99A0BBEE0AB61A8BD52A6ABCAC48FF3CB265B8",'', 3070052, 22,'', null),
 (737, 191,"70F425426612D0D8495386C2375F7A4183548C0D4E7DFA46",'', 594348, 26,'', null),
 (738, 178,"BB310E9DDE9259027123500E65F9FA1E8D9D0F5FE8381CD2",'', 3638348, 23,'', null),
 (739, 191,"6FFB5E4982D306680E0C59087DA961CD4F6B068E323C3BB4",'', 401992, 14,'', null),
 (740, 191,"6DDCA79B7460A1F3671532A28FDCEB331DE6CA550E3178D0",'', 3766400, 37,'', null),
 (741, 191,"A8F7B2FB37CF3BEF43D6CE5C0BF85E85077E681490BA1C4C",'', 37136, 40,'', null),
 (742, 191,"052F425E7528B3A7155C45EEE530F915DBB154E5C8876E25",'', 50040, 26,'', null),
 (743, 178,"D6DE200B631AF71BFBC76202D82649942FD6ED9BC4A9EF75",'', 198, 12,'', null),
 (744, 178,"61077261C66B2CF9B199F115A3A656EA6A00068F151E3656",'', 706314, 23,'', null),
 (745, 191,"513FC0F0673A9DF86FA1FA05371040C14634CE08311ED619",'', 401992, 14,'', null),
 (746, 191,"5E0970A6EB246A79DDF427CB76D0D921F971E13921DD5D2C",'', 134968, 32,'', null),
 (747, 178,"53CAC3EF654610AC7E043C6AAD62709EF0B5400DBDE755EB",'', 149, 5,'', null),
 (748, 178,"566637D06BAEA9190B7CE510C697F72CD20FE3D958A95A25",'', 3049888, 31,'', null),
 (749, 113,"3C9B0CC7FE020EEBD43E6B1D88EDDF0EC46AC35974765068","drvsys_mon", 0, 0,'', null),
 (750, 191,"BDFEE5DCDD37FC5B2A1B3E42FBE5F7997CFED35E86062EB6",'', 28920, 23,'', null),
 (751, 191,"7794AE60131E4D07860DB48047206784B885B30457EAB83E",'', 12194860, 37,'', null),
 (752, 178,"653A308BB00D914AE1ECD773BA4B0BA7724874BC62647D10",'', 3037164, 22,'', null),
 (753, 178,"06B696C35F905E75B451A02E121BDA0330CD44E0D9B872BF",'', 60648, 56,'', null),
 (754, 191,"35E8CD9E8CBD879B1E53278926C634AA8B72B8D9A20009F9",'', 17522, 15,'', null),
 (755, 191,"9B13F2E744904ADAAA062F9113A576D11C2C450D1CD6A4AB",'', 13033, 36,'', null),
 (756, 191,"60851B4A6F7338632A84795FBBB20320E49AD2CC2034BA80",'', 28940, 17,'', null),
 (757, 191,"3BC0BE02AE0B6975974D3B13B811EC6BDACBF9EE122BE633",'', 90202, 13,'', null),
 (758, 191,"E47F7DD8D5B5C29B70AFFD4F25AA286167D411937F9BD247",'', 36907, 24,'', null),
 (759, 178,"35D1CDEE86A410DF087DE6D5F5AC6289C4888B9753293E73",'', 3037164, 22,'', null),
 (760, 191,"2ED2EEB29EE0D48477779E5CA875F1F5F15CCE74CA85BDAA",'', 28956, 17,'', null),
 (761, 191,"78C3A74F7624B26478D4C98BAF1194D9A8E1B33D6AF89DD6",'', 174688, 37,'', null),
 (762, 178,"3D02551F548DFB58832626FE90A7AAA12824D93A54A0DC14",'', 709322, 22,'', null),
 (763, 191,"09D04CF8ABC51D06D874784442987E5F2631041550607255",'', 36544, 55,'', null),
 (764, 191,"F3CD473F8C85977895CA5BA9DC22185BCCBBF6B977205193",'', 448492, 48,'', null),
 (765, 191,"30E2F23DB1038D16D2DEEAB1D0F1790D961E468368DC5108",'', 30012, 16,'', null),
 (766, 191,"540D465F760320A63981289D30CD40CCC770EE126523C71D",'', 477912, 60,'', null),
 (767, 191,"C461E1BE054FE29A1FD58B33D33890BC4A1279DE4F572B47",'', 37180, 24,'', null),
 (768, 191,"1AC3D903CFCA11321E76A257BDA0608E5060030BE745CCF3",'', 130380, 14,'', null),
 (769, 178,"96281A2887E61232007D7015E4A35DA118794841A8EC84BC",'', 3037164, 22,'', null),
 (770, 178,"8A1AC926B46A9E3D60D3BD87A59FF77D7B80A1510BC327A7",'', 710730, 23,'', null),
 (771, 191,"3620B6BDF3993B87FD35E906FE8376A04FF34684E2023D8E",'', 41280, 16,'', null),
 (772, 191,"025C373F05EC6E809EF5A86A903570FDA14D219286BCED5E",'', 448492, 48,'', null),
 (773, 178,"5C0E4EE98C4E34CBE44F6BD595C13DD675555164A8D491DA",'', 710554, 23,'', null),
 (774, 191,"BECE667BF9443EF6515E8E154F74FC2C5817455C8636DB72",'', 501956, 48,'', null),
 (775, 191,"94F1DA3E0D955761826D6BC932E26F44D321B4838C7567D8",'', 13538, 15,'', null),
 (776, 191,"EA3A3AD71FD14B038C98F256E80C1EFA1F45562A3DF92E7D",'', 22792, 25,'', null),
 (777, 191,"AD5A8CBF55EC436DA968EE0B9744C93F65D9E0D6E3C1B136",'', 174688, 37,'', null),
 (778, 191,"9B6B3B311BA9007C06CF0D146BB979B11CF295C58768DD4F",'', 31924, 23,'', null),
 (779, 191,"A373FDB6A789CC46072A4CC51A429C817C40862DC6C0190F",'', 30012, 16,'', null),
 (780, 243,'','', 5345728, 2,"558B","Lua Protection Remover"),
 (781, 243,'','', 7726137, 2, 7414,"Walk on Water Patch"),
 (782, 243,'','', 8016620, 2, 7417,"Collision M2 Special"),
 (783, 243,'','', 8016079, 6,"0F8462010000","Collision M2 Regular"),
 (784, 243,'','', 8054762, 2, 7506,"Collision WMD"),
 (785, 243,'','', 9995315, 2, 7544,"Multi-Jump Patch"),
 (786, 217,'',"WPESPY.DLL", 0, 0,'',"WPE PRO - injected dll"),
 (787, 217,'',"RPE.DLL", 0, 0,'',"rEdoX Packet Editor - injected dll");
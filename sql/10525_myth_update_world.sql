SET NAMES 'utf8';
-- name announce
DELETE FROM `trinity_string` WHERE `entry` IN ('787','788','789','790');
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc8`) VALUES
('788','|CFF00CCFF<Mod>|cffff0000[%s]|c1f40af20 announce: |cffffff00%s|r','|CFF00CCFF<Модератор>|cffff0000[%s]|c1f40af20 анонс: |cffffff00%s|r'),
('789','|CFF0000FF<GM>|cffff0000[%s]|c1f40af20 announce: |cffffff00%s|r','|CFF0000FF<ГМ>|cffff0000[%s]|c1f40af20 анонс: |cffffff00%s|r'),
('790','|cffcc6633<Admin>|cffff0000[%s]|c1f40af20 announce:|cffffff00 %s|r','|cffcc6633<Администратор>|cffff0000[%s]|c1f40af20 анонс: |cffffff00%s|r');

-- transmogrification
DELETE FROM `gossip_menu` WHERE entry = 51000;
INSERT INTO `gossip_menu` VALUES (51000, 51000);
INSERT INTO `npc_text` (ID, text0_0, em0_1) VALUES
(51000, 'Put in the first slot of bag item, that you want to transmogrify. In the second slot, put item with perfect display.', 0);

DELETE FROM `creature_template` WHERE entry = 190001;
INSERT INTO `creature_template` (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, Health_mod, Mana_mod, Armor_mod, faction_A, faction_H, npcflag, speed_walk, speed_run, scale, rank, dmg_multiplier, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, ScriptName) VALUES 
(190001, 15998, "Transmogrify Master", "", 'Speak', 50000, 71, 71, 1.56, 1.56, 1.56, 35, 35, 3, 1, 1.14286, 1.25, 1, 1, 1, 2, 7, 138936390, 3, 1, 2, 'npc_transmogrify'); 

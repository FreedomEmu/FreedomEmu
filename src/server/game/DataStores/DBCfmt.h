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

#ifndef TRINITY_DBCSFRM_H
#define TRINITY_DBCSFRM_H

const char Achievementfmt[]="niixssssssssssssssssxxxxxxxxxxxxxxxxxxiixixxxxxxxxxxxxxxxxxxii";
const std::string CustomAchievementfmt="pppaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaapapaaaaaaaaaaaaaaaaaapp";
const std::string CustomAchievementIndex = "ID";
const char AchievementCriteriafmt[]="niiiiiiiixxxxxxxxxxxxxxxxxiiiix";
const char AreaTableEntryfmt[]="iiinixxxxxissssssssssssssssxiiiiixxx";
const char AreaGroupEntryfmt[]="niiiiiii";
const char AreaPOIEntryfmt[]="niiiiiiiiiiifffixixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxix";
const char AreaTriggerEntryfmt[]="niffffffff";
const char AuctionHouseEntryfmt[]="niiixxxxxxxxxxxxxxxxx";
const char BankBagSlotPricesEntryfmt[]="ni";
const char BarberShopStyleEntryfmt[]="nixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiii";
const char BattlemasterListEntryfmt[]="niiiiiiiiixssssssssssssssssxiixx";
const char CharStartOutfitEntryfmt[]="diiiiiiiiiiiiiiiiiiiiiiiiixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const char CharTitlesEntryfmt[]="nxssssssssssssssssxxxxxxxxxxxxxxxxxxi";
const char ChatChannelsEntryfmt[]="nixssssssssssssssssxxxxxxxxxxxxxxxxxx";
                                                            // ChatChannelsEntryfmt, index not used (more compact store)
const char ChrClassesEntryfmt[]="nxixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixii";
const char ChrRacesEntryfmt[]="nxixiixixxxxixssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxi";
const char CinematicSequencesEntryfmt[]="nxxxxxxxxx";
const char CreatureDisplayInfofmt[]="nxxxfxxxxxxxxxxx";
const char CreatureFamilyfmt[]="nfifiiiiixssssssssssssssssxx";
const char CreatureSpellDatafmt[]="niiiixxxx";
const char CreatureTypefmt[]="nxxxxxxxxxxxxxxxxxx";
const char CurrencyTypesfmt[]="xnxi";
const char DestructibleModelDatafmt[]="nxxixxxixxxixxxixxx";
const char DungeonEncounterfmt[]="niixissssssssssssssssxx";
const char DurabilityCostsfmt[]="niiiiiiiiiiiiiiiiiiiiiiiiiiiii";
const char DurabilityQualityfmt[]="nf";
const char EmotesEntryfmt[]="nxxiiix";
const char EmotesTextEntryfmt[]="nxixxxxxxxxxxxxxxxx";
const char FactionEntryfmt[]="niiiiiiiiiiiiiiiiiiffixssssssssssssssssxxxxxxxxxxxxxxxxxx";
const char FactionTemplateEntryfmt[]="niiiiiiiiiiiii";
const char GameObjectDisplayInfofmt[]="nsxxxxxxxxxxffffffx";
const char GemPropertiesEntryfmt[]="nixxi";
const char GlyphPropertiesfmt[]="niii";
const char GlyphSlotfmt[]="nii";
const char GtBarberShopCostBasefmt[]="f";
const char GtCombatRatingsfmt[]="f";
const char GtChanceToMeleeCritBasefmt[]="f";
const char GtChanceToMeleeCritfmt[]="f";
const char GtChanceToSpellCritBasefmt[]="f";
const char GtChanceToSpellCritfmt[]="f";
const char GtOCTClassCombatRatingScalarfmt[]="df";
const char GtOCTRegenHPfmt[]="f";
//const char GtOCTRegenMPfmt[]="f";
const char GtRegenHPPerSptfmt[]="f";
const char GtRegenMPPerSptfmt[]="f";
const char Holidaysfmt[]="nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const char Itemfmt[]="niiiiiii";
const char ItemBagFamilyfmt[]="nxxxxxxxxxxxxxxxxx";
//const char ItemDisplayTemplateEntryfmt[]="nxxxxxxxxxxixxxxxxxxxxx";
//const char ItemCondExtCostsEntryfmt[]="xiii";
const char ItemExtendedCostEntryfmt[]="niiiiiiiiiiiiiix";
const char ItemLimitCategoryEntryfmt[]="nxxxxxxxxxxxxxxxxxii";
const char ItemRandomPropertiesfmt[]="nxiiixxssssssssssssssssx";
const char ItemRandomSuffixfmt[]="nssssssssssssssssxxiiixxiiixx";
const char ItemSetEntryfmt[]="dssssssssssssssssxiiiiiiiiiixxxxxxxiiiiiiiiiiiiiiiiii";
const char LFGDungeonEntryfmt[]="nxxxxxxxxxxxxxxxxxiiiiiiixixxixixxxxxxxxxxxxxxxxx";
const char LiquidTypefmt[]="nxxixixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const char LockEntryfmt[]="niiiiiiiiiiiiiiiiiiiiiiiixxxxxxxx";
const char MailTemplateEntryfmt[]="nxxxxxxxxxxxxxxxxxssssssssssssssssx";
const char MapEntryfmt[]="nxixxssssssssssssssssxixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixiffxiix";
const char MapDifficultyEntryfmt[]="diisxxxxxxxxxxxxxxxxiix";
const char MovieEntryfmt[]="nxx";
const char OverrideSpellDatafmt[]="niiiiiiiiiix";
const char QuestSortEntryfmt[]="nxxxxxxxxxxxxxxxxx";
const char QuestXPfmt[]="niiiiiiiiii";
const char QuestFactionRewardfmt[]="niiiiiiiiii";
const char PvPDifficultyfmt[]="diiiii";
const char RandomPropertiesPointsfmt[]="niiiiiiiiiiiiiii";
const char ScalingStatDistributionfmt[]="niiiiiiiiiiiiiiiiiiiii";
const char ScalingStatValuesfmt[]="iniiiiiiiiiiiiiiiiixiiii";
const char SkillLinefmt[]="nixssssssssssssssssxxxxxxxxxxxxxxxxxxixxxxxxxxxxxxxxxxxi";
const char SkillLineAbilityfmt[]="niiiixxiiiiixx";
const char SoundEntriesfmt[]="nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const char SpellCastTimefmt[]="nixx";
const char SpellDifficultyfmt[]="niiii";
const std::string CustomSpellDifficultyfmt="ppppp";
const std::string CustomSpellDifficultyIndex="id";
const char SpellDurationfmt[]="niii";
const char SpellEntryfmt[]="niiiiiiiiiiiixixiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifxiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiifffiiiiiiiiiiiiixssssssssssssssssxssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiiiiiiiiiiixfffxxxiiiiixxfffxx";
const std::string CustomSpellEntryfmt="pappppppppaapapapaaaaaaaaaaapaaapapppppppaaaaapaapaaaaaaaaaaaaaaaaaappppppppppppppppppppppppppppppppppppaaaaaapppppppppaaapppppppppaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaappppppppapppaaaaappaaaaaaa";
const std::string CustomSpellEntryIndex = "Id";
const char SpellFocusObjectfmt[]="nxxxxxxxxxxxxxxxxx";
const char SpellItemEnchantmentfmt[]="nxiiiiiixxxiiissssssssssssssssxiiiiiii";
const char SpellItemEnchantmentConditionfmt[]="nbbbbbxxxxxbbbbbbbbbbiiiiiXXXXX";
const char SpellRadiusfmt[]="nfxf";
const char SpellRangefmt[]="nffffixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const char SpellRuneCostfmt[]="niiii";
const char SpellShapeshiftfmt[]="nxxxxxxxxxxxxxxxxxxiixiiixxiiiiiiii";
const char StableSlotPricesfmt[] = "ni";
const char SummonPropertiesfmt[] = "niiiii";
const char TalentEntryfmt[]="niiiiiiiixxxxixxixxxxxx";
const char TalentTabEntryfmt[]="nxxxxxxxxxxxxxxxxxxxiiix";
const char TaxiNodesEntryfmt[]="nifffssssssssssssssssxii";
const char TaxiPathEntryfmt[]="niii";
const char TaxiPathNodeEntryfmt[]="diiifffiiii";
const char TeamContributionPointsfmt[]="df";
const char TotemCategoryEntryfmt[]="nxxxxxxxxxxxxxxxxxii";
const char VehicleEntryfmt[]="niffffiiiiiiiifffffffffffffffssssfifiixx";
const char VehicleSeatEntryfmt[]="niiffffffffffiiiiiifffffffiiifffiiiiiiiffiiiiixxxxxxxxxxxx";
const char WMOAreaTableEntryfmt[]="niiixxxxxiixxxxxxxxxxxxxxxxx";
const char WorldMapAreaEntryfmt[]="xinxffffixx";
const char WorldMapOverlayEntryfmt[]="nxiiiixxxxxxxxxxx";
const char WorldSafeLocsEntryfmt[]="nifffxxxxxxxxxxxxxxxxx";

#endif

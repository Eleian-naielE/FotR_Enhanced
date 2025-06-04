--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Jorritkarwehr
--*   @Date:                2018-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            HeroFighterLibrary.lua
--*   @Last modified by:    [TR]Jorritkarwehr
--*   @Last modified time:  2021-05-25T09:58:	14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
function Get_Hero_Entries(upgrade_object)
	--Index is name of build option to open popup. For ground units tied to an orbiting unit, it is the rebuild option if one exists, or a dummy value that should not match the name of any buildable unit if it does not
	--Hero_Squadron = name of spawned squadron. Can be a table to define multiple options
	--PopupHeader = name of header object for popup
	--Options = first item in sublist is popup option suffix. Locations is a list of all heroes who are associated with this option. Optionally, GroundPerception is the perception to detect these heroes for ground forms.
	--NoInit = optional parameter to prevent fighter from being automatically assigned to the first found hero on startup
	--Faction = Primary owner who is the only valid init. Optional, and Factions[1] will serve the same purpose if not defined
	--Factions = specifies faction list for ground reinforcement perceptions. If a primary faction exists it should be specified first for efficiency
	--NoPlayerInit  = NoInit if Faction is Human. Requires Faction/Factions
	--GroundCompany = name of company to add to reinforcements when squadron/ship is in orbit. Requires GroundPerception and Factions. Can be a table to define multiple options
	--NoSpawnFlag = name of global variable that will prevent spawn. If used the squadron will not be cleared even if Enabler is set
	--Enabler = name of object used to reenable ground forms of fighter squadrons when killed. If not set the hero will not be unassigned and disabled
	--DeathMessage = The string to display when a GroundCompany is killed. Optional field
	--Hero_Squadron and GroundCompany multiple values default to the first listed. Others are accessed through Set_Fighter_Hero_Index and Set_Fighter_Hero_Ground_Index, with arguements of the index and name of the new value
	
	--When piggybacking reinforcement system to check for orbital object instead of squadron, set a dummy index that does not match any buildable object and set NoInit to prevent all the missing fields from causing errors. 
	--GroundReinforcementPerception = the perception to detect when a unit is in orbit. Requires Faction and GroundCompany
	--NoSpawnFlag = name of global variable that will prevent spawn
	
	--WARNING: using indexes with too long of names can prevent them from working in grount tactical. It makes no sense, but watch that
	local heroes = {
		--GAR
		["ARHUL_NARRA_LOCATION_SET"] = {
			Hero_Squadron = "ARHUL_NARRA_GUARDIAN_SQUADRON",
			PopupHeader = "ARHUL_NARRA_SELECTOR_HEADER",
			Options = {
				{"DODONNA", Locations = {"DODONNA_ARDENT"}},
				{"PARCK", Locations = {"PARCK_STRIKEFAST"}},
				{"TARKIN", Locations = {"TARKIN_VENATOR","TARKIN_EXECUTRIX"}},
				{"THERBON", Locations = {"THERBON_CERULEAN_SUNRISE"}},
			}
		},
		["GARVEN_DREIS_LOCATION_SET"] = {
			Hero_Squadron = "GARVEN_DREIS_RAREFIED_SQUADRON",
			PopupHeader = "GARVEN_DREIS_SELECTOR_HEADER",
			Options = {
				{"GRANT", Locations = {"GRANT_VENATOR"}},
				{"RAVIK", Locations = {"RAVIK_VICTORY"}},
				{"PRAJI", Locations = {"PRAJI_VALORUM"}},
				{"GRUMBY", Locations = {"GRUMBY_INVINCIBLE"}},
				{"SCREED", Locations = {"SCREED_ARLIONNE","SCREED_DEMOLISHER"}},
			}
		},
		["NIAL_DECLANN_LOCATION_SET"] = {
			Hero_Squadron = "NIAL_DECLANN_SQUADRON",
			PopupHeader = "NIAL_DECLANN_SELECTOR_HEADER",
			Options = {
				{"BARAKA", Locations = {"BARAKA_NEXU"}},
				{"WESSEL", Locations = {"WESSEL_ACCLAMATOR"}},
				{"PELLAEON", Locations = {"PELLAEON_LEVELER"}},
				{"MARTZ", Locations = {"MARTZ_PROSECUTOR"}},
				{"TALLON", Locations = {"TALLON_SUNDIVER","TALLON_BATTALION"}},
			}
		},
		["RHYS_DALLOWS_LOCATION_SET"] = {
			Hero_Squadron = "RHYS_DALLOWS_BRAVO_SQUADRON",
			PopupHeader = "RHYS_DALLOWS_SELECTOR_HEADER",
			Options = {
				{"AUTEM", Locations = {"AUTEM_VENATOR"}},
				{"DALLIN", Locations = {"DALLIN_KEBIR"}},
				{"HAUSER", Locations = {"HAUSER_DREADNAUGHT"}},
				{"MAARISA", Locations = {"MAARISA_CAPTOR","MAARISA_RETALIATION"}},
			}
		},
		["ARON_ONSTALL_LOCATION_SET"] = {
			Hero_Squadron = "ONSTALL_NTB_630_SQUADRON",
			PopupHeader = "ARON_ONSTALL_SELECTOR_HEADER",
			Options = {
				{"TALLON", Locations = {"TALLON_SUNDIVER","TALLON_BATTALION"}},
				{"GRANT", Locations = {"GRANT_VENATOR"}},
				{"AUTEM", Locations = {"AUTEM_VENATOR"}},
				{"DODONNA", Locations = {"DODONNA_ARDENT"}},
				{"MAARISA", Locations = {"MAARISA_CAPTOR","MAARISA_RETALIATION"}},
			}
		},
		["ODD_BALL_TORRENT_LOCATION_SET"] = {
			Hero_Squadron = "ODD_BALL_TORRENT_SQUAD_SEVEN_SQUADRON",
			PopupHeader = "ODD_BALL_P1_SELECTOR_HEADER",
			Options = {
				{"YULAREN", Locations = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY","YULAREN_INVINCIBLE"}, GroundPerception = "Yularen_In_Orbit"},
				{"KILIAN", Locations = {"KILIAN_ENDURANCE"}, GroundPerception = "Kilian_In_Orbit"},
				{"WIELER", Locations = {"WIELER_RESILIENT"}, GroundPerception = "Wieler_In_Orbit"},
				{"WESSEX", Locations = {"WESSEX_REDOUBT"}, GroundPerception = "Denn_Wessex_In_Orbit"},
			},
			GroundCompany = "ODD_BALL_P1_TEAM",
			Factions = {"Empire"},
			Enabler = "REFORM_SQUAD_SEVEN",
			DeathMessage = "Squad Seven has taken crippling casualties and must be reformed.",
		},
		["ODD_BALL_ARC170_LOCATION_SET"] = {
			Hero_Squadron = "ODD_BALL_ARC170_SQUAD_SEVEN_SQUADRON",
			PopupHeader = "ODD_BALL_P2_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"YULAREN", Locations = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY","YULAREN_INVINCIBLE"}, GroundPerception = "Yularen_In_Orbit"},
				{"KILIAN", Locations = {"KILIAN_ENDURANCE"}, GroundPerception = "Kilian_In_Orbit"},
				{"WIELER", Locations = {"WIELER_RESILIENT"}, GroundPerception = "Wieler_In_Orbit"},
				{"WESSEX", Locations = {"WESSEX_REDOUBT"}, GroundPerception = "Denn_Wessex_In_Orbit"},
			},
			GroundCompany = "ODD_BALL_P2_TEAM",
			Factions = {"Empire"},
			Enabler = "REFORM_SQUAD_SEVEN2",
			DeathMessage = "Squad Seven has taken crippling casualties and must be reformed.",
		},
		["WARTHOG_TORRENT_LOCATION_SET"] = {
			Hero_Squadron = "WARTHOG_TORRENT_HUNTER_SQUADRON",
			PopupHeader = "WARTHOG_P1_SELECTOR_HEADER",
			Options = {
				{"COBURN", Locations = {"COBURN_VENATOR"}, GroundPerception = "Coburn_In_Orbit"},
				{"DALLIN", Locations = {"DALLIN_KEBIR"}, GroundPerception = "Dallin_In_Orbit"},
				{"DODONNA", Locations = {"DODONNA_ARDENT"}, GroundPerception = "Jan_Dodonna_In_Orbit"},
				{"WIELER", Locations = {"WIELER_RESILIENT"}, GroundPerception = "Wieler_In_Orbit"},
				{"KILIAN", Locations = {"KILIAN_ENDURANCE"}, GroundPerception = "Kilian_In_Orbit"},
				{"WESSEX", Locations = {"WESSEX_REDOUBT"}, GroundPerception = "Denn_Wessex_In_Orbit"},
			},
			GroundCompany = "WARTHOG_P1_TEAM",
			Factions = {"Empire"},
			Enabler = "REFORM_HUNTER_SQUADRON",
			DeathMessage = "Hunter Squadron has taken crippling casualties and must be reformed.",
		},
		["WARTHOG_CLONE_Z95_LOCATION_SET"] = {
			Hero_Squadron = "WARTHOG_CLONE_Z95_HUNTER_SQUADRON",
			PopupHeader = "WARTHOG_P2_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"COBURN", Locations = {"COBURN_VENATOR"}, GroundPerception = "Coburn_In_Orbit"},
				{"DALLIN", Locations = {"DALLIN_KEBIR"}, GroundPerception = "Dallin_In_Orbit"},
				{"DODONNA", Locations = {"DODONNA_ARDENT"}, GroundPerception = "Jan_Dodonna_In_Orbit"},
				{"WIELER", Locations = {"WIELER_RESILIENT"}, GroundPerception = "Wieler_In_Orbit"},
				{"KILIAN", Locations = {"KILIAN_ENDURANCE"}, GroundPerception = "Kilian_In_Orbit"},
				{"COBURN", Locations = {"COBURN_VENATOR"}, GroundPerception = "Coburn_In_Orbit"},
			},
			GroundCompany = "WARTHOG_P2_TEAM",
			Factions = {"Empire"},
			Enabler = "REFORM_HUNTER_SQUADRON2",
			DeathMessage = "Hunter Squadron has taken crippling casualties and must be reformed.",
		},
		["SHEA_HUBLIN_LOCATION_SET"] = {
			Hero_Squadron = "SHEA_HUBLIN_V_WING_SWORD_SQUADRON",
			PopupHeader = "SHEA_HUBLIN_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"TARKIN", Locations = {"TARKIN_VENATOR","TARKIN_EXECUTRIX"}},
				{"TRACHTA", Locations = {"TRACHTA_VENATOR"}},
				{"THERBON", Locations = {"THERBON_CERULEAN_SUNRISE"}},
				{"RAVIK", Locations = {"RAVIK_VICTORY"}},
				{"MULLEEN", Locations = {"MULLEEN_IMPERATOR"}},
				{"YULAREN", Locations = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY","YULAREN_INVINCIBLE"}},
				{"SCREED", Locations = {"SCREED_ARLIONNE","SCREED_DEMOLISHER"}},
				{"PARCK", Locations = {"PARCK_STRIKEFAST"}},
			}
		},
		["JORN_KULISH_LOCATION_SET"] = {
			Hero_Squadron = "JORN_KULISH_FOXFIRE_SQUADRON",
			PopupHeader = "JORN_KULISH_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"BYLUIR", Locations = {"BYLUIR_VENATOR"}},
				{"YULAREN", Locations = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY","YULAREN_INVINCIBLE"}},
				{"KILIAN", Locations = {"KILIAN_ENDURANCE"}},
				{"DAO", Locations = {"DAO_VENATOR"}},
				{"DRON", Locations = {"DRON_VENATOR"}},
			}
		},
		["BRAND_ZETA_LOCATION_SET"] = {
			Hero_Squadron = "BRAND_DELTA7_ZETA_SQUADRON",
			PopupHeader = "BRAND_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"COY", Locations = {"COY_IMPERATOR"}},
				{"GRANT", Locations = {"GRANT_VENATOR"}},
				{"DODONNA", Locations = {"DODONNA_ARDENT"}, GroundPerception = "Jan_Dodonna_In_Orbit"},
				{"DALLIN", Locations = {"DALLIN_KEBIR"}, GroundPerception = "Dallin_In_Orbit"},
			}
		},
		["ERK_HARMAN_LOCATION_SET"] = {
			Hero_Squadron = "ERK_HARMAN_SQUADRON",
			PopupHeader = "ERK_HARMAN_SELECTOR_HEADER",
			Options = {
				{"SLAYKE", Locations = {"ZOZRIDOR_SLAYKE_CARRACK","ZOZRIDOR_SLAYKE_CR90"}},
				{"TARKIN", Locations = {"TARKIN_VENATOR","TARKIN_EXECUTRIX"}},
			}
		},
		-- FotR_Enhanced
		["JAG_ARC170_LOCATION_SET"] = {
			Hero_Squadron = "JAG_ARC170_127TH_SQUADRON",
			PopupHeader = "JAG_P2_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"DODONNA", Locations = {"DODONNA_ARDENT"}},
				{"DALLIN", Locations =  {"DALLIN_KEBIR"}},
				{"AUTEM", Locations = {"AUTEM_VENATOR"}},
				{"COBURN", Locations = {"COBURN_VENATOR"}, GroundPerception = "Coburn_In_Orbit"},
			},
			Factions = {"Empire"},

		},
		["BYTHEN_FORRAL_LOCATION_SET"] = {
			Hero_Squadron = "BYTHEN_FORRAL_SQUADRON",
			PopupHeader = "BYTHEN_FORRAL_SELECTOR_HEADER",
			Options = {
				{"BARAKA", Locations = {"BARAKA_NEXU"}},
				{"SEERDON", Locations = {"SEERDON_INVINCIBLE"}},
				{"DENIMOOR", Locations = {"DENIMOOR_TENACIOUS"}},
				{"KREUGE", Locations = {"KREUGE_GIBBON"}},
			},
			Factions = {"Empire"},
		},
	
		--CIS
		["DFS1VR_LOCATION_SET"] = {
			Hero_Squadron = "DFS1VR_31ST_SQUADRON",
			PopupHeader = "DFS1VR_SELECTOR_HEADER",
			Options = {
				{"TF1726", Locations = {"TF1726_MUNIFICENT"}, GroundPerception = "TF1726_In_Orbit"},
				{"AUTO", Locations = {"AUTO_PROVIDENCE"}, GroundPerception = "AutO_In_Orbit"},
				{"DOCTOR", Locations = {"DOCTOR_INSTINCTION"}, GroundPerception = "Doctor_In_Orbit"},
				{"K2B4", Locations = {"K2B4_PROVIDENCE"}, GroundPerception = "K2B4_In_Orbit"},
				{"COLICOID", Locations = {"COLICOID_SWARM"}, GroundPerception = "Colicoid_Swarm_In_Orbit"},
				{"DEVASTATION", Locations = {"DEVASTATION"}, GroundPerception = "Devastation_In_Orbit"},
			},
			GroundCompany = "DFS1VR_LAND_TEAM",
			Factions = {"Rebel"},
			Enabler = "REFORM_31ST_FLIGHT",
			DeathMessage = "31st Flight has taken crippling casualties and must be rebuilt.",
		},
		["NAS_GHENT_LOCATION_SET"] = {
			Hero_Squadron = "NAS_GHENT_SQUADRON",
			PopupHeader = "NAS_GHENT_SELECTOR_HEADER",
			Options = {
				{"GRIEVOUS", Locations = {"GRIEVOUS_RECUSANT","GRIEVOUS_MUNIFICENT","GRIEVOUS_INVISIBLE_HAND","GRIEVOUS_MALEVOLENCE","GRIEVOUS_MALEVOLENCE_2", "GRIEVOUS_MALEVOLENCE_HUNT_CAMPAIGN"}},
				{"STARK", Locations = {"STARK_RECUSANT"}},
				{"HARSOL", Locations = {"HARSOL_MUNIFICENT"}},
				{"SHU_MAI", Locations = {"SHU_MAI_SUBJUGATOR"}},
				{"DALESHAM", Locations = {"DALESHAM_NOVA_DEFIANT"}},
				{"DEVASTATION", Locations = {"DEVASTATION"}},
			}
		},
		["NWON_RAINES_LOCATION_SET"] = {
			Hero_Squadron = "NWON_RAINES_BELBULLAB23_SQUADRON",
			PopupHeader = "NWON_RAINES_SELECTOR_HEADER",
			Options = {
				{"CALLI", Locations = {"CALLI_TRILM_BULWARK"}},
				{"SHONN", Locations = {"SHONN_RECUSANT"}},
				{"TRENCH", Locations = {"TRENCH_INVINCIBLE","TRENCH_INVULNERABLE"}},
				{"TUUK", Locations = {"TUUK_PROCURER"}},
				{"TREETOR", Locations = {"TREETOR_CAPTOR"}},
				{"STARK", Locations = {"STARK_RECUSANT"}},
			}
		},
		["VULPUS_LOCATION_SET"] = {
			Hero_Squadron = "VULPUS_SQUADRON",
			PopupHeader = "VULPUS_SELECTOR_HEADER",
			Options = {
				{"TONITH", Locations = {"TONITH_CORPULENTUS"}},
				{"LUCID", Locations = {"LUCID_VOICE"}},
				{"CALLI", Locations = {"CALLI_TRILM_BULWARK"}},
				{"K2B4", Locations = {"K2B4_PROVIDENCE"}},
				{"CANTEVAL", Locations = {"CANTEVAL_MUNIFICENT"}},
				{"DEVASTATION", Locations = {"DEVASTATION"}},
			}
		},
		["RAINA_QUILL_LOCATION_SET"] = {
			Hero_Squadron = "RAINA_QUILL_SQUADRON",
			PopupHeader = "RAINA_QUILL_SELECTOR_HEADER",
			Options = {
				{"NINGO", Locations = {"DUA_NINGO_UNREPENTANT"}},
				{"HARSOL", Locations = {"HARSOL_MUNIFICENT"}},
				{"MERAI", Locations = {"MERAI_FREE_DAC"}},
				{"SHONN", Locations = {"SHONN_RECUSANT"}},
				{"DELLSO", Locations = {"DELLSO_PROVIDENCE"}},
				{"YAGO", Locations = {"MELLOR_YAGO_RENDILI_REIGN"}},
			}
		},
		["GORGOL_LOCATION_SET"] = {
			Hero_Squadron = "GORGOL_NANTEX_SQUADRON",
			PopupHeader = "GORGOL_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"DOCTOR", Locations = {"DOCTOR_INSTINCTION"}},
				{"MERAI", Locations = {"MERAI_FREE_DAC"}},
				{"GRIEVOUS", Locations = {"GRIEVOUS_RECUSANT","GRIEVOUS_MUNIFICENT","GRIEVOUS_INVISIBLE_HAND","GRIEVOUS_MALEVOLENCE","GRIEVOUS_MALEVOLENCE_2", "GRIEVOUS_MALEVOLENCE_HUNT_CAMPAIGN"}},
				{"TF1726", Locations = {"TF1726_MUNIFICENT"}},
				{"CANTEVAL", Locations = {"CANTEVAL_MUNIFICENT"}},
				{"DEVASTATION", Locations = {"DEVASTATION"}},
			}
		},
		["88TH_FLIGHT_LOCATION_SET"] = {
			Hero_Squadron = "88TH_FLIGHT_SQUADRON",
			PopupHeader = "88TH_FLIGHT_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"GRIEVOUS", Locations = {"GRIEVOUS_RECUSANT","GRIEVOUS_MUNIFICENT","GRIEVOUS_INVISIBLE_HAND","GRIEVOUS_MALEVOLENCE","GRIEVOUS_MALEVOLENCE_2", "GRIEVOUS_MALEVOLENCE_HUNT_CAMPAIGN"}, GroundPerception = "Grievous_In_Orbit"},
				{"DOCTOR", Locations = {"DOCTOR_INSTINCTION"}, GroundPerception = "Doctor_In_Orbit"},
				{"MERAI", Locations = {"MERAI_FREE_DAC"}, GroundPerception = "Merai_In_Orbit"},
				{"TF1726", Locations = {"TF1726_MUNIFICENT"}, GroundPerception = "TF1726_In_Orbit"},
				{"DEVASTATION", Locations = {"DEVASTATION"}, GroundPerception = "Devastation_In_Orbit"},
			},
			GroundCompany = "88TH_FLIGHT_LAND_TEAM",
			Factions = {"Rebel"},
			Enabler = "REFORM_88TH_FLIGHT",
			DeathMessage = "88th Flight has taken crippling casualties and must be rebuilt.",
		},
		["REBUILD_GRIEVOUS_BODY"] = {
			NoInit = true,
			GroundReinforcementPerception = "Grievous_In_Orbit",
			GroundCompany = "GRIEVOUS_DEPLOYED_TEAM",
			Factions = {"Rebel"},
			NoSpawnFlag = "GROUND_GRIEVOUS_DEAD",
			DeathMessage = "General Grievous' body has been severely damaged and must be replaced."
		},
	
		--Hutts
		["PIKNAB_CARSELS_LOCATION_SET"] = {
			Hero_Squadron = "Piknab_Carsels_Gungan_Glory_Squadron",
			PopupHeader = "PIKNAB_CARSELS_SELECTOR_HEADER",
			Options = {
				{"RIBOGA", Locations = {"RIBOGA_RIGHTFUL_DOMINION"}},
				{"ULAL", Locations = {"ULAL_POTALA_UM_VAR"}},
				{"GANIS", Locations = {"GANIS_NAL_HUTTA_JEWEL"}},
				{"JABBA", Locations = {"JABBA_STAR_JEWEL"}},
				{"JILIAC", Locations = {"JILIAC_DRAGON_PEARL"}},
				{"TOBBA", Locations = {"TOBBA_YTOBBA"}},
				{"MIKA", Locations = {"MIKA_TEMPEST"}},
			}
		},
		["SIQO_VASS_LOCATION_SET"] = {
			Hero_Squadron = "Siqo_Vass_Krayts_Honor_Squadron",
			PopupHeader = "SIQO_VASS_SELECTOR_HEADER",
			Options = {
				{"JABBA", Locations = {"JABBA_STAR_JEWEL"}},
				{"JILIAC", Locations = {"JILIAC_DRAGON_PEARL"}},
				{"GANIS", Locations = {"GANIS_NAL_HUTTA_JEWEL"}},
				{"ULAL", Locations = {"ULAL_POTALA_UM_VAR"}},
				{"RIBOGA", Locations = {"RIBOGA_RIGHTFUL_DOMINION"}},
				{"TOBBA", Locations = {"TOBBA_YTOBBA"}},
				{"MIKA", Locations = {"MIKA_TEMPEST"}},
			}
		},
		["TEROCH_LOCATION_SET"] = {
			Hero_Squadron = "TEROCH_KOMRK_SQUADRON",
			PopupHeader = "TEROCH_SELECTOR_HEADER",
			Options = {
				{"JILIAC", Locations = {"JILIAC_DRAGON_PEARL"}},
				{"JABBA", Locations = {"JABBA_STAR_JEWEL"}},
				{"GANIS", Locations = {"GANIS_NAL_HUTTA_JEWEL"}},
				{"ULAL", Locations = {"ULAL_POTALA_UM_VAR"}},
				{"RIBOGA", Locations = {"RIBOGA_RIGHTFUL_DOMINION"}},
				{"TOBBA", Locations = {"TOBBA_YTOBBA"}},
				{"MIKA", Locations = {"MIKA_TEMPEST"}},
			}
		},
		["SERISSU_LOCATION_SET"] = {
			Hero_Squadron = "SERISSU_SCYK_FIGHTER_SQUADRON",
			PopupHeader = "SERISSU_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"JABBA", Locations = {"JABBA_STAR_JEWEL"}},
				{"JILIAC", Locations = {"JILIAC_DRAGON_PEARL"}},
				{"GANIS", Locations = {"GANIS_NAL_HUTTA_JEWEL"}},
				{"ULAL", Locations = {"ULAL_POTALA_UM_VAR"}},
				{"RIBOGA", Locations = {"RIBOGA_RIGHTFUL_DOMINION"}},
				{"TOBBA", Locations = {"TOBBA_YTOBBA"}},
				{"MIKA", Locations = {"MIKA_TEMPEST"}},
			}
		},
		["TORANI_KULDA_LOCATION_SET"] = {
			Hero_Squadron = "TORANI_KIMOGILA_SQUADRON",
			PopupHeader = "TORANI_KULDA_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"JABBA", Locations = {"JABBA_STAR_JEWEL"}},
				{"JILIAC", Locations = {"JILIAC_DRAGON_PEARL"}},
				{"GANIS", Locations = {"GANIS_NAL_HUTTA_JEWEL"}},
				{"ULAL", Locations = {"ULAL_POTALA_UM_VAR"}},
				{"RIBOGA", Locations = {"RIBOGA_RIGHTFUL_DOMINION"}},
				{"TOBBA", Locations = {"TOBBA_YTOBBA"}},
				{"MIKA", Locations = {"MIKA_TEMPEST"}},
			}
		},
		["SSURUSSK_LOCATION_SET"] = {
			Hero_Squadron = "Ssurussk_Nebula_Raiders_Squadron",
			PopupHeader = "SSURUSSK_SELECTOR_HEADER",
			NoInit = true,
			Options = {
				{"PUNDAR", Locations = {"PUNDAR_PROFIT"}},
				{"QUIST", Locations = {"QUIST_PINNACE"}},
				{"SLAGORTH", Locations = {"SLAGORTH_ARC"}},
				{"SELIMA_KIM", Locations = {"SELIMA_KIM_BLOODTHIRSTY"}},
				{"EYTTYRMIN_BATIIV", Locations = {"EYTTYRMIN_BATIIV"}},
				{"QUINCE", Locations = {"QUINCE_QUINCEYS_GIRL"}},
				{"SORORITY", Locations = {"VEILED_QUEEN_SAVRIP"}},
				{"ZAN_DANE", Locations = {"DANE_SWEET_VICTORY"}},
				{"TARGRIM", Locations = {"TARGRIM_C9979"}},
				{"THALASSIAN", Locations = {"THALASSIAN_HARMZUAY"}},
				{"AYCEN", Locations = {"AYCEN_FREEJACK"}},
				{"NORULAC", Locations = {"NORULAC_FREEBOOTERS"}},
				{"ARDELLA", Locations = {"ARDELLA_SMOKESWIMMER"}},
				{"RENTHAL", Locations = {"RENTHALS_FIST"}},
				{"DREDNAR", Locations = {"DREDNAR_SABLE_III"}},
				{"VULTURE_PIRATES", Locations = {"VULTURE_PIRATES"}},
				{"LOOSE_CANNON", Locations = {"LOOSE_CANNON_PIRATES"}},
			}
		},
	}

	if upgrade_object ~= nil then
		return heroes[upgrade_object]
	end

	return heroes
end

function Get_Hero_Upgrade(upgrade_object)
	--Define Setter and NewObject of an entry with the index being the name of a dummy object that triggers the change
	local upgrades = {
	}

	return upgrades[upgrade_object]
end

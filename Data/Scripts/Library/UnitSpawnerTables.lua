function DefineRosterOverride(planet)
	planetTable = {
		BALMORRA = "CLASSIC_TF",
		CATO_NEIMOIDIA = "CLASSIC_TF",
		DEKO_NEIMOIDIA = "CLASSIC_TF",
		DRUCKENWELL = "CLASSIC_TF",
		ENARC = "CLASSIC_TF",
		HYPORI = "CLASSIC_TF",
		KORU_NEIMOIDIA = "CLASSIC_TF",
		VULPTER = "CLASSIC_TF",	
		AARGAU = "CLASSIC_IGBC",
		BELKADAN = "CLASSIC_IGBC",
		DUBRILLION = "CLASSIC_IGBC",
		KARAVIS = "CLASSIC_IGBC",	
		MORISHIM = "CLASSIC_IGBC",		
		MYGEETO = "CLASSIC_IGBC",
		SCIPIO = "CLASSIC_IGBC",
		CORELLIA = "CECORELLIAN",
		FOLESS = "CECORELLIAN",
		SACORRIA = "CECORELLIAN",
		TALFAGLIO = "CECORELLIAN",
		TALUS_TRALUS = "CECORELLIAN",
		BYBLOS = "CECORELLIAN",		
		MINNTOOINE = "FREE_DAC",
		PAMMANT = "FREE_DAC",
		RENDILI = "STARDRIVE",
		SLUIS_VAN = "STARDRIVE",
		ATRAVIS = "REP_ORSF",
		BELSAVIS = "REP_ORSF",
		EIATTU= "REP_ORSF",
		KABAL = "REP_ORSF",
		KRISELIST = "REP_ORSF",
		ORD_VAUG = "REP_ORSF",
		SARRISH = "REP_ORSF",
		THYFERRA = "REP_ORSF",
		WOOSTRI = "REP_ORSF",
		KAMINO = "CLONES",
		ARKANIA = "CLONES",
		BYSS = "CLONES",
		COLUMUS = "CLONES",
		KHOMM = "CLONES",
		WAYLAND = "CLONES",
		ENTRALLA = "KUATI",
		GYNDINE = "KUATI",
		KUAT = "KUATI",
		ROTHANA = "ROTHANAN",
		BEGEREN = "SITHWORLD_REP",
		DROMUND = "SITHWORLD_REP",
		KAR_DELBA = "SITHWORLD_REP",
		KORRIBAN = "SITHWORLD_REP",
		YAVIN = "SITHWORLD_REP",
		ZIOST = "SITHWORLD_REP",
		JABIIM = "NIMBUS",
		BPFASSH = "ROGUE_JEDI",
		CORUSCANT = "CORUSCANT_GUARD",
		MANDALORE = "MANDALORIANS",
	}

	return planetTable[planet]
end

function DefineUnitTable(faction, rosterOverride)
	if faction == "TECHNO_UNION" or faction == "COMMERCE_GUILD" or faction == "BANKING_CLAN" or faction == "TRADE_FEDERATION" then
		faction = "REBEL"
	end

	if faction == "EMPIRE" and (rosterOverride == "CLASSIC_TF" or rosterOverride == "CLASSIC_IGBC" or rosterOverride == "FREE_DAC" or rosterOverride == "NIMBUS") then
		rosterOverride = nil
	end

	if (faction == "REBEL" or GlobalValue.Get("CURRENT_ERA") <= 1) and rosterOverride == "CLONES" then
		rosterOverride = nil
	end

	if faction == "REBEL" and rosterOverride == "STARDRIVE" then
		rosterOverride = "STARDRIVE_CIS"
	end

	if faction == "REBEL" and rosterOverride == "KUATI" then
		rosterOverride = "KUATI_CIS"
	end

	if faction == "REBEL" and rosterOverride == "ROTHANAN" then
		rosterOverride = "KUATI_CIS"
	end

	if faction == "REBEL" and rosterOverride == "REP_ORSF" then
		rosterOverride = nil
	end

	if faction == "REBEL" and rosterOverride == "SITHWORLD_REP" then
		rosterOverride = "SITHWORLD_CIS"
	end

	local government = GameRandom.Free_Random(1, 8)
	local IF_Gov
	if government == 8 then
		IF_Gov = "Revolt_Scavenger_Base"
	elseif government == 7 then
		IF_Gov = "Revolt_Security_HQ"
	elseif government == 6 then
		IF_Gov = "Revolt_Corporate_HQ"
	elseif government == 5 then
		IF_Gov = "Revolt_Local_HQ_Urban"
	elseif government == 4 then
		IF_Gov = "Revolt_Local_HQ_Rural"
	elseif government == 3 then
		IF_Gov = "Revolt_PDF_HQ_Urban"
	elseif government == 2 then
		IF_Gov = "Revolt_PDF_HQ_Rural"
	else
		IF_Gov = "Revolt_PDF_HQ"
	end

	local Faction_Table = {
		EMPIRE = {
			Space_Unit_Table = {
				{"Invincible_Cruiser", 1, LastYear = -21}
				,{"Venator_Star_Destroyer", 1, StartYear = -21}
				,{"Victory_I_Star_Destroyer", 1, StartYear = -20}
				,{"Imperial_DHC", 4, StartYear = -19}
				,{"REP_DHC", 4}
				,{"PDF_DHC", 4}
				,{"Carrack_Cruiser_Lasers", 5}
				,{"Acclamator_I_Carrier", 4, StartYear = -22}
				,{"Acclamator_I_Assault", 4, StartYear = -22}
				,{"Acclamator_II", 4, StartYear = -19}
				,{"Class_C_Frigate", 3, LastYear = -21}
				,{"Arquitens", 3, StartYear = -21}
				,{"Pelta_Assault", 3, StartYear = -22}
				,{"Pelta_Support", 3, StartYear = -22}
				,{"LAC", 3}
				,{"Consular_Refit", 3, LastYear = -22}
				,{"Charger_C70", 3, StartYear = -22}
				,{"CR90", 5}
				,{"DP20", 5}
			},
			Land_Unit_Table = {
				{"Republic_Trooper_Company", 5}
				,{"Republic_Heavy_Trooper_Company", 1}
				,{"Republic_Navy_Trooper_Company", 3}
				,{"Special_Tactics_Trooper_Company", 3}
				,{"Clonetrooper_Phase_One_Company", 5, StartYear = -21, LastYear = -21}
				,{"Clonetrooper_Phase_Two_Company", 5, StartYear = -20}
				,{"Clone_Galactic_Marine_Company", 1, StartYear = -20} -- FotR_Enhanced ; mathced with Phase 2 research
				,{"Republic_SD_6_Droid_Company", 1}
				,{"Ailon_Nova_Guard_Company", 0.5}
				,{"Republic_AT_PT_Company", 2}
				,{"Republic_AT_RT_Company", 2, StartYear = -22}
				,{"AT_XT_Company", 2, StartYear = -22, LastYear = -22}
				,{"Republic_Overracer_Speeder_Bike_Company", 2, LastYear = -23}
				,{"Republic_74Z_Bike_Company", 2, StartYear = -22, LastYear = -21}
				,{"Republic_BARC_Company", 2, StartYear = -20}
				,{"Republic_ISP_Company", 2, StartYear = -20}
				,{"Republic_TX130S_Company", 2, StartYear = -22}
				,{"Republic_TX130T_Company", 2, StartYear = -19}
				,{"AV7_Company", 2, StartYear = -22}
				,{"Republic_UT_AA_Company", 1, StartYear = -22}
				,{"Republic_LAAT_Company", 1, StartYear = -22}
				,{"Republic_VAAT_Company", 0.5, LastYear = -21}
				,{"Republic_Gaba18_Company", 1}
				,{"Republic_Flashblind_Company", 0.5, StartYear = -20, LastYear = -19}
				,{"HAET_Company", 0.5, StartYear = -19}
				,{"AT_OT_Walker_Company", 0.5, StartYear = -19}
				,{"Republic_AT_AP_Walker_Company", 1, StartYear = -19}
				,{"Republic_A5RX_Company", 0.2, StartYear = -22}
				,{"Republic_A5_Juggernaut_Company", 1, StartYear = -22}
				,{"UT_AT_Speeder_Company", 1, StartYear = -20} -- FotR_Enhanced ; mathced with roster update 21BBY M6
				,{"Republic_AT_TE_Walker_Company", 1, StartYear = -22}
				,{"Republic_Gian_Company", 1, LastYear = -21}
				-- FotR_Enhanced
				,{"SPHA_T_Company", 1, LastYear = -22}
				,{"Republic_A6_Prototype_Company", 0.5, StartYear = -21, LastYear = -20}
			},
			Groundbase_Table = {
				"E_Ground_Barracks",
				"E_Ground_Barracks",
				"E_Ground_Light_Vehicle_Factory",
				"E_Ground_Heavy_Vehicle_Factory",
				"E_Ground_Advanced_Vehicle_Factory",
			},
			Starbase_Table = {
				"Empire_Star_Base_1",
				"Empire_Star_Base_2",
				"Empire_Star_Base_3",
				"Empire_Star_Base_4",
				"Empire_Star_Base_5",
			},
			Shipyard_Table = {
				"Republic_Shipyard_Level_One",
				"Republic_Shipyard_Level_Two",
				"Republic_Shipyard_Level_Three",
				"Republic_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				"Secondary_Haven",
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = "Empire_Office",
			GTS_Building = "Ground_Hypervelocity_Gun",
			Base_Defences = "Galactic_Turbolaser_Tower_Defenses_Republic"
		},
		REBEL = {
			Space_Unit_Table = {
				{"Providence_Destroyer", 2, StartYear = -22}
				,{"Providence_Carrier", 1, StartYear = -22}
				,{"Providence_Carrier_Destroyer", 2, StartYear = -21}
				,{"Lucrehulk_Core_Destroyer", 1, StartYear = -22}
				,{"Bulwark_I", 1, StartYear = -20}
				,{"Munificent_Heavy_Cruiser", 0.5}				
				,{"Captor", 4}
				,{"Auxilia", 4}
				,{"Recusant_Light_Destroyer", 4, StartYear = -22}
				,{"C9979_Carrier", 5}
				,{"Hardcell", 5}
				,{"Hardcell_Tender", 2}
				,{"Munificent", 4}
				,{"Munificent_Tender", 0.5}
				,{"Munificent_C3", 0.5}
				,{"Munifex", 5}
				,{"Diamond_Frigate", 5}
				,{"Lupus_Missile_Frigate", 5}
				,{"Geonosian_Cruiser", 1}
				,{"CIS_PDF_DHC", 1}
				,{"CIS_DHC", 0.25}				
				,{"Gozanti_Cruiser_Group", 5}
				,{"Pursuer_Enforcement_Ship_Group", 2, StartYear = -21}				
				,{"DH_Omni", 2}
			},
			Land_Unit_Table = {
				{"B1_Droid_Company", 3}
				,{"B2_Droid_Company", 3, StartYear = -22}
				,{"Destroyer_Droid_I_P_Company", 1}
				,{"Destroyer_Droid_I_W_Company", 1, StartYear = -22}
				,{"Destroyer_Droid_I_Q_Company", 1, StartYear = -20}
				,{"Destroyer_Droid_II_Company", 0.2, StartYear = -19}
				,{"Nimbus_Commando_Company", 0.2, StartYear = -21}
				,{"Neimoidian_Guard_Company", 0.5}
				,{"Skakoan_Combat_Engineer_Company", 0.5}
				,{"BX_Commando_Company", 1, StartYear = -22}
				,{"Crab_Droid_Company", 2}
				,{"Dwarf_Spider_Droid_Company", 2}
				,{"STAP_Company", 2}
				,{"GAT_Company", 2, LastYear = -22}
				,{"AAT_Company", 1}
				,{"HAG_Company", 1}
				,{"HAML_Company", 1}
				,{"MTT_Company", 1}
				,{"OG9_Company", 1}
				,{"Magna_Octuptarra_Company", 1}
				,{"Persuader_Company", 1}
				,{"Persuader_Assault_Company", 0.25}
				,{"Hailfire_Company", 2}
				,{"J1_Cannon_Company", 1, StartYear = -22}
				,{"CA_Artillery_Company", 1}
				,{"PAC_Company", 1}
				,{"MAF_Company", 1}
				,{"HMP_Company", 1, StartYear = -19}
			},
			Groundbase_Table = {
				"R_Ground_Barracks",
				"R_Ground_Barracks",
				"R_Ground_Light_Vehicle_Factory",
				"R_Ground_Heavy_Vehicle_Factory",
				"R_Ground_Advanced_Vehicle_Factory",
			},
			Starbase_Table = {
				"Rebel_Star_Base_1",
				"Rebel_Star_Base_2",
				"Rebel_Star_Base_3",
				"Rebel_Star_Base_4",
				"Rebel_Star_Base_5",
			},
			Shipyard_Table = {
				"CIS_Shipyard_Level_One",
				"CIS_Shipyard_Level_Two",
				"CIS_Shipyard_Level_Three",
				"CIS_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				"Secondary_TF_Outpost",
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = "Rebel_Office",
			GTS_Building = "Ground_Ion_Cannon",
			Base_Defences = "Galactic_Turbolaser_Tower_Defenses_CIS"
		},
		SECTOR_FORCES = {
			Space_Unit_Table = {
				{"Invincible_Cruiser", 3}
				,{"Tagge_Battlecruiser", 0.1}
				,{"PDF_DHC", 4}
				,{"REP_DHC", 3}
				,{"DHC_Carrier", 2}
				,{"Carrack_Cruiser_Lasers", 5}
				,{"Acclamator_I_Carrier", 4, StartYear = -22}
				,{"Acclamator_I_Assault", 4, StartYear = -22}
				,{"Praetor_I_Battlecruiser", 0.1}
				,{"Citadel_Cruiser_Group", 3}
				,{"Galleon", 3}
				,{"Class_C_Frigate", 3}
				,{"Class_C_Support", 3}
				,{"Starbolt", 3}
				,{"CEC_Light_Cruiser", 3}
				,{"CR90", 5}
				,{"DP20", 5}
				,{"LAC", 3}
				,{"Consular_Refit", 3}
				,{"Customs_Corvette", 5}
				,{"IPV1", 5}
			},
			Land_Unit_Table = {
				{"Republic_Trooper_Company", 5}
				,{"Republic_Heavy_Trooper_Company", 2}
				,{"Republic_Navy_Trooper_Company", 3}
				,{"Special_Tactics_Trooper_Company", 3}
				,{"Republic_AT_PT_Company", 2}
				,{"Republic_Overracer_Speeder_Bike_Company", 2}
				,{"Republic_ULAV_Company", 2, StartYear = -22}
				,{"Republic_VAAT_Company", 1}
				,{"Republic_Gaba18_Company", 1}
				,{"Republic_A5RX_Company", 0.2, StartYear = -22}
				,{"Republic_A5_Juggernaut_Company", 1, StartYear = -22}
				,{"Republic_A4_Juggernaut_Company", 1}
				,{"Republic_Gian_Company", 1}
			},
			Groundbase_Table = {
				"SF_Ground_Barracks",
				"SF_Ground_Barracks",
				"SF_Ground_Light_Vehicle_Factory",
				"SF_Ground_Advanced_Vehicle_Factory",
			},
			Starbase_Table = {
				"Empire_Star_Base_1",
				"Empire_Star_Base_2",
				"Empire_Star_Base_3",
				"Empire_Star_Base_4",
				"Empire_Star_Base_5",
			},
			Shipyard_Table = {
				"SF_Shipyard_Level_One",
				"SF_Shipyard_Level_Two",
				"SF_Shipyard_Level_Three",
				"SF_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				"Secondary_Haven",
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = "Empire_Office",
			GTS_Building = "Ground_Hypervelocity_Gun",
			Base_Defences = "Galactic_Turbolaser_Tower_Defenses_Republic"
		},
		HUTT_CARTELS = {
			Space_Unit_Table = {
				{"Light_Minstrel_Yacht", 5}
				,{"Heavy_Minstrel_Yacht", 5}
				,{"Raka_Freighter_Tender", 1}
				,{"Kaloth_Battlecruiser", 3}
				,{"Juvard_Frigate", 5}
				,{"Hutt_Galleon", 3}
				,{"Barabbula_Frigate", 5}
				,{"Szajin_Cruiser", 3}
				,{"Karagga_Destroyer", 3}
				,{"Vontor_Destroyer", 3}
				,{"Voracious_Carrier", 1}
				,{"CIS_PDF_DHC", 1}
				,{"REP_DHC", 1}
				,{"Marauder_Cruiser", 0.2}
				,{"DP20", 0.2}
				,{"CR90", 0.2}
				,{"IPV1_Gunboat", 0.5}
				,{"DHC_Gunboat", 1}
				,{"Consular_Refit", 0.5}
				,{"Komrk_Gunship_Group", 0.2}
				,{"Gozanti_Cruiser_Group", 0.2}
				,{"Gozanti_Cruiser_Raider_Group", 1}
			},
			Land_Unit_Table = {
				{"Hutt_Guard_Company", 5}
				,{"Armored_Hutt_Company", 2}
				,{"Hutt_Airhook_Company", 4}
				,{"Hutt_Starhawk_Company", 4}
				,{"Hutt_Pongeeta_Swamp_Speeder_Company", 2}
				,{"Hutt_Personnel_Skiff_IV_Company", 2}
				,{"Hutt_Bantha_II_Skiff_Company", 4}
				,{"Hutt_SuperHaul_II_Skiff_Company", 1}
				,{"Hutt_AA_Skiff_Company", 1}
				,{"WLO5_Tank_Company", 4}
				,{"Luxury_Barge_Company", 1}
				,{"Hutt_Atmospheric_Flyer_Company", 2}
				,{"Hutt_VAAT_Company", 2}
				,{"MAL_Rocket_Vehicle_Company", 1}
				,{"Gamorrean_Guard_Company", 1}
				,{"Minor_Shell_Hutt_Company", 1}
			},
			Groundbase_Table = {
				"H_Ground_Barracks",
				"H_Ground_Barracks",
				"H_Ground_Light_Vehicle_Factory",
				"H_Ground_Heavy_Vehicle_Factory",
			},
			Starbase_Table = {
				"Hutt_Star_Base_1",
				"Hutt_Star_Base_2",
				"Hutt_Star_Base_3",
				"Hutt_Star_Base_4",
				"Hutt_Star_Base_5",
			},
			Shipyard_Table = {
				"Hutt_Shipyard_Level_One",
				"Hutt_Shipyard_Level_Two",
				"Hutt_Shipyard_Level_Three",
				"Hutt_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				nil,
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = "Hutt_Office",
			GTS_Building = "Ground_Ion_Cannon"
		},
		MANDALORIANS = {
			Space_Unit_Table = {
				{"CIS_PDF_DHC", 5}
				,{"CIS_DHC", 2}
				,{"Neutron_Star", 0.5, StartYear = -21}
				,{"Neutron_Star_Mercenary", 0.5, StartYear = -21}
				,{"Pursuer_Enforcement_Ship_Group", 5, StartYear = -21}
				,{"Komrk_Gunship_Group", 5}
				,{"Gozanti_Cruiser_Group", 1}
			},
			Land_Unit_Table = {
				{"Mandalorian_Soldier_Company", 5}
				,{"Mandalorian_Commando_Company", 3}
				,{"JU9_Juggernaut_Droid_Company", 2}
				,{"MAL_Rocket_Vehicle_Company", 1}
			},
			Groundbase_Table = {
				"Revolt_Rural_PDF_Barracks",
				"Revolt_Urban_PDF_Barracks",
				"Revolt_Rural_Barracks",
				"Revolt_Urban_Barracks",
				"Revolt_Light_Merc_Barracks",
				"Revolt_Merc_Barracks",
				"Revolt_Elite_Merc_Barracks",
				"Revolt_Precinct_House",
			},
			Starbase_Table = {
				"Empire_Star_Base_1",
				"Empire_Star_Base_2",
				"Empire_Star_Base_3",
				"Empire_Star_Base_4",
				"Empire_Star_Base_5",
			},
			Shipyard_Table = {
				"Republic_Shipyard_Level_One",
				"Republic_Shipyard_Level_Two",
				"Republic_Shipyard_Level_Three",
				"Republic_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				"Secondary_TF_Outpost",
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = IF_Gov,
			GTS_Building = nil
		},
		INDEPENDENT_FORCES = {
			Space_Unit_Table = {
				{"Home_One_Type_Liner", 0.2}
				,{"Home_One_Type_Defender", 0.1}
				,{"Liberty_Liner", 0.5}
				,{"Kuari_Princess_Liner", 0.5}
				,{"Invincible_Cruiser", 1}
				,{"Procurator_Battlecruiser", 0.2}
				,{"Tagge_Battlecruiser", 0.05}
				,{"Praetor_I_Battlecruiser", 0.2}
				,{"Space_ARC_Cruiser", 1}
				,{"Providence_Destroyer", 1, StartYear = -21}
				,{"Lucrehulk_Bulk_Cruiser", 0.4}			
				,{"Lucrehulk_Auxiliary", 0.4}
				,{"Lucrehulk_Auxiliary_Control", 0.1}
				,{"Lucrehulk_Carrier", 0.2, StartYear = -21}
				,{"Lucrehulk_Carrier_Control", 0.05, StartYear = -21}
				,{"Lucrehulk_Battleship", 0.05, StartYear = -19}
				,{"Sabaoth_Frigate", 0.2}
				,{"Sabaoth_Frigate_Spy", 0.1}
				,{"Sabaoth_Hex_Deployer", 0.2}
				,{"Sabaoth_Destroyer", 0.2}
				,{"PDF_DHC", 4}
				,{"Imperial_DHC", 4, StartYear = -18}
				,{"Neutron_Star", 2, StartYear = -21}
				,{"Neutron_Star_Mercenary", 1, StartYear = -21}
				,{"Captor", 4}
				,{"Auxilia", 4}
				,{"Munifex", 5}
				,{"Acclamator_I_Carrier", 1, StartYear = -21}
				,{"Acclamator_I_Assault", 2, StartYear = -21}
				,{"Acclamator_Destroyer", 0.1, StartYear = -21}
				,{"Acclamator_Battleship", 0.05, StartYear = -21}
				,{"Victory_I_Star_Destroyer", 1, StartYear = -19}
				,{"Lupus_Missile_Frigate", 5}
				,{"Carrack_Cruiser_Lasers", 5}
				,{"Carrack_Cruiser", 5, StartYear = -20}
				,{"CEC_Light_Cruiser", 4}
				,{"Galleon", 3}
				,{"Class_C_Frigate", 3}
				,{"Class_C_Support", 3}
				,{"DHC_Carrier", 1}
				,{"Starbolt", 2}
				,{"Light_Minstrel_Yacht", 1}
				,{"Heavy_Minstrel_Yacht", 1}
				,{"Kaloth_Battlecruiser", 2}
				,{"Juvard_Frigate", 0.15}
				,{"Hutt_Galleon", 0.05}
				,{"Barabbula_Frigate", 0.15}
				,{"Szajin_Cruiser", 0.1}
				,{"Karagga_Destroyer", 0.1}
				,{"Vontor_Destroyer", 0.1}
				,{"CR90", 4}
				,{"DP20", 4}
				,{"Customs_Corvette", 5}
				,{"IPV1", 5}
				,{"IPV1_Gunboat", 1}
				,{"DHC_Gunboat", 1}
				,{"Marauder_Cruiser", 5}
				,{"Interceptor_I_Frigate", 3}
				,{"Interceptor_II_Frigate", 3}
				,{"Interceptor_III_Frigate", 3}
				,{"Interceptor_IV_Frigate", 3}
				,{"Action_VI_Support", 3}
				,{"Super_Transport_VI", 2}
				,{"Super_Transport_VI_Missile", 1}
				,{"Super_Transport_VII", 2}
				,{"Super_Transport_VII_Missile", 1}
				,{"Super_Transport_XI", 1}
				,{"Super_Transport_XI_Missile", 0.5}
				,{"Super_Transport_XI_Modified", 1}
				,{"Gozanti_Cruiser_Raider_Group", 3}
				,{"Gozanti_Cruiser_Group", 4}
				,{"Gamma_ATR_6_Group", 3, StartYear = -18}		
				,{"Citadel_Cruiser_Group", 3}
			},
			Land_Unit_Table = {
				{"Police_Responder_Company", 2}
				,{"Security_Trooper_Company", 2}
				,{"Military_Soldier_Company", 3}
				,{"PDF_Soldier_Company", 3}
				,{"PDF_Tactical_Unit_Company", 2}
				,{"Light_Mercenary_Company", 3}
				,{"Mercenary_Company", 3}
				,{"Elite_Mercenary_Company", 3}
				,{"Scavenger_Company", 2}
				,{"Heavy_Scavenger_Company", 1}
				,{"PDF_Force_Cultist_Company", 0.1}
				,{"B1_Droid_Company", 2}	
				,{"BX_Commando_Company", 0.25, StartYear = -21}
				,{"JU9_Juggernaut_Droid_Company", 2}
				,{"SD_5_Hulk_Infantry_Droid_Company", 1}
				,{"X34_Technical_Company", 2}
				,{"AT_PT_Company", 2}
				,{"AT_RT_Company", 1, StartYear = -22}
				,{"Espo_Walker_91_Company", 2}
				,{"Overracer_Speeder_Bike_Company", 2}
				,{"74Z_Bike_Company", 2}
				,{"STAP_Company", 2}
				,{"Republic_SD_6_Droid_Company", 2}
				,{"LR_57_Droid_Company", 1}
				,{"Destroyer_Droid_I_P_Company", 1}
				,{"Destroyer_Droid_I_W_Company", 0.75, StartYear = -22}
				,{"Destroyer_Droid_I_Q_Company", 0.5, StartYear = -20}
				,{"Arrow_23_Company", 2}
				,{"PAC_Company", 1}				
				,{"ULAV_Company", 2, StartYear = -22}
				,{"AAT_Company", 1}
				,{"GAT_Company", 2, StartYear = -20}
				,{"AT_XT_Company", 0.5, StartYear = -20}
				,{"ISP_Company", 1, StartYear = -20}
				,{"PDF_AAT_Company", 1}
				,{"Riot_Hailfire_Company", 1}
				,{"Riot_Persuader_Company", 1}
				,{"MZ8_Tank_Company", 1}
				,{"TNT_Company", 1}
				,{"MTT_Company", 0.25}				
				,{"A5_Juggernaut_Company", 1, StartYear = -22}
				,{"Republic_A5_Juggernaut_Company", 0.5, StartYear = -22}
				,{"Republic_A5RX_Company", 1, StartYear = -21}
				,{"Republic_A6_Juggernaut_Company", 0.2, StartYear = -20}
				,{"Republic_A4_Juggernaut_Company", 2}
				,{"Republic_AT_TE_Walker_Company", 0.25, StartYear = -19}
				,{"UT_AT_Speeder_Company", 0.25, StartYear = -19}					
				,{"Republic_TX130S_Company", 0.25, StartYear = -19}
				,{"Republic_AT_AP_Walker_Company", 1, StartYear = -18}
				,{"Luxury_Barge_Company", 0.25}				
				,{"Bantha_II_Skiff_Company", 2}
				,{"Hutt_Bantha_II_Skiff_Company", 0.5}
				,{"Hutt_SuperHaul_II_Skiff_Company", 0.5}
				,{"WLO5_Tank_Company", 1}
				,{"Storm_Cloud_Car_Company", 1}
				,{"Skyhopper_Company", 1}
				,{"Skyhopper_Antivehicle_Company", 1}
				,{"Skyhopper_Primitive_Company", 1}
				,{"Skyhopper_Security_Company", 1}
				,{"Republic_Gaba18_Company", 1}
				,{"Republic_Flashblind_Company", 2.0, StartYear = -20}				
				,{"CA_Artillery_Company", 1}
				,{"Defoliator_Company", 0.25, StartYear = -21}				
				,{"HAG_Company", 0.5}								
				,{"MAL_Rocket_Vehicle_Company", 1}
				,{"HAML_Company", 0.5}
				,{"Hutt_AA_Skiff_Company", 0.25}				
				,{"Republic_UT_AA_Company", 0.25, StartYear = -19}	
				,{"VAAT_Company", 1}
				,{"Republic_VAAT_Company", 0.5}
				,{"Republic_LAAT_Company", 0.25, StartYear = -19}
				,{"HMP_Company", 1, StartYear = -19}
				,{"JX30_Company", 1}
				,{"Gallofree_HTT_Company", 2, StartYear = -19}
				,{"Gian_Company", 1}
				,{"Gian_PDF_Company", 1}
				,{"Gian_Rebel_Company", 1, StartYear = -18}
			},
			Groundbase_Table = {
				"Revolt_Rural_PDF_Barracks",
				"Revolt_Urban_PDF_Barracks",
				"Revolt_Rural_Barracks",
				"Revolt_Urban_Barracks",
				"Revolt_Light_Merc_Barracks",
				"Revolt_Merc_Barracks",
				"Revolt_Elite_Merc_Barracks",
				"Revolt_Precinct_House",
				"Revolt_Scavenger_Outpost",
				"Revolt_Underground_Market",
				"Revolt_Trade_Post",
				"Revolt_TDF_Deserter_Base",
				"Revolt_Security_Droid_Factory",
				"Revolt_OldRep_Light_Factory",
				"Revolt_Walker_Light_Factory",
				"Revolt_UI_Light_Factory",
				"Revolt_AT_Light_Factory",
				"Revolt_Illegal_Heavy_Factory",
				"Revolt_Chop_Shop",
				"Revolt_OldRep_Advanced_Factory",
			},
			Starbase_Table = {
				"Empire_Star_Base_1",
				"Empire_Star_Base_2",
				"Empire_Star_Base_3",
				"Empire_Star_Base_4",
				"Empire_Star_Base_5",
			},
			Shipyard_Table = {
				"Republic_Shipyard_Level_One",
				"Republic_Shipyard_Level_Two",
				"Republic_Shipyard_Level_Three",
				"Republic_Shipyard_Level_Four",
			},
			Defenses_Table = {
				nil,
				nil,
				"Secondary_TF_Outpost",
				"Secondary_Golan_One",
				"Secondary_Golan_Two"
			},
			Government_Building = IF_Gov,
			GTS_Building = nil
		},
		CLASSIC_TF = {
			Space_Unit_Table = {
				{"Lucrehulk_Core_Destroyer", 1, StartYear = -22}
				,{"Captor", 4}
				,{"Auxilia", 4}
				,{"C9979_Carrier_Subfaction", 5}
				,{"Munifex", 5}
				,{"Lupus_Missile_Frigate", 5}
				,{"Providence_Carrier_Destroyer", 0.5, StartYear = -21}				
				,{"Providence_Destroyer", 0.5, StartYear = -22}				
				,{"Providence_Carrier", 0.25, StartYear = -22}				
				,{"DH_Omni", 1}
			},
			Land_Unit_Table = {
				{"Neimoidian_Guard_Company", 2}
				,{"B1_Droid_Company", 3}
				,{"B2_Droid_Company", 3, StartYear = -22}
				,{"Destroyer_Droid_I_P_Company", 2}
				,{"Destroyer_Droid_I_W_Company", 2, StartYear = -22}
				,{"Destroyer_Droid_I_Q_Company", 2, StartYear = -20}
				,{"Neimoidian_Guard_Company", 2}
				,{"STAP_Company", 2}
				,{"AAT_Company", 1}
				,{"HAG_Company", 1}
				,{"HAML_Company", 1}
				,{"MTT_Company", 1}
				,{"PAC_Company", 1}
				,{"MAF_Company", 1}
			}
		},
		CLASSIC_IGBC = {
			Space_Unit_Table = {
				{"Munificent_Subfaction", 4}
				,{"Munificent_C3", 3}
				,{"Munificent_Tender", 1}
				,{"Munificent_Heavy_Cruiser", 2}		
				,{"Hardcell", 5}
				,{"Hardcell_Tender", 5}
				,{"CIS_PDF_DHC", 2}
				,{"CIS_DHC", 2}
				,{"Geonosian_Cruiser", 1}
				,{"Action_VI_Support", 2}
				,{"Interceptor_III_Frigate", 3}
				,{"C9979_Carrier_Subfaction", 1}			
				,{"Gozanti_Cruiser_Group", 5}
				,{"DH_Omni", 1}
			},
			Land_Unit_Table = {
				{"Elite_Mercenary_Company", 2}
				,{"B1_Droid_Company", 3}
				,{"B2_Droid_Company", 3, StartYear = -22}
				,{"BX_Commando_Company", 2, StartYear = -22}
				,{"Hailfire_Company", 5}
				,{"HMP_Company", 1, StartYear = -19}
				,{"MAF_Company", 1}
			}
		},		
		FREE_DAC = {
			Space_Unit_Table = {
				{"Providence_Dreadnought", 1, StartYear = -22}
				,{"Recusant_Dreadnought", 3, StartYear = -22}
				,{"Providence_Destroyer", 3, StartYear = -22, LastYear = -22}
				,{"Providence_Carrier_Destroyer", 3, StartYear = -21}
				,{"Recusant_Light_Destroyer", 5, StartYear = -22}
				,{"CIS_DHC", 0.25}
				,{"CIS_PDF_DHC", 0.5}
				,{"Home_One_Type_Liner", 0.2}
				,{"Home_One_Type_Defender", 0.1}				
				,{"Liberty_Liner", 0.5}
				,{"Kuari_Princess_Liner", 0.5}
				--,{"Subjugator", 0.1} --I shouldn't... it's not the Jedi way...
			},
			Government_Building = "Free_Dac_HQ",
		},
		STARDRIVE = {
			Space_Unit_Table = {
				{"Invincible_Cruiser", 1}
				,{"REP_DHC", 4}
				,{"PDF_DHC", 3}
				,{"DHC_Carrier", 1}
				,{"Customs_Corvette", 5}
				,{"Neutron_Star", 0.2, StartYear = -21}
				,{"Victory_I_Fleet_Star_Destroyer", 1, StartYear = -20}
				,{"Victory_I_Star_Destroyer", 1, StartYear = -20}
			},
			Government_Building = "Rendili_HQ",
		},
		STARDRIVE_CIS = {
			Space_Unit_Table = {
				{"Invincible_Cruiser", 0.2}
				,{"CIS_DHC", 4}
				,{"CIS_PDF_DHC", 3}
				,{"Customs_Corvette", 3}
				,{"Neutron_Star", 0.2, StartYear = -21}
			},
			Government_Building = "Rendili_HQ",
		},
		CECORELLIAN = {
			Space_Unit_Table = {
				{"Starbolt", 3}
				,{"CEC_Light_Cruiser", 3}
				,{"LAC", 3}
				,{"Consular_Refit", 3}
				,{"Charger_C70", 3, StartYear = -22}
				,{"CR90", 5}
				,{"DP20", 5}
				,{"Interceptor_I_Frigate", 0.3}
				,{"Interceptor_II_Frigate", 0.3}
				,{"Interceptor_III_Frigate", 0.3}
				,{"Interceptor_IV_Frigate", 0.3}
				,{"Action_VI_Support", 0.3}
			},
			Land_Unit_Table = {
				{"CorSec_Trooper_Company", 3}
				,{"VAAT_Company", 1}
				,{"Gian_Company", 1}
				,{"Storm_Cloud_Car_Company", 1}
			},
			Government_Building = "CEC_HQ",
		},
		KUATI = {
			Space_Unit_Table = {
				{"Class_C_Frigate", 3}
				,{"Venator_Star_Destroyer", 2, StartYear = -21}
				,{"Victory_I_Star_Destroyer", 1, StartYear = -20}
				,{"Acclamator_I_Carrier", 4, StartYear = -22}
				,{"Acclamator_I_Assault", 4, StartYear = -22}
				,{"Acclamator_II", 4, StartYear = -19}
				,{"Arquitens", 3, StartYear = -21}
				,{"Pelta_Assault", 3, StartYear = -22}
				,{"Pelta_Support", 3, StartYear = -22}
				,{"Galleon", 3}
				,{"Procurator_Battlecruiser", 1}
				,{"Munifex", 3, LastYear = -23}
				,{"Lupus_Missile_Frigate", 3, LastYear = -23}
				,{"Captor", 2, LastYear = -23}
				,{"Auxilia", 2, LastYear = -23}
			},
			Land_Unit_Table = {
				{"Security_Trooper_Company", 3}
				,{"Republic_AT_PT_Company", 0.5}
				,{"Republic_AT_RT_Company", 2, StartYear = -22}
				,{"AT_XT_Company", 0.5, StartYear = -22, LastYear = -22}
				,{"Clone_Vehicular_Assault_Company", 0.5, StartYear = -22, LastYear = -21}		
				,{"Republic_TX130S_Company", 0.5, StartYear = -22}
				,{"Republic_TX130T_Company", 0.5, StartYear = -19}
				,{"Republic_UT_AA_Company", 1, StartYear = -22}
				,{"Republic_LAAT_Company", 0.5, StartYear = -22}
				,{"Republic_VAAT_Company", 0.25}
				,{"Republic_A4_Juggernaut_Company", 2, LastYear = -23}
				,{"Republic_A5_Juggernaut_Company", 2, StartYear = -22}
				,{"Republic_A6_Juggernaut_Company", 1, StartYear = -20} -- FotR_Enhanced ; moved to 20bby
				,{"RX200_Falchion_Company", 0.5, StartYear = -22}
				,{"Republic_A5RX_Company", 2, StartYear = -22}
				,{"UT_AT_Speeder_Company", 1, StartYear = -20} -- FotR_Enhanced ; mathced with roster update 21BBY M6
				,{"Republic_AT_TE_Walker_Company", 0.5, StartYear = -22}
				,{"AT_OT_Walker_Company", 2, StartYear = -19}
				,{"Republic_AT_AP_Walker_Company", 2, StartYear = -19}
				-- FotR_Enhanced
				,{"Republic_A6_Prototype_Company", 0.5, StartYear = -21, LastYear = -20}
			},
			Government_Building = "KDY_HQ",
		},
		KUATI_CIS = {
			Space_Unit_Table = {
				{"Munifex", 5}
				,{"Lupus_Missile_Frigate", 5}
				,{"Captor", 4}
				,{"Auxilia", 4}
				,{"Storm_Fleet_Destroyer", 3, StartYear = -21}
			},
			Government_Building = "KDY_HQ",
		},
		REP_ORSF = {
			Space_Unit_Table = {
				{"Starbolt", 3}
				,{"CEC_Light_Cruiser", 5}
				,{"LAC", 5}
				,{"Consular_Refit", 5}
				,{"Carrack_Cruiser_Lasers", 3}
				,{"Acclamator_I_Assault", 2, StartYear = -22}
				,{"PDF_DHC", 2}
				,{"REP_DHC", 1}
				,{"DHC_Carrier", 1}
				,{"Venator_Star_Destroyer", 1, StartYear = -21}
				,{"Victory_I_Star_Destroyer", 1, StartYear = -20}
				,{"Munifex", 1}
				,{"Lupus_Missile_Frigate", 1}
				,{"Captor", 1}
				,{"Auxilia", 1}
				,{"C9979_Carrier_Subfaction", 1}
			},
			Land_Unit_Table = {
				{"Clonetrooper_Phase_One_Company", 1, StartYear = -22}
				,{"Clonetrooper_Phase_Two_Company", 1, StartYear = -20}
				,{"Clone_Galactic_Marine_Company", 1, StartYear = -22}
				,{"Republic_Trooper_Company", 2}
				,{"Republic_Heavy_Trooper_Company", 2}
				,{"Republic_Navy_Trooper_Company", 2}
				,{"Special_Tactics_Trooper_Company", 5}
				,{"Storm_Cloud_Car_Company", 1}
				,{"Republic_Flashblind_Company", 2.0, StartYear = -20}
				,{"Republic_AT_PT_Company", 2}
				,{"Republic_Gian_Company", 3, LastYear = -21}
				,{"AT_XT_Company", 2, StartYear = -22}
				,{"Republic_A5_Juggernaut_Company", 1, StartYear = -22}
				,{"UT_AT_Speeder_Company", 1, StartYear = -22}
				,{"Republic_AT_TE_Walker_Company", 1, StartYear = -22}
			},
			Government_Building = "CEC_HQ",
		},
		CLONES = {
			Land_Unit_Table = {	--Note: Start year is handled by an era check for the whole roster. Left off units here because it should be unnecessary and is bad if nothing is applicable if that fails somehow
				{"Clonetrooper_Phase_One_Company", 2, LastYear = -21}
				,{"Clonetrooper_Phase_Two_Company", 2, StartYear = -20}
				,{"Clone_Galactic_Marine_Company", 1, StartYear = -20} -- FotR_Enhanced ; mathced with Phase 2 research
				,{"ARC_Phase_One_Company", 1, LastYear = -21}
				,{"ARC_Phase_Two_Company", 1, StartYear = -20}
				,{"Clone_Commando_Company", 1}
				,{"Clone_Special_Ops_Company", 1, LastYear = -21}
				,{"Clone_Vehicular_Assault_Company", 0.25, LastYear = -21}				
				,{"Clone_Flame_Trooper_Company", 0.5}
				,{"Clone_Jumptrooper_Phase_One_Company", 1, LastYear = -21}
				,{"Clone_Jumptrooper_Phase_Two_Company", 1, StartYear = -20}
				,{"Clone_Scout_Trooper_Company", 2, StartYear = -20}
				,{"Clone_Airborne_Trooper_Company", 2, StartYear = -20}
				,{"Clone_Blaze_Trooper_Company", 1, StartYear = -20}
			}
		},
		ROTHANAN = {
			Space_Unit_Table = {
				{"Galleon", 1}
				,{"Pelta_Assault", 2, StartYear = -22}
				,{"Pelta_Support", 2, StartYear = -22}
				,{"Acclamator_I_Carrier", 4, StartYear = -22}
				,{"Acclamator_I_Assault", 4, StartYear = -22}
				,{"Acclamator_II", 4, StartYear = -19}
			},
			Land_Unit_Table = {
				{"Security_Trooper_Company", 2, LastYear = -22}
				,{"Clonetrooper_Phase_One_Company", 2, StartYear = -21, LastYear = -21}
				,{"Clonetrooper_Phase_Two_Company", 2, StartYear = -20}
				,{"Clone_Galactic_Marine_Company", 1, StartYear = -21}
				,{"Republic_AT_PT_Company", 2}
				,{"AT_XT_Company", 2, StartYear = -22}
				,{"Republic_TX130S_Company", 2, StartYear = -22}
				,{"Republic_TX130T_Company", 0.5, StartYear = -19}
				,{"Republic_AT_TE_Walker_Company", 2, StartYear = -22}
				,{"RX200_Falchion_Company", 1, StartYear = -22}
				,{"Republic_LAAT_Company", 1, StartYear = -22}
				,{"Republic_VAAT_Company", 0.5}
				-- FotR_Enhanced
				,{"SPHA_T_Company", 1, LastYear = -22}
			},
			Government_Building = "Rothana_HQ",
		},
		SITHWORLD_REP = {
			Space_Unit_Table = {
				{"Galleon", 1}
				,{"IPV1", 4}
				,{"Carrack_Cruiser_Lasers", 2}
				,{"Acclamator_II", 4, StartYear = -19}
			},
			Land_Unit_Table = {
				{"Special_Tactics_Trooper_Company", 3}
				,{"Sun_Guard_Company", 4}
				,{"AV7_Company", 0.5, StartYear = -22}
			}
		},
		SITHWORLD_CIS = {
			Space_Unit_Table = {
				{"DH_Omni", 0.5}
				,{"Marauder_Cruiser", 4}
				,{"Geonosian_Cruiser", 2}
				,{"Recusant_Light_Destroyer", 4, StartYear = -22}
			},
			Land_Unit_Table = {
				{"B1_Droid_Company", 3, LastYear = -21}
				,{"B2_Droid_Company", 3, StartYear = -22}
				,{"HAG_Company", 0.5}
				,{"Dark_Jedi_Company", 4}
				,{"Sun_Guard_Company", 4}
			}
		},
		ROGUE_JEDI = {
			Space_Unit_Table = {
				{"DH_Omni", 0.5}
				,{"Marauder_Cruiser", 4}
				,{"Pelta_Assault", 1, StartYear = -22}
				,{"Charger_C70", 1, StartYear = -22}
				,{"Consular_Refit", 1}
				,{"CIS_DHC", 0.5}
				,{"CIS_PDF_DHC", 2}
				,{"Geonosian_Cruiser", 2}
				,{"Neutron_Star_Mercenary", 4, StartYear = -22}
			},
			Land_Unit_Table = {
				{"Sith_War_Behemoth_Company", 0.5}
				,{"JU9_Juggernaut_Droid_Company", 2}
				,{"Mercenary_Company", 2}
				,{"PDF_Soldier_Company", 1}
				,{"PDF_Force_Cultist_Company", 2}
				,{"Dark_Jedi_Company", 4}
				,{"Antarian_Ranger_Company", 0.5}
				,{"Republic_Heavy_Trooper_Company", 0.5}
				,{"Republic_TX130S_Company", 0.5, StartYear = -22}
				,{"AT_XT_Company", 0.5, StartYear = -22}
			}
		},
		NIMBUS = {
			Land_Unit_Table = {
				{"Nimbus_Commando_Company", 3}
			}
		},
		CORUSCANT_GUARD = {
			Land_Unit_Table = {
				{"Republic_Heavy_Trooper_Company", 2}
				,{"Senate_Commando_Company", 2, StartYear = -22}
				,{"Clone_Special_Ops_Company", 1, LastYear = -21} -- FotR_Enhanced ; replacement for galactic marine
				,{"Clone_Galactic_Marine_Company", 1, StartYear = -20} -- FotR_Enhanced ; mathced with Phase 2 research
				,{"Republic_VAAT_Company", 0.5, LastYear = -21}
				,{"Republic_A5RX_Company", 0.5, StartYear = -22}
				,{"RX200_Falchion_Company", 0.5, StartYear = -22}
				,{"Republic_A6_Juggernaut_Company", 0.2, StartYear = -20} -- FotR_Enhanced
			}
		},
	}

	local returnValue = Faction_Table[faction]

	local override = Faction_Table[rosterOverride]

	if returnValue == nil then
		returnValue = Faction_Table["INDEPENDENT_FORCES"]
	end

	if override ~= nil and rosterOverride ~= faction then
		if override.Space_Unit_Table ~= nil then
			returnValue.Space_Unit_Table = override.Space_Unit_Table
		end
		if override.Land_Unit_Table ~= nil then
			returnValue.Land_Unit_Table = override.Land_Unit_Table
		end
		if faction == "INDEPENDENT_FORCES" then
			if override.Groundbase_Table ~= nil then
				returnValue.Groundbase_Table = override.Groundbase_Table
			end
			if override.Starbase_Table ~= nil then
				returnValue.Starbase_Table = override.Starbase_Table
			end
			if override.Shipyard_Table ~= nil then
				returnValue.Shipyard_Table = override.Shipyard_Table
			end
			if override.Defenses_Table ~= nil then
				returnValue.Defenses_Table = override.Defenses_Table
			end
			if override.Government_Building ~= nil then
				returnValue.Government_Building = override.Government_Building
			end
			if override.GTS_Building ~= nil then
				returnValue.GTS_Building = override.GTS_Building
			end
		end
	end

	return returnValue
end
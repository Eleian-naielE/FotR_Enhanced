--****************************************************--
--****   Fall of the Republic: Rimward Campaign   ****--
--****************************************************--

require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
require("eawx-util/PopulatePlanetUtilities")
require("eawx-util/StoryUtil")
require("eawx-util/MissionUtil")
require("deepcore/crossplot/crossplot")
require("eawx-util/GalacticUtil")
require("eawx-util/UnitUtil")
require("SetFighterResearch")

function Definitions()
	--DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		-- Generic
		Trigger_Historical_GC_Choice_Prompt = State_Historical_GC_Choice_Prompt,

		-- CIS
		CIS_Bothawui_Business_Epilogue = State_CIS_Bothawui_Business_Epilogue,

		CIS_Rishi_Rookie_Epilogue = State_CIS_Rishi_Rookie_Epilogue,
		CIS_Water_World_Epilogue = State_CIS_Water_World_Epilogue,
		CIS_Clone_Chaos_Epilogue = State_CIS_Clone_Chaos_Epilogue,

		Trigger_CIS_RimwardCampaign_Skytop = State_CIS_RimwardCampaign_Skytop,
		Trigger_CIS_RimwardCampaign_Skytop_Research = State_CIS_RimwardCampaign_Skytop_Research,

		Trigger_CIS_RimwardCampaign_Ruusan = State_CIS_RimwardCampaign_Ruusan,
		Trigger_CIS_Enter_Heroes_Ruusan = State_CIS_Enter_Heroes_Ruusan,

		Trigger_CIS_RimwardCampaign_Ryloth = State_CIS_RimwardCampaign_Ryloth,

		Trigger_CIS_RimwardCampaign_Ukio = State_CIS_RimwardCampaign_Ukio,

		Trigger_CIS_RimwardCampaign_Rodia = State_CIS_RimwardCampaign_Rodia,
		Trigger_CIS_RimwardCampaign_Gunray = State_CIS_RimwardCampaign_Gunray,
		CIS_Venator_Ventress_Epilogue = State_CIS_Venator_Ventress_Epilogue,

		Trigger_CIS_RimwardCampaign_Dooku_Search = State_CIS_RimwardCampaign_Dooku_Search,
		CIS_Perfect_Piracy_Epilogue = State_CIS_Perfect_Piracy_Epilogue,
		Trigger_CIS_RimwardCampaign_Florrum = State_CIS_RimwardCampaign_Florrum,

		Trigger_CIS_RimwardCampaign_Crystals = State_CIS_RimwardCampaign_Crystals,
		Trigger_CIS_RimwardCampaign_Crystal_Mining_Research = State_CIS_RimwardCampaign_Crystal_Mining_Research,

		Trigger_CIS_RimwardCampaign_Devastation = State_CIS_RimwardCampaign_Devastation,
		Trigger_CIS_RimwardCampaign_Devastation_Death = State_CIS_RimwardCampaign_Devastation_Death,

		Trigger_CIS_RimwardCampaign_Super_Tank = State_CIS_RimwardCampaign_Super_Tank,
		Trigger_CIS_RimwardCampaign_Super_Tank_Research = State_CIS_RimwardCampaign_Super_Tank_Research,

		CIS_RimwardCampaign_GC_Progression = State_CIS_RimwardCampaign_GC_Progression,

		-- Republic
		Rep_Bothawui_Business_Epilogue = State_Rep_Bothawui_Business_Epilogue,

		Rep_Ryloth_Ramming_Epilogue = State_Rep_Ryloth_Ramming_Epilogue,
		Rep_Ryloth_Remedy_Epilogue = State_Rep_Ryloth_Remedy_Epilogue,
		Rep_Breaking_Bridges_Epilogue = State_Rep_Breaking_Bridges_Epilogue,

		Trigger_Rep_RimwardCampaign_Communication = State_Rep_RimwardCampaign_Communication,
		Trigger_Rep_RimwardCampaign_Rishi_Station_Research = State_Rep_RimwardCampaign_Rishi_Station_Research,

		Trigger_Rep_RimwardCampaign_Station_Search = State_Rep_RimwardCampaign_Station_Search,

		Trigger_Rep_RimwardCampaign_Skytop = State_Rep_RimwardCampaign_Skytop,
		Rep_Ruusan_Roulette_Epilogue = State_Rep_Ruusan_Roulette_Epilogue,

		Trigger_Rep_RimwardCampaign_Rishi = State_Rep_RimwardCampaign_Rishi,
		Trigger_Rep_Deploy_Heroes_Rishi = State_Rep_Deploy_Heroes_Rishi,

		Trigger_Rep_RimwardCampaign_Kamino = State_Rep_RimwardCampaign_Kamino,
		Rep_Clone_Chaos_Tactical_Failed = State_Rep_Clone_Chaos_Tactical_Failed,

		Trigger_Rep_RimwardCampaign_Florrum = State_Rep_RimwardCampaign_Florrum,
		Rep_Perfect_Piracy_Epilogue = State_Rep_Perfect_Piracy_Epilogue,

		Trigger_Rep_RimwardCampaign_Ziro = State_Rep_RimwardCampaign_Ziro,
		Trigger_Rep_RimwardCampaign_Ziro_Death = State_Rep_RimwardCampaign_Ziro_Death,

		Trigger_Rep_RimwardCampaign_Rodia = State_Rep_RimwardCampaign_Rodia,

		Trigger_Rep_RimwardCampaign_Christophsis = State_Rep_RimwardCampaign_Christophsis,
		Trigger_Rep_Deploy_Heroes_Christophsis = State_Rep_Deploy_Heroes_Christophsis,

		Trigger_Rep_RimwardCampaign_Devastation = State_Rep_RimwardCampaign_Devastation,
		Trigger_Rep_RimwardCampaign_Devastation_Death = State_Rep_RimwardCampaign_Devastation_Death,

		--Trigger_Rep_RimwardCampaign_Pammant = State_Rep_RimwardCampaign_Pammant,
		--Trigger_Rep_RimwardCampaign_Malevolence_2_Death = State_Rep_RimwardCampaign_Malevolence_2_Death,

		Rep_RimwardCampaign_GC_Progression = State_Rep_RimwardCampaign_GC_Progression,

		-- Hutts
		Hutts_Hutt_Hostage_Epilogue = State_Hutts_Hutt_Hostage_Epilogue,
		Hutts_RimwardCampaign_Hero_Deploy_Nal_Hutta = State_Hutts_RimwardCampaign_Hero_Deploy_Nal_Hutta,

		Trigger_Hutts_RimwardCampaign_Ziro_Hunt = State_Hutts_RimwardCampaign_Ziro_Hunt,
		Trigger_Hutts_RimwardCampaign_Civil_War = State_Hutts_RimwardCampaign_Civil_War,

		Trigger_Hutts_RimwardCampaign_Reunion = State_Hutts_RimwardCampaign_Reunion,
		Hutts_RimwardCampaign_Hero_Deploy_Tatooine = State_Hutts_RimwardCampaign_Hero_Deploy_Tatooine,

		Trigger_Hutts_RimwardCampaign_Showdown = State_Hutts_RimwardCampaign_Showdown,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_hutts = Find_Player("Hutt_Cartels")
	p_cg = Find_Player("Commerce_Guild")
	p_tu = Find_Player("Techno_Union")
	p_tf = Find_Player("Trade_Federation")
	p_independent_forces = Find_Player("Independent_Forces")

	all_planets_conquered = false

	cis_quest_planet_hunt_over = false
	cis_quest_skytop_over = false
	cis_quest_ruusan_over = false
	cis_quest_ryloth_over = false
	cis_quest_ukio_over = false
	cis_quest_rodia_over = false
	cis_quest_gunray_over = false
	cis_quest_dooku_search_over = false
	cis_quest_florrum_over = false
	cis_quest_crystals_over = false
	cis_quest_devastation_over = false
	cis_quest_super_tank_over = false

	cis_dooku_search_act_1 = false
	cis_dooku_search_act_2 = false
	cis_dooku_search_act_3 = false
	cis_dooku_search_act_4 = false

	rep_quest_planet_hunt_over = false
	rep_quest_communication_over = false
	rep_quest_station_search_over = false
	rep_quest_skytop_over = false
	rep_quest_rishi_over = false
	rep_quest_kamino_over = false
	rep_quest_florrum_over = false
	rep_quest_ziro_over = false
	rep_quest_rodia_over = false
	rep_quest_christophsis_over = false
	rep_quest_devastation_over = false
	rep_quest_pammant_over = false

	rep_station_search_act_1 = false
	rep_station_search_act_2 = false
	rep_station_search_act_3 = false
	rep_station_search_act_4 = false

	p_rep_quest_rishi_hero_1 = nil
	p_rep_quest_rishi_hero_type_1 = nil

	p_rep_quest_rishi_hero_2 = nil
	p_rep_quest_rishi_hero_type_2 = nil

	rep_kamino_timer_seconds = 0
	rep_kamino_timer_weeks = 5

	rep_florrum_enter_hero_01 = false
	rep_florrum_enter_hero_02 = false
	rep_florrum_enter_hero_03 = false

	hutts_quest_meeting_over = false
	hutts_quest_ziro_hunt_over = false
	hutts_quest_civil_war_over = false
	hutts_quest_reunion_over = false
	hutts_quest_showdown_over = false

	hutts_ziro_hunt_act_1 = false
	hutts_ziro_hunt_act_2 = false
	hutts_ziro_hunt_act_3 = false
	hutts_ziro_hunt_act_4 = false

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("Rimward_CIS_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			GlobalValue.Set("Rimward_Bothawui_Business_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_CIS_Venator_Venture_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_CIS_Venator_Ventress_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_CIS_Clone_Chaos_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Rimward_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("Rimward_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			GlobalValue.Set("Rimward_Bothawui_Business_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_Rishi_Rookie_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_Clone_Chaos_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("Rimward_Breaking_Bridges_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Rimward_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_hutts.Is_Human() then
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Bossk", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Dengar", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Shahan", 0) -- 0 = Survived; 1 = Died
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
	
		p_cis.Unlock_Tech(Find_Object_Type("Gorgol_Location_Set"))
		Set_Fighter_Hero("GORGOL_NANTEX_SQUADRON", "DOCTOR_INSTINCTION")
		
		p_cis.Unlock_Tech(Find_Object_Type("88th_Flight_Location_Set"))
		Set_Fighter_Hero("88TH_FLIGHT_SQUADRON", "GRIEVOUS_RECUSANT")
		
		p_cis.Lock_Tech(Find_Object_Type("Providence_Destroyer"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Swap_Recusant_To_Providence"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Munificent_To_Providence"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Recusant_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Providence_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		
		p_cis.Lock_Tech(Find_Object_Type("Nas_Ghent_Location_Set"))
		Clear_Fighter_Hero("NAS_GHENT_SQUADRON")
		
		p_cis.Lock_Tech(Find_Object_Type("DFS1VR_Location_Set"))
		Clear_Fighter_Hero("DFS1VR_31ST_SQUADRON")

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Charger_C70"))

		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))
		p_republic.Lock_Tech(Find_Object_Type("Invincible_Cruiser"))
		p_republic.Lock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Lock_Tech(Find_Object_Type("DP20"))

		-- Hutts
		p_hutts.Lock_Tech(Find_Object_Type("Random_Bounty_Hunter"))

		GlobalValue.Set("CURRENT_CLONE_PHASE", 1)

		if p_republic.Is_Human() then
			p_cis.Unlock_Tech(Find_Object_Type("CIS_Super_Tank_Company"))

			p_tf.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
			p_cg.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
			p_tu.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
		end

		crossplot:publish("POPUPEVENT", "HISTORICAL_GC_CHOICE", {"STORY", "NO_INTRO", "NO_STORY"}, { },
				{ }, { },
				{ }, { },
				{ }, { },
				"HISTORICAL_GC_CHOICE_OPTION")
	elseif message == OnUpdate then
		crossplot:update()
	end
end
function Historical_GC_Choice_Made(choice)
	if choice == "HISTORICAL_GC_CHOICE_STORY" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
			Story_Event("REP_INTRO_START")
		end
		if p_hutts.Is_Human() then
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Bossk", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Dengar", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Shahan", 0) -- 0 = Survived; 1 = Died

			Create_Thread("Hutts_Story_Set_Up")
			Story_Event("HUTT_INTRO_START")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
		end
		if p_hutts.Is_Human() then
			Create_Thread("Hutts_Story_Set_Up")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_STORY" then
		Create_Thread("Generic_Story_Set_Up")
	end
	if choice == "HISTORICAL_GC_CHOICE_AU" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
			
			GlobalValue.Set("Rimward_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
			
			GlobalValue.Set("Rimward_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			Story_Event("REP_INTRO_START")
		end
		if p_hutts.Is_Human() then
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Bossk", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Dengar", 0) -- 0 = Survived; 1 = Died
			GlobalValue.Set("Rimward_Hutt_Hostage_Outcome_Shahan", 0) -- 0 = Survived; 1 = Died

			Create_Thread("Hutts_Story_Set_Up")
			Story_Event("HUTT_INTRO_START")
		end
	end

	crossplot:publish("VENATOR_HEROES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["SLOT_ADJUST"] = -2,
				["LOCKIN"] = {"Byluir"},
			},
			["NAVY"] = {
				["LOCKIN"] = {"Kilian","Yularen","Coburn"},
				["EXIT"] = {"Maarisa","Baraka","Grumby","Autem","Tallon","Dallin","Pellaeon","Dao","Tenant"},
			},
			["ARMY"] = {
				["SLOT_ADJUST"] = -1,
			},
			["CLONE"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Cody","Rex"},
				["RETURN"] = {"Jet"},
				["EXIT"] = {"Bacara","71"},
			},
			["COMMANDO"] = {
				--this space intentionally left blank
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = 0,
				["LOCKIN"] = {"Kit","Shaak"},
				["EXIT"] = {"Mace","Mundi","Kota","Ahsoka","Halcyon"},
			},
		})

	crossplot:publish("FIGHTER_HERO_DISABLE", {"Garven_Dreis_Location_Set","Rhys_Dallows_Location_Set"})
	crossplot:publish("FIGHTER_HERO_ENABLE", {"Jorn_Kulish_Location_Set"})

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Set_Fighter_Hero("JORN_KULISH_FOXFIRE_SQUADRON","BYLUIR_VENATOR")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")
	Clear_Fighter_Hero("RHYS_DALLOWS_BRAVO_SQUADRON")
	Clear_Fighter_Hero("GARVEN_DREIS_RAREFIED_SQUADRON")

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	StoryUtil.SpawnAtSafePlanet("LERITOR", p_cis, StoryUtil.GetSafePlanetTable(), {"Yansu_Grjak_Team"})
	StoryUtil.SpawnAtSafePlanet("GEONOSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Poggle_Team", "TX_21_Team","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("GAMORR", p_cis, StoryUtil.GetSafePlanetTable(), {"Doctor_Instinction"})
	StoryUtil.SafeSpawnFavourHero("SISKEEN", p_cis, {"Tuuk_Procurer"})
	StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Merai_Free_Dac"})
	StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Munificent"})
	StoryUtil.SpawnAtSafePlanet("RAXUS_SECOND", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Team","Ventress_Team"})
	StoryUtil.SpawnAtSafePlanet("RAXUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team","Lucid_Voice"})

	StoryUtil.SpawnAtSafePlanet("LANNIK", p_republic, StoryUtil.GetSafePlanetTable(), {"Padme_Amidala_Team"})
	StoryUtil.SpawnAtSafePlanet("KAMINO", p_republic, StoryUtil.GetSafePlanetTable(), {"Obi_Wan_Delta_Team","Cody_Team","Shaak_Ti_Delta_Team","Byluir_Venator","Nala_Se_Team"})
	StoryUtil.SpawnAtSafePlanet("MON_CALAMARI", p_republic, StoryUtil.GetSafePlanetTable(), {"Kit_Fisto_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("UKIO", p_republic, StoryUtil.GetSafePlanetTable(), {"McQuarrie_Concept"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kilian_Endurance"})
	StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute","Anakin_Ahsoka_Twilight_Team","Rex_Team","Venator_Star_Destroyer"})

	StoryUtil.SpawnAtSafePlanet("TATOOINE", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Tanda_Team","Jiliac_Dragon_Pearl"})
	StoryUtil.SpawnAtSafePlanet("NAR_SHADDAA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Parella_Team"})
	StoryUtil.SpawnAtSafePlanet("UBRIKKIA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Borvo_Prosperous_Secret"})

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	p_cis.Unlock_Tech(Find_Object_Type("CIS_Super_Tank_Company"))
	p_tf.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
	p_cg.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
	p_tu.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
	
	crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	StoryUtil.SpawnAtSafePlanet("LERITOR", p_cis, StoryUtil.GetSafePlanetTable(), {"Yansu_Grjak_Team"})
	StoryUtil.SpawnAtSafePlanet("GEONOSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Poggle_Team"})
	StoryUtil.SpawnAtSafePlanet("SISKEEN", p_cis, StoryUtil.GetSafePlanetTable(), {"Doctor_Instinction","TA_175_Team"})
	StoryUtil.SafeSpawnFavourHero("SISKEEN", p_cis, {"Tambor_Team"})
	StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Merai_Free_Dac"})
	StoryUtil.SpawnAtSafePlanet("RAXUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team","Lucid_Voice"})
	if (GlobalValue.Get("Rimward_CIS_GC_Version") == 1) then
		StoryUtil.SpawnAtSafePlanet("TOYDARIA", p_cis, StoryUtil.GetSafePlanetTable(), {"Katuunko_Team"})
	else
		StoryUtil.SpawnAtSafePlanet("TOYDARIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Katuunko_Team"})
	end

	StoryUtil.SpawnAtSafePlanet("LANNIK", p_republic, StoryUtil.GetSafePlanetTable(), {"Padme_Amidala_Team"})
	StoryUtil.SpawnAtSafePlanet("KAMINO", p_republic, StoryUtil.GetSafePlanetTable(), {"Obi_Wan_Delta_Team","Cody_Team","Shaak_Ti_Delta_Team","Byluir_Venator","Nala_Se_Team"})
	StoryUtil.SpawnAtSafePlanet("MON_CALAMARI", p_republic, StoryUtil.GetSafePlanetTable(), {"Kit_Fisto_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("UKIO", p_republic, StoryUtil.GetSafePlanetTable(), {"McQuarrie_Concept"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kilian_Endurance"})
	StoryUtil.SpawnAtSafePlanet("RISHI", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute","Anakin_Ahsoka_Twilight_Team","Rex_Team","Venator_Star_Destroyer","Venator_Star_Destroyer"})

	StoryUtil.SpawnAtSafePlanet("TATOOINE", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Tanda_Team","Jiliac_Dragon_Pearl"})
	StoryUtil.SpawnAtSafePlanet("NAR_SHADDAA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Parella_Team"})
	StoryUtil.SpawnAtSafePlanet("UBRIKKIA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Borvo_Prosperous_Secret"})

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	StoryUtil.RevealPlanet("KAMINO", false)
	StoryUtil.RevealPlanet("FLORRUM", false)
	StoryUtil.RevealPlanet("ROTHANA", false)

	MissionUtil.EnableInvasion("FLORRUM", false)
	MissionUtil.EnableInvasion("UKIO", false)

	StoryUtil.SetPlanetRestricted("FLORRUM", 1, false)
	StoryUtil.SetPlanetRestricted("RODIA", 1, false)
	StoryUtil.SetPlanetRestricted("RYLOTH", 1, false)

	Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	Create_Thread("State_CIS_Quest_Checker_Grievous")

	crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
end

function State_CIS_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local RimwardCampaign_PlanetList = {
		FindPlanet("Bothawui"),
		FindPlanet("Handooine"),
		FindPlanet("Kamino"),
		FindPlanet("Mon_Calamari"),
		FindPlanet("Rothana"),
	}

	local event_act_1 = plot.Get_Event("CIS_RimwardCampaign_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(RimwardCampaign_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			if p_planet.Get_Planet_Location() == FindPlanet("Kamino") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_RIMWARD_CAMPAIGN_CIS_LOCATION_KAMINO", p_planet)
			else
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_cis then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Bothawui").Get_Owner() == p_cis 
	and FindPlanet("Handooine").Get_Owner() == p_cis 
	and FindPlanet("Kamino").Get_Owner() == p_cis 
	and FindPlanet("Mon_Calamari").Get_Owner() == p_cis 
	and FindPlanet("Rothana").Get_Owner() == p_cis then
		cis_quest_planet_hunt_over = true
		Story_Event("CIS_PLANET_HUNT_END")

		local planet_list_factional_rep = StoryUtil.GetFactionalPlanetList(p_republic)
		if table.getn(planet_list_factional_rep) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if TestValid(Find_First_Object("Grievous_Malevolence"))
				or TestValid(Find_First_Object("Grievous_Malevolence_2")) then
					StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_CIS", 0)
				else
					StoryUtil.LoadCampaign("Sandbox_DurgesLance_CIS", 0)
				end
			end
		end
	end

	Sleep(5.0)
	if not cis_quest_planet_hunt_over then
		Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	end
end
function State_CIS_Quest_Checker_Grievous()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))

	elseif TestValid(Find_First_Object("Grievous_Recusant")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))

	elseif TestValid(Find_First_Object("Grievous_Munificent")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))

	elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))

	elseif TestValid(Find_First_Object("Grievous_Malevolence_2")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))

	elseif TestValid(Find_First_Object("General_Grievous")) then
		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))

	else

		event_act_1_01_task = plot.Get_Event("CIS_RimwardCampaign_Hero_Enter_Kamino")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Munificent"))
	end

	Sleep(5.0)
	if FindPlanet("Kamino").Get_Owner() ~= p_cis then
		Create_Thread("State_CIS_Quest_Checker_Grievous")
	end
end

function State_CIS_Bothawui_Business_Epilogue(message)
	if message == OnEnter then
		if GlobalValue.Get("Rimward_Bothawui_Business_Outcome") == 0 then
			if (GlobalValue.Get("Rimward_CIS_GC_Version") == 1) then
				SpawnList({"Munificent", "Munificent", "Munificent", "Munificent", "Grievous_Malevolence"}, FindPlanet("Bothawui"), p_cis, false, false)
				StoryUtil.SpawnAtSafePlanet("MOONUS_MANDEL", p_republic, StoryUtil.GetSafePlanetTable(), {"Praetor_I_Battlecruiser"})

			elseif (GlobalValue.Get("Rimward_CIS_GC_Version") == 0) then
				SpawnList({"Munificent", "Munificent", "Munificent", "Munificent", "Grievous_Munificent"}, FindPlanet("Bothawui"), p_cis, false, false)
			end

		elseif GlobalValue.Get("Rimward_Bothawui_Business_Outcome") == 1 then
			StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_republic, StoryUtil.GetSafePlanetTable(), {"Venator_Star_Destroyer", "Venator_Star_Destroyer", "PDF_DHC", "PDF_DHC", "Carrack_Cruiser_Lasers", "Carrack_Cruiser_Lasers", "CR90", "CR90", "CR90"})

			if (GlobalValue.Get("Rimward_CIS_GC_Version") == 1) then
				StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence"})
				StoryUtil.SpawnAtSafePlanet("MOONUS_MANDEL", p_republic, StoryUtil.GetSafePlanetTable(), {"Praetor_I_Battlecruiser"})

			elseif (GlobalValue.Get("Rimward_CIS_GC_Version") == 0) then
				StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Munificent"})
			end

		end
	end
end
function State_CIS_Rishi_Rookie_Epilogue(message)
	if message == OnEnter then
		Sleep(2.0)
		Story_Event("CIS_RISHI_END")
 		StoryUtil.SetPlanetRestricted("KAMINO", 1, false)
   end
end
function State_CIS_Water_World_Epilogue(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("KAMINO", 0)
	end
end
function State_CIS_Clone_Chaos_Epilogue(message)
	if message == OnEnter then
		Sleep(2.0)
		Story_Event("CIS_KAMINO_END")
		ChangePlanetOwnerAndRetreat(FindPlanet("Kamino"), p_cis)
	end
end

function State_CIS_RimwardCampaign_Skytop(message)
	if message == OnEnter then
		Story_Event("CIS_SKYTOP_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_2 = plot.Get_Event("CIS_RimwardCampaign_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Skytop_Station"))
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ruusan"))
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Skytop_Station"))
	end
end
function State_CIS_RimwardCampaign_Skytop_Research(message)
	if message == OnEnter then
		cis_quest_skytop_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_2 = plot.Get_Event("CIS_RimwardCampaign_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Skytop_Station"))

		Story_Event("CIS_SKYTOP_END")
	end
end

function State_CIS_RimwardCampaign_Ruusan(message)
	if message == OnEnter then
		Story_Event("CIS_RUUSAN_START")

		StoryUtil.SpawnAtSafePlanet("NEXUS_ORTAI", p_cis, StoryUtil.GetSafePlanetTable(), {"Gha_Nachkt_Vultures_Claw"})

		MissionUtil.FlashPlanet("RUUSAN", "GUI_Flash_Ruusan")
		MissionUtil.PositionCamera("RUUSAN")

		if not cis_quest_ruusan_over then
			Create_Thread("State_CIS_Quest_Checker_Ruusan")
		end
	end
end
function State_CIS_Quest_Checker_Ruusan()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	if TestValid(Find_First_Object("Gha_Nachkt_Vultures_Claw")) then
		local event_act_3 = plot.Get_Event("CIS_RimwardCampaign_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Gha_Nachkt_Vultures_Claw"))
		if TestValid(Find_First_Object("Gha_Nachkt_Vultures_Claw").Get_Planet_Location()) then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Gha_Nachkt_Vultures_Claw").Get_Planet_Location())
		end
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ruusan"))
		event_act_3.Add_Dialog_Text("TEXT_NONE")

		local event_act_3_task = plot.Get_Event("Trigger_CIS_Enter_Hero_Ruusan")
		event_act_3_task.Set_Event_Parameter(2, Find_Object_Type("Gha_Nachkt_Vultures_Claw"))

	else
		Sleep(5.0)
		Story_Event("CIS_RUUSAN_CHEAT")
	end

	Sleep(5.0)
	if not cis_quest_ruusan_over then
		Create_Thread("State_CIS_Quest_Checker_Ruusan")
	end
end
function State_CIS_Enter_Heroes_Ruusan(message)
	if message == OnEnter then
		Story_Event("CIS_RUUSAN_END")
		cis_quest_ruusan_over = true
	end
end

function State_CIS_RimwardCampaign_Ryloth(message)
	if message == OnEnter then
		Story_Event("CIS_RYLOTH_START")

		StoryUtil.SetPlanetRestricted("RYLOTH", 0)

		if not cis_quest_ryloth_over then
			Create_Thread("CIS_Quest_Checker_Ryloth")
		end
	else
		crossplot:update()
	end
end
function CIS_Quest_Checker_Ryloth()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local event_act_4 = plot.Get_Event("CIS_RimwardCampaign_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_4.Clear_Dialog_Text()
	if FindPlanet("Ryloth").Get_Owner() ~= p_cis then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Ryloth"))
	else
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Ryloth"))
		Story_Event("CIS_RYLOTH_END")
		Sleep(5.0)

		StoryUtil.SafeSpawnFavourHero("RYLOTH", p_cis, {"Tuuk_Procurer"})
		cis_quest_ryloth_over = true
	end

	Sleep(5.0)
	if not cis_quest_ryloth_over then
		Create_Thread("CIS_Quest_Checker_Ryloth")
	end
end

function State_CIS_RimwardCampaign_Ukio(message)
	if message == OnEnter then
		if FindPlanet("Ukio").Get_Owner() == p_cis then
			return
		end

		MissionUtil.FlashPlanet("UKIO", "GUI_Flash_Ukio")
		MissionUtil.PositionCamera("UKIO")

		Story_Event("CIS_UKIO_START")

		if not cis_quest_ukio_over then
			Create_Thread("State_CIS_Quest_Checker_Ukio")
		end
	end
end
function State_CIS_Quest_Checker_Ukio()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	if TestValid(Find_First_Object("Doctor_Instinction")) then
		local event_act_5 = plot.Get_Event("CIS_RimwardCampaign_Act_V_Dialog")
		event_act_5.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Doctor_Instinction"))
		if TestValid(Find_First_Object("Doctor_Instinction").Get_Planet_Location()) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Doctor_Instinction").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ukio"))
		event_act_5.Add_Dialog_Text("TEXT_NONE")

		if Find_First_Object("Doctor_Instinction").Get_Planet_Location() == FindPlanet("Ukio") then
			Story_Event("CIS_UKIO_END")
			MissionUtil.EnableInvasion("UKIO", true)
		end

	else
		Sleep(5.0)
		Story_Event("CIS_UKIO_END")
		MissionUtil.EnableInvasion("UKIO", true)
	end

	Sleep(5.0)
	if not cis_quest_ukio_over then
		Create_Thread("State_CIS_Quest_Checker_Ukio")
	end
end

function State_CIS_RimwardCampaign_Rodia(message)
	if message == OnEnter then
		Story_Event("CIS_RODIA_START")

		StoryUtil.SetPlanetRestricted("RODIA", 0)

		if not cis_quest_rodia_over then
			Create_Thread("State_CIS_Quest_Checker_Rodia")
		end
	end
end
function State_CIS_Quest_Checker_Rodia()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local event_act_6 = plot.Get_Event("CIS_RimwardCampaign_Act_VI_Dialog")
	event_act_6.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_6.Clear_Dialog_Text()
	if FindPlanet("Rodia").Get_Owner() ~= p_cis then
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rodia"))
	else
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rodia"))
		Story_Event("CIS_RODIA_END")

		p_cis.Give_Money(5000)

		cis_quest_rodia_over = true
	end

	Sleep(5.0)
	if not cis_quest_rodia_over then
		Create_Thread("State_CIS_Quest_Checker_Rodia")
	end
end

function State_CIS_RimwardCampaign_Gunray(message)
	if message == OnEnter then
		Story_Event("CIS_GUNRAY_START")

		StoryUtil.SpawnAtSafePlanet("KOTHLIS", p_republic, StoryUtil.GetSafePlanetTable(), {"Venator_Tranquility"})

		Create_Thread("State_CIS_Quest_Checker_Gunray")
	end
end
function State_CIS_Quest_Checker_Gunray()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local event_act_7 = plot.Get_Event("CIS_RimwardCampaign_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_7.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Venator_Tranquility")) or cis_quest_gunray_over then
		event_act_7.Add_Dialog_Text("Target: Nute Gunray / Venator-class Star Destroyer, Tranquility")
		if TestValid(Find_First_Object("Venator_Tranquility").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Venator_Tranquility").Get_Planet_Location())
		end
	else
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Venator_Tranquility"))
	end

	event_act_7.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not cis_quest_gunray_over then
		Create_Thread("State_CIS_Quest_Checker_Gunray")
	end
end
function State_CIS_Venator_Ventress_Epilogue(message)
	if message == OnEnter then
		cis_quest_gunray_over = true

		StoryUtil.SpawnAtSafePlanet("CHRONDRE", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Team","Ventress_Team"})

		Sleep(3.0)

		Story_Event("CIS_GUNRAY_END")
	end
end

function State_CIS_RimwardCampaign_Dooku_Search(message)
	if message == OnEnter then
		Story_Event("CIS_DOOKU_SEARCH_START")

		scout_target_01 = StoryUtil.FindTargetPlanet(p_cis, false, true, 1)

		cis_dooku_search_act_1 = true

		if not cis_quest_dooku_search_over then
			Create_Thread("State_CIS_Quest_Checker_Dooku_Search")
		end
	end
end
function State_CIS_Quest_Checker_Dooku_Search()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")
	local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_01")
	event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_8.Clear_Dialog_Text()

	if Check_Story_Flag(p_cis, "CIS_DOOKU_SEARCH_SCOUTING_01", nil, true) and cis_dooku_search_act_1 then
		scout_target_02 = StoryUtil.FindTargetPlanet(p_cis, false, true, 1)

		cis_dooku_search_act_1 = false
		cis_dooku_search_act_2 = true
	end
	if Check_Story_Flag(p_cis, "CIS_DOOKU_SEARCH_SCOUTING_02", nil, true) and cis_dooku_search_act_2 then
		scout_target_03 = StoryUtil.FindTargetPlanet(p_cis, false, true, 1)

		cis_dooku_search_act_2 = false
		cis_dooku_search_act_3 = true
	end
	if Check_Story_Flag(p_cis, "CIS_DOOKU_SEARCH_SCOUTING_03", nil, true) and cis_dooku_search_act_3 then
		scout_target_04 = StoryUtil.FindTargetPlanet(p_cis, false, true, 1)

		cis_dooku_search_act_3 = false
		cis_dooku_search_act_4 = true
	end
	if Check_Story_Flag(p_cis, "CIS_DOOKU_SEARCH_SCOUTING_04", nil, true) and cis_dooku_search_act_4 then
		cis_dooku_search_act_4 = false
		cis_quest_dooku_search_over = true
	end

	if cis_dooku_search_act_1 then
		local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_01")
		event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_8 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_01")
		event_act_8.Set_Event_Parameter(0, scout_target_01)
	end
	if cis_dooku_search_act_2 then
		local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_02")
		event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_8 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_02")
		event_act_8.Set_Event_Parameter(0, scout_target_02)
	end
	if cis_dooku_search_act_3 then
		local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_03")
		event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_8 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_03")
		event_act_8.Set_Event_Parameter(0, scout_target_03)
	end
	if cis_dooku_search_act_4 then
		local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_04")
		event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_04)

		event_act_8 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_04")
		event_act_8.Set_Event_Parameter(0, scout_target_04)
	end
	if cis_quest_dooku_search_over then
		local event_act_8 = plot.Get_Event("CIS_RimwardCampaign_Act_VIII_Dialog_04")
		event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_04)

		Sleep(5.0)

		cis_quest_dooku_search_over = true
		Story_Event("CIS_DOOKU_SEARCH_TACTICAL")
	end

	Sleep(5.0)
	if not cis_quest_dooku_search_over then
		Create_Thread("State_CIS_Quest_Checker_Dooku_Search")
	end
end
function State_CIS_Perfect_Piracy_Epilogue(message)
	if message == OnEnter then
		Story_Event("CIS_DOOKU_SEARCH_END")

		StoryUtil.SpawnAtSafePlanet("RAXUS_SECOND", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Team"})

		cis_quest_dooku_search_over = true
	end
end

function State_CIS_RimwardCampaign_Florrum(message)
	if message == OnEnter then
		Story_Event("CIS_FLORRUM_START")

		StoryUtil.SetPlanetRestricted("FLORRUM", 0)
		MissionUtil.EnableInvasion("FLORRUM", true)

		if not cis_quest_florrum_over then
			Create_Thread("State_CIS_Quest_Checker_Florrum")
		end
	end
end
function State_CIS_Quest_Checker_Florrum()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local event_act_9 = plot.Get_Event("CIS_RimwardCampaign_Act_IX_Dialog")
	event_act_9.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_9.Clear_Dialog_Text()
	if FindPlanet("Florrum").Get_Owner() ~= p_cis then
		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Florrum"))
	else
		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Florrum"))
		Story_Event("CIS_FLORRUM_END")

		p_cis.Give_Money(5000)

		cis_quest_florrum_over = true
	end

	Sleep(5.0)
	if not cis_quest_florrum_over then
		Create_Thread("State_CIS_Quest_Checker_Florrum")
	end
end

function State_CIS_RimwardCampaign_Crystals(message)
	if message == OnEnter then
		Story_Event("CIS_CRYSTALS_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_10 = plot.Get_Event("CIS_RimwardCampaign_Act_X_Dialog")
		event_act_10.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_10.Clear_Dialog_Text()

		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Crystal_Mining"))
		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Christophsis"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Dummy_Research_Crystal_Mining"))
	end
end
function State_CIS_RimwardCampaign_Crystal_Mining_Research(message)
	if message == OnEnter then
		cis_quest_crystals_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_10 = plot.Get_Event("CIS_RimwardCampaign_Act_X_Dialog")
		event_act_10.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_10.Clear_Dialog_Text()

		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Crystal_Mining"))

		Story_Event("CIS_CRYSTALS_END")
	end
end

function State_CIS_RimwardCampaign_Devastation(message)
	if message == OnEnter then
		Story_Event("CIS_DEVASTATION_START")

		ChangePlanetOwnerAndPopulate(FindPlanet("Christophsis"), p_independent_forces, 7500)
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("CHRISTOPHSIS", p_independent_forces, StoryUtil.GetSafePlanetTable(), {"Sai_Sircu_Devastation"})

		Create_Thread("State_CIS_Quest_Checker_Devastation")
	end
end
function State_CIS_Quest_Checker_Devastation()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

	local event_act_11 = plot.Get_Event("CIS_RimwardCampaign_Act_XI_Dialog")
	event_act_11.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
	event_act_11.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Sai_Sircu_Devastation")) then
		event_act_11.Add_Dialog_Text("Target: Sai Sircu / Modified Subjugator-class Heavy Cruiser, Devastation")
		if TestValid(Find_First_Object("Sai_Sircu_Devastation").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Sai_Sircu_Devastation").Get_Planet_Location())
		end
	else
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Sai_Sircu_Devastation"))
	end

	event_act_11.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not cis_quest_devastation_over then
		Create_Thread("State_CIS_Quest_Checker_Devastation")
	end
end
function State_CIS_RimwardCampaign_Devastation_Death(message)
	if message == OnEnter then
		cis_quest_devastation_over = true

		StoryUtil.SpawnAtSafePlanet("CHRISTOPHSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Devastation"})

		Story_Event("CIS_DEVASTATION_END")
	end
end

function State_CIS_RimwardCampaign_Super_Tank(message)
	if message == OnEnter then
		Story_Event("CIS_SUPER_TANK_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_12 = plot.Get_Event("CIS_RimwardCampaign_Act_XII_Dialog")
		event_act_12.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_12.Clear_Dialog_Text()

		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Super_Tank"))
		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Geonosis"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Dummy_Research_Super_Tank"))
	end
end
function State_CIS_RimwardCampaign_Super_Tank_Research(message)
	if message == OnEnter then
		cis_quest_super_tank_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_CIS.XML")

		local event_act_12 = plot.Get_Event("CIS_RimwardCampaign_Act_XII_Dialog")
		event_act_12.Set_Dialog("Dialog_22_BBY_RimwardCampaign_CIS")
		event_act_12.Clear_Dialog_Text()

		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Super_Tank"))

		p_cis.Unlock_Tech(Find_Object_Type("CIS_Super_Tank_Company"))

		p_tf.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
		p_cg.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
		p_tu.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))

		StoryUtil.SpawnAtSafePlanet("GEONOSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"TX_21_Team"})

		Story_Event("CIS_SUPER_TANK_END")
	end
end

function State_CIS_RimwardCampaign_GC_Progression(message)
	if message == OnEnter then
		if TestValid(Find_First_Object("Grievous_Malevolence"))
		or TestValid(Find_First_Object("Grievous_Malevolence_2")) then
			StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_CIS", 0)
		else
			StoryUtil.LoadCampaign("Sandbox_DurgesLance_CIS", 0)
		end
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	StoryUtil.SpawnAtSafePlanet("LERITOR", p_cis, StoryUtil.GetSafePlanetTable(), {"Yansu_Grjak_Team"})
	StoryUtil.SpawnAtSafePlanet("GEONOSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Poggle_Team","TX_21_Team","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("GAMORR", p_cis, StoryUtil.GetSafePlanetTable(), {"Doctor_Instinction"})
	StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Merai_Free_Dac"})
	StoryUtil.SpawnAtSafePlanet("RAXUS_SECOND", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Team","Ventress_Team"})
	StoryUtil.SpawnAtSafePlanet("RAXUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team","Lucid_Voice"})

	StoryUtil.SpawnAtSafePlanet("KAMINO", p_republic, StoryUtil.GetSafePlanetTable(), {"Obi_Wan_Delta_Team","Cody_Team","Shaak_Ti_Delta_Team","Byluir_Venator"})
	StoryUtil.SpawnAtSafePlanet("MON_CALAMARI", p_republic, StoryUtil.GetSafePlanetTable(), {"Kit_Fisto_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("UKIO", p_republic, StoryUtil.GetSafePlanetTable(), {"McQuarrie_Concept"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kilian_Endurance"})

	if (GlobalValue.Get("Rimward_Rep_GC_Version") == 1) then
		StoryUtil.SpawnAtSafePlanet("TOYDARIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Katuunko_Team"})
		StoryUtil.SpawnAtSafePlanet("HERDESSA", p_republic, StoryUtil.GetSafePlanetTable(), {"Nala_Se_Team"})
	end

	StoryUtil.SpawnAtSafePlanet("TATOOINE", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Tanda_Team","Jiliac_Dragon_Pearl"})
	StoryUtil.SpawnAtSafePlanet("NAR_SHADDAA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Parella_Team"})
	StoryUtil.SpawnAtSafePlanet("UBRIKKIA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Borvo_Prosperous_Secret"})

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	StoryUtil.RevealPlanet("RYLOTH", false)
	StoryUtil.RevealPlanet("RAXUS_SECOND", false)
	StoryUtil.RevealPlanet("FLORRUM", false)

	StoryUtil.SetPlanetRestricted("RYLOTH", 1, false)
	StoryUtil.SetPlanetRestricted("RUUSAN", 1, false)
	StoryUtil.SetPlanetRestricted("TETH", 1, false)

	MissionUtil.EnableInvasion("FLORRUM", false)

	Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
end
function State_Rep_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local RimwardCampaign_PlanetList = {
		FindPlanet("Boz_Pity"),
		FindPlanet("Geonosis"),
		FindPlanet("Hypori"),
		FindPlanet("Minntooine"),
		FindPlanet("Pammant"),
		FindPlanet("Raxus_Second"),
		FindPlanet("Ryloth"),
	}

	local event_act_1 = plot.Get_Event("Rep_RimwardCampaign_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(RimwardCampaign_PlanetList) do
		if p_planet.Get_Owner() ~= p_republic then
			if p_planet.Get_Planet_Location() == FindPlanet("Geonosis") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_RIMWARD_CAMPAIGN_REP_LOCATION_GEONOSIS", p_planet)
			elseif p_planet.Get_Planet_Location() == FindPlanet("Raxus_Second") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_RIMWARD_CAMPAIGN_REP_LOCATION_RAXUS_SEC", p_planet)
			elseif p_planet.Get_Planet_Location() == FindPlanet("Ryloth") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_RIMWARD_CAMPAIGN_REP_LOCATION_RYLOTH", p_planet)
			else
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Boz_Pity").Get_Owner() == p_republic 
	and FindPlanet("Geonosis").Get_Owner() == p_republic 
	and FindPlanet("Hypori").Get_Owner() == p_republic 
	and FindPlanet("Minntooine").Get_Owner() == p_republic 
	and FindPlanet("Pammant").Get_Owner() == p_republic
	and FindPlanet("Raxus_Second").Get_Owner() == p_republic
	and FindPlanet("Ryloth").Get_Owner() == p_republic then
		rep_quest_planet_hunt_over = true
		Story_Event("REP_PLANET_HUNT_END")

		local planet_list_factional_cis = StoryUtil.GetFactionalPlanetList(p_cis)
		if table.getn(planet_list_factional_cis) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
					StoryUtil.LoadCampaign("Sandbox_AU_Tennuutta_Republic", 1)
				else
					StoryUtil.LoadCampaign("Sandbox_Tennuutta_Republic", 1)
				end
			end
		end
	end

	if TestValid(Find_First_Object("Yularen_Resolute")) then
		local event_act_1_task = plot.Get_Event("Rep_RimwardCampaign_Hero_Enter_Ryloth")
		event_act_1_task.Set_Event_Parameter(2, Find_Object_Type("Yularen_Resolute"))
	elseif TestValid(Find_First_Object("Venator_Star_Destroyer")) then
		local event_act_1_task = plot.Get_Event("Rep_RimwardCampaign_Hero_Enter_Ryloth")
		event_act_1_task.Set_Event_Parameter(2, Find_Object_Type("Venator_Star_Destroyer"))
	end

	Sleep(5.0)
	if not rep_quest_planet_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
	end
end

function State_Rep_Bothawui_Business_Epilogue(message)
	if message == OnEnter then
		if GlobalValue.Get("Rimward_Bothawui_Business_Outcome") == 0 then
			StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Munificent"})
			StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_cis, StoryUtil.GetSafePlanetTable(), {"Munificent", "Munificent", "Munificent", "Munificent", "Munificent"})
			StoryUtil.SpawnAtSafePlanet("KOTHLIS", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute", "Anakin_Ahsoka_Twilight_Team", "Rex_Team"})
		else
			StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Munificent"})
			StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute", "Anakin_Ahsoka_Twilight_Team", "Rex_Team", "Venator_Star_Destroyer"})
		end

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	else
		crossplot:update()
	end
end

function State_Rep_Ryloth_Ramming_Epilogue(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("RYLOTH", 0)
		Clear_Fighter_Hero("AXE_BLUE_SQUADRON")
		if not TestValid(Find_First_Object("Yularen_Resolute")) then
			SpawnList({"Yularen_Resolute"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
	end
end
function State_Rep_Ryloth_Remedy_Epilogue(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("RYLOTH", 0)
		ChangePlanetOwnerAndRetreat(FindPlanet("Ryloth"), p_republic)
		MissionUtil.EnableInvasion("RYLOTH", true)
		Clear_Fighter_Hero("AXE_BLUE_SQUADRON")
		Sleep(3.0)
		if not TestValid(Find_First_Object("Yularen_Resolute")) then
			SpawnList({"Yularen_Resolute"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Obi_Wan")) then
			SpawnList({"Obi_Wan_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Cody")) then
			SpawnList({"Cody_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Rex")) then
			SpawnList({"Rex_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
	end
end
function State_Rep_Breaking_Bridges_Epilogue(message)
	if message == OnEnter then
		if not TestValid(Find_First_Object("Yularen_Resolute")) then
			SpawnList({"Yularen_Resolute"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Obi_Wan")) then
			SpawnList({"Obi_Wan_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Cody")) then
			SpawnList({"Cody_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end
		if not TestValid(Find_First_Object("Rex")) then
			SpawnList({"Rex_Team"}, FindPlanet("Ryloth"), p_republic, false, false)
		end

		StoryUtil.SpawnAtSafePlanet("RYLOTH", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Delta_Team","Orn_Free_Taa_Team"})
		StoryUtil.SpawnAtSafePlanet("RYLOTH", p_cis, StoryUtil.GetSafePlanetTable(), {"TA_175_Team"})
		StoryUtil.SafeSpawnFavourHero("RYLOTH", p_cis, {"Tuuk_Procurer"})
	else
		crossplot:update()
	end
end

function State_Rep_RimwardCampaign_Communication(message)
	if message == OnEnter then
		Story_Event("REP_COMMUNICATION_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

		local event_act_2 = plot.Get_Event("Rep_RimwardCampaign_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Rishi_Station"))
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rishi"))
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Rishi_Station"))
	end
end
function State_Rep_RimwardCampaign_Rishi_Station_Research(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

		local event_act_2 = plot.Get_Event("Rep_RimwardCampaign_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Rishi_Station"))

		Story_Event("REP_COMMUNICATION_END")
		rep_quest_communication_over = true
	end
end

function State_Rep_RimwardCampaign_Station_Search(message)
	if message == OnEnter then
		Story_Event("REP_STATION_SEARCH_START")

		scout_target_01 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_station_search_act_1 = true

		if not rep_quest_station_search_over then
			Create_Thread("State_Rep_Quest_Checker_Station_Search")
		end
	end
end
function State_Rep_Quest_Checker_Station_Search()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")
	local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_01")
	event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_3.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_STATION_SEARCH_SCOUTING_01", nil, true) and rep_station_search_act_1 then
		scout_target_02 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_station_search_act_1 = false
		rep_station_search_act_2 = true
	end
	if Check_Story_Flag(p_republic, "REP_STATION_SEARCH_SCOUTING_02", nil, true) and rep_station_search_act_2 then
		scout_target_03 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_station_search_act_2 = false
		rep_station_search_act_3 = true
	end
	if Check_Story_Flag(p_republic, "REP_STATION_SEARCH_SCOUTING_03", nil, true) and rep_station_search_act_3 then
		scout_target_04 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_station_search_act_3 = false
		rep_station_search_act_4 = true
	end
	if Check_Story_Flag(p_republic, "REP_STATION_SEARCH_SCOUTING_04", nil, true) and rep_station_search_act_4 then
		rep_station_search_act_4 = false
		rep_quest_station_search_over = true
	end

	if rep_station_search_act_1 then
		local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_01")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_3 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_01")
		event_act_3.Set_Event_Parameter(0, scout_target_01)
	end
	if rep_station_search_act_2 then
		local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_02")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_3 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_02")
		event_act_3.Set_Event_Parameter(0, scout_target_02)
	end
	if rep_station_search_act_3 then
		local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_03")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_3 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_03")
		event_act_3.Set_Event_Parameter(0, scout_target_03)
	end
	if rep_station_search_act_4 then
		local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_04")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_04)

		event_act_3 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_04")
		event_act_3.Set_Event_Parameter(0, scout_target_04)
	end
	if rep_quest_station_search_over then
		local event_act_3 = plot.Get_Event("Rep_RimwardCampaign_Act_III_Dialog_04")
		event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_04)

		Story_Event("REP_STATION_SEARCH_END")
	end

	Sleep(5.0)
	if not rep_quest_station_search_over then
		Create_Thread("State_Rep_Quest_Checker_Station_Search")
	end
end

function State_Rep_RimwardCampaign_Skytop(message)
	if message == OnEnter then
		Story_Event("REP_SKYTOP_START")

		MissionUtil.FlashPlanet("RUUSAN", "GUI_Flash_Ruusan")
		MissionUtil.PositionCamera("RUUSAN")

		if not TestValid(Find_First_Object("Anakin3")) then
			StoryUtil.SpawnAtSafePlanet("ROTHANA", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_Ahsoka_Twilight_Team"})
		end

		if not rep_quest_skytop_over then
			Create_Thread("State_Rep_Quest_Checker_Skytop")
		end
	end
end
function State_Rep_Quest_Checker_Skytop()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")
	local event_act_4 = plot.Get_Event("Rep_RimwardCampaign_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_4.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Anakin3")) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Ahsoka_Twilight_Team"))
		if TestValid(Find_First_Object("Anakin3").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin3").Get_Planet_Location())
		end
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ruusan"))
		event_act_4.Add_Dialog_Text("TEXT_NONE")

		local event_act_4_task = plot.Get_Event("Trigger_Rep_Enter_Hero_Skytop")
		event_act_4_task.Set_Event_Parameter(2, Find_Object_Type("Anakin_Ahsoka_Twilight_Team"))

	elseif TestValid(Find_First_Object("Anakin")) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Delta_Team"))
		if TestValid(Find_First_Object("Anakin").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin").Get_Planet_Location())
		end
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ruusan"))
		event_act_4.Add_Dialog_Text("TEXT_NONE")

		local event_act_4_task = plot.Get_Event("Trigger_Rep_Enter_Hero_Skytop")
		event_act_4_task.Set_Event_Parameter(2, Find_Object_Type("Anakin_Delta_Team"))

	elseif TestValid(Find_First_Object("Venator_Star_Destroyer")) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Venator_Star_Destroyer"))
		if TestValid(Find_First_Object("Venator_Star_Destroyer").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Venator_Star_Destroyer").Get_Planet_Location())
		end
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Ruusan"))
		event_act_4.Add_Dialog_Text("TEXT_NONE")

		local event_act_4_task = plot.Get_Event("Trigger_Rep_Enter_Hero_Skytop")
		event_act_4_task.Set_Event_Parameter(2, Find_Object_Type("Venator_Star_Destroyer"))

	else
		Sleep(5.0)
		Story_Event("REP_SKYTOP_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_skytop_over then
		Create_Thread("State_Rep_Quest_Checker_Skytop")
	end
end
function State_Rep_Ruusan_Roulette_Epilogue(message)
	if message == OnEnter then
		Story_Event("REP_SKYTOP_END")
		rep_quest_skytop_over = true

		StoryUtil.SetPlanetRestricted("RUUSAN", 0)
		ChangePlanetOwnerAndRetreat(FindPlanet("Ruusan"), p_republic)
	end
end

function State_Rep_RimwardCampaign_Rishi(message)
	if message == OnEnter then
		Story_Event("REP_RISHI_START")

		MissionUtil.FlashPlanet("RISHI", "GUI_Flash_Rishi")
		MissionUtil.PositionCamera("RISHI")

		if not rep_quest_rishi_over then
			Create_Thread("State_Rep_Quest_Checker_Rishi")
		end
	end
end
function State_Rep_Quest_Checker_Rishi()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	if GlobalValue.Get("CURRENT_CLONE_PHASE") == 1 then
		if TestValid(Find_First_Object("Cody")) and TestValid(Find_First_Object("Rex")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Cody")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Rex")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex_Team")
		elseif TestValid(Find_First_Object("Cody")) and not TestValid(Find_First_Object("Rex")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Cody")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Cody")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Cody_Team")
		elseif not TestValid(Find_First_Object("Cody")) and TestValid(Find_First_Object("Rex")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Rex")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Rex_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Rex")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex_Team")
		elseif not TestValid(Find_First_Object("Cody")) and not TestValid(Find_First_Object("Rex")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("ARC_Phase_One_Company")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("ARC_Phase_One_Company_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("ARC_Phase_One_Company")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("ARC_Phase_One_Company_Team")
		end
	end
	if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
		if TestValid(Find_First_Object("Cody2")) and TestValid(Find_First_Object("Rex2")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Cody2")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody2_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Rex2")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex2_Team")
		elseif TestValid(Find_First_Object("Cody2")) and not TestValid(Find_First_Object("Rex2")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Cody2")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody2_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Cody2")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Cody2_Team")
		elseif not TestValid(Find_First_Object("Cody2")) and TestValid(Find_First_Object("Rex2")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("Rex2")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Rex2_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("Rex2")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex2_Team")
		elseif not TestValid(Find_First_Object("Cody2")) and not TestValid(Find_First_Object("Rex2")) then
			p_rep_quest_rishi_hero_1 = Find_First_Object("ARC_Phase_One_Company")
			p_rep_quest_rishi_hero_type_1 = Find_Object_Type("ARC_Phase_One_Company_Team")

			p_rep_quest_rishi_hero_2 = Find_First_Object("ARC_Phase_One_Company")
			p_rep_quest_rishi_hero_type_2 = Find_Object_Type("ARC_Phase_One_Company_Team")
		end
	end

	local event_act_5 = plot.Get_Event("Rep_RimwardCampaign_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_5.Clear_Dialog_Text()

	event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", p_rep_quest_rishi_hero_type_1)
	if TestValid(p_rep_quest_rishi_hero_1.Get_Planet_Location()) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", p_rep_quest_rishi_hero_1.Get_Planet_Location())
	end
	event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rishi"))
	event_act_5.Add_Dialog_Text("TEXT_NONE")

	event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", p_rep_quest_rishi_hero_type_2)
	if TestValid(p_rep_quest_rishi_hero_2.Get_Planet_Location()) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", p_rep_quest_rishi_hero_2.Get_Planet_Location())
	end
	event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rishi"))
	event_act_5.Add_Dialog_Text("TEXT_NONE")

	local event_act_5_task_01 = plot.Get_Event("Trigger_Rep_Deploy_Hero_01_Rishi")
	event_act_5_task_01.Set_Event_Parameter(0, p_rep_quest_rishi_hero_type_1)

	local event_act_5_task_02 = plot.Get_Event("Trigger_Rep_Deploy_Hero_02_Rishi")
	event_act_5_task_02.Set_Event_Parameter(0, p_rep_quest_rishi_hero_type_2)

	Sleep(5.0)
	if not rep_quest_rishi_over then
		Create_Thread("State_Rep_Quest_Checker_Rishi")
	end
end
function State_Rep_Deploy_Heroes_Rishi(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

		if GlobalValue.Get("CURRENT_CLONE_PHASE") == 1 then
			if TestValid(Find_First_Object("Cody")) and TestValid(Find_First_Object("Rex")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Cody")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Rex")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex_Team")
			elseif TestValid(Find_First_Object("Cody")) and not TestValid(Find_First_Object("Rex")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Cody")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Cody")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Cody_Team")
			elseif not TestValid(Find_First_Object("Cody")) and TestValid(Find_First_Object("Rex")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Rex")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Rex_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Rex")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex_Team")
			elseif not TestValid(Find_First_Object("Cody")) and not TestValid(Find_First_Object("Rex")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("ARC_Phase_One_Company")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("ARC_Phase_One_Company_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("ARC_Phase_One_Company")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("ARC_Phase_One_Company_Team")
			end
		end
		if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
			if TestValid(Find_First_Object("Cody2")) and TestValid(Find_First_Object("Rex2")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Cody2")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody2_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Rex2")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex2_Team")
			elseif TestValid(Find_First_Object("Cody2")) and not TestValid(Find_First_Object("Rex2")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Cody2")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Cody2_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Cody2")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Cody2_Team")
			elseif not TestValid(Find_First_Object("Cody2")) and TestValid(Find_First_Object("Rex2")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("Rex2")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("Rex2_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("Rex2")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("Rex2_Team")
			elseif not TestValid(Find_First_Object("Cody2")) and not TestValid(Find_First_Object("Rex2")) then
				p_rep_quest_rishi_hero_1 = Find_First_Object("ARC_Phase_One_Company")
				p_rep_quest_rishi_hero_type_1 = Find_Object_Type("ARC_Phase_One_Company_Team")

				p_rep_quest_rishi_hero_2 = Find_First_Object("ARC_Phase_One_Company")
				p_rep_quest_rishi_hero_type_2 = Find_Object_Type("ARC_Phase_One_Company_Team")
			end
		end

		local event_act_5 = plot.Get_Event("Rep_RimwardCampaign_Act_V_Dialog")
		event_act_5.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", p_rep_quest_rishi_hero_type_1)

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", p_rep_quest_rishi_hero_type_2)

		Sleep(5.0)

		Story_Event("REP_RISHI_TACTICAL")

		rep_quest_rishi_over = true
		Story_Event("REP_RISHI_END")
	end
end

function State_Rep_RimwardCampaign_Kamino(message)
	if message == OnEnter then
		Story_Event("REP_KAMINO_START")

		MissionUtil.FlashPlanet("KAMINO", "GUI_Flash_Kamino")
		MissionUtil.PositionCamera("KAMINO")

		if not rep_quest_kamino_over then
			Create_Thread("State_Rep_Quest_Checker_Kamino")
		end
	end
end
function State_Rep_Quest_Checker_Kamino()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	event_act_6 = plot.Get_Event("Rep_RimwardCampaign_Act_VI_Dialog")
	event_act_6.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_6.Clear_Dialog_Text()
	event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Kamino"))
	event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_TIMER_REMAINING", rep_kamino_timer_weeks)

	rep_kamino_timer_seconds = rep_kamino_timer_seconds + 1
	if rep_kamino_timer_seconds == 40 then
		rep_kamino_timer_weeks = rep_kamino_timer_weeks - 1
		rep_kamino_timer_seconds = 0
	end

	if rep_kamino_timer_weeks == 0 then
		rep_quest_kamino_over = true

		Story_Event("REP_KAMINO_TACTICAL")
		Sleep(5.0)

		Story_Event("REP_KAMINO_END")
	end

	Sleep(1.0)
	if not rep_quest_kamino_over then
		Create_Thread("State_Rep_Quest_Checker_Kamino")
	end
end
function State_Rep_Clone_Chaos_Tactical_Failed(message)
	if message == OnEnter then
		ChangePlanetOwnerAndRetreat(FindPlanet("Kamino"), p_cis)

		local spawn_list = {
			"Providence_Dreadnought",
			"Providence_Dreadnought",
			"Providence_Dreadnought",
			"Lucrehulk_Battleship",
			"Lucrehulk_Battleship",
			"Providence_Carrier",
			"Providence_Carrier",
			"Providence_Carrier",
			"Captor",
			"Captor",
			"Auxilia",
			"Auxilia",
			"Auxilia",
			"Auxilia",
			"C9979_Carrier",
			"C9979_Carrier",
			"C9979_Carrier",
			"C9979_Carrier",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munificent",
			"Munificent",
			"Munificent",
			"Munificent",
			"B1_Droid_Company",
			"B2_Droid_Company",
			"CIS_STAP_Company",
			"Magna_Octuptarra_Company",
			"CIS_MTT_Company",
			"Persuader_Company",
			"OG9_Company",
			"Rebel_Office",
			"Galactic_Turbolaser_Tower_Defenses",
			"R_Ground_Heavy_Vehicle_Factory",
			"Ground_Planetary_Shield",
		}

		SpawnList(spawn_list, FindPlanet("Kamino"), p_cis, false, false)
	end
end

function State_Rep_RimwardCampaign_Florrum(message)
	if message == OnEnter then
		Story_Event("REP_FLORRUM_START")

		MissionUtil.FlashPlanet("FLORRUM", "GUI_Flash_Florrum")
		MissionUtil.PositionCamera("FLORRUM")

		StoryUtil.SpawnAtSafePlanet("BOTHAWUI", p_republic, StoryUtil.GetSafePlanetTable(), {"Jar_Jar_Team"})
		Sleep(5.0)

		if not rep_quest_florrum_over then
			Create_Thread("State_Rep_Quest_Checker_Florrum")
		end
	end
end
function State_Rep_Quest_Checker_Florrum()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local event_act_7 = plot.Get_Event("Rep_RimwardCampaign_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_7.Clear_Dialog_Text()


	if TestValid(Find_First_Object("Anakin3")) then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Ahsoka_Twilight_Team"))
		if TestValid(Find_First_Object("Anakin3").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin3").Get_Planet_Location())
		end
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Florrum"))
		event_act_7.Add_Dialog_Text("TEXT_NONE")

		if Find_First_Object("Anakin3").Get_Planet_Location() == FindPlanet("Florrum") then
			rep_florrum_enter_hero_01 = true
		end
	else
		rep_florrum_enter_hero_01 = true
	end
	if TestValid(Find_First_Object("Obi_Wan")) then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Obi_Wan_Delta_Team"))
		if TestValid(Find_First_Object("Obi_Wan").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Obi_Wan").Get_Planet_Location())
		end
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Florrum"))
		event_act_7.Add_Dialog_Text("TEXT_NONE")

		if Find_First_Object("Obi_Wan").Get_Planet_Location() == FindPlanet("Florrum") then
			rep_florrum_enter_hero_02 = true
		end
	else
		rep_florrum_enter_hero_02 = true
	end
	if TestValid(Find_First_Object("Jar_Jar_Binks")) then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Jar_Jar_Team"))
		if TestValid(Find_First_Object("Jar_Jar_Binks").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Jar_Jar_Binks").Get_Planet_Location())
		end
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Florrum"))
		event_act_7.Add_Dialog_Text("TEXT_NONE")

		if Find_First_Object("Jar_Jar_Binks").Get_Planet_Location() == FindPlanet("Florrum") then
			rep_florrum_enter_hero_03 = true
		end
	else
		rep_florrum_enter_hero_03 = true
	end

	if rep_florrum_enter_hero_01
	and rep_florrum_enter_hero_02
	and rep_florrum_enter_hero_03 then
		Story_Event("REP_FLORRUM_TACTICAL")
	end

	Sleep(5.0)
	if not rep_quest_florrum_over then
		Create_Thread("State_Rep_Quest_Checker_Florrum")
	end
end
function State_Rep_Perfect_Piracy_Epilogue(message)
	if message == OnEnter then
		Story_Event("REP_FLORRUM_END")
		rep_quest_florrum_over = true

		MissionUtil.EnableInvasion("FLORRUM", true)
		ChangePlanetOwnerAndRetreat(FindPlanet("Florrum"), p_republic)

		if not TestValid(Find_First_Object("Anakin3")) then
			StoryUtil.SpawnAtSafePlanet("FLORRUM", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_Ahsoka_Twilight_Team"})
		end
		if not TestValid(Find_First_Object("Obi_Wan")) then
			StoryUtil.SpawnAtSafePlanet("FLORRUM", p_republic, StoryUtil.GetSafePlanetTable(), {"Obi_Wan_Delta_Team"})
		end
	end
end

function State_Rep_RimwardCampaign_Ziro(message)
	if message == OnEnter then
		Story_Event("REP_ZIRO_START")

		StoryUtil.SetPlanetRestricted("TETH", 0)

		ChangePlanetOwnerAndPopulate(FindPlanet("Teth"), p_hutts, 7500)
		Sleep(10.0)

		SpawnList({"Ziro_The_Hutt_Team","WLO5_Tank_Company","WLO5_Tank_Company","Hutt_Bantha_II_Skiff_Company","Hutt_Guard_Company","Hutt_Guard_Company"}, FindPlanet("Teth"), p_hutts, false, false)

		Create_Thread("State_Rep_Quest_Checker_Ziro")
	end
end
function State_Rep_Quest_Checker_Ziro()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local event_act_8 = plot.Get_Event("Rep_RimwardCampaign_Act_VIII_Dialog")
	event_act_8.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_8.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Ziro_The_Hutt")) then
		event_act_8.Add_Dialog_Text("Target: Ziro The Hutt")
		if TestValid(Find_First_Object("Ziro_The_Hutt").Get_Planet_Location()) then
			event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Ziro_The_Hutt").Get_Planet_Location())
		end
	else
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Ziro_The_Hutt_Team"))
	end

	event_act_8.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not rep_quest_ziro_over then
		Create_Thread("State_Rep_Quest_Checker_Ziro")
	end
end
function State_Rep_RimwardCampaign_Ziro_Death(message)
	if message == OnEnter then
		rep_quest_ziro_over = true

		Story_Event("REP_ZIRO_END")
	end
end

function State_Rep_RimwardCampaign_Rodia(message)
	if message == OnEnter then
		Story_Event("REP_RODIA_START")

		ChangePlanetOwnerAndPopulate(FindPlanet("Rodia"), p_cis, 7500)
		Sleep(5.0)

		UnitUtil.DespawnList({"Nute_Gunray"})
		SpawnList({"Nute_Gunray_Team","AAT_Company","B1_Droid_Company","B1_Droid_Company","B2_Droid_Company"}, FindPlanet("Rodia"), p_cis, false, false)

		if not rep_quest_rodia_over then
			Create_Thread("State_Rep_Quest_Checker_Rodia")
		end
	end
end
function State_Rep_Quest_Checker_Rodia()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local event_act_9 = plot.Get_Event("Rep_RimwardCampaign_Act_IX_Dialog")
	event_act_9.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_9.Clear_Dialog_Text()

	if FindPlanet("Rodia").Get_Owner() ~= p_republic then
		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rodia"))
	else
		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rodia"))
		Story_Event("REP_RODIA_END")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("RODIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Padme_Amidala_Team"})
		rep_quest_rodia_over = true
	end

	Sleep(5.0)
	if not rep_quest_rodia_over then
		Create_Thread("State_Rep_Quest_Checker_Rodia")
	end
end

function State_Rep_RimwardCampaign_Christophsis(message)
	if message == OnEnter then
		Story_Event("REP_CHRISTOPHSIS_START")

		MissionUtil.FlashPlanet("CHRISTOPHSIS", "GUI_Flash_Christophsis")
		MissionUtil.PositionCamera("CHRISTOPHSIS")

		if not rep_quest_christophsis_over then
			Create_Thread("State_Rep_Quest_Checker_Christophsis")
		end
	end
end
function State_Rep_Quest_Checker_Christophsis()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")
	local event_act_10 = plot.Get_Event("Rep_RimwardCampaign_Act_X_Dialog")
	event_act_10.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_10.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Padme_Amidala")) then
		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Padme_Amidala_Team"))
		if TestValid(Find_First_Object("Padme_Amidala").Get_Planet_Location()) then
			event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Padme_Amidala").Get_Planet_Location())
		end
		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Christophsis"))
		event_act_10.Add_Dialog_Text("TEXT_NONE")

		local event_act_10_task = plot.Get_Event("Trigger_Rep_Deploy_Hero_Christophsis")
		event_act_10_task.Set_Event_Parameter(0, Find_Object_Type("Padme_Amidala_Team"))

	elseif TestValid(Find_First_Object("Jar_Jar")) then
		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Jar_Jar_Team"))
		if TestValid(Find_First_Object("Jar_Jar").Get_Planet_Location()) then
			event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Jar_Jar").Get_Planet_Location())
		end
		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Christophsis"))
		event_act_10.Add_Dialog_Text("TEXT_NONE")

		local event_act_10_task = plot.Get_Event("Trigger_Rep_Deploy_Hero_Christophsis")
		event_act_10_task.Set_Event_Parameter(0, Find_Object_Type("Jar_Jar_Team"))

	else
		Sleep(5.0)
		Story_Event("REP_CHRISTOPHSIS_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_christophsis_over then
		Create_Thread("State_Rep_Quest_Checker_Christophsis")
	end
end
function State_Rep_Deploy_Heroes_Christophsis(message)
	if message == OnEnter then
		Story_Event("REP_CHRISTOPHSIS_END")
		rep_quest_christophsis_over = true
	end
end

function State_Rep_RimwardCampaign_Devastation(message)
	if message == OnEnter then
		Story_Event("REP_DEVASTATION_START")

		StoryUtil.SpawnAtSafePlanet("CHRISTOPHSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Sai_Sircu_Devastation"})

		Create_Thread("State_Rep_Quest_Checker_Devastation")
	end
end
function State_Rep_Quest_Checker_Devastation()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local event_act_11 = plot.Get_Event("Rep_RimwardCampaign_Act_XI_Dialog")
	event_act_11.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_11.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Sai_Sircu_Devastation")) then
		event_act_11.Add_Dialog_Text("Target: Sai Sircu / Subjugator-class Heavy Cruiser, Devastation")
		if TestValid(Find_First_Object("Sai_Sircu_Devastation").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Sai_Sircu_Devastation").Get_Planet_Location())
		end
	else
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Sai_Sircu_Devastation"))
	end

	event_act_11.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not rep_quest_devastation_over then
		Create_Thread("State_Rep_Quest_Checker_Devastation")
	end
end
function State_Rep_RimwardCampaign_Devastation_Death(message)
	if message == OnEnter then
		rep_quest_devastation_over = true

		Story_Event("REP_DEVASTATION_END")
	end
end

function State_Rep_RimwardCampaign_Pammant(message)
	if message == OnEnter then
		Story_Event("REP_PAMMANT_START")

		Create_Thread("State_Rep_Quest_Checker_Pammant")
	end
end
function State_Rep_Quest_Checker_Pammant()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Republic.XML")

	local event_act_12 = plot.Get_Event("Rep_RimwardCampaign_Act_XII_Dialog")
	event_act_12.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Rep")
	event_act_12.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Grievous_Malevolence_2")) then
		event_act_12.Add_Dialog_Text("Target: General Grievous / Subjugator-class Heavy Cruiser, Malevolence II")
		if TestValid(Find_First_Object("Grievous_Malevolence_2").Get_Planet_Location()) then
			event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Grievous_Malevolence_2").Get_Planet_Location())
		end
	else
		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Grievous_Malevolence_2"))
	end

	event_act_12.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not rep_quest_pammant_over then
		Create_Thread("State_Rep_Quest_Checker_Pammant")
	end
end
function State_Rep_RimwardCampaign_Malevolence_2_Death(message)
	if message == OnEnter then
		rep_quest_pammant_over = true

		Story_Event("REP_PAMMANT_END")
	end
end

function State_Rep_RimwardCampaign_GC_Progression(message)
	if message == OnEnter then
		if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
			StoryUtil.LoadCampaign("Sandbox_AU_Tennuutta_Republic", 1)
		else
			StoryUtil.LoadCampaign("Sandbox_Tennuutta_Republic", 1)
		end
	end
end

-- Hutts

function Hutts_Story_Set_Up()
	Story_Event("HUTTS_STORY_START")

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	StoryUtil.SpawnAtSafePlanet("LERITOR", p_cis, StoryUtil.GetSafePlanetTable(), {"Yansu_Grjak_Team"})
	StoryUtil.SpawnAtSafePlanet("GEONOSIS", p_cis, StoryUtil.GetSafePlanetTable(), {"Poggle_Team","TX_21_Team","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("GAMORR", p_cis, StoryUtil.GetSafePlanetTable(), {"Doctor_Instinction"})
	StoryUtil.SafeSpawnFavourHero("SISKEEN", p_cis, {"Tuuk_Procurer"})
	StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Merai_Free_Dac"})
	StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Munificent"})
	StoryUtil.SpawnAtSafePlanet("RAXUS_SECOND", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Team","Ventress_Team"})
	StoryUtil.SpawnAtSafePlanet("RAXUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team"})

	StoryUtil.SpawnAtSafePlanet("LANNIK", p_republic, StoryUtil.GetSafePlanetTable(), {"Padme_Amidala_Team"})
	StoryUtil.SpawnAtSafePlanet("KAMINO", p_republic, StoryUtil.GetSafePlanetTable(), {"Obi_Wan_Delta_Team","Cody_Team","Shaak_Ti_Delta_Team","Byluir_Venator","Nala_Se_Team"})
	StoryUtil.SpawnAtSafePlanet("MON_CALAMARI", p_republic, StoryUtil.GetSafePlanetTable(), {"Kit_Fisto_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("UKIO", p_republic, StoryUtil.GetSafePlanetTable(), {"McQuarrie_Concept"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kilian_Endurance"})
	StoryUtil.SpawnAtSafePlanet("RISHI", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute","Anakin_Ahsoka_Twilight_Team","Rex_Team","Venator_Star_Destroyer","Venator_Star_Destroyer"})
	StoryUtil.SpawnAtSafePlanet("TOYDARIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Katuunko_Team"})

	StoryUtil.SpawnAtSafePlanet("TATOOINE", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Tanda_Team","Jiliac_Dragon_Pearl"})
	StoryUtil.SpawnAtSafePlanet("NAR_SHADDAA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Parella_Team"})
	StoryUtil.SpawnAtSafePlanet("UBRIKKIA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Borvo_Prosperous_Secret"})

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	StoryUtil.RevealPlanet("RYLOTH", false)
	StoryUtil.RevealPlanet("RUUSAN", false)
	StoryUtil.RevealPlanet("RAXUS_SECOND", false)
	StoryUtil.RevealPlanet("GEONOSIS", false)

	StoryUtil.RevealPlanet("KAMINO", false)
	StoryUtil.RevealPlanet("RISHI", false)
	StoryUtil.RevealPlanet("ROTHANA", false)
	StoryUtil.RevealPlanet("TETH", false)

	p_cis.Unlock_Tech(Find_Object_Type("CIS_Super_Tank_Company"))
	p_tf.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
	p_cg.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))
	p_tu.Unlock_Tech(Find_Object_Type("Super_Tank_Company"))

	StoryUtil.SetPlanetRestricted("OBA_DIAH", 1, false)
	StoryUtil.SetPlanetRestricted("TETH", 1, false)

	Create_Thread("State_Hutt_Quest_Checker_Meeting")

	crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
end
function State_Hutt_Quest_Checker_Meeting()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Hutts.XML")

	event_act_1 = plot.Get_Event("Hutts_RimwardCampaign_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
	event_act_1.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Jabba_The_Hutt")) then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Jabba_The_Hutt_Team"))
		if TestValid(Find_First_Object("Jabba_The_Hutt").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Jabba_The_Hutt").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Nal_Hutta"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		event_act_1_task_01 = plot.Get_Event("Hutts_RimwardCampaign_Hero_Deploy_Nal_Hutta")
		event_act_1_task_01.Set_Event_Parameter(0, Find_Object_Type("Jabba_The_Hutt_Team"))
	elseif not TestValid(Find_First_Object("Jabba_The_Hutt")) then
		StoryUtil.SpawnAtSafePlanet("TATOOINE", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	end

	Sleep(5.0)
	if not hutts_quest_meeting_over then
		Create_Thread("State_Hutt_Quest_Checker_Meeting")
	end
end
function State_Hutts_RimwardCampaign_Hero_Deploy_Nal_Hutta(message)
	if message == OnEnter then
		hutts_quest_meeting_over = true

		Story_Event("HUTTS_MEETING_END")
	end
end

function State_Hutts_Hutt_Hostage_Epilogue(message)
	if message == OnEnter then
		if p_hutts.Is_Human() then
			if (GlobalValue.Get("Rimward_Hutt_Hostage_Outcome_Bossk") == 0) then
				local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
				StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, Safe_House_Planet, {"Bossk_Team"})
			end
			if (GlobalValue.Get("Rimward_Hutt_Hostage_Outcome_Dengar") == 0) then
				local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
				StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, Safe_House_Planet, {"Dengar_Team"})
			end
			if (GlobalValue.Get("Rimward_Hutt_Hostage_Outcome_Shahan") == 0) then
				local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
				StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, Safe_House_Planet, {"Shahan_Alama_Team"})
			end
		end
	end
end

function State_Hutts_RimwardCampaign_Ziro_Hunt(message)
	if message == OnEnter then
		Story_Event("HUTTS_ZIRO_HUNT_START")

		scout_target_01 = StoryUtil.FindTargetPlanet(p_hutts, false, true, 1)

		hutts_ziro_hunt_act_1 = true

		if not hutts_quest_ziro_hunt_over then
			Create_Thread("State_Hutts_Quest_Checker_Ziro_Hunt")
		end
	end
end
function State_Hutts_Quest_Checker_Ziro_Hunt()
		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Hutts.XML")
		event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_01")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

	if Check_Story_Flag(p_hutts, "HUTTS_ZIRO_HUNT_SCOUTING_01", nil, true) and hutts_ziro_hunt_act_1 then
		scout_target_02 = StoryUtil.FindTargetPlanet(p_hutts, false, true, 1)

		hutts_ziro_hunt_act_1 = false
		hutts_ziro_hunt_act_2 = true
	end
	if Check_Story_Flag(p_hutts, "HUTTS_ZIRO_HUNT_SCOUTING_02", nil, true) and hutts_ziro_hunt_act_2 then
		scout_target_03 = StoryUtil.FindTargetPlanet(p_hutts, false, true, 1)

		hutts_ziro_hunt_act_2 = false
		hutts_ziro_hunt_act_3 = true
	end
	if Check_Story_Flag(p_hutts, "HUTTS_ZIRO_HUNT_SCOUTING_03", nil, true) and hutts_ziro_hunt_act_3 then
		scout_target_04 = StoryUtil.FindTargetPlanet(p_hutts, false, true, 1)

		hutts_ziro_hunt_act_3 = false
		hutts_ziro_hunt_act_4 = true
	end
	if Check_Story_Flag(p_hutts, "HUTTS_ZIRO_HUNT_SCOUTING_04", nil, true) and hutts_ziro_hunt_act_4 then
		hutts_ziro_hunt_act_4 = false
		hutts_quest_ziro_hunt_over = true
	end

	if hutts_ziro_hunt_act_1 then
		local event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_01")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_2 = plot.Get_Event("Trigger_Hutts_Enter_Probe_Search_01")
		event_act_2.Set_Event_Parameter(0, scout_target_01)
	end
	if hutts_ziro_hunt_act_2 then
		local event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_02")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_2 = plot.Get_Event("Trigger_Hutts_Enter_Probe_Search_02")
		event_act_2.Set_Event_Parameter(0, scout_target_02)
	end
	if hutts_ziro_hunt_act_3 then
		local event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_03")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_2 = plot.Get_Event("Trigger_Hutts_Enter_Probe_Search_03")
		event_act_2.Set_Event_Parameter(0, scout_target_03)
	end
	if hutts_ziro_hunt_act_4 then
		local event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_04")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_04)

		event_act_2 = plot.Get_Event("Trigger_Hutts_Enter_Probe_Search_04")
		event_act_2.Set_Event_Parameter(0, scout_target_04)
	end
	if hutts_quest_ziro_hunt_over then
		local event_act_2 = plot.Get_Event("Hutts_RimwardCampaign_Act_II_Dialog_04")
		event_act_2.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_04)

		Story_Event("HUTTS_ZIRO_HUNT_END")
	end

	Sleep(5.0)
	if not hutts_quest_ziro_hunt_over then
		Create_Thread("State_Hutts_Quest_Checker_Ziro_Hunt")
	end
end

function State_Hutts_RimwardCampaign_Civil_War(message)
	if message == OnEnter then
		Story_Event("HUTTS_CIVIL_WAR_START")

		StoryUtil.SetPlanetRestricted("OBA_DIAH", 0)

		Create_Thread("State_Hutts_Quest_Checker_Civil_War")
	end
end
function State_Hutts_Quest_Checker_Civil_War()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Hutts.XML")

	local event_act_3 = plot.Get_Event("Hutts_RimwardCampaign_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
	event_act_3.Clear_Dialog_Text()

	local RimwardCampaign_PlanetList = {
		FindPlanet("Oba_Diah"),
		FindPlanet("Kessel"),
		FindPlanet("Barab"),
		FindPlanet("Sriluur"),
		FindPlanet("Ylesia"),
		FindPlanet("Gamorr"),
	}

	for _,p_planet in pairs(RimwardCampaign_PlanetList) do
		if p_planet.Get_Owner() ~= p_hutts then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		elseif p_planet.Get_Owner() == p_hutts then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end
	if FindPlanet("Oba_Diah").Get_Owner() == p_hutts 
	and FindPlanet("Kessel").Get_Owner() == p_hutts 
	and FindPlanet("Barab").Get_Owner() == p_hutts 
	and FindPlanet("Sriluur").Get_Owner() == p_hutts 
	and FindPlanet("Ylesia").Get_Owner() == p_hutts
	and FindPlanet("Gamorr").Get_Owner() == p_hutts then
		hutts_quest_civil_war_over = true
		Story_Event("HUTTS_CIVIL_WAR_END")
	end

	Sleep(5.0)
	if not hutts_quest_civil_war_over then
		Create_Thread("State_Hutts_Quest_Checker_Civil_War")
	end
end

function State_Hutts_RimwardCampaign_Reunion(message)
	if message == OnEnter then
		Story_Event("HUTTS_REUNION_START")

		Create_Thread("State_Hutts_Family_Reunion_Checker")
	end
end
function State_Hutts_Family_Reunion_Checker()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Hutts.XML")

	event_act_4 = plot.Get_Event("Hutts_RimwardCampaign_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
	event_act_4.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Jabba_The_Hutt")) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Jabba_The_Hutt_Team"))
		if TestValid(Find_First_Object("Jabba_The_Hutt").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Jabba_The_Hutt").Get_Planet_Location())
		end
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Tatooine"))
		event_act_4.Add_Dialog_Text("TEXT_NONE")

		event_act_4_task_01 = plot.Get_Event("Hutts_RimwardCampaign_Hero_Deploy_Tatooine")
		event_act_4_task_01.Set_Event_Parameter(0, Find_Object_Type("Jabba_The_Hutt_Team"))
	elseif not TestValid(Find_First_Object("Jabba_The_Hutt")) then
		StoryUtil.SpawnAtSafePlanet("NAL_HUTTA", p_hutts, StoryUtil.GetSafePlanetTable(), {"Jabba_The_Hutt_Team"})
	end

	Sleep(5.0)
	if not hutts_quest_reunion_over then
		Create_Thread("State_Hutts_Family_Reunion_Checker")
	end
end
function State_Hutts_RimwardCampaign_Hero_Deploy_Tatooine(message)
	if message == OnEnter then
		hutts_quest_reunion_over = true

		Story_Event("HUTTS_REUNION_END")
	end
end

function State_Hutts_RimwardCampaign_Showdown(message)
	if message == OnEnter then
		Story_Event("HUTTS_SHOWDOWN_START")

		StoryUtil.SetPlanetRestricted("TETH", 0)

		ChangePlanetOwnerAndPopulate(FindPlanet("Teth"), p_independent_forces, 7500)
		Sleep(5.0)

		SpawnList({"Ziro_The_Hutt_Team","WLO5_Tank_Company","WLO5_Tank_Company","Hutt_Bantha_II_Skiff_Company","Hutt_Guard_Company","Hutt_Guard_Company"}, FindPlanet("Teth"), p_independent_forces, false, false)

		Create_Thread("State_Hutts_Quest_Checker_Showdown")
	end
end
function State_Hutts_Quest_Checker_Showdown()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsRimward\\Story_Sandbox_Rimward_Hutts.XML")

	local event_act_5 = plot.Get_Event("Hutts_RimwardCampaign_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_22_BBY_RimwardCampaign_Hutts")
	event_act_5.Clear_Dialog_Text()

	if FindPlanet("Teth").Get_Owner() ~= p_hutts then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Teth"))
	elseif FindPlanet("Teth").Get_Owner() == p_hutts then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Teth"))
		Story_Event("HUTTS_SHOWDOWN_END")
		
		p_hutts.Give_Money(10000)
		
		hutts_quest_showdown_over = true
	end

	Sleep(5.0)
	if not hutts_quest_showdown_over then
		Create_Thread("State_Hutts_Quest_Checker_Showdown")
	end
end

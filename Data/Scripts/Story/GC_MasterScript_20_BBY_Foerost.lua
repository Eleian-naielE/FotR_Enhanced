--****************************************************--
--****   Fall of the Republic: Foerost Campaign   ****--
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

function Definitions()
	--DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		-- Generic
		Trigger_Historical_GC_Choice_Prompt = State_Historical_GC_Choice_Prompt,

		-- CIS
		Trigger_CIS_Deploy_Heroes_Skako = State_CIS_Deploy_Heroes_Skako,

		Trigger_CIS_FoerostCampaign_Planet_Hunt = State_CIS_FoerostCampaign_Planet_Hunt,
		Trigger_CIS_FoerostCampaign_Ningo_Death = State_CIS_FoerostCampaign_Ningo_Death,

		Trigger_CIS_FoerostCampaign_Anaxes = State_CIS_FoerostCampaign_Anaxes,

		Trigger_CIS_FoerostCampaign_Tagge = State_CIS_FoerostCampaign_Tagge,
		Trigger_CIS_FoerostCampaign_Sanya_Death = State_CIS_FoerostCampaign_Sanya_Death,

		CIS_FoerostCampaign_GC_Progression = State_CIS_FoerostCampaign_GC_Progression,

		-- Republic
		Trigger_Rep_FoerostCampaign_Meeting = State_Rep_FoerostCampaign_Meeting,
		Trigger_Rep_Deploy_Heroes_Rendili = State_Rep_Deploy_Heroes_Meeting,

		Trigger_Rep_FoerostCampaign_Victor = State_Rep_FoerostCampaign_Victor,
		Trigger_Rep_FoerostCampaign_Victor_Research = State_Rep_FoerostCampaign_Victor_Research,

		Trigger_Rep_FoerostCampaign_Ningo_Hunt = State_Rep_FoerostCampaign_Ningo_Hunt,
		Rep_Trigger_Ningo_Death_Ningo_Hunt = State_Rep_Ningo_Death_Ningo_Hunt,

		Trigger_Rep_FoerostCampaign_Anaxes = State_Rep_FoerostCampaign_Anaxes,
		Rep_Anaxes_Annexation_Tactical_Epilogue = State_Rep_Anaxes_Annexation_Tactical_Epilogue,

		Trigger_Rep_FoerostCampaign_Gladiator = State_Rep_FoerostCampaign_Gladiator,
		Trigger_Rep_FoerostCampaign_Gladiator_Research = State_Rep_FoerostCampaign_Gladiator_Research,

		Trigger_Rep_FoerostCampaign_Tagge = State_Rep_FoerostCampaign_Tagge,

		Rep_FoerostCampaign_GC_Progression = State_Rep_FoerostCampaign_GC_Progression,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_sector_forces = Find_Player("Sector_Forces")

	BulwarkFleetList_Easy = {
		"Dua_Ningo_Unrepentant",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
	}
	BulwarkFleetList_Normal = {
		"Dua_Ningo_Unrepentant",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
	}
	BulwarkFleetList_Hard = {
		"Dua_Ningo_Unrepentant",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Bulwark_I",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell_Tender",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
		"Hardcell",
	}

	potential_targets = {}

	bulwark_fleet_unit_list = nil
	clysm_fleet_unit_list = nil

	RampageMoveDelayMin_Easy = 45
	RampageMoveDelayMin_Normal = 30
	RampageMoveDelayMin_Hard = 15

	RampageMoveDelayMax_Easy = 55
	RampageMoveDelayMax_Normal = 40
	RampageMoveDelayMax_Hard = 25

	all_planets_conquered = false

	cis_quest_skako_over = false
	cis_quest_planet_hunt_over = false
	cis_quest_anaxes_over = false
	cis_quest_tagge_over = false

	rep_quest_planet_hunt_over = false
	rep_quest_meeting_over = false
	rep_quest_victor_over = false
	rep_quest_ningo_hunt_over = false
	rep_quest_anaxes_over = false
	rep_quest_gladiator_over = false
	rep_quest_tagge_over = false

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("Foerost_CIS_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Foerost_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("Foerost_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Foerost_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Skakoan_Combat_Engineer_Company"))
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("Geonosian_Cruiser"))
		p_cis.Unlock_Tech(Find_Object_Type("Marauder_Cruiser"))
		p_cis.Unlock_Tech(Find_Object_Type("Bulwark_I"))
		p_cis.Unlock_Tech(Find_Object_Type("Techno_Union_Capital"))
		p_cis.Unlock_Tech(Find_Object_Type("Techno_Union_Office"))

		p_cis.Lock_Tech(Find_Object_Type("CIS_Capital"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		p_cis.Lock_Tech(Find_Object_Type("BX_Commando_Company"))
		p_cis.Lock_Tech(Find_Object_Type("Stimulus_IGBC"))
		p_cis.Lock_Tech(Find_Object_Type("Stimulus_Commerce"))
		p_cis.Lock_Tech(Find_Object_Type("Stimulus_TradeFed"))
		p_cis.Lock_Tech(Find_Object_Type("Stimulus_Techno"))
		p_cis.Lock_Tech(Find_Object_Type("Diamond_Frigate"))
		p_cis.Lock_Tech(Find_Object_Type("Munifex"))
		p_cis.Lock_Tech(Find_Object_Type("Rebel_Office"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Customs_Corvette"))

		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))
		p_republic.Lock_Tech(Find_Object_Type("CR90"))
		p_republic.Lock_Tech(Find_Object_Type("DP20"))

		p_republic.Lock_Tech(Find_Object_Type("Screed_Retire"))
		p_republic.Lock_Tech(Find_Object_Type("Dodonna_Retire"))
		p_republic.Lock_Tech(Find_Object_Type("Trachta_Retire"))

		GlobalValue.Set("B1_SKIN", 1)

		GlobalValue.Set("ROSTER_MAPPING_SRC", {"MUNIFICENT","C9979_CARRIER","CIS_STAP_COMPANY","CIS_AAT_COMPANY","CIS_MTT_COMPANY","CIS_MAF_COMPANY"})
		GlobalValue.Set("ROSTER_MAPPING_DEST", {"MUNIFICENT_SUBFACTION","C9979_CARRIER_SUBFACTION","STAP_COMPANY","AAT_COMPANY","MTT_COMPANY","MAF_COMPANY"})

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
			GlobalValue.Set("Foerost_CIS_Renown_Conquered", 0) -- 1 = AU Version; 0 = Canonical Version

			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")

			Story_Event("REP_INTRO_START")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
			GlobalValue.Set("Foerost_CIS_Renown_Conquered", 0) -- 1 = AU Version; 0 = Canonical Version
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_STORY" then
		Create_Thread("Generic_Story_Set_Up")
	end

	crossplot:publish("VENATOR_HEROES", "empty")
	crossplot:publish("VICTORY1_HEROES", "empty")
	crossplot:publish("CLONE_UPGRADES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["SLOT_ADJUST"] = -2,
				["LOCKIN"] = {"Trachta"},
			},
			["NAVY"] = {
				["SLOT_ADJUST"] = -2,
				["LOCKIN"] = {"Screed", "Dodonna"},
				["EXIT"] = {"Yularen","Coburn","Kilian","Screed","Dodonna","Dron","Dallin","Wieler","Dao","Grumby"},
			},
			["ARMY"] = {
				--this space intentionally left blank
			},
			["CLONE"] = {
				["EXIT"] = {"Bly","Cody","Rex","Gree_Clone"},
			},
			["COMMANDO"] = {
				["SLOT_ADJUST"] = -2,
				["EXIT"] = {"Alpha","Gregor"},
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = -3,
				["EXIT"] = {"Halcyon","Ahsoka","Barriss"},
			},
		})

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	StoryUtil.SpawnAtSafePlanet("EMPRESS_TETA", p_cis, StoryUtil.GetSafePlanetTable(), {"Dua_Ningo_Unrepentant","Bulwark_I","Bulwark_I"})
	StoryUtil.SpawnAtSafePlanet("SKAKO", p_cis, StoryUtil.GetSafePlanetTable(), {"Solenoid_CR90","Tendir_Blue_Team"})
	StoryUtil.SafeSpawnFavourHero("SKAKO", p_cis, {"Treetor_Captor","Tambor_Team"})

	StoryUtil.SpawnAtSafePlanet("ALSAKAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Trachta_Venator","Gentis_Team","Armand_Isard_Team"})
	StoryUtil.SpawnAtSafePlanet("RENDILI", p_republic, StoryUtil.GetSafePlanetTable(), {"Dodonna_Ardent","Screed_Arlionne","Victory_I_Fleet_Star_Destroyer","Victory_I_Fleet_Star_Destroyer"})

	p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Fleet_Star_Destroyer"))
	p_republic.Unlock_Tech(Find_Object_Type("Gladiator_I"))
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	StoryUtil.RevealPlanet("ANAXES", false)
	StoryUtil.RevealPlanet("RENDILI", false)

	StoryUtil.SetPlanetRestricted("ANAXES", 1, false)
	StoryUtil.SetPlanetRestricted("TEPASI", 1, false)

	StoryUtil.SpawnAtSafePlanet("FOEROST", p_cis, StoryUtil.GetSafePlanetTable(), {"Dua_Ningo_Unrepentant"})
	StoryUtil.SpawnAtSafePlanet("SKAKO", p_cis, StoryUtil.GetSafePlanetTable(), {"Solenoid_CR90","Tendir_Blue_Team"})
	StoryUtil.SafeSpawnFavourHero("SKAKO", p_cis, {"Treetor_Captor","Tambor_Team"})

	StoryUtil.SpawnAtSafePlanet("ALSAKAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Trachta_Venator","Gentis_Team","Armand_Isard_Team"})
	StoryUtil.SpawnAtSafePlanet("RENDILI", p_republic, StoryUtil.GetSafePlanetTable(), {
		"Dodonna_Ardent","Screed_Arlionne","Bengila_Urlan_Team",
		"Victory_I_Fleet_Star_Destroyer","Victory_I_Fleet_Star_Destroyer","Victory_I_Fleet_Star_Destroyer", "Victory_I_Fleet_Star_Destroyer","Victory_I_Fleet_Star_Destroyer","Victory_I_Fleet_Star_Destroyer"}
	)
	--StoryUtil.SpawnAtSafePlanet("ODIK", p_republic, StoryUtil.GetSafePlanetTable(), {"Cinzero_Gann_Team"})

	SpawnList({"Invincible_Cruiser", "Invincible_Cruiser", "Invincible_Cruiser"}, FindPlanet("Alsakan"), p_republic, false, false)

	p_republic.Unlock_Tech(Find_Object_Type("Gladiator_I"))
	p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Fleet_Star_Destroyer"))

	Create_Thread("State_CIS_Quest_Checker_Skako")
end

function State_CIS_Quest_Checker_Skako()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_CIS.XML")

	if TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) and TestValid(Find_First_Object("Wat_Tambor")) then
		local event_act_1 = plot.Get_Event("CIS_FoerostCampaign_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_20_BBY_FoerostCampaign_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Dua_Ningo_Unrepentant"))
		if TestValid(Find_First_Object("Dua_Ningo_Unrepentant").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Dua_Ningo_Unrepentant").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Skako"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Wat_Tambor"))
		if TestValid(Find_First_Object("Wat_Tambor").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Wat_Tambor").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Skako"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("Trigger_CIS_Enter_Ningo_Skako")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Dua_Ningo_Unrepentant"))

		local event_act_1_task_02 = plot.Get_Event("Trigger_CIS_Deploy_Tambor_Skako")
		event_act_1_task_02.Set_Event_Parameter(0, Find_Object_Type("Wat_Tambor"))

	else
		Sleep(5.0)
		Story_Event("CIS_SKAKO_CHEAT")
	end

	Sleep(5.0)
	if not cis_quest_skako_over then
		Create_Thread("State_CIS_Quest_Checker_Skako")
	end
end
function State_CIS_Deploy_Heroes_Skako(message)
	if message == OnEnter then
		cis_quest_skako_over = true

		Story_Event("CIS_SKAKO_END")
	end
end

function State_CIS_FoerostCampaign_Planet_Hunt(message)
	if message == OnEnter then
		Story_Event("CIS_PLANET_HUNT_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("ALSAKAN", "GUI_Flash_Alsakan")
		MissionUtil.PositionCamera("ALSAKAN")

		if not cis_quest_planet_hunt_over then
			Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
		end
	end
end
function State_CIS_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_CIS.XML")

	local FoerostCampaign_PlanetList = {
		FindPlanet("Alsakan"),
		FindPlanet("Basilisk"),
		FindPlanet("Ixtlar"),
		FindPlanet("Rendili"),
	}

	local event_act_2 = plot.Get_Event("CIS_FoerostCampaign_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_20_BBY_FoerostCampaign_CIS")
	event_act_2.Clear_Dialog_Text()

	for _,p_planet in pairs(FoerostCampaign_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			if p_planet.Get_Planet_Location() == FindPlanet("Rendili") then
				event_act_2.Add_Dialog_Text("TEXT_STORY_FOEROST_CAMPAIGN_CIS_LOCATION_RENDILI", p_planet)
			else
				event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_cis then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Alsakan").Get_Owner() == p_cis 
	and FindPlanet("Basilisk").Get_Owner() == p_cis 
	and FindPlanet("Ixtlar").Get_Owner() == p_cis 
	and FindPlanet("Rendili").Get_Owner() == p_cis then
		cis_quest_planet_hunt_over = true
		Story_Event("CIS_PLANET_HUNT_END")

	end

	Sleep(5.0)
	if not cis_quest_planet_hunt_over then
		Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	end
end

function State_CIS_FoerostCampaign_Anaxes(message)
	if message == OnEnter then
		Story_Event("CIS_ANAXES_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("ANAXES", "GUI_Flash_Anaxes")
		MissionUtil.PositionCamera("ANAXES")

		if not cis_quest_anaxes_over then
			Create_Thread("State_CIS_Quest_Checker_Anaxes")
		end
	end
end
function State_CIS_Quest_Checker_Anaxes()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_CIS.XML")

	local event_act_3 = plot.Get_Event("CIS_FoerostCampaign_Act_II_Dialog")
	event_act_3.Set_Dialog("Dialog_20_BBY_FoerostCampaign_CIS")
	event_act_3.Clear_Dialog_Text()
	if FindPlanet("Anaxes").Get_Owner() ~= p_cis then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Anaxes"))
	else
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Anaxes"))

		StoryUtil.SetPlanetRestricted("ANAXES", 0)

		Story_Event("CIS_ANAXES_END")
		cis_quest_anaxes_over = true
	end

	local planet_list_factional = StoryUtil.GetFactionalPlanetList(p_republic)
	if table.getn(planet_list_factional) == 0 then
		if not all_planets_conquered then
			all_planets_conquered = true
			if TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) then
				StoryUtil.LoadCampaign("Sandbox_AU_3_OuterRimSieges_CIS", 0)
			elseif not TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) then
				StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
			end
		end
	end

	Sleep(5.0)
	if not cis_quest_anaxes_over then
		Create_Thread("State_CIS_Quest_Checker_Anaxes")
	end
end

function State_CIS_FoerostCampaign_Ningo_Death(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("ANAXES", 0)

		Story_Event("CIS_ANAXES_END")
		cis_quest_anaxes_over = true
	end
end

function State_CIS_FoerostCampaign_Tagge(message)
	if message == OnEnter then
		Story_Event("CIS_TAGGE_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("TEPASI", "GUI_Flash_Tepasi")
		MissionUtil.PositionCamera("TEPASI")

		if not cis_quest_tagge_over then
			Create_Thread("State_CIS_Quest_Checker_Tagge")
		end
	end
end
function State_CIS_Quest_Checker_Tagge()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_CIS.XML")

	local event_act_4 = plot.Get_Event("CIS_FoerostCampaign_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_20_BBY_FoerostCampaign_CIS")
	event_act_4.Clear_Dialog_Text()

	event_act_4.Add_Dialog_Text("Target: Sanya Tagge / Tagge Battlecruiser, House of Tagge")
	if StoryUtil.GetDifficulty() == "EASY" then
		if TestValid(Find_First_Object("Sanya_Tagge_Battlecruiser")) then
			if TestValid(Find_First_Object("Sanya_Tagge_Battlecruiser").Get_Planet_Location()) then
				event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Sanya_Tagge_Battlecruiser").Get_Planet_Location())
			end
		end
	end

	event_act_4.Add_Dialog_Text("TEXT_NONE")

	Sleep(5.0)
	if not cis_quest_tagge_over then
		Create_Thread("State_CIS_Quest_Checker_Tagge")
	end
end
function State_CIS_FoerostCampaign_Sanya_Death(message)
	if message == OnEnter then
		StoryUtil.SpawnAtSafePlanet("FOEROST", p_cis, StoryUtil.GetSafePlanetTable(), {"Calli_Trilm_Bulwark"})

		StoryUtil.SetPlanetRestricted("TEPASI", 0)

		Story_Event("CIS_TAGGE_END")
		cis_quest_tagge_over = true
	end
end

function State_CIS_FoerostCampaign_GC_Progression(message)
	if message == OnEnter then
		if TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) then
			StoryUtil.LoadCampaign("Sandbox_AU_3_OuterRimSieges_CIS", 0)
		elseif not TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) then
			StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
		end
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	StoryUtil.RevealPlanet("FOEROST", false)
	StoryUtil.RevealPlanet("KAIKIELIUS", false)

	StoryUtil.SetPlanetRestricted("TEPASI", 1, false)
	StoryUtil.SetPlanetRestricted("FOEROST", 1, false)

	StoryUtil.SpawnAtSafePlanet("SKAKO", p_cis, StoryUtil.GetSafePlanetTable(), {"Solenoid_CR90","Tendir_Blue_Team"})
	StoryUtil.SafeSpawnFavourHero("SKAKO", p_cis, {"Treetor_Captor","Tambor_Team"})

	StoryUtil.SpawnAtSafePlanet("ALSAKAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Trachta_Venator","Gentis_Team"})
	StoryUtil.SpawnAtSafePlanet("SARAPIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Bengila_Urlan_Team"})
	--StoryUtil.SpawnAtSafePlanet("ODIK", p_republic, StoryUtil.GetSafePlanetTable(), {"Cinzero_Gann_Team"})

	if (GlobalValue.Get("Foerost_Rep_GC_Version") == 1) then
		p_republic.Unlock_Tech(Find_Object_Type("Lancer_Frigate_Prototype"))
	end

	Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
end
function State_Rep_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

	local FoerostCampaign_PlanetList = {
		FindPlanet("Alderaan"),
		FindPlanet("Anaxes"),
		FindPlanet("Alsakan"),
		FindPlanet("Carida"),
		FindPlanet("Rendili"),
	}

	local event_act_1 = plot.Get_Event("Rep_FoerostCampaign_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(FoerostCampaign_PlanetList) do
		if p_planet.Get_Owner() == p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_PROTECTION_REPUBLIC", p_planet)
		elseif p_planet.Get_Owner() == p_sector_forces then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_PROTECTION_SECTOR_FORCES", p_planet)
		else
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_PROTECTION_NONE", p_planet)
		end
	end

	if FindPlanet("Alderaan").Get_Owner() == p_republic 
	and FindPlanet("Anaxes").Get_Owner() == p_republic 
	and FindPlanet("Alsakan").Get_Owner() == p_republic 
	and FindPlanet("Carida").Get_Owner() == p_republic 
	and FindPlanet("Rendili").Get_Owner() == p_republic then
		rep_quest_planet_hunt_over = true
		Story_Event("REP_PLANET_HUNT_END")
	end

	Sleep(5.0)
	if not rep_quest_planet_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
	end
end

function State_Rep_FoerostCampaign_Meeting(message)
	if message == OnEnter then
		Story_Event("REP_MEETING_START")
		StoryUtil.SpawnAtSafePlanet("CARIDA", p_republic, StoryUtil.GetSafePlanetTable(), {"Armand_Isard_Team"})
		Sleep(5.0)

		MissionUtil.FlashPlanet("RENDILI", "GUI_Flash_Rendili")
		MissionUtil.PositionCamera("RENDILI")

		if not rep_quest_meeting_over then
			Create_Thread("State_Rep_Quest_Checker_Meeting")
		end
	end
end
function State_Rep_Quest_Checker_Meeting()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

	if TestValid(Find_First_Object("Armand_Isard")) and TestValid(Find_First_Object("Bengila_Urlan")) then
		local event_act_2 = plot.Get_Event("Rep_FoerostCampaign_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Armand_Isard"))
		if TestValid(Find_First_Object("Armand_Isard").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Armand_Isard").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rendili"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Bengila_Urlan"))
		if TestValid(Find_First_Object("Bengila_Urlan").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Bengila_Urlan").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rendili"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Trigger_Rep_Deploy_Isard_Rendili")
		event_act_2_task_01.Set_Event_Parameter(0, Find_Object_Type("Armand_Isard"))

		local event_act_2_task_02 = plot.Get_Event("Trigger_Rep_Deploy_Urlan_Rendili")
		event_act_2_task_02.Set_Event_Parameter(0, Find_Object_Type("Bengila_Urlan"))

	else
		Sleep(5.0)
		Story_Event("REP_MEETING_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_meeting_over then
		Create_Thread("State_Rep_Quest_Checker_Meeting")
	end
end
function State_Rep_Deploy_Heroes_Meeting(message)
	if message == OnEnter then
		rep_quest_meeting_over = true

		Story_Event("REP_MEETING_END")
	end
end

function State_Rep_FoerostCampaign_Victor(message)
	if message == OnEnter then
		Story_Event("REP_VICTOR_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_FoerostCampaign_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Victory1_FoerostCampaign"))
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rendili"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Victory1_FoerostCampaign"))
	end
end
function State_Rep_FoerostCampaign_Victor_Research(message)
	if message == OnEnter then
		rep_quest_victor_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_FoerostCampaign_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Victory1_FoerostCampaign"))

		StoryUtil.SpawnAtSafePlanet("RENDILI", p_republic, StoryUtil.GetSafePlanetTable(), {"Screed_Arlionne","Dodonna_Ardent","Victory_I_Fleet_Star_Destroyer"})

		p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Fleet_Star_Destroyer"))

		UnitUtil.DespawnList({"Dummy_Research_Victory1_FoerostCampaign"})

		Story_Event("REP_VICTOR_END")

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_Rep_FoerostCampaign_Ningo_Hunt(message)
	if message == OnEnter then
		Story_Event("REP_NINGO_HUNT_START")

		StoryUtil.SetPlanetRestricted("FOEROST", 0)

		if StoryUtil.GetDifficulty() == "EASY" then
			BulwarkFleetList = SpawnList(BulwarkFleetList_Easy, FindPlanet("Foerost"), p_cis, false, false)
			player_bulwark_fleet = Assemble_Fleet(BulwarkFleetList)
		end
		if StoryUtil.GetDifficulty() == "NORMAL" then
			BulwarkFleetList = SpawnList(BulwarkFleetList_Normal, FindPlanet("Foerost"), p_cis, false, false)
			player_bulwark_fleet = Assemble_Fleet(BulwarkFleetList)
		end
		if StoryUtil.GetDifficulty() == "HARD" then
			BulwarkFleetList = SpawnList(BulwarkFleetList_Hard, FindPlanet("Foerost"), p_cis, false, false)
			player_bulwark_fleet = Assemble_Fleet(BulwarkFleetList)
		end

		Register_Timer(State_Rep_Quest_Checker_Bulwark_Rampage, 60)
		Create_Thread("State_Rep_Quest_Checker_Ningo_Hunt")
	end
end
function State_Rep_Quest_Checker_Ningo_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

	local event_act_4 = plot.Get_Event("Rep_FoerostCampaign_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
	event_act_4.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Dua_Ningo_Unrepentant")) then
		event_act_4.Add_Dialog_Text("Target: Dua Ningo / Bulwark-I Cruiser, Unrepentant")
		if TestValid(Find_First_Object("Dua_Ningo_Unrepentant").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Dua_Ningo_Unrepentant").Get_Planet_Location())
		end
	else
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Dua_Ningo_Unrepentant"))
	end

	event_act_4.Add_Dialog_Text("TEXT_NONE")

	Sleep(1.0)
	if not rep_quest_ningo_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Ningo_Hunt")
	end
end
function State_Rep_Quest_Checker_Bulwark_Rampage()
	if TestValid(player_bulwark_fleet) then
		local potential_targets = FindPlanet.Get_All_Planets()
		target_planet = nil
		attack_gambit = nil
		local attack_gambit = GameRandom.Free_Random(1, 5)
		if attack_gambit == 1 then
			while not target_planet do
				local length = table.getn(potential_targets)
				if length > 0 then
					local index = GameRandom(1, table.getn(potential_targets))
					local potential_target = potential_targets[index]

					if potential_target.Get_Owner() == p_republic then
						if EvaluatePerception("Is_Neglected_By_My_Opponent_Space", p_cis, potential_target) then
							target_planet = potential_target
						end
					end
					table.remove(potential_targets, index)
				else 
					break
				end
			end
		elseif attack_gambit >= 2 then
			while not target_planet do
				local length = table.getn(potential_targets)
				if length > 0 then
					local index = GameRandom(1, table.getn(potential_targets))
					local potential_target = potential_targets[index]

					if potential_target.Get_Owner() == p_cis then
						target_planet = potential_target
					end
					table.remove(potential_targets, index)
				else 
					break
				end
			end
		end
		local current_planet = player_bulwark_fleet.Get_Parent_Object()
		if not current_planet then
			Sleep(5.0)
		else
			local to_grow_or_not = GameRandom.Free_Random(1, 3)
			if current_planet.Get_Owner() == p_cis then
				growing_list = {"Bulwark_I", "Bulwark_I", "Marauder_Cruiser", "Marauder_Cruiser", "Hardcell", "Hardcell", "Hardcell"}
				to_grow_or_not = 1
			end
			if to_grow_or_not == 1 then
				growing_list = {"Bulwark_I", "Munificent", "Munificent", "Munificent", "Munificent", "Hardcell", "Hardcell", "Hardcell_Tender"}
				to_grow_or_not = 1
			elseif to_grow_or_not == 2 then
				growing_list = {"Bulwark_I", "Bulwark_I", "Bulwark_I", "Hardcell", "Hardcell",  "Hardcell_Tender", "Hardcell_Tender"}
				to_grow_or_not = 1
			elseif to_grow_or_not == 3 then
				growing_list = {"Bulwark_I", "Bulwark_I", "Bulwark_I", "Bulwark_I", "Marauder_Cruiser", "Marauder_Cruiser", "Hardcell",  "Hardcell"}
				to_grow_or_not = 1
			end
				local bulwark_fleet_followers = SpawnList(growing_list, current_planet, p_cis, true, false)
			bulwark_fleet_path = Find_Path(p_cis, current_planet, target_planet)
			if bulwark_fleet_path then
				bulwark_commander = Find_First_Object("Dua_Ningo_Unrepentant")
				if TestValid(bulwark_commander) then
					player_bulwark_fleet = bulwark_commander.Get_Parent_Object()
					BlockOnCommand(player_bulwark_fleet.Move_To(target_planet))
					bulwark_commander = Find_First_Object("Dua_Ningo_Unrepentant")
					bulwark_commander.Set_Check_Contested_Space(true)
				end
			end
		end
		if not rep_quest_ningo_hunt_over then
			if StoryUtil.GetDifficulty() == "EASY" then
				Register_Timer(State_Rep_Quest_Checker_Bulwark_Rampage, GameRandom.Free_Random(RampageMoveDelayMin_Easy, RampageMoveDelayMax_Easy))
			end
			if StoryUtil.GetDifficulty() == "NORMAL" then
				Register_Timer(State_Rep_Quest_Checker_Bulwark_Rampage, GameRandom.Free_Random(RampageMoveDelayMin_Normal, RampageMoveDelayMax_Normal))
			end
			if StoryUtil.GetDifficulty() == "HARD" then
				Register_Timer(State_Rep_Quest_Checker_Bulwark_Rampage, GameRandom.Free_Random(RampageMoveDelayMin_Hard, RampageMoveDelayMax_Hard))
			end
		end
	end
end
function State_Rep_Ningo_Death_Ningo_Hunt(message)
	if message == OnEnter then
		rep_quest_ningo_hunt_over = true

		Story_Event("REP_NINGO_HUNT_END")
	end
end

function State_Rep_FoerostCampaign_Anaxes(message)
	if message == OnEnter then
		Story_Event("REP_ANAXES_START")

		Create_Thread("State_Rep_Quest_Checker_Anaxes")
	end
end
function State_Rep_Quest_Checker_Anaxes()
	plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

	event_act_5 = plot.Get_Event("Rep_FoerostCampaign_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
	event_act_5.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Screed_Arlionne")) and TestValid(Find_First_Object("Dodonna_Ardent")) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Screed_Arlionne"))
		if TestValid(Find_First_Object("Screed_Arlionne").Get_Planet_Location()) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Screed_Arlionne").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Anaxes"))
		event_act_5.Add_Dialog_Text("TEXT_NONE")

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Dodonna_Ardent"))
		if TestValid(Find_First_Object("Dodonna_Ardent").Get_Planet_Location()) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Dodonna_Ardent").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Anaxes"))

	elseif not TestValid(Find_First_Object("Screed_Arlionne")) and TestValid(Find_First_Object("Dodonna_Ardent")) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Dodonna_Ardent"))
		if TestValid(Find_First_Object("Dodonna_Ardent").Get_Planet_Location()) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Dodonna_Ardent").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Anaxes"))

	elseif TestValid(Find_First_Object("Screed_Arlionne")) and not TestValid(Find_First_Object("Dodonna_Ardent")) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Screed_Arlionne"))
		if TestValid(Find_First_Object("Screed_Arlionne").Get_Planet_Location()) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Screed_Arlionne").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Anaxes"))

	elseif not TestValid(Find_First_Object("Screed_Arlionne")) and not TestValid(Find_First_Object("Dodonna_Ardent")) then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Victory_I_Fleet_Star_Destroyer"))
		if TestValid(Find_First_Object("Victory_I_Fleet_Star_Destroyer")) then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Victory_I_Fleet_Star_Destroyer").Get_Planet_Location())
		end
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Anaxes"))

	end

	if TestValid(Find_First_Object("Screed_Arlionne")) and TestValid(Find_First_Object("Dodonna_Ardent")) then
		if Find_First_Object("Screed_Arlionne").Get_Planet_Location() == FindPlanet("Anaxes")
		and Find_First_Object("Dodonna_Ardent").Get_Planet_Location() == FindPlanet("Anaxes") then
			Story_Event("REP_ANAXES_TACTICAL")
		end

	elseif not TestValid(Find_First_Object("Screed_Arlionne")) and TestValid(Find_First_Object("Dodonna_Ardent")) then
		if Find_First_Object("Dodonna_Ardent").Get_Planet_Location() == FindPlanet("Anaxes") then
			Story_Event("REP_ANAXES_TACTICAL")
		end

	elseif TestValid(Find_First_Object("Screed_Arlionne")) and not TestValid(Find_First_Object("Dodonna_Ardent")) then
		if Find_First_Object("Screed_Arlionne").Get_Planet_Location() == FindPlanet("Anaxes") then
			Story_Event("REP_ANAXES_TACTICAL")
		end

	elseif not TestValid(Find_First_Object("Screed_Arlionne")) and not TestValid(Find_First_Object("Dodonna_Ardent")) then
		if Find_First_Object("Victory_I_Fleet_Star_Destroyer").Get_Planet_Location() == FindPlanet("Anaxes") then
			Story_Event("REP_ANAXES_TACTICAL")
		end

	end

	if not rep_quest_anaxes_over then
		Sleep(5.0)
		Create_Thread("State_Rep_Quest_Checker_Anaxes")
	end
end
function State_Rep_Anaxes_Annexation_Tactical_Epilogue(message)
	if message == OnEnter then
		rep_quest_anaxes_over = true

		Story_Event("REP_ANAXES_END")

		StoryUtil.SetPlanetRestricted("ANAXES", 0)

		if TestValid(Find_First_Object("Screed_Arlionne")) then
			UnitUtil.DespawnList({"Screed_Arlionne"})
			StoryUtil.SpawnAtSafePlanet("ANAXES", p_republic, StoryUtil.GetSafePlanetTable(), {"Screed_Demolisher"})
		end

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_Rep_FoerostCampaign_Gladiator(message)
	if message == OnEnter then
		Story_Event("REP_GLADIATOR_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_FoerostCampaign_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Gladiator"))
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Rendili"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Gladiator"))
	end
end
function State_Rep_FoerostCampaign_Gladiator_Research(message)
	if message == OnEnter then
		rep_quest_gladiator_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_FoerostCampaign_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Gladiator"))

		StoryUtil.SpawnAtSafePlanet("RENDILI", p_republic, StoryUtil.GetSafePlanetTable(), {"Gladiator_I","Gladiator_I","Gladiator_I"})

		p_republic.Unlock_Tech(Find_Object_Type("Gladiator_I"))

		UnitUtil.DespawnList({"Dummy_Research_Gladiator"})

		Story_Event("REP_GLADIATOR_END")
	end
end

function State_Rep_FoerostCampaign_Tagge(message)
	if message == OnEnter then
		Story_Event("REP_TAGGE_START")
		StoryUtil.SetPlanetRestricted("TEPASI", 0)
		Sleep(1.0)

		ChangePlanetOwnerAndPopulate(FindPlanet("Tepasi"), p_cis, 7500)
		Sleep(5.0)

		if not rep_quest_tagge_over then
			Create_Thread("State_Rep_Quest_Checker_Tagge")
		end
	end
end
function State_Rep_Quest_Checker_Tagge()
	local plot = Get_Story_Plot("Conquests\\Historical\\20_BBY_CloneWarsFoerost\\Story_Sandbox_Foerost_Republic.XML")

	local event_act_7 = plot.Get_Event("Rep_FoerostCampaign_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_20_BBY_FoerostCampaign_Rep")
	event_act_7.Clear_Dialog_Text()
	if FindPlanet("Tepasi").Get_Owner() ~= p_republic then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Tepasi"))
	else
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Tepasi"))
		Story_Event("REP_TAGGE_END")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("TEPASI", p_republic, StoryUtil.GetSafePlanetTable(), {"Orman_Tagge_Battlecruiser"})
		rep_quest_tagge_over = true
	end

	Sleep(5.0)
	if not rep_quest_tagge_over then
		Create_Thread("State_Rep_Quest_Checker_Tagge")
	end
end

function State_Rep_FoerostCampaign_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.LoadCampaign("Sandbox_AU_1_OuterRimSieges_Republic", 1)
	end
end

--****************************************************--
--**   Fall of the Republic: Tennuutta Skirmishes   **--
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
		CIS_Venator_Venture_Epilogue = State_CIS_Venator_Venture_Epilogue,

		Trigger_CIS_TennuuttaSkirmishes_Defoliator = State_CIS_TennuuttaSkirmishes_Defoliator,
		CIS_Maridun_Marauder_Epilogue = State_CIS_Maridun_Marauder_Epilogue,

		Trigger_CIS_TennuuttaSkirmishes_Citadel = State_CIS_TennuuttaSkirmishes_Citadel,
		Trigger_CIS_TennuuttaSkirmishes_Citadel_Contruction = State_CIS_TennuuttaSkirmishes_Citadel_Construction,

		Trigger_CIS_TennuuttaSkirmishes_Nexus = State_CIS_TennuuttaSkirmishes_Nexus,
		Trigger_CIS_Piell_Death_Nexus = State_CIS_Piell_Death_Nexus,

		Trigger_CIS_TennuuttaSkirmishes_Handooine = State_CIS_TennuuttaSkirmishes_Handooine,
		Trigger_CIS_Scout_Enter_Handooine = State_CIS_Scout_Enter_Handooine,

		CIS_TennuuttaSkirmishes_GC_Progression = State_CIS_TennuuttaSkirmishes_GC_Progression,

		-- Republic
		Rep_Venator_Venture_Epilogue = State_Rep_Venator_Venture_Epilogue,

		Trigger_Rep_TennuuttaSkirmishes_Jedi_Search = State_Rep_TennuuttaSkirmishes_Jedi_Search,
		Trigger_Rep_TennuuttaSkirmishes_Jedi_Found = State_Rep_TennuuttaSkirmishes_Jedi_Found,
		Rep_Maridun_Marauder_Epilogue = State_Rep_Maridun_Marauder_Epilogue,

		Trigger_Rep_TennuuttaSkirmishes_Meeting = State_Rep_TennuuttaSkirmishes_Meeting,
		Rep_Republic_Naval_Command_Centre_Research = State_Rep_TennuuttaSkirmishes_Meeting_Research,

		Rep_TennuuttaSkirmishes_GC_Progression = State_Rep_TennuuttaSkirmishes_GC_Progression,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_neutral = Find_Player("Neutral")
	p_cg = Find_Player("Commerce_Guild")
	p_tu = Find_Player("Techno_Union")
	p_tf = Find_Player("Trade_Federation")

	all_planets_conquered = false

	rep_jedi_search_act_1 = false
	rep_jedi_search_act_2 = false
	rep_jedi_search_act_3 = false
	rep_jedi_search_act_4 = false

	rep_quest_planet_hunt_over = false
	rep_quest_jedi_search_over = false
	rep_quest_jedi_found_over = false
	rep_quest_meeting_over = false

	cis_defoliator_act_1 = false
	cis_defoliator_act_2 = false
	cis_defoliator_act_3 = false

	cis_quest_planet_hunt_over = false
	cis_quest_defoliator_over = false
	cis_quest_citadel_over = false
	cis_quest_nexus_over = false
	cis_quest_handooine_over = false

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("Tennuutta_CIS_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Tennuutta_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("Tennuutta_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("Tennuutta_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("Recusant_Dreadnought"))
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Dreadnought"))
		p_cis.Unlock_Tech(Find_Object_Type("CIS_Sector_Capital"))

		p_cis.Lock_Tech(Find_Object_Type("Providence_Destroyer"))
		p_cis.Lock_Tech(Find_Object_Type("CIS_Capital"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Naval_Command_Centre"))
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))

		p_republic.Lock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Lock_Tech(Find_Object_Type("Invincible_Cruiser"))
		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))

		p_republic.Lock_Tech(Find_Object_Type("Rom_Mohc_Retire"))
		p_republic.Lock_Tech(Find_Object_Type("Yularen_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Aayla_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Ahsoka_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Bly_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Rex_Assign"))

		GlobalValue.Set("CURRENT_CLONE_PHASE", 1)

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
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_STORY" then
		Create_Thread("Generic_Story_Set_Up")
	end

	crossplot:publish("VENATOR_HEROES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["SLOT_ADJUST"] = -2,
			},
			["NAVY"] = {
				["SLOT_ADJUST"] = -2,
				["LOCKIN"] = {"Pellaeon"},
				["EXIT"] = {"Kilian","Yularen","Maarisa","Baraka","Grumby","Autem","Martz","Dallin","Dao"},
			},
			["ARMY"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Rom","Solomahal"},
				["EXIT"] = {"Jayfon","Gentis","Kligson"},
			},
			["CLONE"] = {
				["RETURN"] = {"Jet"},
				["EXIT"] = {"Bly","Cody","Rex","Gree_Clone","Bacara","71","Neyo"},
			},
			["COMMANDO"] = {
				["SLOT_ADJUST"] = -1,
				["EXIT"] = {"Alpha","Gregor"},
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = -3,
				["EXIT"] = {"Aayla","Ahsoka","Kit","Mace","Shaak","Yoda","Halcyon", },
			},
		})

	Clear_Fighter_Hero("AXE_BLUE_SQUADRON")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	p_cis.Unlock_Tech(Find_Object_Type("CIS_Defoliator_Company"))
	p_republic.Unlock_Tech(Find_Object_Type("Republic_Naval_Command_Centre"))

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"Zolghast_Team"})
	StoryUtil.SpawnAtSafePlanet("QUELL", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	StoryUtil.SpawnAtSafePlanet("LOLA_SAYU", p_cis, StoryUtil.GetSafePlanetTable(), {"Osi_Sobeck_Team", "K2B4_Providence"})

	StoryUtil.SpawnAtSafePlanet("AZURE", p_republic, StoryUtil.GetSafePlanetTable(), {"Renau_Acclamator","Solomahal_Team"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kreuge_Gibbon"})
	StoryUtil.SpawnAtSafePlanet("MENDIG", p_republic, StoryUtil.GetSafePlanetTable(), {"Rom_Mohc_Team"})
	StoryUtil.SpawnAtSafePlanet("GAVRYN", p_republic, StoryUtil.GetSafePlanetTable(), {"Pellaeon_Leveler"})
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	StoryUtil.RevealPlanet("MARIDUN", false)
	StoryUtil.RevealPlanet("HANDOOINE", false)

	StoryUtil.SetPlanetRestricted("MARIDUN", 1, false)

	ChangePlanetOwnerAndRetreat(FindPlanet("Maridun"), p_neutral)

	p_republic.Unlock_Tech(Find_Object_Type("Republic_Naval_Command_Centre"))

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"Zolghast_Team"})
	StoryUtil.SpawnAtSafePlanet("LOLA_SAYU", p_cis, StoryUtil.GetSafePlanetTable(), {"K2B4_Providence"})
	StoryUtil.SafeSpawnFavourHero("LOLA_SAYU", p_cis, {"Lok_Durd_Defoliator_Team"})

	StoryUtil.SpawnAtSafePlanet("AZURE", p_republic, StoryUtil.GetSafePlanetTable(), {"Renau_Acclamator","Solomahal_Team"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kreuge_Gibbon"})
	StoryUtil.SpawnAtSafePlanet("MENDIG", p_republic, StoryUtil.GetSafePlanetTable(), {"Rom_Mohc_Team"})
	StoryUtil.SpawnAtSafePlanet("GAVRYN", p_republic, StoryUtil.GetSafePlanetTable(), {"Pellaeon_Leveler"})

	Sleep(1.0)

	UnitUtil.DespawnList({"Lok_Durd_Defoliator"})

	Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
end
function State_CIS_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")

	local TennuuttaSkirmishes_PlanetList = {
		FindPlanet("Azure"),
		FindPlanet("Lianna"),
		FindPlanet("Gavryn"),
		FindPlanet("Handooine"),
		FindPlanet("Roche"),
	}

	event_act_1 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(TennuuttaSkirmishes_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			if p_planet.Get_Planet_Location() == FindPlanet("Handooine") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_TENNUUTTA_SKIRMISHES_CIS_LOCATION_HANDOOINE", p_planet)
			else
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_cis then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end
	if FindPlanet("Azure").Get_Owner() == p_cis
	and FindPlanet("Lianna").Get_Owner() == p_cis
	and FindPlanet("Gavryn").Get_Owner() == p_cis
	and FindPlanet("Handooine").Get_Owner() == p_cis
	and FindPlanet("Roche").Get_Owner() == p_cis then
		cis_quest_planet_hunt_over = true
		Story_Event("CIS_PLANET_HUNT_END")

		local planet_list_factional_rep = StoryUtil.GetFactionalPlanetList(p_republic)
		if table.getn(planet_list_factional_rep) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if (GlobalValue.Get("Tennuutta_CIS_GC_Version") == 0) then
					StoryUtil.LoadCampaign("Sandbox_DurgesLance_CIS", 0)
				else
					StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_CIS", 0)
				end
			end
		end
	end

	Sleep(5.0)
	if not cis_quest_planet_hunt_over then
		Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	end
end

function State_CIS_Venator_Venture_Epilogue(message)
	if message == OnEnter then
		ChangePlanetOwnerAndRetreat(FindPlanet("Quell"), p_cis)

		StoryUtil.SpawnAtSafePlanet("QUELL", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
	end
end

function State_CIS_TennuuttaSkirmishes_Defoliator(message)
	if message == OnEnter then
		Story_Event("CIS_DEFOLIATOR_START")

		StoryUtil.SpawnAtSafePlanet("SALVARA", p_cis, StoryUtil.GetSafePlanetTable(), {"Lok_Durd_Team"})

		scout_target_01 = FindPlanet("Vorzyd")

		cis_defoliator_act_1 = true

		if not cis_quest_defoliator_over then
			Create_Thread("State_CIS_Quest_Checker_Defoliator")
		end
	end
end
function State_CIS_Quest_Checker_Defoliator()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")
	local event_act_2 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_II_Dialog_01")
	event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
	event_act_2.Clear_Dialog_Text()

	if Check_Story_Flag(p_cis, "CIS_SEARCH_SCOUTING_01", nil, true) and cis_defoliator_act_1 then
		scout_target_02 = FindPlanet("Ringo_Vinda")

		cis_defoliator_act_1 = false
		cis_defoliator_act_2 = true
	end
	if Check_Story_Flag(p_cis, "CIS_SEARCH_SCOUTING_02", nil, true) and cis_defoliator_act_2 then
		scout_target_03 = FindPlanet("Maridun")

		cis_defoliator_act_2 = false
		cis_defoliator_act_3 = true
	end
	if Check_Story_Flag(p_cis, "CIS_SEARCH_SCOUTING_03", nil, true) and cis_defoliator_act_3 then

		cis_defoliator_act_3 = false
		cis_quest_defoliator_over = true
	end

	if cis_defoliator_act_1 then
		local event_act_2 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_II_Dialog_01")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_2 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_01")
		event_act_2.Set_Event_Parameter(0, scout_target_01)
		event_act_2.Set_Event_Parameter(2, Find_Object_Type("Lok_Durd"))
	end
	if cis_defoliator_act_2 then
		local event_act_2 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_II_Dialog_02")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_2 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_02")
		event_act_2.Set_Event_Parameter(0, scout_target_02)
		event_act_2.Set_Event_Parameter(2, Find_Object_Type("Lok_Durd"))
	end
	if cis_defoliator_act_3 then
		local event_act_2 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_II_Dialog_03")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_2 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_03")
		event_act_2.Set_Event_Parameter(0, scout_target_03)
		event_act_2.Set_Event_Parameter(2, Find_Object_Type("Lok_Durd"))
	end
	if cis_quest_defoliator_over then
		local event_act_2 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_II_Dialog_03")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)

		Story_Event("CIS_DEFOLIATOR_END")
	end

	if not TestValid(Find_First_Object("Lok_Durd")) then
		StoryUtil.SpawnAtSafePlanet("SALVARA", p_cis, StoryUtil.GetSafePlanetTable(), {"Lok_Durd_Team"})
	end

	Sleep(5.0)
	if not cis_quest_defoliator_over then
		Create_Thread("State_CIS_Quest_Checker_Defoliator")
	end
end
function State_CIS_Maridun_Marauder_Epilogue(message)
	if message == OnEnter then
		p_cis.Unlock_Tech(Find_Object_Type("CIS_Defoliator_Company"))

		ChangePlanetOwnerAndRetreat(FindPlanet("Maridun"), p_cis)
		Sleep(1.0)
		
		UnitUtil.DespawnList({"Lok_Durd"})
		StoryUtil.SpawnAtSafePlanet("MARIDUN", p_cis, StoryUtil.GetSafePlanetTable(), {"Lok_Durd_Defoliator_Team"})

		StoryUtil.SetPlanetRestricted("MARIDUN", 0)
	end
end

function State_CIS_TennuuttaSkirmishes_Citadel(message)
	if message == OnEnter then
		Story_Event("CIS_CITADEL_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")

		local event_act_3 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Citadel_Prison"))
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Lola_Sayu"))

		event_act_3_task_01 = plot.Get_Event("Trigger_CIS_TennuuttaSkirmishes_Citadel_Contruction")
		event_act_3_task_01.Set_Event_Parameter(2, Find_Object_Type("Citadel_Prison"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Citadel_Prison"))
	end
end
function State_CIS_TennuuttaSkirmishes_Citadel_Construction(message)
	if message == OnEnter then
		cis_quest_citadel_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")

		local event_act_3 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Citadel_Prison"))

		StoryUtil.SpawnAtSafePlanet("LOLA_SAYU", p_cis, StoryUtil.GetSafePlanetTable(), {"Osi_Sobeck_Team"})

		Story_Event("CIS_CITADEL_END")
	end
end

function State_CIS_TennuuttaSkirmishes_Nexus(message)
	if message == OnEnter then
		Story_Event("CIS_NEXUS_START")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("Roche", p_republic, StoryUtil.GetSafePlanetTable(), {"Mission_Venator_Piell"})

		if not cis_quest_nexus_over then
			Create_Thread("State_CIS_Quest_Checker_Nexus")
		end
	end
end
function State_CIS_Quest_Checker_Nexus()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")

	local event_act_4 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
	event_act_4.Clear_Dialog_Text()

	event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Mission_Venator_Piell"))
	if TestValid(Find_First_Object("Mission_Venator_Piell").Get_Planet_Location()) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Mission_Venator_Piell").Get_Planet_Location())
	end
	event_act_4.Add_Dialog_Text("TEXT_NONE")

	if TestValid(Find_First_Object("Mission_Venator_Piell")) then
		Find_First_Object("Mission_Venator_Piell").Get_Planet_Location()
	end

	Sleep(5.0)
	if not cis_quest_nexus_over then
		Create_Thread("State_CIS_Quest_Checker_Nexus")
	end
end
function State_CIS_Piell_Death_Nexus(message)
	if message == OnEnter then
		cis_quest_nexus_over = true
		Story_Event("CIS_NEXUS_END")
	end
end

function State_CIS_TennuuttaSkirmishes_Handooine(message)
	if message == OnEnter then
		if FindPlanet("Handooine").Get_Owner() ~= p_cis then
			Story_Event("CIS_HANDOOINE_START")

			local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")
			local event_act_5 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_V_Dialog")
			event_act_5.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
			event_act_5.Clear_Dialog_Text()

			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", FindPlanet("Handooine"))

			event_act_5_task = plot.Get_Event("Trigger_CIS_Scout_Enter_Handooine")
			event_act_5_task.Set_Event_Parameter(0, FindPlanet("Handooine"))
		end
	end
end
function State_CIS_Scout_Enter_Handooine(message)
	if message == OnEnter then
		Story_Event("CIS_HANDOOINE_END")


		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_CIS.XML")
		local event_act_5 = plot.Get_Event("CIS_TennuuttaSkirmishes_Act_V_Dialog")
		event_act_5.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_CIS")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", FindPlanet("Handooine"))
	end
end

function State_CIS_TennuuttaSkirmishes_GC_Progression(message)
	if message == OnEnter then
		if (GlobalValue.Get("Tennuutta_CIS_GC_Version") == 0) then
			StoryUtil.LoadCampaign("Sandbox_DurgesLance_CIS", 0)
		else
			StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_CIS", 0)
		end
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")
	Clear_Fighter_Hero("BROADSIDE_SHADOW_SQUADRON")

	p_cis.Unlock_Tech(Find_Object_Type("CIS_Defoliator_Company"))
	p_republic.Lock_Tech(Find_Object_Type("Republic_Naval_Command_Centre"))

	StoryUtil.RevealPlanet("MARIDUN", false)
	StoryUtil.RevealPlanet("SALVARA", false)

	StoryUtil.SetPlanetRestricted("MARIDUN", 1, false)

	if (GlobalValue.Get("Tennuutta_Rep_GC_Version") == 1) then
		GlobalValue.Set("CURRENT_CLONE_PHASE", 2)
		crossplot:publish("CLONE_UPGRADES", "empty")
		p_republic.Unlock_Tech(Find_Object_Type("Clonetrooper_Phase_Two_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Republic_BARC_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("ARC_Phase_Two_Company"))

		p_republic.Lock_Tech(Find_Object_Type("Clonetrooper_Phase_One_Company"))
		p_republic.Lock_Tech(Find_Object_Type("Republic_74Z_Bike_Company"))
		p_republic.Lock_Tech(Find_Object_Type("ARC_Phase_One_Company"))
	end

	StoryUtil.SpawnAtSafePlanet("ABHEAN", p_cis, StoryUtil.GetSafePlanetTable(), {"Zolghast_Team"})
	StoryUtil.SpawnAtSafePlanet("LOLA_SAYU", p_cis, StoryUtil.GetSafePlanetTable(), {"Osi_Sobeck_Team", "K2B4_Providence"})

	StoryUtil.SpawnAtSafePlanet("AZURE", p_republic, StoryUtil.GetSafePlanetTable(), {"Renau_Acclamator","Solomahal_Team"})
	StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Kreuge_Gibbon"})
	StoryUtil.SpawnAtSafePlanet("MENDIG", p_republic, StoryUtil.GetSafePlanetTable(), {"Rom_Mohc_Team"})
	StoryUtil.SpawnAtSafePlanet("GAVRYN", p_republic, StoryUtil.GetSafePlanetTable(), {"Pellaeon_Leveler"})

	Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
end
function State_Rep_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_Republic.XML")

	local TennuuttaSkirmishes_PlanetList = {
		FindPlanet("Salvara"),
		FindPlanet("Abhean"),
		FindPlanet("Vorzyd"),
		FindPlanet("Ringo_Vinda"),
		FindPlanet("Murkhana"),
	}

	local event_act_1 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(TennuuttaSkirmishes_PlanetList) do
		if p_planet.Get_Owner() ~= p_republic then
			if p_planet.Get_Planet_Location() == FindPlanet("Salvara") then
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			else
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Salvara").Get_Owner() == p_republic 
	and FindPlanet("Abhean").Get_Owner() == p_republic 
	and FindPlanet("Murkhana").Get_Owner() == p_republic 
	and FindPlanet("Vorzyd").Get_Owner() == p_republic 
	and FindPlanet("Ringo_Vinda").Get_Owner() == p_republic then
		rep_quest_planet_hunt_over = true
		Story_Event("REP_PLANET_HUNT_END")

		local planet_list_factional_cis = StoryUtil.GetFactionalPlanetList(p_cis)
		if table.getn(planet_list_factional_cis) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
					StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_Republic", 1)
				else
					StoryUtil.LoadCampaign("Sandbox_AU_2_DurgesLance_Republic", 1)
				end
			end
		end
	end

	Sleep(5.0)
	if not rep_quest_planet_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
	end
end

function State_Rep_Venator_Venture_Epilogue(message)
	if message == OnEnter then
		if p_republic.Is_Human() then
			ChangePlanetOwnerAndRetreat(FindPlanet("Quell"), p_cis)

			StoryUtil.SpawnAtSafePlanet("QUELL", p_cis, StoryUtil.GetSafePlanetTable(), {"TF1726_Munificent"})
		end
	end
end

function State_Rep_TennuuttaSkirmishes_Jedi_Search(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_SEARCH_START")

		scout_target_01 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_jedi_search_act_1 = true

		if not rep_quest_jedi_search_over then
			Create_Thread("State_Rep_Quest_Checker_Jedi_Search")
		end
	end
end
function State_Rep_Quest_Checker_Jedi_Search()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_Republic.XML")
	local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_01")
	event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
	event_act_2.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_JEDI_SEARCH_SCOUTING_01", nil, true) and rep_jedi_search_act_1 then
		scout_target_02 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_jedi_search_act_1 = false
		rep_jedi_search_act_2 = true
	end
	if Check_Story_Flag(p_republic, "REP_JEDI_SEARCH_SCOUTING_02", nil, true) and rep_jedi_search_act_2 then
		scout_target_03 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_jedi_search_act_2 = false
		rep_jedi_search_act_3 = true
	end
	if Check_Story_Flag(p_republic, "REP_JEDI_SEARCH_SCOUTING_03", nil, true) and rep_jedi_search_act_3 then
		scout_target_04 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		rep_jedi_search_act_3 = false
		rep_jedi_search_act_4 = true
	end
	if Check_Story_Flag(p_republic, "REP_JEDI_SEARCH_SCOUTING_04", nil, true) and rep_jedi_search_act_4 then
		rep_jedi_search_act_4 = false
		rep_quest_jedi_search_over = true
	end

	if rep_jedi_search_act_1 then
		local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_01")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_2 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_01")
		event_act_2.Set_Event_Parameter(0, scout_target_01)
	end
	if rep_jedi_search_act_2 then
		local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_02")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_2 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_02")
		event_act_2.Set_Event_Parameter(0, scout_target_02)
	end
	if rep_jedi_search_act_3 then
		local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_03")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_2 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_03")
		event_act_2.Set_Event_Parameter(0, scout_target_03)
	end
	if rep_jedi_search_act_4 then
		local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_04")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_04)

		event_act_2 = plot.Get_Event("Trigger_Rep_Enter_Probe_Search_04")
		event_act_2.Set_Event_Parameter(0, scout_target_04)
	end
	if rep_quest_jedi_search_over then
		local event_act_2 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_II_Dialog_04")
		event_act_2.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_04)

		Story_Event("REP_JEDI_SEARCH_END")
	end

	Sleep(5.0)
	if not rep_quest_jedi_search_over then
		Create_Thread("State_Rep_Quest_Checker_Jedi_Search")
	end
end

function State_Rep_TennuuttaSkirmishes_Jedi_Found(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_FOUND_START")
		StoryUtil.SpawnAtSafePlanet("HANDOOINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Yularen_Resolute"})

		if not rep_quest_jedi_found_over then
			Create_Thread("State_Rep_Quest_Checker_Jedi_Found")
		end
	end
end
function State_Rep_Quest_Checker_Jedi_Found()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_Republic.XML")

	if TestValid(Find_First_Object("Yularen_Resolute")) then
		local event_act_3 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Yularen_Resolute"))
		if TestValid(Find_First_Object("Yularen_Resolute").Get_Planet_Location()) then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Yularen_Resolute").Get_Planet_Location())
		end
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Maridun"))
		event_act_3.Add_Dialog_Text("TEXT_NONE")

		local event_act_3_task = plot.Get_Event("Rep_Yularen_Enter_Maridun")
		event_act_3_task.Set_Event_Parameter(2, Find_Object_Type("Yularen_Resolute"))

	elseif TestValid(Find_First_Object("Yularen_Integrity")) then
		local event_act_3 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Yularen_Integrity"))
		if TestValid(Find_First_Object("Yularen_Integrity").Get_Planet_Location()) then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Yularen_Integrity").Get_Planet_Location())
		end
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Maridun"))
		event_act_3.Add_Dialog_Text("TEXT_NONE")

		local event_act_3_task = plot.Get_Event("Rep_Yularen_Enter_Maridun")
		event_act_3_task.Set_Event_Parameter(2, Find_Object_Type("Yularen_Integrity"))

	elseif TestValid(Find_First_Object("Venator_Star_Destroyer")) then
		local event_act_3 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Venator_Star_Destroyer"))
		if TestValid(Find_First_Object("Venator_Star_Destroyer").Get_Planet_Location()) then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Venator_Star_Destroyer").Get_Planet_Location())
		end
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Maridun"))
		event_act_3.Add_Dialog_Text("TEXT_NONE")

		local event_act_3_task = plot.Get_Event("Rep_Yularen_Enter_Maridun")
		event_act_3_task.Set_Event_Parameter(2, Find_Object_Type("Venator_Star_Destroyer"))

	else
		Sleep(5.0)
		Story_Event("REP_JEDI_FOUND_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_jedi_found_over then
		Create_Thread("State_Rep_Quest_Checker_Jedi_Found")
	end
end
function State_Rep_Maridun_Marauder_Epilogue(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_FOUND_END")
		StoryUtil.SetPlanetRestricted("MARIDUN", 0)

		if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
			StoryUtil.SpawnAtSafePlanet("MARIDUN", p_republic, StoryUtil.GetSafePlanetTable(), {"Ahsoka_Delta_Team", "Aayla_Secura_Delta_Team", "Bly2_Team", "Rex2_Team"})
		else
			StoryUtil.SpawnAtSafePlanet("MARIDUN", p_republic, StoryUtil.GetSafePlanetTable(), {"Ahsoka_Delta_Team", "Aayla_Secura_Delta_Team", "Bly_Team", "Rex_Team"})
		end

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_Rep_TennuuttaSkirmishes_Meeting(message)
	if message == OnEnter then
		Story_Event("REP_MEETING_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Republic_Naval_Command_Centre"))
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Handooine"))
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Republic_Naval_Command_Centre"))
	end
end
function State_Rep_TennuuttaSkirmishes_Meeting_Research(message)
	if message == OnEnter then
		rep_quest_meeting_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsTennuutta\\Story_Sandbox_Tennuutta_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_TennuuttaSkirmishes_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_TennuuttaSkirmishes_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Republic_Naval_Command_Centre"))

		Story_Event("REP_MEETING_END")
	end
end

function State_Rep_TennuuttaSkirmishes_GC_Progression(message)
	if message == OnEnter then
		if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
			StoryUtil.LoadCampaign("Sandbox_AU_2_DurgesLance_Republic", 1)
		else
			StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_Republic", 1)
		end
	end
end

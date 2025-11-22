--******************************************************--
--********  Campaign: Hunt for the Malevolence  ********--
--******************************************************--

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
		Trigger_CIS_MalevolenceHunt_Kaliida = State_CIS_MalevolenceHunt_Kaliida,
		CIS_Medical_Madness_Tactical_Epilogue = State_CIS_Grievous_Enter_Kaliida,

		Trigger_CIS_MalevolenceHunt_Moorja = State_CIS_MalevolenceHunt_Moorja,
		Trigger_CIS_MalevolenceHunt_Rugosa = State_CIS_MalevolenceHunt_Rugosa,

		CIS_MalevolenceHunt_GC_Progression = State_CIS_MalevolenceHunt_GC_Progression,

		CIS_Cruel_AI_Activated = State_CIS_Cruel_AI_Activated,
		CIS_Cruel_AI_Deactivated = State_CIS_Cruel_AI_Deactivated,

		-- Republic
		Trigger_Rep_Grievous_Death_Malevolence = State_Rep_Grievous_Death_Malevolence,

		Trigger_Rep_MalevolenceHunt_Bormus = State_Rep_MalevolenceHunt_Bormus,
		Trigger_Rep_Deploy_Heroes_Bormus = State_Rep_Deploy_Heroes_Bormus,

		Trigger_Rep_MalevolenceHunt_Bomber = State_Rep_MalevolenceHunt_Bomber,
		Trigger_Rep_MalevolenceHunt_Bomber_Research = State_Rep_MalevolenceHunt_Bomber_Research,

		Trigger_Rep_MalevolenceHunt_Ambulance = State_Rep_MalevolenceHunt_Ambulance,

		Trigger_Rep_MalevolenceHunt_Rugosa = State_Rep_MalevolenceHunt_Rugosa,
		Rep_MalevolenceHunt_Conquest_Rogusa = State_Rep_MalevolenceHunt_Conquest_Rogusa,

		Rep_MalevolenceHunt_GC_Progression = State_Rep_MalevolenceHunt_GC_Progression,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")

	gc_start = false
	all_planets_conquered = false
	act_1_active = false
	act_2_active = false
	act_3_active = false

	malevolence_mission_ii_active = false
	malevolence_destroyed = false

	cis_quest_pelta_over = false
	cis_quest_kaliida_over = false
	cis_quest_moorja_over = false
	cis_quest_rugosa_over = false

	rep_quest_malevolence_over = false
	rep_quest_bormus_over = false
	rep_quest_bomber_over = false
	rep_quest_ambulance_over = false
	rep_quest_rugosa_over = false

	rep_quest_ambulance_rescue_counter = 0

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("CIS_Sector_Capital"))

		p_cis.Lock_Tech(Find_Object_Type("Providence_Destroyer"))
		p_cis.Lock_Tech(Find_Object_Type("Subjugator"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))
		p_cis.Lock_Tech(Find_Object_Type("CIS_Capital"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))

		p_cis.Unlock_Tech(Find_Object_Type("88th_Flight_Location_Set"))
		Set_Fighter_Hero("88TH_FLIGHT_SQUADRON", "GRIEVOUS_MALEVOLENCE_HUNT_CAMPAIGN")
		
		p_cis.Lock_Tech(Find_Object_Type("Nas_Ghent_Location_Set"))
		Clear_Fighter_Hero("NAS_GHENT_SQUADRON")
		
		p_cis.Lock_Tech(Find_Object_Type("DFS1VR_Location_Set"))
		Clear_Fighter_Hero("DFS1VR_31ST_SQUADRON")
		
		p_cis.Lock_Tech(Find_Object_Type("Nwon_Raines_Location_Set"))
		p_cis.Lock_Tech(Find_Object_Type("Vulpus_Location_Set"))
		p_cis.Lock_Tech(Find_Object_Type("Raina_Quill_Location_Set"))

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Charger_C70"))
		p_republic.Unlock_Tech(Find_Object_Type("LAC"))
		p_republic.Unlock_Tech(Find_Object_Type("Class_C_Frigate"))
		p_republic.Unlock_Tech(Find_Object_Type("Class_C_Support"))
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))

		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))
		p_republic.Lock_Tech(Find_Object_Type("Invincible_Cruiser"))
		p_republic.Lock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Lock_Tech(Find_Object_Type("Galleon"))
		p_republic.Lock_Tech(Find_Object_Type("Pelta_Support"))
		p_republic.Lock_Tech(Find_Object_Type("Pelta_Assault"))
		p_republic.Lock_Tech(Find_Object_Type("CR90"))
		p_republic.Lock_Tech(Find_Object_Type("DP20"))

		p_republic.Lock_Tech(Find_Object_Type("Plo_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Gree_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Luminara_Assign"))
		p_republic.Lock_Tech(Find_Object_Type("Tenant_Assign"))

		Set_Fighter_Research("RepublicWarpods")

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

			GlobalValue.Set("HfM_Plo_Rescued", 1)
			GlobalValue.Set("CIS_Pelta_Kill_Count", 0)
			GlobalValue.Set("CIS_Haven_Kill_Count", 0)
			GlobalValue.Set("HfM_Malevolence_Alive", 1)

			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")

			GlobalValue.Set("HfM_Plo_Rescued", 1)
			GlobalValue.Set("HfM_Battle_Counter", 0)
			GlobalValue.Set("HfM_Malevolence_Alive", 1)

			Story_Event("REP_INTRO_START")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			GlobalValue.Set("HfM_Plo_Rescued", 1)
			GlobalValue.Set("CIS_Pelta_Kill_Count", 0)
			GlobalValue.Set("CIS_Haven_Kill_Count", 0)
			GlobalValue.Set("HfM_Malevolence_Alive", 1)

			Create_Thread("CIS_Story_Set_Up")
		end
		if p_republic.Is_Human() then
			GlobalValue.Set("HfM_Plo_Rescued", 1)
			GlobalValue.Set("HfM_Battle_Counter", 0)
			GlobalValue.Set("HfM_Malevolence_Alive", 1)

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
				["LOCKIN"] = {"Yularen"},
				["EXIT"] = {"Maarisa","Martz","Baraka","Grumby","Autem","Tallon","Dallin","Pellaeon","Tenant",},
			},
			["ARMY"] = {
				["SLOT_ADJUST"] = -2,
			},
			["CLONE"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Rex"},
				["RETURN"] = {"Jet"},
				["EXIT"] = {"Gree_Clone","Bacara","Cody"},
			},
			["COMMANDO"] = {
				["SLOT_ADJUST"] = -2,
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = -2,
				["LOCKIN"] = {"Plo"},
				["EXIT"] = {"Ahsoka","Luminara","Barriss","Kit","Shaak","Kota","Knol","Yoda","Halcyon"},
			},
		})

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Story_Mode_Service()
	if gc_start then
		if p_cis.Is_Human() then
			--this space intentionally left blank
		elseif p_republic.Is_Human() then
			if set_up_done then
				if not malevolence_mission_ii_active and (GlobalValue.Get("HfM_Battle_Counter") == 1) then
					Story_Event("PART_II_ACTIVE")
					malevolence_mission_ii_active = true
				end
			end
		end
	end
end


function Generic_Story_Set_Up()
	StoryUtil.SpawnAtSafePlanet("MOORJA", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team"})
	StoryUtil.SpawnAtSafePlanet("ABREGADO_RAE", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence_Hunt_Campaign"})
	StoryUtil.SpawnAtSafePlanet("SANRAFSIX", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team","OOM_224_Team"})
	SpawnList({"Lorz_Geptun_Team"}, FindPlanet("Haruun_Kal"), p_cis, false, false)

	StoryUtil.SpawnAtSafePlanet("NABOO", p_republic, StoryUtil.GetSafePlanetTable(), {"Rex_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Plo_Koon_Delta_Team","Anakin_Ahsoka_Twilight_Team","Ask_Aak_Team","Yularen_Resolute","Coburn_Venator"})
	StoryUtil.SpawnAtSafePlanet("KALIIDA_NEBULA", p_republic, StoryUtil.GetSafePlanetTable(), {"Jarl_Pelta"})

	gc_start = true
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	gc_start = true

	StoryUtil.SetPlanetRestricted("MOORJA", 1, false)
	StoryUtil.SetPlanetRestricted("RUGOSA", 1, false)
	StoryUtil.SetPlanetRestricted("KALIIDA_NEBULA", 1, false)

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")

	SpawnList({"Lorz_Geptun_Team"}, FindPlanet("Haruun_Kal"), p_cis, false, false)
	StoryUtil.SpawnAtSafePlanet("ABREGADO_RAE", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence_Hunt_Campaign"})
	StoryUtil.SpawnAtSafePlanet("SANRAFSIX", p_cis, StoryUtil.GetSafePlanetTable(), {"OOM_224_Team"})
	if StoryUtil.GetDifficulty() == "HARD" then
		SpawnList({"Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer"}, FindPlanet("Kaliida_Nebula"), p_republic, false, false)
	end

	StoryUtil.SpawnAtSafePlanet("NABOO", p_republic, StoryUtil.GetSafePlanetTable(), {"Rex_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Ask_Aak_Team","Plo_Koon_Delta_Team","Anakin_Ahsoka_Twilight_Team","Jarl_Pelta","Yularen_Resolute","Coburn_Venator"})

	Sleep(10.0)

	StoryUtil.SpawnAtSafePlanet("BESTINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})
	StoryUtil.SpawnAtSafePlanet("IPHIGIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})
	StoryUtil.SpawnAtSafePlanet("GHORMAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})

	Create_Thread("State_CIS_Hero_Checker_Grievous")
	Create_Thread("State_CIS_Quest_Checker_Pelta")
end
function State_CIS_Hero_Checker_Grievous()
	if (GlobalValue.Get("HfM_Malevolence_Alive") == 1) and not TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
		StoryUtil.SpawnAtSafePlanet("KALIIDA_NEBULA", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence_Hunt_Campaign"})
	end
	if (GlobalValue.Get("HfM_Malevolence_Alive") == 0) then
		UnitUtil.DespawnList({"Grievous_Malevolence_Hunt_Campaign"})
		StoryUtil.SetPlanetRestricted("KALIIDA_NEBULA", 0)
		Story_Event("CIS_MALEVOLENCE_END")
	end

	Sleep(5.0)
	if (GlobalValue.Get("HfM_Malevolence_Alive") == 1) then
		Create_Thread("State_CIS_Hero_Checker_Grievous")
	end
end
function State_CIS_Quest_Checker_Pelta()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_CIS.XML")

	local event_act_1 = plot.Get_Event("CIS_MalevolenceHunt_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_CIS")
	event_act_1.Clear_Dialog_Text()

	local convoy_list = Find_All_Objects_Of_Type("Medical_Convoy_HfM")
	if table.getn(convoy_list) == 6 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 6)

	elseif table.getn(convoy_list) == 5 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 5)

	elseif table.getn(convoy_list) == 4 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 4)

	elseif table.getn(convoy_list) == 3 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 3)

	elseif table.getn(convoy_list) == 2 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 2)

	elseif table.getn(convoy_list) == 1 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)

	elseif table.getn(convoy_list) == 0 then
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_HUNT_COMPLETE", Find_Object_Type("Medical_Convoy_HfM"))
		cis_quest_pelta_over = true
		Clear_Fighter_Research("RepublicWarpods")

		Story_Event("CIS_PELTA_END")
	end

	Sleep(5.0)
	if not cis_quest_pelta_over then
		Create_Thread("State_CIS_Quest_Checker_Pelta")
	end
end

function State_CIS_Grievous_Enter_Kaliida(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("KALIIDA_NEBULA", 0)
	end
end

function State_CIS_MalevolenceHunt_Kaliida(message)
	if message == OnEnter then
		Story_Event("CIS_KALIIDA_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("KALIIDA_NEBULA", "GUI_Flash_Kaliida_Nebula")
		MissionUtil.PositionCamera("KALIIDA_NEBULA")

		if not cis_quest_kaliida_over then
			Create_Thread("State_CIS_Quest_Checker_Kaliida")
		end
	end
end
function State_CIS_Quest_Checker_Kaliida()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_CIS.XML")

	local event_act_2 = plot.Get_Event("CIS_MalevolenceHunt_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_CIS")
	event_act_2.Clear_Dialog_Text()
	if FindPlanet("Kaliida_Nebula").Get_Owner() ~= p_cis then
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Kaliida_Nebula"))
	else
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Kaliida_Nebula"))

		StoryUtil.SetPlanetRestricted("KALIIDA_NEBULA", 0)

		Story_Event("CIS_KALIIDA_END")
		cis_quest_kaliida_over = true
	end

	local planet_list_factional = StoryUtil.GetFactionalPlanetList(p_republic)
	if table.getn(planet_list_factional) == 0 then
		if not all_planets_conquered then
			all_planets_conquered = true
			if TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
				StoryUtil.LoadCampaign("Sandbox_AU_Rimward_CIS", 0)
			elseif not TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
				StoryUtil.LoadCampaign("Sandbox_Rimward_CIS", 0)
			end
		end
	end

	Sleep(5.0)
	if not cis_quest_kaliida_over then
		Create_Thread("State_CIS_Quest_Checker_Kaliida")
	end
end

function State_CIS_MalevolenceHunt_Moorja(message)
	if message == OnEnter then
		Story_Event("CIS_MOORJA_START")
		StoryUtil.SetPlanetRestricted("MOORJA", 0)
		Sleep(5.0)

		if not cis_quest_moorja_over then
			Create_Thread("State_CIS_Quest_Checker_Moorja")
		end
	end
end
function State_CIS_Quest_Checker_Moorja()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_CIS.XML")

	local event_act_3 = plot.Get_Event("CIS_MalevolenceHunt_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_CIS")
	event_act_3.Clear_Dialog_Text()
	if FindPlanet("Moorja").Get_Owner() ~= p_cis then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Moorja"))
	else
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Moorja"))
		Story_Event("CIS_MOORJA_END")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("MOORJA", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team"})
		cis_quest_moorja_over = true
	end

	Sleep(5.0)
	if not cis_quest_moorja_over then
		Create_Thread("State_CIS_Quest_Checker_Moorja")
	end
end

function State_CIS_MalevolenceHunt_Rugosa(message)
	if message == OnEnter then
		Story_Event("CIS_RUGOSA_START")
		StoryUtil.SetPlanetRestricted("RUGOSA", 0)

		StoryUtil.SpawnAtSafePlanet("ABREGADO_RAE", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team"})

		ChangePlanetOwnerAndPopulate(FindPlanet("Rugosa"), p_republic, 7500)
		Sleep(5.0)

		crossplot:publish("COMMAND_STAFF_DECREMENT", -1, 3)
		SpawnList({"Yoda_Delta_Team","Republic_A5_Juggernaut_Company","Republic_A5_Juggernaut_Company","Clonetrooper_Phase_One_Company","Clonetrooper_Phase_One_Company"}, FindPlanet("Rugosa"), p_republic, false, false)
		crossplot:publish("COMMAND_STAFF_LOCKIN", {"Yoda"}, 3)
		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")

		if not cis_quest_rugosa_over then
			Create_Thread("State_CIS_Quest_Checker_Rugosa")
		end
	elseif message == OnUpdate then
		crossplot:update()
	end
end
function State_CIS_Quest_Checker_Rugosa()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_CIS.XML")

	local event_act_4 = plot.Get_Event("CIS_MalevolenceHunt_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_CIS")
	event_act_4.Clear_Dialog_Text()
	if FindPlanet("Rugosa").Get_Owner() ~= p_cis then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rugosa"))
	else
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rugosa"))
		Story_Event("CIS_RUGOSA_END")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("RUGOSA", p_cis, StoryUtil.GetSafePlanetTable(), {"Katuunko_Team"})
		cis_quest_rugosa_over = true
	end

	Sleep(5.0)
	if not cis_quest_rugosa_over then
		Create_Thread("State_CIS_Quest_Checker_Rugosa")
	end
end

function State_CIS_MalevolenceHunt_GC_Progression(message)
	if message == OnEnter then
		if TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
			StoryUtil.LoadCampaign("Sandbox_AU_Rimward_CIS", 0)
		elseif not TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
			StoryUtil.LoadCampaign("Sandbox_Rimward_CIS", 0)
		end
	end
end

function State_CIS_Cruel_AI_Activated(message)
	if message == OnEnter then
		SpawnList({"Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer"}, FindPlanet("Kaliida_Nebula"), p_republic, false, false)
	end
end
function State_CIS_Cruel_AI_Deactivated(message)
	if message == OnEnter then
		for i=1,5 do
			local venator = Find_First_Object("Venator_Star_Destroyer")
			if TestValid(venator) then
				venator.Despawn()
			end
		end
		SpawnList({"Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer","Venator_Star_Destroyer"}, FindPlanet("Kaliida_Nebula"), p_republic, false, false)
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	set_up_done = true
	gc_start = true

	StoryUtil.SetPlanetRestricted("RUGOSA", 1, false)

	Set_Fighter_Hero("AXE_BLUE_SQUADRON","YULAREN_RESOLUTE")

	SpawnList({"Lorz_Geptun_Team"}, FindPlanet("Haruun_Kal"), p_cis, false, false)
	StoryUtil.SpawnAtSafePlanet("MOORJA", p_cis, StoryUtil.GetSafePlanetTable(), {"Argente_Team"})
	StoryUtil.SpawnAtSafePlanet("ABREGADO_RAE", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence_Hunt_Campaign"})
	if StoryUtil.GetDifficulty() == "HARD" then
		StoryUtil.SpawnAtSafePlanet("MOORJA", p_cis, StoryUtil.GetSafePlanetTable(), {"Doctor_Instinction"})
	end

	StoryUtil.SpawnAtSafePlanet("NABOO", p_republic, StoryUtil.GetSafePlanetTable(), {"Rex_Team"})
	StoryUtil.SpawnAtSafePlanet("BESTINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Plo_Koon_Delta_Team","Anakin_Ahsoka_Twilight_Team","Yularen_Resolute","Coburn_Venator"})
	Sleep(5.0)

	MissionUtil.FlashPlanet("KALIIDA_NEBULA", "GUI_Flash_Kaliida_Nebula")
	MissionUtil.PositionCamera("KALIIDA_NEBULA")

	Create_Thread("State_Rep_Quest_Checker_Malevolence")
end
function State_Rep_Quest_Checker_Malevolence()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

	local event_act_1 = plot.Get_Event("Rep_MalevolenceHunt_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
	event_act_1.Clear_Dialog_Text()

	event_act_1.Add_Dialog_Text("Target: Subjugator-class Heavy Cruiser, The Malevolence")
	if StoryUtil.GetDifficulty() == "EASY" then
		if TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign")) then
			if TestValid(Find_First_Object("Grievous_Malevolence_Hunt_Campaign").Get_Planet_Location()) then
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Grievous_Malevolence_Hunt_Campaign").Get_Planet_Location())
			end
		end
	end

	event_act_1.Add_Dialog_Text("TEXT_NONE")

	Sleep(5.0)
	if not rep_quest_malevolence_over then
		Create_Thread("State_Rep_Quest_Checker_Malevolence")
	end
end
function State_Rep_Grievous_Death_Malevolence(message)
	if message == OnEnter then
		StoryUtil.SpawnAtSafePlanet("NABOO", p_republic, StoryUtil.GetSafePlanetTable(), {"Padme_Amidala_Team","Obi_Wan_Delta_Team"})

		p_republic.Unlock_Tech(Find_Object_Type("Pelta_Assault"))
		p_republic.Unlock_Tech(Find_Object_Type("Pelta_Support"))

		local planet_list_factional = StoryUtil.GetFactionalPlanetList(p_cis)
		if table.getn(planet_list_factional) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				StoryUtil.LoadCampaign("Sandbox_AU_Rimward_Republic", 1)
			end
		end

		Story_Event("REP_MALEVOLENCE_END")
		rep_quest_malevolence_over = true
	end
end

function State_Rep_MalevolenceHunt_Bormus(message)
	if message == OnEnter then
		Story_Event("REP_BORMUS_START")

		if not rep_quest_bormus_over then
			Create_Thread("State_Rep_Quest_Checker_Bormus")
		end
	end
end
function State_Rep_Quest_Checker_Bormus()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

	local event_act_2 = plot.Get_Event("Rep_MalevolenceHunt_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
	event_act_2.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Anakin3")) then
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Ahsoka_Twilight_Team"))
		if TestValid(Find_First_Object("Anakin3").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin3").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bormus"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Trigger_Rep_Deploy_Twilight_Bormus")
		event_act_2_task_01.Set_Event_Parameter(0, Find_Object_Type("Anakin_Ahsoka_Twilight_Team"))
	else
		Story_Event("REP_BORMUS_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_bormus_over then
		Create_Thread("State_Rep_Quest_Checker_Bormus")
	end
end
function State_Rep_Deploy_Heroes_Bormus(message)
	if message == OnEnter then
		rep_quest_bormus_over = true

		Story_Event("REP_BORMUS_END")
	end
end

function State_Rep_MalevolenceHunt_Bomber(message)
	if message == OnEnter then
		Story_Event("REP_BOMBER_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_MalevolenceHunt_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Ywing"))
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bormus"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Ywing"))
	end
end
function State_Rep_MalevolenceHunt_Bomber_Research(message)
	if message == OnEnter then
		rep_quest_bomber_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_MalevolenceHunt_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Ywing"))

		StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Ask_Aak_Team"})

		Story_Event("REP_BOMBER_END")
	end
end

function State_Rep_MalevolenceHunt_Ambulance(message)
	if message == OnEnter then
		if not rep_quest_ambulance_over and not rep_quest_malevolence_over  then
			Story_Event("REP_AMBULANCE_START")

			StoryUtil.SpawnAtSafePlanet("GHORMAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})
			StoryUtil.SpawnAtSafePlanet("IPHIGIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})
			StoryUtil.SpawnAtSafePlanet("DERRA", p_republic, StoryUtil.GetSafePlanetTable(), {"Medical_Convoy_HfM","Medical_Convoy_HfM"})

			Create_Thread("State_Rep_Quest_Checker_Ambulance")
		end
	end
end
function State_Rep_Quest_Checker_Ambulance()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

	local event_act_4 = plot.Get_Event("Rep_MalevolenceHunt_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
	event_act_4.Clear_Dialog_Text()

	event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Medical_Convoy_HfM"))
	event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Kaliida_Nebula"))
	event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_CURRENT", rep_quest_ambulance_rescue_counter)

	p_ambulance_list = Find_All_Objects_Of_Type("Medical_Convoy_HfM")
	if table.getn(p_ambulance_list) > 0 then
		for _,p_ambulance in pairs(p_ambulance_list) do
			if p_ambulance.Get_Planet_Location() == FindPlanet("Kaliida_Nebula") then
				rep_quest_ambulance_rescue_counter = rep_quest_ambulance_rescue_counter + 1
				p_ambulance.Despawn()
			end
		end
	else
		StoryUtil.SpawnAtSafePlanet("KALIIDA_NEBULA", p_republic, StoryUtil.GetSafePlanetTable(), {"Jarl_Pelta"})
		Story_Event("REP_AMBULANCE_END")
		rep_quest_ambulance_over = true
	end

	Sleep(2.0)
	if not rep_quest_ambulance_over then
		Create_Thread("State_Rep_Quest_Checker_Ambulance")
	end
end

function State_Rep_MalevolenceHunt_Rugosa(message)
	if message == OnEnter then
		Story_Event("REP_RUGOSA_START")
		StoryUtil.SetPlanetRestricted("RUGOSA", 0)

		ChangePlanetOwnerAndPopulate(FindPlanet("Rugosa"), p_cis, 7500)
		Sleep(5.0)

		SpawnList({"Ventress_Team","OOM_224_Team","AAT_Company","B1_Droid_Company","B1_Droid_Company","B2_Droid_Company"}, FindPlanet("Rugosa"), p_cis, false, false)

		if not rep_quest_rugosa_over then
			Create_Thread("State_Rep_Quest_Checker_Rugosa")
		end
	end
end
function State_Rep_Quest_Checker_Rugosa()
	local plot = Get_Story_Plot("Conquests\\Historical\\22_BBY_CloneWarsMalevolence\\Story_Sandbox_Malevolence_Republic.XML")

	local event_act_5 = plot.Get_Event("Rep_MalevolenceHunt_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_22_BBY_MalevolenceHunt_Rep")
	event_act_5.Clear_Dialog_Text()
	if FindPlanet("Rugosa").Get_Owner() ~= p_republic then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rugosa"))
	else
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rugosa"))
		Story_Event("REP_RUGOSA_END")
	end

	Sleep(5.0)
	if not rep_quest_rugosa_over then
		Create_Thread("State_Rep_Quest_Checker_Rugosa")
	end
end
function State_Rep_MalevolenceHunt_Conquest_Rogusa(message)
	if message == OnEnter then
		crossplot:publish("COMMAND_STAFF_DECREMENT", -1, 3)
		StoryUtil.SpawnAtSafePlanet("RUGOSA", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Delta_Team","Katuunko_Team"})
		crossplot:publish("COMMAND_STAFF_LOCKIN", {"Yoda"}, 3)
		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")

		rep_quest_rugosa_over = true
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_Rep_MalevolenceHunt_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.LoadCampaign("Sandbox_AU_Rimward_Republic", 1)
	end
end

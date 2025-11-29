--****************************************************--
--*  Fall of the Republic: Operation Knight Hammer   *--
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
		CIS_Tomb_Torment_Epilogue = State_CIS_Tomb_Torment_Epilogue,

		Trigger_CIS_KnightHammer_Planet_Hunt = State_CIS_KnightHammer_Planet_Hunt,

		Trigger_CIS_KnightHammer_Praesitlyn_Siege = State_CIS_KnightHammer_Praesitlyn_Siege,

		Trigger_CIS_KnightHammer_Communication = State_CIS_KnightHammer_Communication,
		Trigger_CIS_Praesitlyn_ComCenter_Research = State_CIS_Praesitlyn_ComCenter_Research,

		CIS_KnightHammer_GC_Progression = State_CIS_KnightHammer_GC_Progression,

		-- Republic
		Rep_Tomb_Torment_Epilogue = State_Rep_Tomb_Torment_Epilogue,

		Trigger_Rep_KnightHammer_Praesitlyn_Siege = State_Rep_KnightHammer_Praesitlyn_Siege,
		Rep_Praesitlyn_Pressure_Epilogue = State_Rep_Praesitlyn_Pressure_Epilogue,

		Trigger_Rep_KnightHammer_Communication = State_Rep_KnightHammer_Communication,
		Trigger_Rep_Praesitlyn_ComCenter_Research = State_Rep_Praesitlyn_ComCenter_Research,

		Trigger_Rep_KnightHammer_Jedi_Cage = State_Rep_KnightHammer_Jedi_Cage,
		Trigger_Rep_Detention_Facility_Research = State_Rep_Detention_Facility_Research,

		Trigger_Rep_KnightHammer_Jedi_Hunt = State_Rep_KnightHammer_Jedi_Hunt,

		Trigger_Rep_KnightHammer_Bespin = State_Rep_KnightHammer_Bespin,
		Rep_Bespin_Breakdown_Epilogue = State_Rep_Bespin_Breakdown_Epilogue,

		Trigger_Rep_KnightHammer_Prison = State_Rep_KnightHammer_Prison,
		Trigger_Rep_Transfer_Rogue_Jedi_Research = State_Rep_Transfer_Rogue_Jedi_Research,

		Trigger_Rep_KnightHammer_Dagobah = State_Rep_KnightHammer_Dagobah,
		Rep_Dagobah_Darkness_Epilogue = State_Rep_Dagobah_Darkness_Epilogue,

		Rep_KnightHammer_GC_Progression = State_Rep_KnightHammer_GC_Progression,

		-- Hutts
		Hutts_Mauling_Mustafar_Epilogue = State_Mauling_Mustafar_Epilogue,

		Trigger_Hutts_KnightHammer_Vigo_Hunt = State_Hutts_KnightHammer_Vigo_Hunt,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_hutts = Find_Player("Hutt_Cartels")
	p_independent = Find_Player("Independent_Forces")

	cis_quest_bpfassh_over = false
	cis_quest_planet_hunt_over = false
	cis_quest_praesitlyn_siege_over = false
	cis_quest_communication_over = false

	rep_quest_jedi_hunt_target_01_over = false
	rep_quest_jedi_hunt_target_02_over = false
	rep_quest_jedi_hunt_target_03_over = false

	rep_quest_bpfassh_over = false
	rep_quest_praesitlyn_siege_over = false
	rep_quest_communication_over = false
	rep_quest_jedi_cage_over = false
	rep_quest_jedi_hunt_over = false
	rep_quest_bespin_over = false
	rep_quest_prison_over = false
	rep_quest_dagobah_over = false

	hutts_survival_timer_seconds = 0
	hutts_survival_timer_weeks = 5

	hutts_quest_survival_over = false
	hutts_quest_vigo_hunt_over = false

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("KnightHammer_CIS_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("KnightHammer_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("KnightHammer_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("KnightHammer_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("CIS_Sector_Capital"))

		p_cis.Lock_Tech(Find_Object_Type("CIS_Capital"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))

		-- Republic
		p_republic.Lock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Lock_Tech(Find_Object_Type("Acclamator_I_Carrier"))
		p_republic.Lock_Tech(Find_Object_Type("Venator_Star_Destroyer"))
		p_republic.Lock_Tech(Find_Object_Type("Clonetrooper_Phase_One_Company"))
		p_republic.Lock_Tech(Find_Object_Type("ARC_Phase_One_Company"))
		p_republic.Lock_Tech(Find_Object_Type("Clone_Commando_Company"))
		p_republic.Lock_Tech(Find_Object_Type("Republic_74Z_Bike_Company"))
		p_republic.Lock_Tech(Find_Object_Type("DP20"))

		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))
		p_republic.Lock_Tech(Find_Object_Type("E_Ground_Barracks"))

		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Jedi_Ground_Barracks"))
		p_republic.Unlock_Tech(Find_Object_Type("Consular_Refit"))
		p_republic.Unlock_Tech(Find_Object_Type("Starbolt"))
		p_republic.Lock_Tech(Find_Object_Type("Yoda_Retire"))
		p_republic.Lock_Tech(Find_Object_Type("Nejaa_Halcyon_Retire"))
		p_republic.Lock_Tech(Find_Object_Type("Tarkin_Retire"))

		p_republic.Unlock_Tech(Find_Object_Type("Republic_Trooper_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Navy_Trooper_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Special_Tactics_Trooper_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Overracer_Speeder_Bike_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Antarian_Ranger_Company"))

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

			GlobalValue.Set("OKH_Praesitlyn_Problems_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("OKH_Bespin_Breakdown_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory

			Story_Event("REP_INTRO_START")
		end
		if p_hutts.Is_Human() then
			Create_Thread("Hutts_Story_Set_Up")

			Story_Event("HUTT_INTRO_START")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			Create_Thread("CIS_Story_Set_Up")
		end
		if p_republic.Is_Human() then
			GlobalValue.Set("OKH_Praesitlyn_Problems_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("OKH_Bespin_Breakdown_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory

			Create_Thread("Rep_Story_Set_Up")
		end
		if p_hutts.Is_Human() then
			Create_Thread("Hutts_Story_Set_Up")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_STORY" then
		Create_Thread("Generic_Story_Set_Up")
	end

	crossplot:publish("VENATOR_HEROES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["SLOT_ADJUST"] = -1,
				["LOCKIN"] = {"Tarkin"},
			},
			["NAVY"] = {
				["SLOT_ADJUST"] = -1, 
				["EXIT"] = {"Yularen","Coburn","Kilian","Screed","Dodonna","Dron","Dallin","Denimoor","Wieler","Dao","Tenant"},
			},
			["ARMY"] = {
				["SLOT_ADJUST"] = 1,
			},
			["CLONE"] = {
				["SLOT_ADJUST"] = -1,
				["EXIT"] = {"Rex","Bly","Cody","Wolffe","Gree_Clone","Neyo"},
			},
			["COMMANDO"] = {
				["EXIT"] = {"Alpha","Gregor"},
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = -1,
				["LOCKIN"] = {"Halcyon","Yoda"},
				["EXIT"] = {"Aayla","Kit","Shaak","Ahsoka",},
			},
		})

	crossplot:publish("FIGHTER_HERO_ENABLE", {"Erk_HArman_Location_Set"})

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	if p_hutts.Is_Human() then
		p_hutts.Lock_Tech(Find_Object_Type("Hutt_Office"))
		p_hutts.Lock_Tech(Find_Object_Type("Hutt_Capital"))

		p_hutts.Unlock_Tech(Find_Object_Type("Shadow_Collective_Office"))

		p_hutts.Unlock_Tech(Find_Object_Type("Shadow_Collective_Capital"))

		p_hutts.Unlock_Tech(Find_Object_Type("SC_Mandalorian_Soldier_Company"))
		p_hutts.Unlock_Tech(Find_Object_Type("SC_Mandalorian_Commando_Company"))
		p_hutts.Unlock_Tech(Find_Object_Type("SC_Komrk_Gunship_Group"))

		crossplot:publish("INCREASE_FAVOUR", "SCUM", 100)

		StoryUtil.SpawnAtSafePlanet("MUSTAFAR", p_hutts, StoryUtil.GetSafePlanetTable(), {"Lom_Pyke_Super_Transport_XI_Modified","Ziton_Moj_Team","Lorka_Gedyc_Team"})
	end

	StoryUtil.SpawnAtSafePlanet("ARGUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Drogen_Hosh_Team"})
	StoryUtil.SpawnAtSafePlanet("ELROOD", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team","Sora_Bulq_Team","Shaala_Doneeta_Team"})
	StoryUtil.SpawnAtSafePlanet("XAGOBAH", p_cis, StoryUtil.GetSafePlanetTable(), {"Vetlya_Core_Destroyer"})
	StoryUtil.SafeSpawnFavourHero("XAGOBAH", p_cis, {"Tambor_Team","Tonith_Corpulentus"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})

	StoryUtil.SpawnAtSafePlanet("MIZTOC", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Nejaa_Halcyon_Team","Grudo_Team","Anakin_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("HARUUN_KAL", p_republic, StoryUtil.GetSafePlanetTable(), {"Lorz_Geptun_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Paige_Tarkin_Team","Tarkin_Venator","Gideon_Tarkin_Team"})
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	StoryUtil.SetPlanetRestricted("PRAESITLYN", 1, false)
	StoryUtil.SetPlanetRestricted("BPFASSH", 1, false)

	StoryUtil.SpawnAtSafePlanet("ARGUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Drogen_Hosh_Team"})
	StoryUtil.SpawnAtSafePlanet("ELROOD", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team","Sora_Bulq_Team","Shaala_Doneeta_Team"})
	StoryUtil.SpawnAtSafePlanet("XAGOBAH", p_cis, StoryUtil.GetSafePlanetTable(), {"Vetlya_Core_Destroyer"})
	StoryUtil.SafeSpawnFavourHero("XAGOBAH", p_cis, {"Tambor_Team","Tonith_Corpulentus"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})

	StoryUtil.SpawnAtSafePlanet("MIZTOC", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Nejaa_Halcyon_Team","Grudo_Team","Anakin_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("HARUUN_KAL", p_republic, StoryUtil.GetSafePlanetTable(), {"Lorz_Geptun_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Paige_Tarkin_Team","Tarkin_Venator","Gideon_Tarkin_Team","Zozridor_Slayke_Carrack"})

	Create_Thread("State_CIS_Quest_Checker_Bpfassh")
end
function State_CIS_Quest_Checker_Bpfassh()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_CIS.XML")

	if TestValid(Find_First_Object("Ventress")) then
		local event_act_1 = plot.Get_Event("CIS_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Ventress"))
		if TestValid(Find_First_Object("Ventress").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Ventress").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("CIS_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Ventress_Team"))

	elseif TestValid(Find_First_Object("Sora_Bulq")) then
		local event_act_1 = plot.Get_Event("CIS_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Sora_Bulq"))
		if TestValid(Find_First_Object("Sora_Bulq").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Sora_Bulq").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("CIS_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Sora_Bulq_Team"))

	elseif TestValid(Find_First_Object("Munificent")) then
		local event_act_1 = plot.Get_Event("CIS_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Munificent"))
		if TestValid(Find_First_Object("Munificent").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Munificent").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("CIS_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Munificent"))

	else
		Sleep(5.0)
		Story_Event("CIS_BPFASSH_CHEAT")
	end

	Sleep(5.0)
	if not cis_quest_bpfassh_over then
		Create_Thread("State_CIS_Quest_Checker_Bpfassh")
	end
end
function State_CIS_Tomb_Torment_Epilogue(message)
	if message == OnEnter then
		cis_quest_bpfassh_over = true
		Story_Event("CIS_BPFASSH_END")
		StoryUtil.SetPlanetRestricted("BPFASSH", 0)
	end
end

function State_CIS_KnightHammer_Planet_Hunt(message)
	if message == OnEnter then
		Story_Event("CIS_PLANET_HUNT_START")

		Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	end
end
function State_CIS_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_CIS.XML")

	local KnightHammer_PlanetList = {
		FindPlanet("Riflor"),
		FindPlanet("Bespin"),
		FindPlanet("Mustafar"),
		FindPlanet("Eriadu"),
		FindPlanet("Bormus"),
		FindPlanet("Sluis_Van"),
	}

	event_act_2 = plot.Get_Event("CIS_KnightHammer_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
	event_act_2.Clear_Dialog_Text()

	for _,p_planet in pairs(KnightHammer_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		elseif p_planet.Get_Owner() == p_cis then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Riflor").Get_Owner() == p_cis
	and FindPlanet("Bespin").Get_Owner() == p_cis
	and FindPlanet("Mustafar").Get_Owner() == p_cis
	and FindPlanet("Eriadu").Get_Owner() == p_cis
	and FindPlanet("Bormus").Get_Owner() == p_cis
	and FindPlanet("Sluis_Van").Get_Owner() == p_cis then
		cis_quest_planet_hunt_over = true
		Story_Event("CIS_PLANET_HUNT_END")
	end

	Sleep(5.0)
	if not cis_quest_planet_hunt_over then
		Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	end
end

function State_CIS_KnightHammer_Praesitlyn_Siege(message)
	if message == OnEnter then
		Story_Event("CIS_PRAESITLYN_SIEGE_START")

		StoryUtil.SetPlanetRestricted("PRAESITLYN", 0)

		Create_Thread("State_CIS_Quest_Checker_Praesitlyn_Siege")
	end
end
function State_CIS_Quest_Checker_Praesitlyn_Siege()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_CIS.XML")

	local event_act_3 = plot.Get_Event("CIS_KnightHammer_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
	event_act_3.Clear_Dialog_Text()
	if FindPlanet("Praesitlyn").Get_Owner() ~= p_cis then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Praesitlyn"))
	elseif FindPlanet("Praesitlyn").Get_Owner() == p_cis then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Praesitlyn"))
		Story_Event("CIS_PRAESITLYN_SIEGE_END")

		cis_quest_praesitlyn_siege_over = true
	end

	Sleep(5.0)
	if not cis_quest_praesitlyn_siege_over then
		Create_Thread("State_CIS_Quest_Checker_Praesitlyn_Siege")
	end
end

function State_CIS_KnightHammer_Communication(message)
	if message == OnEnter then
		Story_Event("CIS_COMMUNICATION_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_CIS.XML")

		local event_act_4 = plot.Get_Event("CIS_KnightHammer_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Praesitlyn_ComCenter"))
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Praesitlyn"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Praesitlyn_ComCenter"))
	end
end
function State_CIS_Praesitlyn_ComCenter_Research(message)
	if message == OnEnter then
		CIS_quest_communication_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_CIS.XML")

		local event_act_4 = plot.Get_Event("CIS_KnightHammer_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_KnightHammer_CIS")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Praesitlyn_ComCenter"))

		Story_Event("CIS_COMMUNICATION_END")
	end
end

function State_CIS_KnightHammer_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.LoadCampaign("Sandbox_DurgesLance_CIS", 0)
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	StoryUtil.SpawnAtSafePlanet("ARGUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Drogen_Hosh_Team"})
	StoryUtil.SpawnAtSafePlanet("ELROOD", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team","Sora_Bulq_Team","Shaala_Doneeta_Team"})
	StoryUtil.SpawnAtSafePlanet("XAGOBAH", p_cis, StoryUtil.GetSafePlanetTable(), {"Vetlya_Core_Destroyer"})
	StoryUtil.SafeSpawnFavourHero("XAGOBAH", p_cis, {"Tambor_Team","Tonith_Corpulentus"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})

	StoryUtil.SpawnAtSafePlanet("MIZTOC", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Nejaa_Halcyon_Team","Grudo_Team","Anakin_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("HARUUN_KAL", p_republic, StoryUtil.GetSafePlanetTable(), {"Lorz_Geptun_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Paige_Tarkin_Team","Tarkin_Venator","Gideon_Tarkin_Team"})

	StoryUtil.RevealPlanet("DAGOBAH", false)

	StoryUtil.SetPlanetRestricted("BESPIN", 1, false)
	StoryUtil.SetPlanetRestricted("BPFASSH", 1, false)
	StoryUtil.SetPlanetRestricted("PRAESITLYN", 1, false)

	Create_Thread("State_Rep_Quest_Checker_Bpfassh")
end
function State_Rep_Quest_Checker_Bpfassh()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

	if TestValid(Find_First_Object("Anakin")) then
		local event_act_1 = plot.Get_Event("Rep_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin"))
		if TestValid(Find_First_Object("Anakin").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("Rep_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Anakin_Delta_Team"))

	elseif TestValid(Find_First_Object("Yoda")) then
		local event_act_1 = plot.Get_Event("Rep_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Yoda"))
		if TestValid(Find_First_Object("Yoda").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Yoda").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("Rep_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Yoda_Delta_Team"))

	elseif TestValid(Find_First_Object("Starbolt")) then
		local event_act_1 = plot.Get_Event("Rep_KnightHammer_Act_I_Dialog")
		event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Starbolt"))
		if TestValid(Find_First_Object("Starbolt").Get_Planet_Location()) then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Starbolt").Get_Planet_Location())
		end
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bpfassh"))
		event_act_1.Add_Dialog_Text("TEXT_NONE")

		local event_act_1_task_01 = plot.Get_Event("Rep_Hero_Enter_Bpfassh")
		event_act_1_task_01.Set_Event_Parameter(2, Find_Object_Type("Starbolt"))

	else
		Sleep(5.0)
		Story_Event("REP_BPFASSH_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_bpfassh_over then
		Create_Thread("State_Rep_Quest_Checker_Bpfassh")
	end
end
function State_Rep_Tomb_Torment_Epilogue(message)
	if message == OnEnter then
		rep_quest_bpfassh_over = true
		Story_Event("REP_BPFASSH_END")
		StoryUtil.SetPlanetRestricted("BPFASSH", 0)
	end
end

function State_Rep_KnightHammer_Praesitlyn_Siege(message)
	if message == OnEnter then
		Story_Event("REP_PRAESITLYN_SIEGE_START")
		Sleep(10.0)

		MissionUtil.FlashPlanet("PRAESITLYN", "GUI_Flash_Praesitlyn")
		MissionUtil.PositionCamera("PRAESITLYN")

		Create_Thread("State_Rep_Quest_Checker_Praesitlyn_Siege")
	end
end
function State_Rep_Quest_Checker_Praesitlyn_Siege()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

	if TestValid(Find_First_Object("Anakin")) then
		local event_act_2 = plot.Get_Event("Rep_KnightHammer_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin"))
		if TestValid(Find_First_Object("Anakin").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Praesitlyn"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Rep_Hero_Enter_Praesitlyn")
		event_act_2_task_01.Set_Event_Parameter(2, Find_Object_Type("Anakin_Delta_Team"))

	elseif TestValid(Find_First_Object("Nejaa_Halcyon")) then
		local event_act_2 = plot.Get_Event("Rep_KnightHammer_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Nejaa_Halcyon"))
		if TestValid(Find_First_Object("Nejaa_Halcyon").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Nejaa_Halcyon").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Praesitlyn"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Rep_Hero_Enter_Praesitlyn")
		event_act_2_task_01.Set_Event_Parameter(2, Find_Object_Type("Nejaa_Halcyon_Team"))

	elseif TestValid(Find_First_Object("Starbolt")) then
		local event_act_2 = plot.Get_Event("Rep_KnightHammer_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Starbolt"))
		if TestValid(Find_First_Object("Starbolt").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Starbolt").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Praesitlyn"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Rep_Hero_Enter_Praesitlyn")
		event_act_2_task_01.Set_Event_Parameter(2, Find_Object_Type("Starbolt"))

	else
		Sleep(5.0)
		Story_Event("REP_PRAESITLYN_SIEGE_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_praesitlyn_siege_over then
		Create_Thread("State_Rep_Quest_Checker_Praesitlyn_Siege")
	end
end
function State_Rep_Praesitlyn_Pressure_Epilogue(message)
	if message == OnEnter then
		rep_quest_praesitlyn_siege_over = true

		Story_Event("REP_PRAESITLYN_SIEGE_END")

		if (GlobalValue.Get("OKH_Praesitlyn_Problems_Outcome") == 1) then
			StoryUtil.SpawnAtSafePlanet("PRAESITLYN", p_republic, StoryUtil.GetSafePlanetTable(), {"Zozridor_Slayke_Carrack"})
		end

		StoryUtil.SetPlanetRestricted("PRAESITLYN", 0)
	end
end

function State_Rep_KnightHammer_Communication(message)
	if message == OnEnter then
		Story_Event("REP_COMMUNICATION_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_KnightHammer_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Praesitlyn_ComCenter"))
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Praesitlyn"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Praesitlyn_ComCenter"))
	end
end
function State_Rep_Praesitlyn_ComCenter_Research(message)
	if message == OnEnter then
		rep_quest_communication_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_3 = plot.Get_Event("Rep_KnightHammer_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Praesitlyn_ComCenter"))

		Story_Event("REP_COMMUNICATION_END")
	end
end

function State_Rep_KnightHammer_Jedi_Cage(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_CAGE_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_KnightHammer_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Rogue_Jedi_Detention_Facility"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Rogue_Jedi_Detention_Facility"))
	end
end
function State_Rep_Detention_Facility_Research(message)
	if message == OnEnter then
		rep_quest_jedi_cage_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_KnightHammer_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Rogue_Jedi_Detention_Facility"))

		Story_Event("REP_JEDI_CAGE_END")
	end
end

function State_Rep_KnightHammer_Jedi_Hunt(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_HUNT_START")
		Create_Thread("State_Rep_Quest_Checker_Jedi_Hunt")
	end
end
function State_Rep_Quest_Checker_Jedi_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")
	local event_act_5 = plot.Get_Event("Rep_KnightHammer_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
	event_act_5.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_SEARCH_SCOUTING_01", nil, true) or FindPlanet("Mustafar").Get_Owner() == p_republic then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", FindPlanet("Mustafar"))
		rep_quest_jedi_hunt_target_01_over = true
	else
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", FindPlanet("Mustafar"))
	end
	if Check_Story_Flag(p_republic, "REP_SEARCH_SCOUTING_02", nil, true) or FindPlanet("Riflor").Get_Owner() == p_republic then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", FindPlanet("Riflor"))
		rep_quest_jedi_hunt_target_02_over = true
	else
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", FindPlanet("Riflor"))
	end
	if Check_Story_Flag(p_republic, "REP_SEARCH_SCOUTING_03", nil, true) or FindPlanet("Skye").Get_Owner() == p_republic then
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", FindPlanet("Skye"))
		rep_quest_jedi_hunt_target_03_over = true
	else
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", FindPlanet("Skye"))
	end

	if rep_quest_jedi_hunt_target_01_over
	and rep_quest_jedi_hunt_target_02_over
	and rep_quest_jedi_hunt_target_03_over then
		rep_quest_jedi_hunt_over = true
		Story_Event("REP_JEDI_HUNT_END")
	end

	Sleep(5.0)
	if not rep_quest_jedi_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Jedi_Hunt")
	end
end

function State_Rep_KnightHammer_Bespin(message)
	if message == OnEnter then
		Story_Event("REP_BESPIN_START")
		Sleep(10.0)

		MissionUtil.FlashPlanet("BESPIN", "GUI_Flash_Bespin")
		MissionUtil.PositionCamera("BESPIN")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")
		local event_act_6 = plot.Get_Event("Rep_Fleet_Bounce_Bespin")
		event_act_6.Set_Reward_Parameter(0, "TEXT_STORY_KNIGHT_HAMMER_REP_BOUNCE_BESPIN_01")

		Create_Thread("State_Rep_Quest_Checker_Bespin")
	end
end
function State_Rep_Quest_Checker_Bespin()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

	if TestValid(Find_First_Object("Anakin")) then
		local event_act_6 = plot.Get_Event("Rep_KnightHammer_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin"))
		if TestValid(Find_First_Object("Anakin").Get_Planet_Location()) then
			event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin").Get_Planet_Location())
		end
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bespin"))
		event_act_6.Add_Dialog_Text("TEXT_NONE")

		local event_act_6_task_01 = plot.Get_Event("Rep_Hero_Enter_Bespin")
		event_act_6_task_01.Set_Event_Parameter(2, Find_Object_Type("Anakin_Delta_Team"))

	elseif TestValid(Find_First_Object("Nejaa_Halcyon")) then
		local event_act_6 = plot.Get_Event("Rep_KnightHammer_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Nejaa_Halcyon"))
		if TestValid(Find_First_Object("Nejaa_Halcyon").Get_Planet_Location()) then
			event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Nejaa_Halcyon").Get_Planet_Location())
		end
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bespin"))
		event_act_6.Add_Dialog_Text("TEXT_NONE")

		local event_act_6_task_01 = plot.Get_Event("Rep_Hero_Enter_Bespin")
		event_act_6_task_01.Set_Event_Parameter(2, Find_Object_Type("Nejaa_Halcyon_Team"))

	elseif TestValid(Find_First_Object("Starbolt")) then
		local event_act_6 = plot.Get_Event("Rep_KnightHammer_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Starbolt"))
		if TestValid(Find_First_Object("Starbolt").Get_Planet_Location()) then
			event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Starbolt").Get_Planet_Location())
		end
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Bespin"))
		event_act_6.Add_Dialog_Text("TEXT_NONE")

		local event_act_6_task_01 = plot.Get_Event("Rep_Hero_Enter_Bespin")
		event_act_6_task_01.Set_Event_Parameter(2, Find_Object_Type("Starbolt"))

	else
		Sleep(5.0)
		Story_Event("REP_BESPIN_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_bespin_over then
		Create_Thread("State_Rep_Quest_Checker_Bespin")
	end
end
function State_Rep_Bespin_Breakdown_Epilogue(message)
	if message == OnEnter then
		rep_quest_bespin_over = true
		Story_Event("REP_BESPIN_END")

		StoryUtil.SetPlanetRestricted("BESPIN", 0)
	end
end

function State_Rep_KnightHammer_Prison(message)
	if message == OnEnter then
		Story_Event("REP_PRISON_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_7 = plot.Get_Event("Rep_KnightHammer_Act_VII_Dialog")
		event_act_7.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_7.Clear_Dialog_Text()

		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Transfer_Rogue_Jedi"))
		if TestValid(Find_First_Object("Rogue_Jedi_Detention_Facility")) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", Find_First_Object("Rogue_Jedi_Detention_Facility").Get_Planet_Location())
		end
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Transfer_Rogue_Jedi"))
	end
end
function State_Rep_Transfer_Rogue_Jedi_Research(message)
	if message == OnEnter then
		rep_quest_prison_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

		local event_act_7 = plot.Get_Event("Rep_KnightHammer_Act_VII_Dialog")
		event_act_7.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_7.Clear_Dialog_Text()

		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Transfer_Rogue_Jedi"))

		Story_Event("REP_PRISON_END")
	end
end

function State_Rep_KnightHammer_Dagobah(message)
	if message == OnEnter then
		Story_Event("REP_DAGOBAH_START")
		Sleep(10.0)

		MissionUtil.FlashPlanet("DAGOBAH", "GUI_Flash_Dagobah")
		MissionUtil.PositionCamera("DAGOBAH")

		Create_Thread("State_Rep_Quest_Checker_Dagobah")
	end
end
function State_Rep_Quest_Checker_Dagobah()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Republic.XML")

	if TestValid(Find_First_Object("Yoda")) then
		local event_act_8 = plot.Get_Event("Rep_KnightHammer_Act_VIII_Dialog")
		event_act_8.Set_Dialog("Dialog_21_BBY_KnightHammer_Rep")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Yoda"))
		if TestValid(Find_First_Object("Yoda").Get_Planet_Location()) then
			event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Yoda").Get_Planet_Location())
		end
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Dagobah"))
		event_act_8.Add_Dialog_Text("TEXT_NONE")

		local event_act_8_task_01 = plot.Get_Event("Rep_Hero_Enter_Dagobah")
		event_act_8_task_01.Set_Event_Parameter(2, Find_Object_Type("Yoda_Delta_Team"))
	else
		Sleep(5.0)
		Story_Event("REP_DAGOBAH_CHEAT")
	end

	Sleep(5.0)
	if not rep_quest_dagobah_over then
		Create_Thread("State_Rep_Quest_Checker_Dagobah")
	end
end
function State_Rep_Dagobah_Darkness_Epilogue(message)
	if message == OnEnter then
		rep_quest_dagobah_over = true
		Story_Event("REP_DAGOBAH_END")
	end
end

function State_Rep_KnightHammer_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.LoadCampaign("Sandbox_AU_DurgesLance_Republic", 1)
	end
end

-- Hutts

function Hutts_Story_Set_Up(message)
	Story_Event("HUTTS_STORY_START")

	p_hutts.Lock_Tech(Find_Object_Type("Hutt_Office"))
	p_hutts.Lock_Tech(Find_Object_Type("Hutt_Capital"))

	p_hutts.Unlock_Tech(Find_Object_Type("Shadow_Collective_Office"))
	p_hutts.Unlock_Tech(Find_Object_Type("Shadow_Collective_Capital"))

	p_hutts.Unlock_Tech(Find_Object_Type("SC_Mandalorian_Soldier_Company"))
	p_hutts.Unlock_Tech(Find_Object_Type("SC_Mandalorian_Commando_Company"))
	p_hutts.Unlock_Tech(Find_Object_Type("SC_Komrk_Gunship_Group"))

	StoryUtil.SetPlanetRestricted("BESPIN", 1, false)

	crossplot:publish("INCREASE_FAVOUR", "SCUM", 100)
	Sleep(1.0)

	UnitUtil.DespawnList({"Ganis_Nal_Hutta_Jewel","Tagoonta","Riboga_Rightful_Dominion","Tobba_YTobba","Darth_Maul","Savage_Opress"})

	StoryUtil.SpawnAtSafePlanet("MUSTAFAR", p_hutts, StoryUtil.GetSafePlanetTable(), {"Lorka_Gedyc_Team"})

	StoryUtil.SpawnAtSafePlanet("ARGUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Drogen_Hosh_Team"})
	StoryUtil.SpawnAtSafePlanet("ELROOD", p_cis, StoryUtil.GetSafePlanetTable(), {"Ventress_Team","Sora_Bulq_Team","Shaala_Doneeta_Team"})
	StoryUtil.SpawnAtSafePlanet("XAGOBAH", p_cis, StoryUtil.GetSafePlanetTable(), {"Vetlya_Core_Destroyer"})
	StoryUtil.SafeSpawnFavourHero("XAGOBAH", p_cis, {"Tambor_Team","Tonith_Corpulentus"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})

	StoryUtil.SpawnAtSafePlanet("MIZTOC", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("BORMUS", p_republic, StoryUtil.GetSafePlanetTable(), {"Nejaa_Halcyon_Team","Grudo_Team","Anakin_Delta_Team"})
	StoryUtil.SpawnAtSafePlanet("HARUUN_KAL", p_republic, StoryUtil.GetSafePlanetTable(), {"Lorz_Geptun_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Paige_Tarkin_Team","Tarkin_Venator","Gideon_Tarkin_Team"})

	Create_Thread("State_Hutts_Quest_Checker_Survival")
end
function State_Hutts_Quest_Checker_Survival()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Hutts.XML")

	event_act_1 = plot.Get_Event("Hutts_KnightHammer_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_21_BBY_KnightHammer_Hutts")
	event_act_1.Clear_Dialog_Text()
	event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_TIMER_REMAINING", hutts_survival_timer_weeks)

	if not TestValid(Find_First_Object("Darth_Maul")) then
		hutts_survival_timer_seconds = hutts_survival_timer_seconds + 1
		if hutts_survival_timer_seconds == 40 then
			hutts_survival_timer_weeks = hutts_survival_timer_weeks - 1
			hutts_survival_timer_seconds = 0
		end

		if hutts_survival_timer_weeks == 0 then
			hutts_quest_survival_over = true

			--Story_Event("HUTTS_SURVIVAL_TACTICAL")
			Sleep(2.0)

			StoryUtil.SpawnAtSafePlanet("MATAOU", p_hutts, StoryUtil.GetSafePlanetTable(), {"Ganis_Nal_Hutta_Jewel","Tagoonta_Team","Riboga_Rightful_Dominion","Tobba_YTobba"})
			StoryUtil.SpawnAtSafePlanet("MUSTAFAR", p_hutts, StoryUtil.GetSafePlanetTable(), {"Darth_Maul_Team","Savage_Opress_Team","Pre_Vizsla_Team","Bo_Katan_Team"})

			Story_Event("HUTTS_SURVIVAL_END")
		end
	end

	Sleep(1.0)
	if not hutts_quest_survival_over then
		Create_Thread("State_Hutts_Quest_Checker_Survival")
	end
end

function State_Mauling_Mustafar_Epilogue(message)
	if message == OnEnter then
		Sleep(1.0)
		if not TestValid(Find_First_Object("Shadow_Collective_Capital")) then
			StoryUtil.SpawnAtSafePlanet("MUSTAFAR", p_hutts, StoryUtil.GetSafePlanetTable(), {"Shadow_Collective_Capital","Shadow_Collective_Office","Mining_Facility_Minerals_Ground","Hutt_Star_Base_2","Hutt_Shipyard_Level_Two"})
		end

		UnitUtil.DespawnList({"Ganis_Nal_Hutta_Jewel","Tagoonta","Riboga_Rightful_Dominion","Tobba_YTobba","Darth_Maul","Savage_Opress"})
	end
end

function State_Hutts_KnightHammer_Vigo_Hunt(message)
	if message == OnEnter then
		Story_Event("HUTTS_VIGO_HUNT_START")

		StoryUtil.SpawnAtSafePlanet("BESPIN", p_independent, StoryUtil.GetSafePlanetTable(), {"Xist_Team","Amanza_Space_ARC_Cruiser"})

		StoryUtil.SetPlanetRestricted("BESPIN", 0)

		Create_Thread("State_Hutts_Quest_Checker_Vigo_Hunt")
	end
end
function State_Hutts_Quest_Checker_Vigo_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsKnightHammer\\Story_Sandbox_KnightHammer_Hutts.XML")

	local event_act_2 = plot.Get_Event("Hutts_KnightHammer_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_21_BBY_KnightHammer_Hutts")
	event_act_2.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Xist")) then
		event_act_2.Add_Dialog_Text("Target: Lord Xist")
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Xist").Get_Planet_Location())
	else
		event_act_2.Add_Dialog_Text("Target: Lord Xist (Defeated)")
	end
	if TestValid(Find_First_Object("Amanza_Space_ARC_Cruiser")) then
		event_act_2.Add_Dialog_Text("Target: Vigo Amanza Regalo")
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Amanza_Space_ARC_Cruiser").Get_Planet_Location())
	else
		event_act_2.Add_Dialog_Text("Target: Vigo Amanza Regalo (Defeated)")
	end

	if not TestValid(Find_First_Object("Xist"))
	and not TestValid(Find_First_Object("Amanza_Space_ARC_Cruiser")) then
		hutts_quest_vigo_hunt_over = true
		Story_Event("HUTTS_VIGO_HUNT_END")
	end

	event_act_2.Add_Dialog_Text("TEXT_NONE")

	Sleep(5.0)
	if not hutts_quest_vigo_hunt_over then
		Create_Thread("State_Hutts_Quest_Checker_Vigo_Hunt")
	end
end

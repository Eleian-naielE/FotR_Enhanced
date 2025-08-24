--****************************************************--
--****   Fall of the Republic: Outer Rim Sieges   ****--
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
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		-- Generic
		Trigger_Historical_GC_Choice_Prompt = State_Historical_GC_Choice_Prompt,

		-- CIS
		CIS_Giants_Graveyard_Epilogue = State_CIS_Giants_Graveyard_Epilogue,

		Trigger_CIS_OuterRimSieges_Cato_Neimoidia = State_CIS_OuterRimSieges_Cato_Neimoidia,
		CIS_Cato_Castle_Clash_Epilogue = State_CIS_Cato_Castle_Clash_Epilogue,

		Trigger_CIS_OuterRimSieges_Belderone = State_CIS_OuterRimSieges_Belderone,
		CIS_Breaking_Belderone_Epilogue = State_CIS_Breaking_Belderone_Epilogue,

		Trigger_CIS_OuterRimSieges_Meeting = State_CIS_OuterRimSieges_Meeting,

		Trigger_CIS_OuterRimSieges_Utapau = State_CIS_OuterRimSieges_Utapau,

		Trigger_CIS_OuterRimSieges_Morgukai = State_CIS_OuterRimSieges_Morgukai,
		Trigger_CIS_OuterRimSieges_Morgukai_Research = State_CIS_OuterRimSieges_Morgukai_Research,
		CIS_Saleucami_Siege_Epilogue = State_CIS_Saleucami_Siege_Epilogue,

		Trigger_CIS_OuterRimSieges_Tythe = State_CIS_OuterRimSieges_Tythe,

		Trigger_CIS_OuterRimSieges_Coruscant = State_CIS_OuterRimSieges_Coruscant,
		CIS_Coruscant_Cataclysm_Epilogue = State_CIS_Coruscant_Cataclysm_Epilogue,

		Trigger_CIS_OuterRimSieges_Rebellion = State_CIS_OuterRimSieges_Rebellion,

		CIS_OuterRimSieges_GC_Progression = State_CIS_OuterRimSieges_GC_Progression,

		-- Republic
		Rep_Giants_Graveyard_Epilogue = State_Rep_Giants_Graveyard_Epilogue,

		Trigger_Rep_OuterRimSieges_Trackdown = State_Rep_OuterRimSieges_Trackdown,
		Trigger_Rep_Enter_Heroes_Trackdown = State_Rep_Enter_Heroes_Trackdown,

		Trigger_Rep_OuterRimSieges_Saleucami = State_Rep_OuterRimSieges_Saleucami,

		Trigger_Rep_OuterRimSieges_Felucia = State_Rep_OuterRimSieges_Felucia,

		Trigger_Rep_OuterRimSieges_Deception = State_Rep_OuterRimSieges_Deception,
		Rep_Dooku_Domicile_Epilogue = State_Rep_Dooku_Domicile_Epilogue,

		Trigger_Rep_OuterRimSieges_Cato_Neimoidia = State_Rep_OuterRimSieges_Cato_Neimoidia,
		Rep_Cato_Castle_Clash_Epilogue = State_Rep_Cato_Castle_Clash_Epilogue,

		Trigger_Rep_OuterRimSieges_Chair = State_Rep_OuterRimSieges_Chair,
		Trigger_Rep_Deploy_Heroes_Chair = State_Rep_Deploy_Heroes_Chair,

		Trigger_Rep_OuterRimSieges_Sidious_Hunt = State_Rep_OuterRimSieges_Sidious_Hunt,

		Trigger_Rep_OuterRimSieges_Tythe = State_Rep_OuterRimSieges_Tythe,

		Trigger_Rep_OuterRimSieges_Coruscant = State_Rep_OuterRimSieges_Coruscant,
		Rep_Coruscant_Cataclysm_Epilogue = State_Rep_Coruscant_Cataclysm_Epilogue,

		Trigger_Rep_OuterRimSieges_RotS = State_Rep_OuterRimSieges_RotS,
		Rep_Temple_Tragedy_Epilogue = State_Rep_Temple_Tragedy_Epilogue,

		Trigger_Rep_OuterRimSieges_Mustafar = State_Rep_OuterRimSieges_Mustafar,
		Trigger_Rep_Enter_Heroes_Mustafar = State_Rep_Enter_Heroes_Mustafar,

		Trigger_Rep_OuterRimSieges_Jedi_Hunt = State_Rep_OuterRimSieges_Jedi_Hunt,

		Trigger_Rep_OuterRimSieges_Frigates = State_Rep_OuterRimSieges_Frigates,
		Trigger_Rep_OuterRimSieges_Frigate_Research = State_Rep_OuterRimSieges_Frigate_Research,

		Rep_OuterRimSieges_GC_Progression = State_Rep_OuterRimSieges_GC_Progression,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_independent_forces = Find_Player("Independent_Forces")
	p_sector_forces = Find_Player("Sector_Forces")

	all_planets_conquered = false

	cis_quest_deception_over = false
	cis_quest_cato_neimoidia_over = false
	cis_quest_belderone_over = false
	cis_quest_meeting_over = false
	cis_quest_utapau_over = false
	cis_quest_morgukai_over = false
	cis_quest_tythe_over = false
	cis_quest_coruscant_over = false
	cis_quest_rebellion_over = false

	cis_deception_act_1 = false
	cis_deception_act_2 = false
	cis_deception_act_3 = false

	cis_utapau_hero_counter = 0
	cis_utapau_hero_amount = 0

	rep_quest_trackdown_over = false
	rep_quest_saleucami_over = false
	rep_quest_felucia_over = false
	rep_quest_deception_over = false
	rep_quest_cato_neimoidia_over = false
	rep_quest_chair_over = false
	rep_quest_sidious_hunt_over = false
	rep_quest_tythe_over = false
	rep_quest_coruscant_over = false
	rep_quest_rots_over = false
	rep_quest_mustafar_over = false
	rep_quest_jedi_hunt_over = false
	rep_quest_frigates_over = false

	rep_deception_act_1 = false
	rep_deception_act_2 = false

	p_rep_quest_chair_hero_1 = nil
	p_rep_quest_chair_hero_type_1 = nil
	p_rep_quest_chair_hero_2 = nil
	p_rep_quest_chair_hero_type_2 = nil

	rep_sidious_hunt_act_1 = false
	rep_sidious_hunt_act_2 = false
	rep_sidious_hunt_act_3 = false

	rep_rots_enter_hero_01 = false
	rep_rots_enter_hero_02 = false
	rep_rots_enter_hero_03 = false
	rep_rots_enter_hero_04 = false

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("ORS_CIS_GC_Version", 0) -- 3 = Ningo Alive; 2 = CIS Kuat; 1 = CIS Kuat and Maly; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("ORS_CIS_GC_Version", 1) -- 3 = Ningo Alive; 2 = CIS Kuat; 1 = CIS Kuat and Maly; 0 = Canonical Version
			elseif TestValid(Find_First_Object("GC_AU_2_Dummy")) then
				GlobalValue.Set("ORS_CIS_GC_Version", 2) -- 3 = Ningo Alive; 2 = CIS Kuat; 1 = CIS Kuat and Maly; 0 = Canonical Version
			elseif TestValid(Find_First_Object("GC_AU_3_Dummy")) then
				GlobalValue.Set("ORS_CIS_GC_Version", 3) -- 3 = Ningo Alive; 2 = CIS Kuat; 1 = CIS Kuat and Maly; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("ORS_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("ORS_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("Bulwark_I"))
		p_cis.Unlock_Tech(Find_Object_Type("Bulwark_II"))

		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Providence_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Recusant_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Fleet_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Victory_II_Star_Destroyer"))

		p_republic.Lock_Tech(Find_Object_Type("Invincible_Cruiser"))

		GlobalValue.Set("MissionOutcome_GIANTS_GRAVEYARD", 0) -- 1 = AU Version; 0 = Canonical Version

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
	crossplot:publish("VICTORY1_HEROES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["LOCKIN"] = {"Tarkin"},
			},
			["NAVY"] = {
				["SLOT_ADJUST"] = 0,
				["LOCKIN"] = {"Dodonna"},
				["EXIT"] = {"Kilian","Dron","Dao","Grumby"},
			},
			["ARMY"] = {
				["EXIT"] = {"Solomahal"},
			},
			["CLONE"] = {
				["LOCKIN"] = {"Cody","Bly"},
				["EXIT"] = {"Rex"},
			},
			["COMMANDO"] = {
				["LOCKIN"] = {"Fordo"},
				["EXIT"] = {"Alpha"},
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Mace","Yoda","Aayla"},
				["EXIT"] = {"Halcyon","Ahsoka","Barriss"},
			},
		})

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	ChangePlanetOwnerAndRetreat(FindPlanet("Boz_Pity"), p_republic)

	local spawn_list = {
		"Republic_Jedi_Knight_Company",
		"Clonetrooper_Phase_Two_Company",
		"Clonetrooper_Phase_Two_Company",
		"Clone_Galactic_Marine_Company",
		"Acclamator_II",
		"Empire_Office",
		"E_Ground_Barracks",
		"E_Ground_Heavy_Vehicle_Factory",
		"Ground_Planetary_Shield",
	}

	SpawnList(spawn_list, FindPlanet("Boz_Pity"), p_republic, false, false)

	StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Invisible_Hand"})
	StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team"})
	StoryUtil.SpawnAtSafePlanet("SERENNO", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Team","Lucid_Voice"})
	StoryUtil.SpawnAtSafePlanet("OSSUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Vazus_Team"})
	StoryUtil.SpawnAtSafePlanet("SISKEEN", p_cis, StoryUtil.GetSafePlanetTable(), {"Harsol_Munificent"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})
	StoryUtil.SpawnAtSafePlanet("SY_MYRTH", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Team"})
	StoryUtil.SpawnAtSafePlanet("NEW_BORNALEX", p_cis, StoryUtil.GetSafePlanetTable(), {"Tobbi_Dala_Team","Fenn_Shysa_Team","Spar_Team"})
	StoryUtil.SpawnAtSafePlanet("THYFERRA", p_cis, StoryUtil.GetSafePlanetTable(), {"Colicoid_Swarm"})

	StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_Eta_Team","Obi_Wan_Eta_Team","Cody2_Team","Wessex_Redoubt"})
	StoryUtil.SpawnAtSafePlanet("KASHYYYK", p_republic, StoryUtil.GetSafePlanetTable(), {"Delta_Squad"})
	StoryUtil.SpawnAtSafePlanet("CENTARES", p_republic, StoryUtil.GetSafePlanetTable(), {"Aayla_Secura_Eta_Team","Bly2_Team"})
	StoryUtil.SpawnAtSafePlanet("ORINDA", p_republic, StoryUtil.GetSafePlanetTable(), {"Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo2_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Tarkin_Venator"})
	StoryUtil.SpawnAtSafePlanet("CORELLIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Dodonna_Ardent"})

	p_republic.Lock_Tech(Find_Object_Type("Arquitens"))
	p_republic.Lock_Tech(Find_Object_Type("Acclamator_I_Assault"))
	p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Frigate"))
	p_republic.Unlock_Tech(Find_Object_Type("Imperial_I_Frigate"))
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	StoryUtil.RevealPlanet("CORUSCANT", false)
	StoryUtil.RevealPlanet("BELDERONE", false)

	StoryUtil.SetPlanetRestricted("CATO_NEIMOIDIA", 1, false)
	StoryUtil.SetPlanetRestricted("CORUSCANT", 1, false)
	StoryUtil.SetPlanetRestricted("BELDERONE", 1, false)
	StoryUtil.SetPlanetRestricted("TYTHE", 1, false)

	StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team"})
	StoryUtil.SpawnAtSafePlanet("OSSUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Vazus_Team"})
	StoryUtil.SpawnAtSafePlanet("SISKEEN", p_cis, StoryUtil.GetSafePlanetTable(), {"Harsol_Munificent"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})
	StoryUtil.SpawnAtSafePlanet("NEW_BORNALEX", p_cis, StoryUtil.GetSafePlanetTable(), {"Tobbi_Dala_Team","Fenn_Shysa_Team","Spar_Team"})
	StoryUtil.SpawnAtSafePlanet("THYFERRA", p_cis, StoryUtil.GetSafePlanetTable(), {"Colicoid_Swarm"})

	StoryUtil.SpawnAtSafePlanet("KASHYYYK", p_republic, StoryUtil.GetSafePlanetTable(), {"Delta_Squad"})
	StoryUtil.SpawnAtSafePlanet("CENTARES", p_republic, StoryUtil.GetSafePlanetTable(), {"Aayla_Secura_Eta_Team","Bly2_Team"})
	StoryUtil.SpawnAtSafePlanet("ORINDA", p_republic, StoryUtil.GetSafePlanetTable(), {"Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Tarkin_Venator"})
	StoryUtil.SpawnAtSafePlanet("CORELLIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Dodonna_Ardent"})
	StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Eta_Team"})

	p_republic.Lock_Tech(Find_Object_Type("Arquitens"))
	p_republic.Lock_Tech(Find_Object_Type("Acclamator_I_Assault"))
	p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Frigate"))
	p_republic.Unlock_Tech(Find_Object_Type("Imperial_I_Frigate"))

	if (GlobalValue.Get("ORS_CIS_GC_Version") == 0) then
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, Safe_House_Planet, {"Grievous_Invisible_Hand"})

	elseif (GlobalValue.Get("ORS_CIS_GC_Version") == 1) then
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, Safe_House_Planet, {"Grievous_Malevolence"})

		p_cis.Unlock_Tech(Find_Object_Type("Storm_Fleet_Destroyer"))

	elseif (GlobalValue.Get("ORS_CIS_GC_Version") == 2) then
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, Safe_House_Planet, {"Grievous_Invisible_Hand"})

		p_cis.Unlock_Tech(Find_Object_Type("Storm_Fleet_Destroyer"))

	elseif (GlobalValue.Get("ORS_CIS_GC_Version") == 3) then
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, Safe_House_Planet, {"Grievous_Invisible_Hand"})

		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("ANAXES", p_cis, Safe_House_Planet, {"Dua_Ningo_Unrepentant"})
	end

	Sleep(5.0)

	scout_target_01 = FindPlanet("Ruhe")
	cis_deception_act_1 = true

	Create_Thread("State_CIS_Quest_Checker_Deception")
end
function State_CIS_Quest_Checker_Deception()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")
	local event_act_1 = plot.Get_Event("CIS_OuterRimSieges_Act_I_Dialog_01")
	event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_1.Clear_Dialog_Text()

	if Check_Story_Flag(p_cis, "CIS_DECEPTION_SCOUTING_01", nil, true) and cis_deception_act_1 then
		scout_target_02 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		cis_deception_act_1 = false
		cis_deception_act_2 = true
	end
	if Check_Story_Flag(p_cis, "CIS_DECEPTION_SCOUTING_02", nil, true) and cis_deception_act_2 then
		scout_target_03 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)

		cis_deception_act_2 = false
		cis_deception_act_3 = true
	end
	if Check_Story_Flag(p_cis, "CIS_DECEPTION_SCOUTING_03", nil, true) and cis_deception_act_3 then

		cis_deception_act_3 = false
		cis_quest_deception_over = true
	end

	if cis_deception_act_1 then
		local event_act_1 = plot.Get_Event("CIS_OuterRimSieges_Act_I_Dialog_01")
		event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_1 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_01")
		event_act_1.Set_Event_Parameter(0, scout_target_01)
		event_act_1.Set_Event_Parameter(2, Find_Object_Type("Dooku_Stealth_Team"))
	end
	if cis_deception_act_2 then
		local event_act_1 = plot.Get_Event("CIS_OuterRimSieges_Act_I_Dialog_02")
		event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_1 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_02")
		event_act_1.Set_Event_Parameter(0, scout_target_02)
		event_act_1.Set_Event_Parameter(2, Find_Object_Type("Dooku_Stealth_Team"))
	end
	if cis_deception_act_3 then
		local event_act_1 = plot.Get_Event("CIS_OuterRimSieges_Act_I_Dialog_03")
		event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_03)

		event_act_1 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_03")
		event_act_1.Set_Event_Parameter(0, scout_target_03)
		event_act_1.Set_Event_Parameter(2, Find_Object_Type("Dooku_Stealth_Team"))
	end
	if cis_quest_deception_over then
		local event_act_1 = plot.Get_Event("CIS_OuterRimSieges_Act_I_Dialog_03")
		event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_1.Clear_Dialog_Text()

		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)
		event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_03)

		Story_Event("CIS_DECEPTION_END")
	end

	if not TestValid(Find_First_Object("Dooku_Stealth")) then
		StoryUtil.SpawnAtSafePlanet("SERENNO", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Stealth_Team"})
	end

	Sleep(5.0)
	if not cis_quest_deception_over then
		Create_Thread("State_CIS_Quest_Checker_Deception")
	end
end

function State_CIS_Giants_Graveyard_Epilogue(message)
	if message == OnEnter then
		if GlobalValue.Get("MissionOutcome_GIANTS_GRAVEYARD") == 0 then
			ChangePlanetOwnerAndRetreat(FindPlanet("Boz_Pity"), p_republic)

			local spawn_list = {
				"Republic_Jedi_Knight_Company",
				"Clonetrooper_Phase_Two_Company",
				"Clonetrooper_Phase_Two_Company",
				"Clone_Galactic_Marine_Company",
				"Acclamator_II",
				"Empire_Office",
				"E_Ground_Barracks",
				"E_Ground_Heavy_Vehicle_Factory",
				"Ground_Planetary_Shield",
			}

			SpawnList(spawn_list, FindPlanet("Boz_Pity"), p_republic, false, false)

			StoryUtil.SpawnAtSafePlanet("SERENNO", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Stealth_Team","Lucid_Voice"})

			StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo2_Team","Anakin_Eta_Team","Obi_Wan_Eta_Team","Cody2_Team","Wessex_Redoubt","Bail_Organa_Venator"})
		elseif GlobalValue.Get("MissionOutcome_GIANTS_GRAVEYARD") == 1 then
			ChangePlanetOwnerAndRetreat(FindPlanet("Boz_Pity"),p_cis)

			StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Dooku_Stealth_Team","Lucid_Voice","Ventress_Team"})

			StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo2_Team","Anakin_Eta_Team","Obi_Wan_Eta_Team","Cody2_Team","Wessex_Redoubt"})
		end

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_CIS_OuterRimSieges_Cato_Neimoidia(message)
	if message == OnEnter then
		Story_Event("CIS_CATO_NEIMOIDIA_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("CATO_NEIMOIDIA", "GUI_Flash_Cato_Neimoidia")
		MissionUtil.PositionCamera("CATO_NEIMOIDIA")
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Stealth_Team"})

		if not cis_quest_cato_neimoidia_over then
			Create_Thread("State_CIS_Quest_Checker_Cato_Neimoidia")
		end
	end
end
function State_CIS_Quest_Checker_Cato_Neimoidia()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	if TestValid(Find_First_Object("Nute_Gunray_Stealth")) then
		local event_act_2 = plot.Get_Event("CIS_OuterRimSieges_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Nute_Gunray_Stealth"))
		if TestValid(Find_First_Object("Nute_Gunray_Stealth").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Nute_Gunray_Stealth").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Cato_Neimoidia"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Cato_Neimoidia")
		event_act_2_task_01.Set_Event_Parameter(2, Find_Object_Type("Nute_Gunray_Stealth_Team"))
	end

	Sleep(5.0)
	if not cis_quest_cato_neimoidia_over then
		Create_Thread("State_CIS_Quest_Checker_Cato_Neimoidia")
	end
end
function State_CIS_Cato_Castle_Clash_Epilogue(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("CATO_NEIMOIDIA", 0)

		Sleep(1.0)
		Story_Event("CIS_CATO_NEIMOIDIA_END")
		ChangePlanetOwnerAndReplace(FindPlanet("Cato_Neimoidia"), p_cis)
		ChangePlanetOwnerAndRetreat(FindPlanet("Cato_Neimoidia"), p_republic)

		Sleep(3.0)
		p_republic = Find_Player("Empire")
		ChangePlanetOwnerAndRetreat(FindPlanet("Cato_Neimoidia"), p_republic)


		local spawn_list = {
			"Republic_Jedi_Knight_Company",
			"Clonetrooper_Phase_Two_Company",
			"Clonetrooper_Phase_Two_Company",
			"Clone_Galactic_Marine_Company",
			"Acclamator_II",
			"Empire_Office",
			"E_Ground_Barracks",
			"E_Ground_Heavy_Vehicle_Factory",
			"Ground_Planetary_Shield",
		}

		SpawnList(spawn_list, FindPlanet("Cato_Neimoidia"), Find_Player("Empire"), false, false)
	end
end

function State_CIS_OuterRimSieges_Belderone(message)
	if message == OnEnter then
		Story_Event("CIS_BELDERONE_START")

		MissionUtil.FlashPlanet("BELDERONE", "GUI_Flash_Belderone")
		MissionUtil.PositionCamera("BELDERONE")

		Create_Thread("State_CIS_Quest_Checker_Belderone")
	end
end
function State_CIS_Quest_Checker_Belderone()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local event_act_3 = plot.Get_Event("CIS_OuterRimSieges_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_3.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Invisible_Hand"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))
	elseif TestValid(Find_First_Object("Grievous_Recusant")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Recusant"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))
	elseif TestValid(Find_First_Object("Grievous_Munificent")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Munificent"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))
	elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Malevolence"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))
	elseif TestValid(Find_First_Object("Grievous_Malevolence_2")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Malevolence_2"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))
	elseif TestValid(Find_First_Object("General_Grievous")) then
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Grievous_Team"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))
	else
		event_act_3.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_BELDERONE", Find_Object_Type("Providence_Carrier_Destroyer"))

		event_act_3_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Belderone")
		event_act_3_01_task.Set_Event_Parameter(2, Find_Object_Type("Providence_Carrier_Destroyer"))
	end

	Sleep(5.0)
	if cis_quest_belderone_over then
		Create_Thread("State_CIS_Quest_Checker_Belderone")
	end
end
function State_CIS_Breaking_Belderone_Epilogue(message)
	if message == OnEnter then
		Story_Event("CIS_BELDERONE_END")
		
		cis_quest_belderone_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

		local event_act_3 = plot.Get_Event("CIS_OuterRimSieges_Act_III_Dialog")
		event_act_3.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_3.Clear_Dialog_Text()

		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_FAILED", FindPlanet("Rendili"))

		Sleep(2.0)
 		StoryUtil.SetPlanetRestricted("BELDERONE", 0)
	end
end

function State_CIS_OuterRimSieges_Meeting(message)
	if message == OnEnter then
		Story_Event("CIS_MEETING_START")
		Sleep(5.0)

		if not cis_quest_meeting_over then
			Create_Thread("State_CIS_Quest_Checker_Meeting")
		end
	end
end
function State_CIS_Quest_Checker_Meeting()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local Grievous_HeroList = {
		"GRIEVOUS_INVISIBLE_HAND",
		"GRIEVOUS_MUNIFICENT",
		"GRIEVOUS_RECUSANT",
		"GRIEVOUS_MALEVOLENCE",
		"GRIEVOUS_MALEVOLENCE_2",
		"GENERAL_GRIEVOUS",
	}

	local event_act_4 = plot.Get_Event("CIS_OuterRimSieges_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_4.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Nute_Gunray_Stealth")) then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Nute_Gunray_Stealth_Team"))
		if TestValid(Find_First_Object("Nute_Gunray_Stealth").Get_Planet_Location()) then
			event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Nute_Gunray_Stealth").Get_Planet_Location())
		end

		for _,p_hero in pairs(Grievous_HeroList) do
			if TestValid(Find_First_Object(p_hero)) then
				if TestValid(Find_First_Object(p_hero).Get_Planet_Location()) then
					event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type(p_hero))
					event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object(p_hero).Get_Planet_Location())
					if Find_First_Object(p_hero).Get_Planet_Location() == Find_First_Object("Nute_Gunray_Stealth").Get_Planet_Location() then
						Story_Event("CIS_MEETING_END")
						cis_quest_meeting_over = true

						UnitUtil.DespawnList({"Nute_Gunray_Stealth"})
						StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Team"})
					end
				end
			end
		end
	end

	if not TestValid(Find_First_Object("NUTE_GUNRAY")) and not TestValid(Find_First_Object("NUTE_GUNRAY_STEALTH")) then
		Story_Event("CIS_MEETING_END")
		cis_quest_meeting_over = true
		StoryUtil.SpawnAtSafePlanet("MURKHANA", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Team"})
	end

	Sleep(5.0)
	if not cis_quest_meeting_over then
		Create_Thread("State_CIS_Quest_Checker_Meeting")
	end
end

function State_CIS_OuterRimSieges_Utapau(message)
	if message == OnEnter then
		Story_Event("CIS_UTAPAU_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("UTAPAU", "GUI_Flash_Utapau")
		MissionUtil.PositionCamera("UTAPAU")

		if FindPlanet("Utapau").Get_Owner() ~= p_cis then
			ChangePlanetOwnerAndRetreat(FindPlanet("Utapau"), p_cis)
		end

		if not cis_quest_utapau_over then
			Create_Thread("State_CIS_Quest_Checker_Utapau")
		end
	end
end
function State_CIS_Quest_Checker_Utapau()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local ShadowCouncil_HeroList = {
		"NUTE_GUNRAY",
		"NUTE_GUNRAY_STEALTH",
		"WAT_TAMBOR",
		"POGGLE_AAT",
		"PASSEL_ARGENTE",
		"SHU_MAI_CASTELL",
		"SHU_MAI_SUBJUGATOR",
	}

	local event_act_5 = plot.Get_Event("CIS_OuterRimSieges_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_5.Clear_Dialog_Text()

	for _,p_hero in pairs(ShadowCouncil_HeroList) do
		if TestValid(Find_First_Object(p_hero)) then
			cis_utapau_hero_amount = cis_utapau_hero_amount + 1

			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type(p_hero))
			if TestValid(Find_First_Object(p_hero).Get_Planet_Location()) then
				event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object(p_hero).Get_Planet_Location())
				event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Utapau"))
				event_act_5.Add_Dialog_Text("TEXT_NONE")
			end
			if Find_First_Object(p_hero).Get_Planet_Location() == FindPlanet("Utapau") then
				cis_utapau_hero_counter = cis_utapau_hero_counter + 1
				if cis_utapau_hero_amount == cis_utapau_hero_counter then
					Story_Event("CIS_UTAPAU_END")
					cis_quest_utapau_over = true
				end
			end
		end
	end

	Sleep(5.0)
	if not cis_quest_utapau_over then
		cis_utapau_hero_counter = 0
		cis_utapau_hero_amount = 0
		Create_Thread("State_CIS_Quest_Checker_Utapau")
	end
end

function State_CIS_OuterRimSieges_Morgukai(message)
	if message == OnEnter then
		Story_Event("CIS_MORGUKAI_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

		local event_act_6 = plot.Get_Event("CIS_OuterRimSieges_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Morgukai_Warriors"))
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Salaucami"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Dummy_Research_Morgukai_Warriors"))
	end
end
function State_CIS_OuterRimSieges_Morgukai_Research(message)
	if message == OnEnter then
		cis_quest_morgukai_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

		local event_act_6 = plot.Get_Event("CIS_OuterRimSieges_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Morgukai_Warriors"))
		Sleep(5.0)

		Story_Event("CIS_MORGUKAI_TACTICAL")
	end
end
function State_CIS_Saleucami_Siege_Epilogue(message)
	if message == OnEnter then
		Story_Event("CIS_MORGUKAI_END")
		
		cis_quest_morgukai_over = true
	end
end

function State_CIS_OuterRimSieges_Tythe(message)
	if message == OnEnter then
		Story_Event("CIS_TYTHE_START")

		StoryUtil.SetPlanetRestricted("TYTHE", 0)

		if not cis_quest_tythe_over then
			Create_Thread("State_CIS_Quest_Checker_Tythe")
		end
	end
end
function State_CIS_Quest_Checker_Tythe()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local event_act_7 = plot.Get_Event("CIS_OuterRimSieges_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_7.Clear_Dialog_Text()

	if FindPlanet("Tythe").Get_Owner() ~= p_cis then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Tythe"))
	else
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Tythe"))
		Story_Event("CIS_TYTHE_END")
		cis_quest_tythe_over = true
	end

	Sleep(5.0)
	if not cis_quest_tythe_over then
		Create_Thread("State_CIS_Quest_Checker_Tythe")
	end
end

function State_CIS_OuterRimSieges_Coruscant(message)
	if message == OnEnter then
		Story_Event("CIS_CORUSCANT_START")

		if not cis_quest_coruscant_over then
			Create_Thread("State_CIS_Quest_Checker_Coruscant")
		end
	end
end
function State_CIS_Quest_Checker_Coruscant()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local event_act_8 = plot.Get_Event("CIS_OuterRimSieges_Act_VIII_Dialog")
	event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_8.Clear_Dialog_Text()

	if FindPlanet("Coruscant").Get_Owner() ~= p_cis then
		if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Invisible_Hand"))
		elseif TestValid(Find_First_Object("Grievous_Recusant")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Recusant"))
		elseif TestValid(Find_First_Object("Grievous_Munificent")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Munificent"))
		elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Malevolence"))
		elseif TestValid(Find_First_Object("Grievous_Malevolence_2")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Malevolence_2"))
		elseif TestValid(Find_First_Object("General_Grievous")) then
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Grievous_Team"))
		else
			event_act_8.Add_Dialog_Text("TEXT_STORY_OUTER_RIM_SIEGES_CIS_LOCATION_CORUSCANT", Find_Object_Type("Providence_Carrier_Destroyer"))
		end
	else
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Coruscant"))
		Story_Event("CIS_CORUSCANT_END")

		StoryUtil.SetPlanetRestricted("CORUSCANT", 0)
	end

	if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))
	elseif TestValid(Find_First_Object("Grievous_Recusant")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))
	elseif TestValid(Find_First_Object("Grievous_Munificent")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))
	elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))
	elseif TestValid(Find_First_Object("Grievous_Malevolence_2")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))
	elseif TestValid(Find_First_Object("General_Grievous")) then
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))
	else
		event_act_8_01_task = plot.Get_Event("CIS_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_8_01_task.Set_Event_Parameter(2, Find_Object_Type("Providence_Carrier_Destroyer"))
	end

	Sleep(5.0)
	if not cis_quest_coruscant_over then
		Create_Thread("State_CIS_Quest_Checker_Coruscant")
	end
end
function State_CIS_Coruscant_Cataclysm_Epilogue(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("CORUSCANT", 0)
	end
end

function State_CIS_OuterRimSieges_Rebellion(message)
	if message == OnEnter then
		Story_Event("CIS_REBELLION_START")
		Sleep(5.0)

		UnitUtil.DespawnList({"Nute_Gunray_Stealth", "Nute_Gunray", "Dooku_Stealth", "Wat_Tambor", "Poggle_AAT", "Passel_Argente", "Shu_Mai_Castell", "Shu_Mai_Subjugator", "Anakin3", "Emperor_Palpatine"})
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_cis, StoryUtil.GetSafePlanetTable(), {"Emperor_Palpatine_Team", "Vader_Team"})  

		Sleep(1.0)
		Story_Event("CIS_UTAPAU_END")

		if not cis_quest_rebellion_over then
			Create_Thread("State_CIS_Quest_Checker_Rebellion")
		end
	end
end
function State_CIS_Quest_Checker_Rebellion()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_CIS.XML")

	local OuterRimSieges_PlanetList = {
		FindPlanet("Alderaan"),
		FindPlanet("Anaxes"),
		FindPlanet("Corellia"),
		FindPlanet("Eriadu"),
		FindPlanet("Kashyyyk"),
		FindPlanet("Kuat"),
	}

	event_act_9 = plot.Get_Event("CIS_OuterRimSieges_Act_IX_Dialog")
	event_act_9.Set_Dialog("Dialog_19_BBY_OuterRimSieges_CIS")
	event_act_9.Clear_Dialog_Text()

	for _,p_planet in pairs(OuterRimSieges_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		elseif p_planet.Get_Owner() == p_cis then
			event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end
	if FindPlanet("Alderaan").Get_Owner() == p_cis
	and FindPlanet("Anaxes").Get_Owner() == p_cis
	and FindPlanet("Corellia").Get_Owner() == p_cis
	and FindPlanet("Eriadu").Get_Owner() == p_cis
	and FindPlanet("Kashyyyk").Get_Owner() == p_cis
	and FindPlanet("Kuat").Get_Owner() == p_cis then
		cis_quest_rebellion_over = true
		Story_Event("CIS_REBELLION_END")
	end

	Sleep(5.0)
	if not cis_quest_rebellion_over then
		Create_Thread("State_CIS_Quest_Checker_Rebellion")
	end
end

function State_CIS_OuterRimSieges_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.DeclareVictory(p_cis, true)
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("Rep_STORY_START")

	StoryUtil.SetPlanetRestricted("CATO_NEIMOIDIA", 1, false)
	StoryUtil.SetPlanetRestricted("FELUCIA", 1, false)
	StoryUtil.SetPlanetRestricted("SALEUCAMI", 1, false)
	StoryUtil.SetPlanetRestricted("TYTHE", 1, false)
	StoryUtil.SetPlanetRestricted("UTAPAU", 1, false)

	MissionUtil.EnableInvasion("SALEUCAMI", false)
	MissionUtil.EnableInvasion("CATO_NEIMOIDIA", false)

	StoryUtil.SpawnAtSafePlanet("SALEUCAMI", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team"})
	StoryUtil.SpawnAtSafePlanet("OSSUS", p_cis, StoryUtil.GetSafePlanetTable(), {"Vazus_Team"})
	StoryUtil.SpawnAtSafePlanet("SISKEEN", p_cis, StoryUtil.GetSafePlanetTable(), {"Harsol_Munificent"})
	StoryUtil.SpawnAtSafePlanet("TRITON", p_cis, StoryUtil.GetSafePlanetTable(), {"Dalesham_Nova_Defiant"})
	StoryUtil.SpawnAtSafePlanet("SY_MYRTH", p_cis, StoryUtil.GetSafePlanetTable(), {"Nute_Gunray_Team"})
	StoryUtil.SpawnAtSafePlanet("NEW_BORNALEX", p_cis, StoryUtil.GetSafePlanetTable(), {"Tobbi_Dala_Team","Fenn_Shysa_Team","Spar_Team"})
	StoryUtil.SpawnAtSafePlanet("THYFERRA", p_cis, StoryUtil.GetSafePlanetTable(), {"Colicoid_Swarm"})

	StoryUtil.SpawnAtSafePlanet("KASHYYYK", p_republic, StoryUtil.GetSafePlanetTable(), {"Delta_Squad"})
	StoryUtil.SpawnAtSafePlanet("CENTARES", p_republic, StoryUtil.GetSafePlanetTable(), {"Aayla_Secura_Eta_Team","Bly2_Team"})
	StoryUtil.SpawnAtSafePlanet("ORINDA", p_republic, StoryUtil.GetSafePlanetTable(), {"Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Tarkin_Venator"})
	StoryUtil.SpawnAtSafePlanet("CORELLIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Dodonna_Ardent"})
	StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Yoda_Eta_Team","Fordo2_Team"})

	if (GlobalValue.Get("ORS_Rep_GC_Version") == 1) then
		p_republic.Unlock_Tech(Find_Object_Type("Gladiator_I"))
		p_republic.Unlock_Tech(Find_Object_Type("Lancer_Frigate_Prototype"))
	end

	Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
end
function State_Rep_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local OuterRimSieges_PlanetList = {
		FindPlanet("Felucia"),
		FindPlanet("Mygeeto"),
		FindPlanet("Serenno"),
		FindPlanet("Siskeen"),
		FindPlanet("Praesitlyn"),
		FindPlanet("YagDhul"),
	}

	local event_act_1 = plot.Get_Event("Rep_OuterRimSieges_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(OuterRimSieges_PlanetList) do
		if p_planet.Get_Owner() ~= p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_THEATRE", p_planet)
		elseif p_planet.Get_Owner() == p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_THEATRE_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Felucia").Get_Owner() == p_republic 
	and FindPlanet("Mygeeto").Get_Owner() == p_republic 
	and FindPlanet("Serenno").Get_Owner() == p_republic 
	and FindPlanet("Siskeen").Get_Owner() == p_republic
	and FindPlanet("Praesitlyn").Get_Owner() == p_republic
	and FindPlanet("YagDhul").Get_Owner() == p_republic then
		rep_quest_planet_hunt_over = true
		Story_Event("REP_PLANET_HUNT_END")
	end

	Sleep(5.0)
	if not rep_quest_planet_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Planet_Hunt")
	end
end

function State_Rep_Giants_Graveyard_Epilogue(message)
	if message == OnEnter then
		if GlobalValue.Get("MissionOutcome_GIANTS_GRAVEYARD") == 0 then
			ChangePlanetOwnerAndRetreat(FindPlanet("Boz_Pity"), p_republic)

			local spawn_list = {
				"Republic_Jedi_Knight_Company",
				"Clonetrooper_Phase_Two_Company",
				"Clonetrooper_Phase_Two_Company",
				"Clone_Galactic_Marine_Company",
				"Acclamator_II",
				"Empire_Office",
				"E_Ground_Barracks",
				"E_Ground_Heavy_Vehicle_Factory",
				"Ground_Planetary_Shield",
			}

			SpawnList(spawn_list, FindPlanet("Boz_Pity"), p_republic, false, false)

			StoryUtil.SpawnAtSafePlanet("SERENNO", p_cis, StoryUtil.GetSafePlanetTable(), {"Lucid_Voice"})

			StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Anakin_ObiWan_Master_Team","Cody2_Team","Wessex_Redoubt","Bail_Organa_Venator"})
		elseif GlobalValue.Get("MissionOutcome_GIANTS_GRAVEYARD") == 1 then
			ChangePlanetOwnerAndRetreat(FindPlanet("Boz_Pity"),p_cis)

			StoryUtil.SpawnAtSafePlanet("BOZ_PITY", p_cis, StoryUtil.GetSafePlanetTable(), {"Lucid_Voice","Ventress_Team"})

			StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Anakin_ObiWan_Master_Team","Cody2_Team","Wessex_Redoubt"})
		end

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end

function State_Rep_OuterRimSieges_Trackdown(message)
	if message == OnEnter then
		if not rep_quest_trackdown_over then
			Story_Event("REP_TRACKDOWN_START")

			if not TestValid(Find_First_Object("Aayla_Secura2")) then
				StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Aayla_Secura_Eta_Team"})
			end

			Create_Thread("State_Rep_Quest_Checker_Trackdown")
		end
	end
end
function State_Rep_Quest_Checker_Trackdown()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	if TestValid(Find_First_Object("Aayla_Secura2")) then
		local event_act_2 = plot.Get_Event("Rep_OuterRimSieges_Act_II_Dialog")
		event_act_2.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_2.Clear_Dialog_Text()

		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Aayla_Secura_Eta_Team"))
		if TestValid(Find_First_Object("Aayla_Secura2").Get_Planet_Location()) then
			event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Aayla_Secura2").Get_Planet_Location())
		end
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Saleucami"))
		event_act_2.Add_Dialog_Text("TEXT_NONE")

		local event_act_2_task_01 = plot.Get_Event("Trigger_Rep_Enter_Hero_Trackdown")
		event_act_2_task_01.Set_Event_Parameter(2, Find_Object_Type("Aayla_Secura_Eta_Team"))
	else
		Story_Event("REP_TRACKDOWN_CHEAT")
		return
	end

	Sleep(5.0)
	if not rep_quest_trackdown_over then
		Create_Thread("State_Rep_Quest_Checker_Trackdown")
	end
end
function State_Rep_Enter_Heroes_Trackdown(message)
	if message == OnEnter then
		rep_quest_trackdown_over = true
		Story_Event("REP_TRACKDOWN_END")
	end
end

function State_Rep_OuterRimSieges_Saleucami(message)
	if message == OnEnter then
		if not rep_quest_saleucami_over then
			Story_Event("REP_SALEUCAMI_START")

			Sleep(6.0)

			StoryUtil.SetPlanetRestricted("SALEUCAMI", 0)
			MissionUtil.EnableInvasion("SALEUCAMI", true)

			Create_Thread("State_Rep_Quest_Checker_Saleucami")
		else
			MissionUtil.EnableInvasion("SALEUCAMI", true)
			StoryUtil.SetPlanetRestricted("SALEUCAMI", 0)
			StoryUtil.SetPlanetRestricted("FELUCIA", 0)
		end
	end
end
function State_Rep_Quest_Checker_Saleucami()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local event_act_3 = plot.Get_Event("Rep_OuterRimSieges_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_3.Clear_Dialog_Text()

	if FindPlanet("Saleucami").Get_Owner() ~= p_republic then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Saleucami"))
	elseif FindPlanet("Saleucami").Get_Owner() == p_republic then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Saleucami"))

		rep_quest_saleucami_over = true
		Story_Event("REP_SALEUCAMI_END")
	end

	Sleep(5.0)
	if not rep_quest_saleucami_over then
		Create_Thread("State_Rep_Quest_Checker_Saleucami")
	end
end

function State_Rep_OuterRimSieges_Felucia(message)
	if message == OnEnter then
		if not rep_quest_felucia_over then
			Story_Event("REP_FELUCIA_START")

			Sleep(6.0)

			StoryUtil.SetPlanetRestricted("FELUCIA", 0)

			Create_Thread("State_Rep_Quest_Checker_Felucia")
		else
			StoryUtil.SetPlanetRestricted("FELUCIA", 0)
		end
	end
end
function State_Rep_Quest_Checker_Felucia()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local event_act_4 = plot.Get_Event("Rep_OuterRimSieges_Act_IV_Dialog")
	event_act_4.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_4.Clear_Dialog_Text()

	if FindPlanet("Felucia").Get_Owner() ~= p_republic then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Felucia"))
	elseif FindPlanet("Felucia").Get_Owner() == p_republic then
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Felucia"))

		rep_quest_felucia_over = true
		Story_Event("REP_FELUCIA_END")
	end

	Sleep(5.0)
	if not rep_quest_felucia_over then
		Create_Thread("State_Rep_Quest_Checker_Felucia")
	end
end

function State_Rep_OuterRimSieges_Deception(message)
	if message == OnEnter then
		Story_Event("REP_DECEPTION_START")
		Sleep(5.0)

		scout_target_01 = StoryUtil.FindTargetPlanet(p_republic, false, true, 1)
		rep_deception_act_1 = true

		if not rep_quest_deception_over then
			Create_Thread("State_Rep_Quest_Checker_Deception")
		end
	end
end
function State_Rep_Quest_Checker_Deception()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")
	local event_act_5 = plot.Get_Event("Rep_OuterRimSieges_Act_V_Dialog_01")
	event_act_5.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_5.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_DECEPTION_SCOUTING_01", nil, true) and rep_deception_act_1 then
		scout_target_02 = FindPlanet("Ruhe")

		rep_deception_act_1 = false
		rep_deception_act_2 = true
	end
	if Check_Story_Flag(p_republic, "REP_DECEPTION_SCOUTING_02", nil, true) and rep_deception_act_2 then

		rep_deception_act_2 = false
		rep_quest_deception_over = true
	end

	if rep_deception_act_1 then
		local event_act_5 = plot.Get_Event("Rep_OuterRimSieges_Act_V_Dialog_01")
		event_act_5.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)

		event_act_5 = plot.Get_Event("Trigger_Rep_Enter_Deception_01")
		event_act_5.Set_Event_Parameter(0, scout_target_01)
		event_act_5.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	end
	if rep_deception_act_2 then
		local event_act_5 = plot.Get_Event("Rep_OuterRimSieges_Act_V_Dialog_02")
		event_act_5.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_02)

		event_act_5 = plot.Get_Event("Trigger_Rep_Enter_Deception_02")
		event_act_5.Set_Event_Parameter(0, scout_target_02)
		event_act_5.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	end
	if rep_quest_deception_over then
		local event_act_5 = plot.Get_Event("Rep_OuterRimSieges_Act_V_Dialog_02")
		event_act_5.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_02)

		Story_Event("REP_DECEPTION_TACTICAL")
	end

	if not TestValid(Find_First_Object("Anakin3")) then
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_ObiWan_Master_Team"})
	end

	Sleep(5.0)
	if not rep_quest_deception_over then
		Create_Thread("State_Rep_Quest_Checker_Deception")
	end
end
function State_Rep_Dooku_Domicile_Epilogue(message)
	if message == OnEnter then
		Story_Event("REP_DECEPTION_END")
		
		rep_quest_deception_over = true
	end
end

function State_Rep_OuterRimSieges_Cato_Neimoidia(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_OuterRimSieges_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_6.Clear_Dialog_Text()
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Cato_Neimoidia"))

		Story_Event("REP_CATO_NEIMOIDIA_START")
		Sleep(5.0)

		MissionUtil.FlashPlanet("CATO_NEIMOIDIA", "GUI_Flash_Cato_Neimoidia")
		MissionUtil.PositionCamera("CATO_NEIMOIDIA")

		StoryUtil.SetPlanetRestricted("CATO_NEIMOIDIA", 0)
	end
end
function State_Rep_Cato_Castle_Clash_Epilogue(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_OuterRimSieges_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_6.Clear_Dialog_Text()
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Cato_Neimoidia"))

		Sleep(2.0)

		MissionUtil.EnableInvasion("CATO_NEIMOIDIA", true)
		Story_Event("REP_CATO_NEIMOIDIA_END")
		UnitUtil.DespawnList({"Sentepth_Findos_MTT"})
		ChangePlanetOwnerAndRetreat(FindPlanet("Cato_Neimoidia"), p_republic)
	end
end

function State_Rep_OuterRimSieges_Chair(message)
	if message == OnEnter then
		Story_Event("REP_CHAIR_START")

		Sleep(2.0)
		StoryUtil.SpawnAtSafePlanet("CATO_NEIMOIDIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Mechno_Chair_Team"})
		Sleep(2.0)

		if not rep_quest_chair_over then
			Create_Thread("State_Rep_Quest_Checker_Chair")
		end
	end
end
function State_Rep_Quest_Checker_Chair()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local event_act_7 = plot.Get_Event("Rep_OuterRimSieges_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_7.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Mace_Windu2")) then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Mace_Windu_Eta_Team"))
		if TestValid(Find_First_Object("Mace_Windu2").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Mace_Windu2").Get_Planet_Location())
		end
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Coruscant"))
		event_act_7.Add_Dialog_Text("TEXT_NONE")
	end
	if TestValid(Find_First_Object("Mechno_Chair")) then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Mechno_Chair_Team"))
		if TestValid(Find_First_Object("Mechno_Chair").Get_Planet_Location()) then
			event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Mechno_Chair").Get_Planet_Location())
		end
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Coruscant"))
		event_act_7.Add_Dialog_Text("TEXT_NONE")
	end
	if not TestValid(Find_First_Object("Mace_Windu2")) and not TestValid(Find_First_Object("Mechno_Chair")) then
		Story_Event("REP_CHAIR_CHEAT")
	end

	if TestValid(Find_First_Object("Mace_Windu2")) and TestValid(Find_First_Object("Mechno_Chair")) then
		if Find_First_Object("Mace_Windu2").Get_Planet_Location() == FindPlanet("Coruscant") and Find_First_Object("Mechno_Chair").Get_Planet_Location() == FindPlanet("Coruscant") then
			Story_Event("REP_CHAIR_CHEAT")
		end
	elseif not TestValid(Find_First_Object("Mace_Windu2")) and TestValid(Find_First_Object("Mechno_Chair")) then
		if Find_First_Object("Mechno_Chair").Get_Planet_Location() == FindPlanet("Coruscant") then
			Story_Event("REP_CHAIR_CHEAT")
		end
	end

	Sleep(5.0)
	if not rep_quest_chair_over then
		Create_Thread("State_Rep_Quest_Checker_Chair")
	end
end
function State_Rep_Deploy_Heroes_Chair(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_7 = plot.Get_Event("Rep_OuterRimSieges_Act_VII_Dialog")
		event_act_7.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_7.Clear_Dialog_Text()

		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Mace_Windu_Eta_Team"))
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_UNIT_COMPLETE", Find_Object_Type("Mechno_Chair_Team"))

		rep_quest_chair_over = true
		Story_Event("REP_CHAIR_END")
		Story_Event("REP_SIDIOUS_HUNT_PRELUDE")

		UnitUtil.DespawnList({"Mechno_Chair"})
	end
end

function State_Rep_OuterRimSieges_Sidious_Hunt(message)
	if message == OnEnter then
		Story_Event("REP_SIDIOUS_HUNT_START")
		Sleep(5.0)

		sidious_hunt_target_01 = FindPlanet("Charros")
		rep_sidious_hunt_act_1 = true

		if not rep_quest_sidious_hunt_over then
			Create_Thread("State_Rep_Quest_Checker_Sidious_Hunt")
		end
	end
end
function State_Rep_Quest_Checker_Sidious_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")
	local event_act_8 = plot.Get_Event("Rep_OuterRimSieges_Act_VIII_Dialog_01")
	event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_8.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_SIDIOUS_HUNT_SCOUTING_01", nil, true) and rep_sidious_hunt_act_1 then
		sidious_hunt_target_02 = FindPlanet("Sy_Myrth")

		rep_sidious_hunt_act_1 = false
		rep_sidious_hunt_act_2 = true
	end
	if Check_Story_Flag(p_republic, "REP_SIDIOUS_HUNT_SCOUTING_02", nil, true) and rep_sidious_hunt_act_2 then
		sidious_hunt_target_03 = FindPlanet("Naos")

		rep_sidious_hunt_act_2 = false
		rep_sidious_hunt_act_3 = true
	end
	if Check_Story_Flag(p_republic, "REP_SIDIOUS_HUNT_SCOUTING_03", nil, true) and rep_sidious_hunt_act_3 then
		rep_sidious_hunt_act_3 = false
		rep_quest_sidious_hunt_over = true
	end

	if rep_sidious_hunt_act_1 then
		local event_act_8 = plot.Get_Event("Rep_OuterRimSieges_Act_VIII_Dialog_01")
		event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", sidious_hunt_target_01)

		event_act_8 = plot.Get_Event("Trigger_Rep_Enter_Sidious_Hunt_01")
		event_act_8.Set_Event_Parameter(0, sidious_hunt_target_01)
		event_act_8.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	end
	if rep_sidious_hunt_act_2 then
		local event_act_8 = plot.Get_Event("Rep_OuterRimSieges_Act_VIII_Dialog_02")
		event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", sidious_hunt_target_02)

		event_act_8 = plot.Get_Event("Trigger_Rep_Enter_Sidious_Hunt_02")
		event_act_8.Set_Event_Parameter(0, sidious_hunt_target_02)
		event_act_8.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	end
	if rep_sidious_hunt_act_3 then
		local event_act_8 = plot.Get_Event("Rep_OuterRimSieges_Act_VIII_Dialog_03")
		event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_02)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", sidious_hunt_target_03)

		event_act_8 = plot.Get_Event("Trigger_Rep_Enter_Sidious_Hunt_03")
		event_act_8.Set_Event_Parameter(0, sidious_hunt_target_03)
		event_act_8.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	end
	if rep_quest_sidious_hunt_over then
		local event_act_8 = plot.Get_Event("Rep_OuterRimSieges_Act_VIII_Dialog_03")
		event_act_8.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_8.Clear_Dialog_Text()

		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_01)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_02)
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", sidious_hunt_target_03)

		Story_Event("REP_SIDIOUS_HUNT_END")
	end

	if not TestValid(Find_First_Object("Anakin3")) then
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_ObiWan_Master_Team"})
	end

	Sleep(5.0)
	if not rep_quest_sidious_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Sidious_Hunt")
	end
end

function State_Rep_OuterRimSieges_Tythe(message)
	if message == OnEnter then
		Story_Event("REP_TYTHE_START")

		StoryUtil.SetPlanetRestricted("TYTHE", 0)
		ChangePlanetOwnerAndPopulate(FindPlanet("Tythe"), p_cis, 7500)

		if not rep_quest_tythe_over then
			Create_Thread("State_Rep_Quest_Checker_Tythe")
		end
	end
end
function State_Rep_Quest_Checker_Tythe()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local Tythe_PlanetList = {
		FindPlanet("Nelvaan"),
		FindPlanet("Tythe"),
	}

	local event_act_1 = plot.Get_Event("Rep_OuterRimSieges_Act_IX_Dialog")
	event_act_1.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(Tythe_PlanetList) do
		if p_planet.Get_Owner() ~= p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		elseif p_planet.Get_Owner() == p_republic then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Nelvaan").Get_Owner() == p_republic 
	and FindPlanet("Tythe").Get_Owner() == p_republic then
		rep_quest_tythe_over = true
		Story_Event("REP_TYTHE_END")
	end

	Sleep(5.0)
	if not rep_quest_tythe_over then
		Create_Thread("State_Rep_Quest_Checker_Tythe")
	end
end

function State_Rep_OuterRimSieges_Coruscant(message)
	if message == OnEnter then
		Story_Event("REP_CORUSCANT_START")
		StoryUtil.SetPlanetRestricted("CORUSCANT", 1, false)

		ForceSpaceRetreat(FindPlanet("Coruscant"), p_cis, FindPlanet("Anaxes"))
		ChangePlanetOwnerAndReplace(FindPlanet("Coruscant"), Find_Player("Sector_Forces"), 3)
		ChangePlanetOwnerAndReplace(FindPlanet("Coruscant"), Find_Player("Empire"), 3)

		local spawn_list_coruscant = {
			"Grievous_Invisible_Hand",
			"Lucrehulk_Battleship",
			"Lucrehulk_Battleship",
			"Providence_Dreadnought",
			"Providence_Dreadnought",
			"Providence_Carrier_Destroyer",
			"Providence_Carrier_Destroyer",
			"Providence_Carrier_Destroyer",
			"Munificent",
			"Munificent",
			"Munificent",
			"Munificent",
			"Munificent",
			"Recusant_Dreadnought",
			"Recusant_Light_Destroyer",
			"Recusant_Light_Destroyer",
			"Recusant_Light_Destroyer",
			"Auxilia",
			"Auxilia",
			"Auxilia",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
			"C9979_Carrier",
			"C9979_Carrier",
			"C9979_Carrier",
			"C9979_Carrier",
			"C9979_Carrier",
		}
		CoruscantSpawn = SpawnList(spawn_list_coruscant, FindPlanet("Coruscant"), Find_Player("Independent_Forces"), false, false)

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_10 = plot.Get_Event("Rep_OuterRimSieges_Act_X_Dialog")
		event_act_10.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_10.Clear_Dialog_Text()

		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Coruscant"))

		Create_Thread("State_Rep_Quest_Checker_Coruscant")
	end
end
function State_Rep_Quest_Checker_Coruscant()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	if TestValid(Find_First_Object("Anakin3")) then
		local event_act_10_task = plot.Get_Event("Rep_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_10_task.Set_Event_Parameter(2, Find_Object_Type("Anakin_ObiWan_Master_Team"))
	else
		local event_act_10_task = plot.Get_Event("Rep_OuterRimSieges_Hero_Enter_Coruscant")
		event_act_10_task.Set_Event_Parameter(2, Find_Object_Type("Venator_Star_Destroyer"))
	end

	Sleep(5.0)
	if not rep_quest_coruscant_over then
		Create_Thread("State_Rep_Quest_Checker_Coruscant")
	end
end
function State_Rep_Coruscant_Cataclysm_Epilogue(message)
	if message == OnEnter then
		rep_quest_coruscant_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_10 = plot.Get_Event("Rep_OuterRimSieges_Act_X_Dialog")
		event_act_10.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_10.Clear_Dialog_Text()

		event_act_10.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Coruscant"))
		Sleep(2.0)

		StoryUtil.SetPlanetRestricted("CORUSCANT", 0)
		ChangePlanetOwnerAndReplace(FindPlanet("Coruscant"), p_republic, 3)
		Sleep(8.0)

		Story_Event("REP_CORUSCANT_END")
	end
end

function State_Rep_OuterRimSieges_RotS(message)
	if message == OnEnter then
		Story_Event("REP_ROTS_START")

		UnitUtil.DespawnList({"Anakin3","Obi_Wan3","Mace_Windu2","Yoda2","Bail_Organa_Venator"})
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Anakin_Eta_Team","Obi_Wan_Eta_Team","Yoda_Eta_Team","Needa_Integrity"})

		StoryUtil.SetPlanetRestricted("UTAPAU", 0)

		ChangePlanetOwnerAndRetreat(FindPlanet("Utapau"), p_cis)

		local spawn_list = {
			"Grievous_Team",
			"Providence_Dreadnought",
			"Providence_Carrier",
			"Providence_Carrier",
			"Captor",
			"Auxilia",
			"Auxilia",
			"C9979_Carrier",
			"C9979_Carrier",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
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

		SpawnList(spawn_list, FindPlanet("Utapau"), p_cis, false, false)

		if not rep_quest_rots_over then
			Create_Thread("State_Rep_Quest_Checker_RotS")
		end
	end
end
function State_Rep_Quest_Checker_RotS()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local event_act_11 = plot.Get_Event("Rep_OuterRimSieges_Act_XI_Dialog")
	event_act_11.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_11.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Anakin2")) then
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Eta_Team"))
		if TestValid(Find_First_Object("Anakin2").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin2").Get_Planet_Location())
		end
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Coruscant"))
		event_act_11.Add_Dialog_Text("TEXT_NONE")
		
		if Find_First_Object("Anakin2").Get_Planet_Location() == FindPlanet("Coruscant") then
			rep_rots_enter_hero_01 = true
		end
	else
		rep_rots_enter_hero_01 = true
	end
	if TestValid(Find_First_Object("Obi_Wan2")) then
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Obi_Wan_Eta_Team"))
		if TestValid(Find_First_Object("Obi_Wan2").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Obi_Wan2").Get_Planet_Location())
		end
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Utapau"))
		event_act_11.Add_Dialog_Text("TEXT_NONE")
		
		if Find_First_Object("Obi_Wan2").Get_Planet_Location() == FindPlanet("Utapau") then
			rep_rots_enter_hero_02 = true
		end
	else
		rep_rots_enter_hero_02 = true
	end
	if TestValid(Find_First_Object("Mace_Windu2")) then
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Mace_Windu_Eta_Team"))
		if TestValid(Find_First_Object("Mace_Windu2").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Mace_Windu2").Get_Planet_Location())
		end
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Coruscant"))
		event_act_11.Add_Dialog_Text("TEXT_NONE")
		
		if Find_First_Object("Mace_Windu2").Get_Planet_Location() == FindPlanet("Coruscant") then
			rep_rots_enter_hero_03 = true
		end
	else
		rep_rots_enter_hero_03 = true
	end
	if TestValid(Find_First_Object("Yoda2")) then
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Yoda_Eta_Team"))
		if TestValid(Find_First_Object("Yoda2").Get_Planet_Location()) then
			event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Yoda2").Get_Planet_Location())
		end
		event_act_11.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Kashyyyk"))
		event_act_11.Add_Dialog_Text("TEXT_NONE")
		
		if Find_First_Object("Yoda2").Get_Planet_Location() == FindPlanet("Kashyyyk") then
			rep_rots_enter_hero_04 = true
		end
	else
		rep_rots_enter_hero_04 = true
	end

	if rep_rots_enter_hero_01
	and rep_rots_enter_hero_02
	and rep_rots_enter_hero_03
	and rep_rots_enter_hero_04 then
		Story_Event("REP_ROTS_TACTICAL")
	end

	Sleep(5.0)
	if not rep_quest_rots_over then
		Create_Thread("State_Rep_Quest_Checker_RotS")
	end
end
function State_Rep_Temple_Tragedy_Epilogue(message)
	if message == OnEnter then
		rep_quest_rots_over = true

		Story_Event("REP_ROTS_END")
		Create_Thread("State_Rep_Quest_CleanUp_RotS")

		crossplot:publish("EXECUTE_ORDER_66", "DespawnJedi")
	else
		crossplot:update()
	end
end
function State_Rep_Quest_CleanUp_RotS()
	StoryUtil.SetPlanetRestricted("SALEUCAMI", 0)
	StoryUtil.SetPlanetRestricted("FELUCIA", 0)
	MissionUtil.EnableInvasion("SALEUCAMI", true)

	rep_quest_trackdown_over = true
	rep_quest_saleucami_over = true
	rep_quest_felucia_over = true

	Story_Event("REP_TRACKDOWN_CHEAT")
	Sleep(1.0)
	Story_Event("REP_SALEUCAMI_CHEAT")
	Sleep(1.0)
	Story_Event("REP_FELUCIA_CHEAT")
	Sleep(8.0)
	Story_Event("REP_MUSTAFAR_START")
end

function State_Rep_OuterRimSieges_Mustafar(message)
	if message == OnEnter then
		Story_Event("REP_MUSTAFAR_START")

		if not TestValid(Find_First_Object("Anakin_Darkside")) then
			StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Anakin_Darkside_Team"})
		end

		if not rep_quest_mustafar_over then
			Create_Thread("State_Rep_Quest_Checker_Mustafar")
		end
	end
end
function State_Rep_Quest_Checker_Mustafar()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	if TestValid(Find_First_Object("Anakin_Darkside")) then
		local event_act_12 = plot.Get_Event("Rep_OuterRimSieges_Act_XII_Dialog")
		event_act_12.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_12.Clear_Dialog_Text()

		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Anakin_Darkside_Team"))
		if TestValid(Find_First_Object("Anakin_Darkside").Get_Planet_Location()) then
			event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Anakin_Darkside").Get_Planet_Location())
		end
		event_act_12.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Mustafar"))
		event_act_12.Add_Dialog_Text("TEXT_NONE")

		local event_act_12_task_01 = plot.Get_Event("Trigger_Rep_Enter_Hero_Mustafar")
		event_act_12_task_01.Set_Event_Parameter(2, Find_Object_Type("Anakin_Darkside_Team"))
	else
		Story_Event("REP_MUSTAFAR_CHEAT")
		return
	end

	Sleep(5.0)
	if not rep_quest_mustafar_over then
		Create_Thread("State_Rep_Quest_Checker_Mustafar")
	end
end
function State_Rep_Enter_Heroes_Mustafar(message)
	if message == OnEnter then
		rep_quest_mustafar_over = true
		Story_Event("REP_MUSTAFAR_END")
	end
end

function State_Rep_OuterRimSieges_Jedi_Hunt(message)
	if message == OnEnter then
		Story_Event("REP_JEDI_HUNT_START")

		ChangePlanetOwnerAndRetreat(FindPlanet("Bogden"), p_independent_forces)
		ChangePlanetOwnerAndRetreat(FindPlanet("Kashyyyk"), p_independent_forces)
		ChangePlanetOwnerAndRetreat(FindPlanet("New_Cov"), p_independent_forces)
		ChangePlanetOwnerAndRetreat(FindPlanet("Orinda"), p_independent_forces)
		ChangePlanetOwnerAndRetreat(FindPlanet("Zeltros"), p_independent_forces)

		Sleep(2.0)

		local spawn_list = {
			"Republic_Jedi_Knight_Company",
			"Antarian_Ranger_Company",
			"Antarian_Ranger_Company",
			"AT_XT_Company",
			"Republic_TX130S_Company",
			"Republic_AT_AP_Walker_Company",
			"Revolt_PDF_HQ_Rural",
			"Jedi_Enclave",
			"Jedi_Ground_Barracks",
			"E_Ground_Heavy_Vehicle_Factory",
			"Ground_Planetary_Shield",
		}

		SpawnList(spawn_list, FindPlanet("Bogden"), p_independent_forces, false, false)
		SpawnList(spawn_list, FindPlanet("Kashyyyk"), p_independent_forces, false, false)
		SpawnList(spawn_list, FindPlanet("New_Cov"), p_independent_forces, false, false)
		SpawnList(spawn_list, FindPlanet("Orinda"), p_independent_forces, false, false)
		SpawnList(spawn_list, FindPlanet("Zeltros"), p_independent_forces, false, false)

		ChangePlanetOwnerAndRetreat(FindPlanet("Mustafar"), p_cis)

		UnitUtil.DespawnList({"Dellso_Providence"})

		local spawn_list = {
			"Dellso_Providence",
			"Providence_Dreadnought",
			"Providence_Carrier",
			"Providence_Carrier",
			"Captor",
			"Auxilia",
			"Auxilia",
			"C9979_Carrier",
			"C9979_Carrier",
			"Munifex",
			"Munifex",
			"Munifex",
			"Munifex",
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

		SpawnList(spawn_list, FindPlanet("Mustafar"), p_cis, false, false)

		if not rep_quest_jedi_hunt_over then
			Create_Thread("State_Rep_Quest_Checker_Jedi_Hunt")
		end
	end
end
function State_Rep_Quest_Checker_Jedi_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

	local Jedi_Hunt_PlanetList = {
		FindPlanet("Bogden"),
		FindPlanet("Kashyyyk"),
		FindPlanet("Orinda"),
		FindPlanet("Mustafar"),
		FindPlanet("New_Cov"),
		FindPlanet("Zeltros"),
	}

	local event_act_13 = plot.Get_Event("Rep_OuterRimSieges_Act_XIII_Dialog")
	event_act_13.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
	event_act_13.Clear_Dialog_Text()

	for _,p_planet in pairs(Jedi_Hunt_PlanetList) do
		if p_planet.Get_Owner() ~= p_republic then
			event_act_13.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		elseif p_planet.Get_Owner() == p_republic then
			event_act_13.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Bogden").Get_Owner() == p_republic 
	and FindPlanet("Kashyyyk").Get_Owner() == p_republic
	and FindPlanet("Orinda").Get_Owner() == p_republic
	and FindPlanet("Mustafar").Get_Owner() == p_republic
	and FindPlanet("New_Cov").Get_Owner() == p_republic
	and FindPlanet("Zeltros").Get_Owner() == p_republic then
		rep_quest_jedi_hunt_over = true
		Story_Event("REP_JEDI_HUNT_END")
	end

	Sleep(5.0)
	if not rep_quest_jedi_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Jedi_Hunt")
	end
end

function State_Rep_OuterRimSieges_Frigates(message)
	if message == OnEnter then
		Story_Event("REP_FRIGATES_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_14 = plot.Get_Event("Rep_OuterRimSieges_Act_XIV_Dialog")
		event_act_14.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_14.Clear_Dialog_Text()

		event_act_14.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Experimental_Frigate_Doctrine"))
		event_act_14.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Experimental_Frigate_Doctrine"))
	end
end
function State_Rep_OuterRimSieges_Frigate_Research(message)
	if message == OnEnter then
		rep_quest_frigates_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\19_BBY_CloneWarsOuterRimSieges\\Story_Sandbox_OuterRimSieges_Republic.XML")

		local event_act_14 = plot.Get_Event("Rep_OuterRimSieges_Act_XIV_Dialog")
		event_act_14.Set_Dialog("Dialog_19_BBY_OuterRimSieges_Rep")
		event_act_14.Clear_Dialog_Text()

		event_act_14.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Experimental_Frigate_Doctrine"))

		p_republic.Lock_Tech(Find_Object_Type("Arquitens"))
		p_republic.Lock_Tech(Find_Object_Type("Acclamator_I_Assault"))
		p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Frigate"))
		p_republic.Unlock_Tech(Find_Object_Type("Imperial_I_Frigate"))

		Story_Event("REP_FRIGATES_END")
	end
end

function State_Rep_OuterRimSieges_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.DeclareVictory(p_republic, false)
	end
end

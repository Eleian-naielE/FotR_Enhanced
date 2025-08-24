--*****************************************************--
--********  Campaign: Operation Durge's Lance  ********--
--*****************************************************--

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
require("eawx-plugins/influence-service/InfluenceService")

function Definitions()
	--DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		-- Generic
		Trigger_Historical_GC_Choice_Prompt = State_Historical_GC_Choice_Prompt,

		-- CIS
		CIS_Duro_Defence_Epilogue = State_CIS_Duro_Defence_Epilogue,
		CIS_Jyvus_Joyride_Epilogue = State_CIS_Jyvus_Joyride_Epilogue,
		CIS_Duro_Drama_Epilogue = State_CIS_Duro_Drama_Epilogue,

		CIS_DurgesLance_Conquest_Humbarine = State_CIS_DurgesLance_Conquest_Humbarine,

		Trigger_CIS_DurgesLance_Kuat = State_CIS_DurgesLance_Kuat,
		CIS_DurgesLance_Hero_Enter_Kuat = State_CIS_DurgesLance_Hero_Enter_Kuat,
		CIS_Shipyard_Showdown_Epilogue = State_CIS_Shipyard_Showdown_Epilogue,

		Trigger_CIS_DurgesLance_Probe = State_CIS_DurgesLance_Probe,

		Trigger_CIS_DurgesLance_Plague = State_CIS_DurgesLance_Plague,
		Trigger_CIS_DurgesLance_Plague_Research = State_CIS_DurgesLance_Plague_Research,

		Trigger_CIS_DurgesLance_Rendili = State_CIS_DurgesLance_Rendili,
		CIS_DurgesLance_Conquest_Rendili = State_CIS_DurgesLance_Conquest_Rendili,

		Trigger_CIS_DurgesLance_HoloNet = State_CIS_DurgesLance_HoloNet,
		CIS_Holo_Hunt_Epilogue = State_CIS_Holo_Hunt_Epilogue,

		Trigger_CIS_DurgesLance_Shadowfeed = State_CIS_DurgesLance_Shadowfeed,

		CIS_DurgesLance_GC_Progression = State_CIS_DurgesLance_GC_Progression,

		-- Republic
		Trigger_Rep_DurgesLance_Duro = State_Rep_DurgesLance_Duro,
		Rep_Duro_Defence_Epilogue = State_Rep_Duro_Defence_Epilogue,

		Trigger_Rep_DurgesLance_Suspicions = State_Rep_DurgesLance_Suspicions,

		Trigger_Rep_DurgesLance_Investigation = State_Rep_DurgesLance_Investigation,
		Trigger_Rep_DurgesLance_Duro_Investigations_Research = State_Rep_DurgesLance_Duro_Investigations_Research,

		Trigger_Rep_DurgesLance_Corellia = State_Rep_DurgesLance_Corellia,

		Trigger_Rep_DurgesLance_Rendili = State_Rep_DurgesLance_Rendili,
		Rep_DurgesLance_Conquest_Rendili = State_Rep_DurgesLance_Conquest_Rendili,

		Trigger_Rep_DurgesLance_HoloNet = State_Rep_DurgesLance_HoloNet,

		Trigger_Rep_DurgesLance_ShadowFeed = State_Rep_DurgesLance_ShadowFeed,

		Trigger_Rep_DurgesLance_Plague = State_Rep_DurgesLance_Plague,
		Trigger_Rep_DurgesLance_Plague_Vaccine_Research = State_Rep_DurgesLance_Plague_Vaccine_Research,

		Rep_DurgesLance_GC_Progression = State_Rep_DurgesLance_GC_Progression,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_sector_forces = Find_Player("Sector_Forces")

	all_planets_conquered = false

	cis_quest_planet_hunt_over = false
	cis_quest_kuat_over = false
	cis_quest_probe_over = false
	cis_quest_plague_over = false
	cis_quest_kuat_over = false
	cis_quest_rendili_over = false
	cis_quest_holonet_over = false
	cis_quest_shadowfeed_over = false

	cis_act_1_death_01 = false
	cis_act_1_death_02 = false

	current_amount_relay = 0

	rep_quest_grievous_hunt_over = false
	rep_quest_duro_over = false
	rep_quest_suspicions_over = false
	rep_quest_investigation_over = false
	rep_quest_corellia_over = false
	rep_quest_rendili_over = false
	rep_quest_holonet_over = false
	rep_quest_shadowfeed_over = false
	rep_quest_plague_over = false

	GlobalValue.Set("CURRENT_CLONE_PHASE", 1)

	crossplot:galactic()
	crossplot:subscribe("HISTORICAL_GC_CHOICE_OPTION", Historical_GC_Choice_Made)
end

function State_Historical_GC_Choice_Prompt(message)
	if message == OnEnter then
		if p_cis.Is_Human() then
			GlobalValue.Set("ODL_CIS_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("ODL_CIS_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
		elseif p_republic.Is_Human() then
			GlobalValue.Set("ODL_Rep_GC_Version", 0) -- 1 = AU Version; 0 = Canonical Version

			if TestValid(Find_First_Object("GC_AU_Dummy")) then
				GlobalValue.Set("ODL_Rep_GC_Version", 1) -- 1 = AU Version; 0 = Canonical Version
			end
			if TestValid(Find_First_Object("GC_AU_2_Dummy")) then
				GlobalValue.Set("CURRENT_CLONE_PHASE", 2)
			end
		end

		-- CIS
		p_cis.Unlock_Tech(Find_Object_Type("Providence_Carrier_Destroyer"))
		p_cis.Unlock_Tech(Find_Object_Type("CIS_Sector_Capital"))

		p_cis.Lock_Tech(Find_Object_Type("CIS_Capital"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Recusant_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Grievous_Upgrade_Providence_To_Malevolence"))
		p_cis.Lock_Tech(Find_Object_Type("Random_Mercenary"))
		p_cis.Lock_Tech(Find_Object_Type("Devastation"))

		-- Republic
		p_republic.Unlock_Tech(Find_Object_Type("Republic_Sector_Capital"))
		p_republic.Unlock_Tech(Find_Object_Type("Victory_I_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("Venator_Star_Destroyer"))
		p_republic.Unlock_Tech(Find_Object_Type("LAC"))
		p_republic.Unlock_Tech(Find_Object_Type("Citadel_Cruiser_Group"))

		p_republic.Lock_Tech(Find_Object_Type("Republic_Capital"))
		p_republic.Lock_Tech(Find_Object_Type("Rep_DHC"))
		p_republic.Lock_Tech(Find_Object_Type("CR90"))

		p_republic.Lock_Tech(Find_Object_Type("Mace_Retire"))

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

			GlobalValue.Set("ODL_CIS_Shipyard_Struggle_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Jyvus_Joyride_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Grievous_Respawn", 0)

			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")

			Story_Event("REP_INTRO_START")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_INTRO" then
		if p_cis.Is_Human() then
			GlobalValue.Set("ODL_CIS_Shipyard_Struggle_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Jyvus_Joyride_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Grievous_Respawn", 0)

			Create_Thread("CIS_Story_Set_Up")
		end
		if p_republic.Is_Human() then
			Create_Thread("Rep_Story_Set_Up")
		end
	end
	if choice == "HISTORICAL_GC_CHOICE_NO_STORY" then
		Create_Thread("Generic_Story_Set_Up")
	end
	if choice == "HISTORICAL_GC_CHOICE_AU" then
		if p_cis.Is_Human() then
			GlobalValue.Set("ODL_CIS_Shipyard_Struggle_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Jyvus_Joyride_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
			GlobalValue.Set("ODL_CIS_Grievous_Respawn", 0)
			GlobalValue.Set("ODL_CIS_GC_Version", 1)

			Create_Thread("CIS_Story_Set_Up")

			Story_Event("CIS_INTRO_START")
		end
		if p_republic.Is_Human() then
			GlobalValue.Set("CURRENT_CLONE_PHASE", 2)
			Create_Thread("Rep_Story_Set_Up")

			Story_Event("REP_INTRO_START")
		end
	end

	crossplot:publish("VENATOR_HEROES", "empty")
	crossplot:publish("VICTORY1_HEROES", "empty")

	crossplot:publish("COMMAND_STAFF_INITIALIZE", {
			["MOFF"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Grant"},
			},
			["NAVY"] = {
				["SLOT_ADJUST"] = -1,
				["EXIT"] = {"Yularen","Coburn","Kilian","Screed","Dodonna","Dron","Dallin","Wieler","Dao"},
			},
			["ARMY"] = {
				--this space intentionally left blank
			},
			["CLONE"] = {
				["SLOT_ADJUST"] = -1,
				["EXIT"] = {"Rex","Bly","Cody","Wolffe","Gree_Clone","Neyo"},
			},
			["COMMANDO"] = {
				["LOCKIN"] = {"Fordo"},
				["EXIT"] = {"Alpha","Gregor"},
			},
			["JEDI"] = {
				["SLOT_ADJUST"] = 1,
				["LOCKIN"] = {"Mace","Plo"},
				["EXIT"] = {"Aayla","Kit","Shaak","Ahsoka","Knol"},
			},
		})

	crossplot:publish("FIGHTER_HERO_DISABLE", {"Garven_Dreis_Location_Set","Rhys_Dallows_Location_Set"})
	crossplot:publish("FIGHTER_HERO_ENABLE", {"Brand_Zeta_Location_Set"})

	Set_Fighter_Hero("BRAND_DELTA7_ZETA_SQUADRON","GRANT_VENATOR")
	Clear_Fighter_Hero("RHYS_DALLOWS_BRAVO_SQUADRON")
	Clear_Fighter_Hero("GARVEN_DREIS_RAREFIED_SQUADRON")

	crossplot:publish("INITIALIZE_AI", "empty")
end

function Generic_Story_Set_Up()
	StoryUtil.SpawnAtSafePlanet("YAGDHUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Invisible_Hand"})
	StoryUtil.SpawnAtSafePlanet("DEVARON", p_cis, StoryUtil.GetSafePlanetTable(), {"Shaala_Doneeta_Team","Ventress_Team","Durge_Team"})
	StoryUtil.SpawnAtSafePlanet("ORD_VAUG", p_cis, StoryUtil.GetSafePlanetTable(), {"Shonn_Recusant"})
	StoryUtil.SpawnAtSafePlanet("RONYARDS", p_cis, StoryUtil.GetSafePlanetTable(), {"Krett_Lucrehulk_Battleship","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("IPHIGIN", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team","Lucid_Voice"})
	StoryUtil.SafeSpawnFavourHero("THYFERRA", p_cis, {"Treetor_Captor"})

	StoryUtil.SpawnAtSafePlanet("COMMENOR", p_republic, StoryUtil.GetSafePlanetTable(), {"Ahalas_Svindren_Team"})
	StoryUtil.SpawnAtSafePlanet("CHARDAAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Coy_Imperator","Inglemenn_Barezz_Team"})
	StoryUtil.SpawnAtSafePlanet("HUMBARINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Armand_Isard_Team"})
	StoryUtil.SpawnAtSafePlanet("SARAPIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Plo_Koon_Delta_Team","Onaconda_Farr_Team"})
	StoryUtil.SpawnAtSafePlanet("THOMORK", p_republic, StoryUtil.GetSafePlanetTable(), {"Grant_Venator","Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("AILON", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo_Team","Tallon_Sundiver"})
end

-- CIS

function CIS_Story_Set_Up()
	Story_Event("CIS_STORY_START")

	if (GlobalValue.Get("ODL_CIS_GC_Version") == 0) then
		StoryUtil.SpawnAtSafePlanet("YAGDHUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Invisible_Hand"})
	elseif (GlobalValue.Get("ODL_CIS_GC_Version") == 1) then
		StoryUtil.SpawnAtSafePlanet("YAGDHUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Malevolence"})
	end

	StoryUtil.SpawnAtSafePlanet("DEVARON", p_cis, StoryUtil.GetSafePlanetTable(), {"Shaala_Doneeta_Team","Ventress_Team","Durge_Team"})
	StoryUtil.SpawnAtSafePlanet("ORD_VAUG", p_cis, StoryUtil.GetSafePlanetTable(), {"Shonn_Recusant"})
	StoryUtil.SpawnAtSafePlanet("RONYARDS", p_cis, StoryUtil.GetSafePlanetTable(), {"Krett_Lucrehulk_Battleship","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("IPHIGIN", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team","Lucid_Voice"})
	StoryUtil.SafeSpawnFavourHero("THYFERRA", p_cis, {"Treetor_Captor"})

	StoryUtil.SpawnAtSafePlanet("COMMENOR", p_republic, StoryUtil.GetSafePlanetTable(), {"Ahalas_Svindren_Team"})
	StoryUtil.SpawnAtSafePlanet("CHARDAAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Coy_Imperator","Inglemenn_Barezz_Team"})
	StoryUtil.SpawnAtSafePlanet("HUMBARINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Ardus_Kaine_Team","Armand_Isard_Team"})
	StoryUtil.SpawnAtSafePlanet("SARAPIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Plo_Koon_Delta_Team","Onaconda_Farr_Team"})
	StoryUtil.SpawnAtSafePlanet("THOMORK", p_republic, StoryUtil.GetSafePlanetTable(), {"Grant_Venator","Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("AILON", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo_Team","Tallon_Sundiver"})

	StoryUtil.RevealPlanet("KUAT", false)

	MissionUtil.EnableInvasion("LOEDORVIA", false)

	StoryUtil.SetPlanetRestricted("DURO", 1, false)
	StoryUtil.SetPlanetRestricted("KAIKIELIUS", 1, false)
	StoryUtil.SetPlanetRestricted("KUAT", 1, false)
	StoryUtil.SetPlanetRestricted("RENDILI", 1, false)

	Create_Thread("State_CIS_Quest_Checker_Planet_Hunt")
	Create_Thread("State_CIS_Quest_Checker_Grievous")
end
function State_CIS_Quest_Checker_Planet_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

	local DurgesLance_PlanetList = {
		FindPlanet("Corellia"),
		FindPlanet("Duro"),
		FindPlanet("Loedorvia"),
	}

	local event_act_1 = plot.Get_Event("CIS_DurgesLance_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
	event_act_1.Clear_Dialog_Text()

	for _,p_planet in pairs(DurgesLance_PlanetList) do
		if p_planet.Get_Owner() ~= p_cis then
			if p_planet.Get_Planet_Location() == FindPlanet("Duro") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_DURGES_LANCE_CIS_LOCATION_DURO", p_planet)
			elseif p_planet.Get_Planet_Location() == FindPlanet("Loedorvia") then
				event_act_1.Add_Dialog_Text("TEXT_STORY_DURGES_LANCE_CIS_LOCATION_LOEDORVIA", p_planet)
			else
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
			end
		elseif p_planet.Get_Owner() == p_cis then
			event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		end
	end

	if FindPlanet("Corellia").Get_Owner() == p_cis 
	and FindPlanet("Duro").Get_Owner() == p_cis 
	and FindPlanet("Loedorvia").Get_Owner() == p_cis then
		cis_quest_planet_hunt_over = true
		Story_Event("CIS_PLANET_HUNT_END")

		local planet_list_factional_rep = StoryUtil.GetFactionalPlanetList(p_republic)
		if table.getn(planet_list_factional_rep) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
					StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Recusant")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
						StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Munificent")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
						StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
					StoryUtil.LoadCampaign("Sandbox_AU_1_OuterRimSieges_CIS", 0)
				else
					grievous_dead = true
					StoryUtil.LoadCampaign("Sandbox_Foerost_CIS", 0)
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
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

	if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Invisible_Hand"))

	elseif TestValid(Find_First_Object("Grievous_Recusant")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Recusant"))

	elseif TestValid(Find_First_Object("Grievous_Munificent")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Munificent"))

	elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence"))

	elseif TestValid(Find_First_Object("Grievous_Malevolence_2")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Malevolence_2"))

	elseif TestValid(Find_First_Object("General_Grievous")) then
		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Grievous_Team"))

	else

		event_act_1_01_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Duro")
		event_act_1_01_task.Set_Event_Parameter(2, Find_Object_Type("Providence_Carrier_Destroyer"))

		event_act_1_02_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_Kuat")
		event_act_1_02_task.Set_Event_Parameter(2, Find_Object_Type("Providence_Carrier_Destroyer"))

		event_act_1_03_task = plot.Get_Event("CIS_DurgesLance_Hero_Enter_HoloNet")
		event_act_1_03_task.Set_Event_Parameter(2, Find_Object_Type("Providence_Carrier_Destroyer"))
	end

	Sleep(5.0)
	if cis_quest_planet_hunt_over and cis_quest_kuat_over and cis_quest_holonet_over then
		Create_Thread("State_CIS_Quest_Checker_Grievous")
	end
end

function State_CIS_Duro_Defence_Epilogue(message)
	if message == OnEnter then
		Sleep(2.0)

 		StoryUtil.SetPlanetRestricted("DURO", 0)
		Sleep(2.0)

		if (GlobalValue.Get("ODL_CIS_Jyvus_Joyride_Outcome") == 1) then
			Story_Event("CIS_DURO_TACTICAL")
		end
		if (GlobalValue.Get("ODL_CIS_Jyvus_Joyride_Outcome") == 0) then
			Sleep(1.0)

			Story_Event("CIS_DURO_END")
			ChangePlanetOwnerAndRetreat(FindPlanet("Duro"), p_cis)
			Sleep(1.0)

			if not TestValid(Find_First_Object("Hoolidan_Keggle")) then
				StoryUtil.SpawnAtSafePlanet("DURO", p_cis, StoryUtil.GetSafePlanetTable(), {"Hoolidan_Keggle_Team"})
			end
		end
	end
end
function State_CIS_Jyvus_Joyride_Epilogue(message)
	if message == OnEnter then
		if (GlobalValue.Get("ODL_CIS_Jyvus_Joyride_Outcome") == 1) then
			Story_Event("CIS_DURO_TACTICAL")
		end
		if (GlobalValue.Get("ODL_CIS_Jyvus_Joyride_Outcome") == 0) then
			Sleep(1.0)

			Story_Event("CIS_DURO_END")
			ChangePlanetOwnerAndRetreat(FindPlanet("Duro"), p_cis)
			Sleep(1.0)

			StoryUtil.SpawnAtSafePlanet("DURO", p_cis, StoryUtil.GetSafePlanetTable(), {"Hoolidan_Keggle_Team"})
		end
	end
end
function State_CIS_Duro_Drama_Epilogue(message)
	if message == OnEnter then
		Sleep(2.0)
		Story_Event("CIS_DURO_END")
		ChangePlanetOwnerAndRetreat(FindPlanet("Duro"), p_cis)
		FindPlanet("Duro").Attach_Particle_Effect("Galactic_GtS_Attrition_Explosion") 
   end
end
function State_CIS_Shipyard_Showdown_Epilogue(message)
	if message == OnEnter then
		Sleep(2.0)
 		StoryUtil.SetPlanetRestricted("KUAT", 0)
   end
end

function State_CIS_DurgesLance_Conquest_Humbarine(message)
	if message == OnEnter then
		Story_Event("CIS_HUMBARINE_END")
		FindPlanet("Humbarine").Attach_Particle_Effect("Galactic_GtS_Attrition_Explosion") 
	end
end

function State_CIS_DurgesLance_Kuat(message)
	if message == OnEnter then
		Story_Event("CIS_KUAT_START")

		if not cis_quest_kuat_over then
			Create_Thread("State_CIS_Quest_Checker_Kuat")
		end
	end
end
function State_CIS_Quest_Checker_Kuat()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

	local event_act_2 = plot.Get_Event("CIS_DurgesLance_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
	event_act_2.Clear_Dialog_Text()

	if FindPlanet("Kuat").Get_Owner() ~= p_cis then
		event_act_2.Add_Dialog_Text("TEXT_STORY_DURGES_LANCE_CIS_LOCATION_KUAT", FindPlanet("Kuat"))
	else
		event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Kuat"))
		Story_Event("CIS_KUAT_END")
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("KUAT", p_cis, StoryUtil.GetSafePlanetTable(), {"Storm_Fleet_Destroyer","Storm_Fleet_Destroyer","Storm_Fleet_Destroyer"})
		cis_quest_kuat_over = true

		p_cis.Unlock_Tech(Find_Object_Type("Storm_Fleet_Destroyer"))

		local planet_list_factional_rep = StoryUtil.GetFactionalPlanetList(p_republic)
		if table.getn(planet_list_factional_rep) == 0 then
			if not all_planets_conquered then
				all_planets_conquered = true
				if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
					StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Recusant")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
						StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Munificent")) then
					if FindPlanet("Kuat").Get_Owner() == p_cis then
						StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
					end
					if FindPlanet("Kuat").Get_Owner() ~= p_cis then
						StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
					end
				elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
					StoryUtil.LoadCampaign("Sandbox_AU_1_OuterRimSieges_CIS", 0)
				else
					grievous_dead = true
					StoryUtil.LoadCampaign("Sandbox_Foerost_CIS", 0)
				end
			end
		end

	end

	Sleep(5.0)
	if not cis_quest_kuat_over then
		Create_Thread("State_CIS_Quest_Checker_Kuat")
	end
end
function State_CIS_DurgesLance_Hero_Enter_Kuat(message)
	if message == OnEnter then
		Story_Event("CIS_KUAT_TACTICAL")
	end
end

function State_CIS_DurgesLance_Probe(message)
	if message == OnEnter then
		Story_Event("CIS_PROBE_START")

		FindPlanet("Loedorvia").Attach_Particle_Effect("Galactic_Planet_Infection") 

		scout_target_01 = FindPlanet("Loedorvia")

		if not cis_quest_probe_over then
			Create_Thread("State_CIS_Quest_Checker_Probe")
		end
	end
end
function State_CIS_Quest_Checker_Probe()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")
	local event_act_3 = plot.Get_Event("CIS_DurgesLance_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
	event_act_3.Clear_Dialog_Text()

	if Check_Story_Flag(p_cis, "CIS_PROBE_SCOUTING_01", nil, true) then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_COMPLETE", scout_target_01)
		cis_quest_probe_over = true

		ChangePlanetOwnerAndRetreat(FindPlanet("Loedorvia"), p_cis)
		MissionUtil.EnableInvasion("LOEDORVIA", true)

		Story_Event("CIS_PROBE_END")
	else
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", scout_target_01)
	end

	event_act_3 = plot.Get_Event("Trigger_CIS_Enter_Probe_Search_01")
	event_act_3.Set_Event_Parameter(0, scout_target_01)

	Sleep(5.0)
	if not cis_quest_probe_over then
		Create_Thread("State_CIS_Quest_Checker_Probe")
	end
end

function State_CIS_DurgesLance_Plague(message)
	if message == OnEnter then
		Story_Event("CIS_PLAGUE_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_4 = plot.Get_Event("CIS_DurgesLance_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Brainrot_Plague"))
		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Loedorvia"))
		Sleep(10.0)

		p_cis.Unlock_Tech(Find_Object_Type("Dummy_Research_Brainrot_Plague"))
	end
end
function State_CIS_DurgesLance_Plague_Research(message)
	if message == OnEnter then
		cis_quest_plague_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_4 = plot.Get_Event("CIS_DurgesLance_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Brainrot_Plague"))
		Sleep(2.0)

		Story_Event("CIS_PLAGUE_TACTICAL")
		Sleep(5.0)

		Story_Event("CIS_PLAGUE_END")
	end
end

function State_CIS_DurgesLance_Rendili(message)
	if message == OnEnter then
		Story_Event("CIS_RENDILI_START")
		StoryUtil.SetPlanetRestricted("RENDILI", 0)

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_5 = plot.Get_Event("CIS_DurgesLance_Act_V_Dialog")
		event_act_5.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rendili"))
	end
end
function State_CIS_DurgesLance_Conquest_Rendili(message)
	if message == OnEnter then
		cis_quest_rendili_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_5 = plot.Get_Event("CIS_DurgesLance_Act_V_Dialog")
		event_act_5.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_5.Clear_Dialog_Text()

		event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rendili"))

		Sleep(2.0)
		ChangePlanetOwnerAndRetreat(FindPlanet("Rendili"), p_cis)

		Sleep(2.0)
		StoryUtil.SpawnAtSafePlanet("RENDILI", p_cis, StoryUtil.GetSafePlanetTable(), {"Mellor_Yago_Rendili_Reign"})

		p_cis.Unlock_Tech(Find_Object_Type("CIS_DHC"))

		Story_Event("CIS_RENDILI_END")
	end
end

function State_CIS_DurgesLance_HoloNet(message)
	if message == OnEnter then
		Story_Event("CIS_HOLONET_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_6 = plot.Get_Event("CIS_DurgesLance_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("Target: Central HoloNet Relay")
		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", FindPlanet("Kaikielius"))
	end
end
function State_CIS_Holo_Hunt_Epilogue(message)
	if message == OnEnter then
		Story_Event("CIS_HOLONET_END")
		
		cis_quest_holonet_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")

		local event_act_6 = plot.Get_Event("CIS_DurgesLance_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("Target: Central HoloNet Relay (Destroyed)")

		Sleep(2.0)
 		StoryUtil.SetPlanetRestricted("KAIKIELIUS", 0)
   end
end

function State_CIS_DurgesLance_Shadowfeed(message)
	if message == OnEnter then
		Story_Event("CIS_SHADOWFEED_START")
		p_cis.Unlock_Tech(Find_Object_Type("ShadowFeed_Relay_Base"))

		Sleep(5.0)
		if not cis_quest_shadowfeed_over then
			Create_Thread("State_CIS_Quest_Checker_Shadowfeed")
		end
	end
end
function State_CIS_Quest_Checker_Shadowfeed()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_CIS.XML")
	local event_act_7 = plot.Get_Event("CIS_DurgesLance_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_21_BBY_DurgesLance_CIS")
	event_act_7.Clear_Dialog_Text()

	if Check_Story_Flag(p_cis, "CIS_CONSTRUCTION_01_SENSOR", nil, true) then
		current_amount_relay = 1
	end
	if Check_Story_Flag(p_cis, "CIS_CONSTRUCTION_02_SENSOR", nil, true) then
		current_amount_relay = 2
	end
	if Check_Story_Flag(p_cis, "CIS_CONSTRUCTION_03_SENSOR", nil, true) then
		current_amount_relay = 3
	end

	if current_amount_relay < 3 then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE", Find_Object_Type("ShadowFeed_Relay_Base"))
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_CURRENT", current_amount_relay)
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_TARGET", 3)
	else
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE_COMPLETE", Find_Object_Type("ShadowFeed_Relay_Base"))
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_CURRENT", current_amount_relay)
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_TARGET", 3)
	end

	event_act_7.Add_Dialog_Text("TEXT_NONE")

	if current_amount_relay >= 3 then
		cis_quest_shadowfeed_over = true
		p_cis.Lock_Tech(Find_Object_Type("ShadowFeed_Relay_Base"))
		Story_Event("CIS_SHADOWFEED_END")
	end

	Sleep(5.0)
	if not cis_quest_shadowfeed_over then
		Create_Thread("State_CIS_Quest_Checker_Shadowfeed")
	end
end

function State_CIS_DurgesLance_GC_Progression(message)
	if message == OnEnter then
		if TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
			if FindPlanet("Kuat").Get_Owner() == p_cis then
			StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
			end
			if FindPlanet("Kuat").Get_Owner() ~= p_cis then
				StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
			end
		elseif TestValid(Find_First_Object("Grievous_Recusant")) then
			if FindPlanet("Kuat").Get_Owner() == p_cis then
				StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
			end
			if FindPlanet("Kuat").Get_Owner() ~= p_cis then
				StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
			end
		elseif TestValid(Find_First_Object("Grievous_Munificent")) then
			if FindPlanet("Kuat").Get_Owner() == p_cis then
				StoryUtil.LoadCampaign("Sandbox_AU_2_OuterRimSieges_CIS", 0)
			end
			if FindPlanet("Kuat").Get_Owner() ~= p_cis then
				StoryUtil.LoadCampaign("Sandbox_OuterRimSieges_CIS", 0)
			end
		elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
			StoryUtil.LoadCampaign("Sandbox_AU_1_OuterRimSieges_CIS", 0)
		else
			grievous_dead = true
			StoryUtil.LoadCampaign("Sandbox_Foerost_CIS", 0)
		end
	end
end

-- Republic

function Rep_Story_Set_Up()
	Story_Event("REP_STORY_START")

	StoryUtil.SpawnAtSafePlanet("YAGDHUL", p_cis, StoryUtil.GetSafePlanetTable(), {"Grievous_Invisible_Hand"})
	StoryUtil.SpawnAtSafePlanet("DEVARON", p_cis, StoryUtil.GetSafePlanetTable(), {"Shaala_Doneeta_Team","Ventress_Team","Durge_Team"})
	StoryUtil.SpawnAtSafePlanet("ORD_VAUG", p_cis, StoryUtil.GetSafePlanetTable(), {"Shonn_Recusant"})
	StoryUtil.SpawnAtSafePlanet("RONYARDS", p_cis, StoryUtil.GetSafePlanetTable(), {"Krett_Lucrehulk_Battleship","Colicoid_Swarm"})
	StoryUtil.SpawnAtSafePlanet("IPHIGIN", p_cis, StoryUtil.GetSafePlanetTable(), {"Sora_Bulq_Team","Lucid_Voice"})
	StoryUtil.SafeSpawnFavourHero("THYFERRA", p_cis, {"Treetor_Captor"})

	StoryUtil.SpawnAtSafePlanet("COMMENOR", p_republic, StoryUtil.GetSafePlanetTable(), {"Ahalas_Svindren_Team"})
	StoryUtil.SpawnAtSafePlanet("HUMBARINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Armand_Isard_Team"})
	StoryUtil.SpawnAtSafePlanet("SARAPIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Plo_Koon_Delta_Team","Onaconda_Farr_Team"})
	StoryUtil.SpawnAtSafePlanet("THOMORK", p_republic, StoryUtil.GetSafePlanetTable(), {"Grant_Venator","Romodi_Team"})
	StoryUtil.SpawnAtSafePlanet("AILON", p_republic, StoryUtil.GetSafePlanetTable(), {"Mace_Windu_Eta_Team","Fordo_Team","Tallon_Sundiver"})

	if (GlobalValue.Get("ODL_Rep_GC_Version") == 1) then
		StoryUtil.SpawnAtSafePlanet("HUMBARINE", p_republic, StoryUtil.GetSafePlanetTable(), {"Mulleen_Imperator","Tector_Star_Destroyer","Tector_Star_Destroyer"})
	end

	if (GlobalValue.Get("CURRENT_CLONE_PHASE") == 2) then
		crossplot:publish("CLONE_UPGRADES", "empty")
		p_republic.Unlock_Tech(Find_Object_Type("Clonetrooper_Phase_Two_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("Republic_BARC_Company"))
		p_republic.Unlock_Tech(Find_Object_Type("ARC_Phase_Two_Company"))

		p_republic.Lock_Tech(Find_Object_Type("Clonetrooper_Phase_One_Company"))
		p_republic.Lock_Tech(Find_Object_Type("Republic_74Z_Bike_Company"))
		p_republic.Lock_Tech(Find_Object_Type("ARC_Phase_One_Company"))
	end

	StoryUtil.SetPlanetRestricted("CORELLIA", 1, false)
	StoryUtil.SetPlanetRestricted("RENDILI", 1, false)

	Create_Thread("State_Rep_Quest_Checker_Grievous_Hunt")
end
function State_Rep_Quest_Checker_Grievous_Hunt()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

	local DurgesLance_HeroList = {
		Find_First_Object("Colicoid_Swarm"),
		Find_First_Object("Lucid_Voice"),
		Find_First_Object("Grievous_Invisible_Hand"),
		Find_First_Object("Grievous_Munificent"),
		Find_First_Object("Grievous_Recusant"),
		Find_First_Object("Grievous_Malevolence"),
		Find_First_Object("Grievous_Malevolence_2"),
		Find_First_Object("General_Grievous"),
	}

	local event_act_1 = plot.Get_Event("Rep_DurgesLance_Act_I_Dialog")
	event_act_1.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_1.Clear_Dialog_Text()

	event_act_1.Add_Dialog_Text("Target: General Grievous / Current flagship unknown")
	event_act_1.Add_Dialog_Text("TEXT_NONE")
	for _,p_hero in pairs(DurgesLance_HeroList) do
		if TestValid(p_hero) then
			if TestValid(p_hero.Get_Planet_Location()) then
				event_act_1.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_POSSIBLE", p_hero.Get_Planet_Location())
			end
		end
	end

	if not TestValid(Find_First_Object("Colicoid_Swarm")) and not cis_act_1_death_01 then
		cis_act_1_death_01 = true
		Story_Event("REP_GRIEVOUS_END")
	end
	if not TestValid(Find_First_Object("Lucid_Voice")) and not cis_act_1_death_02 then
		cis_act_1_death_02 = true
		Story_Event("REP_GRIEVOUS_END")
	end

	if not TestValid(Find_First_Object("Colicoid_Swarm"))
	and not TestValid(Find_First_Object("Lucid_Voice"))
	and not TestValid(Find_First_Object("Grievous_Invisible_Hand"))
	and not TestValid(Find_First_Object("Grievous_Munificent"))
	and not TestValid(Find_First_Object("Grievous_Recusant"))
	and not TestValid(Find_First_Object("Grievous_Malevolence"))
	and not TestValid(Find_First_Object("Grievous_Malevolence_2"))
	and not TestValid(Find_First_Object("General_Grievous")) then
		Sleep(1.0)
		if not TestValid(Find_First_Object("Colicoid_Swarm"))
		and not TestValid(Find_First_Object("Lucid_Voice"))
		and not TestValid(Find_First_Object("Grievous_Invisible_Hand"))
		and not TestValid(Find_First_Object("Grievous_Munificent"))
		and not TestValid(Find_First_Object("Grievous_Recusant"))
		and not TestValid(Find_First_Object("Grievous_Malevolence"))
		and not TestValid(Find_First_Object("Grievous_Malevolence_2"))
		and not TestValid(Find_First_Object("General_Grievous")) then
			Sleep(1.0)
			rep_quest_grievous_hunt_over = true
			Story_Event("REP_GRIEVOUS_HUNT_END")
		end
	end

	Sleep(1.0)
	if not rep_quest_grievous_hunt_over then
		Create_Thread("State_Rep_Quest_Checker_Grievous_Hunt")
	end
end

function State_Rep_DurgesLance_Duro(message)
	if message == OnEnter then
		Story_Event("REP_DURO_START")

		if not rep_quest_duro_over then
			Create_Thread("State_Rep_Quest_Checker_Duro")
		end
	end
end
function State_Rep_Quest_Checker_Duro()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

	local event_act_2 = plot.Get_Event("Rep_DurgesLance_Act_II_Dialog")
	event_act_2.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_2.Clear_Dialog_Text()
	event_act_2.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION", FindPlanet("Duro"))

	if (EvaluatePerception("Has_Friendly_Space_Force", p_republic, FindPlanet("Duro")) == 0.0) then
		rep_quest_duro_over = true
		Sleep(2.0)

		p_republic.Give_Money(5000)
		Story_Event("REP_DURO_END")
		Sleep(12.0)

		Story_Event("REP_DURO_TACTICAL")
	end

	Sleep(20.0)
	if not rep_quest_duro_over then
		Create_Thread("State_Rep_Quest_Checker_Duro")
	end
end

function State_Rep_DurgesLance_Suspicions(message)
	if message == OnEnter then
		Story_Event("REP_SUSPICIONS_START")

		StoryUtil.SpawnAtSafePlanet("CHARDAAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Inglemenn_Barezz_Team"})

		if not rep_quest_suspicions_over then
			Create_Thread("State_Rep_Quest_Checker_Suspicions")
		end
	end
end
function State_Rep_Quest_Checker_Suspicions()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

	local event_act_3 = plot.Get_Event("Rep_DurgesLance_Act_III_Dialog")
	event_act_3.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_3.Clear_Dialog_Text()

	if TestValid(Find_First_Object("Inglemenn_Barezz")) then
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", Find_Object_Type("Inglemenn_Barezz_Team"))
		if TestValid(Find_First_Object("Inglemenn_Barezz").Get_Planet_Location()) then
			event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_CURRENT", Find_First_Object("Inglemenn_Barezz").Get_Planet_Location())
			
			if Find_First_Object("Inglemenn_Barezz").Get_Planet_Location() == FindPlanet("Duro") then
				Story_Event("REP_SUSPICIONS_END")
				rep_quest_suspicions_over = true
			end
		end
		event_act_3.Add_Dialog_Text("TEXT_INTERVENTION_LOCATION_TARGET", FindPlanet("Duro"))
		event_act_3.Add_Dialog_Text("TEXT_NONE")
	end

	Sleep(5.0)
	if not rep_quest_suspicions_over then
		Create_Thread("State_Rep_Quest_Checker_Suspicions")
	end
end
function State_Rep_Duro_Defence_Epilogue(message)
	if message == OnEnter then
		Story_Event("REP_DURO_END")
		ChangePlanetOwnerAndRetreat(FindPlanet("Duro"), p_cis)
		FindPlanet("Duro").Attach_Particle_Effect("Galactic_GtS_Attrition_Explosion") 
   end
end

function State_Rep_DurgesLance_Investigation(message)
	if message == OnEnter then
		Story_Event("REP_INVESTIGATION_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_DurgesLance_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Duro_Investigations"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Duro_Investigations"))
	end
end
function State_Rep_DurgesLance_Duro_Investigations_Research(message)
	if message == OnEnter then
		rep_quest_investigation_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_4 = plot.Get_Event("Rep_DurgesLance_Act_IV_Dialog")
		event_act_4.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_4.Clear_Dialog_Text()

		event_act_4.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Duro_Investigations"))
		Sleep(5.0)

		UnitUtil.DespawnList({"Onaconda_Farr"})
		Sleep(5.0)

		StoryUtil.SpawnAtSafePlanet("CHARDAAN", p_republic, StoryUtil.GetSafePlanetTable(), {"Coy_Imperator","Ardus_Kaine_Team"})
		Story_Event("REP_INVESTIGATION_END")
	end
end

function State_Rep_DurgesLance_Corellia(message)
	if message == OnEnter then
		Story_Event("REP_CORELLIA_START")

		if not rep_quest_corellia_over then
			Create_Thread("State_Rep_Quest_Checker_Corellia")
		end
	end
end
function State_Rep_Quest_Checker_Corellia()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

	local Corellia_PlanetList = {
		FindPlanet("Chasin"),
		FindPlanet("Devaron"),
		FindPlanet("Duro"),
		FindPlanet("New_Plympto"),
		FindPlanet("Ebaq"),
	}

	local event_act_5 = plot.Get_Event("Rep_DurgesLance_Act_V_Dialog")
	event_act_5.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_5.Clear_Dialog_Text()

	for _,p_planet in pairs(Corellia_PlanetList) do
		if p_planet.Get_Owner() == p_republic or p_planet.Get_Owner() == p_sector_forces then
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", p_planet)
		else
			event_act_5.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", p_planet)
		end
	end

	if (FindPlanet("Chasin").Get_Owner() == p_republic or FindPlanet("Chasin").Get_Owner() == p_sector_forces) 
	and (FindPlanet("Devaron").Get_Owner() == p_republic or FindPlanet("Devaron").Get_Owner() == p_sector_forces) 
	and (FindPlanet("Duro").Get_Owner() == p_republic or FindPlanet("Duro").Get_Owner() == p_sector_forces) 
	and (FindPlanet("New_Plympto").Get_Owner() == p_republic or FindPlanet("New_Plympto").Get_Owner() == p_sector_forces) 
	and (FindPlanet("Ebaq").Get_Owner() == p_republic or FindPlanet("Ebaq").Get_Owner() == p_sector_forces) then
		rep_quest_corellia_over = true

		StoryUtil.SetPlanetRestricted("CORELLIA", 0)

		Sleep(2.0)
		Story_Event("REP_CORELLIA_END")
		ChangePlanetOwnerAndReplace(FindPlanet("Corellia"), p_republic, 3)

		Sleep(2.0)
		StoryUtil.SpawnAtSafePlanet("CORELLIA", p_republic, StoryUtil.GetSafePlanetTable(), {"Garm_Bel_Iblis_Starbolt"})
	end

	Sleep(5.0)
	if not rep_quest_corellia_over then
		Create_Thread("State_Rep_Quest_Checker_Corellia")
	end
end

function State_Rep_DurgesLance_Rendili(message)
	if message == OnEnter then
		Story_Event("REP_RENDILI_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_DurgesLance_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION", FindPlanet("Rendili"))

		StoryUtil.SetPlanetRestricted("RENDILI", 0)
		ChangePlanetOwnerAndPopulate(FindPlanet("Rendili"), p_cis, 7500)

		StoryUtil.SpawnAtSafePlanet("SARAPIN", p_republic, StoryUtil.GetSafePlanetTable(), {"Dodonna_Acclamator"})

		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	elseif message == OnUpdate then
		crossplot:update()
	end
end
function State_Rep_DurgesLance_Conquest_Rendili(message)
	if message == OnEnter then
		rep_quest_rendili_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_6 = plot.Get_Event("Rep_DurgesLance_Act_VI_Dialog")
		event_act_6.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_6.Clear_Dialog_Text()

		event_act_6.Add_Dialog_Text("TEXT_INTERVENTION_PLANET_CONQUEST_LOCATION_COMPLETE", FindPlanet("Rendili"))

		Sleep(2.0)
		ChangePlanetOwnerAndRetreat(FindPlanet("Rendili"), p_republic)

		Sleep(2.0)
		StoryUtil.SpawnAtSafePlanet("RENDILI", p_republic, StoryUtil.GetSafePlanetTable(), {"Dallin_Kebir"})
		p_republic.Unlock_Tech(Find_Object_Type("Rep_DHC"))

		Story_Event("REP_RENDILI_END")
	end
end

function State_Rep_DurgesLance_HoloNet(message)
	if message == OnEnter then
		Story_Event("REP_HOLONET_START")
		p_republic.Unlock_Tech(Find_Object_Type("HoloNet_Relay_Base"))

		Sleep(5.0)
		if not rep_quest_holonet_over then
			Create_Thread("State_Rep_Quest_Checker_Holonet")
		end
	end
end
function State_Rep_Quest_Checker_Holonet()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")
	local event_act_7 = plot.Get_Event("Rep_DurgesLance_Act_VII_Dialog")
	event_act_7.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_7.Clear_Dialog_Text()

	if Check_Story_Flag(p_republic, "REP_CONSTRUCTION_01_SENSOR", nil, true) then
		current_amount_relay = 1
	end
	if Check_Story_Flag(p_republic, "REP_CONSTRUCTION_02_SENSOR", nil, true) then
		current_amount_relay = 2
	end
	if Check_Story_Flag(p_republic, "REP_CONSTRUCTION_03_SENSOR", nil, true) then
		current_amount_relay = 3
	end

	if current_amount_relay < 3 then
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE", Find_Object_Type("HoloNet_Relay_Base"))
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_CURRENT", current_amount_relay)
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_TARGET", 3)
	else
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE_COMPLETE", Find_Object_Type("HoloNet_Relay_Base"))
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_CURRENT", current_amount_relay)
		event_act_7.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY_TARGET", 3)
	end

	event_act_7.Add_Dialog_Text("TEXT_NONE")

	if current_amount_relay >= 3 then
		rep_quest_holonet_over = true
		p_republic.Lock_Tech(Find_Object_Type("HoloNet_Relay_Base"))
		Story_Event("REP_HOLONET_END")
	end

	Sleep(5.0)
	if not rep_quest_holonet_over then
		Create_Thread("State_Rep_Quest_Checker_Holonet")
	end
end

function State_Rep_DurgesLance_ShadowFeed(message)
	if message == OnEnter then
		Story_Event("REP_SHADOWFEED_START")

		StoryUtil.SpawnAtSafePlanet("EMPRESS_TETA", p_cis, StoryUtil.GetSafePlanetTable(), {"Munificent_Shadowfeed_Convoy","Munificent_Shadowfeed_Convoy"})
		StoryUtil.SpawnAtSafePlanet("KOORIVA", p_cis, StoryUtil.GetSafePlanetTable(), {"Munificent_Shadowfeed_Convoy","Munificent_Shadowfeed_Convoy"})
		StoryUtil.SpawnAtSafePlanet("TYNNA", p_cis, StoryUtil.GetSafePlanetTable(), {"Munificent_Shadowfeed_Convoy","Munificent_Shadowfeed_Convoy"})

		Sleep(5.0)
		if not rep_quest_shadowfeed_over then
			Create_Thread("State_Rep_Quest_Checker_Shadowfeed")
		end
	end
end
function State_Rep_Quest_Checker_Shadowfeed()
	local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

	local event_act_8 = plot.Get_Event("Rep_DurgesLance_Act_VIII_Dialog")
	event_act_8.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
	event_act_8.Clear_Dialog_Text()

	local convoy_list = Find_All_Objects_Of_Type("Munificent_Shadowfeed_Convoy")
	if table.getn(convoy_list) == 6 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 6)

	elseif table.getn(convoy_list) == 5 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 5)

	elseif table.getn(convoy_list) == 4 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 4)

	elseif table.getn(convoy_list) == 3 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 3)

	elseif table.getn(convoy_list) == 2 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 2)

	elseif table.getn(convoy_list) == 1 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", 1)

	elseif table.getn(convoy_list) == 0 then
		event_act_8.Add_Dialog_Text("TEXT_INTERVENTION_HUNT_COMPLETE", Find_Object_Type("Munificent_Shadowfeed_Convoy"))
		rep_quest_shadowfeed_over = true

		p_republic.Give_Money(5000)

		Story_Event("REP_SHADOWFEED_END")
	end

	Sleep(5.0)
	if not rep_quest_shadowfeed_over then
		Create_Thread("State_Rep_Quest_Checker_Shadowfeed")
	end
end

function State_Rep_DurgesLance_Plague(message)
	if message == OnEnter then
		Story_Event("REP_PLAGUE_START")

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_9 = plot.Get_Event("Rep_DurgesLance_Act_IX_Dialog")
		event_act_9.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_9.Clear_Dialog_Text()

		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT", Find_Object_Type("Dummy_Research_Plague_Vaccine"))
		Sleep(10.0)

		p_republic.Unlock_Tech(Find_Object_Type("Dummy_Research_Plague_Vaccine"))
	end
end
function State_Rep_DurgesLance_Plague_Vaccine_Research(message)
	if message == OnEnter then
		rep_quest_plague_over = true

		local plot = Get_Story_Plot("Conquests\\Historical\\21_BBY_CloneWarsDurgesLance\\Story_Sandbox_DurgesLance_Republic.XML")

		local event_act_9 = plot.Get_Event("Rep_DurgesLance_Act_IX_Dialog")
		event_act_9.Set_Dialog("Dialog_21_BBY_DurgesLance_Rep")
		event_act_9.Clear_Dialog_Text()

		event_act_9.Add_Dialog_Text("TEXT_INTERVENTION_OBJECT_COMPLETE", Find_Object_Type("Dummy_Research_Plague_Vaccine"))
		Sleep(5.0)

		Story_Event("REP_PLAGUE_END")
	end
end

function State_Rep_DurgesLance_GC_Progression(message)
	if message == OnEnter then
		StoryUtil.LoadCampaign("Sandbox_Foerost_Republic", 1)
	end
end

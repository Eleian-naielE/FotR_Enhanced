
--*****************************************************--
--**************** Rimward: Clone Chaos ***************--
--*****************************************************--

require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")
require("eawx-util/StoryUtil")
require("eawx-util/MissionUtil")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents =
	{
		Battle_Start = Begin_Battle,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_neutral = Find_Player("Neutral")

	act_1_active = false

	cinematic_one = false
	cinematic_two_alt_01 = false
	cinematic_two_alt_02 = false

	cinematic_one_skipped = false
	cinematic_two_alt_01_skipped = false
	cinematic_two_alt_02_skipped = false

	battle_over = false

	defenders_spawned = false

	mission_started = false
end
function Begin_Battle(message)
	if message == OnEnter then
		MissionUtil.VictoryAllowance(false)

		introcam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-1")
		introcam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-2")
		introcam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-3")
		introcam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-4")

		introcam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-1")
		introcam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-2")
		introcam_target_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-3")

		outrocam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-1")
		outrocam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-2")

		outrocam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-target-1")

		cis_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "cis")

		prop_c9979 = Find_Hint("C9979_CARRIER_LANDING_FULL", "c9979")

		mission_started = true
		if p_cis.Is_Human() then

			MissionUtil.DisableRetreat("EMPIRE", true)

			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Intro_CIS")
		elseif p_republic.Is_Human() then
			Register_Death_Event(Find_First_Object("VENTRESS"), State_Hero_Death_Ventress)

			MissionUtil.DisableRetreat("REBEL", true)

			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Intro_Rep")
		end
	end
end

function State_Hero_Death_C9979()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "REP", 2)
	p_republic.Give_Money(15000)
end
function State_Hero_Death_Grievous()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "REP", 3)
end
function State_Hero_Death_Ventress()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "REP", 4)
end

function State_Hero_Death_ObiWan()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "CIS", 2)
end
function State_Hero_Death_Anakin()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "CIS", 3)
end
function State_Hero_Death_Cody()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "CIS", 4)
end
function State_Hero_Death_Rex()
	MissionUtil.SetMissionObjectiveComplete("CLONE_CHAOS", "CIS", 5)
end

function Story_Handle_Esc()
	if p_cis.Is_Human() then
		if cinematic_one then
			if not cinematic_one_skipped then
				cinematic_one_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				if TestValid(prop_c9979) then
					p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", prop_c9979, p_cis)
					Register_Death_Event(p_c9979, State_Hero_Death_C9979)
					prop_c9979.Despawn()
				end
				if TestValid(p_c9979_lander) then
					p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", p_c9979_lander, p_cis)
					Register_Death_Event(p_c9979, State_Hero_Death_C9979)
					p_c9979_lander.Despawn()
				end

				MissionUtil.AddToReinforcementPool("REPUBLIC_JEDI_KNIGHT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_LAAT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_AT_TE_WALKER_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_AT_RT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_A5_JUGGERNAUT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_A6_JUGGERNAUT_COMPANY", p_republic, 1)
				MissionUtil.AddToReinforcementPool("CLONE_SPECIAL_OPS_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_ONE_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_ONE_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("ARC_PHASE_ONE_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_GALACTIC_MARINE_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("AT_XT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_BARC_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("AV7_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_ISP_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("AT_OT_WALKER_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("RX200_FALCHION_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_TX130S_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_UT_AA_COMPANY", p_republic, 8)

				MissionUtil.AddToReinforcementPool("MAGNAGUARD_SQUAD", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B2_RP_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("PAC_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("DESTROYER_DROID_I_W_COMPANY", p_cis, 8)
				--[[MissionUtil.AddToReinforcementPool("CRAB_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("J1_CANNON_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_GAT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_MTT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_SUPER_TANK_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("BX_COMMANDO_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B2_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B1_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("AAT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_STAP_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("HAILFIRE_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("HAG_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("MAGNA_OCTUPTARRA_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("OG9_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("PERSUADER_COMPANY", p_cis, 8)]]
				MissionUtil.AddToReinforcementPool("GRIEVOUS_TEAM", p_cis, 1)

				MissionUtil.SetObjectiveMissionSet("CLONE_CHAOS", "CIS", 5)
				MissionUtil.CinematicSkippingCleanUp(Find_First_Object("REINFORCEMENT_POINT_PLUS10_CAP"))
				MissionUtil.Set_To_Enemies(p_cis, p_republic)

				cinematic_one = false
				act_1_active = true

				Fade_Screen_In(0.5)
			end
		end
		if cinematic_two_alt_01 then
			if not cinematic_two_alt_01_skipped then
				cinematic_two_alt_01_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.DisableRetreat("REBEL", false)
				MissionUtil.DisableRetreat("EMPIRE", false)

				GlobalValue.Set("Rimward_CIS_Clone_Chaos_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
				StoryUtil.DeclareVictory(p_cis, false)
			end
		end
		if cinematic_two_alt_02 then
			if not cinematic_two_alt_02_skipped then
				cinematic_two_alt_02_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.DisableRetreat("REBEL", false)
				MissionUtil.DisableRetreat("EMPIRE", false)

				GlobalValue.Set("Rimward_CIS_Clone_Chaos_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
				StoryUtil.DeclareVictory(p_cis, true)
			end
		end
	elseif p_republic.Is_Human() then
		if cinematic_one then
			if not cinematic_one_skipped then
				cinematic_one_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				if TestValid(prop_c9979) then
					p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", prop_c9979, p_cis)
					Register_Death_Event(p_c9979, State_Hero_Death_C9979)
					prop_c9979.Despawn()
				end
				if TestValid(p_c9979_lander) then
					p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", p_c9979_lander, p_cis)
					Register_Death_Event(p_c9979, State_Hero_Death_C9979)
					p_c9979_lander.Despawn()
				end

				if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
					MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_TWO_COMPANY", p_republic, 8)
					MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_TWO_COMPANY", p_republic, 8)
					MissionUtil.AddToReinforcementPool("ARC_PHASE_TWO_COMPANY", p_republic, 8)
				else
					MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_ONE_COMPANY", p_republic, 8)
					MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_ONE_COMPANY", p_republic, 8)
					MissionUtil.AddToReinforcementPool("ARC_PHASE_ONE_COMPANY", p_republic, 8)
				end

				MissionUtil.AddToReinforcementPool("REPUBLIC_JEDI_KNIGHT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_LAAT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_SPECIAL_OPS_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("CLONE_GALACTIC_MARINE_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("AT_XT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_BARC_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_AT_TE_WALKER_COMPANY", p_republic, 8)

				--[[MissionUtil.AddToReinforcementPool("REPUBLIC_AT_RT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_A5_JUGGERNAUT_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_A6_JUGGERNAUT_COMPANY", p_republic, 1)
				MissionUtil.AddToReinforcementPool("AV7_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_ISP_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("AT_OT_WALKER_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("RX200_FALCHION_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_TX130S_COMPANY", p_republic, 8)
				MissionUtil.AddToReinforcementPool("REPUBLIC_UT_AA_COMPANY", p_republic, 8)]]

				MissionUtil.AddToReinforcementPool("MAGNAGUARD_SQUAD", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B2_RP_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("J1_CANNON_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("DESTROYER_DROID_I_W_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_MAF_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CRAB_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_GAT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_MTT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_SUPER_TANK_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("BX_COMMANDO_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B2_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("B1_DROID_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("AAT_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("CIS_STAP_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("HAILFIRE_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("HAG_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("MAGNA_OCTUPTARRA_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("OG9_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("PAC_COMPANY", p_cis, 8)
				MissionUtil.AddToReinforcementPool("PERSUADER_COMPANY", p_cis, 8)

				MissionUtil.SetObjectiveMissionSet("CLONE_CHAOS", "REP", 4)
				MissionUtil.CinematicSkippingCleanUp(Find_First_Object("REINFORCEMENT_POINT_PLUS10_CAP"))
				MissionUtil.Set_To_Enemies(p_cis, p_republic)

				cinematic_one = false
				act_1_active = true

				Fade_Screen_In(0.5)
			end
		end
		if cinematic_two_alt_01 then
			if not cinematic_two_alt_01_skipped then
				cinematic_two_alt_01_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.DisableRetreat("REBEL", false)
				MissionUtil.DisableRetreat("EMPIRE", false)

				StoryUtil.DeclareVictory(p_cis, false)
			end
		end
		if cinematic_two_alt_02 then
			if not cinematic_two_alt_02_skipped then
				cinematic_two_alt_02_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.DisableRetreat("REBEL", false)
				MissionUtil.DisableRetreat("EMPIRE", false)

				StoryUtil.DeclareVictory(p_cis, false)
			end
		end
	end
end
function Story_Mode_Service()
	if p_cis.Is_Human() then
		if act_1_active then
			local cis_command_post_list = Find_All_Objects_Of_Type(p_cis, "REINFORCEMENT_POINT_PLUS10_CAP")
			if (table.getn(cis_command_post_list) == 8) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_02_CIS")
				end
			end
			local rep_command_post_list = Find_All_Objects_Of_Type(p_republic, "REINFORCEMENT_POINT_PLUS10_CAP")
			if (table.getn(rep_command_post_list) == 8) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_01_CIS")
				end
			end
			local cis_list = Find_All_Objects_Of_Type(p_cis, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(cis_list) == 0) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_01_CIS")
				end
			end
			local rep_list = Find_All_Objects_Of_Type(p_republic, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(rep_list) == 0) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_02_CIS")
				end
			end
		end
	elseif p_republic.Is_Human() then
		if act_1_active then
			local cis_command_post_list = Find_All_Objects_Of_Type(p_cis, "REINFORCEMENT_POINT_PLUS10_CAP")
			if (table.getn(cis_command_post_list) == 8) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_02_Rep")
				end
			end
			local rep_command_post_list = Find_All_Objects_Of_Type(p_republic, "REINFORCEMENT_POINT_PLUS10_CAP")
			if (table.getn(rep_command_post_list) == 8) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_01_Rep")
				end
			end
			local rep_list = Find_All_Objects_Of_Type(p_republic, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(rep_list) == 0) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_02_Rep")
				end
			end
			local cis_list = Find_All_Objects_Of_Type(p_cis, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(cis_list) == 0) then
				if not battle_over then
					battle_over = true
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_01_Rep")
				end
			end
		end
	end
end

function Start_Cinematic_Intro_CIS()
	if not TestValid(Find_First_Object("Anakin")) and not TestValid(Find_First_Object("Anakin2")) and not TestValid(Find_First_Object("Anakin3")) then
		MissionUtil.SpawnUnitGround("ANAKIN_DELTA_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end
	if not TestValid(Find_First_Object("Obi_Wan")) and not TestValid(Find_First_Object("Obi_Wan2")) and not TestValid(Find_First_Object("Obi_Wan3")) then
		MissionUtil.SpawnUnitGround("OBI_WAN_DELTA_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end
	if not TestValid(Find_First_Object("Rex")) and not TestValid(Find_First_Object("Rex2")) then
		MissionUtil.SpawnUnitGround("REX_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end
	if not TestValid(Find_First_Object("Cody")) and not TestValid(Find_First_Object("Cody2")) then
		MissionUtil.SpawnUnitGround("CODY_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end
	if not TestValid(Find_First_Object("Shaak_Ti")) and not TestValid(Find_First_Object("Shaak_Ti2")) then
		MissionUtil.SpawnUnitGround("SHAAK_TI_DELTA_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end
	if not TestValid(Find_First_Object("Alpha_17")) and not TestValid(Find_First_Object("Alpha_17_2")) then
		MissionUtil.SpawnUnitGround("ALPHA_17_TEAM", Find_First_Object("DEFENDING FORCES POSITION"), p_republic)
	end

	Register_Death_Event(Find_First_Object("OBI_WAN"), State_Hero_Death_ObiWan)
	Register_Death_Event(Find_First_Object("ANAKIN"), State_Hero_Death_Anakin)
	Register_Death_Event(Find_First_Object("CODY"), State_Hero_Death_Cody)
	Register_Death_Event(Find_First_Object("REX"), State_Hero_Death_Rex)

	cinematic_one = true

	MissionUtil.StartCinematicCamera()
	MissionUtil.CinematicEnvironmentOn()

	MissionUtil.PlayGenericSpeech("Clone_Chaos_01")
	Sleep(1.0)

	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 1, 15.0, nil, nil, 0)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 2, 15.0, nil, nil, 0)

	MissionUtil.PlayGenericMusic("Christophsis_Clash_Theme")

	MissionUtil.SetCinematicCamera(introcam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_2_marker, introcam_target_2_marker, true, 7.5, nil, nil)

	Fade_Screen_In(3.0)
	Letter_Box_In(1.0)
	Sleep(4.5)

	p_c9979_lander = MissionUtil.CreateCinematicLander("C9979_CARRIER_LANDING_FULL", prop_c9979, p_cis, 10, true, "LANDING", 37.0)
	prop_c9979.Despawn()
	Sleep(3.0)

	MissionUtil.SetCinematicCamera(introcam_3_marker, introcam_target_3_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_4_marker, introcam_target_3_marker, true, 8.5, nil, nil)
	Sleep(8.5)

	if not cinematic_one_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Intro_CIS")
	end
end
function End_Cinematic_Intro_CIS()
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.EndCinematicCamera(Find_First_Object("REINFORCEMENT_POINT_PLUS10_CAP"), 3.5)
	Sleep(3.5)

	p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", p_c9979_lander, p_cis)
	p_c9979_lander.Despawn()

	MissionUtil.Set_To_Enemies(p_cis, p_republic)

	MissionUtil.AddToReinforcementPool("REPUBLIC_JEDI_KNIGHT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_LAAT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_AT_TE_WALKER_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_AT_RT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_A5_JUGGERNAUT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_A6_JUGGERNAUT_COMPANY", p_republic, 1)
	MissionUtil.AddToReinforcementPool("CLONE_SPECIAL_OPS_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_ONE_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_ONE_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("ARC_PHASE_ONE_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_GALACTIC_MARINE_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("AT_XT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_BARC_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("AV7_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_ISP_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("AT_OT_WALKER_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("RX200_FALCHION_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_TX130S_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_UT_AA_COMPANY", p_republic, 8)

	MissionUtil.AddToReinforcementPool("MAGNAGUARD_SQUAD", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B2_RP_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("PAC_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_MAF_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("DESTROYER_DROID_I_W_COMPANY", p_cis, 8)
	--[[MissionUtil.AddToReinforcementPool("CRAB_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("J1_CANNON_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_GAT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_MTT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_SUPER_TANK_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("BX_COMMANDO_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B2_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B1_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("AAT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_STAP_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("HAILFIRE_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("HAG_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("MAGNA_OCTUPTARRA_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("OG9_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("PERSUADER_COMPANY", p_cis, 8)]]
	MissionUtil.AddToReinforcementPool("GRIEVOUS_TEAM", p_cis, 1)

	MissionUtil.SetObjectiveMissionSet("CLONE_CHAOS", "CIS", 5)
	MissionUtil.CinematicEnvironmentOff()

	Stop_All_Speech()

	current_cinematic_thread_id = nil

	cinematic_one = false
	act_1_active = true
end

function Start_Cinematic_Outro_01_CIS()
	act_1_active = false
	cinematic_two_alt_01 = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(0.5)

	Fade_Screen_In(0.5)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 5, 8.0, nil, nil, 0)
	MissionUtil.PlayGenericMusic("Clone_Army_Theme")

	MissionUtil.SetCinematicCamera(outrocam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_2_marker, introcam_target_2_marker, true, 8.0, nil, nil)
	Sleep(3.0)

	Fade_Screen_Out(4.0)
	Sleep(5.0)

	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.DisableRetreat("REBEL", false)
	MissionUtil.DisableRetreat("EMPIRE", false)

	GlobalValue.Set("Rimward_CIS_Clone_Chaos_Outcome", 1) -- 0 = CIS Victory; 1 = Republic Victory
	StoryUtil.DeclareVictory(p_republic, false)
end
function Start_Cinematic_Outro_02_CIS()
	act_1_active = false
	cinematic_two_alt_02 = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(0.5)

	Fade_Screen_In(0.5)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 6, 5.0, nil, nil, 0)
	MissionUtil.PlayGenericMusic("Grievous_Theme")

	MissionUtil.SetCinematicCamera(outrocam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_2_marker, introcam_target_2_marker, true, 8.0, nil, nil)
	Sleep(3.0)

	Fade_Screen_Out(4.0)
	Sleep(5.0)

	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.DisableRetreat("REBEL", false)
	MissionUtil.DisableRetreat("EMPIRE", false)

	GlobalValue.Set("Rimward_CIS_Clone_Chaos_Outcome", 0) -- 0 = CIS Victory; 1 = Republic Victory
	StoryUtil.DeclareVictory(p_cis, true)
end

function Start_Cinematic_Intro_Rep()
	local unit_list = Find_All_Objects_Of_Type("GENERAL_GRIEVOUS")
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			unit.Despawn()
		end
	end

	player_grievous = MissionUtil.SpawnUnitGround("GENERAL_GRIEVOUS", cis_marker, p_cis)
	Register_Death_Event(player_grievous, State_Hero_Death_Grievous)

	Sleep(1.0)

	local rep_list = Find_All_Objects_Of_Type(p_republic, "InfantryHero | VehicleHero")
	for k, rep_unit in pairs(rep_list) do
		if TestValid(rep_unit) then
			rep_unit.Teleport_And_Face(Find_Hint("DEFENDING FORCES POSITION", "1"))
		end
	end

	local rep_list = Find_All_Objects_Of_Type(p_republic, "Vehicle | AirGunship | AirSpeeder")
	for k, rep_unit in pairs(rep_list) do
		if TestValid(rep_unit) then
			rep_unit.Teleport_And_Face(Find_Hint("DEFENDING FORCES POSITION", "2"))
		end
	end

	cinematic_one = true

	MissionUtil.StartCinematicCamera()
	MissionUtil.CinematicEnvironmentOn()

	MissionUtil.PlayGenericSpeech("Clone_Chaos_01")
	Sleep(1.0)

	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 1, 15.0, nil, nil, 0)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 2, 15.0, nil, nil, 0)
	MissionUtil.PlayGenericMusic("Christophsis_Clash_Theme")

	MissionUtil.SetCinematicCamera(introcam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_2_marker, introcam_target_2_marker, true, 7.5, nil, nil)

	Fade_Screen_In(3.0)
	Letter_Box_In(1.0)
	Sleep(4.5)

	p_c9979_lander = MissionUtil.CreateCinematicLander("C9979_CARRIER_LANDING_FULL", prop_c9979, p_cis, 10, true, "LANDING", 37.0)
	prop_c9979.Despawn()
	Sleep(3.0)

	MissionUtil.SetCinematicCamera(introcam_3_marker, introcam_target_3_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_4_marker, introcam_target_3_marker, true, 8.5, nil, nil)
	Sleep(8.5)

	if not cinematic_one_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Intro_Rep")
	end
end
function End_Cinematic_Intro_Rep()
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.EndCinematicCamera(Find_First_Object("REINFORCEMENT_POINT_PLUS10_CAP"), 3.5)
	Sleep(3.5)

	p_c9979 = MissionUtil.SpawnUnitGround("R_Ground_C9979", p_c9979_lander, p_cis)
	Register_Death_Event(p_c9979, State_Hero_Death_C9979)
	p_c9979_lander.Despawn()

	MissionUtil.Set_To_Enemies(p_cis, p_republic)

	if GlobalValue.Get("CURRENT_CLONE_PHASE") == 2 then
		MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_TWO_COMPANY", p_republic, 8)
		MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_TWO_COMPANY", p_republic, 8)
		MissionUtil.AddToReinforcementPool("ARC_PHASE_TWO_COMPANY", p_republic, 8)
	else
		MissionUtil.AddToReinforcementPool("CLONETROOPER_PHASE_ONE_COMPANY", p_republic, 8)
		MissionUtil.AddToReinforcementPool("CLONE_JUMPTROOPER_PHASE_ONE_COMPANY", p_republic, 8)
		MissionUtil.AddToReinforcementPool("ARC_PHASE_ONE_COMPANY", p_republic, 8)
	end

	MissionUtil.AddToReinforcementPool("REPUBLIC_JEDI_KNIGHT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_LAAT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_SPECIAL_OPS_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("CLONE_GALACTIC_MARINE_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("AT_XT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_BARC_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_AT_TE_WALKER_COMPANY", p_republic, 8)

	--[[MissionUtil.AddToReinforcementPool("REPUBLIC_AT_RT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_A5_JUGGERNAUT_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_A6_JUGGERNAUT_COMPANY", p_republic, 1)
	MissionUtil.AddToReinforcementPool("AV7_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_ISP_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("AT_OT_WALKER_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("RX200_FALCHION_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_TX130S_COMPANY", p_republic, 8)
	MissionUtil.AddToReinforcementPool("REPUBLIC_UT_AA_COMPANY", p_republic, 8)]]

	MissionUtil.AddToReinforcementPool("MAGNAGUARD_SQUAD", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B2_RP_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("J1_CANNON_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("DESTROYER_DROID_I_W_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_MAF_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CRAB_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_GAT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_MTT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_SUPER_TANK_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("BX_COMMANDO_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B2_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("B1_DROID_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("AAT_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("CIS_STAP_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("HAILFIRE_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("HAG_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("MAGNA_OCTUPTARRA_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("OG9_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("PAC_COMPANY", p_cis, 8)
	MissionUtil.AddToReinforcementPool("PERSUADER_COMPANY", p_cis, 8)

	MissionUtil.SetObjectiveMissionSet("CLONE_CHAOS", "REP", 4)
	MissionUtil.CinematicEnvironmentOff()

	Stop_All_Speech()
	MissionUtil.AIActivation()
	current_cinematic_thread_id = nil

	cinematic_one = false
	act_1_active = true
end

function Start_Cinematic_Outro_01_Rep()
	act_1_active = false
	cinematic_two_alt_01 = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(0.5)

	Fade_Screen_In(0.5)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 5, 8.0, nil, nil, 0)
	MissionUtil.PlayGenericMusic("Clone_Army_Theme")

	MissionUtil.SetCinematicCamera(outrocam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_2_marker, introcam_target_2_marker, true, 8.0, nil, nil)
	Sleep(3.0)

	Fade_Screen_Out(4.0)
	Sleep(5.0)

	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.DisableRetreat("REBEL", false)
	MissionUtil.DisableRetreat("EMPIRE", false)

	StoryUtil.DeclareVictory(p_republic, false)
end
function Start_Cinematic_Outro_02_Rep()
	act_1_active = false
	cinematic_two_alt_02 = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(0.5)

	Fade_Screen_In(0.5)
	MissionUtil.MissionTextSpeech("CLONE_CHAOS", 6, 5.0, nil, nil, 0)
	MissionUtil.PlayGenericMusic("Grievous_Theme")

	MissionUtil.SetCinematicCamera(outrocam_1_marker, introcam_target_1_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_2_marker, introcam_target_2_marker, true, 8.0, nil, nil)
	Sleep(3.0)

	Fade_Screen_Out(4.0)
	Sleep(5.0)

	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.DisableRetreat("REBEL", false)
	MissionUtil.DisableRetreat("EMPIRE", false)

	StoryUtil.DeclareVictory(p_cis, false)
end

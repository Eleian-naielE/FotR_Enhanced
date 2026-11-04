
--*****************************************************--
--***** Operation Knight Hammer: Bespin Breakdown *****--
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
	protodeka_squad_list = {"PROTODEKA"}
	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_hostiles = Find_Player("Hutt_Cartels")

    current_cinematic_thread_id = nil

	act_1_active = false
	act_2_active = false
	cinematic_one = false
	cinematic_two = false
	cinematic_three = false

	cinematic_one_skipped = false
	cinematic_two_skipped = false
	cinematic_three_skipped = false

	mission_started = false
	mission_over = false

end
function Begin_Battle(message)
    if message == OnEnter then
        MissionUtil.VictoryAllowance(false)
        MissionUtil.DisableRetreat("REBEL", true)
		MissionUtil.DisableRetreat("EMPIRE", true)       

        Rep_lander_1_marker = Find_Hint("PROPONLY_LANDED_EMPIRE_SHUTTLE", "lander-1")
		Rep_lander_2_marker = Find_Hint("PROPONLY_LANDED_EMPIRE_SHUTTLE", "lander-2")
		Rep_lander_3_marker = Find_Hint("PROPONLY_LANDED_EMPIRE_SHUTTLE", "lander-3")
		outro_zuko_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-zuko")
		introcam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-1")
		introcam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-2")
		introcam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-3")
		introcam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-4")
		introcam_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-5")
		introcam_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-6")
		introcam_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-7")

		midtrocam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-1")
		midtrocam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-2")
		midtrocam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-3")
		midtrocam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-4")
		p_cis.Disable_Orbital_Bombardment(true)
		p_republic.Disable_Orbital_Bombardment(true)
		p_hostiles.Disable_Orbital_Bombardment(true)

		p_republic.Disable_Bombing_Run(true)
		p_cis.Disable_Bombing_Run(true)
		p_hostiles.Disable_Bombing_Run(true)
		midtrocam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-1")
		midtrocam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-2")

		introcam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-1")
		introcam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-2")
		introcam_target_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-3")
		introcam_target_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-4")
		introcam_target_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-5")
        introcam_target_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-6")

		outrocam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-1")
		outrocam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-2")
		outrocam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-3")
		outrocam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-4")
		outrocam_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-5")
		outrocam_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-6")
		outrocam_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-7")
		outrocam_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-8")
		outrocam_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-9")

		outrocam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-target-1")
		outrocam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-target-2")

		outro_cultist_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-1")
		outro_cultist_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-2")
		outro_cultist_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-3")
		outro_cultist_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-4")
		outro_cultist_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-5")
		outro_cultist_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-6")
		outro_cultist_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-7")
		outro_cultist_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-8")
		outro_cultist_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-cultist-9")

        defender_phase_1_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "arc-phase-1")
        defender_phase_1_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "militia-phase-1")
        defender_phase_1_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "terenterak")

		intro_1_anakin_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-anakin")
		intro_1_halcyon_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-halcyon")

		intro_1_zuko_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-zuko-1")
		zuko_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "protodeka-phase-2")
		intro_1_iroh_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "irotah-marker")
		intro_1_iroh_test_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "irotah-marker-test")
		intro_1_teren_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-terentarak-1")

		player_anakin = Find_First_Object("ANAKIN")
		Register_Death_Event(player_anakin, State_Hero_Death)
		FogOfWar.Reveal(p_republic, player_anakin, 200)

		player_halcyon = Find_First_Object("NEJAA_HALCYON")
		Register_Death_Event(player_halcyon, State_Hero_Death)

		player_zuko = Find_First_Object("ZUKAO")
		Register_Death_Event(player_zuko, State_Hero_Death)

		player_iroh = Find_First_Object("IROTAH")
		Register_Death_Event(player_iroh, State_Hero_Death)

        player_terentarak = Find_First_Object("PASSIVE_SITH_TERENTATEK")

		p_republic.Disable_Orbital_Bombardment(true)

		mission_started = true
		current_cinematic_thread_id = Create_Thread("Start_Cinematic_Intro_Rep")
	end
end

function State_Hero_Death()
	if p_republic.Is_Human() then
		if not TestValid(player_anakin) then
			MissionUtil.SetMissionObjectiveFailed("BESPIN_BREAKDOWN", "REP", 3)
			StoryUtil.TriggerScriptedBattle("BESPIN_BREAKDOWN", "BESPIN", "LAND", "EMPIRE", "REBEL", false, nil, "VIC")
			StoryUtil.DeclareVictory(p_cis, false)
		end
		if not TestValid(player_halcyon) then
			MissionUtil.SetMissionObjectiveFailed("BESPIN_BREAKDOWN", "REP", 4)
			StoryUtil.TriggerScriptedBattle("BESPIN_BREAKDOWN", "BESPIN", "LAND", "EMPIRE", "REBEL", false, nil, "VIC")
			StoryUtil.DeclareVictory(p_cis, false)
		end
		if not TestValid(player_iroh) then
			MissionUtil.SetMissionObjectiveComplete("BESPIN_BREAKDOWN", "REP", 2)
			current_cinematic_thread_id = Create_Thread("Start_Battle_Phase_Two")
		end
	end
end

function State_CIS_Spawner()
	act_1_active = true
    local marker_list = Find_All_Objects_With_Hint("arc-phase-1")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("Clone_Commando_Rework_Company_Dummy", marker, p_republic, 2) -- FotR_Enhanced
        end
    end
    local marker_list = Find_All_Objects_With_Hint("rep-bike")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("REPUBLIC_BARC_SPEEDER", marker, p_republic, 1)
        end
    end
    local marker_list = Find_All_Objects_With_Hint("militia-phase-1")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("HEAVY_SCAVENGER_SQUAD", marker, p_cis, 1)
        end
    end
    local marker_list = Find_All_Objects_With_Hint("bikes")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("HUTT_STARHAWK", marker, p_cis, 6)
        end
    end
    local marker_list = Find_All_Objects_With_Hint("terenterak")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("TERENTATEK_MISSION", marker, p_hostiles, 1)
        end
    end
end
function State_CIS_Spawner_Two()
	act_2_active = true
    local marker_list = Find_All_Objects_With_Hint("war-behemoth-phase-2")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("SITH_WAR_BEHEMOTH", marker, p_cis, 1)
        end
    end
    local marker_list = Find_All_Objects_With_Hint("militia-phase-2")
    for k, marker in pairs(marker_list) do
        if TestValid(marker) then
            MissionUtil.SpawnListSpawner("SUN_GUARD_COMPANY", marker, p_cis, 1)
        end
    end
end

function Start_Battle_Phase_Two()
	SpawnList(protodeka_squad_list, zuko_marker, p_cis, true, true)
    cinematic_two = true
	Start_Cinematic_Camera()
	Suspend_AI(1)
	Lock_Controls(1)
	Cancel_Fast_Forward()
	Stop_All_Music()
	Fade_On()
	Sleep(2.0)
	Fade_Screen_In(3.0)
	Letter_Box_In(3.0)
	MissionUtil.SetCinematicCamera(midtrocam_1_marker, midtrocam_target_2_marker, true, nil, nil)
    Play_Music("FoC_Tybers_Plan_Theme")
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_08")	
	Sleep(6.5)
	MissionUtil.TransitionCinematicCamera(midtrocam_2_marker, midtrocam_target_1_marker, true, 8.5, nil, nil)
	Sleep(9.5)
	Play_Music("FoC_Tybers_Plan_Theme")
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_09")	
	MissionUtil.TransitionCinematicCamera(midtrocam_3_marker, midtrocam_target_1_marker, true, 8.5, nil, nil)
	Sleep(9.0)
	Create_Thread("State_CIS_Spawner_Two")
	act_1_active = false
	Sleep(4.0)
	if not cinematic_two_skipped then
		current_cinematic_thread_id = Create_Thread("End_Battle_Phase_Two")
	end
end
function End_Battle_Phase_Two()
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_10")
	MissionUtil.TransitionCinematicCamera(midtrocam_4_marker, midtrocam_target_2_marker, true, 8.5, nil, nil)
	Sleep(9.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.EndCinematicCamera(player_anakin, 2.0)
	act_2_active = true
	p_republic.Make_Enemy(p_cis)
	p_cis.Make_Enemy(p_republic)

	MissionUtil.CinematicEnvironmentOff()
	current_cinematic_thread_id = nil
	MissionUtil.AIActivation()
	cinematic_two = false
	blast_door_list = Find_All_Objects_Of_Type("GENERIC_MAGNETIC_BLAST_DOOR_BIG")
	for k, blast_doors in pairs(blast_door_list) do
		if TestValid(blast_doors) then
			blast_doors.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
			blast_doors.Play_Animation("Cinematic", false, 1)
			Sleep(2.0)
			blast_doors.Despawn()
		end
	end
end

function Story_Handle_Esc()
    if p_republic.Is_Human() then
		if cinematic_one then
			if not cinematic_one_skipped then
				cinematic_one_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				MissionUtil.CinematicSkippingCleanUp(player_anakin)

				MissionUtil.SetObjectiveMissionSet("BESPIN_BREAKDOWN", "REP", 6)

                player_terentarak.Despawn()
                player_zuko.Despawn()

				cinematic_one = false

				Fade_Screen_In(0.5)
			end
		end
		if cinematic_two then
			if not cinematic_two_skipped then
				cinematic_two_skipped = true
				 --MessageBox("Escape Key Pressed!!!")

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				MissionUtil.CinematicSkippingCleanUp(player_anakin)

				blast_door_list = Find_All_Objects_Of_Type("GENERIC_MAGNETIC_BLAST_DOOR_BIG")
				for k, blast_doors in pairs(blast_door_list) do
					if TestValid(blast_doors) then
						blast_doors.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
						blast_doors.Play_Animation("Cinematic", false, 1)
						blast_doors.Despawn()
					end
				end

				Create_Thread("State_CIS_Spawner_Two")
				act_1_active = false
				act_2_active = true	

				cinematic_two = false

				Fade_Screen_In(0.5)
			end
		end
		if cinematic_three then
			if not cinematic_three_skipped then
				cinematic_three_skipped = true

				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end

				p_cis.Disable_Orbital_Bombardment(false)
				p_republic.Disable_Orbital_Bombardment(false)

				p_republic.Disable_Bombing_Run(true)
				p_cis.Disable_Bombing_Run(true)

				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.DisableRetreat("REBEL", false)
				MissionUtil.DisableRetreat("EMPIRE", false)

				StoryUtil.DeclareVictory(p_republic, false)
			end
		end
	end
end
function Story_Mode_Service()
	if p_republic.Is_Human() then
		if act_2_active then
			local cis_list = Find_All_Objects_Of_Type(p_cis, "PROTODEKA")
			if (table.getn(cis_list) == 0) then
				MissionUtil.SetMissionObjectiveComplete("BESPIN_BREAKDOWN", "REP", 5)
				if not mission_over then
					mission_over = true
					act_2_active = false
					current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_Rep")
				end
			end
		end
	end
end

function Start_Cinematic_Intro_Rep()
    
    cinematic_one = true
	Start_Cinematic_Camera()
	Suspend_AI(1)
	Lock_Controls(1)
	Cancel_Fast_Forward()
	Stop_All_Music()
	Fade_On()

	player_anakin.Teleport_And_Face(intro_1_anakin_marker)
	player_halcyon.Teleport_And_Face(intro_1_halcyon_marker)
	player_zuko.Teleport_And_Face(intro_1_zuko_marker)
	player_iroh.Teleport_And_Face(intro_1_iroh_marker)
	player_terentarak.Teleport_And_Face(intro_1_teren_marker)
	Create_Thread("State_CIS_Spawner")	
	MissionUtil.SetCinematicCamera(introcam_1_marker, introcam_target_6_marker, true, nil, nil)
    Play_Music("Clone_Army_Theme")
	Fade_Screen_In(3.0)
	Letter_Box_In(3.0)
	Sleep(4.5)
	MissionUtil.PlayAnimation(player_anakin, "Talk", true, 0)
	MissionUtil.PlayAnimation(player_halcyon, "Talk", true, 0)
	MissionUtil.TransitionCinematicCamera(introcam_2_marker, introcam_target_3_marker, true, 8.5, nil, nil)
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_00")
	Sleep(12.0)
    MissionUtil.TransitionCinematicCamera(introcam_3_marker, introcam_target_3_marker, true, 8.5, nil, nil)   
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_01")
    Sleep(11.0)
    MissionUtil.TransitionCinematicCamera(introcam_3_marker, introcam_target_6_marker, true, 8.5, nil, nil) 
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_02")  
    Sleep(8.0)
	Sleep(3.0)
    MissionUtil.TransitionCinematicCamera(introcam_2_marker, introcam_target_6_marker, true, 8.5, nil, nil)  
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_03") 
	MissionUtil.PlayAnimation(player_anakin, "Talk", false, 0)
	MissionUtil.PlayAnimation(player_halcyon, "Talk", false, 0)
	MissionUtil.CreateCinematicLander("RHO_SHUTTLE_LANDING_CRAFT_CLONES_LANDING", Rep_lander_1_marker, p_republic, 4.5, 1, "LANDING", 91)
	MissionUtil.CreateCinematicLander("RHO_SHUTTLE_LANDING_CRAFT_CLONES_LANDING", Rep_lander_2_marker, p_republic, 4.5, 1, "LANDING", 91)
	MissionUtil.CreateCinematicLander("RHO_SHUTTLE_LANDING_CRAFT_CLONES_LANDING", Rep_lander_3_marker, p_republic, 4.5, 1, "LANDING", 91)
	Sleep(1.5)
    Sleep(3.8)
	Fade_Screen_Out(3.0)
	Sleep(4.0)
    Play_Music("ESB_The_Imperial_Probe_Theme")
    MissionUtil.SetCinematicCamera(introcam_4_marker, introcam_target_4_marker, true, nil, nil)
	Fade_Screen_In(3.0)
	Letter_Box_In(3.0)
	Sleep(1.0)
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_04") 
    Sleep(9.0)
    MissionUtil.TransitionCinematicCamera(introcam_5_marker, introcam_target_4_marker, true, 8.5, nil, nil)
	MissionUtil.PlayAnimation(player_iroh, "Talk", true, 2)
	MissionUtil.PlayAnimation(player_zuko, "Talk", true, 2)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_05")  
	Sleep(1.0)
    Sleep(10.0)
	MissionUtil.PlayAnimation(player_zuko, "Choke", true, 0)
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_07")
	MissionUtil.PlayAnimation(player_iroh, "Talk", true, 1)
    Sleep(1.0)
	MissionUtil.PlayAnimation(player_iroh, "Talk", false, 1)
	Sleep(9.0)
    MissionUtil.TransitionCinematicCamera(introcam_6_marker, introcam_target_5_marker, true, 8.5, nil, nil)
    Sleep(11.0)
    MissionUtil.TransitionCinematicCamera(introcam_7_marker, introcam_target_2_marker, true, 8.5, nil, nil)   

	if not cinematic_one_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Intro_Rep")
	end
end
function End_Cinematic_Intro_Rep()
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.EndCinematicCamera(player_zuko, 2.0)
	Sleep(2.0)
	
	player_terentarak.Despawn()
    player_zuko.Despawn()

	p_republic.Make_Enemy(p_cis)
	p_cis.Make_Enemy(p_republic)

	MissionUtil.SetObjectiveMissionSet("BESPIN_BREAKDOWN", "REP", 6)
	MissionUtil.CinematicEnvironmentOff()

	MissionUtil.AIActivation()

	current_cinematic_thread_id = nil

	cinematic_one = false
	
end

function Start_Cinematic_Outro_Rep()
	act_2_active = false
	cinematic_three = true

	Fade_Screen_Out(0.5)
	Sleep(1.0)
	Suspend_AI(1)
	p_republic.Make_Ally(p_cis)
	p_cis.Make_Ally(p_republic)
	MissionUtil.StartCinematicCamera()
	MissionUtil.CinematicEnvironmentOn()

    Play_Music("CW_Urban_Ambient_5_Theme")
	player_zuko_outro = MissionUtil.SpawnUnitGround("ZUKAO", outro_zuko_marker, p_cis)
	Hide_Sub_Object(player_zuko_outro, 1, "Lightsaber")
	Hide_Sub_Object(player_zuko_outro, 1, "saberglow")
	player_zuko_outro.Enable_Behavior(78, false)
	player_cultist_1 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_1_marker, p_cis)
	Hide_Sub_Object(player_cultist_1, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_1, 1, "saberglow")
	player_cultist_2 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_2_marker, p_cis)
	Hide_Sub_Object(player_cultist_2, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_2, 1, "saberglow")
	player_cultist_3 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_3_marker, p_cis)
	Hide_Sub_Object(player_cultist_3, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_3, 1, "saberglow")
	player_cultist_4 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_4_marker, p_cis)
	Hide_Sub_Object(player_cultist_4, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_4, 1, "saberglow")
	player_cultist_5 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_5_marker, p_cis)
	Hide_Sub_Object(player_cultist_5, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_5, 1, "saberglow")
	player_cultist_6 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_6_marker, p_cis)
	Hide_Sub_Object(player_cultist_6, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_6, 1, "saberglow")
	player_cultist_7 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_7_marker, p_cis)
	Hide_Sub_Object(player_cultist_7, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_7, 1, "saberglow")
	player_cultist_8 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_8_marker, p_cis)
	Hide_Sub_Object(player_cultist_8, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_8, 1, "saberglow")
	player_cultist_9 = MissionUtil.SpawnUnitGround("SITH_CULT_FANATIC", outro_cultist_9_marker, p_cis)
	Hide_Sub_Object(player_cultist_9, 1, "Lightsaber")
	Hide_Sub_Object(player_cultist_9, 1, "saberglow")
	Sleep(4.5)
	player_cultist_1.Turn_To_Face(player_zuko_outro)
	player_cultist_2.Turn_To_Face(player_zuko_outro)
	player_cultist_3.Turn_To_Face(player_zuko_outro)
	player_cultist_4.Turn_To_Face(player_zuko_outro)
	player_cultist_5.Turn_To_Face(player_zuko_outro)
	player_cultist_6.Turn_To_Face(player_zuko_outro)
	player_cultist_7.Turn_To_Face(player_zuko_outro)
	player_cultist_8.Turn_To_Face(player_zuko_outro)
	player_cultist_9.Turn_To_Face(player_zuko_outro)
	Fade_Screen_In(3.0)
	Letter_Box_In(3.0)
	MissionUtil.SetCinematicCamera(outrocam_1_marker, outrocam_target_1_marker, true, nil, nil)
    MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_11")
	Sleep(1.0)	
	MissionUtil.PlayAnimation(player_zuko_outro, "FW_ATTACK", true, 0)

	MissionUtil.PlayAnimation(player_cultist_1, "Cinematic", true, 1)
		Sleep(.5)
	MissionUtil.PlayAnimation(player_cultist_2, "Cinematic", true, 1)
	MissionUtil.PlayAnimation(player_cultist_3, "Cinematic", true, 1)
		Sleep(.5)
	MissionUtil.TransitionCinematicCamera(outrocam_2_marker, outrocam_target_1_marker, true, 8.5, nil, nil)
	MissionUtil.PlayAnimation(player_cultist_4, "Cinematic", true, 1)
	MissionUtil.PlayAnimation(player_cultist_5, "Cinematic", true, 1)
	MissionUtil.PlayAnimation(player_cultist_6, "Cinematic", true, 1)
		Sleep(.5)
	MissionUtil.PlayAnimation(player_cultist_7, "Cinematic", true, 1)
		Sleep(.5)
	MissionUtil.PlayAnimation(player_cultist_8, "Cinematic", true, 1)
	MissionUtil.PlayAnimation(player_cultist_9, "Cinematic", true, 1)
		Sleep(4.5)
	MissionUtil.TransitionCinematicCamera(outrocam_3_marker, outrocam_target_1_marker, true, 8.5, nil, nil)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_12")
		Sleep(13)

	MissionUtil.PlayAnimation(player_zuko_outro, "FL_ATTACK", true, 0)
	Sleep(1.5)
	MissionUtil.PlayAnimation(player_zuko_outro, "Cinematic", false, 1)
	Sleep(.5)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_13")
	Sleep(5.0)
	MissionUtil.PlayAnimation(player_zuko_outro, "Die", true, 0)
	MissionUtil.TransitionCinematicCamera(introcam_6_marker, outrocam_target_1_marker, true, 8.5, nil, nil)
	Sleep(0.45)
	MissionUtil.SpawnUnitGround("HUGE_EXPLOSION_LAND", outro_zuko_marker, p_cis)
	player_zuko_outro.Despawn()
	player_cultist_1.Despawn()
	player_cultist_2.Despawn()
	player_cultist_3.Despawn()
	player_cultist_4.Despawn()
	player_cultist_5.Despawn()
	player_cultist_6.Despawn()
	player_cultist_7.Despawn()
	player_cultist_8.Despawn()
	player_cultist_9.Despawn()
	Sleep(1.5)
	Sleep(8.0)
	Fade_Screen_Out(3.0)
	player_anakin.Teleport_And_Face(intro_1_anakin_marker)
	player_halcyon.Teleport_And_Face(intro_1_halcyon_marker)
	Play_Music("CW_Urban_Ambient_5_Theme")
	Sleep(4.0)
    MissionUtil.SetCinematicCamera(introcam_6_marker, introcam_target_5_marker, true, nil, nil) 
	Fade_Screen_In(3.0)
	Sleep(3.0)
	Letter_Box_In(3.0)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_14")
	Sleep(12.5)
	Fade_Screen_Out(3.0)
	Sleep(4.0)
	MissionUtil.PlayAnimation(player_anakin, "Talk", true, 0)
	MissionUtil.PlayAnimation(player_halcyon, "Talk", true, 0)
	MissionUtil.SetCinematicCamera(introcam_3_marker, introcam_target_3_marker, true, nil, nil) 
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_15")
	Fade_Screen_In(3.0)
	Sleep(4.5)
	MissionUtil.TransitionCinematicCamera(introcam_1_marker, introcam_target_3_marker, true, 8.5, nil, nil)
	Sleep(6.5)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_16")
	Sleep(4.5)
	MissionUtil.PlayAnimation(player_anakin, "Talk", false, 0)
	MissionUtil.PlayAnimation(player_halcyon, "Talk", false, 0)
	MissionUtil.TransitionCinematicCamera(outrocam_9_marker, introcam_target_1_marker, true, 8.5, nil, nil)
	Sleep(8.5)
	MissionUtil.CinematicIntroHeader("BESPIN_BREAKDOWN_17")
	Sleep(3.5)
	Cinematic_Zoom(15, 5)
	Sleep(4.0)
	Do_End_Cinematic_Cleanup()
	Fade_Screen_Out(3.0)
	Sleep(8.0)
	p_cis.Disable_Orbital_Bombardment(false)
	p_republic.Disable_Orbital_Bombardment(false)
	p_hostiles.Disable_Orbital_Bombardment(false)

	p_republic.Disable_Bombing_Run(false)
	p_cis.Disable_Bombing_Run(false)
	p_hostiles.Disable_Bombing_Run(false)
	MissionUtil.DisableRetreat("REBEL", false)
	MissionUtil.DisableRetreat("EMPIRE", false)

	StoryUtil.DeclareVictory(p_republic, false)
end
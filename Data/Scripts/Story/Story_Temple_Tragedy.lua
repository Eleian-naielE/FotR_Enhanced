
--*****************************************************--
--********* Outer Rim Sieges: Temple Tragedy **********--
--*****************************************************--

require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")
require("eawx-util/StoryUtil")
require("eawx-util/MissionUtil")

-- FotR_Enhanced ; 
-- Clone Commandos replaced with rework mission variant
-- Spec ops replaced with Marines
-- Darkside Anakin red blade temporarily hidden for blue blade

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents =
	{
		Battle_Start = Begin_Battle,
	}

	p_cis = Find_Player("Rebel")
	p_republic = Find_Player("Empire")
	p_secforce = Find_Player("Sector_Forces")
	p_neutral = Find_Player("Neutral")
	p_hostile = Find_Player("Independent_Forces")

	act_1_active = false
    act_2_active = false
    act_3_active = false
	act_4_active = false
    act_5_active = false
    act_6_active = false
	cave_reached_anakin = false
	nu_reached_anakin = false
	cin_reached_anakin = false
	zone_reached_anakin = false
	zone_2_reached_anakin = false
	cinematic_one = false
	cinematic_two = false
	cinematic_three = false
	cinematic_mid = false
	cinematic_four = false
	cinematic_five = false
	cinematic_six = false
	cinematic_seven = false
	cinematic_eight = false
	cinematic_one_skipped = false
	cinematic_two_skipped = false
	cinematic_three_skipped = false
	cinematic_four_skipped = false
	cinematic_mid_skipped = false
	cinematic_five_skipped = false
	cinematic_six_skipped = false
	cinematic_seven_skipped = false
	cinematic_eight_skipped = false
	initial_troops = false
	int_guard_spawn = false
	library_guard_spawn = false
	draliq_spawn = false

	mission_started = false
end
function Begin_Battle(message)
	if message == OnEnter then
		MissionUtil.VictoryAllowance(false)

		MissionUtil.DisableRetreat("REBEL", true)
		MissionUtil.DisableRetreat("EMPIRE", true)
		MissionUtil.DisableRetreat("SECTOR_FORCES", true)
		MissionUtil.DisableRetreat("INDEPENDENT_FORCES", true)

		p_cis.Disable_Orbital_Bombardment(true)
		p_republic.Disable_Orbital_Bombardment(true)
		p_secforce.Disable_Orbital_Bombardment(true)

		p_republic.Disable_Bombing_Run(false)
		p_cis.Disable_Bombing_Run(false)
		p_secforce.Disable_Bombing_Run(false)

		p_door_1 = Find_Hint("MISSION_MAGNETIC_BLAST_DOOR_BIG", "laddinare-door")
		p_door_2 = Find_Hint("MISSION_MAGNETIC_BLAST_DOOR_BIG", "laddinare-door-2")
		p_door_3 = Find_Hint("MISSION_MAGNETIC_BLAST_DOOR_BIG", "nu-door")
		p_door_4 = Find_Hint("MISSION_MAGNETIC_BLAST_DOOR_BIG", "dralliq-door")

		introcam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-1")
		introcam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-2")
		introcam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-3")
		introcam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-4")
		introcam_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-5")
		introcam_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-6")
		introcam_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-7")
		introcam_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-8")
		introcam_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-9")
		introcam_10_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-10")
		introcam_11_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-11")
		introcam_12_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-12")
		introcam_13_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-13")
		introcam_14_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-14")
		introcam_15_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-15")
		introcam_16_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-16")

		introcam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-1")
		introcam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-2")
		introcam_target_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-3")
		introcam_target_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-4")
		introcam_target_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-5")
		introcam_target_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-6")
		introcam_target_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-7")
		introcam_target_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-8")
		introcam_target_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-9")
		introcam_target_10_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "introcam-target-10")

		midtrocam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-1")
		midtrocam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-2")
		midtrocam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-3")
		midtrocam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-4")
		midtrocam_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-5")
		midtrocam_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-6")
		midtrocam_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-7")
		midtrocam_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-8")
		midtrocam_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-9")
		midtrocam_10_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-10")
		midtrocam_11_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-11")
		midtrocam_12_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-12")
		midtrocam_13_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-13")
		midtrocam_14_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-14")
		midtrocam_15_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-15")
		midtrocam_16_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-16")

		midtrocam_duel_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "duel-cam-one")

		midtrocam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-1")
		midtrocam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-2")
		midtrocam_target_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-3")
		midtrocam_target_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-4")
		midtrocam_target_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtrocam-target-5")

		outrocam_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-1")
		outrocam_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-2")
		outrocam_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-3")
		outrocam_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-4")
		outrocam_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-5")
		outrocam_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-6")
		outrocam_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-7")

		outrocam_target_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outrocam-target-1")
		outrocam_target_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-target-2")
		anakin_spawn_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "anakin-spawn")
		appo_spawn_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "appo-spawn")
		intro_nu_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "nu-marker")
		zone_one_explosion_marker  = Find_Hint("STORY_TRIGGER_ZONE_00", "zone-one-explosion")
		zone_two_explosion_marker  = Find_Hint("STORY_TRIGGER_ZONE_00", "zone-two-explosion")
		intro_torbin_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "torbin-marker")

		intro_dralliq_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "dralliq-marker")

		intro_hero_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-appo")
		intro_hero_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "intro-1-anakin")
		intro_hero_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "side-soldier")

		midtro_hero_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-1-appo")
		midtro_hero_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-1-anakin")
		midtro_torbin_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "torbin-spawn")
		midtro_hero_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-hero-3")
		midtro_hero_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-hero-4")

		midtro_hero_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-hero-5")
		midtro_hero_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-hero-6")

		duel_hero_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "torbin-duel-one")
		duel_hero_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "anakin-duel-one")
		duel_hero_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "duel-clone-1")
		duel_hero_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "duel-clone-2")
		duel_hero_5_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "clone-enter-1")
		duel_hero_6_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "clone-enter-2")
		duel_hero_7_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "torbin-exit")
		duel_hero_10_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "anakin-duel-10")
		duel_hero_11_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "serra-marker")
		duel_hero_12_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "serra-2-marker")

		duel_hero_8_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "lib-anakin-entry")
		duel_hero_9_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "lib-appo-entry")

		door_hero_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-anakin-1")
		door_hero_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "midtro-anakin-2")

		attacker_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "attacker-1-marker")
		attacker_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "attacker-2-marker")
		attacker_3_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "attacker-3-marker")
		attacker_4_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "attacker-4-marker")

		outro_hero_1_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-anakin-1")
		outro_hero_2_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-anakin-2")

		outro_hero_dralliq_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-dralliq-1")		
		outro_hero_palp_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "outro-palpatine")	

		entry_laddinare_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "battle-point-one")
		Register_Prox(entry_laddinare_marker, Prox_Laddinare_Reached, 300, p_republic)
		Add_Radar_Blip(entry_laddinare_marker, "p_laddinare_blip")
		entry_laddinare_marker.Highlight(true)

		entry_nu_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "battle-point-2")
		Register_Prox(entry_nu_marker, Prox_Nu_Reached, 200, p_republic)

		entry_cin_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "battlepoint-3")
		Register_Prox(entry_cin_marker, Prox_Cin_Reached, 150, p_republic)

		second_zone_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "zone-point-3")
		Register_Prox(second_zone_marker, Prox_Two_Reached, 200, p_republic)

		zone_one_marker = Find_Hint("STORY_TRIGGER_ZONE_00", "zone-point-1")
		Register_Prox(zone_one_marker, Prox_One_Reached, 150, p_republic)


		mission_started = true
		if p_cis.Is_Human() then
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Intro_CIS")
		elseif p_republic.Is_Human() then
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Intro_Rep")
		end
	end
end

function Prox_Laddinare_Reached(self_obj, trigger_obj)
	if act_1_active then
		player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
		if trigger_obj == player_anakin then
			cave_reached_anakin = true
		end
		if cave_reached_anakin then
			MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 9, 10.0, nil, nil)
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_One")
			self_obj.Cancel_Event_Object_In_Range(Prox_Laddinare_Reached)
		end	
	end	
end
function Prox_Nu_Reached(self_obj, trigger_obj)
	if act_3_active then
		player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
		if trigger_obj == player_anakin then
			nu_reached_anakin = true
		end
		if nu_reached_anakin then
			MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 21, 10.0, nil, nil)
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Four")
			self_obj.Cancel_Event_Object_In_Range(Prox_Nu_Reached)
		end	
	end	
end
function Prox_Cin_Reached(self_obj, trigger_obj)
	if act_5_active then
		player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
		if trigger_obj == player_anakin then
			cin_reached_anakin = true
		end
		if cin_reached_anakin then
			MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 21, 10.0, nil, nil)
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Seven")
			self_obj.Cancel_Event_Object_In_Range(Prox_Cin_Reached)
		end	
	end	
end
function Prox_One_Reached(self_obj, trigger_obj)
	if act_3_active then
		player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
		if trigger_obj == player_anakin then
			zone_reached_anakin = true
		end
		if zone_reached_anakin then
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Three")
			self_obj.Cancel_Event_Object_In_Range(Prox_One_Reached)
		end
	end	
end
function Prox_Two_Reached(self_obj, trigger_obj)
	if act_4_active then
		player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
		if trigger_obj == player_anakin then
			zone_2_reached_anakin = true
		end
		if zone_2_reached_anakin then
			current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Six")
			self_obj.Cancel_Event_Object_In_Range(Prox_Two_Reached)
		end
	end	
end

function State_Hero_Death_Laddinare() 
	current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Two")
	GlobalValue.Set("TACTICAL_KNIGHTFALL_TORBIN_DEFEATED", true)
end
function State_Hero_Death_Jocasta() 
	current_cinematic_thread_id = Create_Thread("Start_Cinematic_Midtro_Republic_Five")
	GlobalValue.Set("TACTICAL_KNIGHTFALL_JOCASTA_DEFEATED", true)
end
function State_Hero_Death_Dralliq() 
	current_cinematic_thread_id = Create_Thread("Start_Cinematic_Outro_Rep")
end
function State_Hero_Death_Anakin() 
	MissionUtil.SetMissionObjectiveFailed("TEMPLE_TRAGEDY", "REP", 6)
	StoryUtil.DeclareVictory(p_cis, false)
	GlobalValue.Set("TACTICAL_KNIGHTFALL_DEFEAT",true)
end
function State_Hero_Death_Appo() 
	--debug
	--MissionUtil.SetMissionObjectiveFailed("TEMPLE_TRAGEDY", "REP", 6)
	--StoryUtil.DeclareVictory(p_cis, false)
	--GlobalValue.Set("TACTICAL_KNIGHTFALL_DEFEAT",true)
end

---@param old GameObject | string
---@param new string 
function ReplaceAtPosition(old, new)
	local checkObject = old
    if type(checkObject) == "string" then 
        checkObject = Find_First_Object(old)
    end
	if TestValid(checkObject) then
		local pos = checkObject.Get_Position()
		local owner = checkObject.Get_Owner()
		Spawn_Unit(Find_Object_Type(new), pos, owner)
	end
end

function ReplaceAllAtLocation()
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

				if not TestValid(player_appo) then
					player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", intro_hero_1_marker, p_republic)
					--Register_Death_Event(player_appo, State_Hero_Death_Appo)
				end

				if p_republic.Get_Difficulty() == "Easy" then
		
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-intro", 1, true)		
				
				elseif p_republic.Get_Difficulty() == "Hard" then
						
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-intro-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone-hard", 1, true)
				
				else
						
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-intro", 1, true)
				
				end

				player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
				Register_Death_Event(player_anakin, State_Hero_Death_Anakin)
				MissionUtil.SetObjectiveMissionSet("TEMPLE_TRAGEDY", "REP", 6)

				player_laddinare = Find_First_Object("LADDINARE_TORBIN")
				player_laddinare.Teleport_And_Face(intro_torbin_marker)
				player_laddinare.Prevent_AI_Usage(true)
				Register_Death_Event(player_laddinare, State_Hero_Death_Laddinare)
				player_anakin.Teleport_And_Face(anakin_spawn_marker)
				player_appo.Teleport_And_Face(appo_spawn_marker)
				MissionUtil.CinematicSkippingCleanUp(player_anakin)
				MissionUtil.CinematicEnvironmentOff()

				cinematic_one = false
				act_1_active = true

				Fade_Screen_In(0.5)
			end
		end
		if cinematic_two then
			if not cinematic_two_skipped then
				cinematic_two_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-lad", 1, false)
				Fade_Screen_In(1.0)
				act_1_active = false
				player_laddinare.Teleport_And_Face(midtro_torbin_marker)
				player_anakin.Teleport_And_Face(midtro_hero_2_marker)
				player_appo.Teleport_And_Face(midtro_hero_1_marker)
				act_2_active = true
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				cinematic_two = false
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				act_2_active = true
				Fade_Screen_In(1.0)
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				entry_laddinare_marker.Highlight(false)
				Remove_Radar_Blip("p_laddinare_blip")

			end
		end
		if cinematic_three then
			if not cinematic_three_skipped then
				cinematic_three_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				if TestValid(player_laddinare_death) then
					player_laddinare_death.Despawn()
				end
				if TestValid(player_anakin_cutscene) then
					player_anakin_cutscene.Despawn()
				end
				if TestValid(player_appo_cutscene) then
					player_appo_cutscene.Despawn()
				end
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				MissionUtil.Set_To_Enemies(p_secforce, p_cis)
				cinematic_three = false
				act_3_active = true
				act_2_active = false
				zone_one_marker.Highlight(true)
				Add_Radar_Blip(zone_one_marker, "p_one_blip")
				MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 1)
				Fade_Screen_In(2.0)
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				p_door_1.Despawn()
				p_door_2.Despawn()
				MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 1)
				Sleep(5.0)
				MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 21, 10.0, nil,nil) -- narrator
			end
		end
		if cinematic_four then
			if not cinematic_four_skipped then
				cinematic_four_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 2)
				if p_republic.Get_Difficulty() == "Easy" then
		
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 2, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_secforce, "flametrooper", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)	
			
				elseif p_republic.Get_Difficulty() == "Hard" then
					
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_secforce, "flametrooper", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_republic, "rein-flame", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-nu-hard", 1, true)
			
				else
					
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 2, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)
			
				end	
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				zone_one_marker.Highlight(false)
				Remove_Radar_Blip("p_one_blip")
				cinematic_four = false
				entry_nu_marker.Highlight(true)
				Add_Radar_Blip(entry_nu_marker, "p_nu_blip")
				MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", false, 0)
				blast_door_list = Find_All_Objects_Of_Type("MISSION_MAGNETIC_BLAST_DOOR_BIG_KNIGHTFALL_01")
				for k, blast_doors in pairs(blast_door_list) do
					if TestValid(blast_doors) then
						blast_doors.Despawn()
					end
				end
			end
		end
		if cinematic_mid then
			if not cinematic_mid_skipped then
				cinematic_mid_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				if not TestValid(player_nu) then
					player_nu = MissionUtil.SpawnUnitGround("JOCASTA_NU", intro_nu_marker, p_cis)
					Register_Death_Event(player_nu, State_Hero_Death_Jocasta)
				end
				player_anakin.Teleport_And_Face(duel_hero_8_marker)
				player_appo.Teleport_And_Face(duel_hero_8_marker)
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu-battle", 2, false)
				MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-nu-battle", 2, false)
				MissionUtil.PopulateAllMarkersWithHint("CLONE_BLAZE_TROOPER_SQUAD", p_republic, "blaze-trooper", 2, false)
				MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 47, 10.0, nil,{r = 255, g = 255, b = 0})
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				MissionUtil.Set_To_Enemies(p_secforce, p_cis)
				entry_nu_marker.Highlight(false)
				Remove_Radar_Blip("p_nu_blip")
				act_3_active = true
				act_2_active = false
				cinematic_mid = false
			end
		end
		if cinematic_five then
			if not cinematic_five_skipped then
				cinematic_five_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				if TestValid(player_nu_death) then
					player_nu_death.Despawn()
				end
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				MissionUtil.Set_To_Enemies(p_secforce, p_cis)
				MissionUtil.Set_To_Allies(p_republic, p_secforce)
				p_door_3.Despawn()
				cinematic_five = false
				act_3_active = false
				act_4_active = true
				Fade_Screen_In(1.0)
				second_zone_marker.Highlight(true)
				Add_Radar_Blip(second_zone_marker, "p_second_blip")
				MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 3)
			end
		end
		if cinematic_six then
			if not cinematic_six_skipped then
				cinematic_six_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 4)
				if p_republic.Get_Difficulty() == "Easy" then
		
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 2, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-dral", 3, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_GUARDIAN", p_cis, "pt-dral", 2, true)
			
				elseif p_republic.Get_Difficulty() == "Hard" then
					
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-dral", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_GUARDIAN", p_cis, "pt-dral", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_republic, "rein-flame", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-dral-hard", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-dral-hard", 1, true)
			
				else
					
					MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 2, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-dral", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
					MissionUtil.PopulateAllMarkersWithHint("JEDI_GUARDIAN", p_cis, "pt-dral", 1, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 2, true)
					MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_republic, "rein-flame", 2, true)
			
				end		
				MissionUtil.EndCinematicCamera(player_anakin, 3.0)
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				MissionUtil.Set_To_Enemies(p_secforce, p_cis)
				second_zone_marker.Highlight(false)
				Remove_Radar_Blip("p_second_blip")
				cinematic_six = false
				act_4_active = false
				act_5_active = true
				entry_cin_marker.Highlight(true)
				Add_Radar_Blip(entry_cin_marker, "p_cin_blip")
				MissionUtil.PlayGenericMusic("Imperial_March_Theme")
				MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", false, 0)
				blast_door_2_list = Find_All_Objects_Of_Type("MISSION_MAGNETIC_BLAST_DOOR_BIG_KNIGHTFALL")
				for k, blast_door_2s in pairs(blast_door_2_list) do
					if TestValid(blast_door_2s) then
						blast_door_2s.Despawn()
					end
				end
			end
		end
		if cinematic_seven then
			if not cinematic_seven_skipped then
				cinematic_seven_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				if not TestValid(player_cin) then
					player_cin = MissionUtil.SpawnUnitGround("CIN_DRALLIG", intro_dralliq_marker, p_cis)

				end
				if not TestValid(player_serra) then
					player_serra = MissionUtil.SpawnUnitGround("SERRA_KETO", duel_hero_11_marker, p_cis)
				end
				player_anakin.Teleport_And_Face(midtro_hero_5_marker)
				player_appo.Teleport_And_Face(midtro_hero_6_marker)
				MissionUtil.EndCinematicCamera(player_anakin, 3.0) 
				MissionUtil.CinematicEnvironmentOff()
				MissionUtil.AIActivation()
				MissionUtil.Set_To_Enemies(p_republic, p_cis)
				entry_cin_marker.Highlight(false)
				Remove_Radar_Blip("p_cin_blip")
				Fade_Screen_In(0.5)
				cinematic_eight = false
				MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_republic, "blaze-trooper-2", 2, false)
			end
		end
		if cinematic_eight then
			if not cinematic_eight_skipped then
				cinematic_eight_skipped = true
				if current_cinematic_thread_id ~= nil then
					Thread.Kill(current_cinematic_thread_id)
					current_cinematic_thread_id = nil
				end
				Fade_Screen_Out(0.5)
				MissionUtil.CinematicEnvironmentOff()

				MissionUtil.AllowOrbitalSupport(p_cis, true)
				MissionUtil.AllowOrbitalSupport(p_secforce, true)
				MissionUtil.AllowOrbitalSupport(p_republic, true)

				StoryUtil.DeclareVictory(p_republic, false)
			end
		end
	end
end
function Story_Mode_Service()
	if p_cis.Is_Human() then
		if act_1_active then
			local cis_list = Find_All_Objects_Of_Type(p_cis, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(cis_list) == 0) then
				if not battle_over then
					StoryUtil.TriggerScriptedBattle("TEMPLE_TRAGEDY", "CORUSCANT", "LAND", "REBEL", "EMPIRE", false, "CIS")
					StoryUtil.DeclareVictory(p_hostile, false)
				end
			end
		end
	elseif p_republic.Is_Human() then
		if act_1_active then
			local rep_list = Find_All_Objects_Of_Type(p_republic, "Vehicle | Infantry | AirGunship | AirSpeeder | InfantryHero | VehicleHero")
			if (table.getn(rep_list) == 0) then
				if not battle_over then
					StoryUtil.TriggerScriptedBattle("TEMPLE_TRAGEDY", "CORUSCANT", "LAND", "EMPIRE", "REBEL", false, "REP")
					StoryUtil.DeclareVictory(p_hostile, false)
				end
			end
		end
	end
end

function Start_Cinematic_Intro_Rep() 
	MissionUtil.StartCinematicCamera()
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.Set_To_Allies(p_republic, p_secforce)
	cinematic_one = true
	Sleep(1.5)
	SFXManager.Allow_Ambient_VO(false)
	MissionUtil.PlayGenericMusic("Anakins_Betrayal_Theme")
	player_anakin = Find_First_Object("ANAKIN_DARKSIDE")
	player_anakin.Teleport_And_Face(intro_hero_2_marker)
	Register_Death_Event(player_anakin, State_Hero_Death_Anakin)
	-- FotR_Enhanced ; temporary blue blade for Anakin DS
	Hide_Sub_Object(player_anakin, 0, "Lightsaber_Blue") 
	Hide_Sub_Object(player_anakin, 1, "Lightsaber_Red") 
	
	-- FotR_Enhanced ; pre mission start up swaps for spec ops and pre-rework clone commandos 
	Find_All_Objects_Of_Type("Clone_Special_Ops_Squad")

	player_laddinare = Find_First_Object("LADDINARE_TORBIN")
	player_laddinare.Teleport_And_Face(intro_torbin_marker)
	Register_Death_Event(player_laddinare, State_Hero_Death_Laddinare)

	player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", intro_hero_1_marker, p_republic)
	Register_Death_Event(player_appo, State_Hero_Death_Appo) --debug
	MissionUtil.Set_To_Allies(p_republic, p_secforce)

	player_appo.Prevent_AI_Usage(true)
	Sleep(0.5)
	MissionUtil.CinematicIntroHeader("TEMPLE_TRAGEDY")

	MissionUtil.SetCinematicCamera(introcam_1_marker, introcam_target_1_marker, true, nil, nil)
	Sleep(3.0)
	Fade_Screen_In(10.0)
	Letter_Box_In(1.0)
	Sleep(6.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 1, 7.0, nil, {r = 117, g = 216, b = 230}) -- Appo
	player_appo.Move_To(introcam_target_2_marker)
	Sleep(8.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 2, 12.0, nil, {r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 3, 12.0, nil, {r = 255, g = 44, b = 44}) -- Anakin
	
	MissionUtil.SetCinematicCamera(introcam_5_marker, introcam_target_4_marker, true, nil, nil)
	Sleep(1.0)

	MissionUtil.PlayAnimation(player_anakin, "IDLE", false, 0)

	Sleep(1.5)
	MissionUtil.TransitionCinematicCamera(introcam_6_marker, introcam_target_4_marker, true, 12.0, nil, nil)

	MissionUtil.PlayAnimation(player_anakin, "Talk", false, 0)

	Sleep(6.0)


	MissionUtil.PlayAnimation(player_appo, "Idle", false, 4)

	Sleep(4.0)
	MissionUtil.PlayAnimation(player_anakin, "IDLE", true, 0)
	Sleep(1.0)
	MissionUtil.PlayAnimation(player_appo, "Talk", true, 1) 
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 4, 7.0, nil, {r = 117, g = 216, b = 230}) -- Appo
	Sleep(3.0)
	MissionUtil.TransitionCinematicCamera(introcam_8_marker, introcam_target_4_marker, true, 13.0, nil, nil)
	Sleep(5.0)

	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 5, 6.0, nil, {r = 255, g = 44, b = 44}) -- Anakin
	Fade_Screen_Out(4.0)
	Sleep(3.0)
	MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone-intro", 1, true)
	MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro-intro", 2, true)
	Sleep(4.0) 
	MissionUtil.SetCinematicCamera(introcam_9_marker, introcam_target_5_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_10_marker, introcam_target_5_marker, true, 10.0, nil, nil)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 6, 9.0, nil, {r = 117, g = 216, b = 230}) -- Appo
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 7, 9.0, nil, {r = 117, g = 216, b = 230})
	Fade_Screen_In(2.0)
	Sleep(10.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 8, 6.0, nil, {r = 255, g = 44, b = 44}) -- Anakin
	player_soldier = MissionUtil.SpawnUnitGround("TEMPLE_SECURITY_TROOPER", intro_hero_3_marker, p_cis)
	Sleep(7.0)

	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 9, 9.0, nil, {r = 0, g = 255, b = 0}) -- Torbin
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 10, 9.0, nil, {r = 0, g = 255, b = 0})	

	MissionUtil.PlayAnimation(player_laddinare, "IDLE", true, 0)
	player_soldier.Prevent_AI_Usage(true)
	MissionUtil.SetCinematicCamera(introcam_11_marker, introcam_target_7_marker, true, nil, nil)
	MissionUtil.TransitionCinematicCamera(introcam_12_marker, introcam_target_7_marker, true, 8.0, nil, nil)
	Sleep(10.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 11, 6.0, nil, {r = 0, g = 255, b = 0})	
	MissionUtil.PlayAnimation(player_laddinare, "TALK", true, 2)
	Sleep(2.5)
	MissionUtil.PlayAnimation(player_laddinare, "IDLE", false, 1)
	Fade_Screen_Out(2.0)
	Sleep(3.0)
	player_soldier.Despawn()
	Hide_Sub_Object(player_anakin, 0, "lightsaber")
	Register_Death_Event(player_laddinare, State_Hero_Death_Laddinare)
	Sleep(2.0)
	if not cinematic_one_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Intro_Rep")
	end
end
function End_Cinematic_Intro_Rep()
	Fade_Screen_In(2.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.EndCinematicCamera(Find_First_Object("ANAKIN_DARKSIDE"), 3.5)
	Sleep(3.5)
	act_1_active = true
	MissionUtil.SetObjectiveMissionSet("TEMPLE_TRAGEDY", "REP", 6)
	Stop_All_Speech()
	player_laddinare = Find_First_Object("LADDINARE_TORBIN")
	player_laddinare.Teleport_And_Face(intro_torbin_marker)
	player_anakin.Teleport_And_Face(anakin_spawn_marker)
	player_appo.Teleport_And_Face(appo_spawn_marker)
	MissionUtil.PlayGenericMusic("Jedi_Temple_March_Theme")
	
	if p_republic.Get_Difficulty() == "Easy" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
		Sleep(3.0)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "jedi-intro", 3, true)		

	elseif p_republic.Get_Difficulty() == "Hard" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
		Sleep(3.0)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "jedi-intro", 3, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-intro-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone-hard", 1, true)

	else
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-1-clone", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_secforce, "phase-1-atrt", 1, true)
		Sleep(3.0)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-intro", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-intro", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "jedi-intro", 3, true)

	end
	current_cinematic_thread_id = nil

	cinematic_one = false
	act_1_active = true
end

function Start_Cinematic_Midtro_Republic_One()
	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_cis, p_secforce)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)

	act_1_active = false
	cinematic_two = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	MissionUtil.PlayGenericMusic("Vaders_Presence_Theme")
	Sleep(2.5)

	if not TestValid(player_anakin) then
		player_anakin = MissionUtil.SpawnUnitGround("ANAKIN_DARKSIDE", midtro_hero_2_marker, p_republic)
		Register_Death_Event(player_anakin, State_Hero_Death_Anakin)
	end
	if not TestValid(player_appo) then
		player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", midtro_hero_1_marker, p_republic)
		Register_Death_Event(player_appo, State_Hero_Death_Appo)
	end
	player_anakin.Teleport_And_Face(midtro_hero_2_marker)
	player_appo.Teleport_And_Face(midtro_hero_1_marker)

	player_laddinare = Find_First_Object("LADDINARE_TORBIN")
	player_laddinare.Teleport_And_Face(intro_torbin_marker)
	MissionUtil.SetCinematicCamera(midtrocam_1_marker, introcam_target_7_marker, false, nil, nil)
	Fade_Screen_In(1.0)
	Sleep(2.0)
	MissionUtil.TransitionCinematicCamera(midtrocam_target_5_marker, introcam_target_7_marker, true, 5.0, nil, nil)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 13, 10.0, nil, {r = 0, g = 255, b = 0}) -- Torbin
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 14, 10.0, nil,{r = 0, g = 255, b = 0}) -- Torbin	
	Sleep(11.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 15, 7.0, nil, {r = 255, g = 44, b = 44}) -- Anakin
	Sleep(7.0)
	Fade_Screen_Out(0.5)
	Sleep(2.0)
	if not cinematic_two_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_One")
	end
end
function End_Cinematic_Midtro_Republic_One()
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.AIActivation()
	player_laddinare.Teleport_And_Face(midtro_torbin_marker)
	act_2_active = true
	MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-lad", 1, false)
	Fade_Screen_In(1.0)
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	entry_laddinare_marker.Highlight(false)
	Remove_Radar_Blip("p_laddinare_blip")
	current_cinematic_thread_id = nil
	cinematic_two = false
end

function Start_Cinematic_Midtro_Republic_Two()
	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_cis, p_secforce)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)

	cinematic_three = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)
	if not TestValid(player_anakin) then
		player_anakin = MissionUtil.SpawnUnitGround("ANAKIN_DARKSIDE", midtro_hero_2_marker, p_republic)
		Register_Death_Event(player_anakin, State_Hero_Death_Anakin)
	end
	if not TestValid(player_appo) then
		player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", midtro_hero_1_marker, p_republic)
	end
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(2.5)
	player_laddinare_death = MissionUtil.SpawnUnitGround("LADDINARE_TORBIN", duel_hero_1_marker, p_cis)
	player_laddinare_death.Prevent_AI_Usage(true)
	player_anakin.Teleport_And_Face(entry_laddinare_marker)
	player_anakin_cutscene = MissionUtil.SpawnUnitGround("ANAKIN_DARKSIDE", duel_hero_2_marker, p_republic)
	player_appo.Teleport_And_Face(entry_laddinare_marker)
	player_laddinare.Teleport_And_Face(duel_hero_1_marker)
	MissionUtil.SetCinematicCamera(midtrocam_duel_1_marker, midtrocam_target_5_marker, false, nil, nil)
	player_laddinare_death.Teleport_And_Face(duel_hero_1_marker)
	player_anakin_cutscene.Teleport_And_Face(duel_hero_2_marker)
	Fade_Screen_In(1.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 16, 8.0, nil,{r = 0, g = 255, b = 0}) -- Torbin
	MissionUtil.PlayAnimation(player_laddinare_death, "TALK", true, 0)
	MissionUtil.PlayAnimation(player_anakin_cutscene, "FB_HOLD", true, 0)
	Sleep(9.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 17, 10.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 18, 10.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	Sleep(11.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 19, 9.0, nil,{r = 0, g = 255, b = 0}) -- Torbin
	Sleep(10.0)
	player_appo_cutscene = MissionUtil.SpawnUnitGround("MISSION_APPO", midtro_hero_1_marker, p_republic)
	player_appo_cutscene.Move_To(midtrocam_target_5_marker)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 20, 8.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.PlayAnimation(player_laddinare_death, "TALK", true, 2)
	Sleep(4.0)
	player_appo_cutscene.Turn_To_Face(player_laddinare_death)
	Fade_Screen_Out(0.5)
	Sleep(0.3)
	MissionUtil.PlayAnimation(player_anakin_cutscene, "FB_HOLD", false, 0)
	Sleep(1.0)
	player_anakin_cutscene.Despawn()
	player_appo_cutscene.Despawn()
	zone_one_marker.Highlight(true)
	Add_Radar_Blip(zone_one_marker, "p_one_blip")
	if not cinematic_two_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Two")
	end
end
function End_Cinematic_Midtro_Republic_Two()
	Fade_Screen_In(2.0)
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.AIActivation()
	player_laddinare_death.Despawn()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	MissionUtil.Set_To_Enemies(p_secforce, p_cis)

	current_cinematic_thread_id = nil
	p_door_1.Despawn()
	p_door_2.Despawn()
	cinematic_three = false
	act_3_active = true
	act_2_active = false
	MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 1)
	Sleep(5.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 21, 10.0, nil,nil) -- narrator
end

function Start_Cinematic_Midtro_Republic_Three()
	MissionUtil.Set_To_Allies(p_republic, p_cis)

	cinematic_four = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	MissionUtil.PlayGenericMusic("Carbon_Freeze_Theme")
	player_anakin.Teleport_And_Face(door_hero_1_marker)
	Sleep(2.5)
	Fade_Screen_In(1.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 22, 10.0, nil,nil) -- narrator
	MissionUtil.SetCinematicCamera(midtrocam_10_marker, midtrocam_target_4_marker, false, nil, nil)
	MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", true, 0)
	MissionUtil.TransitionCinematicCamera(midtrocam_11_marker, door_hero_1_marker, false, 16.0, nil, nil)
	Sleep(5.0)

	blast_door_list = Find_All_Objects_Of_Type("MISSION_MAGNETIC_BLAST_DOOR_BIG_KNIGHTFALL_01")
	for k, blast_doors in pairs(blast_door_list) do
		MissionUtil.SpawnUnitGround("HUGE_EXPLOSION_LAND", zone_one_explosion_marker, p_republic)	
		Sleep(0.1)	
		if TestValid(blast_doors) then
			blast_doors.Play_SFX_Event("Unit_Wall_Death_SFX") -- replace with explosion

			Sleep(0.1)
			blast_doors.Despawn()
		end
	end
	MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 2)
	MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", false, 0)
	Sleep(3.0)
	if p_republic.Get_Difficulty() == "Easy" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 2, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_secforce, "flametrooper", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)	

	elseif p_republic.Get_Difficulty() == "Hard" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONE_FLAME_TROOPER_COMPANY", p_secforce, "flametrooper", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-nu-hard", 1, true)

	else
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-2-clone", 2, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_JEDI_COMPANY", p_cis, "jedi-nu", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONE_COMMANDO_REWORK_MISSION_COMPANY", p_republic, "rein-cc", 1, true)

	end	

	if not cinematic_three_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Three")
	end
end
function End_Cinematic_Midtro_Republic_Three()
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.AIActivation()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	zone_one_marker.Highlight(false)
	Remove_Radar_Blip("p_one_blip")
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 46, 10.0, nil,{r = 255, g = 255, b = 0})
	current_cinematic_thread_id = nil
	cinematic_four = false
	entry_nu_marker.Highlight(true)
	Add_Radar_Blip(entry_nu_marker, "p_nu_blip")
end

function Start_Cinematic_Midtro_Republic_Four()
	if not TestValid(player_appo) then
		player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", midtro_hero_1_marker, p_republic)
	end
	player_nu = MissionUtil.SpawnUnitGround("JOCASTA_NU", intro_nu_marker, p_cis)
	Register_Death_Event(player_nu, State_Hero_Death_Jocasta)

	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_cis, p_secforce)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)

	cinematic_mid = true
	player_nu = Find_First_Object("JOCASTA_NU")
	player_nu.Teleport_And_Face(intro_nu_marker)
	Fade_Screen_Out(0.5)
	Sleep(0.5)
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Sleep(2.5)
	player_anakin.Teleport_And_Face(duel_hero_8_marker)
	player_appo.Teleport_And_Face(duel_hero_8_marker)
	Fade_Screen_In(1.0)
	MissionUtil.PlayGenericMusic("TCW_Jedi_Temple_Theme")

	MissionUtil.SetCinematicCamera(introcam_14_marker, midtrocam_target_1_marker, false, nil, nil)
	player_appo.Move_To(midtro_hero_4_marker)
	player_anakin.Move_To(midtro_hero_3_marker)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 23, 6.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	Sleep(4.0)
	player_nu.Turn_To_Face(player_anakin)
	Sleep(2.5)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 24, 8.0, nil,{r = 157 , g = 0, b = 255}) -- Jocasta
	MissionUtil.PlayAnimation(player_nu, "TALK", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 25, 8.0, nil,{r = 157, g = 0, b = 255}) -- Jocasta
	MissionUtil.TransitionCinematicCamera(midtrocam_3_marker, midtrocam_target_1_marker, false, 10.0, nil, nil)
	Sleep(2.0)
	MissionUtil.PlayAnimation(player_nu, "IDLE", true, 2)
	Sleep(7.0)
	MissionUtil.PlayAnimation(player_anakin, "TALK", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 26, 6.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.TransitionCinematicCamera(midtrocam_6_marker, midtrocam_target_1_marker, false, 10.0, nil, nil)
	Sleep(7.0)
	MissionUtil.PlayAnimation(player_nu, "FW_ATTACK", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 27, 8.0, nil,{r = 157, g = 0, b = 255}) -- Jocasta
	Sleep(4.0)
	Fade_Screen_Out(0.5)
	Sleep(3.0)
	if not cinematic_four_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Four")
	end
end
function End_Cinematic_Midtro_Republic_Four()
	Fade_Screen_In(1.0)
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-nu-battle", 2, false)
	MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-nu-battle", 2, false)
	MissionUtil.PopulateAllMarkersWithHint("CLONE_BLAZE_TROOPER_SQUAD", p_republic, "blaze-trooper", 2, false)
	MissionUtil.AIActivation()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	MissionUtil.Set_To_Enemies(p_secforce, p_cis)
	entry_nu_marker.Highlight(false)
	Remove_Radar_Blip("p_nu_blip")
	act_3_active = true
	act_2_active = false
	current_cinematic_thread_id = nil
	cinematic_mid = false
end

function Start_Cinematic_Midtro_Republic_Five()
	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_cis, p_secforce)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)

	cinematic_five = true
	player_nu_death = MissionUtil.SpawnUnitGround("JOCASTA_NU", duel_hero_1_marker, p_secforce)

	Fade_Screen_Out(0.5)
	Sleep(0.5)
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	MissionUtil.SetCinematicCamera(midtrocam_5_marker, introcam_target_8_marker, false, nil, nil)
	MissionUtil.PlayGenericMusic("ROTS_Im_So_Sorry_Theme")
	player_anakin.Teleport_And_Face(duel_hero_10_marker)
	player_nu_death.Teleport_And_Face(intro_nu_marker)
	player_nu_death.Turn_To_Face(player_anakin)
	Sleep(1.0)
	Fade_Screen_In(1.0)

	MissionUtil.Set_To_Enemies(p_republic, p_secforce)
	
	MissionUtil.TransitionCinematicCamera(midtrocam_4_marker, introcam_target_8_marker, false, 16.0, nil, nil)
	Sleep(4.0)
	Fade_Screen_Out(0.5)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 28, 8.0, nil,{r = 157, g = 0, b = 255}) -- Jocasta
	Sleep(1.0)
	Fade_Screen_In(0.5)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)
	player_anakin.Teleport_And_Face(duel_hero_10_marker)
	player_nu_death.Teleport_And_Face(intro_nu_marker)
	player_nu_death.Turn_To_Face(player_anakin)
	MissionUtil.SetCinematicCamera(midtrocam_5_marker, introcam_target_8_marker, false, nil, nil)
	Sleep(0.1)
	MissionUtil.PlayAnimation(player_anakin, "ATTACK", false, 0)
	Sleep(2.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 29, 10.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.PlayAnimation(player_nu_death, "DIE", false, 0)
	Sleep(1.2)
	Fade_Screen_Out(0.5)
	Sleep(1.5)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 30, 8.0, nil,{r = 157, g = 0, b = 255}) -- Jocasta
	Sleep(6.0)
	player_nu_death.Despawn()
	if not cinematic_five_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Five")
	end
end
function End_Cinematic_Midtro_Republic_Five()
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.AIActivation()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	MissionUtil.Set_To_Enemies(p_secforce, p_cis)

	p_door_3.Despawn()
	current_cinematic_thread_id = nil
	cinematic_five = false
	act_3_active = false
	act_4_active = true
	Fade_Screen_In(1.0)
	second_zone_marker.Highlight(true)
	Add_Radar_Blip(second_zone_marker, "p_second_blip")
	MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 3)
end

function Start_Cinematic_Midtro_Republic_Six()

	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)
	MissionUtil.Set_To_Allies(p_secforce, p_cis)
	cinematic_six = true

	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	player_anakin.Teleport_And_Face(door_hero_2_marker)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 22, 8.0, nil,nil) -- narrator
	Sleep(1.5)
	Fade_Screen_In(1.0)

	MissionUtil.SetCinematicCamera(midtrocam_13_marker, midtrocam_target_3_marker, false, nil, nil)
	MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", true, 0)
	MissionUtil.TransitionCinematicCamera(midtrocam_14_marker, door_hero_2_marker, false, 16.0, nil, nil)
	Sleep(3.0)


	blast_door_2_list = Find_All_Objects_Of_Type("MISSION_MAGNETIC_BLAST_DOOR_BIG_KNIGHTFALL")
	for k, blast_door_2s in pairs(blast_door_2_list) do
		MissionUtil.SpawnUnitGround("HUGE_EXPLOSION_LAND", zone_two_explosion_marker, p_republic)	
		Sleep(0.1)	
		if TestValid(blast_door_2s) then
			blast_door_2s.Play_SFX_Event("Unit_Wall_Death_SFX") -- replace with explosion

			Sleep(0.1)
			blast_door_2s.Despawn()
		end
	end
	MissionUtil.PlayAnimation(player_anakin, "FB_HOLD", false, 0)
	MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 4)
	if p_republic.Get_Difficulty() == "Easy" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 2, true)
		MissionUtil.PopulateAllMarkersWithHint("JEDI_PADAWAN_COMPANY", p_cis, "hd-dral", 3, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("JEDI_GUARDIAN", p_cis, "pt-dral", 2, true)

	elseif p_republic.Get_Difficulty() == "Hard" then
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-dral", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-dral", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-dral-hard", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_TROOPER_COMPANY_DUMMY", p_cis, "ld-dral-hard", 1, true)

	else
		
		MissionUtil.PopulateAllMarkersWithHint("CLONETROOPER_PHASE_TWO_COMPANY_DUMMY", p_secforce, "phase-3-clone", 2, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_HEAVY_TROOPER_COMPANY_DUMMY", p_cis, "hd-dral", 1, true)
		MissionUtil.PopulateAllMarkersWithHint("TEMPLE_SECURITY_TROOPER_SQUAD", p_cis, "ld-dral", 4, true)
		MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_PT_COMPANY", p_cis, "pt-dral", 1, true)

	end		

	MissionUtil.SetCinematicCamera(midtrocam_2_marker, midtrocam_target_3_marker, false, nil, nil)
	MissionUtil.TransitionCinematicCamera(midtrocam_1_marker, midtrocam_target_3_marker, false, 16.0, nil, nil)
	Sleep(3.0)
	if not cinematic_six_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Six")
	end
end
function End_Cinematic_Midtro_Republic_Six()
	MissionUtil.EndCinematicCamera(player_anakin, 3.0)
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.AIActivation()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	MissionUtil.Set_To_Enemies(p_secforce, p_cis)
	second_zone_marker.Highlight(false)
	Remove_Radar_Blip("p_second_blip")
	current_cinematic_thread_id = nil
	cinematic_six = false
	act_4_active = false
	act_5_active = true
	entry_cin_marker.Highlight(true)
	Add_Radar_Blip(entry_cin_marker, "p_cin_blip")
	MissionUtil.PlayGenericMusic("Imperial_March_Theme")
end

function Start_Cinematic_Midtro_Republic_Seven()
	if not TestValid(player_appo) then
		player_appo = MissionUtil.SpawnUnitGround("MISSION_APPO", midtro_hero_1_marker, p_republic)
	end
	MissionUtil.Set_To_Allies(p_republic, p_cis)
	MissionUtil.Set_To_Allies(p_republic, p_secforce)
	MissionUtil.Set_To_Allies(p_secforce, p_cis)
	cinematic_seven = true

	player_cin = MissionUtil.SpawnUnitGround("CIN_DRALLIG", intro_dralliq_marker, p_cis)
	player_serra = MissionUtil.SpawnUnitGround("SERRA_KETO", duel_hero_11_marker, p_cis)
	Register_Death_Event(player_cin, State_Hero_Death_Dralliq)
	player_cin.Teleport_And_Face(intro_dralliq_marker)
	player_serra.Teleport_And_Face(duel_hero_11_marker)
	Fade_Screen_Out(0.5)
	Sleep(0.5)

	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	MissionUtil.PlayGenericMusic("AOTC_Ambush_On_Coruscant_Theme_Crazy_Clone")
	Sleep(2.5)
	Fade_Screen_In(1.0)
	player_cin.Teleport_And_Face(intro_dralliq_marker)
	player_serra.Teleport_And_Face(duel_hero_11_marker)
	player_anakin.Teleport_And_Face(midtro_hero_5_marker)
	player_appo.Teleport_And_Face(midtro_hero_6_marker)

	MissionUtil.SetCinematicCamera(introcam_16_marker, midtrocam_target_2_marker, false, nil, nil)
	MissionUtil.TransitionCinematicCamera(midtrocam_8_marker, midtrocam_target_2_marker, false, 16.0, nil, nil)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 31, 6.0, nil,{r = 0, g = 157, b = 0}) -- Serra
	MissionUtil.PlayAnimation(player_serra, "TALK", true, 0)
	Sleep(7.0)
	MissionUtil.PlayAnimation(player_cin, "TALK", true, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 32, 6.0, nil,{r = 255, g = 255, b = 0}) -- Drallig
	Sleep(7.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 33, 6.0, nil,{r = 0, g = 157, b = 0}) -- Serra
	Sleep(7.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 45, 5.0, nil,{r = 255, g = 255, b = 0}) -- Drallig (Needs replacement)

	Sleep(4.0)
	Fade_Screen_Out(0.5)
	Sleep(1.0)
	player_serra.Despawn()
	MissionUtil.SetCinematicCamera(introcam_16_marker, midtrocam_target_2_marker, false, nil, nil)
	Sleep(1.0)
	Fade_Screen_In(1.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 35, 4.0, nil,{r = 255, g = 255, b = 0}) -- Drallig
	MissionUtil.PlayAnimation(player_cin, "TALK", true, 0)
	Sleep(5.0)
	MissionUtil.SetCinematicCamera(midtrocam_16_marker, introcam_target_10_marker, false, nil, nil)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 36, 8.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.PlayAnimation(player_anakin, "TALK", true, 0)
	Sleep(9.0)
	MissionUtil.SetCinematicCamera(introcam_16_marker, midtrocam_target_2_marker, false, nil, nil)
	MissionUtil.TransitionCinematicCamera(midtrocam_8_marker, midtrocam_target_2_marker, false, 16.0, nil, nil)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 37, 3.0, nil,{r = 255, g = 255, b = 0}) -- Drallig
	MissionUtil.PlayAnimation(player_cin, "FW_ATTACK", false, 0)Sleep(1.5)
	Fade_Screen_Out(5.0)
	Sleep(4.0)
	player_serra = MissionUtil.SpawnUnitGround("SERRA_KETO", duel_hero_12_marker, p_cis)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 34, 3.0, nil,{r = 255, g = 255, b = 0}) -- Drallig
	Sleep(3.0)
	player_cin.Teleport_And_Face(intro_dralliq_marker)
	player_serra.Teleport_And_Face(duel_hero_12_marker)
	if not cinematic_seven_skipped then
		current_cinematic_thread_id = Create_Thread("End_Cinematic_Midtro_Republic_Seven")
	end
end
function End_Cinematic_Midtro_Republic_Seven()
	MissionUtil.EndCinematicCamera(player_anakin, 3.0) 
	MissionUtil.CinematicEnvironmentOff()
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 48, 10.0, nil,{r = 255, g = 255, b = 0})
	MissionUtil.AIActivation()
	MissionUtil.Set_To_Enemies(p_republic, p_cis)
	entry_cin_marker.Highlight(false)
	Remove_Radar_Blip("p_cin_blip")
	Fade_Screen_In(0.5)
	current_cinematic_thread_id = nil
	cinematic_eight = false
	MissionUtil.PopulateAllMarkersWithHint("REPUBLIC_AT_RT_COMPANY", p_republic, "blaze-trooper-2", 2, false)
end

function Start_Cinematic_Outro_Rep()
	MissionUtil.Set_To_Allies(p_republic, p_cis)

	MissionUtil.SetMissionObjectiveComplete("TEMPLE_TRAGEDY", "REP", 5)

	cinematic_eight = true
	act_6_active = false

	Fade_Screen_Out(0.5)
	Sleep(0.5)
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	Do_End_Cinematic_Cleanup()

	player_cin_death = MissionUtil.SpawnUnitGround("CIN_DRALLIG", outro_hero_dralliq_marker, p_cis)
	player_anakin_outro = MissionUtil.SpawnUnitGround("ANAKIN_DARKSIDE", outro_hero_1_marker, p_republic)
	player_anakin_outro.Teleport_And_Face(outro_hero_1_marker)
	player_cin_death.Teleport_And_Face(outro_hero_dralliq_marker)
	player_cin_death.Turn_To_Face(player_anakin_outro)

	MissionUtil.Set_To_Enemies(p_republic, p_cis)

	Sleep(1.0)
	MissionUtil.CinematicEnvironmentOn()
	MissionUtil.StartCinematicCamera()
	MissionUtil.SetCinematicCamera(outrocam_3_marker, outrocam_target_1_marker, false, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_3_marker, outrocam_target_1_marker, false, 16.0, nil, nil)
	Fade_Screen_In(1.0)
	Sleep(3.5)

	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 38, 6.0, nil,{r = 255, g = 255, b = 0}) -- Drallig
	Sleep(7.0)

	MissionUtil.Set_To_Allies(p_republic, p_cis)
	Sleep(0.5)
	MissionUtil.PlayGenericMusic("Immolation_Scene_Theme")
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 39, 5.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	MissionUtil.PlayAnimation(player_cin_death, "Die", false, 0)
	Sleep(2.0)
	Fade_Screen_Out(5.0)
	Sleep(5.0)

	player_anakin_outro_2 = MissionUtil.SpawnUnitGround("ANAKIN_DARKSIDE", outro_hero_2_marker, p_republic)
	player_palpatine_outro = MissionUtil.SpawnUnitGround("EMPEROR_PALPATINE", outro_hero_palp_marker, p_republic)
	player_palpatine_outro.Turn_To_Face(player_anakin_outro)
	Sleep(0.5)
	MissionUtil.SetCinematicCamera(outrocam_6_marker, outrocam_target_2_marker, false, nil, nil)
	MissionUtil.TransitionCinematicCamera(outrocam_4_marker, outrocam_target_2_marker, false, 16.0, nil, nil)
	Fade_Screen_In(0.5)

	MissionUtil.PlayAnimation(player_anakin_outro_2, "Die", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 40, 6.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	Sleep(7.0)
	MissionUtil.PlayAnimation(player_palpatine_outro, "Talk", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 41, 8.0, nil,{r = 255, g = 102, b = 102}) -- Palpatine
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 42, 8.0, nil,{r = 255, g = 102, b = 102}) -- Palpatine
	Sleep(9.0)
	MissionUtil.PlayAnimation(player_anakin_outro_2, "Idle", false, 0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 43, 8.0, nil,{r = 255, g = 102, b = 102}) -- Palpatine
	Sleep(9.0)
	MissionUtil.MissionTextSpeech("TEMPLE_TRAGEDY", 44, 6.0, nil,{r = 255, g = 44, b = 44}) -- Anakin
	Sleep(7.0)
	Fade_Screen_Out(3.0)
	Sleep(5.0)
	MissionUtil.CinematicEnvironmentOff()

	MissionUtil.AllowOrbitalSupport(p_cis, true)
	MissionUtil.AllowOrbitalSupport(p_secforce, true)
	MissionUtil.AllowOrbitalSupport(p_republic, true)

	StoryUtil.DeclareVictory(p_republic, false)
end

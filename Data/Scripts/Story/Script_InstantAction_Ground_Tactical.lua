--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox
--*   @Date:                2017-12-14T10:54:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Script_InstantAction_Tactical.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T13:18:54+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("eawx-util/StoryUtil")
CONSTANTS = ModContentLoader.get("GameConstants")

function Definitions()
	-- DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		Trigger_Setup_Start = State_Setup_Start,
		Trigger_Battle_Start = State_Battle_Start
	}

	GlobalValue.Set("CURRENT_ERA", 1)
	GlobalValue.Set("REGIME_INDEX", 1)
end

function State_Setup_Start(message)
	if message == OnEnter then
		local humanPlayer = Find_Player("local")

		local plot = Get_Story_Plot("Conquests\\InstantAction\\Story_InstantAction_Ground_Tactical.xml")
		local event = plot.Get_Event("End_Battle")
		event.Set_Reward_Parameter(0,humanPlayer.Get_Faction_Name())

		ia_marker_target_pos = Find_First_Object("Attacker Entry Position")
		ia_marker_faction_pos = Find_Hint("STORY_TRIGGER_ZONE_00", "instantaction-faction-switcher")

		Create_Generic_Object("InstantAction_Marker_Target", ia_marker_target_pos.Get_Position(), humanPlayer)

		if Find_Object_Type("icw") then
			Create_Generic_Object("InstantAction_Marker_Faction", ia_marker_faction_pos.Get_Position(), humanPlayer)
		end

		for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
			local faction_object = Find_Player(faction)
			for _, second_faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
				if faction ~= second_faction then
					local second_faction_object = Find_Player(second_faction)
					faction_object.Make_Ally(second_faction_object)
				end
			end
		end

		--Needed to force object scripts e.g. fighter spawn to work for IF. ~Mord
		StoryUtil.ChangeAIPlayer("Independent_Forces", "AI_Player_UnderworldStoryOpponent")
	end
end

function State_Battle_Start(message)
	if message == OnEnter then
		for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
			local faction_object = Find_Player(faction)
			for _, second_faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
				if faction ~= second_faction then
					local second_faction_object = Find_Player(second_faction)
					faction_object.Make_Enemy(second_faction_object)
				end
			end
		end
	end
end

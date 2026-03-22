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
CONSTANTS = ModContentLoader.get("GameConstants")

function Definitions()
	--DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		Trigger_Determine_Faction = State_Determine_Faction
	}
end

function State_Determine_Faction(message)
	--DebugMessage("%s -- In State_Determine_Faction", tostring(Script))
	if message == OnEnter then
		local liveFactionTable = CONSTANTS.LIVE_FACTION_TABLE

		local humanPlayerName = Find_Player("local").Get_Faction_Name()

		local faction_index = 0
		for faction, id in pairs(liveFactionTable) do
			if faction == humanPlayerName then
				faction_index = id
				break
			end
		end

		local plot = Get_Story_Plot("Conquests\\InstantAction\\Story_InstantAction_Galactic.xml")

		local event = plot.Get_Event("Reload_InstantAction_Campaign")
		event.Set_Reward_Parameter(0,"Campaign_InstantAction_"..humanPlayerName)
		event.Set_Reward_Parameter(1,faction_index)
	end
end

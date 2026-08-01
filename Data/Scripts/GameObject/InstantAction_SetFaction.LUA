--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("eawx-util/MissionUtil")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		if Get_Game_Mode() == "Galactic" then
			ScriptExit()
		end
		local setterName = Object.Get_Type().Get_Name()
		local factionName = string.gsub(setterName, "IA_SET_", "")
		GlobalValue.Set("IA_FACTION", factionName)
		ScriptExit()
		
	end
end
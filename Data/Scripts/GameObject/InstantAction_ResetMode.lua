--***************************************************--
--*********** Main Menu Space Script ****************--
--***************************************************--

require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")
require("eawx-util/StoryUtil")
require("eawx-util/MissionUtil")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init)

end

function State_Init(message)
	if message == OnEnter then

		if Get_Game_Mode() == "Galactic" then
			ScriptExit()
		end
		Story_Event("IA_RESTART_MODE")
		GlobalValue.Set("SHOULD_RESTART", 1)
	end
end

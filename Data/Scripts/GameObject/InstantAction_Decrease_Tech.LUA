require("PGStoryMode")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init);


end

-- FotR_Enhanced ; ground instant action inclusion
function State_Init(message)
	if message == OnEnter then
		local game_mode = Get_Game_Mode()
		if game_mode == "Space" then
			local era = GlobalValue.Get("CURRENT_ERA")
			if era == nil then
				era = 1
			end
			GlobalValue.Set("CURRENT_ERA", era+1)
			Story_Event("AI_NOTIF_IA_ERA_" .. tostring(era+1))
		elseif game_mode == "Land" then -- for ground
			if not ModContentLoader then
                ModContentLoader = require("eawx-std/ModContentLoader")
            end
            local CONSTANTS = ModContentLoader.get("GameConstants")
            
			Story_Event("AI_NOTIF_IA_TECH_" .. tostring(display_tech))
		end
		ScriptExit()
	end
end
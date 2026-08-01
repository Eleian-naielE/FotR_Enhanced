require("PGStoryMode")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init);


end

-- FotR_Enhanced ; ground instant action inclusion
function State_Init(message)
	if message == OnEnter then
		local game_mode = Get_Game_Mode()
		if game_mode == "Galactic" then
			ScriptExit()
		end
		if game_mode == "Space" then
			local era = GlobalValue.Get("CURRENT_ERA")
			if era == nil then
				era = 1
			end
			GlobalValue.Set("CURRENT_ERA", era+1)
			Story_Event("AI_NOTIF_IA_ERA_" .. tostring(era+1))
		elseif game_mode == "Land" then -- for ground
			local player = Find_Player("local")
			local tech = player.Get_Tech_Level()
			local display_tech = nil
			tech = tech + 1
			display_tech = tech
			if player == "REBEL" then -- Rebel goes from tech 0-4 ; for display purpose
				if tech == 5 then
					tech = 0
				end
				display_tech = tech + 1
			elseif tech == 6 then
				tech = 1
				display_tech = tech
			end
			player.Set_Tech_Level(tech)
			Story_Event("AI_NOTIF_IA_TECH_" .. tostring(display_tech))
		end
		ScriptExit()
	end
end
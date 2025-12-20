require("PGStateMachine")
require("PGSpawnUnits")
UnitUtil = require("eawx-util/UnitUtil")


function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init)
end


function State_Init(message)
    if message == OnEnter then	
		if Get_Game_Mode() ~= "Galactic" then
			ScriptExit()
		end
        local lock_tech = true
        local p2_table = require("ClonePhaseTwoLibrary")
        for i, unit_type in pairs(p2_table) do
            local despawn_list = Find_All_Objects_Of_Type(unit_type[1])
            if despawn_list ~= nil then
                for  _, target in pairs(despawn_list) do
                    if target.Get_Planet_Location() == nil then
                        lock_tech = false
                    else
                        UnitUtil.ReplaceAtLocation(target, unit_type[2])
                    end
                end
            end
        end
        
        if lock_tech then
            Find_Player("Empire").Lock_Tech(Object.Get_Type())
        end
        Object.Despawn()
		ScriptExit()
	end
end

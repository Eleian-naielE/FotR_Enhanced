require("PGStateMachine")
require("PGSpawnUnits")
UnitUtil = require("eawx-util/UnitUtil")


function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
    if message == OnEnter then	
		if Get_Game_Mode() ~= "Galactic" then
			ScriptExit()
		end
        local lock_tech = true
		local phase_one = {
            "Clonetrooper_Phase_One_Company", "ARC_Phase_One_Company", "Republic_74Z_Bike_Company", "Clone_Jumptrooper_Phase_One_Company", 
            "Commander_Tier_I_Clone_Phase_One_Company", "Commander_Tier_I_ARC_Phase_One_Company", "Commander_Tier_IV_Republic_74Z_Speeder_Bike_Company"
        }
        local phase_two = {
            "Clonetrooper_Phase_Two_Company", "ARC_Phase_Two_Company", "Republic_BARC_Company", "Clone_Jumptrooper_Phase_Two_Company", 
            "Commander_Tier_I_Clone_Phase_Two_Company", "Commander_Tier_I_ARC_Phase_Two_Company", "Commander_Tier_IV_Republic_BARC_Speeder_Company"
        }
        for i, unit_type in pairs(phase_one) do
            local despawn_list = Find_All_Objects_Of_Type(unit_type)
            for  _, target in pairs(despawn_list) do
                if target.Get_Planet_Location() == nil then
                    lock_tech = false
                else
                    UnitUtil.ReplaceAtLocation(target, phase_two[i])
                end
            end
        end
        
        if lock_tech then
            Object.Lock_Tech()
        end
		ScriptExit()
	end
end

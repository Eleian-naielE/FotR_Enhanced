require("PGStateMachine")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if Get_Game_Mode() ~= "Galactic" then
		ScriptExit()
	end

	if message == OnEnter then
		Owner = Object.Get_Owner()
		local check = TestValid(GlobalValue.Get("ARC_LIFETIME_LIMIT"))
		if not check then
		local current_era = GlobalValue.Get("CURRENT_ERA")
		local limit_table = require("CloneArcLimitLibrary")
		local initial_limit = limit_table[current_era]
		GlobalValue.Set("ARC_LIFETIME_LIMIT", initial_limit)
		end	
        local ObjectCount = GlobalValue.Get("ARC_LIFETIME_LIMIT")
		if ObjectCount == 0 then
			Owner.Give_Money(Object.Get_Type().Get_Build_Cost())
			Object.Despawn()
			ScriptExit()
		end
		local total_left = ObjectCount - 1 
		if total_left == 0 then
			Owner.Lock_Tech(Object.Get_Type())	
		end
        GlobalValue.Set("ARC_LIFETIME_LIMIT", total_left)
	end
	ScriptExit()
end
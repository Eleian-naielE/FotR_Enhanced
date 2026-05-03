require("PGStateMachine")
require("IA_Spawn_Generic")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), tostring(Script))
		ScriptExit()
	end
end

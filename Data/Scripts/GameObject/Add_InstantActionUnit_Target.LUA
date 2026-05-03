require("PGStateMachine")
require("IA_Spawn_Generic")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), nil, "TARGET", "Hostile")
		ScriptExit()
	end
end
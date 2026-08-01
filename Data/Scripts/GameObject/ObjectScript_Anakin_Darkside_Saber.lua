require("PGStateMachine")


function Definitions()
	Define_State("State_Init", State_Init)

end

function State_Init(message)

	if Get_Game_Mode() ~= "Land" or TestValid(Find_First_Object("SCRIPTED_BATTLE_MARKER")) then
		ScriptExit()
	end

		
	if message == OnEnter then
		Hide_Sub_Object(Object, 1, "Lightsaber") 
		Hide_Sub_Object(Object, 0, "Lightsaber_Red")
		
        ScriptExit()
	end
end

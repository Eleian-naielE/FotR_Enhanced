require("PGStateMachine")

function Definitions()
	Define_State("State_Init", State_Init)

end

function State_Init(message)

	if Get_Game_Mode() ~= "Land" then
		ScriptExit()
	end

		
	if message == OnEnter then -- FotR_Enhanced ; Hide arc wear for visual accuracy
		Hide_Sub_Object(Object, 1, "arc_wear") 
		Hide_Sub_Object(Object, 1, "arc_wear2")
		
        ScriptExit()
	end
end

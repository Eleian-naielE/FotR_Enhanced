--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"CITADEL_CRUISER_GROUP",
	"CUSTOMS_CORVETTE",
	"IPV1",
	"CLASS_C_SUPPORT",
	"CLASS_C_FRIGATE",
	"GALLEON",
	"PDF_DHC",
	"DHC_CARRIER",
	"CEC_LIGHT_CRUISER",
	"STARBOLT",
	"LAC",
	"CARRACK_CRUISER",
	"CONSULAR_REFIT",
	"LANCER_FRIGATE_PROTOTYPE",
	"VICTORY_I_FRIGATE",
	"GLADIATOR_I",
	"IMPERIAL_I_FRIGATE",
	"IMPERIAL_DHC",
	"VICTORY_I_FLEET_STAR_DESTROYER",
	"ACCLAMATOR_DESTROYER",
	"ACCLAMATOR_BATTLESHIP",
	"IMPERATOR_STAR_DESTROYER_ASSAULT",
	-- FotR_Enhanced
	"VENATOR_SPHA_T"
}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_EMPIRE_2", "Empire", unit_table)
		ScriptExit()
		
	end
end
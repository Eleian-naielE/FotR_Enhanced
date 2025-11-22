--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
		"KOMRK_GUNSHIP_GROUP",
		"GEONOSIAN_CRUISER",
		"SUPER_TRANSPORT_VII_MISSILE",
		"SUPER_TRANSPORT_VII",
		"SUPER_TRANSPORT_VI_MISSILE",
		"SUPER_TRANSPORT_VI",
		"SUPER_TRANSPORT_XI_MISSILE",
		"SUPER_TRANSPORT_XI",
		"NEUTRON_STAR_MERCENARY",
		"KUARI_PRINCESS_LINER",
		"LIBERTY_LINER",
		"SPACE_ARC_CRUISER",
		"HOME_ONE_TYPE_LINER",
		"TAGGE_BATTLECRUISER",
		"UMBARAN_FRIGATE"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_CSA", "Sector_Forces", unit_table)
		ScriptExit()
		
	end
end
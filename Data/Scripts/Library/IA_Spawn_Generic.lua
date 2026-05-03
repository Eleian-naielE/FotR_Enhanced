require("PGSpawnUnits")

function IA_Spawn(dummy_name, script_name, marker_name_in, faction_name_in)
	if Get_Game_Mode() ~= "Space" then
		ScriptExit()
	end

	local spawn_object_type = Find_Object_Type(string.sub(dummy_name,4)) --Trim "IA_" off the front

	local marker_name = ""
	if marker_name_in then
		marker_name = marker_name_in
	else
		local pos_s, pos_e = string.find(script_name,"Add_InstantActionUnit_")
		marker_name = string.sub(script_name,pos_e+1)
	end

	local faction_name = GlobalValue.Get("IA_FACTION")
	if faction_name then
		--this space intentionally left blank
	elseif faction_name_in then
		faction_name = faction_name_in
	else
		faction_name = string.gsub(marker_name,"%d","")
	end

	Spawn_Unit(spawn_object_type, Find_First_Object("INSTANTACTION_MARKER_"..string.upper(marker_name)), Find_Player(faction_name))

	ScriptExit()
end

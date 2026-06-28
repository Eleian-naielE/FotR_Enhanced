require("eawx-util/StoryUtil")

EaWXEnhancedUtil = {}

---@param object string
function EaWXEnhancedUtil.Find_Nearest_Friendly_Planet(object)
    local checkObject = object
    if type(checkObject) == "string" then 
        checkObject = Find_First_Object(object)
    end
    if TestValid(checkObject) then
        local planet = checkObject.Get_Planet_Location()

        if not planet then
            
        end
    end
end

function EaWXEnhancedUtil.Replace_Troops(old_unit_name, upgraded_unit_name)
    for _,unit in pairs(Find_All_Objects_Of_Type(old_unit_name)) do
        location = unit.Get_Planet_Location()
        if location == nil then
            min_distance = 1000000
            for _,planet in pairs(FindPlanet.Get_All_Planets()) do
                if planet.Get_Distance(unit) < min_distance and planet.Get_Owner() == player then
                    min_distance = planet.Get_Distance(unit)
                    location = planet
                end
            end
        end
        SpawnList({upgraded_unit_name}, location, player, true, false)
        unit.Despawn()
    end
end

-- Keeping these just in case
---@param old GameObject | string
---@param new string 
function ReplaceAtPosition(old, new)
	local checkObject = old
    if type(checkObject) == "string" then 
        checkObject = Find_First_Object(old)
    end
	if TestValid(checkObject) then
		local pos = checkObject.Get_Position()
		local owner = checkObject.Get_Owner()
		Spawn_Unit(Find_Object_Type(new), pos, owner)
		checkObject.Despawn()
	end
end
---@param old string
---@param new string 
function ReplaceAllAtPosition(old, new)
	local old_obj_table = Find_All_Objects_Of_Type(old)
	for _,old_obj in pairs(old_obj_table) do
		ReplaceAtPosition(old_obj, new)
	end
end
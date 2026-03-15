require("eawx-util/StoryUtil")
---@param object string
function Find_Nearest_Friendly_Planet(object)
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

function Replace_Troops(old_unit_name, upgraded_unit_name)
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
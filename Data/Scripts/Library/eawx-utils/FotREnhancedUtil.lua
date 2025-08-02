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
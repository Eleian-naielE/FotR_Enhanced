require("deepcore/std/class")
require("PGStateMachine")
require("PGSpawnUnits")
require("PGBase")

---@class EmblemHandler
EmblemHandler = class()

function EmblemHandler:new(unit_entry)
    self.is_active = true

    ---@private
    self.unit_entry = unit_entry

    ---@private
    self.object_name = Object.Get_Type().Get_Name()

    ---@private
    ---@type PlayerObject
    self.original_owner = Object.Get_Owner()

    ---@private
    self.emblem_data = unit_entry.EmblemData

    ---@private
    self.active_emblem = self:get_emblem(self.emblem_data)
end

function EmblemHandler:get_emblem(emblem_data)
	if Get_Game_Mode() ~= "Space" or not self.unit_entry then
		ScriptExit()
	end
	local emblem_to_use = GlobalValue.Get("FLEET_EMBLEM")

	for emblem,emblem_tag in pairs(emblem_data) do
		for hero_option,override_hero in pairs(emblem_tag.EmblemHero) do
			if TestValid(Find_First_Object(override_hero)) then
				if Find_First_Object(override_hero).Get_Owner() == self.original_owner then
					emblem_to_use = emblem
					break
				end
			end
		end
	end
	
	if emblem_to_use ~= nil and emblem_data[emblem_to_use] ~= nil then
		if emblem_data[emblem_to_use].mesh_to_hide then
			for hidden_mesh_option,hidden_mesh_attribute in pairs(emblem_data[emblem_to_use].mesh_to_hide) do
				Hide_Sub_Object(Object, 1, hidden_mesh_attribute)
			end
		end
		if emblem_data[emblem_to_use].mesh_to_reveal then
			for revealed_mesh_option,revealed_mesh_attribute in pairs(emblem_data[emblem_to_use].mesh_to_reveal) do
				Hide_Sub_Object(Object, 0, revealed_mesh_attribute)
				--Hide_Sub_Object(Object, 0, revealed_mesh_attribute)
			end
		end
	end
end

return EmblemHandler

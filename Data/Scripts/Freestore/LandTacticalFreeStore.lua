require("pgevents")
require("TRTacticalFreeStore")

---Basic freestore definitions
function Base_Definitions()

    Common_Base_Definitions()

    ServiceRate = 20
    UnitServiceRate = 2

    if Definitions then
        Definitions()
    end

    free_store_attack_range = 600.0
	
	aggressive_mode = false
end

---freestore cycle until exit
function main()

    if FreeStoreService then
        while 1 do
            FreeStoreService()
            PumpEvents()
        end
    end

    ScriptExit()
end

---Default behavior when unit added to the freestore
---@param object GameObject
function On_Unit_Added(object)

end

---Freestore cycle service. Checks enemy and friendly locations, and turns on aggressive mode, based on perceptions
function FreeStoreService()
    enemy_location = FindTarget.Reachable_Target(PlayerObject, "Current_Enemy_Location", "Tactical_Location", "Any_Threat", 0.5)
    friendly_location = FindTarget.Reachable_Target(PlayerObject, "Current_Friendly_Location", "Tactical_Location", "Any_Threat", 0.5)

	if Find_Hint("ATTACKER ENTRY POSITION", "main-menu-battle-disable-me") then
		aggressive_mode = true
	else
		if (EvaluatePerception("Allowed_As_Defender_Land", PlayerObject) > 0.0) then
			DebugMessage("%s -- Aggressive mode activated", tostring(Script))
			aggressive_mode = true
		else
			aggressive_mode = false
		end	
	end

end

---Default behavior on UnitService (controlled by UnitServiceRate)
---@param object GameObject
function On_Unit_Service(object)

    if not TestValid(object) then
        return
    end
	
	if object.Is_Category("AirGunship") or object.Is_Category("AirSpeeder") then
	--Air units can go anywhere, fast
		free_store_attack_range = 6000.0
	end

    current_target = object.Get_Attack_Target()
    if TestValid(current_target) then
        unit_has_target(object, current_target)   
    end

    if not object.Has_Active_Orders() then
        unit_idle(object)
    end
end

---Unit behavior when it has a target
---@param object GameObject
---@param target GameObject
function unit_has_target(object, target)

    Try_Weapon_Switch(object, target)

    if Should_Crush(object, target) then
		object.Move_To(target.Get_Position())
    end
	
	if Service_Garrison(object) then
        return
    end

    if Service_Kite(object) then
        return
    end

    if Service_Heal(object, 0.6) then
        return
    end

    return
end

---Unit behavior when it is idle
---@param object GameObject
function unit_idle(object)

    -- Reset some abilities
    object.Activate_Ability("SPREAD_OUT", false)
	
	if Service_Garrison(object) then
        return
    end

    if Service_Attack(object) then
        return
    end

    if Service_Kite(object) then
        return
    end

    if Service_Heal(object, 1.0) then
        return
    end

    Service_Guard(object)

    return
end

---Activates various abilities for units that need to get moving
---@param unit GameObject
---@param target GameObject
function unit_needs_to_move_fast(unit, target)
    unit.Activate_Ability("SPREAD_OUT", false)
    Try_Ability(unit,"JET_PACK", target)
    Try_Ability(unit,"SPRINT")
    Try_Ability(unit, "STEALTH")
    Try_Ability(unit, "FORCE_CLOAK")

    return
end

---Sends a unit to heal if it is below a given health fraction
---@param object GameObject
---@param health_threshold number
---@return boolean
function Service_Heal(object, health_threshold)

    if object.Get_Hull() > health_threshold then
        return false
    end

    -- Try to find the nearest healing structure appropriate for this unit
    local fs_healer_property_flag = Get_Special_Healer_Property_Flag(object)
    if not fs_healer_property_flag then
        if object.Is_Category("Organic") then
            fs_healer_property_flag = "HealsOrganics"
        elseif object.Is_Category("Vehicle") or object.Is_Category("VehicleHero") or object.Is_Category("AirGunship") or object.Is_Category("AirSpeeder") or object.Is_Category("Droid") then
            fs_healer_property_flag = "HealsVehicles"
        end
    end

    if fs_healer_property_flag then
        healer = Find_Nearest(object, fs_healer_property_flag, PlayerObject, true)
    end

    if not TestValid(healer) then
        return false
    end

    if object.Get_Distance(healer) > 300.0 then
        unit_needs_to_move_fast(object, healer)
        object.Move_To(healer, 10)
        return true
    end
	
    object.Move_To(healer, 10)
    return true
end

--FotR_Enhanced : Reimplement Organic/Droid Infantry healing function

---Services units that contain a garrison
---@param object GameObject
function Service_Garrison(object)

    if not object.Has_Property("CanContainGarrison") then
        return false
    end

    local garrison_table = object.Get_Garrisoned_Units()
    if table.getn(garrison_table) == 0 then
        return false
    end

    local garrison_needs_heals = false
    garrison_healer = Find_Nearest(object, "HealsOrganics | HealsDroids", PlayerObject, true)
    garrison_capture = Find_Nearest(object, "IsRushTarget")
    local garrison_enemy = Find_Nearest(object, PlayerObject, false)
    local eject_before_destroyed = (object.Get_Hull() < 0.2)
    local eject_for_heal = TestValid(garrison_healer) and (object.Get_Distance(garrison_healer) < 150)
    local eject_for_attack = (not object.Has_Property("GarrisonCanFire")) and TestValid(garrison_enemy) and (object.Get_Distance(garrison_enemy) < free_store_attack_range)
    local eject_for_capture = (not object.Has_Property("GarrisonCanFire")) and TestValid(garrison_capture) and (object.Get_Distance(garrison_capture) < 100)
	local no_enemies_near = false
	
	closest_enemy = Find_Nearest(object, object.Get_Owner(), false)
	
		--Exit garrison if no enemies nearby
	if TestValid(closest_enemy) and object.Has_Property("GarrisonCanFire") then
		no_enemies_near = (object.Get_Distance(closest_enemy) > free_store_attack_range)
	end

    for _, garrison in pairs(garrison_table) do
        if garrison_should_exit(garrison, eject_before_destroyed, eject_for_heal, eject_for_attack, eject_for_capture, no_enemies_near) then
            garrison.Leave_Garrison()
        end

        if garrison.Get_Hull() < 0.4 and not eject_for_heal then
            garrison_needs_heals = true
        end
    end
	
	if TestValid(garrison_capture) then
        object.Move_To(garrison_capture, 10)
	elseif garrison_needs_heals and TestValid(garrison_healer) then
        object.Move_To(garrison_healer, 10)
    end
    
    return true
end

---Determines if a garrison unit should exit
---@param garrison GameObject
---@param eject_before_destroyed boolean
---@param eject_for_heal boolean
---@param eject_for_capture boolean
---@param no_enemies_near boolean
---@return boolean
function garrison_should_exit(garrison, eject_before_destroyed, eject_for_heal, eject_for_attack, eject_for_capture, no_enemies_near)
    return eject_before_destroyed or (garrison.Get_Hull() < 0.4 and eject_for_heal) or eject_for_attack or eject_for_capture or no_enemies_near
end

---Makes units engage enemies
---@param object GameObject
function Service_Attack(object)
    --Move to the enemy position rather than the enemy itself in order to leave us free
    --to run autonomous targeting.  While this doesn't provide chase behavior we're probably
    --repeating this enough that we don't care
    closest_enemy = Find_Nearest(object, object.Get_Owner(), false)

    if not TestValid(closest_enemy) or not aggressive_mode then
        return false
    end

    if object.Get_Distance(closest_enemy) < free_store_attack_range then
        object.Attack_Move(closest_enemy.Get_Position())
        return true
    end
    
    if TestValid(enemy_location) then
        object.Attack_Move(enemy_location)
		return true
    end

	return false
end

---Controls freestore guard behavior
---@param object GameObject
---@return boolean
function Service_Guard(object)
    if Try_Deploy_Garrison(object, nil, 0.0) then
        return true
    end

    local closest_friendly_structure = Find_Nearest(object, "Structure", object.Get_Owner(), true)
	
	if TestValid(friendly_location) then
		object.Attack_Move(friendly_location)
		-- Try to garrison near friendlies
		Try_Garrison(nil, object, true, free_store_attack_range)
	elseif TestValid(closest_friendly_structure) then
		object.Attack_Move(closest_friendly_structure.Get_Position())
		object.Guard_Target(closest_friendly_structure)
		return true
	elseif TestValid(enemy_location) then
		object.Attack_Move(enemy_location)
		return true
	end

	return false
end

---Controls freestore kiting behavior
---@param object GameObject
---@return boolean
function Service_Kite(object)
	
    if should_kite(object) and (object.Get_Hull() < 0.9) then
	
		fs_deadly_enemy = FindDeadlyEnemy(object)

		if TestValid(fs_deadly_enemy) then

			Try_Ability(object, "PROXIMITY_MINES", object)

			if object.Get_Hull() > 0.5 then
				Try_Ability(object, "STIM_PACK")
			end

			fs_kite_pos = Project_By_Unit_Range(fs_deadly_enemy, object)
			unit_needs_to_move_fast(object, fs_kite_pos)
			object.Move_To(fs_kite_pos)

			return true
		end

		return false
	end
end


function should_kite(object)
	return object.Has_Property("DoKite") or object.Is_Category("AirGunship") or object.Is_Category("AirSpeeder") or object.Is_Category("InfantryHero")
end
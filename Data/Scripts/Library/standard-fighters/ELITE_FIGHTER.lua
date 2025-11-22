require("StandardFighterFunctions")

return {
	Evaluate_Fighters = function(native,suffix,owner,alias,techLevel,regime,flags,is_main_empire)		
		local fighter = "CLOAKSHAPE_SQUADRON"
		
		if Is_Amalgam(owner) then
			alias = native
		end
		
		-- Commented out for lack of anything to input
		-- local simpletypes = {
		
		-- }
		
		-- if simpletypes[owner] then
			-- fighter = simpletypes[owner]
		-- elseif simpletypes[alias] then
			-- fighter = simpletypes[alias]
		-- end
		
		if owner == "EMPIRE" or alias == "EMPIRE" then
			if techLevel >= 2 and not Check_Flags(flags,"ELITE_CLOAKSHAPE") then
				fighter = "CLONE_ARC_170_SQUADRON"
			end
		end
		
		if owner == "SECTOR_FORCES" or alias == "SECTOR_FORCES" then
			if techLevel >= 2 then
				fighter = "STOCK_ARC_170_SQUADRON"
			end
		end
		
		if owner == "HUTT_CARTELS" then
			if Get_Fighter_Research("Scyk") then
				fighter = "SCYK_HEAVY_FIGHTER_SQUADRON"
			else
				fighter = "MORNINGSTAR_A_SQUADRON"
			end
		end
		
		if alias == "CIS" then
			if owner == "COMMERCE_GUILD" or owner == "BANKING_CLAN" then
				fighter = "NANTEX_SQUADRON"
			else 
				if techLevel > 2 then
					fighter = "TRIFIGHTER_SQUADRON"
				else
					fighter = "SCARAB_SQUADRON"
				end
			end
		end
		
		if suffix then
			fighter = fighter .. suffix
		end
		return fighter
	end
}
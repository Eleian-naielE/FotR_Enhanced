	-- ["COMPANY_OBJECT_NAME"] = {
		-- current_limit = N (required),
		-- lifetime_limit = N (optional),
		-- shared_cap = true (optional)
		-- limit_synced_unit = UnitName (Optional)
	-- },

return {
	["KOTAS_MILITIA_TROOPER_COMPANY"] = {
		current_limit = 5,
	},
	["NIGHTSISTER_SITH_WITCH_COMPANY"] = {
		current_limit = 3,
	},
	
	["ARC_PHASE_TWO_COMPANY"] = {
		current_limit = GlobalValue.Get('ARC_LIFETIME_LIMIT'), 
		lifetime_limit = GlobalValue.Get('ARC_LIFETIME_LIMIT'),
	}
	
}

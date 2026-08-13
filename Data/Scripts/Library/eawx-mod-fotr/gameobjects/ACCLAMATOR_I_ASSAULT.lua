return {
	Ship_Crew_Requirement = 155,
	Fighters = {
		["INTERCEPTOR"] = {
			DEFAULT = {Initial = 1, Reserve = 1, HeroOverride = {{"FORRAL_VENSENOR"}, {"CLOAKSHAPE_STOCK_SQUADRON"}}}
		},
		["ELITE_FIGHTER"] = {
			DEFAULT = {Initial = 1, Reserve = 2, HeroOverride = {{"FORRAL_VENSENOR"}, {"STOCK_ARC_170_SQUADRON"}}}
		},
		["BOMBER"] = {
			DEFAULT = {Initial = 1, Reserve = 2,HeroOverride = {{"FORRAL_VENSENOR"}, {"2_WARPOD_SQUADRON"}}}
		}
	},
	Native = "EMPIRE",
	FighterFlags = {"CLONE_Z95","INTERCEPTOR_AB_INVERT"},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"}
}
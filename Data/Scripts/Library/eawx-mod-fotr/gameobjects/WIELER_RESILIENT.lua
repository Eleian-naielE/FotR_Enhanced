return {
	Fighters = {
		["TORRENT_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 6, TechLevel = LessOrEqualTo(3)}
		},
		["CLONE_NIMBUS_V_WING_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 6, HeroOverride = {{"SATE_PESTAGE","MON_MOTHMA"}, {"NIMBUS_V_WING_ELITE_GUARD_SQUADRON","NIMBUS_V_WING_ELITE_GUARD_SQUADRON"}}, TechLevel = GreaterThan(3)}
		},
		["ETA2_ACTIS_SQUADRON_DOUBLE"] = { --Maybe swap this for Delta in Era 2? YES
			DEFAULT = {Initial = 2, Reserve = 6, TechLevel = LessOrEqualTo(2)}
		},
		["DELTA7_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 6, TechLevel = GreaterThan(2)}
		},
		["ARC_170_OFC_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Scripts = {"multilayer", "fighter-spawn"}
}
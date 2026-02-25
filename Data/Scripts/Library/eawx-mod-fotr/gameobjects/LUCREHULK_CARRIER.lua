return {
	Ship_Crew_Requirement = 1350,
	Fighters = {
		["LIGHT_FIGHTER_DOUBLE"] = {
			DEFAULT = {Initial = 3, Reserve = 12}
		},
		--IF specific spawns, standards are blocked by the techlevel
		["Z95_HEADHUNTER_SQUADRON_DOUBLE"] = {
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 2}
		},
		["EARLY_SKIPRAY_SQUADRON_DOUBLE"] = {
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 2}
		},
		["ELITE_INTERCEPTOR_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 4},
			INDEPENDENT_FORCES = {Initial = 2, Reserve = 4, TechLevel = GreaterThan(99)}
		},
		["LIGHT_BOMBER2_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 4},
			REBEL = {Initial = 1, Reserve = 4, TechLevel = GreaterThan(99)}
		},
		-- FotR_Enhanced
		["LIGHT_BOMBER_DOUBLE"] = {
			REBEL = {Initial = 1, Reserve = 4}
		},
		["BOMBER_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 8}
		}
	},
	Native = "CIS",
	Scripts = {"multilayer", "fighter-spawn"}
}
return {
	Ship_Crew_Requirement = 23,
	Fighters = {
		["LIGHT_FIGHTER"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["LIGHT_BOMBER2"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Native = "CIS",
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"},
	Flags = {HANGAR = true}
}
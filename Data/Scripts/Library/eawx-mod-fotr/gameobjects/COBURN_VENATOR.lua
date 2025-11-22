return {
	Fighters = {
		["PDF_Z95_HEADHUNTER_SQUADRON"] = {
			DEFAULT = {Initial = 3, Reserve = 10, TechLevel = LessOrEqualTo(2)}
		},
		["CLONE_Z95_HEADHUNTER_SQUADRON"] = {
			DEFAULT = {Initial = 3, Reserve = 10, TechLevel = GreaterThan(2)}
		},
		["ARC_170_OFC_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "microjump"}
}
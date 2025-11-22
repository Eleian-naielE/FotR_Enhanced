return {
	Ship_Crew_Requirement = 290,
	Fighters = {
		["INTERCEPTOR"] = {
			DEFAULT = {Initial = 1, Reserve = 4}
		},
		["ELITE_FIGHTER"] = {
			DEFAULT = {Initial = 1, Reserve = 3}
		},
		["BOMBER"] = {
			DEFAULT = {Initial = 1, Reserve = 4}
		},
		["HEAVY_BOMBER"] = {
			DEFAULT = {Initial = 1, Reserve = 3}
		}
	},
	Native = "EMPIRE",
	EmblemData = {
		OPEN_CIRCLE = {
			mesh_to_hide = {"VENATOR_LEFT", "VENATOR_RIGHT"},
			mesh_to_reveal = {"VENATOR_LEFT_OCA", "VENATOR_RIGHT_OCA"},
			EmblemHero = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY", "COBURN_VENATOR", "TENANT_VENATOR", "AUTEM_VENATOR", "KILIAN_ENDURANCE", "WIELER_RESILIENT", "BLOCK_NEGOTIATOR", "BLOCK_VIGILANCE"},
		},
		KDY = {
			mesh_to_hide = {"VENATOR_LEFT", "VENATOR_RIGHT"},
			mesh_to_reveal = {"VENATOR_LEFT_KDY", "VENATOR_RIGHT_KDY"},
			EmblemHero = {"WESSEX_REDOUBT", "ONARA_KUAT_PRIDE_OF_THE_CORE", "KUAT_OF_KUAT_PROCURATOR"},
		},
		ORSF = {
			mesh_to_hide = {"VENATOR_LEFT", "VENATOR_RIGHT"},
			mesh_to_reveal = {"VENATOR_LEFT_ORSF", "VENATOR_RIGHT_ORSF"},
			EmblemHero = {"TARKIN_VENATOR","TARKIN_EXECUTRIX","MAARISA_RETALIATION","MAARISA_CAPTOR"},
		},
		TAPANI = {
			mesh_to_hide = {"VENATOR_LEFT", "VENATOR_RIGHT"},
			mesh_to_reveal = {"VENATOR_LEFT_TAPANI", "VENATOR_RIGHT_TAPANI"},
			EmblemHero = {"GRANT_VENATOR"},
		},
	},
	Scripts = {"multilayer", "fighter-spawn", "emblem-handler"}
}

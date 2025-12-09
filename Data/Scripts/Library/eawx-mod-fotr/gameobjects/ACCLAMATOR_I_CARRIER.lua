return {
	Ship_Crew_Requirement = 155,
	Fighters = {
		["INTERCEPTOR_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		},
		["BOMBER_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Native = "SECTOR_FORCES",
	FighterFlags = {"TORRENTKEEP"},
	EmblemData = {
		OCF = {
			mesh_to_hide = {"ACCLAMATOR_I_LEFT", "ACCLAMATOR_I_RIGHT"},
			mesh_to_reveal = {"ACCLAMATOR_I_LEFT_OCA", "ACCLAMATOR_I_RIGHT_OCA"},
			EmblemHero = {"YULAREN_RESOLUTE","YULAREN_INTEGRITY", "YULAREN_RESOLUTE_SPHAT", "COBURN_VENATOR", "TENANT_VENATOR", "AUTEM_VENATOR", "KILIAN_ENDURANCE", "WIELER_RESILIENT", "BLOCK_NEGOTIATOR", "BLOCK_VIGILANCE"},
		},
		KDY = {
			mesh_to_hide = {"ACCLAMATOR_I_LEFT", "ACCLAMATOR_I_RIGHT"},
			mesh_to_reveal = {"ACCLAMATOR_I_LEFT_KDY", "ACCLAMATOR_I_RIGHT_KDY"},
			EmblemHero = {"WESSEX_REDOUBT", "ONARA_KUAT_PRIDE_OF_THE_CORE", "KUAT_OF_KUAT_PROCURATOR"},
		},
		ORSF = {
			mesh_to_hide = {"ACCLAMATOR_I_LEFT", "ACCLAMATOR_I_RIGHT"},
			mesh_to_reveal = {"ACCLAMATOR_I_LEFT_ORSF", "ACCLAMATOR_I_RIGHT_ORSF"},
			EmblemHero = {"TARKIN_VENATOR","TARKIN_EXECUTRIX","MAARISA_RETALIATION","MAARISA_CAPTOR"},
		},
		TAPANI = {
			mesh_to_hide = {"ACCLAMATOR_I_LEFT", "ACCLAMATOR_I_RIGHT"},
			mesh_to_reveal = {"ACCLAMATOR_I_LEFT_TAPANI", "ACCLAMATOR_I_RIGHT_TAPANI"},
			EmblemHero = {"GRANT_VENATOR"},
		},
	},
	Scripts = {"multilayer", "fighter-spawn", "emblem-handler", "single-unit-retreat"}
}
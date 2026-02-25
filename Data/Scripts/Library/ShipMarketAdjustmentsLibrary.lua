return {
	--Universal GC start adjustments & in-game events
		["CLONE_WAR_BEGUN"] = {
		--Starting in Era 2+ unlocks Acclamator Destroyer and Acclamator Battleship
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", false},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", false},
				{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_ONE_COMPANY", false},	
				{"EMPIRE", "CLONE_MARKET", "CLONE_COMMANDO_REWORK_COMPANY", false},	
				{"EMPIRE", "CLONE_MARKET", "CLONE_VEHICULAR_ASSAULT_COMPANY", false},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SPECIAL_OPS_COMPANY", false},
			},
			initial_amounts = {
				{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_ONE_COMPANY", GlobalValue.Get("ARC_LIFETIME_LIMIT")}
			},
		},
		["VENATOR_RESEARCH"] = {
		--Venator Research unlocks Maelstrom, reduces chance of Procurator
		--KDY Contract stops Venator Research from making market changes
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", false},
			},
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", -20},
			}
		},
		["KDY_CONTRACT"] = {
		--KDY Contract locks Maelstrom and Procurator, unlocks Secutor, Tector, Imperator
		--KDY Contract stops Venator Research from making market changes
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", true},
				{"EMPIRE", "KDY_MARKET", "TECTOR_STAR_DESTROYER", false},
				{"EMPIRE", "KDY_MARKET", "SECUTOR_STAR_DESTROYER", false},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER", false},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER_ASSAULT", false},
			},
			requirement_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", "[ This design has been retired ]"},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", "[ This design has been retired ]"},
			}
		},
		["PHASE_TWO_RESEARCH"] = {
			lock_lists = {
				{"EMPIRE", "CLONE_MARKET", "CLONE_GALACTIC_MARINE_COMPANY", false},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SCOUT_TROOPER_COMPANY", false},
				{"EMPIRE", "CLONE_MARKET", "CLONE_AIRBORNE_TROOPER_COMPANY", false},
				{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_ONE_COMPANY", true, true},
				{"EMPIRE", "CLONE_MARKET", "CLONE_VEHICULAR_ASSAULT_COMPANY", true},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SPECIAL_OPS_COMPANY", true},
			},
			requirement_lists = {
				{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_ONE_COMPANY", "[ This unit has been upgraded to phase II ]"},
				{"EMPIRE", "CLONE_MARKET", "CLONE_VEHICULAR_ASSAULT_COMPANY", "[ This unit has been phased out ]"},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SPECIAL_OPS_COMPANY", "[ This unit has been phased out ]"},
			},
			initial_amounts ={ 
				{"EMPIRE", "CLONE_MARKET", "CLONE_GALACTIC_MARINE_COMPANY", 3},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SCOUT_TROOPER_COMPANY", 2},
				{"EMPIRE", "CLONE_MARKET", "CLONE_AIRBORNE_TROOPER_COMPANY", 1},
				--{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_TWO_COMPANY", GlobalValue.Get("ARC_LIFETIME_LIMIT")},
			},
		},
	--Specific GC start overwrites
		["MALEVOLENCE"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", 20, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", false},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", nil, nil, true},
				{"EMPIRE", "CLONE_MARKET", "CLONE_VEHICULAR_ASSAULT_COMPANY", false},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SPECIAL_OPS_COMPANY", false},	
			},
		},
		["RIMWARD"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", 50, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", 60, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", 35, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", 35, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", false},
			},
		},
		["TENNUUTTA"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "TECTOR_STAR_DESTROYER", 100, true},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER_ASSAULT", 100, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "SECUTOR_STAR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "TECTOR_STAR_DESTROYER", false},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER_ASSAULT", false},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", nil, nil, true},
			},
			requirement_lists = {
				{"EMPIRE", "KDY_MARKET", "TECTOR_STAR_DESTROYER", "[ Requires a Republic Naval Command Center ]"},
				{"EMPIRE", "KDY_MARKET", "IMPERATOR_STAR_DESTROYER_ASSAULT", "[ Requires a Republic Naval Command Center ]"},
			},
		},
		["KNIGHT_HAMMER"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", 50, true},
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", 60, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", 20, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", false},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", nil, nil, true},
				{"EMPIRE", "CLONE_MARKET", "CLONE_VEHICULAR_ASSAULT_COMPANY", nil, nil, true},
				{"EMPIRE", "CLONE_MARKET", "CLONE_SPECIAL_OPS_COMPANY", nil, nil, true},
				{"EMPIRE", "CLONE_MARKET", "ARC_PHASE_ONE_COMPANY", nil, nil, true},
			},
		},
		["DURGES_LANCE"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", 85, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", 45, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", 45, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", nil, nil, true},
			},
		},
		["FOEROST"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", 60, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", nil, nil, true},
			},
		},
		["OUTER_RIM_SIEGES"] = {
			adjustment_lists = {
				{"EMPIRE", "KDY_MARKET", "PRAETOR_I_BATTLECRUISER", 60, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_DESTROYER", 10, true},
				{"EMPIRE", "KDY_MARKET", "ACCLAMATOR_BATTLESHIP", 10, true},
			},
			lock_lists = {
				{"EMPIRE", "KDY_MARKET", "PROCURATOR_BATTLECRUISER", nil, nil, true},
				{"EMPIRE", "KDY_MARKET", "MAELSTROM_BATTLECRUISER", nil, nil, true},
			},
		},
}

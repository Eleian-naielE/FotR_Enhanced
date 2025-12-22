return {
	Missions = {
		["BUILDSTRUCTURESGROUND"] = {active = false, chance = 12},
		["BUILDSTRUCTURESSPACE"] = {active = false, chance = 12},
		["CREDITINCOME"] = {active = false, chance = 4},
		["CREWINCOME"] = {active = false, chance = 4},
		["HUNTTARGETA"] = {active = false, chance = 12},
		["HUNTTARGETB"] = {active = false, chance = 12},
		--["RAISE_INFLUENCE"] = {active = false, chance = 8},
		["RAISEINFRASTRUCTURE"] = {active = false, chance = 8},
		["RECON"] = {active = false, chance = 12},
		["TAKEPLANETANY"] = {active = false, chance = 12},
		["TAKEPLANETENEMY"] = {active = false, chance = 12},
	},
	RewardGroups = {
		"REP",
		"REP",
		"REP",
		"REP",
		"PDF"
	},
	RewardGroupDetails = {
		["REP"] = {
			DialogName = "REP",
			RewardName = "ERA",
			GroupSupport = "SECTOR_FORCES",
			SupportArg = 1,
		},
		["PDF"] = {
			DialogName = "PDF",
			RewardName = "PDF"
		}
	}
}

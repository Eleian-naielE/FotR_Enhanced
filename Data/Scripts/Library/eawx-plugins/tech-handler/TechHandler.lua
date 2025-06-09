require("deepcore/std/class")
require("eawx-events/GenericResearch")
require("eawx-events/GenericSwap")

---@class TechHandler
TechHandler = class()

function TechHandler:new(galactic_conquest, human_player, planets, unlocktech)
	self.galactic_conquest = galactic_conquest
	self.human_player = human_player
	self.planets = planets
	self.unlocktech = unlocktech

	if self.unlocktech ~= false then
			-- galactic_conquest,
			-- event_name,
			-- research_dummy,
			-- player,
			-- unlock_list,
			-- lock_list,
			-- spawn_list, spawn_planet,
			-- chained_effect

		self.ProvidenceResearch = GenericResearch(self.galactic_conquest,
			"PROVIDENCE_RESEARCH",
			"Dummy_Research_Providence",
			{"Rebel"},
			{"Providence_Carrier_Destroyer"},
			{"Providence_Destroyer"}
			)

		self.VenatorResearch = GenericResearch(self.galactic_conquest,
			"VENATOR_RESEARCH",
			"Dummy_Research_Venator",
			{"Empire"},
			{"Venator_Star_Destroyer"},
			nil,
			nil,nil,
			{"VENATOR_HEROES"}
			)
		--FotR_Enhanced
		--[[
		self.UtatResearch = GenericResearch(self.galactic_conquest, 
			"UTAT_RESEARCH", 
			"Dummy_Research_UTAT", 
			{"Empire"}, 
			{"Republic_UT_AT_Speeder_Company"}, 
			nil,
			nil,nil,
			{"UTAT_HEROES"}
			)
		]]
		self.Victory1Research = GenericResearch(self.galactic_conquest,
			"VICTORY1_RESEARCH",
			"Dummy_Research_Victory1",
			{"Empire"},
			{"Victory_I_Star_Destroyer"},
			nil,
			nil,nil,
			{"VICTORY1_HEROES"}
			)

		self.Bulwark1Research = GenericResearch(self.galactic_conquest,
			"BULWARK1_RESEARCH",
			"Dummy_Research_Bulwark1",
			{"Rebel"},
			{"Bulwark_I"},
			nil,
			nil,nil,
			{"BULWARK1_HEROES"}
			)

		self.PhaseIIResearch = GenericResearch(self.galactic_conquest,
			"PHASE_TWO_RESEARCH",
			"Dummy_Research_Clone_Trooper_II",
			{"Empire"},
			{"Clonetrooper_Phase_Two_Company","Republic_BARC_Company","ARC_Phase_Two_Company"},
			{"Clonetrooper_Phase_One_Company","Republic_74Z_Bike_Company","ARC_Phase_One_Company"},
			nil,nil,
			{"CLONE_UPGRADES"}
			)

		self.Victory2Research = GenericResearch(self.galactic_conquest,
			"VICTORY2_RESEARCH",
			"Dummy_Research_Victory2",
			{"Empire"},
			{"Victory_II_Star_Destroyer"},
			nil,
			nil,nil,
			{"VICTORY2_HEROES"}
			)

		self.Bulwark2Research = GenericResearch(self.galactic_conquest,
			"BULWARK2_RESEARCH",
			"Dummy_Research_Bulwark2",
			{"Rebel"},
			{"Bulwark_II"}
			)

	--These events all fire together in 21 BBY month 6
	--This should probably be handled by switching the tech state machine from the global era policy to a year policy
		self.Roster_Update_21BBY_M6_CIS = GenericResearch(self.galactic_conquest,
			"ROSTER_UPDATE_21BBY_M6",
			"Template_Research_Dummy",
			{"Rebel"},
			{"Pursuer_Enforcement_Ship_Group","Lucrehulk_Battleship"},
			{"CIS_GAT_Company"}
			)

		self.Roster_Update_21BBY_M6_Subs = GenericResearch(self.galactic_conquest,
			"ROSTER_UPDATE_21BBY_M6",
			"Template_Research_Dummy",
			{"Banking_Clan","Commerce_Guild","Techno_Union","Trade_Federation"},
			{"Providence_Carrier"},
			{"CIS_GAT_Company"}
			)

		self.Roster_Update_21BBY_M6_Rep = GenericResearch(self.galactic_conquest,
			"ROSTER_UPDATE_21BBY_M6",
			"Template_Research_Dummy",
			{"Empire"},
			{"Republic_ISP_Company","Republic_Flashblind_Company","UT_AT_Speeder_Company"},
			{"Invincible_Cruiser","Republic_Gaba18_Company","AT_XT_Company"},
			nil, nil,
			{"GEEN_UNLOCK"}
			)

	--These events all fire together in 20 BBY month 6
	--This should probably be handled by switching the tech state machine from the global era policy to a year policy
		self.Roster_Update_20BBY_M6_CIS_And_Subs = GenericResearch(self.galactic_conquest,
			"ROSTER_UPDATE_20BBY_M6",
			"Template_Research_Dummy",
			{"Rebel","Banking_Clan","Commerce_Guild","Techno_Union","Trade_Federation"},
			{"HMP_Company","Destroyer_Droid_I_Q_Company","Destroyer_Droid_II_Company","Magna_Missile_Company"},
			{"Destroyer_Droid_I_W_Company","Magna_Company"}
			)

		self.Roster_Update_20BBY_M6_Rep = GenericResearch(self.galactic_conquest,
			"ROSTER_UPDATE_20BBY_M6",
			"Template_Research_Dummy",
			{"Empire"},
			{"Acclamator_II","HAET_Company","Republic_AT_AP_Walker_Company","AT_OT_Walker_Company"},
			{"Republic_Flashblind_Company"}
			)

		--These events all fire together in 19 BBY month 2
		--This should probably be handled by switching the tech state machine from the global era policy to a year policy
		self.TX130Swap_Rep = GenericResearch(self.galactic_conquest,
			"TX130SWAP",
			"Template_Research_Dummy",
			{"Empire"},
			{"Republic_TX130T_Company"},
			{"Republic_TX130S_Company"}
			)
	end

	--This should probably be handled with the rest of PHASE_TWO_RESEARCH effects. (P2 as implemented in historicals would also need work to make that happen.)
	self.CloneSwap = GenericSwap("CLONE_UPGRADES", "EMPIRE",
		{"Cody", "Rex", "Appo", "Commander_71", "Bacara", "Jet", "Gree_Clone", "Deviss", "Bly", "Wolffe", "Neyo", "Alpha_17", "Fordo", "Ordo_Skirata", "Aden_Skirata", "Kligson", "Rom_Mohc"},
		{"Cody2_Team", "Rex2_Team", "Appo2_Team", "Commander_71_2_Team", "Bacara2_Team", "Jet2_Team", "Gree2_Team", "Deviss2_Team", "Bly2_Team", "Wolffe2_Team", "Neyo2_Team", "Alpha_17_2_Team", "Fordo2_Team", "Ordo_Skirata2_Team", "Aden_Skirata2_Team", "Kligson2_Team", "Rom_Mohc2_Team"})

	self.TempestResearch = GenericResearch(self.galactic_conquest,
		"TEMPEST_RESEARCH",
		"Dummy_Research_Tempest",
		{"Hutt_Cartels"},
		{"Tempest_Cruiser"},
		nil,
		{"Mika_Tempest"},"Nal_Hutta"
		)
end

return TechHandler

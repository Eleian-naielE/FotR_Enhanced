require("deepcore/std/class")
require("eawx-util/StoryUtil")
require("eawx-util/UnitUtil")
require("deepcore/crossplot/crossplot")
require("PGStoryMode")
require("eawx-util/Sort")
require("deepcore/std/class")
require("eawx-events/GenericResearch")
require("eawx-events/GenericSwap")

---@class GovernmentRepublic
GovernmentRepublic = class()

function GovernmentRepublic:new(gc,id,gc_name)
	p_independent = Find_Player("Independent_Forces")
	self.RepublicPlayer = Find_Player("Empire")
	self.human_player = Find_Player("local")

	GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_PALPATINE")
	GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_PALPATINE")

	GlobalValue.Set("CLONE_DEFAULT", 0)
	self.CloneSkins = {
		"Default clone armour reset to unpainted",
		"Default clone armour set to 212th",
		"Default clone armour set to 501st",
		"Default clone armour set to 104th",
		"Default clone armour set to 327th",
		"Default clone armour set to 187th",
		"Default clone armour set to 21st",
		"Default clone armour set to 41st",
		"Default clone armour set to random squads",
		"Default clone armour set to random companies"
	}

	self.FleetSkins = {
		"Default fleet marking reset",
		"Default fleet marking set to Open Circle",
		"Default fleet marking set to KDY",
		"Default fleet marking set to ORSF",
		"Default fleet marking set to Tapani",
	}

	self.FleetID = 0

	self.FleetValues = {
		nil,
		"OPEN_CIRCLE",
		"KDY",
		"ORSF",
		"TAPANI",
	}

	self.Active_Planets = StoryUtil.GetSafePlanetTable()

	self.rep_starbase = Find_Object_Type("Empire_Star_Base_1")
	self.rep_gov_building = Find_Object_Type("Empire_Office")

	self.id = id
	self.gc_name = gc_name

	self.standard_integrate = false

	if self.gc_name == "PROGRESSIVE" then
		self.standard_integrate = true
	end

	self.Order6XExecuted = false

	self.GroundStructureSnapshot = {}
	self.SpaceStructureSnapshot = {}

	GCEventTable = {
		["PROGRESSIVE"] = {EventName = "START_ORDER_6X", AutoOption = "SENATE_CHOICE_ORDER_6X_AI"},
		["FTGU"] = {EventName = "START_ORDER_6X", AutoOption = "SENATE_CHOICE_ORDER_6X_AI"},
		["CUSTOM"] = {EventName = "START_ORDER_6X", AutoOption = "SENATE_CHOICE_ORDER_6X_AI"},
		["MALEVOLENCE"] = {EventName = "START_SPECIAL_TASKFORCE_FUNDING", AutoOption = "SENATE_APPROVAL_TASKFORCE", HumanAuto = true},
		["RIMWARD"] = {EventName = "START_MILITARY_ENHANCEMENT_BILL", AutoOption = "SENATE_CHOICE_MIL_ENH_MOTHMA"},
		["TENNUUTTA"] = {EventName = "START_BLISSEX_RESEARCH_FUNDING", AutoOption = "SENATE_APPROVAL_BLISSEX", HumanAuto = true},
		["KNIGHT_HAMMER"] = {EventName = "START_ENHANCED_SECURITY", AutoOption = "SENATE_CHOICE_ENH_SEC_TARKIN"},
		["DURGES_LANCE"] = {EventName = "START_KUAT_POWER_STRUGGLE", AutoOption = "SENATE_CHOICE_KUAT_GIDDEAN"},
		["FOEROST"] = {EventName = "START_CORE_WORLDS_SECURITY_ACT", AutoOption = "SENATE_APPROVAL_CORE_SECURITY", HumanAuto = true},
		["OUTER_RIM_SIEGES"] = {EventName = "START_SECTOR_GOVERNANCE_DECREE", AutoOption = "SENATE_CHOICE_SEC_GOV_PESTAGE"},
	}

	self.production_finished_event = gc.Events.GalacticProductionFinished
	self.production_finished_event:attach_listener(self.on_construction_finished, self)

	crossplot:subscribe("SENATE_SUPPORT_REACHED", self.SenateSupportReached, self)

	crossplot:subscribe("SENATE_CHOICE_ENH_SEC_OPTION", self.SenateChoiceMade, self)
	crossplot:subscribe("SENATE_CHOICE_KUAT_OPTION", self.SenateChoiceMade, self)
	crossplot:subscribe("SENATE_CHOICE_MIL_ENH_OPTION", self.SenateChoiceMade, self)
	crossplot:subscribe("SENATE_CHOICE_ORDER_6X_OPTION", self.SenateChoiceMade, self)
	crossplot:subscribe("SENATE_CHOICE_SEC_GOV_OPTION", self.SenateChoiceMade, self)

	crossplot:subscribe("EXECUTE_ORDER_66", self.ExecuteOrder66, self)
	crossplot:subscribe("MISSION_KNIGHTFALL_OPTION", self.ExecuteOrder66, self)
end

function GovernmentRepublic:update()
	--Logger:trace("entering GovernmentRepublic:Update")

	--this space intentionally left blank
end

function GovernmentRepublic:SenateSupportReached()
	--Logger:trace("entering GovernmentRepublic:SenateSupportReached")

	--if the Order 65/66 choice has already been made, do not prompt any other Senate choices
	if self.Order6XExecuted == true then
		return
	end

	if self.RepublicPlayer.Is_Human() then
		Story_Event(GCEventTable[self.gc_name].EventName)
		if GCEventTable[self.gc_name].HumanAuto == true then
			self:SenateChoiceMade(GCEventTable[self.gc_name].AutoOption)
		end
	else
		self:SenateChoiceMade(GCEventTable[self.gc_name].AutoOption)
	end
end

function GovernmentRepublic:SenateChoiceMade(option)
	--Logger:trace("entering GovernmentRepublic:SenateChoiceMade")

	--enhanced security
	if option == "SENATE_CHOICE_ENH_SEC_MOTHMA" then
		Story_Event("ENHANCED_SECURITY_MOTHMA")
		crossplot:publish("SENATE_CHOICE_MADE", "ENHANCED_SECURITY_PREVENTED")
	elseif option == "SENATE_CHOICE_ENH_SEC_TARKIN" then
		Story_Event("ENHANCED_SECURITY_TARKIN")
		crossplot:publish("SENATE_CHOICE_MADE", "ENHANCED_SECURITY_SUPPORTED")

	--kuat power struggle
	elseif option == "SENATE_CHOICE_KUAT_ONARA" then
		Story_Event("KUAT_POWER_STRUGGLE_ONARA")
		UnitUtil.SetLockList("EMPIRE", {"Onara_Kuat_POTC_Upgrade"})
		StoryUtil.SpawnAtSafePlanet("KUAT", self.RepublicPlayer, self.Active_Planets, {"Onara_Kuat_Team","Ottegru_Grey_Team"})
	elseif option == "SENATE_CHOICE_KUAT_GIDDEAN" then
		Story_Event("KUAT_POWER_STRUGGLE_GIDDEAN")
		UnitUtil.DespawnList({"ONARA_KUAT"})
		StoryUtil.SpawnAtSafePlanet("BYSS", self.RepublicPlayer, self.Active_Planets, {"Giddean_Team","Kuat_of_Kuat_Procurator"})
		UnitUtil.SetLockList("EMPIRE", {"Lancer_Frigate_Prototype"})

	--military enhancement
	elseif option == "SENATE_CHOICE_MIL_ENH_MOTHMA" then
		Story_Event("MILITARY_ENHANCEMENT_MOTHMA")
		StoryUtil.SpawnAtSafePlanet("BOTHAWUI", self.RepublicPlayer, self.Active_Planets, {"Bail_Organa_Team","Raymus_Tantive"})
	elseif option == "SENATE_CHOICE_MIL_ENH_PESTAGE" then
		Story_Event("MILITARY_ENHANCEMENT_PESTAGE")
		UnitUtil.SetLockList("EMPIRE", {"DUMMY_RESEARCH_CLONE_TROOPER_II"})

	--order 6x
	elseif option == "SENATE_CHOICE_ORDER_6X_AI" then
		if TestValid(FindPlanet("CORUSCANT")) then
			if FindPlanet("CORUSCANT").Get_Owner() ~= self.RepublicPlayer then
				self:SenateChoiceMade("SENATE_CHOICE_ORDER_6X_ORDER_65")
				return
			end
		end

		self:ExecuteOrder66("DespawnJedi")
		self:ExecuteOrder66("MISSION_KNIGHTFALL_SKIP")
		self:on_construction_finished("empty", "DUMMY_KDY_CONTRACT")

		Story_Event("EXECUTE_ORDER_66_NON_REPUBLIC")
	elseif option == "SENATE_CHOICE_ORDER_6X_ORDER_65" then
		if self.RepublicPlayer.Is_Human() then
			Story_Event("EXECUTE_ORDER_65")
		end

		self.Order6XExecuted = true
		GlobalValue.Set("STORYLINE", "ORDER_65_STORY")

		UnitUtil.SetLockList("EMPIRE", {"Tallon_Battalion_Upgrade", "Neutron_Star"})

		UnitUtil.DespawnList({"Sate_Pestage"})
		
		crossplot:publish("SENATE_CHOICE_MADE", "ORDER_65_STAFF_CHANGES")

		GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_MOTHMA")
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", self.RepublicPlayer, self.Active_Planets, {"Mon_Mothma_Team","Garm_Team","Bail_Organa_Team","Raymus_Tantive"})
	elseif option == "SENATE_CHOICE_ORDER_6X_ORDER_66" then
		Story_Event("EXECUTE_ORDER_66")

	--sector governance
	elseif option == "SENATE_CHOICE_SEC_GOV_MOTHMA" then
		Story_Event("SECTOR_GOVERNANCE_MOTHMA")
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", self.RepublicPlayer, self.Active_Planets, {"Giddean_Team"})
		UnitUtil.SetLockList("EMPIRE", {"Tallon_Battalion_Upgrade", "Neutron_Star"})
	elseif option == "SENATE_CHOICE_SEC_GOV_PESTAGE" then
		Story_Event("SECTOR_GOVERNANCE_PESTAGE")
		crossplot:publish("SENATE_CHOICE_MADE", "SECTOR_GOVERNANCE_DECREE_SUPPORTED")

	--not actually choices

	--special taskforce funding
	elseif option == "SENATE_APPROVAL_TASKFORCE" then
		crossplot:publish("SENATE_CHOICE_MADE", "SPECIAL_TASK_FORCE_FUNDED")
		crossplot:publish("COMMAND_STAFF_RETURN", {"Tenant"}, 1)
		crossplot:publish("COMMAND_STAFF_RETURN", {"Luminara"}, 3)
		crossplot:publish("COMMAND_STAFF_RETURN", {"Gree_Clone"}, 4)

		StoryUtil.SpawnAtSafePlanet("KALIIDA_NEBULA", self.RepublicPlayer, self.Active_Planets, {"Luminara_Unduli_Delta_Team", "Gree_Team", "Tenant_Venator"})
		
		crossplot:publish("COMMAND_STAFF_CENSUS", "empty")
	--blissex research funding
	elseif option == "SENATE_APPROVAL_BLISSEX" then
		StoryUtil.SpawnAtSafePlanet("HANDOOINE", self.RepublicPlayer, self.Active_Planets, {"Mulleen_Imperator"})

	--core worlds security act
	elseif option == "SENATE_APPROVAL_CORE_SECURITY" then
		crossplot:publish("SENATE_CHOICE_MADE", "SECTOR_GOVERNANCE_DECREE_SUPPORTED")
	end
end

function GovernmentRepublic:ExecuteOrder66(stage)
	if stage == "DespawnJedi" then
		self.Order6XExecuted = true
		GlobalValue.Set("STORYLINE", "ORDER_66_STORY")
		GlobalValue.Set("ORDER_66",true)
		
		UnitUtil.SetLockList("EMPIRE", {"Jedi_Temple", "Jedi_Enclave", "Republic_Jedi_Knight_Company", "View_Council", "Extra_Council_Slot"}, false)
	
		UnitUtil.DespawnList({
			"YODA", "YODA2",
			"MACE_WINDU", "MACE_WINDU2",
			"PLO_KOON",
			"KIT_FISTO", "KIT_FISTO2",
			"KI_ADI_MUNDI", "KI_ADI_MUNDI2",
			"LUMINARA_UNDULI", "LUMINARA_UNDULI2",
			"BARRISS_OFFEE","BARRISS_OFFEE2",
			"AHSOKA","AHSOKA2",
			"AAYLA_SECURA","AAYLA_SECURA2",
			"SHAAK_TI","SHAAK_TI2",
			"RAHM_KOTA",
			"NEJAA_HALCYON",
			"KNOL_VENNARI",
			"OBI_WAN", "OBI_WAN2",
			"ANAKIN", "ANAKIN2",
			"CIN_DRALLIG", "SERRA_KETO", "JOCASTA_NU", "LADDINARE_TORBIN", "OPPO_RANCISIS", --Future proofing/support for Custom heroes
			"JEDI_TEMPLE",
			"JEDI_ENCLAVE",
			"REPUBLIC_JEDI_KNIGHT_COMPANY_DUMMY",
			"KOTAS_MILITIA_TROOPER_COMPANY_DUMMY",
			"ANTARIAN_RANGER_COMPANY_DUMMY"
		})
		
		local SPHA_T_Ven = "Venator_SPHA_T" 
		if TestValid(Find_First_Object(SPHA_T_Ven)) then
			local SPHA_T_List = Find_All_Objects_Of_Type(SPHA_T_Ven)
			if table.getn(SPHA_T_List) ~= 0 then
				for _, despawn_target in pairs(SPHA_T_List) do
					UnitUtil.ReplaceAtLocation(despawn_target, "Venator_Star_Destroyer")
				end
			end
		end

		crossplot:publish("SENATE_CHOICE_MADE", "ORDER_66_STAFF_CHANGES")

	elseif stage == "PromptKnightfall" then
		crossplot:publish("POPUPEVENT", "MISSION_KNIGHTFALL", {"PLAY","SKIP"}, { },
				{ }, { },
				{ }, { },
				{ }, { },
				"MISSION_KNIGHTFALL_OPTION")

	elseif stage == "MISSION_KNIGHTFALL_PLAY" then
		self.GroundStructureSnapshot = SaveGroundStructures(FindPlanet("Coruscant"))
		self.SpaceStructureSnapshot = SaveSpaceStructures(FindPlanet("Coruscant"))
		Story_Event("REP_KNIGHTFALL_TACTICAL")

	elseif stage == "PostTacticalKnightfall" then
		RestoreGroundStructures(FindPlanet("Coruscant"),self.GroundStructureSnapshot)
		RestoreSpaceStructures(FindPlanet("Coruscant"),self.SpaceStructureSnapshot)

		if GlobalValue.Get("TACTICAL_KNIGHTFALL_DEFEAT") == true then
			self:jedi_rebellion()
			StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Vader_Team"})
		else
			StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Anakin_Darkside_Team"})
			StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Laddinare_Torbin_Empire_Team"})
		end

		self:ExecuteOrder66("SpawnEmpire")

	elseif stage == "MISSION_KNIGHTFALL_SKIP" then
		self:jedi_rebellion()
		--StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Vader_Team"})
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Anakin_Darkside_Team"}) --test

		self:ExecuteOrder66("SpawnEmpire")

	elseif stage == "SpawnEmpire" then
		GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_EMPEROR_PALPATINE")

		UnitUtil.SetLockList("EMPIRE", {"Gamma_ATR_6_Group", "Yularen_Resolute_Upgrade_Invincible", "Yularen_Integrity_Upgrade_Invincible"})

		StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Emperor_Palpatine_Team"})
	end
end

function GovernmentRepublic:jedi_rebellion()
	ChangePlanetOwnerAndRetreat(FindPlanet("Kashyyyk"), p_independent, FindPlanet("Coruscant"))

	local spawn_list = {
		"Republic_Jedi_Knight_Company",
		"Antarian_Ranger_Company",
		"Antarian_Ranger_Company",
		"AT_XT_Company",
		"Republic_TX130S_Company",
		"Republic_AT_AP_Walker_Company",
		"Revolt_PDF_HQ_Rural",
		"Jedi_Enclave",
		"Jedi_Ground_Barracks",
		"E_Ground_Heavy_Vehicle_Factory",
		"Ground_Planetary_Shield",
	}

	if GlobalValue.Get("TACTICAL_KNIGHTFALL_TORBIN_DEFEATED") ~= true then
		table.insert(spawn_list,"Laddinare_Torbin_Team")
	else
		table.insert(spawn_list,"Republic_TX130S_Company")
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Laddinare_Torbin_Empire_Team"})
	end

	if GlobalValue.Get("TACTICAL_KNIGHTFALL_JOCASTA_DEFEATED") ~= true then
		table.insert(spawn_list,"Jocasta_Nu_Team")
	else
		table.insert(spawn_list,"Antarian_Ranger_Company")
	end

	table.insert(spawn_list,"Serra_Keto_Team")
	table.insert(spawn_list,"Cin_Drallig_Team")

	KashyyykSpawn = SpawnList(spawn_list, FindPlanet("Kashyyyk"), p_independent, false, false)
end

function GovernmentRepublic:on_construction_finished(planet, game_object_type_name)
	--Logger:trace("entering GovernmentRepublic:on_construction_finished")
	if game_object_type_name == "OPTION_CYCLE_CLONES" then
		self:Option_Cycle_Clone_Colour()

	elseif game_object_type_name == "OPTION_CYCLE_REP_FLEET" then
		self:Option_Cycle_Fleet_Skin()

	elseif game_object_type_name == "DUMMY_RESEARCH_VENATOR" then
		crossplot:publish("UPDATE_MOBILIZATION","VENATOR_RESEARCH")

	elseif game_object_type_name == "DUMMY_KDY_CONTRACT" then
		if self.RepublicPlayer.Is_Human() then
			Story_Event("KDY_CONTRACT_COMPLETED")
		end

		crossplot:publish("UPDATE_MOBILIZATION","KDY_CONTRACT")
		UnitUtil.SetLockList("EMPIRE", {"TARKIN_EXECUTRIX_UPGRADE", "ANAKIN_DARKSIDE_UPGRADE_EXACTOR", "VADER_UPGRADE_EXACTOR"})
		Find_Player("Empire").Unlock_Tech(Find_Object_Type("Tarkin_Executrix_Upgrade"))
		StoryUtil.SpawnAtSafePlanet("CORUSCANT", Find_Player("Empire"), StoryUtil.GetSafePlanetTable(), {"Mulleen_Imperator"})

	elseif game_object_type_name == "DUMMY_RESEARCH_CLONE_TROOPER_II" then
		if self.gc_name == "RIMWARD" then
			UnitUtil.DespawnList({"DUMMY_RESEARCH_CLONE_TROOPER_II"})

			UnitUtil.SetLockList("EMPIRE", {"CLONETROOPER_PHASE_ONE_COMPANY", "REPUBLIC_74Z_BIKE_COMPANY", "ARC_PHASE_ONE_COMPANY"}, false)
			UnitUtil.SetLockList("EMPIRE", {"CLONETROOPER_PHASE_TWO_COMPANY", "REPUBLIC_BARC_COMPANY", "ARC_PHASE_TWO_COMPANY"})
			crossplot:publish("CLONE_UPGRADES", "empty")
			GlobalValue.Set("CURRENT_CLONE_PHASE", 2)
		end
		if GlobalValue.Get("ARC_LIFETIME_LIMIT") == 0 then
			UnitUtil.SetLockList("EMPIRE", {"ARC_PHASE_TWO_COMPANY"}, false)
		end
	elseif game_object_type_name == "ARC_PHASE_ONE_COMPANY" or game_object_type_name == "ARC_PHASE_TWO_COMPANY" then -- FotR_Enhanced
		local liftime = GlobalValue.Get("ARC_LIFETIME_LIMIT")
		liftime = liftime -1
		if liftime <= 0 then
			if not game_object_type_name.Is_Build_Locked(self.RepublicPlayer) then
				UnitUtil.SetLockList(game_object_type_name)
				return
			end
			local dummy_name = game_object_type_name.."_DUMMY"
			self.RepublicPlayer.Give_Money(game_object_type_name.Get_Type().Get_Build_Cost())
			local last_spawned = Find_First_Object(dummy_name)
			last_spawned.Despawn()
		end
		GlobalValue.Set("ARC_LIFETIME_LIMIT", liftime)
	end
end

function GovernmentRepublic:Option_Cycle_Clone_Colour()
	--Logger:trace("entering GovernmentRepublic:Option_Cycle_Clone_Colour")

	UnitUtil.DespawnList({"OPTION_CYCLE_CLONES"})
	local clone_skin = GlobalValue.Get("CLONE_DEFAULT")
	clone_skin = clone_skin + 1
	if clone_skin > 9 then
		clone_skin = 0
	end
	GlobalValue.Set("CLONE_DEFAULT", clone_skin)
	--convert from zero-indexed skin list to one-indexed table numeric key
	clone_skin = clone_skin + 1
	StoryUtil.ShowScreenText(self.CloneSkins[clone_skin], 5)
end

function GovernmentRepublic:Option_Cycle_Fleet_Skin()
	--Logger:trace("entering GovernmentRepublic:Option_Cycle_Fleet_Skin")

	UnitUtil.DespawnList({"OPTION_CYCLE_REP_FLEET"})
	self.FleetID = self.FleetID + 1
	if self.FleetID > 4 then
		self.FleetID = 0
	end
	--convert from zero-indexed skin list to one-indexed table numeric key
	GlobalValue.Set("FLEET_EMBLEM", self.FleetValues[self.FleetID + 1])
	StoryUtil.ShowScreenText(self.FleetSkins[self.FleetID + 1], 5)
end

function GovernmentRepublic:UpdateDisplay(favour_table, market_name, market_list)
	--Logger:trace("entering GovernmentRepublic:UpdateDisplay")
	local plot = Get_Story_Plot("Conquests\\Player_Agnostic_Plot.xml")
	local government_display_event = plot.Get_Event("Government_Display")

	if self.RepublicPlayer.Is_Human() then
		government_display_event.Clear_Dialog_Text()

		government_display_event.Set_Reward_Parameter(1, "EMPIRE")

		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CURRENT_APPROVAL", favour_table.favour)
		local current_chief_of_state = GlobalValue.Get("ChiefOfState")
		if current_chief_of_state == "DUMMY_CHIEFOFSTATE_EMPEROR_PALPATINE" then
			government_display_event.Add_Dialog_Text("SOVEREIGN AND PROTECTOR OF THE REPUBLIC: His Imperial Majesty, Emperor Palpatine")
		else
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CURRENT_CHANCELLOR", Find_Object_Type(GlobalValue.Get("ChiefOfState")))
		end

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_NONE")

		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_KDY_OVERVIEW_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_KDY_OVERVIEW")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_NONE")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_KDY_LIST_01")
		for i, ship in ipairs(SortKeysByElement(market_list,"order","asc")) do
			local ship_data = market_list[ship]
			if (ship_data.amount > 0) or ((ship_data.locked == false) and (ship_data.gc_locked == false)) then
				government_display_event.Add_Dialog_Text(ship_data.readable_name .. ": "..tostring(ship_data.amount) .." - [ ".. tostring(ship_data.chance/10) .."%% ] ")
			end
		end

		government_display_event.Add_Dialog_Text("TEXT_NONE")
		government_display_event.Add_Dialog_Text("Currently Unavailable:")
		for i, ship in ipairs(SortKeysByElement(market_list,"order","asc")) do
			local ship_data = market_list[ship]
			if (ship_data.amount == 0) and (ship_data.locked == true) and (ship_data.gc_locked == false) then
				government_display_event.Add_Dialog_Text(ship_data.readable_name .." - "..ship_data.text_requirement)
			end
		end

		government_display_event.Add_Dialog_Text("TEXT_NONE")

		local admiral_list = GlobalValue.Get("REP_MOFF_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_MOFF_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end
		local admiral_list = GlobalValue.Get("REP_ADMIRAL_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_ADMIRAL_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end
		local admiral_list = GlobalValue.Get("REP_COUNCIL_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_COUNCIL_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end
		local admiral_list = GlobalValue.Get("REP_GENERAL_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_GENERAL_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end
		local admiral_list = GlobalValue.Get("REP_COMMANDO_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_COMMANDO_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end
		local admiral_list = GlobalValue.Get("REP_CLONE_LIST")
		if admiral_list ~= nil then
			if table.getn(admiral_list) > 0 then
				government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
				government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CLONE_LIST")

				for index, obj in pairs(admiral_list) do
					government_display_event.Add_Dialog_Text(obj)
				end
			end
		end

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_NONE")

		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_FUNCTION")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_MOD_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BASE1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BASE2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BASE3")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BASE4")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BASE5")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_MOD_CONQUEST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_MOD_MISSION")

		government_display_event.Add_Dialog_Text("TEXT_NONE")

		if self.gc_name == "PROGRESSIVE" or self.gc_name == "FTGU" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_65_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_65_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_65_2")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_65_3")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_2")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_3")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_4")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_5")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_KUAT_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ORDER_66_KUAT_2")

		elseif self.gc_name == "MALEVOLENCE" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_SPECIAL_TASKFORCE_FUNDING_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_SPECIAL_TASKFORCE_FUNDING_1")

		elseif self.gc_name == "RIMWARD" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_INCREASED_MILITARY_BILL_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_INCREASED_MILITARY_BILL_1")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_2")

		elseif self.gc_name == "TENNUUTTA" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BLISSEX_RESEARCH_FUNDING_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_BLISSEX_RESEARCH_FUNDING_1")

		elseif self.gc_name == "KNIGHT_HAMMER" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ENHANCED_SECURITY_SUPPORT_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ENHANCED_SECURITY_SUPPORT_1")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ENHANCED_SECURITY_PREVENT_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_ENHANCED_SECURITY_PREVENT_1")

		elseif self.gc_name == "DURGES_LANCE" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_KUAT_POWER_STRUGGLE_KUAT_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_KUAT_POWER_STRUGGLE_KUAT_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_KUAT_POWER_STRUGGLE_KUAT_2")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_KUAT_POWER_STRUGGLE_ONARA_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_KUAT_POWER_STRUGGLE_ONARA_1")

		elseif self.gc_name == "FOEROST" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CORE_WORLDS_SECURITY_ACT_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CORE_WORLDS_SECURITY_ACT_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CORE_WORLDS_SECURITY_ACT_2")

		elseif self.gc_name == "OUTER_RIM_SIEGES" then
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_CHOICE_REWARD_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_SECTOR_GOVERNANCE_DECREE_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_SECTOR_GOVERNANCE_DECREE_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_SECTOR_GOVERNANCE_DECREE_2")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_HEADER")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_1")
			government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_APPROVAL_REDUCED_MILITARY_BILL_2")
		end

		government_display_event.Add_Dialog_Text("TEXT_NONE")

		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_SECTORFORCES_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_SECTORFORCES")

		government_display_event.Add_Dialog_Text("TEXT_NONE")

		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_0")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_3")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_4")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_5")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_HERO_SYSTEM_6")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_HAUSER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_WESSEL")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_SEERDON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_TARKIN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_WESSEX")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_GRANT")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_VORRU")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_BYLUIR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_TRACHTA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_RAVIK")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_PRAJI")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_MOFF_THERBON")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_DALLIN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_MAARISA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_PELLAEON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_TALLON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_BARAKA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_MARTZ")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_GRUMBY")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_YULAREN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_COBURN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_DENIMOOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_DRON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_FORRAL")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_WIELER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_KILIAN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_DAO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_AUTEM")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_TENANT")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_BLOCK") --FotR_Enhanced
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_SCREED")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_DODONNA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_ADMIRAL_PARCK")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_YODA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_MACE")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_PLO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_KIT")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_AAYLA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_MUNDI")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_LUMINARA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_BARRISS")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_AHSOKA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_SHAAK")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_KOTA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_HALCYON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COUNCIL_OPPO") --FotR_Enhanced

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_GRUNGER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_KLIGSON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_ROM")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_GENTIS")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_GEEN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_OZZEL")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_ROMODI")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_SOLOMAHAL")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_JAYFON")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_GENERAL_JESRA")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_ALPHA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_FORDO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_GREGOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_VOCA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_DELTA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_OMEGA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_ORDO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_ADEN")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_COMMANDO_PRUDII") --FotR_Enhanced

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_LIST")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_REX")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_APPO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_CODY")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_BLY")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_DEVISS")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_WOLFFE")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_GREE")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_BACARA")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_JET")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_NEYO")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_71")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_KELLER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_FAIE")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_VILL")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_BOW")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_CLONE_GAFFA")

		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		government_display_event.Add_Dialog_Text("TEXT_NONE")
		government_display_event.Add_Dialog_Text("TEXT_NONE")
		government_display_event.Add_Dialog_Text("TEXT_NONE")

		Story_Event("GOVERNMENT_DISPLAY")
	end
end

return GovernmentRepublic

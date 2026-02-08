require("deepcore/std/class")
require("eawx-plugins/government-manager/GovernmentRepublic")
require("eawx-plugins/government-manager/GovernmentCIS")
require("eawx-plugins/government-manager/GovernmentHutts")
require("eawx-plugins/government-manager/GovernmentFavour")
require("eawx-plugins/government-manager/ShipMarket")

---@class GovernmentManager
GovernmentManager = class()

function GovernmentManager:new(gc, id, gc_name)
    self.REPGOV = GovernmentRepublic(gc, id, gc_name)
    self.CISGOV = GovernmentCIS(gc, id, gc_name)
    self.FAVOUR = GovernmentFavour(gc, gc_name)
    self.HUTTGOV = GovernmentHutts(gc, id)
    self.SHIPMARKET = ShipMarket(gc)

    self.human = Find_Player("local")
    self.HuttPlayer = Find_Player("Hutt_Cartels")
    self.CISPlayer = Find_Player("Rebel")

    if gc_name == nil then
        return
    end

    self.gc_name = gc_name

    self.market_adjustments = require("ShipMarketAdjustmentsLibrary")
    self:Favour_Initialize()
    self:Market_Initialize()

    crossplot:subscribe("UPDATE_MOBILIZATION", self.Market_Update, self)
    crossplot:subscribe("SHADOW_COLLECTIVE_AVAILABLE", self.Shadow_Collective_Formation, self)
    crossplot:subscribe("TEMPEST_RESEARCH_FINISHED", self.Hutt_Research_Tempest, self)
    crossplot:subscribe("KOSSAK_AVAILABLE", self.Hutt_Militarization_Kossak, self)
    crossplot:subscribe("UBRIKKIAN_CRUISER_AVAILABLE", self.Hutt_Militarization_Ubrikkian, self)
    crossplot:subscribe("HUTT_EMPIRE_AVAILABLE", self.Hutt_Empire_Formation, self)
    crossplot:subscribe("UPDATE_GOVERNMENT", self.UpdateDisplay, self)
end

function GovernmentManager:update()
    self.REPGOV:update()
    self.FAVOUR:update()
    self.SHIPMARKET:update()
    self.HUTTGOV:update()
end

function GovernmentManager:Favour_Initialize()
    GCFavourTable = {
        ["FTGU"] =              {CISFavour = 20, RepFavour = 50},
        ["CUSTOM"] =            {CISFavour = 20, RepFavour = 50},
        ["PROGRESSIVE"] =       {CISFavour =  0, RepFavour = 50},
        ["MALEVOLENCE"] =       {CISFavour = 85, RepFavour = 85},
        ["RIMWARD"] =           {CISFavour = 70, RepFavour = 85},
        ["TENNUUTTA"] =         {CISFavour = 80, RepFavour = 85},
        ["KNIGHT_HAMMER"] =     {CISFavour = 70, RepFavour = 85},
        ["DURGES_LANCE"] =      {CISFavour = 70, RepFavour = 85},
        ["FOEROST"] =           {CISFavour =  0, RepFavour = 85},
        ["OUTER_RIM_SIEGES"] =  {CISFavour = 85, RepFavour = 85},
    }

    FavourModifierTable = {
        ["ERA_1"] =             {CISModifier = 30, RepModifier =  5},
        ["ERA_2"] =             {CISModifier = 40, RepModifier = 10},
        ["ERA_3"] =             {CISModifier = 50, RepModifier = 10},
        ["ERA_4"] =             {CISModifier = 60, RepModifier = 15},
        ["ERA_5"] =             {CISModifier = 70, RepModifier = 15},
    }

    if self.gc_name == "PROGRESSIVE" then
        local SizeModifier = 10
        local all_planets = FindPlanet.Get_All_Planets()

        if table.getn(all_planets) < 100 then
            GCFavourTable[self.gc_name].CISFavour = GCFavourTable[self.gc_name].CISFavour + SizeModifier
            GCFavourTable[self.gc_name].RepFavour = GCFavourTable[self.gc_name].RepFavour + SizeModifier
        end

        GCFavourTable[self.gc_name].CISFavour = GCFavourTable[self.gc_name].CISFavour + FavourModifierTable["ERA_".. GlobalValue.Get("CURRENT_ERA")].CISModifier
        GCFavourTable[self.gc_name].RepFavour = GCFavourTable[self.gc_name].RepFavour + FavourModifierTable["ERA_".. GlobalValue.Get("CURRENT_ERA")].RepModifier
    end

    self.FAVOUR:AdjustFavour("SECTOR_FORCES", GCFavourTable[self.gc_name].RepFavour)
    for group, data in pairs(self.FAVOUR.FavourTables["REBEL"]) do
        self.FAVOUR:AdjustFavour(group, GCFavourTable[self.gc_name].CISFavour)
    end
end

function GovernmentManager:Market_Initialize() -- FotR_Enhanced ; Clone Market Era Handling
    local StartingEra = GlobalValue.Get("CURRENT_ERA")

    --first, start date-based adjustments
    if StartingEra == 2 then
        self:Market_Update("CLONE_WAR_BEGUN")
    elseif StartingEra == 3 then
        self:Market_Update("CLONE_WAR_BEGUN")
        self:Market_Update("VENATOR_RESEARCH")
    elseif StartingEra >= 4 then
        self:Market_Update("CLONE_WAR_BEGUN")
        self:Market_Update("VENATOR_RESEARCH")
        self:Market_Update("PHASE_TWO_RESEARCH")
    end

    --second, GC-specific adjustments
    if self.market_adjustments[self.gc_name] ~= nil then
        self:Market_Update(self.gc_name)
    end
end

function GovernmentManager:Market_Update(tag)
    --KDY Contract stops Venator Research from making market changes
    if (tag == "VENATOR_RESEARCH") and (self.REPGOV.KDY_Contract == true) then
        return
    end

    if self.market_adjustments[tag] then
        if self.market_adjustments[tag].adjustment_lists then
            self.SHIPMARKET:adjust_ship_chance(self.market_adjustments[tag].adjustment_lists)
        end
        if self.market_adjustments[tag].lock_lists then
            self.SHIPMARKET:lock_or_unlock_options(self.market_adjustments[tag].lock_lists)
        end
        if self.market_adjustments[tag].requirement_lists then
            self.SHIPMARKET:adjust_ship_requirements(self.market_adjustments[tag].requirement_lists)
        end
    end
end

function GovernmentManager:Shadow_Collective_Formation()
    --Logger:trace("entering GovernmentManager:Shadow_Collective_Formation")
    if self.HuttPlayer.Is_Human() then
        if self.gc_name ~= "KNIGHT_HAMMER" then
            GlobalValue.Set("SHADOW_COLLECTIVE",true)
            StoryUtil.Multimedia("TEXT_CONQUEST_GOVERNMENT_HUTTS_SHADOW_COLLECTIVE_FORMATION", 20, nil, "Generic_Sith_Loop", 0)
        end
    end
end

function GovernmentManager:Hutt_Research_Tempest()
    GlobalValue.Set("TEMPEST_ENABLED",true)
end

function GovernmentManager:Hutt_Militarization_Kossak()
    GlobalValue.Set("KOSSAK_ENABLED",true)
end

function GovernmentManager:Hutt_Militarization_Ubrikkian()
    GlobalValue.Set("UBRIKKIAN_ENABLED",true)
end

function GovernmentManager:Hutt_Empire_Formation()
    --Logger:trace("entering GovernmentManager:Hutt_Empire_Formation")
    if self.HuttPlayer.Is_Human() then
        StoryUtil.Multimedia("TEXT_CONQUEST_GOVERNMENT_HUTTS_EMPIRE_FORMATION", 20, nil, "Jabba_Loop", 0)
    end
end

function GovernmentManager:UpdateDisplay()
    if self.human == Find_Player("Hutt_Cartels") then
        self.HUTTGOV:UpdateDisplay(self.FAVOUR.FavourTables["HUTT_CARTELS"])
    elseif self.human == Find_Player("Rebel") then
        self.CISGOV:UpdateDisplay(self.FAVOUR.FavourTables["REBEL"])
    elseif self.human == Find_Player("Empire") then -- FotR_Enhanced ; may need to refactor
        self.REPGOV:UpdateDisplay(self.FAVOUR.FavourTables["EMPIRE"]["SECTOR_FORCES"],self.SHIPMARKET.market_types["EMPIRE"]["KDY_MARKET"].market_name, {self.SHIPMARKET.market_types["EMPIRE"]["KDY_MARKET"].list, self.SHIPMARKET.market_types["EMPIRE"]["CLONE_MARKET"].list})
    end
end

return GovernmentManager

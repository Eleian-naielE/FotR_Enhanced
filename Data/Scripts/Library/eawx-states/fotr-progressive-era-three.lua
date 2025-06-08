require("eawx-util/StoryUtil")
require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")
require("SetFighterResearch")

return {
    on_enter = function(self, state_context)
        --Logger:trace("entering fotr-progressive-era-three:on_enter")
        GlobalValue.Set("CURRENT_ERA", 3)
     
        self.Active_Planets = StoryUtil.GetSafePlanetTable()
        self.entry_time = GetCurrentTime()
        self.StaticFleets = false
        self.AI_Active = true
        self.plot = Get_Story_Plot("Conquests\\Events\\EventLogRepository.xml")

        if self.entry_time <= 5 then
            if Find_Player("local") == Find_Player("Empire") then
                StoryUtil.Multimedia("TEXT_STORY_INTRO_PROGRESSIVE_REPUBLIC_PALPATINE_ERA_3", 15, nil, "PalpatineFotR_Loop", 0)
                Story_Event("CLONE_WARS_21BBY_REPUBLIC_START")
            elseif Find_Player("local") == Find_Player("Rebel") then
                StoryUtil.Multimedia("TEXT_STORY_INTRO_PROGRESSIVE_CIS_DOOKU_ERA_3", 15, nil, "Dooku_Loop", 0)
                Story_Event("CLONE_WARS_21BBY_CONFEDERACY_START")
            elseif Find_Player("local") == Find_Player("Hutt_Cartels") then
                StoryUtil.Multimedia("TEXT_STORY_INTRO_PROGRESSIVE_HUTT_CARTELS_JABBA_ERA_3", 15, nil, "Jabba_Loop", 0)
                Story_Event("CLONE_WARS_21BBY_HUTT_CARTELS_START")
            end

            self.StaticFleets = true
            self.AI_Active = false
            self.Starting_Spawns = require("eawx-mod-fotr/spawn-sets/EraThreeStartSet")
            for faction, herolist in pairs(self.Starting_Spawns) do
                for planet, spawnlist in pairs(herolist) do
                    StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
                end
            end

            Find_Player("Rebel").Lock_Tech(Find_Object_Type("Grievous_Upgrade_Recusant_To_Malevolence"))
            Find_Player("Rebel").Lock_Tech(Find_Object_Type("Grievous_Upgrade_Providence_To_Malevolence"))

        else
            self.Starting_Spawns = require("eawx-mod-fotr/spawn-sets/EraThreeProgressSet")
            for faction, herolist in pairs(self.Starting_Spawns) do
                for planet, spawnlist in pairs(herolist) do
                    StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
                end
            end
            
            UnitUtil.ReplaceAtLocation("Yoda", "Yoda_Eta_Team")
            UnitUtil.ReplaceAtLocation("Mace_Windu", "Mace_Windu_Eta_Team")
            UnitUtil.ReplaceAtLocation("Obi_Wan", "Obi_Wan_Eta_Team")
            UnitUtil.ReplaceAtLocation("Anakin", "Anakin_Eta_Team")
            UnitUtil.ReplaceAtLocation("Kit_Fisto", "Kit_Fisto_Eta_Team")
            UnitUtil.ReplaceAtLocation("Aayla_Secura", "Aayla_Secura_Eta_Team")
            UnitUtil.ReplaceAtLocation("Ki_Adi_Mundi", "Ki_Adi_Mundi_Eta_Team")
            UnitUtil.ReplaceAtLocation("Luminara_Unduli", "Luminara_Unduli_Eta_Team")
            UnitUtil.ReplaceAtLocation("Barriss_Offee", "Barriss_Offee_Eta_Team")
            UnitUtil.ReplaceAtLocation("Shaak_Ti", "Shaak_Ti_Eta_Team")
            UnitUtil.ReplaceAtLocation("Ahsoka", "Ahsoka_Eta_Team")
            
            crossplot:publish("ERA_TRANSITION", 3)
        end
    end,
    on_update = function(self, state_context)
        local current = GetCurrentTime() - self.entry_time
        local player = nil
        local p_human = Find_Player("local")
        if current >= 7 and self.AI_Active == false then
            self.AI_Active = true
            crossplot:publish("INITIALIZE_AI", "empty")
        end
        if current >= 10 and self.StaticFleets == true then
            self.StaticFleets = false
            local static_spawns = require("eawx-mod-fotr/spawn-sets/EraThreeStaticFleetSet")

            for metafaction, factions in pairs(static_spawns) do
                if p_human ~= Find_Player(metafaction) then
                    for faction, unitlist in pairs(factions) do
                        player = Find_Player(faction)
                        for planet, spawnlist in pairs(unitlist) do
                            if self.Active_Planets[planet] then
                                StoryUtil.SpawnAtSafePlanet(planet, player, self.Active_Planets, spawnlist, false)  
                            end
                        end
                    end
                end
            end

            crossplot:publish("CONQUER_RENDILI", "empty")
            crossplot:publish("VENATOR_RESEARCH_FINISHED", "empty")
            crossplot:publish("PROVIDENCE_RESEARCH_FINISHED", "empty")
        end
    end,
    on_exit = function(self, state_context)
    end
}
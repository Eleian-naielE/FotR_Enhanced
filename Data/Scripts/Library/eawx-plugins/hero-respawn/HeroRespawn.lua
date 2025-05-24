--**************************************************************************************************
--*    _______ __                                                                                  *
--*   |_     _|  |--.----.---.-.--.--.--.-----.-----.                                              *
--*     |   | |     |   _|  _  |  |  |  |     |__ --|                                              *
--*     |___| |__|__|__| |___._|________|__|__|_____|                                              *
--*    ______                                                                                      *
--*   |   __ \.-----.--.--.-----.-----.-----.-----.                                                *
--*   |      <|  -__|  |  |  -__|     |  _  |  -__|                                                *
--*   |___|__||_____|\___/|_____|__|__|___  |_____|                                                *
--*                                   |_____|                                                      *
--*                                                                                                *
--*                                                                                                *
--*       File:              HeroRespawn.lua                                                     *
--*       File Created:      Monday, 24th February 2020 02:19                                      *
--*       Author:            [TR] Jorritkarwehr                                                             *
--*       Last Modified:     Monday, 24th February 2020 02:34                                      *
--*       Modified By:       [TR] Jorritkarwehr                                                             *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("PGSpawnUnits")
require("deepcore/std/class")
require("eawx-util/StoryUtil")
require("PGDebug")
require("SetFighterResearch")

HeroRespawn = class()

function HeroRespawn:new(herokilled_finished_event, human_player)
	self.p_CIS = Find_Player("Rebel")
    herokilled_finished_event:attach_listener(self.on_galactic_hero_killed, self)
	self.durge_chance = 105
	self.dooku_second_chance_used = false
end

function HeroRespawn:on_galactic_hero_killed(hero_name, owner)
    --Logger:trace("entering HeroRespawn:on_galactic_hero_killed")
    if hero_name == "GENERAL_GRIEVOUS" or hero_name == "GRIEVOUS_TEAM" then
        self:check_grievous()
    elseif hero_name == "GRIEVOUS_MUNIFICENT" then
        self:spawn_grievous("Grievous_Team","GRIEVOUS_RESPAWN_BELBULLAB")
		self.p_CIS.Lock_Tech(Find_Object_Type("Grievous_Reveal_Colicoid_Swarm"))
		self.p_CIS.Lock_Tech(Find_Object_Type("Grievous_Reveal_Lucid_Voice"))
        --todo: function to assign whatever hero may have been on Grievous_Munificent to next existent host ~Mord
    elseif hero_name == "GRIEVOUS_INVISIBLE_HAND" then
        self:spawn_grievous("Grievous_Munificent","GRIEVOUS_RESPAWN_MUNIFICENT")
        Transfer_Fighter_Hero("GRIEVOUS_INVISIBLE_HAND", "GRIEVOUS_MUNIFICENT")
    elseif hero_name == "GRIEVOUS_RECUSANT" then
        self:spawn_grievous("Grievous_Munificent","GRIEVOUS_RESPAWN_MUNIFICENT")
        Transfer_Fighter_Hero("GRIEVOUS_RECUSANT", "GRIEVOUS_MUNIFICENT")
    elseif hero_name == "GRIEVOUS_MALEVOLENCE" then
        self:spawn_grievous("Grievous_Invisible_Hand","GRIEVOUS_RESPAWN_PROVIDENCE")
        Transfer_Fighter_Hero("GRIEVOUS_MALEVOLENCE", "GRIEVOUS_INVISIBLE_HAND")
    elseif hero_name == "GRIEVOUS_MALEVOLENCE_2" then
        self:spawn_grievous("Grievous_Recusant","GRIEVOUS_RESPAWN_RECUSANT")
        Transfer_Fighter_Hero("GRIEVOUS_MALEVOLENCE_2", "GRIEVOUS_RECUSANT")

    elseif hero_name == "DURGE_TEAM" then
        self:check_durge()
    elseif hero_name == "DOOKU_TEAM" then
        self:check_dooku_doppelganger()
    elseif hero_name == "TRENCH_INVINCIBLE" then
        self:start_cyber_trench_countdown()
    elseif hero_name == "ZOZRIDOR_SLAYKE_CARRACK" then
        self:slaykes_second_chance()
	elseif hero_name == "ANAKIN_DARKSIDE_TEAM" then
        self:anakins_dark_suit()
    end
end

function HeroRespawn:check_grievous()
    --Logger:trace("entering HeroRespawn:check_grievous")
    if TestValid(Find_First_Object("Grievous_Malevolence_2")) then
        Find_First_Object("Grievous_Malevolence_2").Despawn()
        self:spawn_grievous("Grievous_Recusant","GRIEVOUS_RESPAWN_RECUSANT")
        Transfer_Fighter_Hero("GRIEVOUS_MALEVOLENCE_2", "GRIEVOUS_RECUSANT")
        return
    elseif TestValid(Find_First_Object("Grievous_Malevolence")) then
        Find_First_Object("Grievous_Malevolence").Despawn()
        self:spawn_grievous("Grievous_Invisible_Hand","GRIEVOUS_RESPAWN_PROVIDENCE")
        Transfer_Fighter_Hero("GRIEVOUS_MALEVOLENCE", "GRIEVOUS_INVISIBLE_HAND")
        return
    elseif TestValid(Find_First_Object("Grievous_Invisible_Hand")) then
        Find_First_Object("Grievous_Invisible_Hand").Despawn()
        self:spawn_grievous("Grievous_Munificent","GRIEVOUS_RESPAWN_MUNIFICENT")
        Transfer_Fighter_Hero("GRIEVOUS_INVISIBLE_HAND", "GRIEVOUS_MUNIFICENT")
        return
    elseif TestValid(Find_First_Object("Grievous_Recusant")) then
        Find_First_Object("Grievous_Recusant").Despawn()
        self:spawn_grievous("Grievous_Munificent","GRIEVOUS_RESPAWN_MUNIFICENT")
        Transfer_Fighter_Hero("GRIEVOUS_RECUSANT", "GRIEVOUS_MUNIFICENT")
        return
    elseif TestValid(Find_First_Object("Grievous_Munificent")) then
        Find_First_Object("Grievous_Munificent").Despawn()
        self:spawn_grievous("Grievous_Team","GRIEVOUS_RESPAWN_BELBULLAB")
        --todo: function to assign whatever hero may have been on Grievous_Munificent to next existent host ~Mord
        return
    else
        Story_Event("GRIEVOUS_DEAD")
    end
end

function HeroRespawn:spawn_grievous(team, event)
	--Logger:trace("entering HeroRespawn:spawn_grievous")
	local respawn_grievous = StoryUtil.SpawnAtSafePlanet(nil, self.p_CIS, StoryUtil.GetSafePlanetTable(), {team})
	if respawn_grievous then
		Story_Event(event)
	end
end

function HeroRespawn:check_durge()
	--Logger:trace("entering HeroRespawn:check_durge")

	local check = GameRandom(1, 100)
	if self.durge_chance >= check then
		local planet = StoryUtil.FindFriendlyPlanet(self.p_CIS)
		if planet then
			SpawnList({"Durge_Team"}, planet, self.p_CIS, true, false)
			StoryUtil.Multimedia("TEXT_SPEECH_DURGE_RETURNS", 20, nil, "Durge_Loop", 0)
			self.durge_chance = self.durge_chance - 10
			StoryUtil.ShowScreenText("Revive chance: " .. tostring(self.durge_chance), 5)
		else
			StoryUtil.Multimedia("TEXT_SPEECH_DURGE_GONE", 20, nil, "Durge_Loop", 0)
		end
	else
		StoryUtil.Multimedia("TEXT_SPEECH_DURGE_GONE", 20, nil, "Durge_Loop", 0)
	end
end

function HeroRespawn:check_dooku_doppelganger()
	--Logger:trace("entering HeroRespawn:check_dooku_doppelganger")
	if self.dooku_second_chance_used == false then
		self.dooku_second_chance_used = true

		local respawn_dooku = StoryUtil.SpawnAtSafePlanet("SERENNO", self.p_CIS, StoryUtil.GetSafePlanetTable(),{"Dooku_Team"})
		if respawn_dooku then
			StoryUtil.Multimedia("TEXT_SPEECH_DOOKU_DOPPELGANGER_SPAWN", 15, nil, "Dooku_Loop", 0)
		end
	end
end

function HeroRespawn:slaykes_second_chance()
	--Logger:trace("entering HeroRespawn:slaykes_second_chance")
	local p_republic = Find_Player("Empire")
	local planet = StoryUtil.FindFriendlyPlanet(p_republic)
	StoryUtil.SpawnAtSafePlanet("ERIADU", p_republic, StoryUtil.GetSafePlanetTable(), {"Zozridor_Slayke_CR90"})
end

function HeroRespawn:start_cyber_trench_countdown()
	--Logger:trace("entering HeroRespawn:start_cyber_trench_countdown")
	
	Story_Event("TRENCH_COUNTDOWN_BEGINS")
end

function HeroRespawn:anakins_dark_suit()
	--Logger:trace("entering HeroRespawn:anakins_dark_suit")
	local p_republic = Find_Player("Empire")
	local planet = StoryUtil.FindFriendlyPlanet(p_republic)
	local respawn_anakin = StoryUtil.SpawnAtSafePlanet("CORUSCANT", p_republic, StoryUtil.GetSafePlanetTable(), {"Vader_Team"})
	
	if respawn_anakin then
		StoryUtil.Multimedia("TEXT_SPEECH_DARTH_VADER_SPAWN", 15, nil, "Emperor_Loop", 0)
	end
end
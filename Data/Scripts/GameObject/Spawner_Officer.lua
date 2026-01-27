--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox
--*   @Date:                2018-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Spawner_Officer.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-26T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("MinorHeroSpawner")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
    if message == OnEnter then
		if Object.Get_Planet_Location() == FindPlanet("Kamino") and GlobalValue.Get("CURRENT_ERA") > 1 then
			land_IV_list = {{"Commander_Tier_IV_Republic_74Z_Speeder_Bike_Company", "Republic_BARC_Company", false}, {"Commander_Tier_IV_Republic_BARC_Speeder_Company", "Republic_BARC_Company"}, "Commander_Tier_IV_Republic_AT_RT_Walker"}
			land_III_list = {"Commander_Tier_III_Clone_Special_Ops_Company", "Commander_Tier_III_Clone_Airborne_Trooper_Company"}
			land_II_list  = {"Commander_Tier_II_Clone_Galactic_Marine_Company", "Commander_Tier_II_Clone_Scout_Trooper_Company"}
			land_I_list  = {{"Commander_Tier_I_Clone_Phase_One_Company", "Clonetrooper_Phase_Two_Company", false}, {"Commander_Tier_I_Clone_Phase_Two_Company", "Clonetrooper_Phase_Two_Company"}, --[[{"Commander_Tier_I_ARC_Phase_One_Company", "ARC_Phase_Two_Company", false}, {"Commander_Tier_I_ARC_Phase_Two_Company", "ARC_Phase_Two_Company"}}]]
		else
			land_IV_list = {"Commander_Tier_IV_AT_TE_Walker_Company", "Commander_Tier_IV_RX200_Falchion_Company"}
			land_III_list  = {"Commander_Tier_III_Republic_ULAV_Company","Commander_Tier_III_AT_XT_Walker_Company", {"Commander_Tier_III_TX130S_Company", "Republic_TX130T_Company", false}, {"Commander_Tier_III_TX130T_Company", "Republic_TX130T_Company"}}
			land_II_list  = {"Commander_Tier_II_Special_Tactics_Trooper_Company","Commander_Tier_II_Senate_Commando_Company"}
			land_I_list  = {"Commander_Tier_I_Republic_Navy_Trooper_Company","Commander_Tier_I_Republic_Heavy_Trooper_Company"}
		end
		Register_Timer(CadetLoop, 0, {Object, true, land_I_list, land_II_list, land_III_list, land_IV_list, {}, {}})
    end
end
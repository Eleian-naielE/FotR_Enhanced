require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")

return {
    on_enter = function(self, state_context)
        self.entry_time = GetCurrentTime()

        if self.entry_time <= 5 then
            UnitUtil.SetLockList("EMPIRE", {
                "PDF_DHC",
                "DHC_Carrier",
                "Citadel_Cruiser_Group",
                "Republic_A4_Juggernaut_Company",
                "Republic_Navy_Trooper_Company",
                "Republic_Trooper_Company",
                "Special_Tactics_Trooper_Company",
                "Republic_ULAV_Company",
				"Acclamator_II",
                "HAET_Company",
                "Republic_AT_AP_Walker_Company",
                "AT_OT_Walker_Company",
                "Invincible_Cruiser",
                "Republic_Gaba18_Company",
                "AT_XT_Company",
                "Republic_Gian_Company"
            }, false)

            UnitUtil.SetLockList("REBEL", {
                "Lucrehulk_Auxiliary",
                "CIS_GAT_Company",
				"HMP_Company",
				"Destroyer_Droid_II_Company",
            }, false)

            UnitUtil.SetLockList("REBEL", {
                "Pursuer_Enforcement_Ship_Group",
                "Lucrehulk_Battleship"
            })

            UnitUtil.SetLockList("BANKING_CLAN", {
                "GAT_Company",
				"HMP_Company",
				"Destroyer_Droid_II_Company"
            }, false)

            UnitUtil.SetLockList("BANKING_CLAN", {
            })

            UnitUtil.SetLockList("TRADE_FEDERATION", {
                "GAT_Company",
				"HMP_Company",
				"Destroyer_Droid_II_Company"
            }, false)

            UnitUtil.SetLockList("TRADE_FEDERATION", {
            })

            UnitUtil.SetLockList("COMMERCE_GUILD", {
                "GAT_Company",
				"HMP_Company",
				"Destroyer_Droid_II_Company"
            }, false)

            UnitUtil.SetLockList("COMMERCE_GUILD", {
            })

            UnitUtil.SetLockList("TECHNO_UNION", {
                "GAT_Company",
				"HMP_Company",
				"Destroyer_Droid_II_Company"
            }, false)

            UnitUtil.SetLockList("TECHNO_UNION", {
                "Skakoan_Combat_Engineer_Company",
                "Marauder_Cruiser"
            })

            UnitUtil.SetLockList("HUTT_CARTELS", {

            }, false)

             UnitUtil.SetLockList("HUTT_CARTELS", {
                "Consular_Refit"
            })
        end
    end,
    on_update = function(self, state_context)
    end,
    on_exit = function(self, state_context)
    end
}

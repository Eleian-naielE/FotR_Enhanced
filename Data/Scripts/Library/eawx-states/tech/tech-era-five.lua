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
                "Invincible_Cruiser",
                "Republic_Gaba18_Company",
                "AT_XT_Company",
                "Republic_Flashblind_Company",
                "Republic_Gian_Company",
				"Republic_TX130S_Company"
            }, false)

            UnitUtil.SetLockList("EMPIRE", {
				"Republic_TX130T_Company"
            })

            UnitUtil.SetLockList("REBEL", {
                "Lucrehulk_Auxiliary",
                "CIS_GAT_Company",
                "Destroyer_Droid_I_W_Company",
                "Magna_Company"
            }, false)

            UnitUtil.SetLockList("REBEL", {
                "Pursuer_Enforcement_Ship_Group",
                "Lucrehulk_Battleship",
                "HMP_Company",
                "Destroyer_Droid_I_Q_Company",
                "Destroyer_Droid_II_Company",
                "Magna_Missile_Company"
            })

            UnitUtil.SetLockList("BANKING_CLAN", {
                "GAT_Company",
                "Destroyer_Droid_I_W_Company"
            }, false)

             UnitUtil.SetLockList("BANKING_CLAN", {
                "HMP_Company",
                "Destroyer_Droid_I_Q_Company",
                "Destroyer_Droid_II_Company"
            })

            UnitUtil.SetLockList("TRADE_FEDERATION", {
                "GAT_Company",
                "Destroyer_Droid_I_W_Company"
            }, false)

            UnitUtil.SetLockList("TRADE_FEDERATION", {
                "HMP_Company",
                "Destroyer_Droid_I_Q_Company",
                "Destroyer_Droid_II_Company"
            })

            UnitUtil.SetLockList("COMMERCE_GUILD", {
                "GAT_Company",
                "Destroyer_Droid_I_W_Company"
            }, false)

            UnitUtil.SetLockList("COMMERCE_GUILD", {
                "HMP_Company",
                "Destroyer_Droid_I_Q_Company",
                "Destroyer_Droid_II_Company"
            })

            UnitUtil.SetLockList("TECHNO_UNION", {
                "GAT_Company",
                "Destroyer_Droid_I_W_Company"
            }, false)

            UnitUtil.SetLockList("TECHNO_UNION", {
                "HMP_Company",
                "Destroyer_Droid_I_Q_Company",
                "Destroyer_Droid_II_Company",
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

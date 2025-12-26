require("PGBase")
require("PGStateMachine")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	-- prevent this from doing anything in galactic mode and skirmish
	if Get_Game_Mode() ~= "Land" or Find_First_Object("Team_00_Base_Position_Marker") then
		ScriptExit()
	end

	if message == OnEnter then
		local clone_skin = GlobalValue.Get("CLONE_DEFAULT")

		if clone_skin == nil then
			clone_skin = 0
		end

		local generics = {"Commander_Clone_P2_III","Commander_Clone_P1_III","Commander_Clone_P2_IV","Commander_Clone_P1_IV"} --Earlier in the list determines priority if multiple are present

		for _, generic in pairs(generics) do
			local unit = Find_First_Object(generic)
			if unit ~= nil then
				clone_skin = 0 --Assume paintless unless proven otherwise
				local object_name = unit.Get_Name()
				contain_check = string.find(object_name, "212th")
	 			if contain_check ~= nil then
					clone_skin = 1
				end
				contain_check = string.find(object_name, "501st")
	 			if contain_check ~= nil then
					clone_skin = 2
				end
				contain_check = string.find(object_name, "104th")
	 			if contain_check ~= nil then
					clone_skin = 3
				end
				contain_check = string.find(object_name, "327th")
	 			if contain_check ~= nil then
					clone_skin = 4
				end
				contain_check = string.find(object_name, "187th")
	 			if contain_check ~= nil then
					clone_skin = 5
				end
				contain_check = string.find(object_name, "21st")
	 			if contain_check ~= nil then
					clone_skin = 6
				end
				contain_check = string.find(object_name, "41st")
	 			if contain_check ~= nil then
					clone_skin = 7
				end
				break
			end
		end

		if Find_First_Object("Commander_71") or Find_First_Object("Commander_71_2")
		then
			clone_skin = 0
		elseif Find_First_Object("Obi_Wan") or Find_First_Object("Obi_Wan2") or Find_First_Object("Obi_Wan3")
		or Find_First_Object("Cody") or Find_First_Object("Cody2")
		or Find_First_Object("Gregor")
		then
			clone_skin = 1
		elseif Find_First_Object("Anakin") or Find_First_Object("Anakin2") or Find_First_Object("Anakin3") or Find_First_Object("Anakin_Darkside") or Find_First_Object("Vader")
		or Find_First_Object("Ahsoka") or Find_First_Object("Ahsoka2") or Find_First_Object("Ahsoka3")
		or Find_First_Object("Rex") or Find_First_Object("Rex2")
		or Find_First_Object("Appo") or Find_First_Object("Appo2")
		or Find_First_Object("Bow")
		or Find_First_Object("Vill")
		or Find_First_Object("Voca")
		or Find_First_Object("Hawk_P1_LAAT") or Find_First_Object("Hawk_P2_LAAT")
		then
			clone_skin = 2
		elseif Find_First_Object("Plo_Koon")
		or Find_First_Object("Wolffe") or Find_First_Object("Wolffe2")
		or Find_First_Object("Warthog_P1_LAAT") or Find_First_Object("Warthog_P2_LAAT")
		then
			clone_skin = 3
		elseif Find_First_Object("Aayla_Secura") or Find_First_Object("Aayla_Secura2")
		or Find_First_Object("Bly") or Find_First_Object("Bly2")
		or Find_First_Object("Deviss") or Find_First_Object("Deviss2")
		or Find_First_Object("Faie") or Find_First_Object("Oppo_Rancisis") then -- FotR_Enhanced
			clone_skin = 4
		elseif Find_First_Object("Mace_Windu") or Find_First_Object("Mace_Windu2") or Find_First_Object("Mace_Windu_AT_RT")
		then
			clone_skin = 5
		elseif Find_First_Object("Bacara") or Find_First_Object("Bacara2")
		or Find_First_Object("Ki_Adi_Mundi") or Find_First_Object("Ki_Adi_Mundi2")
		or Find_First_Object("Jet") or Find_First_Object("Jet2")
		then
			clone_skin = 6
		elseif Find_First_Object("Gree_Clone") or Find_First_Object("Gree2")
		or Find_First_Object("Luminara_Unduli") or Find_First_Object("Luminara_Unduli2")
		or Find_First_Object("Yoda") or Find_First_Object("Yoda2")
		or Find_First_Object("Barriss_Offee") or Find_First_Object("Barriss_Offee2")
		then
			clone_skin = 7
		end

		if clone_skin >= 8 then
			time_interval = 1
			if clone_skin == 9 then
				time_interval = 10
			end
			clone_skin = Simple_Mod(Dirty_Floor(GetCurrentTime()/time_interval),8)
		end

		if clone_skin == 1 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_212_LOD0")
			Hide_Sub_Object(Object, 0, "body_212_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_212_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_212_LOD1")
			Hide_Sub_Object(Object, 0, "head_212_LOD0")
			Hide_Sub_Object(Object, 0, "head_212_LOD1")
		elseif clone_skin == 2 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_501_LOD0")
			Hide_Sub_Object(Object, 0, "body_501_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_501_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_501_LOD1")
			Hide_Sub_Object(Object, 0, "head_501_LOD0")
			Hide_Sub_Object(Object, 0, "head_501_LOD1")
		elseif clone_skin == 3 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_104_LOD0")
			Hide_Sub_Object(Object, 0, "body_104_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_104_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_104_LOD1")
			Hide_Sub_Object(Object, 0, "head_104_LOD0")
			Hide_Sub_Object(Object, 0, "head_104_LOD1")
		elseif clone_skin == 4 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_327_LOD0")
			Hide_Sub_Object(Object, 0, "body_327_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_327_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_327_LOD1")
			Hide_Sub_Object(Object, 0, "head_327_LOD0")
			Hide_Sub_Object(Object, 0, "head_327_LOD1")
		elseif clone_skin == 5 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_187_LOD0")
			Hide_Sub_Object(Object, 0, "body_187_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_187_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_187_LOD1")
			Hide_Sub_Object(Object, 0, "head_187_LOD0")
			Hide_Sub_Object(Object, 0, "head_187_LOD1")
		elseif clone_skin == 6 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_21_LOD0")
			Hide_Sub_Object(Object, 0, "body_21_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_21_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_21_LOD1")
			Hide_Sub_Object(Object, 0, "head_21_LOD0")
			Hide_Sub_Object(Object, 0, "head_21_LOD1")
		elseif clone_skin == 7 then
			Hide_Sub_Object(Object, 1, "body_LOD0")
			Hide_Sub_Object(Object, 1, "body_LOD1")
			Hide_Sub_Object(Object, 1, "helmet_LOD0")
			Hide_Sub_Object(Object, 1, "helmet_LOD1")
			Hide_Sub_Object(Object, 1, "head_LOD0")
			Hide_Sub_Object(Object, 1, "head_LOD1")
			Hide_Sub_Object(Object, 0, "body_41_LOD0")
			Hide_Sub_Object(Object, 0, "body_41_LOD1")
			Hide_Sub_Object(Object, 0, "helmet_41_LOD0")
			Hide_Sub_Object(Object, 0, "helmet_41_LOD1")
			Hide_Sub_Object(Object, 0, "head_41_LOD0")
			Hide_Sub_Object(Object, 0, "head_41_LOD1")
		end
		ScriptExit()
	end
end

--LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, XXXX)--Kiem tra Impact tren nguoi nhan vat--
--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, XXXX, 0)--Them Impact len nhan vat--
--LuaFnCancelSpecificImpact(sceneId, selfId, XXXX)--Huy bo Impact tren nguoi nhan vat--

x380001_g_scriptId = 380001

function x380001_AddImpact(sceneId, selfId, equip_do)
	local Item100 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 100 ) --Vu Khi--
	local Item101 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 101 ) --Mao Tu--
	local Item102 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 102 ) --Y Phuc--
	local Item103 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 103 ) --Ho Thu--
	local Item104 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 104 ) --Hai Tu--
	local Item105 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 105 ) --Yeu Dai--
	local Item106 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 106 ) --Gioi Chi 1--
	local Item107 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 107 ) --Hang Lien--
	local Item108 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 108 ) --Thu Cuoi--
	local Item109 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 109 ) --Lenh Bai--
	local Item110 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 110 ) --Vo Hon--
	local Item111 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 111 ) --Gioi Chi 2--
	local Item112 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 112 ) --Ho Phu 1--
	local Item113 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 113 ) --Ho Phu 2--
	local Item114 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 114 ) --Ho Uyen--
	local Item115 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 115 ) --Ho Kien--
	local Item116 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 116 ) --Thoi Trang--
	local Item117 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 117 ) --Am Khi--
	local Item118 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 118 ) --Long Van--
	
	if Item106 >= 10259201 and Item106 <= 10263200 then
		local DW106_Base = 11000
		local DWID106 = mod(Item106,200)
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, DW106_Base + DWID106) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW106_Base + DWID106, 0)
		end
	else
		local DW106_Cancel = 11851
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW106_Cancel, 0)
	end

	if Item111 >= 10259201 and Item111 <= 10263200 then
		local DW111_Base = 11170
		local DWID111 = mod(Item111,200)
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, DW111_Base + DWID111) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW111_Base + DWID111, 0)
		end
	else
		local DW111_Cancel = 11852
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW111_Cancel, 0)
	end

	if Item112 >= 10265401 and Item112 <= 10269400 then
		local DW112_Base = 11340
		local DWID112 = mod(Item112,200)
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, DW112_Base + DWID112) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW112_Base + DWID112, 0)
		end
	else
		local DW112_Cancel = 11853
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW112_Cancel, 0)
	end

	if Item113 >= 10265401 and Item113 <= 10269400 then
		local DW113_Base = 11510
		local DWID113 = mod(Item113,200)
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, DW113_Base + DWID113) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW113_Base + DWID113, 0)
		end
	else
		local DW113_Cancel = 11854
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW113_Cancel, 0)
	end
	
	if Item118 >= 10157001 and Item118 <= 10157900 then
		local DW118_Base = 11680
		local i, m = LuaFnGetItemCreator(sceneId,selfId,118)
		local DWID118 = 175
		local LW_Pro1_Base = 13800
		local LW_Pro2_Base = 13810
		local LW_Pro3_Base = 13850
		local LW_Pro1 = 0
		local LW_Pro2 = 0
		local LW_Pro3 = 0
		if m ~= nil then
			DWID118 = tonumber(strsub(tostring(m),9,11))
			if DWID118 == 0 then
				DWID118 = 175
			end
			LW_Pro1 = tonumber(strsub(tostring(m),3,4))
			LW_Pro2 = tonumber(strsub(tostring(m),5,6))
			LW_Pro3 = tonumber(strsub(tostring(m),7,8))
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, DW118_Base + DWID118) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, DW118_Base + DWID118, 0)
		end
		if LW_Pro1 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, LW_Pro1_Base + LW_Pro1) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, LW_Pro1_Base + LW_Pro1, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13891, 0)
		end
		if LW_Pro2 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, LW_Pro2_Base + LW_Pro2) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, LW_Pro2_Base + LW_Pro2, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13892, 0)
		end
		if LW_Pro3 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, LW_Pro3_Base + LW_Pro3) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, LW_Pro3_Base + LW_Pro3, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13893, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11855, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13891, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13892, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,  13893, 0)
	end

	if (Item110 >= 10156001 and Item110 <= 10156004) or (Item110 >= 10264601 and Item110 <= 10265400) then
		local i, m = LuaFnGetItemCreator(sceneId,selfId,110)
		local WH_Name = GetItemName(sceneId, Item110)

		local m0 = tonumber(strsub(tostring(m),1,6))
		local m1 = tonumber(strsub(tostring(m),7,12))
		local m2 = tonumber(strsub(tostring(m),13,18))
		local m3 = tonumber(strsub(tostring(m),19,24))
		local m4 = tonumber(strsub(tostring(m),25,29))

		BeginUICommand(sceneId)
			if m ~= nil then
				UICommand_AddInt(sceneId,m0)
				UICommand_AddInt(sceneId,m1)
				UICommand_AddInt(sceneId,m2)
				UICommand_AddInt(sceneId,m3)
				UICommand_AddInt(sceneId,m4)
			else
				UICommand_AddInt(sceneId, 000000)			
				UICommand_AddInt(sceneId, 015001)			
				UICommand_AddInt(sceneId, 000000)			
				UICommand_AddInt(sceneId, 000000)			
				UICommand_AddInt(sceneId, 00000)			
			end
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,20007413)
			
		local WH_TT_Base = 5
		local WH_TT = 4
		local WH_LV = 1
		local WH_Pro1 = 0
		local WH_Pro2 = 0
		local WH_Pro3 = 0		

		if m ~= nil then
			WH_TT_Base = tonumber(strsub(tostring(m),9,9))
			WH_TT = 9 - WH_TT_Base --Truong Thanh--
			WH_LV = tonumber(strsub(tostring(m),6,8)) --WH_LV--
			WH_Pro1 = tonumber(strsub(tostring(m),14,15)) --WH_Pro1--
			WH_Pro2 = tonumber(strsub(tostring(m),16,17)) --WH_Pro2--
			WH_Pro3 = tonumber(strsub(tostring(m),18,19)) --WH_Pro3--
		end
		
		local IDIP_Base = 0
		if WH_Name == "Lßu Ly Di®m" then
			IDIP_Base = 12000
		elseif WH_Name == "Ngñ Dao Bàn" then
			IDIP_Base = 12600
		end
		local Property = IDIP_Base + 120*WH_TT + WH_LV --OK--
		
		local Pro1 = 13200 + 40*WH_TT + WH_Pro1
		local Pro2 = 13400 + 40*WH_TT + WH_Pro2
		local Pro3 = 13600 + 40*WH_TT + WH_Pro3

		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Property) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Property, 0)
		end
		
		if WH_Pro1 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Pro1) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Pro1, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11997, 0)
		end

		if WH_Pro2 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Pro2) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Pro2, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11998, 0)
		end

		if WH_Pro3 ~= 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Pro3) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Pro3, 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11999, 0)
		end

	else
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 000000)			
			UICommand_AddInt(sceneId, 015001)			
			UICommand_AddInt(sceneId, 000000)			
			UICommand_AddInt(sceneId, 000000)			
			UICommand_AddInt(sceneId, 00000)			
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,20007413)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12000, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11999, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11998, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11997, 0)
	end
	
	if GetItemName(sceneId, Item110) == "Lßu Ly Di®m" or GetItemName(sceneId, Item110) == "Ngñ Dao Bàn" then
		local Author, szAuthor = LuaFnGetItemCreator(sceneId,selfId,110)
		if szAuthor ~= nil then
			local WuhunSkill1 = tonumber(strsub(tostring(szAuthor),21,23))
			if WuhunSkill1 ~= 0 then
				local WHSkill1Base = 1360
				AddSkill(sceneId,selfId,WHSkill1Base + WuhunSkill1)
			else
				for i = 1361, 1384 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
			
			local WuhunSkill2 = tonumber(strsub(tostring(szAuthor),24,26))
			if WuhunSkill2 ~= 0 then
				local WHSkill2Base = 1384
				AddSkill(sceneId,selfId,WHSkill2Base + WuhunSkill2)
			else
				for i = 1385, 1516 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
			
			local WuhunSkill3 = tonumber(strsub(tostring(szAuthor),27,29))
			if WuhunSkill3 ~= 0 then
				local WHSkill3Base = 1516
				AddSkill(sceneId,selfId,WHSkill3Base + WuhunSkill3)
			else
				for i = 1517, 1600 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
		end
	else
		for i = 1361, 1600 do
			if HaveSkill(sceneId,selfId,i) == 1 then
				DelSkill(sceneId,selfId,i)
			end
		end
	end

	if Item116 ~= 0 and equip_do == 0 then
		GemEffect = {}
			GemEffect[50131001] = {8411, 8421}	GemEffect[50431001] = {8411, 8421}	GemEffect[50731001] = {8411, 8421}
			GemEffect[50131002] = {8412, 8422}	GemEffect[50431002] = {8412, 8422}	GemEffect[50731002] = {8412, 8422}
			GemEffect[50131003] = {8413, 8423}	GemEffect[50431003] = {8413, 8423}	GemEffect[50731003] = {8413, 8423}
			GemEffect[50131004] = {8414, 8424}	GemEffect[50431004] = {8414, 8424}	GemEffect[50731004] = {8414, 8424}
			GemEffect[50131005] = {8415, 8425}	GemEffect[50431005] = {8415, 8425}	GemEffect[50731005] = {8415, 8425}
			GemEffect[50131006] = {8416, 8426}	GemEffect[50431006] = {8416, 8426}	GemEffect[50731006] = {8416, 8426}
			GemEffect[50131007] = {8417, 8427}	GemEffect[50431007] = {8417, 8427}	GemEffect[50731007] = {8417, 8427}
			GemEffect[50131008] = {8418, 8428}	GemEffect[50431008] = {8418, 8428}	GemEffect[50731008] = {8418, 8428}
			GemEffect[50131009] = {8419, 8429}	GemEffect[50431009] = {8419, 8429}	GemEffect[50731009] = {8419, 8429}
			GemEffect[50131010] = {8431, 8441}	GemEffect[50432001] = {8431, 8441}	GemEffect[50732001] = {8431, 8441}
			GemEffect[50131011] = {8432, 8442}	GemEffect[50432002] = {8432, 8442}	GemEffect[50732002] = {8432, 8442}
			GemEffect[50131012] = {8433, 8443}	GemEffect[50432003] = {8433, 8443}	GemEffect[50732003] = {8433, 8443}
			GemEffect[50131013] = {8434, 8444}	GemEffect[50432004] = {8434, 8444}	GemEffect[50732004] = {8434, 8444}
			GemEffect[50131014] = {8435, 8445}	GemEffect[50432005] = {8435, 8445}	GemEffect[50732005] = {8435, 8445}
			GemEffect[50131015] = {8436, 8446}	GemEffect[50432006] = {8436, 8446}	GemEffect[50732006] = {8436, 8446}
			GemEffect[50131016] = {8437, 8447}	GemEffect[50432007] = {8437, 8447}	GemEffect[50732007] = {8437, 8447}
			GemEffect[50131017] = {8438, 8448}	GemEffect[50432008] = {8438, 8448}	GemEffect[50732008] = {8438, 8448}
			GemEffect[50131018] = {8439, 8449}	GemEffect[50432009] = {8439, 8449}	GemEffect[50732009] = {8439, 8449}
			GemEffect[50131019] = {8451, 8461}	GemEffect[50433001] = {8451, 8461}	GemEffect[50733001] = {8451, 8461}
			GemEffect[50131020] = {8452, 8462}	GemEffect[50433002] = {8452, 8462}	GemEffect[50733002] = {8452, 8462}
			GemEffect[50131021] = {8453, 8463}	GemEffect[50433003] = {8453, 8463}	GemEffect[50733003] = {8453, 8463}
			GemEffect[50131022] = {8454, 8464}	GemEffect[50433004] = {8454, 8464}	GemEffect[50733004] = {8454, 8464}
			GemEffect[50131023] = {8455, 8465}	GemEffect[50433005] = {8455, 8465}	GemEffect[50733005] = {8455, 8465}
			GemEffect[50131024] = {8456, 8466}	GemEffect[50433006] = {8456, 8466}	GemEffect[50733006] = {8456, 8466}
			GemEffect[50131025] = {8457, 8467}	GemEffect[50433007] = {8457, 8467}	GemEffect[50733007] = {8457, 8467}
			GemEffect[50131026] = {8458, 8468}	GemEffect[50433008] = {8458, 8468}	GemEffect[50733008] = {8458, 8468}
			GemEffect[50131027] = {8459, 8469}	GemEffect[50433009] = {8459, 8469}	GemEffect[50733009] = {8459, 8469}
			GemEffect[50231001] = {8411, 8421}	GemEffect[50531001] = {8411, 8421}	GemEffect[50831001] = {8411, 8421}
			GemEffect[50231002] = {8412, 8422}	GemEffect[50531002] = {8412, 8422}	GemEffect[50831002] = {8412, 8422}
			GemEffect[50231003] = {8413, 8423}	GemEffect[50531003] = {8413, 8423}	GemEffect[50831003] = {8413, 8423}
			GemEffect[50231004] = {8414, 8424}	GemEffect[50531004] = {8414, 8424}	GemEffect[50831004] = {8414, 8424}
			GemEffect[50231005] = {8415, 8425}	GemEffect[50531005] = {8415, 8425}	GemEffect[50831005] = {8415, 8425}
			GemEffect[50231006] = {8416, 8426}	GemEffect[50531006] = {8416, 8426}	GemEffect[50831006] = {8416, 8426}
			GemEffect[50231007] = {8417, 8427}	GemEffect[50531007] = {8417, 8427}	GemEffect[50831007] = {8417, 8427}
			GemEffect[50231008] = {8418, 8428}	GemEffect[50531008] = {8418, 8428}	GemEffect[50831008] = {8418, 8428}
			GemEffect[50231009] = {8419, 8429}	GemEffect[50531009] = {8419, 8429}	GemEffect[50831009] = {8419, 8429}
			GemEffect[50232001] = {8431, 8441}	GemEffect[50532001] = {8431, 8441}	GemEffect[50832001] = {8431, 8441}
			GemEffect[50232002] = {8432, 8442}	GemEffect[50532002] = {8432, 8442}	GemEffect[50832002] = {8432, 8442}
			GemEffect[50232003] = {8433, 8443}	GemEffect[50532003] = {8433, 8443}	GemEffect[50832003] = {8433, 8443}
			GemEffect[50232004] = {8434, 8444}	GemEffect[50532004] = {8434, 8444}	GemEffect[50832004] = {8434, 8444}
			GemEffect[50232005] = {8435, 8445}	GemEffect[50532005] = {8435, 8445}	GemEffect[50832005] = {8435, 8445}
			GemEffect[50232006] = {8436, 8446}	GemEffect[50532006] = {8436, 8446}	GemEffect[50832006] = {8436, 8446}
			GemEffect[50232007] = {8437, 8447}	GemEffect[50532007] = {8437, 8447}	GemEffect[50832007] = {8437, 8447}
			GemEffect[50232008] = {8438, 8448}	GemEffect[50532008] = {8438, 8448}	GemEffect[50832008] = {8438, 8448}
			GemEffect[50232009] = {8439, 8449}	GemEffect[50532009] = {8439, 8449}	GemEffect[50832009] = {8439, 8449}
			GemEffect[50233001] = {8451, 8461}	GemEffect[50533001] = {8451, 8461}	GemEffect[50833001] = {8451, 8461}
			GemEffect[50233002] = {8452, 8462}	GemEffect[50533002] = {8452, 8462}	GemEffect[50833002] = {8452, 8462}
			GemEffect[50233003] = {8453, 8463}	GemEffect[50533003] = {8453, 8463}	GemEffect[50833003] = {8453, 8463}
			GemEffect[50233004] = {8454, 8464}	GemEffect[50533004] = {8454, 8464}	GemEffect[50833004] = {8454, 8464}
			GemEffect[50233005] = {8455, 8465}	GemEffect[50533005] = {8455, 8465}	GemEffect[50833005] = {8455, 8465}
			GemEffect[50233006] = {8456, 8466}	GemEffect[50533006] = {8456, 8466}	GemEffect[50833006] = {8456, 8466}
			GemEffect[50233007] = {8457, 8467}	GemEffect[50533007] = {8457, 8467}	GemEffect[50833007] = {8457, 8467}
			GemEffect[50233008] = {8458, 8468}	GemEffect[50533008] = {8458, 8468}	GemEffect[50833008] = {8458, 8468}
			GemEffect[50233009] = {8459, 8469}	GemEffect[50533009] = {8459, 8469}	GemEffect[50833009] = {8459, 8469}
			GemEffect[50331001] = {8411, 8421}	GemEffect[50631001] = {8411, 8421}	GemEffect[50931001] = {8411, 8421}
			GemEffect[50331002] = {8412, 8422}	GemEffect[50631002] = {8412, 8422}	GemEffect[50931002] = {8412, 8422}
			GemEffect[50331003] = {8413, 8423}	GemEffect[50631003] = {8413, 8423}	GemEffect[50931003] = {8413, 8423}
			GemEffect[50331004] = {8414, 8424}	GemEffect[50631004] = {8414, 8424}	GemEffect[50931004] = {8414, 8424}
			GemEffect[50331005] = {8415, 8425}	GemEffect[50631005] = {8415, 8425}	GemEffect[50931005] = {8415, 8425}
			GemEffect[50331006] = {8416, 8426}	GemEffect[50631006] = {8416, 8426}	GemEffect[50931006] = {8416, 8426}
			GemEffect[50331007] = {8417, 8427}	GemEffect[50631007] = {8417, 8427}	GemEffect[50931007] = {8417, 8427}
			GemEffect[50331008] = {8418, 8428}	GemEffect[50631008] = {8418, 8428}	GemEffect[50931008] = {8418, 8428}
			GemEffect[50331009] = {8419, 8429}	GemEffect[50631009] = {8419, 8429}	GemEffect[50931009] = {8419, 8429}
			GemEffect[50332001] = {8431, 8441}	GemEffect[50632001] = {8431, 8441}	GemEffect[50932001] = {8431, 8441}
			GemEffect[50332002] = {8432, 8442}	GemEffect[50632002] = {8432, 8442}	GemEffect[50932002] = {8432, 8442}
			GemEffect[50332003] = {8433, 8443}	GemEffect[50632003] = {8433, 8443}	GemEffect[50932003] = {8433, 8443}
			GemEffect[50332004] = {8434, 8444}	GemEffect[50632004] = {8434, 8444}	GemEffect[50932004] = {8434, 8444}
			GemEffect[50332005] = {8435, 8445}	GemEffect[50632005] = {8435, 8445}	GemEffect[50932005] = {8435, 8445}
			GemEffect[50332006] = {8436, 8446}	GemEffect[50632006] = {8436, 8446}	GemEffect[50932006] = {8436, 8446}
			GemEffect[50332007] = {8437, 8447}	GemEffect[50632007] = {8437, 8447}	GemEffect[50932007] = {8437, 8447}
			GemEffect[50332008] = {8438, 8448}	GemEffect[50632008] = {8438, 8448}	GemEffect[50932008] = {8438, 8448}
			GemEffect[50332009] = {8439, 8449}	GemEffect[50632009] = {8439, 8449}	GemEffect[50932009] = {8439, 8449}
			GemEffect[50333001] = {8451, 8461}	GemEffect[50633001] = {8451, 8461}	GemEffect[50933001] = {8451, 8461}
			GemEffect[50333002] = {8452, 8462}	GemEffect[50633002] = {8452, 8462}	GemEffect[50933002] = {8452, 8462}
			GemEffect[50333003] = {8453, 8463}	GemEffect[50633003] = {8453, 8463}	GemEffect[50933003] = {8453, 8463}
			GemEffect[50333004] = {8454, 8464}	GemEffect[50633004] = {8454, 8464}	GemEffect[50933004] = {8454, 8464}
			GemEffect[50333005] = {8455, 8465}	GemEffect[50633005] = {8455, 8465}	GemEffect[50933005] = {8455, 8465}
			GemEffect[50333006] = {8456, 8466}	GemEffect[50633006] = {8456, 8466}	GemEffect[50933006] = {8456, 8466}
			GemEffect[50333007] = {8457, 8467}	GemEffect[50633007] = {8457, 8467}	GemEffect[50933007] = {8457, 8467}
			GemEffect[50333008] = {8458, 8468}	GemEffect[50633008] = {8458, 8468}	GemEffect[50933008] = {8458, 8468}
			GemEffect[50333009] = {8459, 8469}	GemEffect[50633009] = {8459, 8469}	GemEffect[50933009] = {8459, 8469}

			
		local GemID1 = GetGemEmbededType( sceneId, selfId, 116, 0 )
		local GemID2 = GetGemEmbededType( sceneId, selfId, 116, 1 )	
		local GemID3 = GetGemEmbededType( sceneId, selfId, 116, 2 )
		
		if GemID1 > 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID1][1]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID1][1], 0)
			end
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID1][2]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID1][2], 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8401, 0)
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8402, 0)
		end
		
		if GemID2 > 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID2][1]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID2][1], 0)
			end
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID2][2]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID2][2], 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8403, 0)
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8404, 0)
		end

		if GemID3 > 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID3][1]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID3][1], 0)
			end
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GemEffect[GemID3][2]) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GemEffect[GemID3][2], 0)
			end
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8405, 0)
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8406, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8401, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8402, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8403, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8404, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8405, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8406, 0)
	end
	
	if GetItemName(sceneId, Item101) == "Trùng Lâu Khôi" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9509, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9509)
	end

	if GetItemName(sceneId, Item102) == "Trùng Lâu Giáp" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9506, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9506)
	end
	
	if GetItemName(sceneId, Item103) == "Trùng Lâu Thü" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9507, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9507)
	end

	if GetItemName(sceneId, Item104) == "Trùng Lâu Ngoa" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9508, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9508)
	end

	if GetItemName(sceneId, Item105) == "Trùng Lâu Ð¾i" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9504, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9504)
	end

	if GetItemName(sceneId, Item107) == "Trùng Lâu Liên" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9503, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9503)
	end

	if GetItemName(sceneId, Item106) == "Trùng Lâu Gi¾i" or GetItemName(sceneId, Item111) == "Trùng Lâu Gi¾i" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9501, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9501)
		if GetItemName(sceneId, Item106) == "Trùng Lâu Tri®u" or GetItemName(sceneId, Item111) == "Trùng Lâu Tri®u" then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9511, 0)
		else
			LuaFnCancelSpecificImpact(sceneId, selfId, 9511)
		end
	end
	
	if GetItemName(sceneId, Item112) == "Trùng Lâu Ng÷c" or GetItemName(sceneId, Item113) == "Trùng Lâu Ng÷c" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9502, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9502)
		if GetItemName(sceneId, Item112) == "Trùng Lâu Quy" or GetItemName(sceneId, Item113) == "Trùng Lâu Quy" then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9512, 0)
		else
			LuaFnCancelSpecificImpact(sceneId, selfId, 9512)
		end
	end

	if GetItemName(sceneId, Item114) == "Trùng Lâu Uy¬n" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9510, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9510)
	end
	
	if GetItemName(sceneId, Item115) == "Trùng Lâu Kiên" then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 9505, 0)
	else
		LuaFnCancelSpecificImpact(sceneId, selfId, 9505)
	end
end
--00000001500100000000000000000--
function x380001_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
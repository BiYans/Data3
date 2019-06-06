x741302_g_scriptId = 741302

function x741302_ModifyEquip(sceneId, selfId, type, param1, param2, param3)
	if type == 801 then --Hoc thuoc tinh mo rong--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Item2ID < 30700214 or Item2ID > 30700229 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u sách thuµc tính Võ H°n.")
			return
		end
		
		local WuhunBook = {}
			WuhunBook[30700214] = {"041",41,50}
			WuhunBook[30700215] = {"051",51,60}
			WuhunBook[30700216] = {"061",61,70}
			WuhunBook[30700217] = {"071",71,80}
			
			WuhunBook[30700218] = {"001",1,10}
			WuhunBook[30700219] = {"011",11,20}
			WuhunBook[30700220] = {"021",21,30}
			WuhunBook[30700221] = {"031",31,40}
			
			WuhunBook[30700222] = {"081",81,90}
			WuhunBook[30700223] = {"091",91,100}
			WuhunBook[30700224] = {"101",101,110}
			WuhunBook[30700225] = {"111",111,120}
			
			WuhunBook[30700226] = {"121",121,130}
			WuhunBook[30700227] = {"131",131,140}
			WuhunBook[30700228] = {"141",141,150}
			WuhunBook[30700229] = {"151",151,160}
			
		local VoHon_AttrEx = {}
			VoHon_AttrEx[1] = {18,20}
			VoHon_AttrEx[2] = {21,23}
			VoHon_AttrEx[3] = {24,26}
			VoHon_AttrEx[4] = {27,29}
			VoHon_AttrEx[5] = {30,32}
			VoHon_AttrEx[6] = {33,35}
			VoHon_AttrEx[7] = {36,38}
			VoHon_AttrEx[8] = {39,41}
			VoHon_AttrEx[9] = {42,44}
			VoHon_AttrEx[10] = {45,47}
		
		local OptionNum = 0;
		local OptionFree = 0;
		for i = 1, 10 do
			local WuhunOption = x741302_GetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[i][1], VoHon_AttrEx[i][2])
			if WuhunOption ~= "---" then
				OptionNum = OptionNum + 1;
				if WuhunOption >= WuhunBook[Item2ID][2] and WuhunOption <= WuhunBook[Item2ID][3] then
					x741302_NotifyFailTips(sceneId,selfId,"Thuµc tính này ðã t°n tÕi trên Võ H°n.")
					return
				end
			else
				if OptionFree == 0 then
					OptionFree = i;
				end
			end
		end
		
		local WuhunSlotNum = x741302_GetWuhunAuthor(sceneId, selfId, param1, 17, 17)
		if OptionNum >= WuhunSlotNum then
			x741302_NotifyFailTips(sceneId,selfId,"Hãy nâng cao s¯ khung thuµc tính Võ H°n");
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end
		
		--Check Co Dinh--
		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		EraseItem(sceneId,selfId,param2)
		x741302_SetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[OptionFree][1], WuhunBook[Item2ID][1])
		x741302_NotifyFailTips( sceneId, selfId, "M· rµng thuµc tính Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end

	if type == 802 then --Thang Cap Hop Thanh--
		local Wuhun1ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if Wuhun1ID < 10308001 or Wuhun1ID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local Wuhun2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Wuhun2ID < 10308001 or Wuhun2ID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"Nguyên li®u nâng c¤p phäi là V² H°n.")
			return
		end
		
		local Wuhun1Level = x741302_GetWuhunAuthor(sceneId, selfId, param1, 16, 16)
		
		if Wuhun1Level >= 7 then
			x741302_NotifyFailTips(sceneId,selfId,"ÐÆng c¤p hþp thành Võ H°n ðã ðÕt cao nh¤t.")
			return
		end
		
		local Wuhun2Level = x741302_GetWuhunAuthor(sceneId, selfId, param2, 16, 16)
		
		if Wuhun1Level ~= Wuhun2Level then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Võ H°n nguyên li®u phäi ðÕt hþp thành "..Wuhun1Level..".")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end
		
		--Check Co Dinh--
		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		local NewLevel = Wuhun1Level + 1;
		EraseItem(sceneId,selfId,param2)
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 16, NewLevel)
		x741302_NotifyFailTips( sceneId, selfId, "Nâng c¤p Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end

	if type == 804 then --Mo rong khung thuoc tinh--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local WuhunSlotLevel = x741302_GetWuhunAuthor(sceneId, selfId, param1, 16, 16)
		local WuhunSlotNum = x741302_GetWuhunAuthor(sceneId, selfId, param1, 17, 17)
		
		if WuhunSlotNum >= WuhunSlotLevel then
			x741302_NotifyFailTips(sceneId,selfId,"Hãy nâng cao ðÆng c¤p hþp thành Võ H°n.")
			return
		end
		
		local LanMocTienID = 20310158;
		local PhaThienTienID = 20310159;
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Item2ID ~= LanMocTienID and Item2ID ~= PhaThienTienID then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u "..GetItemName(sceneId,LanMocTienID).." ho£c "..GetItemName(sceneId,PhaThienTienID)..".")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end

		--Check Co Dinh--
		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		EraseItem(sceneId,selfId,param2)
		
		local Random = random(1,100);
		if Item2ID == LanMocTienID then
			if Random >= 25 then
				x741302_NotifyFailTips( sceneId, selfId, "M· rµng khung thuµc tính Võ H°n th¤t bÕi.")
				return
			end
		end
		if Item2ID == PhaThienTienID then
			if Random >= 50 then
				x741302_NotifyFailTips( sceneId, selfId, "M· rµng khung thuµc tính Võ H°n th¤t bÕi.")
				return
			end
		end
		
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		WuhunSlotNum = WuhunSlotNum + 1;
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 17, WuhunSlotNum)
		x741302_NotifyFailTips( sceneId, selfId, "M· rµng khung thuµc tính Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if type == 809 then
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Item2ID < 30700237 or Item2ID > 30700242 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u H°i Thiên ThÕch ð¬ thay ð±i ph¦m giá.")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end
		
		local Random = 0;
		if Item2ID >= 30700237 and Item2ID <= 30700239 then
			Random = random(500,999)
			if Random >= 600 then
				Random = random(600,999)
			end
			
			if Random >= 700 then
				Random = random(700,999)
			end
			
			if Random >= 800 then
				Random = random(800,999)
			end
			
			if Random >= 900 then
				Random = random(900,999)
			end
		end
		
		if Item2ID >= 30700240 and Item2ID <= 30700242 then
			Random = random(500,999)
			if Random >= 600 then
				Random = random(600,999)
			end
			
			if Random >= 800 then
				Random = random(800,999)
			end
		end
		
		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,Item2ID,1)
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 13, Random)
		x741302_NotifyFailTips( sceneId, selfId, "Thay ð±i C¥m Tinh thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if type == 810 then
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local WuhunLevel = x741302_GetWuhunAuthor(sceneId, selfId, param1, 16, 16)
		if WuhunLevel < 5 then
			x741302_NotifyFailTips(sceneId,selfId,"Võ H°n ð£t hþp thành 5 m¾i có th¬ thay ð±i C¥m Tinh.")
			return
		end
		
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Item2ID < 30700243 or Item2ID > 30700245 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Võ H°n D¸ch Tß¾ng Ðan ð¬ thay ð±i C¥m Tinh")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
			return
		end
		
		local WuhunCamTinh = x741302_GetWuhunAuthor(sceneId, selfId, param1, 57, 57)
		local WuhunCT = random(1,4);
		while WuhunCT == WuhunCamTinh do
			WuhunCT = random(1,4);
		end

		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		EraseItem(sceneId,selfId,param2)
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 57, WuhunCT)
		x741302_NotifyFailTips( sceneId, selfId, "Thay ð±i C¥m Tinh thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if type == 876 then
		local Item1ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if Item1ID < 20310122 or Item1ID > 20310157 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ hþp thành Nhu§n H°n ThÕch.")
			return
		end
		
		if Item1ID == 20310130 or Item1ID == 20310130 or Item1ID == 20310130 or Item1ID == 20310130 then
			x741302_NotifyFailTips(sceneId,selfId,"Nhu§n H°n ThÕch c¤p 9 không th¬ tiªp tøc nâng c¤p.")
			return
		end
		
		if Item1ID >= 20310128 or Item1ID >= 20310137 or Item1ID >= 20310146 or Item1ID >= 20310155 then
			x741302_NotifyFailTips(sceneId,selfId,"Nhu§n H°n ThÕch trên c¤p 7 vçn chßa ðßþc khai m·.")
			return
		end
		
		local WuhunRH_Level = 0;
		
		if (Item1ID >= 20310126 and Item1ID <= 20310130)
		or (Item1ID >= 20310135 and Item1ID <= 20310139)
		or (Item1ID >= 20310144 and Item1ID <= 20310148)
		or (Item1ID >= 20310153 and Item1ID <= 20310157)
		then
			WuhunRH_Level = 5;
		end
		
		local Item1ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		local Item3ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param3)
		
		if WuhunRH_Level == 0 then
			if Item1ID ~= Item2ID or Item1ID ~= Item3ID then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch cùng loÕi và ðÆng c¤p.")
				return
			end
			
			if CostMoney(sceneId,selfId,50000) == -1 then
				x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
				return
			end
			
			local Item1Bind = LuaFnGetItemBindStatus(sceneId,selfId,param1)
			local Item2Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
			local Item3Bind = LuaFnGetItemBindStatus(sceneId,selfId,param3)
			
			local Bind = 0;
			if Item1Bind + Item2Bind + Item3Bind > 0 then
				Bind = 1;
			end
			
			EraseItem(sceneId,selfId,param1)
			EraseItem(sceneId,selfId,param2)
			EraseItem(sceneId,selfId,param3)
			
			local NewItem = TryRecieveItem(sceneId,selfId,Item1ID+1,1)
			if Bind == 1 then
				LuaFnItemBind(sceneId,selfId,NewItem)
			end
		end
		
		if WuhunRH_Level == 5 then
			if Item1ID ~= Item2ID then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch cùng loÕi và ðÆng c¤p.")
				return
			end
			
			if CostMoney(sceneId,selfId,50000) == -1 then
				x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
				return
			end
			
			local Item1Bind = LuaFnGetItemBindStatus(sceneId,selfId,param1)
			local Item2Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
			
			local Bind = 0;
			if Item1Bind + Item2Bind > 0 then
				Bind = 1;
			end
			
			EraseItem(sceneId,selfId,param1)
			EraseItem(sceneId,selfId,param2)
			
			local NewItem = TryRecieveItem(sceneId,selfId,Item1ID+1,1)
			if Bind == 1 then
				LuaFnItemBind(sceneId,selfId,NewItem)
			end
		end
		
		x741302_NotifyFailTips( sceneId, selfId, "Nhu§n H°n ThÕch ðã ðßþc hþp thành.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if type == 877 then --Nang Cap Ky Nang--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local WuhunSkill = x741302_GetWuhunAuthor(sceneId, selfId, param1, 45+param2*3, 47+param2*3)
		if WuhunSkill == "---" then
			x741302_NotifyFailTips(sceneId,selfId,"L²i xØ lý, vui lòng liên h® GM!")
			return
		end
		
		local SkillLevel = mod(WuhunSkill,6)
		if SkillLevel == 0 then
			x741302_NotifyFailTips(sceneId,selfId,"KÛ nång này ðã ðÕt c¤p ðµ cao nh¤t.")
			return
		end
		
		local HonBangChauID = {20310117,20310118,20310119,20310120,20310121}
		local HonBangChauID_CD = {20310161,20310162,20310163,20310164,20310165}
		
		local HonBangChau = LuaFnGetAvailableItemCount(sceneId,selfId,HonBangChauID[SkillLevel])
		local HonBangChau_CD = LuaFnGetAvailableItemCount(sceneId,selfId,HonBangChauID_CD[SkillLevel])
		
		if HonBangChau + HonBangChau_CD < 1 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u "..GetItemName(sceneId,HonBangChauID[SkillLevel])..".")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
			return
		end
		
		local Bind = 0;
		if HonBangChau_CD >= 1 then
			Bind = 1;
			LuaFnDelAvailableItem(sceneId,selfId,HonBangChauID_CD[SkillLevel],1)
		else
			LuaFnDelAvailableItem(sceneId,selfId,HonBangChauID[SkillLevel],1)
		end
		
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		WuhunSkill = WuhunSkill + 1;
		if WuhunSkill >= 1 and WuhunSkill <= 9 then
			WuhunSkill = "00"..WuhunSkill
		elseif WuhunSkill >= 10 and WuhunSkill <= 99 then
			WuhunSkill = "0"..WuhunSkill
		end
		
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 45+param2*3, WuhunSkill)
		x741302_NotifyFailTips( sceneId, selfId, "Thång c¤p kÛ nång Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end

	if type == 878 then --Tay Lai Ky Nang Wuhun--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local WuhunAllSkill = x741302_GetWuhunAuthor(sceneId, selfId, param1, 48, 56)
		if WuhunAllSkill == "---------" then
			x741302_NotifyFailTips(sceneId,selfId,"Võ H°n chßa có kÛ nång nào cä.")
			return
		end
		
		local UcHonThachID = 30700213
		local UcHonThachID_CD = 30700236
		local UcHonThach = LuaFnGetAvailableItemCount(sceneId,selfId,UcHonThachID)
		local UcHonThach_CD = LuaFnGetAvailableItemCount(sceneId,selfId,UcHonThachID_CD)
		if UcHonThach + UcHonThach_CD < 1 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u ºc H°n ThÕch ð¬ t¦y kÛ nång cho Võ H°n.")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
			return
		end
		
		local Bind = 0;
		if UcHonThach_CD >= 1 then
			Bind = 1;
			LuaFnDelAvailableItem(sceneId,selfId,UcHonThachID_CD,1)
		else
			LuaFnDelAvailableItem(sceneId,selfId,UcHonThachID,1)
		end
		
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		local NumArray = {3,21,13}
		for i = 1, 3 do
			local WuhunSkill = x741302_GetWuhunAuthor(sceneId, selfId, param1, 45+i*3, 47+i*3)
			local WuhunNewSkill = WuhunSkill;
			if WuhunSkill ~= "---" then
				local SkillLevel = mod(WuhunSkill,6)
				while WuhunSkill == WuhunNewSkill do
					if SkillLevel == 0 then
						WuhunNewSkill = 6 * random(1,NumArray[i]+1);
					else
						WuhunNewSkill = 6 * random(0,NumArray[i]) + SkillLevel;
					end
				end
				
				if WuhunNewSkill >= 1 and WuhunNewSkill <= 9 then
					WuhunNewSkill = "00"..WuhunNewSkill
				elseif WuhunNewSkill >= 10 and WuhunNewSkill <= 99 then
					WuhunNewSkill = "0"..WuhunNewSkill
				end
				x741302_SetWuhunAuthor(sceneId, selfId, param1, 45+i*3, WuhunNewSkill)
			end
		end

		x741302_NotifyFailTips( sceneId, selfId, "T¦y kÛ nång Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end

	if type == 879 then --Linh Hoi Ky Nang--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local WuhunLevel = x741302_GetWuhunAuthor(sceneId, selfId, param1, 5, 7)
		
		local WuhunSkill1 = x741302_GetWuhunAuthor(sceneId, selfId, param1, 48, 50)
		if WuhunSkill1 == "---" then
			if WuhunLevel < 40 then
				x741302_NotifyFailTips(sceneId,selfId,"Võ H°n c¤p ð÷ 40 m¾i có th¬ b¡t ð¥u lînh ngµ kÛ nång.")
				return
			end
			if CostMoney(sceneId,selfId,50000) == -1 then
				x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
				return
			end
			
			WuhunSkill1 = 6 * random(0, 3) + 1;
			if WuhunSkill1 >= 1 and WuhunSkill1 <= 9 then
				WuhunSkill1 = "00"..WuhunSkill1
			elseif WuhunSkill1 >= 10 and WuhunSkill1 <= 99 then
				WuhunSkill1 = "0"..WuhunSkill1
			end

			x741302_SetWuhunAuthor(sceneId, selfId, param1, 48, WuhunSkill1)
			x741302_NotifyFailTips( sceneId, selfId, "Lînh hµi kÛ nång Võ H°n thành công.")
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
			return
		end
		
		local WuhunSkill2 = x741302_GetWuhunAuthor(sceneId, selfId, param1, 51, 53)
		if WuhunSkill2 == "---" then
			if WuhunLevel < 70 then
				x741302_NotifyFailTips(sceneId,selfId,"Võ H°n c¤p ð÷ 40 m¾i có th¬ b¡t ð¥u lînh ngµ kÛ nång.")
				return
			end
			if CostMoney(sceneId,selfId,50000) == -1 then
				x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
				return
			end
			
			WuhunSkill2 = 6 * random(0, 21) + 1;
			if WuhunSkill2 >= 1 and WuhunSkill2 <= 9 then
				WuhunSkill2 = "00"..WuhunSkill2
			elseif WuhunSkill2 >= 10 and WuhunSkill2 <= 99 then
				WuhunSkill2 = "0"..WuhunSkill2
			end

			x741302_SetWuhunAuthor(sceneId, selfId, param1, 51, WuhunSkill2)
			x741302_NotifyFailTips( sceneId, selfId, "Lînh hµi kÛ nång Võ H°n thành công.")
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
			return
		end

		local WuhunSkill3 = x741302_GetWuhunAuthor(sceneId, selfId, param1, 54, 56)
		if WuhunSkill3 == "---" then
			if WuhunLevel < 90 then
				x741302_NotifyFailTips(sceneId,selfId,"Võ H°n c¤p ð÷ 40 m¾i có th¬ b¡t ð¥u lînh ngµ kÛ nång.")
				return
			end
			if CostMoney(sceneId,selfId,50000) == -1 then
				x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng.")
				return
			end
			
			WuhunSkill3 = 6 * random(0, 13) + 1;
			if WuhunSkill3 >= 1 and WuhunSkill3 <= 9 then
				WuhunSkill3 = "00"..WuhunSkill3
			elseif WuhunSkill3 >= 10 and WuhunSkill3 <= 99 then
				WuhunSkill3 = "0"..WuhunSkill3
			end

			x741302_SetWuhunAuthor(sceneId, selfId, param1, 54, WuhunSkill3)
			x741302_NotifyFailTips( sceneId, selfId, "Lînh hµi kÛ nång Võ H°n thành công.")
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
			return
		else
			x741302_NotifyFailTips( sceneId, selfId, "Võ H°n ðã lînh ngµ ðü 3 kÛ nång.")
		end
	end
	
	if type == 898 then --Xoa Thuoc Tinh Mo Rong--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local VoHon_AttrEx = {}
			VoHon_AttrEx[1] = {18,20}
			VoHon_AttrEx[2] = {21,23}
			VoHon_AttrEx[3] = {24,26}
			VoHon_AttrEx[4] = {27,29}
			VoHon_AttrEx[5] = {30,32}
			VoHon_AttrEx[6] = {33,35}
			VoHon_AttrEx[7] = {36,38}
			VoHon_AttrEx[8] = {39,41}
			VoHon_AttrEx[9] = {42,44}
			VoHon_AttrEx[10] = {45,47}
			
		local WuhunOption = x741302_GetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[param2][1], VoHon_AttrEx[param2][2])
		if WuhunOption == "---" then
			x741302_NotifyFailTips(sceneId,selfId,"L²i xØ lý, vui lòng liên h® GM!")
			return
		end
		
		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end
		
		x741302_SetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[param2][1], "---")
		
		local WuhunAllOption = x741302_GetWuhunAuthor(sceneId, selfId, param1, 18, 47)
		WuhunAllOption = gsub(WuhunAllOption,"-","")
		
		local OptionLen = strlen(WuhunAllOption);
		for i = 1, 30 - OptionLen do
			WuhunAllOption = WuhunAllOption.."-";
		end
		
		x741302_SetWuhunAuthor(sceneId, selfId, param1, 18, WuhunAllOption)
		
		x741302_NotifyFailTips( sceneId, selfId, "Xoá bö thuµc tính Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if type == 899 then --Thang Cap Thuoc Tinh Mo Rong--
		local WuhunID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param1)
		if WuhunID < 10308001 or WuhunID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"N½i ðây chï có th¬ nâng c¤p cho Võ H°n.")
			return
		end
		
		local Item2ID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,param2)
		if Item2ID < 20310122 or Item2ID > 20310157 then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch ð¬ nâng c¤p Võ H°n.")
			return
		end
		
		local VoHon_AttrEx = {}
			VoHon_AttrEx[1] = {18,20}
			VoHon_AttrEx[2] = {21,23}
			VoHon_AttrEx[3] = {24,26}
			VoHon_AttrEx[4] = {27,29}
			VoHon_AttrEx[5] = {30,32}
			VoHon_AttrEx[6] = {33,35}
			VoHon_AttrEx[7] = {36,38}
			VoHon_AttrEx[8] = {39,41}
			VoHon_AttrEx[9] = {42,44}
			VoHon_AttrEx[10] = {45,47}
			
		local WuhunOption = x741302_GetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[param3][1], VoHon_AttrEx[param3][2])
		if WuhunOption == "---" then
			x741302_NotifyFailTips(sceneId,selfId,"L²i xØ lý, vui lòng liên h® GM!")
			return
		end
		
		local OptionLevel = mod(WuhunOption,10)
		if OptionLevel == 0 then
			x741302_NotifyFailTips(sceneId,selfId,"Thuµc tính này ðã · c¤p ðµ t¯i ða!")
			return
		end
		
		if WuhunOption >= 1 and WuhunOption <= 40 then
			if Item2ID < 20310131 or Item2ID > 20310139 then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch-Kích")
				return
			end
		end
		
		if WuhunOption >= 41 and WuhunOption <= 80 then
			if Item2ID < 20310122 or Item2ID > 20310130 then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch-Ngñ")
				return
			end
		end
		
		if WuhunOption >= 81 and WuhunOption <= 120 then
			if Item2ID < 20310140 or Item2ID > 20310148 then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch-Phá")
				return
			end
		end
		
		if WuhunOption >= 121 and WuhunOption <= 160 then
			if Item2ID < 20310149 or Item2ID > 20310157 then
				x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch-BÕo")
				return
			end
		end
		
		local NHT_Level = mod((Item2ID - 20310121),9);
		if NHT_Level == 0 then
			NHT_Level = 9;
		end
		
		if OptionLevel ~= NHT_Level then
			x741302_NotifyFailTips(sceneId,selfId,"Yêu c¥u Nhu§n H°n ThÕch (C¤p "..OptionLevel..").")
			return
		end

		if CostMoney(sceneId,selfId,50000) == -1 then
			x741302_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
			return
		end

		WuhunOption = WuhunOption + 1;
		if WuhunOption <= 9 then
			WuhunOption = "00"..WuhunOption
		elseif WuhunOption <= 99 then
			WuhunOption = "0"..WuhunOption
		end
		
		local Bind = LuaFnGetItemBindStatus(sceneId,selfId,param2)
		if Bind == 1 then
			LuaFnItemBind(sceneId,selfId,param1)
		end
		
		EraseItem(sceneId,selfId,param2)
		x741302_SetWuhunAuthor(sceneId, selfId, param1, VoHon_AttrEx[param3][1], WuhunOption)
		x741302_NotifyFailTips( sceneId, selfId, "Thång c¤p thuµc tính Võ H°n thành công.")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
end

function x741302_SetWuhunAuthor(sceneId, selfId, ItemPos, Start, Data)
	local Author, szAuthor = LuaFnGetItemCreator(sceneId, selfId, ItemPos)
	if not szAuthor then
		szAuthor = "*---0010000050010---------------------------------------0";
	end

	local Begin = strsub(szAuthor, 1, Start - 1)
	local End = strsub(szAuthor, Start + strlen(Data), strlen(szAuthor))
	
	szAuthor = Begin..Data..End;
	LuaFnSetItemCreator(sceneId, selfId, ItemPos, szAuthor)
end

function x741302_GetWuhunAuthor(sceneId, selfId, ItemPos, Start, End)
	local WuhunReturn = "";
	local Author, szAuthor = LuaFnGetItemCreator(sceneId, selfId, ItemPos)
	if not szAuthor then
		szAuthor = "*---0010000050010---------------------------------------0";
	end

	WuhunReturn = strsub(szAuthor, Start, End)
	if not strfind(WuhunReturn,"-") then
		WuhunReturn = tonumber(WuhunReturn);
	end
	
	return WuhunReturn;
end

function x741302_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
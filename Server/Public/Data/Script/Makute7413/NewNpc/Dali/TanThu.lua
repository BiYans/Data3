
x880201_g_scriptId = 880201

--**********************************
--
--**********************************
function x880201_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Chào m×ng các hÕ ğªn v¾i thª gi¾i Thiên Long Bát Bµ, ta là sÑ giä do GM gØi ğªn ğ¬ h² trş cho tân thü nh§p thª.")
		AddNumText( sceneId, x880201_g_scriptId, "Nh§n Kim Nguyên Bäo", 4, 1 )
		AddNumText( sceneId, x880201_g_scriptId, "Nh§n H² Trş Giao TØ", 5, 2 )
		AddNumText( sceneId, x880201_g_scriptId, "Nh§n H² Trş Ngân Lßşng", 5, 3 )
		AddNumText( sceneId, x880201_g_scriptId, "Nh§n Trang B¸ Môn Phái", 6, 4 )
		--AddNumText( sceneId, x880201_g_scriptId, "#GCampaignTrack", 6, 5 )
		--AddNumText( sceneId, x880201_g_scriptId, "#GMissionTrack", 6, 6 )
		AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--
--**********************************
function x880201_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	if key == 5 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 243001 )
	end
	
	if key == 6 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 244001 )
	end
	
	if key == 0 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
	
	if key == 1 then
		local CurrentKNB = YuanBao(sceneId,selfId,targetId,3,0)
		if CurrentKNB >= 35000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ngß½i ğã mang s¯ nguyên bäo thßşng hÕng!" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		YuanBao(sceneId,selfId,targetId,1,35000-CurrentKNB)
		BeginEvent(sceneId)
			AddText(sceneId,"Ğây là chút ít quà m÷n ngày tªt mà ta dành cho ngß½i.")
			AddText(sceneId,"Hãy ki¬m tra tay näi nhé!")
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if key == 2 then
		local CurrentGold = GetMoneyJZ(sceneId,selfId)
		if CurrentGold >= 35000000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ngß½i ğã mang s¯ giao tØ thßşng hÕng!" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local NewMoney = 35000000-CurrentGold
		AddMoneyJZ(sceneId,selfId,NewMoney)
		x880201_ShowMsg( sceneId, selfId, "Các hÕ ğßşc thß·ng #{_EXCHG"..NewMoney.."}")
		BeginEvent(sceneId)
			AddText(sceneId,"Ğây là chút ít quà m÷n ngày tªt mà ta dành cho ngß½i.")
			AddText(sceneId,"Hãy ki¬m tra tay näi nhé!")
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if key == 3 then
		local CurrentGold = GetMoney(sceneId,selfId)
		if CurrentGold >= 35000000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ngß½i ğã mang s¯ ngân lßşng thßşng hÕng!" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		AddMoney(sceneId,selfId,35000000-CurrentGold)
		BeginEvent(sceneId)
			AddText(sceneId,"Ğây là chút ít quà m÷n ngày tªt mà ta dành cho ngß½i.")
			AddText(sceneId,"Hãy ki¬m tra tay näi nhé!")
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if key == 4 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ cüa môn phái nào?")
			AddNumText( sceneId, x880201_g_scriptId, "Phái Thiªu Lâm", 6, 40 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Minh Giáo", 6, 41 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Cái Bang", 6, 42 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Võ Ğang", 6, 43 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Nga My", 6, 44 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Tinh Túc", 6, 45 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Thiên Long", 6, 46 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Thiên S½n", 6, 47 )
			AddNumText( sceneId, x880201_g_scriptId, "Phái Tiêu Dao", 6, 48 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if key == 40 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiªu Lâm C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 41 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Minh Giáo C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 42 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Cái Bang C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 43 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Võ Ğang C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 44 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Nga My C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 45 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tinh Túc C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 46 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên Long C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 47 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Thiên S½n C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 48 then
		BeginEvent(sceneId)
			AddText(sceneId,"Các hÕ mu¯n nh§n trang b¸ c¤p ğµ bao nhiêu?")
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 10", 6, key*10 + 1 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 20", 6, key*10 + 2 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 30", 6, key*10 + 3 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 40", 6, key*10 + 4 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 50", 6, key*10 + 5 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 60", 6, key*10 + 6 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 70", 6, key*10 + 7 )
			AddNumText( sceneId, x880201_g_scriptId, "Trang B¸ Tiêu Dao C¤p 80", 6, key*10 + 8 )
			AddNumText( sceneId, x880201_g_scriptId, "R¶i ği", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key >= 401 and key <= 488 then
		local EquipID = {}
			EquipID[401] = {10510000, 10512000, 10511000}
			EquipID[402] = {10513001, 10514001, 10515001}
			EquipID[403] = {10500002, 10521002, 10522002, 10520002}
			EquipID[404] = {10512003, 10522003, 10514003}
			EquipID[405] = {10513004, 10511004, 10521004, 10515004}
			EquipID[406] = {10500005, 10510005, 10520005, 10552005, 10523005}
			EquipID[407] = {10510006, 10520006, 10523006, 10515006}
			EquipID[408] = {10511007, 10521007, 10522007, 10553007, 10514007}
			EquipID[411] = {10513010, 10514010, 10515010}
			EquipID[412] = {10521011, 10522011, 10520011}
			EquipID[413] = {10500012, 10510012, 10512012, 10511012}
			EquipID[414] = {10510013, 10520013, 10523013}
			EquipID[415] = {10513014, 10511014, 10521014, 10515014}
			EquipID[416] = {10500015, 10512015, 10522015, 10552015, 10514015}
			EquipID[417] = {10511016, 10552016, 10553016, 10515016}
			EquipID[418] = {10510017, 10512017, 10521017, 10523017, 10514017}
			EquipID[421] = {10521020, 10522020, 10520020}
			EquipID[422] = {10510021, 10512021, 10511021}
			EquipID[423] = {10501002, 10513022, 10514022, 10515022}
			EquipID[424] = {10510023, 10512023, 10522023}
			EquipID[425] = {10513024, 10520024, 10552024, 10523024}
			EquipID[426] = {10501005, 10511025, 10521025, 10514025, 10515025}
			EquipID[427] = {10510026, 10512026, 10522026, 10523026}
			EquipID[428] = {10521027, 10520027, 10552027, 10553027, 10515027}
			EquipID[431] = {10510030, 10512030, 10511030}
			EquipID[432] = {10513031, 10514031, 10515031}
			EquipID[433] = {10502002, 10521032, 10522032, 10520032}
			EquipID[434] = {10512033, 10522033, 10514033}
			EquipID[435] = {10513034, 10511034, 10521034, 10515034}
			EquipID[436] = {10502005, 10510035, 10520035, 10552035, 10523035}
			EquipID[437] = {10510036, 10520036, 10523036, 10515036}
			EquipID[438] = {10511037, 10521037, 10522037, 10553037, 10514037}
			EquipID[441] = {10513040, 10514040, 10515040}
			EquipID[442] = {10521041, 10522041, 10520041}
			EquipID[443] = {10503002, 10510042, 10512042, 10511042}
			EquipID[444] = {10510043, 10520043, 10523043}
			EquipID[445] = {10513044, 10511044, 10521044, 10515044}
			EquipID[446] = {10503005, 10512045, 10522045, 10552045, 10514045}
			EquipID[447] = {10511046, 10552046, 10553046, 10515046}
			EquipID[448] = {10510047, 10512047, 10521047, 10523047, 10514047}
			EquipID[451] = {10521050, 10522050, 10520050}
			EquipID[452] = {10510051, 10512051, 10511051}
			EquipID[453] = {10503012, 10513052, 10514052, 10515052}
			EquipID[454] = {10510053, 10512053, 10522053}
			EquipID[455] = {10513054, 10520054, 10552054, 10523054}
			EquipID[456] = {10503015, 10511055, 10521055, 10514055, 10515055}
			EquipID[457] = {10510056, 10512056, 10522056, 10523056}
			EquipID[458] = {10521057, 10520057, 10552057, 10553057, 10515057}
			EquipID[461] = {10521080, 10522080, 10520080}
			EquipID[462] = {10510081, 10512081, 10511081}
			EquipID[463] = {10505002, 10513082, 10514082, 10515082}
			EquipID[464] = {10510083, 10512083, 10522083}
			EquipID[465] = {10513084, 10520084, 10552084, 10523084}
			EquipID[466] = {10505005, 10511085, 10521085, 10514085, 10515085}
			EquipID[467] = {10510086, 10512086, 10522086, 10523086}
			EquipID[468] = {10521087, 10520087, 10552087, 10553087, 10515087}
			EquipID[471] = {10510060, 10512060, 10511060}
			EquipID[472] = {10513061, 10514061, 10515061}
			EquipID[473] = {10504002, 10521062, 10522062, 10520062}
			EquipID[474] = {10512063, 10522063, 10514063}
			EquipID[475] = {10513064, 10511064, 10521064, 10515064}
			EquipID[476] = {10504005, 10510065, 10520065, 10552065, 10523065}
			EquipID[477] = {10510066, 10520066, 10523066, 10515066}
			EquipID[478] = {10511067, 10521067, 10522067, 10553067, 10514067}
			EquipID[481] = {10513070, 10514070, 10515070}
			EquipID[482] = {10521071, 10522071, 10520071}
			EquipID[483] = {10504012, 10510072, 10512072, 10511072}
			EquipID[484] = {10510073, 10520073, 10523073}
			EquipID[485] = {10513074, 10511074, 10521074, 10515074}
			EquipID[486] = {10504015, 10512075, 10522075, 10552075, 10514075}
			EquipID[487] = {10511076, 10552076, 10553076, 10515076}
			EquipID[488] = {10510077, 10512077, 10521077, 10523077, 10514077}

		BeginEvent(sceneId)
			for i = 1, getn(EquipID[key]) do
				AddRadioItemBonus( sceneId, EquipID[key][i], 1 )
			end
		EndEvent( )
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x880201_g_scriptId,0)
	end
	
end

--**********************************
--
--**********************************
function x880201_OnMissionSubmit(sceneId,selfId,targetId,x880201_g_scriptId,ItemID)
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"Hãy s¡p xªp 1 ô tr¯ng trong túi ğÕo cø.")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	local PosNew = TryRecieveItem(sceneId,selfId,ItemID,1)

	BeginEvent(sceneId)
		AddText(sceneId,"Chúc m×ng ngß½i ğã nh§n ğßşc #G"..GetItemName(sceneId,ItemID).."#W.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
end

--**********************************
--
--**********************************
function x880201_ShowMsg( sceneId, selfId, strMsg)
	BeginEvent( sceneId )
		AddText( sceneId, strMsg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
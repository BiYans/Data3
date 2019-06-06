--LÕc Dß½ngNPC
--·¶ÒÆ³Ç
--ÆÕÍ¨

x000143_g_ScriptId	= 143
x000143_g_EventList	= { 808008, 808009 }

--**********************************
--ÊÂ¼þ½»»¥Èë¿Ú
--**********************************
function x000143_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, "  Ta là di dân tiªp ðãi sÑ, nªu các hÕ v×a di dân ðªn ðây, có c¥n giúp ðÞ gì thì hãy lên tiªng." )
		--AddNumText(sceneId, x000143_g_scriptId, "#GThay ð±i Môn Phái", 6, 1)
		for i, eventId in x000143_g_EventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--ÊÂ¼þÁÐ±íÑ¡ÖÐmµt Ïî
--**********************************
function x000143_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	if key == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ngß½i mu¯n ð±i sang môn phái nào?" )
			AddNumText(sceneId, x000143_g_scriptId, "Thiªu Lâm", 6, 10)
			AddNumText(sceneId, x000143_g_scriptId, "Minh Giáo", 6, 11)
			AddNumText(sceneId, x000143_g_scriptId, "Cái Bang", 6, 12)
			AddNumText(sceneId, x000143_g_scriptId, "Võ Ðang", 6, 13)
			AddNumText(sceneId, x000143_g_scriptId, "Nga My", 6, 14)
			AddNumText(sceneId, x000143_g_scriptId, "Tinh Túc", 6, 15)
			AddNumText(sceneId, x000143_g_scriptId, "Thiên Long", 6, 16)
			AddNumText(sceneId, x000143_g_scriptId, "Thiên S½n", 6, 17)
			AddNumText(sceneId, x000143_g_scriptId, "Tiêu Dao", 6, 18)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if key >= 10 and key <= 18 then
		if GetHumanMenpaiPoint(sceneId,selfId) < 300000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Yêu c¥u thay ð±i môn phái phäi ðánh ð±i #G30 vÕn ði¬m môn phái#W." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local Menpai = GetMenPai(sceneId,selfId)
		if Menpai == 9 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ngß½i vçn chßa gia nh§p môn phái?" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local MenpaiStr = {"Thiªu Lâm", "Minh Giáo", "Cái Bang", "Võ Ðang", "Nga My", "Tinh Túc", "Thiên Long", "Thiên S½n", "Tiêu Dao"}

		if Menpai == key - 10 then
			BeginEvent( sceneId )
				AddText( sceneId, "ChÆng phäi ngß½i ðã là môn hÕ "..MenpaiStr[key - 9].." r°i sao?" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local XinfaID = {}
			XinfaID[0] = {1,2,3,4,5,6,55}
			XinfaID[1] = {7,8,9,10,11,12,56}
			XinfaID[2] = {13,14,15,16,17,18,57}
			XinfaID[3] = {19,20,21,22,23,24,58}
			XinfaID[4] = {25,26,27,28,29,30,59}
			XinfaID[5] = {31,32,33,34,35,36,60}
			XinfaID[6] = {37,38,39,40,41,42,61}
			XinfaID[7] = {43,44,45,46,47,48,62}
			XinfaID[8] = {49,50,51,52,53,54,63}

		local Xinfa1Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][1])
		local Xinfa2Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][2])
		local Xinfa3Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][3])
		local Xinfa4Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][4])
		local Xinfa5Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][5])
		local Xinfa6Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][6])
		local Xinfa7Lv = LuaFnGetXinFaLevel(sceneId,selfId,XinfaID[Menpai][7])

		LuaFnJoinMenpai(sceneId,selfId,9,key - 10)
		
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][1],Xinfa1Lv)
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][2],Xinfa2Lv)
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][3],Xinfa3Lv)
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][4],Xinfa4Lv)
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][5],Xinfa5Lv)
		LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][6],Xinfa6Lv)
		if Xinfa7Lv > 0 then
			LuaFnSetXinFaLevel(sceneId,selfId,XinfaID[key - 10][7],Xinfa7Lv)
		end
		
		local MenpaiPoint = GetHumanMenpaiPoint(sceneId,selfId)
		SetHumanMenpaiPoint(sceneId,selfId,MenpaiPoint - 300000)
				
		BeginEvent( sceneId )
			AddText( sceneId, "Chuy¬n ð±i môn phái thành công, xin chúc m×ng các hÕ..." )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
		local playername = GetName(sceneId, selfId)	
		local strText = format("#{_INFOUSR%s} #GtÕi #WLÕc Dß½ng #Gðã nh¶ #WPhÕm Di Thành (142,113) #Ggiúp bän thân r¶i khöi môn hÕ, sau ðó gia nh§p vào #W"..MenpaiStr[key - 9].."#G.", playername)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end

	for i, findId in x000143_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end

end

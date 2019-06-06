--L誧 D呓ngNPC
--范移城
--普通

x000143_g_ScriptId	= 143
x000143_g_EventList	= { 808008, 808009 }

--**********************************
--事件交互入口
--**********************************
function x000143_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, "  Ta l� di d鈔 ti猵 疸i s�, n猽 c醕 h� v譨 di d鈔 皙n 疴y, c� c gi鷓 疝 g� th� h銀 l阯 ti猲g." )
		--AddNumText(sceneId, x000143_g_scriptId, "#GThay 鸨i M鬾 Ph醝", 6, 1)
		for i, eventId in x000143_g_EventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--事件列表选中m祎 项
--**********************************
function x000143_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	if key == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ng呓i mu痭 鸨i sang m鬾 ph醝 n鄌?" )
			AddNumText(sceneId, x000143_g_scriptId, "Thi猽 L鈓", 6, 10)
			AddNumText(sceneId, x000143_g_scriptId, "Minh Gi醥", 6, 11)
			AddNumText(sceneId, x000143_g_scriptId, "C醝 Bang", 6, 12)
			AddNumText(sceneId, x000143_g_scriptId, "V� 衋ng", 6, 13)
			AddNumText(sceneId, x000143_g_scriptId, "Nga My", 6, 14)
			AddNumText(sceneId, x000143_g_scriptId, "Tinh T鷆", 6, 15)
			AddNumText(sceneId, x000143_g_scriptId, "Thi阯 Long", 6, 16)
			AddNumText(sceneId, x000143_g_scriptId, "Thi阯 S絥", 6, 17)
			AddNumText(sceneId, x000143_g_scriptId, "Ti陁 Dao", 6, 18)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if key >= 10 and key <= 18 then
		if GetHumanMenpaiPoint(sceneId,selfId) < 300000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Y陁 c thay 鸨i m鬾 ph醝 ph鋓 疳nh 鸨i #G30 v課 餴琺 m鬾 ph醝#W." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local Menpai = GetMenPai(sceneId,selfId)
		if Menpai == 9 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ng呓i v鏽 ch遖 gia nh m鬾 ph醝?" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local MenpaiStr = {"Thi猽 L鈓", "Minh Gi醥", "C醝 Bang", "V� 衋ng", "Nga My", "Tinh T鷆", "Thi阯 Long", "Thi阯 S絥", "Ti陁 Dao"}

		if Menpai == key - 10 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ch苙g ph鋓 ng呓i 疸 l� m鬾 h� "..MenpaiStr[key - 9].." r癷 sao?" )
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
			AddText( sceneId, "Chuy琻 鸨i m鬾 ph醝 th鄋h c鬾g, xin ch鷆 m譶g c醕 h�..." )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
		local playername = GetName(sceneId, selfId)	
		local strText = format("#{_INFOUSR%s} #Gt読 #WL誧 D呓ng #G疸 nh� #WPh誱 Di Th鄋h (142,113) #Ggi鷓 b鋘 th鈔 r秈 kh鰅 m鬾 h�, sau 痼 gia nh v鄌 #W"..MenpaiStr[key - 9].."#G.", playername)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end

	for i, findId in x000143_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end

end

--L�c D߽ngNPC
--���Ƴ�
--��ͨ

x000143_g_ScriptId	= 143
x000143_g_EventList	= { 808008, 808009 }

--**********************************
--�¼��������
--**********************************
function x000143_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, "  Ta l� di d�n ti�p ��i s�, n�u c�c h� v�a di d�n �n ��y, c� c�n gi�p �� g� th� h�y l�n ti�ng." )
		--AddNumText(sceneId, x000143_g_scriptId, "#GThay �i M�n Ph�i", 6, 1)
		for i, eventId in x000143_g_EventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x000143_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	if key == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ng߽i mu�n �i sang m�n ph�i n�o?" )
			AddNumText(sceneId, x000143_g_scriptId, "Thi�u L�m", 6, 10)
			AddNumText(sceneId, x000143_g_scriptId, "Minh Gi�o", 6, 11)
			AddNumText(sceneId, x000143_g_scriptId, "C�i Bang", 6, 12)
			AddNumText(sceneId, x000143_g_scriptId, "V� �ang", 6, 13)
			AddNumText(sceneId, x000143_g_scriptId, "Nga My", 6, 14)
			AddNumText(sceneId, x000143_g_scriptId, "Tinh T�c", 6, 15)
			AddNumText(sceneId, x000143_g_scriptId, "Thi�n Long", 6, 16)
			AddNumText(sceneId, x000143_g_scriptId, "Thi�n S�n", 6, 17)
			AddNumText(sceneId, x000143_g_scriptId, "Ti�u Dao", 6, 18)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if key >= 10 and key <= 18 then
		if GetHumanMenpaiPoint(sceneId,selfId) < 300000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Y�u c�u thay �i m�n ph�i ph�i ��nh �i #G30 v�n �i�m m�n ph�i#W." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local Menpai = GetMenPai(sceneId,selfId)
		if Menpai == 9 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ng߽i v�n ch�a gia nh�p m�n ph�i?" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		local MenpaiStr = {"Thi�u L�m", "Minh Gi�o", "C�i Bang", "V� �ang", "Nga My", "Tinh T�c", "Thi�n Long", "Thi�n S�n", "Ti�u Dao"}

		if Menpai == key - 10 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ch�ng ph�i ng߽i �� l� m�n h� "..MenpaiStr[key - 9].." r�i sao?" )
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
			AddText( sceneId, "Chuy�n �i m�n ph�i th�nh c�ng, xin ch�c m�ng c�c h�..." )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
		local playername = GetName(sceneId, selfId)	
		local strText = format("#{_INFOUSR%s} #Gt�i #WL�c D߽ng #G�� nh� #WPh�m Di Th�nh (142,113) #Ggi�p b�n th�n r�i kh�i m�n h�, sau �� gia nh�p v�o #W"..MenpaiStr[key - 9].."#G.", playername)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end

	for i, findId in x000143_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end

end

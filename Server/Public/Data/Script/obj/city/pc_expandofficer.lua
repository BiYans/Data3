--Th�nh ph� NPC
--У��

x805013_g_scriptId = 805013
x805013_g_BuildingID7 = 15

--��ӵ��to� � �¼�ID�б�
x805013_g_eventList = {600046, 600023}-- zchw add 600046 �����ռ�

--��ӵ��to� � �¼�ID�б�2 Ϊ�����ռ����� zchw 
x805013_g_eventList2 = {600047, 600048, 600049}

-- �����¼� ID �б�,�����¼��������¼�
x805013_g_eventSetList = { 600023 } 

--**********************************
--�¼��б�
--**********************************
function x805013_UpdateEventList( sceneId, selfId, targetId )
	local i = 1
	local eventId = 0

	local Humanguildid 	= GetHumanGuildID(sceneId,selfId)
	local cityguildid 	= GetCityGuildID(sceneId, selfId, sceneId)

	BeginEvent( sceneId )
		if Humanguildid == cityguildid then
			AddText( sceneId, "    иa v� v� danh ti�ng c�a bang ta tr�n giang h� do ta ��m nhi�m, c� � ki�n g� hay c� n�u ra." )
			--for i, eventId in x805013_g_eventList do
			--	CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
			--end
			
			if IsHaveMission( sceneId, selfId, 1110 ) > 0 then
				CallScriptFunction( 600023, "OnEnumerate", sceneId, selfId, targetId )
			else
				AddNumText( sceneId, x805013_g_scriptId, "#GNhi�m v� GKhu�ch Tr߽ng - 600024", 4, 600024 )
				AddNumText( sceneId, x805013_g_scriptId, "#GNhi�m v� GKhu�ch Tr߽ng - 600025", 4, 600025 )
				AddNumText( sceneId, x805013_g_scriptId, "#GNhi�m v� GKhu�ch Tr߽ng - 600026", 4, 600026 )
				AddNumText( sceneId, x805013_g_scriptId, "#GNhi�m v� GKhu�ch Tr߽ng - 600027", 4, 600027 )
			end
			
			AddNumText( sceneId, x805013_g_scriptId, "C�ng hi�n �i�m #GKhu�ch Tr߽ng", 6, 7413 )
			AddNumText( sceneId, x805013_g_scriptId, "V� nhi�m v� khu�ch tr߽ng", 11, 1 )
			AddNumText( sceneId, x805013_g_scriptId, "Gi�i thi�u v� tr߶ng", 11, 2 )
			AddNumText( sceneId, x805013_g_scriptId, "Ph߽ng ph�p ch� t�o c�ng tr�nh", 7, 3 )
			AddNumText( sceneId, x805013_g_scriptId, "T�o ��i c� cho bang h�i", 6, 4 )
			AddNumText( sceneId, x805013_g_scriptId, "Tu luy�n ph�ng ng�", 6, 5 )
			AddNumText( sceneId, x805013_g_scriptId, "X�y d�ng th�p ki�m cao c�p", 6, 6 )
		else
			AddText( sceneId, "    ��y l� �a �i�m quan tr�ng c�a tr߶ng, tr� � t� b�n bang, kh�ng ai ���c xem tr�m � ��y" )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��������
--**********************************
function x805013_OnDefaultEvent( sceneId, selfId, targetId )
	x805013_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
-- �ж�ĳc�i�¼���ng�����ͨ���� NPC ִ��
--**********************************
function x805013_IsValidEvent( sceneId, selfId, eventId )
	local i = 1
	local findId = 0
	local bValid = 0

	for i, findId in x805013_g_eventList do
		if eventId == findId then
			bValid = 1
			break
		end
	end

	if bValid == 0 then
		for i, findId in x805013_g_eventSetList do
			if CallScriptFunction( findId, "IsInEventList", sceneId, selfId, eventId ) == 1 then
				bValid = 1
				break
			end
		end
	end

	return bValid
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x805013_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() >= 600024 and GetNumText() <= 600027 then
		CallScriptFunction(600023, "ListQ_Clicked", sceneId, selfId, targetId, GetNumText())
	end
	if x805013_IsValidEvent( sceneId, selfId, eventId ) == 1 then
		CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 7413 then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i th�t s� mu�n d�ng �i�m c�ng hi�n � gia t�ng � Khu�ch Tr߽ng c�a bang h�i?" )
			AddNumText( sceneId, x805013_g_scriptId, "��ng, ta �� s�n s�ng!", 6, 74131 )
			AddNumText( sceneId, x805013_g_scriptId, "H�y...", 6, 74130 )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	end
	if GetNumText() == 74130 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
	if GetNumText() == 74131 then
		if CityGetAttr(sceneId, selfId, 6) <= 9 then
			BeginEvent(sceneId)
				AddText( sceneId, "�i�m c�ng hi�n c�a ng߽i v�n ch�a �� 10, h�y mau ��ng g�p th�m cho bang h�i." )
			EndEvent(sceneId)
			DispatchEventList( sceneId, selfId, targetId )
			return
		else
			BeginEvent(sceneId)
				AddText( sceneId, "Ta xin thay m�t m�i ng߶i �a t� ng߽i." )
				AddText( sceneId, "Ng߽i qu� th�t r�t h�o ph�ng, ��ng l� m�t �ng anh t�i." )
			EndEvent(sceneId)
			DispatchEventList( sceneId, selfId, targetId )
			CityChangeAttr(sceneId,selfId,GUILD_CONTRIB_POINT,-10)
			CityChangeAttr(sceneId,selfId,GUILD_AMBI_LEVEL,10)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
			local PlayerName = GetName(sceneId,selfId)
			local Str = format("@*;SrvMsg;GLD:#{_INFOUSR%s}#Y h�t l�ng cho bang h�i, mang 10 �i�m c�ng hi�n �n � gia t�ng #GKhu�ch Tr߽ng#Y, th�t ��ng ng��ng m�!", PlayerName)
			BroadMsgByChatPipe(sceneId,selfId,Str,6)
		end
	end
	if GetNumText() == 1 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{City_Expand_Mission_Help}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 2 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{City_Intro_JiaoChang}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 3 then
		BeginEvent(sceneId)
		AddText( sceneId, "Ch�c n�ng n�y s�p ���c th�c hi�n" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 4 then
		BeginEvent(sceneId)
		AddText( sceneId, "Ch�c n�ng n�y s�p ���c th�c hi�n" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 5 then
		BeginEvent(sceneId)
		AddText( sceneId, "Ch�c n�ng n�y s�p ���c th�c hi�n" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 6 then
		BeginEvent(sceneId)
		AddText( sceneId, "Ch�c n�ng n�y s�p ���c th�c hi�n" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x805013_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, eventId in x805013_g_eventList2 do
		if missionScriptId == eventId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			return
		end
	end
	if x805013_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		local ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
		if ret > 0 then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
		elseif ret == -1 then
			x805013_NotifyFailTips( sceneId, selfId, "Ng߽i hi�n kh�ng th� nh�n nhi�m v� n�y" )
		elseif ret == -2 then
			x805013_NotifyFailTips( sceneId, selfId, "Kh�ng th� ti�p nh�n nhi�u nhi�m v�" )
		end

		return
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x805013_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	if x805013_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		x805013_UpdateEventList( sceneId, selfId, targetId )
		return
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x805013_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	if x805013_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
		return
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x805013_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, eventId in x805013_g_eventList2 do
		if missionScriptId == eventId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
		end
	end
	
	if x805013_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
		return
	end
end

--**********************************
--�����¼�
--**********************************
function x805013_OnDie( sceneId, selfId, killerId )
end

function x805013_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

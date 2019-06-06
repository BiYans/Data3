--Th�nh ph� NPC
--�ײ�

x805014_g_scriptId = 805014
x805014_g_BuildingID8 = 7

--��ӵ��to� � �¼�ID�б�
x805014_g_eventList = { 600007 }

-- �����¼� ID �б�,�����¼��������¼�
x805014_g_eventSetList = { 600007 }

--**********************************
--�¼��б�
--**********************************
function x805014_UpdateEventList( sceneId, selfId, targetId )
	local i = 1
	local eventId = 0

	local Humanguildid 	= GetHumanGuildID(sceneId,selfId)
	local cityguildid 	= GetCityGuildID(sceneId, selfId, sceneId)

	BeginEvent( sceneId )
		if Humanguildid == cityguildid then
			AddText( sceneId, "    Bang h�i c߶ng m�nh r�t ch� tr�ng ngh� n�ng, c� vi�c g� c�n ta gi�p ng߽i kh�ng?" )
			--for i, eventId in x805014_g_eventList do
			--	CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
			--end
			
			if IsHaveMission( sceneId, selfId, 1106 ) > 0 then
				CallScriptFunction( 600007, "OnEnumerate", sceneId, selfId, targetId )
			else
				AddNumText( sceneId, x805014_g_scriptId, "#GNhi�m v� N�ng Nghi�p - 600008", 4, 600008 )
				AddNumText( sceneId, x805014_g_scriptId, "#GNhi�m v� N�ng Nghi�p - 600009", 4, 600009 )
				AddNumText( sceneId, x805014_g_scriptId, "#GNhi�m v� N�ng Nghi�p - 600010", 4, 600010 )
				AddNumText( sceneId, x805014_g_scriptId, "#GNhi�m v� N�ng Nghi�p - 600011", 4, 600011 )
			end
			
			AddNumText( sceneId, x805014_g_scriptId, "C�ng hi�n �i�m #GN�ng Nghi�p", 6, 7413 )
			AddNumText( sceneId, x805014_g_scriptId, "Gi�i thi�u nhi�m v� ph�t tri�n", 11, 1 )
			AddNumText( sceneId, x805014_g_scriptId, "Сp th�m t߶ng", 6, 3 )
			AddNumText( sceneId, x805014_g_scriptId, "Gi�i thi�u kho g�o", 11, 2 )
			AddNumText( sceneId, x805014_g_scriptId, "бi B�ng Tr�n D�a H�u", 6, 4 )
			AddNumText( sceneId, x805014_g_scriptId, "Gi�i thi�u B�ng Tr�n D�a H�u", 11, 5 )

			--life ���C�i n�y ������to� � ��Ӧ�����ѡ��
			CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "AddCityLifeAbilityOpt",sceneId, selfId, x805014_g_scriptId,x805014_g_BuildingID8,888)
		else
			AddText( sceneId, "    C�c h� kh�ng ph�i l� th�nh vi�n b�n bang, nh�n m�t tr�ng l� l�m!" )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��������
--**********************************
function x805014_OnDefaultEvent( sceneId, selfId, targetId )
	x805014_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
-- �ж�ĳc�i�¼���ng�����ͨ���� NPC ִ��
--**********************************
function x805014_IsValidEvent( sceneId, selfId, eventId )
	local i = 1
	local findId = 0
	local bValid = 0

	for i, findId in x805014_g_eventList do
		if eventId == findId then
			bValid = 1
			break
		end
	end

	if bValid == 0 then
		for i, findId in x805014_g_eventSetList do
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
function x805014_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() >= 600008 and GetNumText() <= 600011 then
		CallScriptFunction(600007, "ListQ_Clicked", sceneId, selfId, targetId, GetNumText())
	end
	if x805014_IsValidEvent( sceneId, selfId, eventId ) == 1 then
		CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
		return
	--life ����C�i n�y ������to� � ��Ӧ�����ѡ��
	elseif eventId ~= x805014_g_scriptId then
		CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnDefaultEvent",sceneId, selfId, targetId, eventId, x805014_g_scriptId, x805014_g_BuildingID8 )
		return
	end
	if GetNumText() == 7413 then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i th�t s� mu�n d�ng �i�m c�ng hi�n � gia t�ng � N�ng Nghi�p c�a bang h�i?" )
			AddNumText( sceneId, x805014_g_scriptId, "��ng, ta �� s�n s�ng!", 6, 74131 )
			AddNumText( sceneId, x805014_g_scriptId, "H�y...", 6, 74130 )
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
			CityChangeAttr(sceneId,selfId,GUILD_AGR_LEVEL,10)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
			local PlayerName = GetName(sceneId,selfId)
			local Str = format("@*;SrvMsg;GLD:#{_INFOUSR%s}#Y h�t l�ng cho bang h�i, mang 10 �i�m c�ng hi�n �n � gia t�ng #GN�ng Nghi�p#Y, th�t ��ng ng��ng m�!", PlayerName)
			BroadMsgByChatPipe(sceneId,selfId,Str,6)
		end
	end
	if GetNumText() == 1 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{City_Dev_Mission_Help}" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 2 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{City_Intro_MiCang}" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 3 then
		BeginEvent(sceneId)
			AddText( sceneId, "Ch�c n�ng n�y s�p ���c th�c hi�n" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 888 then
		BeginEvent(sceneId)
		--life ���C�i n�y ������to� � ��Ӧ�����ѡ��
		CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnEnumerate",sceneId, selfId, targetId, x805014_g_BuildingID8 )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 4 then
		--ȷ����ng��ȡ��������
		BeginEvent(sceneId)
			AddText( sceneId, "#{BGHXG_JS}" )
			AddText( sceneId, "C�c h� c� x�c nh�n d�ng 9 �i�m c�ng hi�n bang h�i �i B�ng Tr�n D�a H�u kh�ng ?" )
			AddNumText( sceneId, x805014_g_scriptId, "Duy�t", 6, 16 )
			AddNumText( sceneId, x805014_g_scriptId, "Hu�", 8, 17 )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 5 then
		--�������Ͻ���
		BeginEvent(sceneId)
			AddText( sceneId, "#{BGHXG_JS}" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 16 then
		--ȷ�ϻ�����
		x805014_BingZhenXiGua(sceneId, selfId, targetId);
	elseif GetNumText() == 17 then
		--Hu� b�������
		x805014_OnDefaultEvent( sceneId, selfId, targetId )
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x805014_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	if x805014_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		local ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
		if ret > 0 then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
		elseif ret == -1 then
			x805014_NotifyFailTips( sceneId, selfId, "Ng߽i hi�n kh�ng th� nh�n nhi�m v� n�y" )
		elseif ret == -2 then
			x805014_NotifyFailTips( sceneId, selfId, "Kh�ng th� ti�p nh�n nhi�u nhi�m v�" )
		end

		return
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x805014_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	if x805014_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		x805014_UpdateEventList( sceneId, selfId, targetId )
		return
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x805014_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	if x805014_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
		return
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x805014_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	if x805014_IsValidEvent( sceneId, selfId, missionScriptId ) == 1 then
		CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
		return
	end
end

--**********************************
--�����¼�
--**********************************
function x805014_OnDie( sceneId, selfId, killerId )
end

function x805014_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--��ȡ��������
--**********************************
function x805014_BingZhenXiGua(sceneId, selfId, targetId)
	local humanGuildId 	= GetHumanGuildID(sceneId,selfId)
	local cityGuildId 	= GetCityGuildID(sceneId, selfId, sceneId)
	if not humanGuildId or not cityGuildId or humanGuildId ~= cityGuildId then
		BeginEvent(sceneId)
			AddText( sceneId, "Ch� c� th�nh vi�n c�a b�n bang m�i c� th� �i" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return 0;
	end
	
	local guildPoint = CityGetAttr(sceneId, selfId, 6);
	if not guildPoint or guildPoint < 9 then
		BeginEvent(sceneId)
			AddText( sceneId, "�i�m c�ng hi�n bang h�i c�a c�c h� kh�ng �� 9 �i�m, kh�ng th� �i." )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return 0;
	end

	LuaFnBeginAddItem(sceneId);
		LuaFnAddItem(sceneId, 30501103, 1);
	local ret = LuaFnEndAddItem(sceneId, selfId);
	if not ret or 1 ~= ret then
		BeginEvent(sceneId)
			AddText(sceneId, "Hi�n c�c h� kh�ng th� thu ���c v�t ph�m, xin ki�m tra l�i tay n�i.");
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return 0;
	end
	
	ret = CityChangeAttr(sceneId, selfId, 6, -9);
	if not ret or ret ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId, "Thao t�c th�t b�i, xin h�y th� l�i.");
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return 0;
	end
	
	AddItemListToHuman(sceneId,selfId);
	x805014_NotifyFailTips(sceneId, selfId, "C�c h� nh�n ���c 1 mi�ng D�a h�u ߾p l�nh");
	
	local szTransferItem = GetItemTransfer(sceneId, selfId, 0);
	local selfName = LuaFnGetName(sceneId, selfId);
	local strChatMessage = "#{_INFOUSR"..selfName.."}#cff99cc h�n h� t� trong tay#G Chu Th� h�u[129, 100]#cff99cc l�y 1 mi�ng#Y#{_INFOMSG" .. szTransferItem .. "}#cff99cc, �n 1 mi�ng v�o m�t t� �u xu�ng �n b�n ch�n!";
	BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;GLD:"..strChatMessage, 6);
	x805014_OnDefaultEvent( sceneId, selfId, targetId )
end

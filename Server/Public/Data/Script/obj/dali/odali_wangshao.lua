--��i L�NPC
--����
--��ͨ

--�ű���
x002000_g_scriptId = 002000

--��ӵ��to� � �¼�ID�б�
x002000_g_eventList = { 212117, 228902, 228904, 212140, 212144 }

--**********************************
--�¼��б�
--**********************************
function x002000_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "  M�t �i l�m b�n v�i binh ng�a, ph� qu� cao sang, c�ng ch� l� m�y kh�i tho�ng qua, ch� c�n hai n߾c ��i T�ng - ��i L� b�nh an v� s�, ta c�ng th�y y�n t�m r�i" )
		for i, eventId in x002000_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��������
--**********************************
function x002000_OnDefaultEvent( sceneId, selfId, targetId )
	x002000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x002000_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x002000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002000_g_eventList do
		if missionScriptId == findId then
			local ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end

			return
		end
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x002000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x002000_g_eventList do
		if missionScriptId == findId then
			x002000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x002000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x002000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002000_OnDie( sceneId, selfId, killerId )
end
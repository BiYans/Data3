--½��

--�ű���
x003003_g_scriptId = 003003

--��ӵ��to� � �¼�ID�б�
x003003_g_eventList={}--210303, 210304}

--**********************************
--�¼��б�
--**********************************
function x003003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  Ta l� Danh y L�c T�ng c�a Tung D߽ng th� vi�n, �� h�nh y � ��y ���c 30 n�m r�i, ch�a bao gi� g�p s� c� trong �i�u tr�.")
	for i, eventId in x003003_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x003003_OnDefaultEvent( sceneId, selfId,targetId )
	x003003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x003003_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x003003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x003003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x003003_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
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
function x003003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x003003_g_eventList do
		if missionScriptId == findId then
			x003003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x003003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x003003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x003003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x003003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x003003_OnDie( sceneId, selfId, killerId )
end
--��n Ho�ng �����

--�ű���
--g_scriptId = 008014

--��ӵ��to� � �¼�ID�б�
x008014_g_eventList={}--210808} --212603,212606,210807

--**********************************
--�¼��б�
--**********************************
function x008014_UpdateEventList( sceneId, selfId,targetId )
    BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
    AddText(sceneId,"  ��ng ph� l�i v� �ch v�i t�i h�, ch�m ch� ho�n th�nh vi�c th� luy�n c�a c�c h� �i.")

	for i, eventId in x008014_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x008014_OnDefaultEvent( sceneId, selfId,targetId )
	x008014_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x008014_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x008014_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x008014_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008014_g_eventList do
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
function x008014_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x008014_g_eventList do
		if missionScriptId == findId then
			x008014_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x008014_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x008014_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x008014_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x008014_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x008014_OnDie( sceneId, selfId, killerId )
end

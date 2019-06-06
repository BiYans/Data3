--Ki�m C�c ʱǨ

--�ű���
x007005_g_scriptId = 007005

--��ӵ��to� � �¼�ID�б�
x007005_g_eventList={}--210707}	

--**********************************
--�¼��б�
--**********************************
function x007005_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)	

	local IsDone507 = IsMissionHaveDone(sceneId,selfId,507)	
	
	AddText(sceneId, "#{OBJ_jiange_0005}")
	for i, eventId in x007005_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x007005_OnDefaultEvent( sceneId, selfId,targetId )
	x007005_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x007005_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x007005_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x007005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007005_g_eventList do
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
function x007005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x007005_g_eventList do
		if missionScriptId == findId then
			x007005_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x007005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x007005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x007005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x007005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x007005_OnDie( sceneId, selfId, killerId )
end

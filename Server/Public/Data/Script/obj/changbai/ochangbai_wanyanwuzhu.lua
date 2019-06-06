--����أ��

--�ű���
x022003_g_scriptId = 022003

--��ӵ��to� � �¼�ID�б�
x022003_g_eventList={212110}--211301,211307	

--**********************************
--�¼��б�
--**********************************
function x022003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"Anh d�ng, v� ��i, thi�n l߽ng, nhi�t huy�t  ��i anh h�ng! Ng߽i l�i ��y Ho�n Nhan B�  A, mau t�a h� u�ng ch�n ti�p n�i �i.")
	for i, eventId in x022003_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x022003_OnDefaultEvent( sceneId, selfId,targetId )
	x022003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x022003_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x022003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x022003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x022003_g_eventList do
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
function x022003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x022003_g_eventList do
		if missionScriptId == findId then
			x022003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x022003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x022003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x022003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x022003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x022003_OnDie( sceneId, selfId, killerId )
end
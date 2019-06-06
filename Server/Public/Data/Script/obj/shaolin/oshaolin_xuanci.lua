--Thi�u L�mNPC
--������
--Huy�n t�
--��ͨ

--��ӵ��to� � �¼�ID�б�
x009005_g_eventList={229009, 200089, 200090, 212140, 229012, 808092}

--**********************************
--�¼��������
--**********************************
function x009005_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Ta c�m th�y Huy�n Bi s� � vi�n t�ch, kh�ng c� li�n can g� v�i �o�n gia � ��i L�")
		for i, findId in x009005_g_eventList do
			CallScriptFunction( x009005_g_eventList[i], "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x009005_OnDefaultEvent( sceneId, selfId,targetId )
	x009005_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x009005_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x009005_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_SHAOLIN )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x009005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x009005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x009005_g_eventList do
		if missionScriptId == findId then
			x009005_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x009005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x009005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x009005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x009005_OnDie( sceneId, selfId, killerId )
end


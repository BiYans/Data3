--��i L�NPC
--���ng�
--����ָ��

--�ű���
x002069_g_ScriptId = 002069

--��ӵ��to� � �¼�ID�б�
x002069_g_eventList={808097, 808098, 808099, 808093}

--**********************************
--�¼��������
--**********************************
function x002069_OnDefaultEvent( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = " c� n߽ng"
	else
		PlayerSex = " c�c h�"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  "..PlayerName..PlayerSex..", ph�i �i x� t� t� v�i tr�n th� c�a ta �y. Thao t�c c� g� kh�ng r�, ta c� th� gi�i ��p cho c�c h�.")
		
		for i, eventId in x002069_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
		AddNumText(sceneId,x002069_g_ScriptId,"Sinh m�nh tr�n th� kh�ng ��?",11,0)
		AddNumText(sceneId,x002069_g_ScriptId,"Hoan h� tr�n th� kh�ng ��?",11,1)
		AddNumText(sceneId,x002069_g_ScriptId,"N�ng cao ��ng c�p tr�n th�?",11,2)
		AddNumText(sceneId,x002069_g_ScriptId,"L�m th� n�o � b�t tr�n th�?",11,3)

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x002069_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x002069_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end

	if	GetNumText() == 0	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{OBJ_dali_0041}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif	GetNumText() == 1	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{OBJ_dali_0042}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	elseif	GetNumText() == 2	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{OBJ_dali_0043}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif	GetNumText() == 3	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{OBJ_dali_0044}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x002069_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002069_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId, targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId, missionScriptId )
			end
			return
		end
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x002069_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x002069_g_eventList do
		if missionScriptId == findId then
			x002069_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x002069_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002069_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x002069_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002069_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002069_OnDie( sceneId, selfId, killerId )
end

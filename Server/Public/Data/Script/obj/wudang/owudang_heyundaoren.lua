--V� �angNPC  ѧϰ��������
--����
--��ͨ

--�ű���
x012001_g_ScriptId = 012001

--��ӵ��to� � �¼�
--estudy_liandan = 713519
--elevelup_liandan = 713578
--edialog_liandan = 713618

--��ӵ��to� � �¼�ID�б�
x012001_g_eventList={713519,713578,701608}	

--**********************************
--�¼��б�
--**********************************
function x012001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Ch�nh l� t�n Ho�ng ��i nh�n h�m h�i ��i s� huynh! Ti�u s� mu�i v�n c�n n�i t�t cho h�n, qu� th�t kh�ng th� ch�u n�i")
		for i, eventId in x012001_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText( sceneId, x012001_g_ScriptId, "Gi�i thi�u c�ch luy�n �n", 11, 100 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x012001_OnDefaultEvent( sceneId, selfId,targetId )
	x012001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x012001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{function_help_035}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	for i, findId in x012001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x012001_g_ScriptId )
			return
		end
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x012001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x012001_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--�ܾ���NPCto� � ����
--**********************************
function x012001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for i, findId in x012001_g_eventList do
		if missionScriptId == findId then
			x012001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x012001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x012001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x012001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x012001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x012001_OnDie( sceneId, selfId, killerId )
end

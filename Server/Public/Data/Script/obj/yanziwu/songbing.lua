--������ �α� û��ʲôʵ�ʹ���

--�ű���
x402262_g_scriptId = 402262

--��ӵ�е��¼�ID�б�
x402262_g_eventList={}	

--**********************************
--�¼��б�
--**********************************
function x402262_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nRand = random(4)
		local str = ""
		if nRand == 1  then
			str = "  Nghe n�i l�n n�y ph�n t�c m�i t�i t� ��i �c nh�n �n �m s�t H� Di�n B�o t߾ng qu�n!"
		elseif nRand == 2 then
			str = "  H� Di�n B�o t߾ng qu�n �ang g�p nguy hi�m, m�i c�c ng߽i ch�y nhanh �n k� h�m � b�o v� h�n!"
		elseif nRand == 3 then
			str = "  H� Di�n B�o t߾ng qu�n l� h� t߾ng hi�m c� c�a ��i T�ng, am hi�m th�y chi�n, c� h�n � ��y ��i T�ng th�y qu�n s� t�t th�ng!"
		else
			str = "  N�u ta c� kinh c�ng nh�t �nh c�ng s� bay l�n l� sen ti�n �n k� h�m b�o v� H� Di�n B�o t߾ng qu�n!"
		end
		
		AddText(sceneId, str)		    				
		for i, eventId in x402262_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��������
--**********************************
function x402262_OnDefaultEvent( sceneId, selfId,targetId )
	x402262_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x402262_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x402262_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x402262_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402262_g_eventList do
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
--�ܾ���NPC������
--**********************************
function x402262_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			x402262_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x402262_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x402262_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x402262_OnDie( sceneId, selfId, killerId )

end


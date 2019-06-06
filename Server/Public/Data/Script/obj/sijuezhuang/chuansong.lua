-- 899994
-- ��̫�� ��կ������

--kich ban goc hao
x899994_g_scriptId = 899994

--��ӵ�е��¼�ID�б�
x899994_g_eventList={893063}

--**********************************
--�¼��б�
--**********************************
function x899994_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"   C�a ta ngh�a ph� phan x� v�n l� k� ngh� th� gia � t�, trong c�ng c� tuy�t th� k� ngh� b� b�o. Nh�ng l�y c�m k� th� h�a n�i ti�ng giang h� t� tuy�t trang l�i d�ng c�c lo�i hi�m �c th� �o�n �em b� b�o c߾p �i, c�n ngh� phan gia di�t m�n. Ta ngh�a ph� nh�n r�i xu�ng v�ch n�i �en c� th� ��o tho�t, nh�ng r�i v�o 2 ch�n t�n ph�, ta v�n �nh �em b� b�o �o�t l�i n�y t�m nguy�n, b�t �c d� l�c b�t t�ng t�m, l�c n�y kh�n c�u ch� v� ��i hi�p tr� ta �o�t l�i b� b�o, l�m cho ti�u n� t� c� th� t�n ph�n hi�u t�m")
	AddText(sceneId,"   Ch� � h� th�ng nhi�m v� kh� xin c�n tr�ng")

	AddNumText( sceneId, x899994_g_scriptId, "V� t� tuy�t trang",0 ,2  )
	
	for i, eventId in x899994_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--Su kien lan nhau cua vao
--**********************************
function x899994_OnDefaultEvent( sceneId, selfId,targetId )
	x899994_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x899994_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 2 then
	BeginEvent(sceneId)
	    AddText(sceneId,"T� tuy�t trang ho�n m� quan ph߽ng ph� b�n, ch� y�u r�i xu�ng nguy�n li�u th�ng c�p v� h�n, m�i ng�y 3 l��t, cu�i c�ng th�nh c�ng ��nh ch�t chung c�c BOSS sau kh�ng c� ng߶i kh� ��t ���c m�t c�i t� tuy�t b�o t߽ng. #r#Y ch� �: BOSS k� n�ng ho�n m� c�ng quan ph߽ng gi�ng nhau, c�n th�n")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
		return
	end

	for i, findId in x899994_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--���ܴ�NPC������
--**********************************
function x899994_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
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
--�ܾ���NPC������
--**********************************
function x899994_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��Ҫ����NPC���¼��б�
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			x899994_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�������Ѿ���������
--**********************************
function x899994_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ�����������
--**********************************
function x899994_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x899994_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- �Ի�������Ϣ��ʾ
--**********************************
function x899994_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

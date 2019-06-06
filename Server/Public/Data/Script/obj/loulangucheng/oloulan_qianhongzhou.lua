x001154_g_ScriptId = 001154
--**********************************
--�¼��������
--**********************************
function x001154_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#W� gi�a hoang m�c, th�y ng߶i �� �ang ch� luy�n m�t lo�i �m kh� th�n k�#Y B�ng Ph�ch Th�n Ch�m#W. Do t�i h� kh�n c�u, n� hi�p �� �� truy�n th� c�ch th�c ch� luy�n cho t�i h�." )
		AddNumText( sceneId, x001154_g_ScriptId, "#G��c th�nh B�ng Ph�ch Th�n Ch�m", 6, 1 )
		AddNumText( sceneId, x001154_g_ScriptId, "R�i kh�i", 9, 9 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x001154_OnEventRequest( sceneId, selfId, targetId, eventId)
	
	if GetNumText() == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "C�c h� c� x�c nh�n d�ng 20 #GH�n B�ng Tinh Th�ch #W� ��c th�nh #GB�ng Ph�ch Th�n Ch�m#W?" )
			AddText( sceneId, "C�c h� c� th� t�y l�i ��ng c�p c�a #GB�ng Ph�ch Th�n Ch�m #W� ��t ���c ch� s� t�i �u nh�t." )
			AddNumText( sceneId, x001154_g_ScriptId, "#GTa �ng �", 6, 11 )
			AddNumText( sceneId, x001154_g_ScriptId, "Hu�", 9, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if GetNumText() == 11 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if GetNumText() == 9 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
end
--**********************************
-- �Ի�������Ϣ��ʾ
--**********************************
function x001154_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- ��Ļ�м���Ϣ��ʾ
--**********************************
function x001154_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

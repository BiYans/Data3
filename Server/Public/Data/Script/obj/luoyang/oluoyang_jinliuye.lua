--����NPC
--����ү
--��ͨ

x000100_g_scriptId 	= 181000
x000100_g_gotoact	 	= 2
x000100_g_YBBTIntro = 11     --Ԫ����̯����
x000100_g_leave			= 20

--**********************************
--�¼��������
--**********************************
function x000100_OnDefaultEvent( sceneId, selfId,targetId )
local	nam	= LuaFnGetName( sceneId, selfId )
	BeginEvent(sceneId)
		AddText(sceneId,"Ch�o m�ng kh�ch qu�, v�a th�y ng�i hi�n di�n ta �� l�nh cho th�ng tri t�ng b� b�n kia l�m th�t t�t c�ng vi�c thi�t ��i. Ng�i mu�n �i t�ng b� c�a ch�ng ta kh�ng ?")
            AddNumText( sceneId, x000100_g_scriptId, "Ph�a tr߾c l� ti�n trang t�ng b�", 9, x000100_g_gotoact)
            AddNumText( sceneId, x000100_g_scriptId, "R�i kh�i", -1, x000100_g_leave)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x000100_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == x000100_g_gotoact then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 181,65,62)
	elseif GetNumText() == x000100_g_YBBTIntro then
	  BeginEvent( sceneId )
			AddText( sceneId, "#{YBBT_081023_2}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	elseif GetNumText() == x000100_g_leave then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
    end
end

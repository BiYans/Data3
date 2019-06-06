x210531_g_ScriptId = 210531

function x210531_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "Luy�n h�n th�n kh� c� th� gi�p th�n binh c�a c�c h� bi�n �i kh�n l߶ng, ch� s� t�ng cao, s�c chi�n �u v��t b�t" )
		AddNumText( sceneId, x210531_g_ScriptId, "Luy�n H�n Th�n Kh�", 6, 1 )
		AddNumText( sceneId, x210531_g_ScriptId, "Luy�n H�n Th�n Kh� 102", 6, 3 )
		AddNumText( sceneId, x210531_g_ScriptId, "Tr�ng T�y Th�n Kh� 6 Sao", 6, 4 )
		AddNumText( sceneId, x210531_g_ScriptId, "H�p Th�nh Th�n Binh Ph�", 6, 2 )
		AddNumText( sceneId, x210531_g_ScriptId, "Ta ch� �i ngang qua ��y", 8, 9 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x210531_OnEventRequest( sceneId, selfId, targetId, eventId)
	local key = GetNumText()
	
	if key == 4 then
		BeginEvent(sceneId)
			AddText( sceneId, "N�u c�c h� kh�ng h�i l�ng v�i thu�c t�nh c�a th�n binh th� ta c� th� gi�p c�c h� t�y l�i thu�c t�nh." )
			AddText( sceneId, "#GTh�n kh� 86 ti�u hao 1 c�i Th�n Binh Ph� C�p 1." )
			AddText( sceneId, "#GTh�n kh� 96 ti�u hao 1 c�i Th�n Binh Ph� C�p 2." )
			AddText( sceneId, "#GTh�n kh� 102 ti�u hao 1 c�i Th�n Binh Ph� C�p 3." )
			AddNumText( sceneId, x210531_g_ScriptId, "Ti�n H�nh Tr�ng T�y", 6, 41 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta ch� �i ngang qua ��y", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 41 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,3)
			--UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 3 then
		BeginEvent(sceneId)
			AddText( sceneId, "Th�n kh� 102 sau khi luy�n h�n s� th�ng c�p l�n 6 sao v� kh�ng thay �i c�p �." )
			AddText( sceneId, "#GC�n ti�u hao 5 Th�n Binh Ph� C�p 3." )
			AddNumText( sceneId, x210531_g_ScriptId, "Ti�n H�nh Luy�n H�n", 6, 31 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta ch� �i ngang qua ��y", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 31 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,2)
			--UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 2 then
		BeginEvent(sceneId)
			AddText( sceneId, "Ь h�p th�nh Th�n Binh Ph� 2 c�n 5 c�i Th�n Binh Ph� 1." )
			AddText( sceneId, "Ь h�p th�nh Th�n Binh Ph� 3 c�n 5 c�i Th�n Binh Ph� 2." )
			AddNumText( sceneId, x210531_g_ScriptId, "H�p Th�nh Th�n Binh Ph� 2", 6, 20 )
			AddNumText( sceneId, x210531_g_ScriptId, "H�p Th�nh Th�n Binh Ph� 3", 6, 21 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end	

	if key == 20 then
		local TBP1 = LuaFnGetAvailableItemCount(sceneId,selfId,30505816)
		if TBP1 < 5 then
			x210531_NotifyFailTips( sceneId, selfId, "Ng߽i v�n ch�a c� �� 5 c�i Th�n Binh Ph� 1" )
			return
		end
		
		local FreeDC = LuaFnGetPropertyBagSpace(sceneId,selfId)
		if FreeDC < 1 then
			x210531_NotifyFailTips( sceneId, selfId, "C�n 1 � tr�ng trong ��o C�" )
			return
		end

		LuaFnDelAvailableItem(sceneId,selfId,30505816,5)
		local NewItemPos = TryRecieveItem(sceneId,selfId,30505817,1)
		x210531_NotifyFailTips( sceneId, selfId, "Ch�c m�ng ng߽i �� h�p th�nh Th�n Binh Ph� C�p 2." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent(sceneId)
			AddText( sceneId, "�� h�p th�nh Th�n Binh Ph� C�p 2, ng߽i c� mu�n ti�p t�c?" )
			AddNumText( sceneId, x210531_g_ScriptId, "Ti�p t�c", 6, 20 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if key == 21 then
		local TBP2 = LuaFnGetAvailableItemCount(sceneId,selfId,30505817)
		if TBP2 < 5 then
			x210531_NotifyFailTips( sceneId, selfId, "Ng߽i v�n ch�a c� �� 5 c�i Th�n Binh Ph� 2" )
			return
		end

		local FreeDC = LuaFnGetPropertyBagSpace(sceneId,selfId)
		if FreeDC < 1 then
			x210531_NotifyFailTips( sceneId, selfId, "C�n 1 � tr�ng trong ��o C�" )
			return
		end

		LuaFnDelAvailableItem(sceneId,selfId,30505817,5)
		local NewItemPos = TryRecieveItem(sceneId,selfId,30505908,1)
		x210531_NotifyFailTips( sceneId, selfId, "Ch�c m�ng ng߽i �� h�p th�nh Th�n Binh Ph� C�p 3." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent(sceneId)
			AddText( sceneId, "�� h�p th�nh Th�n Binh Ph� C�p 3, ng߽i c� mu�n ti�p t�c?" )
			AddNumText( sceneId, x210531_g_ScriptId, "Ti�p t�c", 6, 21 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if key == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "Sau khi luy�n h�n, th�n kh� s� mang c�p � 86/96. Ng߽i h�y l�a ch�n th�t k�!" )
			AddNumText( sceneId, x210531_g_ScriptId, "Thi�u L�m - D�ch Thi�n Ph� T� Tr��ng", 6, 10 )
			AddNumText( sceneId, x210531_g_ScriptId, "Minh Gi�o - X�ch Di�m C�u V�n �ao", 6, 11 )
			AddNumText( sceneId, x210531_g_ScriptId, "C�i Bang - Tr�m �u �o�n S�u Th߽ng", 6, 12 )
			AddNumText( sceneId, x210531_g_ScriptId, "V� �ang - V�n Nh�n Long Uy�n Ki�m", 6, 13 )
			AddNumText( sceneId, x210531_g_ScriptId, "Nga My - H�m Quang L�ng �nh Ki�m", 6, 14 )
			AddNumText( sceneId, x210531_g_ScriptId, "Tinh T�c - Chuy�n H�n Di�t Ph�ch C�u", 6, 15 )
			AddNumText( sceneId, x210531_g_ScriptId, "Thi�n Long - Thi�n Tinh Di�u D߽ng Ho�n", 6, 16 )
			AddNumText( sceneId, x210531_g_ScriptId, "Thi�n S�n - To�i T�nh V� �nh Ho�n", 6, 17 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ti�u Dao - L�i Minh Ly H�a Phi�n", 6, 18 )
			AddNumText( sceneId, x210531_g_ScriptId, "M� Dung - Tinh Di V� Ng�n Ki�m", 6, 19 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta ch� �i ngang qua ��y", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 10 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 11 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 12 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,2)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 13 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,3)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 14 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,4)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 15 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,5)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 16 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,6)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 17 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,7)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 18 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,8)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 19 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,9)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 9 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
end
--**********************************
-- �Ի�������Ϣ��ʾ
--**********************************
function x210531_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- ��Ļ�м���Ϣ��ʾ
--**********************************
function x210531_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end


x400989_g_ScriptId = 400989


x400989_left 	=226.0000
x400989_right	=230.0000

x400989_top  	=201.0000
x400989_bottom	=205.0000

--��ҽ���m�t c�i area ʱ����
function x400989_OnEnterArea( sceneId, selfId )

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400989_g_ScriptId);
		UICommand_AddString(sceneId, "GotoTKNH");
		UICommand_AddString(sceneId, "#cfff263Thi�n K� Nam Ho�i cho ph�p tuy�n chi�n, #Gkh�ng s�t kh�#cfff263, c� th� x�y ra #GPK#cfff263. Ch� � b�o tr�ng.#r    #cfff263 Trong khu v�c n�y #Gch� �ng t�n c�ng#cfff263 ng߶i ch�i kh�c#G kh�ng b� tr�ng ph�t#cfff263.#r    #cfff263C� mu�n v�o kh�ng?");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)

	-- CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 432,90,86)
end

--���T�i m�t c�i area ����m�t ��ʱ��û����ʱ����
function x400989_OnTimer( sceneId, selfId )
	-- �� gi�y,��T�i C�i n�y  area ͣ�������
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5 gi�y����δ����
	if StandingTime >= 5000 then
		x400989_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--����뿪m�t c�i area ʱ����
function x400989_OnLeaveArea( sceneId, selfId )
end

--**********************************
--������ں���
--**********************************
function x400989_GotoTKNH( sceneId, selfId, targetId )	-- �i�m���������ִ�д˽ű�
	
	-- ��������ng����ng��T�i C�i n�y ��Χ��
	if sceneId ~= 465 then
		--Ng߽i �� kh�ng � khu v�c v�n chuy�n.
		BeginEvent(sceneId)
			AddText(sceneId,"Ng߽i �� kh�ng � khu v�c v�n chuy�n.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400989_left or
			targetX > x400989_right or
			targetZ < x400989_top  or
			targetZ > x400989_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"Ng߽i �� kh�ng � khu v�c v�n chuy�n.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 468,135,220)
end

--�����ݵ�


--�ű���
x898989_g_scriptId = 898989

--**********************************
-- OnTime
--**********************************
function x898989_OnSceneTimer(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		x898989_DoHanYuLogic( sceneId, nHumanId )
	end
end

--**********************************
-- �һ��Ӿ����߼�
--**********************************
function x898989_DoHanYuLogic( sceneId, selfId )

	local CurLevel = LuaFnGetLevel( sceneId, selfId )
	if CurLevel >= 90 then
		CallScriptFunction((400900),"TransferFunc",sceneId,selfId,151,45,35)
		BeginEvent(sceneId)
			AddText(sceneId,"#r       #YC�nh c�o h�nh vi can thi�p n�i dung tr� ch�i!#r")
			AddText(sceneId,"C�c h� �� c� c�p � l�n h�n 90, � ngh� kh�ng tham gia Ph� C�nh c�a t�n th�.")
		EndEvent(senceId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
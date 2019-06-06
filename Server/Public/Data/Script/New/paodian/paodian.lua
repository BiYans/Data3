--在线泡点


--脚本号
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
-- 挂机加经验逻辑
--**********************************
function x898989_DoHanYuLogic( sceneId, selfId )

	local CurLevel = LuaFnGetLevel( sceneId, selfId )
	if CurLevel >= 90 then
		CallScriptFunction((400900),"TransferFunc",sceneId,selfId,151,45,35)
		BeginEvent(sceneId)
			AddText(sceneId,"#r       #YC鋘h c醥 h鄋h vi can thi畃 n礽 dung tr� ch絠!#r")
			AddText(sceneId,"C醕 h� 疸 c� c 鸬 l緉 h絥 90, 皤 ngh� kh鬾g tham gia Ph� C鋘h c黙 t鈔 th�.")
		EndEvent(senceId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
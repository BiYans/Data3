-- 402247
-- 连弩塔 

--脚本号
x402247_g_scriptId = 402247

--所拥有的事件ID列表
x402247_g_eventList={}

-- 木材ID  (暂时用别的物品代替)
x402247_g_Item = 40004430


--**********************************
--事件列表
--**********************************
function x402247_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		--AddText(sceneId, "  我是连弩塔，丘果不给我说话。")		    				

		if LuaFnGetCopySceneData_Param(sceneId, 8) >= 10  then
		
			local szName = GetName(sceneId, targetId)
			if szName == "Th醦 li阯 n� tr呔c"  then
				AddText(sceneId, "  Th醦 li阯 n�, s� t� 鸬ng t c鬾g m鴆 ti陁 k� th� xung quanh.")
				local nCount = LuaFnGetCopySceneData_Param(sceneId, 9)
				if nCount < 5  then
					local str = "S豠 ch鎍 c騨 c " .. 5-nCount .. " c醝 m礳 t鄆"
					AddNumText( sceneId, x402247_g_scriptId, str, 10 ,1 )
				end
				
			elseif szName == "Th醦 li阯 n� sau"  then
				AddText(sceneId, "  Th醦 li阯 n�, s� t� 鸬ng t c鬾g m鴆 ti陁 k� th� xung quanh.")
				local nCount = LuaFnGetCopySceneData_Param(sceneId, 10)
				if nCount < 5  then
					local str = "S豠 ch鎍 c騨 c " .. 5-nCount .. " c醝 m礳 t鄆"
					AddNumText( sceneId, x402247_g_scriptId, str, 10 ,2 )
				end
				
			elseif szName == "Th醦 tr� li畊"  then
				AddText(sceneId, "  Th醦 tr� li畊, c� th� ph� h癷 m醬 t c� c醕 m鴆 ti陁 xung quanh l� bg h鎢.")
				local nCount = LuaFnGetCopySceneData_Param(sceneId, 11)
				if nCount < 10  then
					local str = "S豠 ch鎍 c騨 c " .. 10-nCount .. " c醝 m礳 t鄆"
					AddNumText( sceneId, x402247_g_scriptId, str, 10 ,3 )
				end
				
			elseif szName == "Th醦 ph騨g ng�"  then
				AddText(sceneId, "  Th醦 ph騨g ng�, c� th� l鄊 gi鋗 c醕 cu礳 t c鬾g c黙 k� th� c� c醕 m鴆 ti陁 xung quanh.")
				local nCount = LuaFnGetCopySceneData_Param(sceneId, 12)
				if nCount < 5  then
					local str = "S豠 ch鎍 c騨 c " .. 5-nCount .. " c醝 m礳 t鄆"
					AddNumText( sceneId, x402247_g_scriptId, str, 10 ,4 )
				end
				
			end
		end
	
		for i, eventId in x402247_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x402247_OnDefaultEvent( sceneId, selfId,targetId )
	x402247_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x402247_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	local nNumText = GetNumText()
	if nNumText == 1  then
		local nCount = LuaFnGetCopySceneData_Param(sceneId, 9)
		nCount = 5 - nCount
		-- 背包中可以删除的“木材”的总数
		local nItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x402247_g_Item) 
		if nItemCount > nCount  then
			nItemCount = nCount
		end
		local bDelOk = LuaFnDelAvailableItem(sceneId,selfId, x402247_g_Item, nItemCount)
		if bDelOk == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 9, 5-(nCount-nItemCount) )
		end
		
		if LuaFnGetCopySceneData_Param(sceneId, 9) >= 5  then
			
		end
	
	elseif nNumText == 2  then
		local nCount = LuaFnGetCopySceneData_Param(sceneId, 10)
		nCount = 5 - nCount
		-- 背包中可以删除的“木材”的总数
		local nItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x402247_g_Item) 
		if nItemCount > nCount  then
			nItemCount = nCount
		end
		local bDelOk = LuaFnDelAvailableItem(sceneId,selfId, x402247_g_Item, nItemCount)
		if bDelOk == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 10, 5-(nCount-nItemCount) )
		end

		if LuaFnGetCopySceneData_Param(sceneId, 10) >= 5  then
			
		end
		
	elseif nNumText == 3  then
		local nCount = LuaFnGetCopySceneData_Param(sceneId, 11)
		nCount = 10 - nCount
		-- 背包中可以删除的“木材”的总数
		local nItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x402247_g_Item) 
		if nItemCount > nCount  then
			nItemCount = nCount
		end
		local bDelOk = LuaFnDelAvailableItem(sceneId,selfId, x402247_g_Item, nItemCount)
		if bDelOk == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 11, 10-(nCount-nItemCount) )
		end

		if LuaFnGetCopySceneData_Param(sceneId, 11) >= 10  then
			
		end
		
	elseif nNumText == 4  then
		local nCount = LuaFnGetCopySceneData_Param(sceneId, 12)
		nCount = 5 - nCount
		-- 背包中可以删除的“木材”的总数
		local nItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x402247_g_Item) 
		if nItemCount > nCount  then
			nItemCount = nCount
		end
		local bDelOk = LuaFnDelAvailableItem(sceneId,selfId, x402247_g_Item, nItemCount)
		if bDelOk == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 12, 5-(nCount-nItemCount) )
		end

		if LuaFnGetCopySceneData_Param(sceneId, 12) >= 5  then
			
		end
		
	end

	if nNumText==1 or nNumText==2 or nNumText==3 or nNumText==4  then
		
		BeginEvent(sceneId)
			local szName = GetName(sceneId, targetId)
			if szName == "Th醦 li阯 n� tr呔c"  then
				AddText(sceneId, "  Th醦 li阯 n�, s� t� 鸬ng t c鬾g m鴆 ti陁 k� th� xung quanh.")
			elseif szName == "Th醦 li阯 n� sau"  then
				AddText(sceneId, "  Th醦 li阯 n�, s� t� 鸬ng t c鬾g m鴆 ti陁 k� th� xung quanh.")
			elseif szName == "Th醦 tr� li畊"  then
				AddText(sceneId, "  Th醦 tr� li畊, c� th� ph� h癷 m醬 t c� c醕 m鴆 ti陁 xung quanh l� bg h鎢.")
			elseif szName == "Th醦 ph騨g ng�"  then
				AddText(sceneId, "  Th醦 ph騨g ng�, c� th� l鄊 gi鋗 c醕 cu礳 t c鬾g c黙 k� th� c� c醕 m鴆 ti陁 xung quanh.")
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	for i, findId in x402247_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x402247_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402247_g_eventList do
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
--拒绝此NPC的任务
--**********************************
function x402247_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x402247_g_eventList do
		if missionScriptId == findId then
			x402247_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x402247_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402247_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x402247_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x402247_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x402247_OnDie( sceneId, selfId, killerId )

end


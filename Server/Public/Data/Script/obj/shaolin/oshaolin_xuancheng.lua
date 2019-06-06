--铜人巷副本任务npc

--脚本号
x009014_g_scriptId = 009014


--所拥有to� 鸬 事件ID列表
x009014_g_eventList={220901}

--**********************************
--事件列表
--**********************************
function x009014_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"  "..PlayerName.." , Thi猽 L鈓 t� c� 邪ng Nh鈔 H課g n眎 danh thi阯 h�, c醕 h� c� mu痭 th� th醕h b鋘 th鈔 kh鬾g?")
		for i, findId in x009014_g_eventList do
			CallScriptFunction( x009014_g_eventList[i], "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x009014_OnDefaultEvent( sceneId, selfId,targetId )
	x009014_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x009014_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x009014_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ti猵 th薔PCto� 鸬 任务
--**********************************
function x009014_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009014_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--拒绝此NPCto� 鸬 任务
--**********************************
function x009014_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后,要Tr� v玁PCto� 鸬 事件列表
	for i, findId in x009014_g_eventList do
		if missionScriptId == findId then
			x009014_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续(已经接了任务)
--**********************************
function x009014_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009014_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完to� 鸬 任务
--**********************************
function x009014_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x009014_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x009014_OnDie( sceneId, selfId, killerId )
end

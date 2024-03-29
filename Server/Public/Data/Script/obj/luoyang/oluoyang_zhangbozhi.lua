--L誧 D呓ngNPC
--张伯志
--普通

--脚本号
x000078_g_ScriptId = 000078

x000078_g_eventList={250512}
--**********************************
--事件列表
--**********************************
function x000078_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Ng呓i mu痭 c呔p ti陁 kh鬾g... �... l� ta n骾... Ng呓i c� mu痭 nghe nh誧 kh鬾g?")
	for i, eventId in x000078_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000078_OnDefaultEvent( sceneId, selfId,targetId )
	x000078_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x000078_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000078_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000078_g_ScriptId )
			return
		end
	end
end

--**********************************
--Ti猵 th薔PCto� 鸬 任务
--**********************************
function x000078_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000078_g_eventList do
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
--拒绝此NPCto� 鸬 任务
--**********************************
function x000078_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后,要Tr� v玁PCto� 鸬 事件列表
	for i, findId in x000078_g_eventList do
		if missionScriptId == findId then
			x000078_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续(已经接了任务)
--**********************************
function x000078_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000078_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完to� 鸬 任务
--**********************************
function x000078_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000078_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000078_OnDie( sceneId, selfId, killerId )
end

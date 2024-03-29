--L鈛 LanNPC....
--烹饪大师....

--脚本号
x001113_g_ScriptId = 001113

--所拥有to� 鸬 事件Id列表
--elevelup_pengren = 713561
--edialog_pengren = 713601
--所拥有to� 鸬 事件ID列表
x001113_g_eventList={713561,713601}

--**********************************
--事件列表
--**********************************
function x001113_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{LLGC_20080324_06}")
	for i, eventId in x001113_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001113_OnDefaultEvent( sceneId, selfId,targetId )
	x001113_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x001113_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x001113_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x001113_g_ScriptId )
		return
	end
end
end

--**********************************
--Ti猵 th薔PCto� 鸬 任务
--**********************************
function x001113_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001113_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,ABILITY_PENGREN )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPCto� 鸬 任务
--**********************************
function x001113_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后,要Tr� v玁PCto� 鸬 事件列表
	for i, findId in x001113_g_eventList do
		if missionScriptId == findId then
			x001113_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续(已经接了任务)
--**********************************
function x001113_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001113_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完to� 鸬 任务
--**********************************
function x001113_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001113_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

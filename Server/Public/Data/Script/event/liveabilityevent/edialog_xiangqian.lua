--对话事件 

--脚本号
x713603_g_ScriptId = 713603

--**********************************
--任务入口函数
--**********************************
function x713603_OnDefaultEvent( sceneId, selfId, targetId )
	dialog = "#{event_liveabilityevent_0003}"
		BeginEvent(sceneId)
		AddText(sceneId, dialog)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713603_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713603_g_ScriptId,"T読 h� mu痭 t靘 hi瑄 ch誱 kh鋗",11,-1)
end

--**********************************
--检测Ti猵 th跫�
--**********************************
function x713603_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti猵 th�
--**********************************
function x713603_OnAccept( sceneId, selfId, AbilityId )
end

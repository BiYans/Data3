--Nga MyNPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x015031_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Ta l� 甬 t� ph醝 Nga My")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--Thi猽 L鈓NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x009031_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Ta l� 甬 t� ph醝 Thi猽 L鈓.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

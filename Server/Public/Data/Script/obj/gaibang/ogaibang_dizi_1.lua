--C醝 BangNPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x010030_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  N絠 疴y l� t眓g 疣 c黙 C醝 Bang. N猽 ng呓i c gi鷓 疝, h銀 皙n ch� g c眓g vi畁 t靘 Tri Kh醕h C醝 gi鷓 cho.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

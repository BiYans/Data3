--黄龙NPC
--村民
--普通

--**********************************
--事件交互入口
--**********************************
function x023006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  G 疴y tr Ho鄋g Long kh鬾g 疬㧟 y阯 t竛h, nghe n骾 qu醝 v 皤u b� M鉵g C醝 h鼀 di畉, ch鷑g ta s g tai h鱝 m 馥u 皙n n緄..")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--C醝 BangNPC
--刘竹庄
--普通

--**********************************
--事件交互入口
--**********************************
function x010003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"To鄋 朽 ch� th錸g ch裞 trong bang kh� nhanh, ta mu痭 h鱟 t 鬾g !")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

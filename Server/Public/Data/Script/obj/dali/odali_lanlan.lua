--姓i L齆PC
--兰兰
--普通

--**********************************
--事件交互入口
--**********************************
function x002052_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  V呓ng Phi h鄋g ng鄖 錸 kh鬾g ngon, ng� kh鬾g y阯. N猽 c� ti猵 t鴆 nh� v s� 鋘h h叻ng 皙n long th�")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

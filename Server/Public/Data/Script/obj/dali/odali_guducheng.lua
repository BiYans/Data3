--姓i L齆PC
--古笃诚
--普通

--**********************************
--事件交互入口
--**********************************
function x002012_OnDefaultEvent( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = " c� n呓ng "
	else
		PlayerSex = " c醕 h� "
	end
	BeginEvent(sceneId)
		AddText(sceneId,"  "..PlayerName..PlayerSex..", l鈛 l kh鬾g g, ho鄋g th唼ng 餫ng 瘙i c醕 h� 黏y")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

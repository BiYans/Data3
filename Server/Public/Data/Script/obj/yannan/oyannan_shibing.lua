--Nh課 NamNPC
--村民
--普通

--**********************************
--事件交互入口
--**********************************
function x018006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  衖 theo 鹫i so醝 Ch黱g Th� Ho鄋h, c� th� l c鬾g l nghi畃; 餴 theo gi醡 qu鈔 M� Th譨 S鋘h, c� th� th錸g quan ph醫 t鄆. Nh遪g hai vi甤 n鄖 c� c� c鋗 gi醕 l� r m鈛 thu鏽.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

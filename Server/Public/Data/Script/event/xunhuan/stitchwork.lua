--缝纫台

function x801013_OnDefaultEvent( sceneId, selfId, targetId )	-- 餴琺击该任务后执行此脚本
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
		UICommand_AddInt(sceneId,2)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 41)
end

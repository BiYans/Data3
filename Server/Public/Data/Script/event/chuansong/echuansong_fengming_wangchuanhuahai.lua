
x400981_g_ScriptId = 400981


x400981_left 	=58.0000
x400981_right	=62.0000

x400981_top  	=226.0000
x400981_bottom	=230.0000

--玩家进入m祎 c醝 area 时触发
function x400981_OnEnterArea( sceneId, selfId )

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400981_g_ScriptId);
		UICommand_AddString(sceneId, "GotoVXHH");
		UICommand_AddString(sceneId, "#cfff263Vong Xuy阯 Hoa H鋓 cho ph閜 tuy阯 chi猲, #Gkh鬾g s醫 kh�#cfff263, c� th� x鋣 ra #GPK#cfff263. Ch� � b鋙 tr鱪g.#r    #cfff263 Trong khu v馽 n鄖 #Gch� 鸬ng t c鬾g#cfff263 ng叨i ch絠 kh醕#G kh鬾g b� tr譶g ph誸#cfff263.#r    #cfff263C� mu痭 v鄌 kh鬾g?");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)

	-- CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 432,90,86)
end

--玩家T読 m祎 c醝 area 呆了m祎 段时间没走则定时触发
function x400981_OnTimer( sceneId, selfId )
	-- 毫 gi鈟,看T読 C醝 n鄖  area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5 gi鈟后仍未传送
	if StandingTime >= 5000 then
		x400981_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开m祎 c醝 area 时触发
function x400981_OnLeaveArea( sceneId, selfId )
end

--**********************************
--任务入口函数
--**********************************
function x400981_GotoVXHH( sceneId, selfId, targetId )	-- 餴琺击该任务后执行此脚本
	
	-- 检查玩家喧ng不喧ng还T読 C醝 n鄖 范围内
	if sceneId ~= 480 then
		--Ng呓i 疸 kh鬾g � khu v馽 v chuy琻.
		BeginEvent(sceneId)
			AddText(sceneId,"Ng呓i 疸 kh鬾g � khu v馽 v chuy琻.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400981_left or
			targetX > x400981_right or
			targetZ < x400981_top  or
			targetZ > x400981_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"Ng呓i 疸 kh鬾g � khu v馽 v chuy琻.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 467,37,40)
end

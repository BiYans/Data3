--玩家进入m祎 c醝 area 时触发
function x400920_OnEnterArea( sceneId, selfId )
	NewWorld( sceneId, selfId, 2, 160, 150 )
end

--玩家T読 m祎 c醝 area 呆了m祎 段时间没走则定时触发
function x400920_OnTimer( sceneId, selfId )
	-- 毫 gi鈟,看T読 C醝 n鄖  area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5 gi鈟后仍未传送
	if StandingTime >= 5000 then
		x400920_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开m祎 c醝 area 时触发
function x400920_OnLeaveArea( sceneId, selfId )
end

----**********************************
----事件列表选中m祎 项
----**********************************
--function OnEventRequest( sceneId, selfId, targetId, eventId )
--	if	GetNumText()==0	then
--		if	IsHaveMission( sceneId, selfId, 711)>0	 then
--			misIndex = GetMissionIndexByID(sceneId,selfId,711)
--			num = GetMissionParam(sceneId,selfId,misIndex,0)
--			if	num == 1 then
--				NewWorld( sceneId, selfId, 2, 275, 50 )
--			else
--				CallScriptFunction((210231), "OnAbandon",sceneId, selfId)
--			end
--		end
--	end
--end

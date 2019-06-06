--燕子坞 宋兵 没有什么实际功能

--脚本号
x402262_g_scriptId = 402262

--所拥有的事件ID列表
x402262_g_eventList={}	

--**********************************
--事件列表
--**********************************
function x402262_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nRand = random(4)
		local str = ""
		if nRand == 1  then
			str = "  Nghe n骾 l n鄖 ph鋘 t m秈 t緄 t� 鹫i 醕 nh鈔 皙n 醡 s醫 H� Di阯 B醥 t呔ng qu鈔!"
		elseif nRand == 2 then
			str = "  H� Di阯 B醥 t呔ng qu鈔 餫ng g nguy hi琺, m秈 c醕 ng呓i ch誽 nhanh 皙n k� h誱 瓞 b鋙 v� h!"
		elseif nRand == 3 then
			str = "  H� Di阯 B醥 t呔ng qu鈔 l� h� t呔ng hi猰 c� c黙 姓i T痭g, am hi琺 th鼀 chi猲, c� h � 疴y 姓i T痭g th鼀 qu鈔 s� t thg!"
		else
			str = "  N猽 ta c� kinh c鬾g nh 鸶nh c鹡g s� bay l阯 l� sen ti猲 皙n k� h誱 b鋙 v� H� Di阯 B醥 t呔ng qu鈔!"
		end
		
		AddText(sceneId, str)		    				
		for i, eventId in x402262_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x402262_OnDefaultEvent( sceneId, selfId,targetId )
	x402262_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x402262_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x402262_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x402262_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x402262_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			x402262_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x402262_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x402262_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x402262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x402262_OnDie( sceneId, selfId, killerId )

end


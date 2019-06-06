--缥缈峰副本....
--战败乌老大对话脚本....

--kich ban goc hao
x893075_g_ScriptId = 893075

--副本逻辑kich ban goc hao....
x893075_g_FuBenScriptId = 893063


--**********************************
--任务入口函数....
--**********************************
function x893075_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "Phi, n鄖 nham hi琺 ti瑄 nh鈔 疸 k陁 b鄋g x�. N錷 痼 v� 鸬c chi猰 ph� s� y猽 truy玭 cho ch鷑g la b� b鋙, h� 鸬c s� huynh mu礽 ba ng叨i" )

		--判断当前是否可以Khi陁 chi猲 李秋水....	
		if 1 == CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
			AddNumText( sceneId, x893075_g_ScriptId, "Quy猼 chi猲 BOSS B鄋g X�", 10, 1 )
		end
		--判断当前是否可以Khi陁 chi猲 过李秋水....	
		if 2 == CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
			AddNumText( sceneId, x893075_g_ScriptId, "V� T� Ch鈛", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893075_OnEventRequest( sceneId, selfId, targetId, eventId )
   if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893075_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
		return
	end

	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		BeginEvent(sceneId)
			AddText( sceneId, "#{PMF_20080521_07}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--判断当前是否可以Khi陁 chi猲 李秋水....	
	if 1 ~= CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
		return
	end

	--如果正在和别的BOSSChi猲 黏u 则返回....
	local ret, msg = CallScriptFunction( x893075_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893075_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893075_g_ScriptId, -1 ,-1 )
	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
      CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 99,121,10 )--传送
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893075_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 5 gi鈟 b 馥u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 4 gi鈟 b 馥u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 3 gi鈟 b 馥u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 2 gi鈟 b 馥u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 1 gi鈟 b 馥u" )
		return
	end

	if 2 == step then
		--提示Chi猲 黏u b 馥u....
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u b 馥u" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893075_g_FuBenScriptId, "CreateBOSS", sceneId, "PangQi_BOSS", -1, -1 )
		return
	end

end

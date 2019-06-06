--缥缈峰副本....
--乌老大对话脚本....

--kich ban goc hao
x893072_g_ScriptId = 893072

--副本逻辑kich ban goc hao....
x893072_g_FuBenScriptId = 893063

--战败乌老大对话kich ban goc hao....
x893072_g_LossScriptId = 893075

--**********************************
--任务入口函数....
--**********************************
function x893072_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)

		AddText( sceneId, "    N絠 n鄖 ch韓h l� t v ch� t鈟 v c醕. Theo ta餴玼 tra tin, t v c� ch鷆 鋘h di陁 h皀g c鵱g m鄒 v鄋g d� 餴畊 hai 鹫i tuy畉 k�. #rCh鷆 鋘h di陁 h皀g s� l� ng呓i th呓ng t眓 ch韓h 鸬i ng� c黙 minh" )
		AddText( sceneId, "    M鄒 v鄋g v� 餴畊 c騨 l読 l� d馻 v鄌 h癷 鈓 phi阯 c叨ng h骯 t v c鬾g l馽, nghe n骾 c� 餰m nh鈔 k韈h b� m m課g uy l馽 #rc醕 ng呓i chu b� t痶 li玭 cho ta bi猼, ta c醝 n鄖 餴 d鏽 t v 餴 ra" )

		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "Khi陁 chi猲 BOSS T V", 10, 1 )
		end

		--判断当前是否可以Khi陁 chi猲 李秋水....	
		if 0 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "Truy玭 t痭g ti猵 theo", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893072_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893072_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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

	--如果正在和别的BOSSChi猲 黏u 则返回....
	local ret, msg = CallScriptFunction( x893072_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以Khi陁 chi猲 乌老大....	
		if 1 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
			BeginEvent(sceneId)
				AddText( sceneId, "#{PMF_20080521_11}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--开启缥缈峰计时器来激活自己....
		CallScriptFunction( x893072_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893072_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 28, 57)
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893072_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 5 gi鈟 b 馥u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 4 gi鈟 b 馥u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 3 gi鈟 b 馥u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 2 gi鈟 b 馥u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 1 gi鈟 b 馥u" )
		return
	end

	if 2 == step then
		--提示Chi猲 黏u b 馥u....
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u b 馥u" )
		--删除NPC....
		--CallScriptFunction( x893072_g_FuBenScriptId, "DeleteBOSS", sceneId, "TaoQin_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893072_g_FuBenScriptId, "CreateBOSS", sceneId, "TaoQin_BOSS", -1, -1 )
		return
	end

end

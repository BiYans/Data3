--缥缈峰副本....
--哈大霸对话脚本....

--kich ban goc hao
x893070_g_ScriptId = 893070

--副本逻辑kich ban goc hao....
x893070_g_FuBenScriptId = 893063

--**********************************
--任务入口函数....
--**********************************
function x893070_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText(sceneId,"  Ti玭 ph呓ng ch韓h l� T� tuy畉 trang. Ch鷑g ta ph鋓 餴 v鄌 � ch� s鈛 trong t鄆 n錸g t靘 疬㧟 b� b鄌. 啸u ti阯 l� ph鋓 th鬾g qua T� tuy畉 餴畁")
		AddText(sceneId,"  T� tuy畉 trong 餴畁 c� r nhi玼 h� v�, nh遪g ch� mu痭 nghe 皙n trong 餴畁 t� tuy畉 ti猲g chu鬾g, s� r秈 餴. Ta c� th� l鄊 cho c chi猲 m鬾 ph醝 l雗 v鄌 xao chung, n猽 kh鬾g c鹡g ch� c� th� x鬾g v鄌")

		--判断当前是否可以Khi陁 chi猲 ....	
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		AddText(sceneId,"   Trong 餴畁 h� v� 疸 mu痭 thanh l�, ta 餴 餰m t� tuy畉 chi th� sinh m鏽 m 疬a t緄, m鱥 ng叨i mau b gi� h, 瓞 cho ta 閜 h鰅 h b� b鋙 b鋙 t皀 鸶a ph呓ng. H phi th叨ng th韈h b誧h [餰m ti猲 r唼u]. M瞚 l s� tuy畉 k� th秈 餴琺 皤u 疸 ng鈓 x呔ng v譨 l. M鱥 ng叨i ch� c ch� � n� tr醤h h ph醫 ra 餰m ti猲 m鵬 r唼u k韓h, tho鋓 m醝 b gi� h kh鬾g l� v 皤")
		    AddNumText( sceneId, x893070_g_ScriptId, "Khi陁 chi猲 BOSS M鏽 M", 10, 1 )
		end
		--判断当前是否Khi陁 chi猲 完毕之后传送....	
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893070_g_ScriptId, "Truy玭 t痭g ti猵 theo", 10, 2 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893070_OnEventRequest( sceneId, selfId, targetId, eventId )

   if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893070_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以Khi陁 chi猲 桑土公....	
	if 1 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng呓i 疸 mu痭 khi陁 chi猲 ta" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893070_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893070_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 101, 52)

  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893070_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 5 gi鈟 b 馥u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 4 gi鈟 b 馥u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 3 gi鈟 b 馥u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 2 gi鈟 b 馥u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 1 gi鈟 b 馥u" )
		return
	end

	if 2 == step then
		--提示Chi猲 黏u b 馥u....
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u b 馥u" )
		--删除NPC....
		--CallScriptFunction( x893070_g_FuBenScriptId, "DeleteBOSS", sceneId, "MinMo_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893070_g_FuBenScriptId, "CreateBOSS", sceneId, "MinMo_BOSS", -1, -1 )
		return
	end

end

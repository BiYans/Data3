--缥缈峰副本....
--桑土公对话脚本....

--kich ban goc hao
x893071_g_ScriptId = 893071

--副本逻辑kich ban goc hao....
x893071_g_FuBenScriptId = 893063

--**********************************
--任务入口函数....
--**********************************
function x893071_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "   N絠 n鄖 ch韓h l� 朽o thanh ch� b鄋 long c醕. Giang h� 鸢n 疸i 疣o thanh hai m nh鈔 b畁h hi琺 ngh鑟, 疸 mu痭 kh鬾g th� nh靚 v. Nh遪g c鬾g phu v鏽 r l㱮 h読 l� t� tuy畉 trang trung t痠 c叨ng. #r朽o thanh ch錸 nu鬷 t� ch韈h m h� c鵱g m叨i ch韈h thanh 遪g, ch鷑g n� 鸠i v緄 疣o thanh r m馽 trung th鄋h v� t t鈓. N猽 trong chi猲 黏u xu hi畁 trong l秈 n骾, nh 鸶nh ph鋓 ti猲 lui" )
		AddText( sceneId, "   M kh醕 h c騨 c� h課g nh tuy畉 k� --tam phong l遳 v鈔. S� xu 皙n sau, 疣o thanh h礽  nh� qu� th b靚h th叨ng, xu qu� nh th. Nghe n骾, k� n錸g n鄖 c� v譨 v� tr醤, h鋙 h鋙 l㱮 d鴑g c� th� 餰m tam phong l遳 v鈔 c ph� #r c醕 ng呓i chu b� t痶 li玭 cho ta bi猼, ta c醝 n鄖 餴 d鏽 疣o thanh 餴 ra" )
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "Khi陁 chi猲 BOSS 朽o Thanh", 10, 1 )
		end
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "Truy玭 t痭g ti猵 theo", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893071_OnEventRequest( sceneId, selfId, targetId, eventId )
   if GetNumText() == 1 then
	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893071_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893071_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以Khi陁 chi猲 桑土公....	
	if 1 ~= CallScriptFunction( x893071_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng呓i 疸 mu痭 khi陁 chi猲 ta" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893071_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893071_g_ScriptId, -1, -1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 73, 91)
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893071_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 5 gi鈟 b 馥u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 4 gi鈟 b 馥u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 3 gi鈟 b 馥u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 2 gi鈟 b 馥u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u 1 gi鈟 b 馥u" )
		return
	end

	if 2 == step then
		--提示Chi猲 黏u b 馥u....
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi猲 黏u b 馥u" )
		--删除NPC....
		--CallScriptFunction( x893071_g_FuBenScriptId, "DeleteBOSS", sceneId, "QinYun_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893071_g_FuBenScriptId, "CreateBOSS", sceneId, "QinYun_BOSS", -1, -1 )
		return
	end

end

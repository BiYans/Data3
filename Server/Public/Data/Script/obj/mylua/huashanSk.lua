--传送NPC
--驿站老板
--普通

x892007_g_ScriptId	= 892007

--门派信息(门派名称，SceneID，PosX，PosY，门派ID)
x892007_g_mpInfo		= {}
x892007_g_mpInfo[0]	= { "星宿", 16,  96, 152, MP_XINGSU }
x892007_g_mpInfo[1]	= { "逍遥", 14,  67, 145, MP_XIAOYAO }
x892007_g_mpInfo[2]	= { "少林",  9,  96, 127, MP_SHAOLIN }
x892007_g_mpInfo[3]	= { "天山", 17,  95, 120, MP_TIANSHAN }
x892007_g_mpInfo[4]	= { "天龙", 13,  96, 120, MP_DALI }
x892007_g_mpInfo[5]	= { "峨嵋", 15,  89, 139, MP_EMEI }
x892007_g_mpInfo[6]	= { "武当", 12, 103, 140, MP_WUDANG }
x892007_g_mpInfo[7]	= { "明教", 11,  98, 167, MP_MINGJIAO }
x892007_g_mpInfo[8]	= { "丐帮", 10,  91, 116, MP_GAIBANG }

x892007_g_Yinpiao = 40002000
--**********************************
--事件交互入口
--**********************************
function x892007_OnDefaultEvent( sceneId, selfId, targetId )

	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x892007_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	local	mp
	local	i		= 0
	BeginEvent( sceneId )
		if GetLevel( sceneId, selfId ) >= 10 then
			AddText( sceneId, "#b#G  中华天龙独家设计的帮战系统， 为了荣誉，为了帮会，亲们！！速度加入激情的帮战当中去吧!中华天龙谢谢亲们支持 #133#133#133" )
			--AddNumText( sceneId, x892007_g_ScriptId, "#gFF83FA返回门派", 9, 1000 )
			AddNumText( sceneId, x892007_g_ScriptId, "#gf19fcc点击进入帮战地图 ", 9, 1002 )
			
			for i, mp in x892007_g_mpInfo do
				--AddNumText( sceneId, x892007_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
		else
			AddText( sceneId, "  你需要等级到达10级以上，才能去别的城市。" )
			AddNumText( sceneId, x892007_g_ScriptId, "城市 - 大理",  9, 1003 )
			AddNumText( sceneId, x892007_g_ScriptId, "城市 - 大理2", 9, 1004 )
			AddNumText( sceneId, x892007_g_ScriptId, "城市 - 大理3", 9, 1005 )
		end

		-- 我怎样才能去敦煌和嵩山
		--AddNumText( sceneId, x892007_g_ScriptId, "我怎样才能去敦煌和嵩山", 11, 2000 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x892007_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1011 then
	local	mp
	local	i		= 0
		BeginEvent( sceneId )
			for i, mp in x892007_g_mpInfo do
				AddNumText( sceneId, x892007_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
		--队伍相关
	if GetTeamId(sceneId,selfId)>=0 and
		IsTeamFollow(sceneId, selfId)==1 and
		LuaFnIsTeamLeader(sceneId,selfId)==1 then
		num=LuaFnGetFollowedMembersCount( sceneId, selfId)
		local mems = {}
		for	i=0,num-1 do
			mems[i] = GetFollowedMember(sceneId, selfId, i)
			if mems[i] == -1 then
				return
			end
			if IsHaveMission(sceneId,mems[i],4021) > 0 then
				x892007_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运\货舱在身，我们驿站不能为你提供传送服务。" )
				return
			end
		end
	end

	--漕运相关
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x892007_MsgBox( sceneId, selfId, targetId, "  你有漕运\货舱在身，我们驿站不能为你提供传送服务。" )
		return
	end

	--顺利传送
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
	if arg == 1000 then		--返回门派
		if id < 0 or id >= 9 then
			x892007_MsgBox( sceneId, selfId, targetId, "  你还没有加入任何门派！" )
		else
			mp	= x892007_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4], 10 )
			end
		end
		return
	end
	if arg == 1001 then		--跨服争霸赛
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 550, 250, 250, 10 )
		return
	end
	if arg == 1002 then		--通天塔塔顶
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 125, 256,272, 10 )
		return
	end
	if arg == 1003 then		--通天塔三层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 547, 258,314, 10 )
		return
	end
	if arg == 1006 then		--通天塔二层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 546, 255, 367, 10 )
		return
	end
	if arg == 1007 then		--通天塔一层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 545, 255, 380, 10 )
		return
	end
	if arg == 1008 then		--通天塔地宫
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 544, 255, 384, 10 )
		return
	end
	if arg == 1009 then		--束河古镇
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 422, 200, 211, 10 )
		return
	end
	if arg == 1010 then		--昆仑福地
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 421, 93, 36, 10 )
		return
	end
	if arg == 1012 then		--幻境
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 534, 36, 32, 10 )
		return
	end
	if arg == 1013 then		--钧天王陵
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 553, 48, 48, 10 )
		return
	end
	if arg == 1014 then		--潮京城
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 560, 125, 134, 10 )
		return
	end
	if arg == 1015 then		--秦王地宫四层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 538, 125, 134, 10 )
		return
	end
	if arg == 1016 then		--忘川花海
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 557, 125, 134, 10 )
		return
	end
	if arg == 1017 then		--天岐南淮
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 558, 125, 134, 10 )
		return
	end
	if arg == 1018 then		--夙阳镇
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 559, 185, 185, 10 )
		return
	end
	if arg == 1019 then		--凤凰古城
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 180, 53, 36, 10 )
		return
	end
	if arg == 1003 then		--大理1
		--如果玩家就在大理1则不传送
		if sceneId == 2 then
			x892007_MsgBox( sceneId, selfId, targetId, "  你已经在大理了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 241, 138 )
		end
		return
	end
	if arg == 1004 then		--大理2
		--如果玩家就在大理2则不传送
		if sceneId == 71 then
			x892007_MsgBox( sceneId, selfId, targetId, "  你已经在大理2了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 71, 241, 138 )
		end
		return
	end
	if arg == 1005 then		--大理3
		--如果玩家就在大理3则不传送
		if sceneId == 72 then
			x892007_MsgBox( sceneId, selfId, targetId, "  你已经在大理3了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 72, 241, 138 )
		end
		return
	end
	for i, mp in x892007_g_mpInfo do
		if arg == i then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4], 10 )
			return
		end
	end

	if GetNumText() == 2000 then		--
		BeginEvent( sceneId )
			AddText( sceneId, "#{GOTO_DUNHUANF_SONGSHAN}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

		return
	end

end

--**********************************
--根据门派ID获取门派信息
--**********************************
function x892007_GetMPInfo( mpID )
	local	mp
	local	i		= 0
	for i, mp in x892007_g_mpInfo do
		if mp[5] == mpID then
			return mp
		end
	end
	return nil
end

--**********************************
--对话窗口信息提示
--**********************************
function x892007_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

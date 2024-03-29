-- 天工开物L頽h 人民币材料
-- 创建人[ QUFEI 2007-09-21 15:07 UPDATE BugID 24677 ]

x210244_g_ScriptId = 210244

x210244_g_Update = {

    ["id01"] = 60,
    ["id02"] = 70,
    ["id03"] = 80,

}

--提示信息
x210244_g_msg = {

    ["jl60"]	= "L頽h 60c奖励",
    ["jl70"]	= "L頽h 70c奖励",
    ["jl80"]	= "L頽h 80c奖励",

}

--奖励标记
x210244_g_flag = {

    [60]	= MF_TianGongJiangli60,
    [70]	= MF_TianGongJiangli70,
    [80]	= MF_TianGongJiangli80,

}

--材料奖励
-- 60 棉布碎片
-- 70 Tinh铁碎片
-- 80 秘银碎片
x210244_g_CaiLiaoJiangLi = {

    [60]	= 20501000,
    [70]	= 20500000,
    [80]	= 20502000,

}

x210244_g_PlayerLevel = 0

--**********************************
--列举事件
--**********************************
function x210244_OnEnumerate( sceneId, selfId, targetId )	
		
--	BeginEvent(sceneId)					警告: C醝 n鄖 函数中不要出现BeginEvent套件 会清空之前to� 鸬 AddNumText信息 
	
		if GetLevel( sceneId, selfId ) >= 60 then
			--AddNumText( sceneId, x210244_g_ScriptId, "#{TGKW_20070918_003}", 6, 105 )
			--AddNumText( sceneId, x210244_g_ScriptId, "#{TGKW_20070918_004}", 11, 106 )
		end	
			
--	EndEvent(sceneId)
--	DispatchEventList(sceneId,selfId,targetId)
		
end

function x210244_OnDefaultEvent( sceneId, selfId, targetId )
	
	local	key	= GetNumText()
	x210244_g_PlayerLevel = GetNumText()
			
	if key == 105 then
		BeginEvent(sceneId)
		
		AddText(sceneId,"#{TGKW_20070918_001}")				
		AddNumText( sceneId, x210244_g_ScriptId, x210244_g_msg["jl60"], 6, x210244_g_Update["id01"] )	
		AddNumText( sceneId, x210244_g_ScriptId, x210244_g_msg["jl70"], 6, x210244_g_Update["id02"] )	
		AddNumText( sceneId, x210244_g_ScriptId, x210244_g_msg["jl80"], 6, x210244_g_Update["id03"] )	
		
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	
	elseif key == 106 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{TGKW_20070918_002}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		return
	elseif key == x210244_g_Update["id01"] or key == x210244_g_Update["id02"] or key == x210244_g_Update["id03"] then
		x210244_OnTianGongKaiWu( sceneId, selfId, targetId )
		return
	end	
	
end

function x210244_OnTianGongKaiWu( sceneId, selfId, targetId )
		
	local mylevel = GetLevel( sceneId, selfId )
		
	if mylevel < x210244_g_PlayerLevel then
		local strText = format("您to� 鸬 Kh鬾g 瘘 鹌ng c,待等c达到%dc再来找我吧.", x210244_g_PlayerLevel )
		x210244_TalkMsg( sceneId, selfId, targetId, strText )	
		return
	end
		
	local index =	GetMissionFlag( sceneId, selfId, x210244_g_flag[x210244_g_PlayerLevel] )
		
	if index == 1 then
		x210244_TalkMsg( sceneId, selfId, targetId, "您已经L頽h 过该项奖励,不能再领了." )	
		return
	end
	
	BeginAddItem( sceneId )
	AddItem( sceneId, x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel], 4 )
	ret = EndAddItem( sceneId, selfId )
			
	if ret <= 0 then
		x210244_TalkMsg( sceneId, selfId, targetId, "您to� 鸬 材料栏空位不够,諰inh貱 4c醝空位,不能L頽h 奖励." )	
		return
	end
	
	-- 奖励材料	
	local bagpos01 = TryRecieveItem( sceneId, selfId, x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	local bagpos02 = TryRecieveItem( sceneId, selfId, x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	local bagpos03 = TryRecieveItem( sceneId, selfId, x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	local bagpos04 = TryRecieveItem( sceneId, selfId, x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	
	local itemInfo = GetBagItemTransfer( sceneId, selfId, bagpos01 )
		
	-- 强制绑定										
	local	bindidx01	=	LuaFnItemBind( sceneId, selfId, bagpos01 )
	local	bindidx02	=	LuaFnItemBind( sceneId, selfId, bagpos02 )
	local	bindidx03	=	LuaFnItemBind( sceneId, selfId, bagpos03 )
	local	bindidx04	=	LuaFnItemBind( sceneId, selfId, bagpos04 )
	
	if bindidx01 ~= 1 or bindidx02 ~= 1 or bindidx03 ~= 1 or bindidx04 ~= 1 then
		local bindmsg = "Bu礳 鸶nh th b読"													
		BeginEvent( sceneId )
			AddText( sceneId, bindmsg )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
		
	SetMissionFlag( sceneId, selfId, x210244_g_flag[x210244_g_PlayerLevel], 1 )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,1000)
	local retmsg = format("%s物品L頽h 成功", GetItemName(sceneId,x210244_g_CaiLiaoJiangLi[x210244_g_PlayerLevel]) )
	x210244_TalkMsg( sceneId, selfId, targetId, retmsg )	
	
	-- 发送H� th痭g公告										
	local playername = GetName(sceneId, selfId)
	local strText = format("#{_INFOUSR%s}#I#{TGKW_20070918_005}#Y%d#{TGKW_20070918_006}#{_INFOMSG%s}#G4c醝.", playername, x210244_g_PlayerLevel, itemInfo)										
	BroadMsgByChatPipe(sceneId, selfId, strText, 4)

end

--**********************************
--消息提示
--**********************************
function x210244_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--对话提示
--**********************************
function x210244_TalkMsg( sceneId, selfId, targetId, str )	
	BeginEvent(sceneId)
      AddText(sceneId, str)      
  EndEvent(sceneId)
  DispatchEventList(sceneId,selfId,targetId)    
end

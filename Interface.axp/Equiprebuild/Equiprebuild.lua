
local ObjCaredIDID = -1
local g_ItemPos = -1
local g_NewId = -1
local g_NeedMoney = 50000
local MAX_OBJ_DISTANCE = 3.0
local g_Accept_Clicked_Num = 0
--local g_Is92ShenQi = 0
--=========================================================
--常量定义
--=========================================================
--local MIN_MENPAI_IDX = 0
--local MAX_MENPAI_IDX = 8

function Equiprebuild_PreLoad()
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "OBJECT_CARED_EVENT" )
	this : RegisterEvent( "PACKAGE_ITEM_CHANGED" )
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )
	--this : RegisterEvent( "UPDATE_SHENQIUP" )
	this : RegisterEvent( "RESUME_ENCHASE_GEM" )--???
	this : RegisterEvent( "NEW_DEBUGMESSAGE" )
	this : RegisterEvent("MANUALEQUIP_RESET")
end

function Equiprebuild_OnLoad()
	--SuperWeaponUp_Hide_RadioText();
end


--=========================================================
--事件响应
--=========================================================
function Equiprebuild_OnEvent( event )

	if event == "UI_COMMAND" and tonumber(arg0) == 20130806 then
		local targetId = Get_XParam_INT(0)
		ObjCaredID = DataPool : GetNPCIDByServerID( targetId )
		if ObjCaredID == -1 then
			return
		end
		ObjCaredIDID = targetId
		BeginCareObject_Equiprebuild()
		Equiprebuild_Clear()
		this : Show()

	elseif event == "UNIT_MONEY" then
		Equiprebuild_SelfMoney: SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY")) )

	elseif event == "MONEYJZ_CHANGE" then
		Equiprebuild_JiaoZiNum: SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY_JZ")) )

	elseif event == "OBJECT_CARED_EVENT" then
		if( tonumber(arg0) ~= ObjCaredID ) then
			return
		end
		if( arg1 == "distance" and tonumber( arg2 ) > MAX_OBJ_DISTANCE or arg1=="destroy" ) then
			Equiprebuild_Close()
		end

	elseif event == "RESUME_ENCHASE_GEM" then --让镶嵌UI中的宝石还原  ???啥时候发生 放这儿没用啊
		Equiprebuild_ResetSlot()

	elseif event == "PACKAGE_ITEM_CHANGED" then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end

		if tonumber(arg0) == g_ItemPos then
		--	Equiprebuild_ResetSlot()
		end

	elseif event == "MANUALEQUIP_RESET" then--拖拽放入 框中
		if arg0 ~= nil then
			--SuperWeaponUp_Update( arg0 )
			Equiprebuild_Update( arg0 )
		end
	end

end

--=========================================================
--确定按钮
--=========================================================
function Equiprebuild_OKEvent()

	--判断电话密保和二级密码保护2012.6.11-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then
		return
	end
	-- 判断是否为安全时间2012.6.11-LIUBO
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZYXT_120528_16}")
		return
	end

	if g_ItemPos ~= -1 and PlayerPackage : GetItemTableIndex( g_ItemPos ) > 0 then
		--钱是否够....
		local ItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )

		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "OnManualEquipAttrReset" )
			Set_XSCRIPT_ScriptID( 809275 )
			Set_XSCRIPT_Parameter( 0, g_ItemPos )
			Set_XSCRIPT_Parameter( 1, ObjCaredIDID )
			Set_XSCRIPT_ParamCount( 2 )
		Send_XSCRIPT()
	--	Equiprebuild_Clear()
	--	this:Hide()
	else
		PushDebugMessage( "H銀 疬a trang b� c th錸g c v鄌:" )
	end

end




--=========================================================
--更新界面
--=========================================================
--function SuperWeaponUp_Update( pos_packet )
function Equiprebuild_Update( pos_packet )

	local BagIndex = tonumber( pos_packet )
	local theAction = EnumAction( BagIndex, "packageitem" )

	if theAction : GetID() == 0 then
		return
	end

	-------------检查是否是装备----------
	local isEquip =LifeAbility:Is_HumanEquip(BagIndex)
	if isEquip <0 then
		PushDebugMessage("#{SGZBSJ_130725_08}")
		return
	end
--------------

	--看是否是新手工装备
	local ItemID = PlayerPackage : GetItemTableIndex( BagIndex )
	if ItemID <= 0 or ItemID<10141702 or ItemID >10141790 then
		PushDebugMessage("Trang b� 疬a v鄌 kh鬾g ch韓h x醕")
		return
	end

	g_NeedMoney=50000 --交子的需求数暂时写死为5交子
	--g_NewId, g_NeedMoney = ShenqiUpgrade : GetShenqiUpgradeInfo( ItemID, MenpaiID )
	--&&& 检查是否是可兑换的装备  客户端检查也是白检查，直接pass掉，在服务器做检查
--	if g_NewId == -1 then
--		PushDebugMessage("请放入可以兑换的神器！")
--		return
--	end


	--更换ActionButton....
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end
	LifeAbility : Lock_Packet_Item( BagIndex, 1 )
	Equiprebuild_Item : SetActionItem( theAction : GetID() )
	g_ItemPos = BagIndex
	Equiprebuild_DemandJZ: SetProperty( "MoneyNumber", tostring( g_NeedMoney ) )
	g_Accept_Clicked_Num = 0
end



--=========================================================
--重置界面
--=========================================================
function Equiprebuild_Clear()
	if g_ItemPos ~= -1 then
		Equiprebuild_Item : SetActionItem( -1 )
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
		g_ItemPos = -1
		g_NewId = -1
		g_NeedMoney = 0
		Equiprebuild_DemandJZ: SetProperty( "MoneyNumber", tostring( g_NeedMoney ) )
		g_Accept_Clicked_Num = 0
	end
end


--=========================================================
--关闭
--=========================================================
--function SuperWeaponUp_Close()
function Equiprebuild_Close()
	this : Hide()
	StopCareObject_Equiprebuild()
	Equiprebuild_Clear()
end

--=========================================================
--界面隐藏
--=========================================================
function Equiprebuild_OnHiden()
	StopCareObject_Equiprebuild()
	Equiprebuild_Clear()
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function BeginCareObject_Equiprebuild()
	this : CareObject( ObjCaredID, 1, "Equiprebuild" )
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function StopCareObject_Equiprebuild()
	this : CareObject( ObjCaredID, 0, "Equiprebuild" )
end

--=========================================================
--右键点击ActionButton
--=========================================================
function Equiprebuild_ResetSlot()

	if( this:IsVisible() ) then

		Equiprebuild_Clear()

	end
end

function Equiprebuild_CancleEvent()

	this:CareObject(ObjCaredIDID, 0, "Equiprebuild");
	ObjCaredIDID = -1;
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end
	this:Hide();
end

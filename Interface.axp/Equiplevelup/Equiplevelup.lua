
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

function Equiplevelup_PreLoad()
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "OBJECT_CARED_EVENT" )
	this : RegisterEvent( "PACKAGE_ITEM_CHANGED" )
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )
	--this : RegisterEvent( "UPDATE_SHENQIUP" )
	this : RegisterEvent( "RESUME_ENCHASE_GEM" )--???
	this : RegisterEvent( "NEW_DEBUGMESSAGE" )
	this : RegisterEvent("UPDATE_MANUALEQUIP")
end

function Equiplevelup_OnLoad()
	--SuperWeaponUp_Hide_RadioText();
end


--=========================================================
--事件响应
--=========================================================
function Equiplevelup_OnEvent( event )

	if event == "UI_COMMAND" and tonumber(arg0) == 20130726 then
		local targetId = Get_XParam_INT(0)
		ObjCaredID = DataPool : GetNPCIDByServerID( targetId )
		if ObjCaredID == -1 then
			return
		end
		ObjCaredIDID = targetId
		BeginCareObject_EquiplevelUp()
		Equiplevelup_Clear()
		this : Show()

	elseif event == "UNIT_MONEY" then
		Equiplevelup_SelfMoney: SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY")) )

	elseif event == "MONEYJZ_CHANGE" then
		Equiplevelup_JiaoZiNum: SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY_JZ")) )

	elseif event == "OBJECT_CARED_EVENT" then
		if( tonumber(arg0) ~= ObjCaredID ) then
			return
		end
		if( arg1 == "distance" and tonumber( arg2 ) > MAX_OBJ_DISTANCE or arg1=="destroy" ) then
			Equiplevelup_Close()
		end

	elseif event == "RESUME_ENCHASE_GEM" then --让镶嵌UI中的宝石还原  ???啥时候发生 放这儿没用啊
		Equiplevelup_ResetSlot()

	elseif event == "PACKAGE_ITEM_CHANGED" then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end

		if tonumber(arg0) == g_ItemPos then
			Equiplevelup_ResetSlot()
		end

	elseif event == "UPDATE_MANUALEQUIP" then--拖拽放入 框中
		if arg0 ~= nil then
			--SuperWeaponUp_Update( arg0 )
			Equiplevelup_Update( arg0 )
		end
	end

end

--=========================================================
--确定按钮
--=========================================================
function Equiplevelup_OKEvent()

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
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ") --交子普及 Vega
		if selfMoney < g_NeedMoney then
			PushDebugMessage( "#{SGZBSJ_130725_16}" ) --金钱不足，不能装备洗练

			return
		end

		local eqLevel = LifeAbility : Get_Equip_Level(g_ItemPos)--获取装备等级

		if eqLevel == nil then
			return
		end

		if eqLevel < 82 then
			PushDebugMessage("H銀 疬a trang b� c c鋓 thi畁 v鄌:")
			return
		end

		if (g_ItemPos ~= -1) then
			local ItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
			if eqLevel then
					local MatLevel2,MatNum2
					MatLevel2 = 30504659;--重铸符
					local nHaveNum2 = 0
					nHaveNum2 = Player :IsHaveItem(MatLevel2,MatNum2)
					if (nHaveNum2< 5) then--现在都是5，但都是从表里读的，还会变吗？
						PushDebugMessage( "Nguy阯 li畊 ch遖 瘘" ) --材料不足 ZBSJ
						return
					end
			end
		end

		if (g_Accept_Clicked_Num == 0) then
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name( "ManualEquipUpConfirm" )
				Set_XSCRIPT_ScriptID( 809275 )
				Set_XSCRIPT_Parameter( 0, g_ItemPos )
				Set_XSCRIPT_Parameter( 1, ObjCaredIDID )

				Set_XSCRIPT_ParamCount( 2 )
			Send_XSCRIPT()
			g_Accept_Clicked_Num = 1
		else
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name( "OnManualEquipUp" )
				Set_XSCRIPT_ScriptID( 809275 )
				Set_XSCRIPT_Parameter( 0, g_ItemPos )
				Set_XSCRIPT_Parameter( 1, ObjCaredIDID )
				Set_XSCRIPT_ParamCount( 2 )
			Send_XSCRIPT()
			Equiplevelup_Clear()
		--	this:Hide()
		end

	else
		PushDebugMessage( "H銀 疬a trang b� c c鋓 thi畁 v鄌:" )
	end

end




--=========================================================
--更新界面
--=========================================================
--function SuperWeaponUp_Update( pos_packet )
function Equiplevelup_Update( pos_packet )

	local BagIndex = tonumber( pos_packet )
	local theAction = EnumAction( BagIndex, "packageitem" )

	if theAction : GetID() == 0 then
		return
	end
-------------检查是否是装备----------
	local isEquip =LifeAbility:Is_HumanEquip(BagIndex)
	if isEquip <0 then
		PushDebugMessage("#{SGZBSJ_130725_07}")
		return
	end
--------------
	--查看装备等级
	local eqLevel = LifeAbility:Get_Equip_Level(BagIndex)--获取装备等级
	if eqLevel == nil then
		return
	end

	local ItemID = PlayerPackage : GetItemTableIndex( BagIndex )
	if ItemID <= 0 then
		PushDebugMessage("Trang b� b� l瞚")
		return
	end
	if nil == SearchIsInManuanUpTable(ItemID) then
		PushDebugMessage("#{SGZBSJ_130725_08}")
		return
	end

	g_NeedMoney = SearchUpgradeMoney(ItemID)
	if g_NeedMoney == nil then
		return
	end

	----------------------------------------
	--更换ActionButton....
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end
	LifeAbility : Lock_Packet_Item( BagIndex, 1 )
	Equiplevelup_Item:SetActionItem( theAction : GetID() )
	g_ItemPos = BagIndex
	Equiplevelup_DemandJZ: SetProperty( "MoneyNumber", tostring( g_NeedMoney ) )
	g_Accept_Clicked_Num = 0
	----------------------------------------

end



--=========================================================
--重置界面
--=========================================================
--function SuperWeaponUp_Clear()
function Equiplevelup_Clear()
	if g_ItemPos ~= -1 then
		Equiplevelup_Item : SetActionItem( -1 )
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
		g_ItemPos = -1
		g_NewId = -1
		g_NeedMoney = 0
		--SuperWeaponUp_DemandMoney : SetProperty( "MoneyNumber", 0 )
		Equiplevelup_DemandJZ: SetProperty( "MoneyNumber", tostring( g_NeedMoney ) )
		g_Accept_Clicked_Num = 0
	end
end


--=========================================================
--关闭
--=========================================================
function Equiplevelup_Close()
	this : Hide()
	StopCareObject_EquiplevelUp()
	Equiplevelup_Clear()
end

--=========================================================
--界面隐藏
--=========================================================
function Equiplevelup_OnHiden()
	StopCareObject_EquiplevelUp()
	Equiplevelup_Clear()
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function BeginCareObject_EquiplevelUp()
	this : CareObject( ObjCaredID, 1, "Equiplevelup" )
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function StopCareObject_EquiplevelUp()
	this : CareObject( ObjCaredID, 0, "Equiplevelup" )
end

--=========================================================
--右键点击ActionButton
--=========================================================
function Equiplevelup_ResetSlot()

	if( this:IsVisible() ) then

		Equiplevelup_Clear()

	end
end

function Equiplevelup_CancleEvent()

	this:CareObject(ObjCaredIDID, 0, "Equiplevelup");
	ObjCaredIDID = -1;
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end
	this:Hide();
end

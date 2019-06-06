
local ObjCaredIDID = -1
local g_ItemPos = -1
local g_NewId = -1
local g_NeedMoney = -1
local MAX_OBJ_DISTANCE = 3.0
local g_Accept_Clicked_Num = 0
local Equip_Level = -1
local g_NeedItem = -1
--=========================================================
--常量定义
--=========================================================
local MIN_MENPAI_IDX = 0
local MAX_MENPAI_IDX = 8

function SuperWeaponUp_PreLoad()
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "OBJECT_CARED_EVENT" )
	this : RegisterEvent( "PACKAGE_ITEM_CHANGED" )
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )
	this : RegisterEvent( "UPDATE_SHENQIUP" )
	this : RegisterEvent( "RESUME_ENCHASE_GEM" )
	this : RegisterEvent( "NEW_DEBUGMESSAGE" )
end

function SuperWeaponUp_OnLoad()

end


--=========================================================
--事件响应
--=========================================================
function SuperWeaponUp_OnEvent( event )

	if event == "UI_COMMAND" and tonumber(arg0) == 19831114 then
		local targetId = Get_XParam_INT(0)
		ObjCaredID = DataPool : GetNPCIDByServerID( targetId )
		if ObjCaredID == -1 then
			--PushDebugMessage("server传过来的数据有问题。")
			return
		end
		ObjCaredIDID = targetId
		BeginCareObject_SuperWeaponUp()
		SuperWeaponUp_Clear()
		this : Show()

	elseif event == "UNIT_MONEY" then
		SuperWeaponUp_SelfMoney : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY")) )

	elseif event == "MONEYJZ_CHANGE" then
		SuperWeaponUp_DemandJiaozi : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY_JZ")) )

	elseif event == "OBJECT_CARED_EVENT" then
		if( tonumber(arg0) ~= ObjCaredID ) then
			return
		end
		if( arg1 == "distance" and tonumber( arg2 ) > MAX_OBJ_DISTANCE or arg1=="destroy" ) then
			SuperWeaponUp_Close()
		end

	elseif event == "RESUME_ENCHASE_GEM" then
		SuperWeaponUp_Resume_Equip_Gem()

	elseif event == "PACKAGE_ITEM_CHANGED" then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end

		if tonumber(arg0) == g_ItemPos then
			SuperWeaponUp_Resume_Equip_Gem()
		end

	--elseif event == "UPDATE_SHENQIUP" then
	elseif ((event == "UI_COMMAND") and (tonumber(arg0) == 20170119)) then
		if arg1 ~= nil then
			SuperWeaponUp_Update( arg1 )
		end
	end

end

--=========================================================
--确定按钮
--=========================================================
function SuperWeaponUp_Buttons_Clicked()
	if g_ItemPos ~= -1 and PlayerPackage : GetItemTableIndex( g_ItemPos ) > 0 then


		if PlayerPackage : IsLock( g_ItemPos ) == 1 then
			PushDebugMessage( "V ph kh鬾g t皀 t読 ho 疸 kh骯!" )
			return
		end

		--钱是否够....
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ") --交子普及 Vega
		if selfMoney < g_NeedMoney then
			PushDebugMessage( "#{JKBS_081021_011}" )
			return
		end

		if (g_ItemPos ~= -1) then
			local ItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
			--local MatID,MatNum = g_NeedItem,5;--ShenqiUpgrade : GetShenqiUpMaterial( ItemID, 0 )
      local index,BindState = PlayerPackage:FindFirstBindedItemIdxByIDTable(tonumber(g_NeedItem))--Player : IsHaveItem( MatID, MatNum)
			--PushDebugMessage( n.."::"..nHaveNum.."::"..MatID )
			if (index == -1) then
				PushDebugMessage( "#{SQSJ_0708_04}" )
				return
			end
		end

		if (g_Accept_Clicked_Num == 0) then
			ShowSystemInfo("SQSJ_0708_09")
			g_Accept_Clicked_Num = 1
		else
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name( "OnShenqiUpgrade" )
				Set_XSCRIPT_ScriptID( 500505 )
				Set_XSCRIPT_Parameter( 0, g_ItemPos )
				Set_XSCRIPT_Parameter( 1, ObjCaredIDID )
				Set_XSCRIPT_ParamCount( 2 )
			Send_XSCRIPT()
			SuperWeaponUp_Clear()
		end

	else
		PushDebugMessage( "H銀 穑t th kh� c t醝 t誳!" )
	end
end




--=========================================================
--更新界面
--=========================================================
function SuperWeaponUp_Update( pos_packet )
	local BagIndex = tonumber( pos_packet )
	local theAction = EnumAction( BagIndex, "packageitem" )

	if theAction : GetID() == 0 then
		return
	end

	--必须是可兑换的神器....
	--local MenpaiID = Player : GetData( "MEMPAI" )
	local ItemID = PlayerPackage : GetItemTableIndex( BagIndex )
	local LastINT = ItemID - 10300000;
	if (LastINT < 4 or LastINT > 100000) then
		PushDebugMessage("V ph n鄖 kh鬾g ph鋓 l� th kh� c� th� 鸨i!")
		return
	end

	--g_NewId, g_NeedMoney = ShenqiUpgrade : GetShenqiUpgradeInfo( ItemID, MenpaiID )
	Equip_Level = LifeAbility : Get_Equip_Level(BagIndex);
	if (Equip_Level < 82) then
		PushDebugMessage("H銀 穑t th kh� c� th� 鸨i!")
		return
	end

	if (Equip_Level >= 82 and Equip_Level < 92) then
		g_NeedItem = 30505816;
	elseif (Equip_Level >= 92 and Equip_Level < 102) then
		g_NeedItem = 30505817;
	elseif (Equip_Level >= 102) then
		g_NeedItem = 30505908;
	end

	g_NeedMoney = 50000
	-- g_NewId = 1;
	-- if g_NewId == -1 then
	-- 	PushDebugMessage("H銀 穑t th kh� c� th� 鸨i!")
	-- 	return
	-- end

	--更换ActionButton....
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end
	LifeAbility : Lock_Packet_Item( BagIndex, 1 )
	SuperWeaponUp_Object : SetActionItem( theAction : GetID() )
	g_ItemPos = BagIndex
	SuperWeaponUp_DemandMoney : SetProperty( "MoneyNumber", tostring( g_NeedMoney ) )
	g_Accept_Clicked_Num = 0
end



--=========================================================
--重置界面
--=========================================================
function SuperWeaponUp_Clear()
	if g_ItemPos ~= -1 then
		SuperWeaponUp_Object : SetActionItem( -1 )
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
		g_ItemPos = -1
		g_NewId = -1
		g_NeedMoney = -1
		SuperWeaponUp_DemandMoney : SetProperty( "MoneyNumber", 0 )
		g_Accept_Clicked_Num = 0
	end
end


--=========================================================
--关闭
--=========================================================
function SuperWeaponUp_Close()
	this : Hide()
	StopCareObject_SuperWeaponUp()
	SuperWeaponUp_Clear()
end

--=========================================================
--界面隐藏
--=========================================================
function SuperWeaponUp_OnHiden()
	StopCareObject_SuperWeaponUp()
	SuperWeaponUp_Clear()
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function BeginCareObject_SuperWeaponUp()
	this : CareObject( ObjCaredID, 1, "SuperWeaponUp" )
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function StopCareObject_SuperWeaponUp()
	this : CareObject( ObjCaredID, 0, "SuperWeaponUp" )
end

--=========================================================
--右键点击ActionButton
--=========================================================
function SuperWeaponUp_Resume_Equip_Gem()

	if( this:IsVisible() ) then

		SuperWeaponUp_Clear()

	end
end

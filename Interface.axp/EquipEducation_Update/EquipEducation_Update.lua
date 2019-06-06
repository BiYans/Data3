
local MAX_OBJ_DISTANCE = 3.0
local g_CaredNpc = -1
local g_EquipEducation_Update_Item = -1
local g_EquipEducation_Update_DemandMoney = 0
local g_EquipEducation_Update_GRID_SKIP = 96


local g_EquipEducation_Update_Frame_UnifiedPosition;
local g_EquipEducation_Update_binditem = 20700055
local g_EUAttr_list = {};
local g_Select_Property = -1;

local g_IsExtra_ItemPos = -1	--Ç¿»¯µÀ¾ßµÄ±³°üÎ»ÖÃ
local g_EquipEducation_Transfer_Confirm = -1;
local g_EquipEducation_Transfer_ExConfirm = -1;
local g_ItemX = 20700055;
local g_ItemA = 20700057;
local g_ItemB = 20700059;
local g_ItemC = 20700061;

local g_ItemUnBindA = 20700056;
local g_ItemUnBindB = 20700058;
local g_ItemUnBindC = 20700060;

--=========================================================
-- ×¢²á´°¿Ú¹ØÐÄµÄËùÓÐÊÂ¼þ
--=========================================================
function EquipEducation_Update_PreLoad()
	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("SHOUGONG_ATTALEVELUP")
	this:RegisterEvent("OBJECT_CARED_EVENT")
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("UNIT_MONEY")
	this:RegisterEvent("MONEYJZ_CHANGE")	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	this:RegisterEvent("EQUIP_UPDATE_SENDMSG")
end

--=========================================================
-- ÔØÈë³õÊ¼»¯
--=========================================================
function EquipEducation_Update_OnLoad()
	g_EquipEducation_Update_Item = -1
	g_IsExtra_ItemPos = 1
	g_EquipEducation_Update_DemandMoney = 0
	-- Ê¼ÖÕ¿ÉÒÔµã»÷ OK °´Å¥, ÎªÁË·½±ãÌáÊ¾Íæ¼ÒÐÅÏ¢
	EquipEducation_Update_OK:Enable()
	
	g_EquipEducation_Update_Frame_UnifiedPosition=EquipEducation_Update_Frame:GetProperty("UnifiedPosition");
	g_EUAttr_list[1] = EquipEducation_Update_AttrFirst
	g_EUAttr_list[2] = EquipEducation_Update_AttrSecond
	g_EUAttr_list[3] = EquipEducation_Update_AttrThird
end

--=========================================================
-- ÊÂ¼þ´¦Àí
--=========================================================
function EquipEducation_Update_OnEvent(event)
	if (event == "UI_COMMAND" and tonumber(arg0) == 20130528) then
		local xx = Get_XParam_INT(0)
		g_CaredNpc = DataPool:GetNPCIDByServerID(xx)
		if g_CaredNpc == -1 then
			PushDebugMessage("Dæ li®u máy chü có v¤n ð«")
			return
		end
		BeginCareObject_EquipEducation_Update()
		EquipEducation_Update_Clear()
		EquipEducation_Update_UpdateBasic()
		EquipEducation_Update_Hide_Extra()
		this:Show()
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 20130728 and this:IsVisible() ) then
		local bagIndex = Get_XParam_INT(0)
		EquipEducation_Update_Update(bagIndex,0)
		EquipEducation_Update_UpdateBasic()
		EquipEducation_Update_SetExtraAfterSuccess()
		--EquipEducation_Update_Select_Click(g_Select_Property)
	elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if (tonumber(arg0) ~= g_CaredNpc) then
			return
		end
		if ((arg1 == "distance" and tonumber(arg2) > MAX_OBJ_DISTANCE) or arg1=="destroy") then
			EquipEducation_Update_Close()
		end
	elseif (event == "SHOUGONG_ATTALEVELUP") then
		local solt  =  tonumber(arg1);
		if arg0 ~= nil and solt == 0 then
			EquipEducation_Update_Update(arg0,1)
			EquipEducation_Update_UpdateBasic()
		elseif arg0 ~= nil and solt == 1 then
			EquipEducation_Update_Update_Extra(arg0)
			EquipEducation_Update_UpdateBasic()
		end
	elseif (event == "UNIT_MONEY" or event =="MONEYJZ_CHANGE") then
		EquipEducation_Update_UpdateBasic()
	elseif (event == "RESUME_ENCHASE_GEM" and this:IsVisible()) then
		if( tonumber(arg0) == 133 ) then
			EquipEducation_Update_Clear()
			EquipEducation_Update_UpdateBasic()
		elseif ( tonumber(arg0) == 134 ) then
			EquipEducation_Update_Clean_Extra()
		end		
	elseif (event == "ADJEST_UI_POS" ) then
		EquipEducation_Update_Frame_On_ResetPos()
		
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipEducation_Update_Frame_On_ResetPos()
	elseif (event == "EQUIP_UPDATE_SENDMSG") then		
		if(tonumber(arg0) == 0) then
			g_EquipEducation_Transfer_Confirm = 1
		elseif(tonumber(arg0) == 1) then
			g_EquipEducation_Transfer_ExConfirm = 1
		end
	end
end

--=========================================================
-- ¸üÐÂ»ù±¾ÏÔÊ¾ÐÅÏ¢
-- ÔÚÕâÀï¼ÆËã½ðÇ®²¢ÏÔÊ¾
--=========================================================
function EquipEducation_Update_UpdateBasic()
	EquipEducation_Update_HaveGoldNum:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
	EquipEducation_Update_HaveNum:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))
end

--=========================================================
-- ÖØÖÃ½çÃæ
--=========================================================
function EquipEducation_Update_Clear()
	if g_EquipEducation_Update_Item ~= -1 then
		EquipEducation_Update_InputIcon:SetActionItem(-1)
		LifeAbility:Lock_Packet_Item(g_EquipEducation_Update_Item, 0)
		g_EquipEducation_Update_Item = -1
	end

	g_EquipEducation_Update_DemandMoney = 0
	g_Select_Property = -1
	DataPool:SetEquipUpdatePro(g_Select_Property);	
	for i = 0, 2 do
		g_EUAttr_list[i+1]:SetText("")
		g_EUAttr_list[i+1]:SetCheck(0)
		g_EUAttr_list[i+1]:SetProperty("Disabled", "True");
		--g_ETAfter_Attr[i+1]:SetText(szStr)
	end
	EquipEducation_Update_OK:SetProperty("Disabled", "True");
	EquipEducation_Update_NeedItem:SetText("")
	EquipEducation_Update_Pro:SetText("#{ZBSX_130625_24}")
	EquipEducation_Update_ExtraText:SetText("")
	EquipEducation_Update_Clean_Extra()
	g_EquipEducation_Transfer_Confirm = -1
	g_EquipEducation_Transfer_ExConfirm = -1
end

--=========================================================
-- ¸üÐÂ½çÃæ
--=========================================================
function EquipEducation_Update_Update(itemIndex,updateExtra)
	local index = tonumber(itemIndex)
	local theAction = EnumAction(index, "packageitem")

	if theAction:GetID() ~= 0 then
		-- Èç¹û¿Õ¸ñÄÚÒÑ¾­ÓÐ¶ÔÓ¦ÎïÆ·ÁË, Ìæ»»Ö®
		if g_EquipEducation_Update_Item ~= -1 and index ~= g_EquipEducation_Update_Item then
			EquipEducation_Update_Clear()
		end

		EquipEducation_Update_InputIcon:SetActionItem(theAction:GetID())
		LifeAbility:Lock_Packet_Item(index, 1)
		g_EquipEducation_Update_Item = index
		EquipEducation_Update_OK:SetProperty("Disabled", "False");
		for i = 0, 2 do
			g_EUAttr_list[i+1]:SetProperty("Disabled", "False");
			local pName,pLevel,pBValue,pPercent,pRValue = theAction:GetEquipAttaProperty(i);
			--local perStr = ScriptGlobal_Format("#{ZBSX_130625_15}", pPercent, pRValue)
			local perStr = ScriptGlobal_Format("#{ZBSX_130625_127}", pLevel, pRValue,pBValue,pPercent)
			local szStr = ""
			if(SystemSetup:IsClassic() == 1) then
				szStr = "#cfff263#{"..pName.."}"..perStr;
			else
				szStr = "#cfff264#{"..pName.."}"..perStr;
			end
			g_EUAttr_list[i+1]:SetText(szStr)
			
			--g_ETAfter_Attr[i+1]:SetText(szStr)
		end
		if updateExtra > 0 then
			if g_Select_Property < 0 then
				EquipEducation_Update_Select_Click(1)
			else
				EquipEducation_Update_Select_Click(g_Select_Property)
			end
		end
		-- Éè¶¨ OK Îª×ÜÊÇ¿ÉÒÔµã»÷, ÕâÑù·½±ã¼ìÑé
		-- ÅÐ¶ÏÎïÆ·ÊÇ·ñÂú×ãÒªÇóÀ´Éè¶¨¹¦ÄÜbutton
		-- EquipEducation_Update_Check_AllItem()
	else
		EquipEducation_Update_Clear()
	end
end






function EquipEducation_Update_SetExtraAfterSuccess()

	if( g_EquipEducation_Update_Item < 0 or g_Select_Property < 0) then
		return
	end
	
	local nLevel, nCost,nSuccPer, nItemX, nItemA, nItemB, nIteamC = PlayerPackage:GetEquipLevelUpInfo(g_EquipEducation_Update_Item,g_Select_Property);
	if(nLevel >= 0 ) then
		DataPool:SetEquipUpdatePro(nLevel);	--µÈ¼¶´æÒ»ÏÂ£¬Ò»»áÒªËãÐèÇóÎïÆ·µÄÊýÁ¿
		EquipEducation_Update_WantNum:SetProperty("MoneyNumber", tostring(nCost))
		local str = ScriptGlobal_Format("#{ZBSX_130625_31}", nItemX,PlayerPackage:GetItemName(g_ItemX))
		EquipEducation_Update_NeedItem:SetText(str)
		local SuccPerStr = string.format("%d",nSuccPer/100);	
		if(nLevel >= 100) then
			EquipEducation_Update_Pro:SetText("#{ZBSX_130625_25}")
			EquipEducation_Update_OK:Disable()
			EquipEducation_Update_Clean_Extra()
			EquipEducation_Update_Hide_Extra()
			return
		end
		if(nIteamC ~= nil and nIteamC > 0  ) then
			--PushDebugMessage("!!!!!!!!!!!!!")
			local Str = ScriptGlobal_Format("#{ZBSX_130625_32}", nIteamC, PlayerPackage:GetItemName(g_ItemC))
			EquipEducation_Update_ExtraText:SetText(Str)
			if(nSuccPer < 10000) then
				EquipEducation_Update_AfterSuccess(nIteamC,g_ItemC, g_ItemUnBindC)
			end
		elseif(nItemB > 0 ) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_32}", nItemB, PlayerPackage:GetItemName(g_ItemB))
			EquipEducation_Update_ExtraText:SetText(Str)
			if(nSuccPer < 10000) then
				EquipEducation_Update_AfterSuccess(nItemB,g_ItemB, g_ItemUnBindB)
			end
		elseif(nItemA > 0 ) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_32}", nItemA, PlayerPackage:GetItemName(g_ItemA))
			EquipEducation_Update_ExtraText:SetText(Str)
			if(nSuccPer < 10000) then
				EquipEducation_Update_AfterSuccess(nItemA,g_ItemA, g_ItemUnBindA)
			end
		else
			EquipEducation_Update_Clean_Extra()
		end	
	end
end
--=========================================================
-- È¡³ö´°¿ÚÄÚ·ÅÈëµÄÎïÆ·
--=========================================================
function EquipEducation_Update_Resume_Equip()
	if this:IsVisible() then
		if g_EquipEducation_Update_Item ~= -1 then
			LifeAbility:Lock_Packet_Item(g_EquipEducation_Update_Item, 0)
			EquipEducation_Update_InputIcon:SetActionItem(-1)
			g_EquipEducation_Update_Item = -1
		end
	end


end



local EB_FREE_BIND = 0;				-- ÎÞ°ó¶¨ÏÞÖÆ
local EB_BINDED = 1;				-- ÒÑ¾­°ó¶¨
local EB_GETUP_BIND =2			-- Ê°È¡°ó¶¨
local EB_EQUIP_BIND =3			-- ×°±¸°ó¶¨
--=========================================================
-- È·¶¨Ö´ÐÐ¹¦ÄÜ
--=========================================================
function EquipEducation_Update_OK_Clicked()

	if g_EquipEducation_Update_Item < 0 then
		return
	end
	if ( PlayerPackage:IsChongLouItem(g_EquipEducation_Update_Item) == 1 ) then	--ÊÇÖØÂ¥ÎÞÐè¶þ´ÎÈ·ÈÏ
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("EquipLevelupAtta");
			Set_XSCRIPT_ScriptID(890088);
			Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
			Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
			Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
			Set_XSCRIPT_ParamCount(3);
		Send_XSCRIPT();
		return	
	end
	
	if g_EquipEducation_Transfer_Confirm == 1 and g_IsExtra_ItemPos < 0 then
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("EquipLevelupAtta");
			Set_XSCRIPT_ScriptID(890088);
			Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
			Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
			Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
			Set_XSCRIPT_ParamCount(3);
		Send_XSCRIPT();
		return
	elseif g_EquipEducation_Transfer_ExConfirm == 1 then
		if(PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Update_binditem)) <= 0 then
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipLevelupAtta");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
				Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
				Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
				Set_XSCRIPT_ParamCount(3);
			Send_XSCRIPT();	
			return
		elseif g_EquipEducation_Transfer_Confirm == 1 then
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipLevelupAtta");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
				Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
				Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
				Set_XSCRIPT_ParamCount(3);
			Send_XSCRIPT();	
			return			
		end
	end
	
	
	if(PlayerPackage:GetItemBindStatusByIndex(g_EquipEducation_Update_Item) == 1 ) then		--×°±¸ÊÇ°ó¶¨µÄ¾Í²»ÓÃÌáÊ¾ÁË
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("EquipLevelupAtta");
			Set_XSCRIPT_ScriptID(890088);
			Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
			Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
			Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
			Set_XSCRIPT_ParamCount(3);
		Send_XSCRIPT();
		return
	end
	if( PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Update_binditem)) > 0 then	--±³°üÀïÓÐ°ó¶¨µÄ¾«½ðÊ¯
		if( g_IsExtra_ItemPos < 0 ) then		
			PushEvent("EQUIP_UPDATE_CONFIRM",0);
			return
		elseif( g_EquipEducation_Transfer_ExConfirm > 0) then
			PushEvent("EQUIP_UPDATE_CONFIRM",0);
			return
		end
		

	end
	
	if(g_IsExtra_ItemPos >= 0) then
		if(PlayerPackage:GetItemBindStatusByIndex(g_IsExtra_ItemPos) == 1 ) then
			PushEvent("EQUIP_UPDATE_CONFIRM",1, PlayerPackage:GetItemTableIndex(g_IsExtra_ItemPos));
			return
		else
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipLevelupAtta");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
				Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
				Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
				Set_XSCRIPT_ParamCount(3);
			Send_XSCRIPT();			
		end
	else
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipLevelupAtta");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Update_Item);
				Set_XSCRIPT_Parameter(1, tonumber(g_Select_Property))
				Set_XSCRIPT_Parameter(2, tonumber(g_IsExtra_ItemPos));	--
				Set_XSCRIPT_ParamCount(3);
			Send_XSCRIPT();			
	end
end

--=========================================================
-- ¹Ø±Õ½çÃæ
--=========================================================
function EquipEducation_Update_Closed()
	this:Hide()
	return
end

--=========================================================
-- ½çÃæÒþ²Ø
--=========================================================
function EquipEducation_Update_OnHiden()
	StopCareObject_EquipEducation_Update()
	EquipEducation_Update_Clear()
	return
end

--=========================================================
-- ¿ªÊ¼¹ØÐÄNPC£¬
-- ÔÚ¿ªÊ¼¹ØÐÄÖ®Ç°ÐèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓÐ¡°¹ØÐÄ¡±µÄNPC£¬
-- Èç¹ûÓÐµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓÐµÄ¡°¹ØÐÄ¡±
--=========================================================
function BeginCareObject_EquipEducation_Update()

	this:CareObject(g_CaredNpc, 1, "EquipEducation_Update")
	return
end

--=========================================================
-- Í£Ö¹¶ÔÄ³NPCµÄ¹ØÐÄ
--=========================================================
function StopCareObject_EquipEducation_Update()
	this:CareObject(g_CaredNpc, 0, "EquipEducation_Update")
	g_CaredNpc = -1
	return
end

--=========================================================
-- Íæ¼Ò½ðÇ®±ä»¯
--=========================================================
function EquipEducation_Update_UserMoneyChanged()
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	-- ÅÐ¶Ï½ðÇ®¹»²»¹»
	if selfMoney < g_EquipEducation_Update_DemandMoney then
		--EquipEducation_Update_OK:Disable()
		return -1
	end
	return 1
end

function EquipEducation_Update_Frame_On_ResetPos()
  EquipEducation_Update_Frame:SetProperty("UnifiedPosition", g_EquipEducation_Update_Frame_UnifiedPosition);
end

function EquipEducation_Update_Select_Click(num) --±£´æÑ¡µÄÊôÐÔ
	if g_EquipEducation_Update_Item < 0 then
		return 
	end
	
	if(g_Select_Property == num) then
		return
	end
	
	EquipEducation_Update_Hide_Extra()
	EquipEducation_Update_OK:Enable()
	g_EUAttr_list[num]:SetCheck(1)		--Ä¬ÈÏÑ¡ÖÐµÚÒ»¸ö
	g_Select_Property = num;
	local nLevel, nCost,nSuccPer, nItemX, nItemA, nItemB, nIteamC = PlayerPackage:GetEquipLevelUpInfo(g_EquipEducation_Update_Item,num);
	local SuccPerStr = string.format("%d",nSuccPer/100);	
	if(nLevel >= 0 ) then
		DataPool:SetEquipUpdatePro(nLevel);	--µÈ¼¶´æÒ»ÏÂ£¬Ò»»áÒªËãÐèÇóÎïÆ·µÄÊýÁ¿
		EquipEducation_Update_WantNum:SetProperty("MoneyNumber", tostring(nCost))
		local str = ScriptGlobal_Format("#{ZBSX_130625_31}", nItemX,PlayerPackage:GetItemName(g_ItemX))
		EquipEducation_Update_NeedItem:SetText(str)
		if(nLevel >= 100) then
			EquipEducation_Update_Pro:SetText("#{ZBSX_130625_25}")
			EquipEducation_Update_OK:Disable()
			return
		elseif(nSuccPer >= 10000) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_27}", SuccPerStr)
			EquipEducation_Update_Pro:SetText(Str)
		elseif(nSuccPer < 10000) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_26}", SuccPerStr)
			EquipEducation_Update_Pro:SetText(Str)
			EquipEducation_Update_Show_Extra()
		end	
		
		EquipEducation_Update_SetExtraAfterSuccess()
	end	
end

function EquipEducation_Update_AfterSuccess(nNeedItem,ItemBindindex,ItemUnBindindex)
	if(g_IsExtra_ItemPos > 0)then
		if(PlayerPackage:GetBagItemNum(g_IsExtra_ItemPos) >= nNeedItem and 
		( PlayerPackage:GetItemTableIndex(g_IsExtra_ItemPos) == ItemBindindex or PlayerPackage:GetItemTableIndex(g_IsExtra_ItemPos) == ItemUnBindindex)) then
			EquipEducation_Update_Update_Extra(g_IsExtra_ItemPos)
			EquipEducation_Update_Extra:Show()
			if SystemSetup:IsClassic() == 1 then
				EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:390 h:505")
			else
				EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:430 h:540")
			end
			DataPool:SetEquipUpdateIsSetEquip(1);
		else
			EquipEducation_Update_Show_Extra()
		end
	else
		EquipEducation_Update_Show_Extra()
	end
end
function EquipEducation_Update_Update_Extra(ExtraItem)
	local index = tonumber(ExtraItem)
	local theAction = EnumAction(index, "packageitem")

	if theAction:GetID() ~= 0 then

		-- Èç¹û¿Õ¸ñÄÚÒÑ¾­ÓÐ¶ÔÓ¦ÎïÆ·ÁË, Ìæ»»Ö®
		if g_IsExtra_ItemPos ~= -1 and index ~= g_IsExtra_ItemPos then
			EquipEducation_Update_Clean_Extra()
		end
		g_IsExtra_ItemPos = index --±£´æ±³°üÎ»ÖÃ
		EquipEducation_Update_ExtraIcon:SetActionItem(theAction:GetID())
		LifeAbility:Lock_Packet_Item(index, 1)
		
		local Str = ScriptGlobal_Format("#{ZBSX_130625_27}", 100) --Ö±½Ó100%
		EquipEducation_Update_Pro:SetText(Str)
	else
		EquipEducation_Update_Clear()
	end
end

function EquipEducation_Update_Clean_Extra()
	if g_IsExtra_ItemPos ~= -1 then
		EquipEducation_Update_ExtraIcon:SetActionItem(-1)
		LifeAbility:Lock_Packet_Item(g_IsExtra_ItemPos, 0)
		g_IsExtra_ItemPos = -1
		g_EquipEducation_Transfer_ExConfirm = -1
		g_EquipEducation_Transfer_Confirm = -1
	end
	if(g_EquipEducation_Update_Item >= 0 and g_Select_Property > 0) then
		local nLevel, nCost,nSuccPer, nItemX, nItemA, nItemB, nIteamC = PlayerPackage:GetEquipLevelUpInfo(g_EquipEducation_Update_Item,g_Select_Property);
		local SuccPerStr = string.format("%d",nSuccPer/100);
		local Str = ScriptGlobal_Format("#{ZBSX_130625_26}", SuccPerStr)		
		if(nLevel >= 100) then
			EquipEducation_Update_Pro:SetText("#{ZBSX_130625_25}")
		elseif(nSuccPer >= 10000) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_27}", SuccPerStr)
			EquipEducation_Update_Pro:SetText(Str)
		elseif(nSuccPer < 10000) then
			local Str = ScriptGlobal_Format("#{ZBSX_130625_26}", SuccPerStr)
			EquipEducation_Update_Pro:SetText(Str)
		end	
	end
end


function EquipEducation_Update_Hide_Extra()
		EquipEducation_Update_Extra:Hide()
		if SystemSetup:IsClassic() == 1 then
			EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:390 h:456")
		else
			EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:430 h:485")
		end
		DataPool:SetEquipUpdateIsSetEquip(-1);
end

function EquipEducation_Update_Show_Extra()
		EquipEducation_Update_Clean_Extra()
		EquipEducation_Update_Extra:Show()
		if SystemSetup:IsClassic() == 1 then
			EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:390 h:505")
		else
			EquipEducation_Update_Frame:SetProperty("AbsoluteSize","w:430 h:540")
		end
		DataPool:SetEquipUpdateIsSetEquip(1);
end

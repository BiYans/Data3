
local MAX_OBJ_DISTANCE = 3.0
local g_CaredNpc = -1
local g_EquipEducation_Temper_Item = -1
local g_EquipEducation_Temper_IsBind = 0
local g_EquipEducation_Temper_HaveGoldNum = 0
local g_EquipEducation_Temper_Confirm = -1
local g_EquipEducation_Temper_binditem = 20700063
local g_EquipEducation_Temper_unbinditem = 20700062
local g_ItemNeed = 20700062
local g_LockState = {}
local g_IsHaveAttaPro = 0



local g_EquipEducation_Temper_Frame_UnifiedPosition;

local g_ETemper_Attr = {};

--=========================================================
-- ×¢²á´°¿Ú¹ØÐÄµÄËùÓÐÊÂ¼þ
--=========================================================
function EquipEducation_Temper_PreLoad()
	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("SHOUGONG_FUZHUO")
	this:RegisterEvent("OBJECT_CARED_EVENT")
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("UNIT_MONEY")
	this:RegisterEvent("MONEYJZ_CHANGE")

	this:RegisterEvent("CONFIRM_EquipEducation_Temper")
	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	this:RegisterEvent("EQUIP_TEMPER_SENDMSG")
end

--=========================================================
-- ÔØÈë³õÊ¼»¯
--=========================================================
function EquipEducation_Temper_OnLoad()
	g_EquipEducation_Temper_Item = -1
	g_EquipEducation_Temper_HaveGoldNum = 0
	EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", tostring(g_EquipEducation_Temper_HaveGoldNum))

	-- Ê¼ÖÕ¿ÉÒÔµã»÷ OK °´Å¥, ÎªÁË·½±ãÌáÊ¾Íæ¼ÒÐÅÏ¢
	EquipEducation_Temper_OK:Enable()
	
	g_EquipEducation_Temper_Frame_UnifiedPosition=EquipEducation_Temper_Frame:GetProperty("UnifiedPosition");
	g_ETemper_Attr[1] = EquipEducation_Temper_AttrFirstText
	g_ETemper_Attr[2] = EquipEducation_Temper_AttrSecondText
	g_ETemper_Attr[3] = EquipEducation_Temper_AttrThirdText
	
	g_LockState[1] = {Button = EquipEducation_Temper_AttrFirstButton, State = 0}	--Î´Ëø¶¨×´Ì¬
	g_LockState[2] = {Button = EquipEducation_Temper_AttrSecondButton, State = 0}
	g_LockState[3] = {Button = EquipEducation_Temper_AttrThirdButton, State = 0}
end

--=========================================================
-- ÊÂ¼þ´¦Àí
--=========================================================
function EquipEducation_Temper_OnEvent(event)
	if (event == "UI_COMMAND" and tonumber(arg0) == 20130604) then
		local xx = Get_XParam_INT(0)
		g_CaredNpc = DataPool:GetNPCIDByServerID(xx)
		if g_CaredNpc == -1 then
			PushDebugMessage("Dæ li®u máy chü có v¤n ð«")
			return
		end
		BeginCareObject_EquipEducation_Temper()
		EquipEducation_Temper_Clear()
		EquipEducation_Temper_UpdateBasic()
		this:Show()
	elseif(event == "UI_COMMAND" and tonumber(arg0) == 20130724 and this:IsVisible()) then
		--´ãÁ¶³É¹¦Ë¢ÐÂÊôÐÔ
		local bagIndex = Get_XParam_INT(0)
		BeginCareObject_EquipEducation_Temper()
		EquipEducation_Temper_UpdateBasic()
		EquipEducation_Temper_Update(tonumber(bagIndex))
		this:Show()
	elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if (tonumber(arg0) ~= g_CaredNpc) then
			return
		end
		if ((arg1 == "distance" and tonumber(arg2) > MAX_OBJ_DISTANCE) or arg1=="destroy") then
			EquipEducation_Temper_Close()
		end
	elseif (event == "PACKAGE_ITEM_CHANGED" and this:IsVisible()) then
			EquipEducation_Temper_UpdateBasic()
	elseif (event == "SHOUGONG_FUZHUO") then
		if arg0 ~= nil then
			EquipEducation_Temper_Update(arg0)
			EquipEducation_Temper_UpdateBasic()
		end
	elseif (event == "UNIT_MONEY" or event =="MONEYJZ_CHANGE") then
		EquipEducation_Temper_UpdateBasic()
	elseif (event == "CONFIRM_EquipEducation_Temper") then
		EquipEducation_Temper_OK_Clicked(1)
		
	elseif (event == "ADJEST_UI_POS" ) then
		EquipEducation_Temper_Frame_On_ResetPos()
		
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipEducation_Temper_Frame_On_ResetPos()
	elseif (event == "RESUME_ENCHASE_GEM") then
		EquipEducation_Temper_Clear()
	elseif (event == "EQUIP_TEMPER_SENDMSG") then
		g_EquipEducation_Temper_Confirm = 1;
	end
end

--=========================================================
-- ¸üÐÂ»ù±¾ÏÔÊ¾ÐÅÏ¢
-- ÔÚÕâÀï¼ÆËã½ðÇ®²¢ÏÔÊ¾
--=========================================================
function EquipEducation_Temper_UpdateBasic()
	 EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", Player:GetData("MONEY"))
	 EquipEducation_Temper_HaveNum:SetProperty("MoneyNumber", Player:GetData("MONEY_JZ"))
end

--=========================================================
-- ÖØÖÃ½çÃæ
--=========================================================
function EquipEducation_Temper_Clear()
	if g_EquipEducation_Temper_Item ~= -1 then
		EquipEducation_Temper_InputIcon:SetActionItem(-1)
		LifeAbility:Lock_Packet_Item(g_EquipEducation_Temper_Item, 0)
		g_EquipEducation_Temper_Item = -1
	end

	g_EquipEducation_Temper_HaveGoldNum = 0
	for i=1,3 do
		g_ETemper_Attr[i]:SetText("")
		g_LockState[i].State = 0;
		g_LockState[i].Button:SetProperty("Selected", "False");
		--g_LockState[i].Button:SetProperty("Disabled", "True");
	end
	g_IsHaveAttaPro = 0	
	EquipEducation_Temper_NeedItem:SetText("");	
	EquipEducation_Temper_WantNum:SetProperty("MoneyNumber", 0)
	EquipEducation_Temper_OK:SetProperty("Disabled", "True")
	
	g_EquipEducation_Temper_Confirm = -1
	-- EquipEducation_Temper_NumericalValue:SetProperty("DefaultEditBox", "True")
	-- EquipEducation_Temper_NumericalValue:SetSelected(0, -1)
end

--=========================================================
-- ¸üÐÂ½çÃæ
--=========================================================
function EquipEducation_Temper_Update(itemIndex)
	local index = tonumber(itemIndex)
	local theAction = EnumAction(index, "packageitem")

	if theAction:GetID() ~= 0 then


		-- Èç¹û¿Õ¸ñÄÚÒÑ¾­ÓÐ¶ÔÓ¦ÎïÆ·ÁË, Ìæ»»Ö®
		if g_EquipEducation_Temper_Item ~= -1 and index ~= g_EquipEducation_Temper_Item then
			EquipEducation_Temper_Clear()
		end

		EquipEducation_Temper_InputIcon:SetActionItem(theAction:GetID())
		LifeAbility:Lock_Packet_Item(index, 1)
		g_EquipEducation_Temper_Item = index
		
		for i = 0, 2 do
			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(i);
			if(pLevel == nil or pLevel <= 0) then
				g_ETemper_Attr[i+1]:SetText("#{ZBSX_130625_14}")
			else
				--local perStr = ScriptGlobal_Format("#{ZBSX_130625_15}", pPercent, pRValue)
				local perStr = ScriptGlobal_Format("#{ZBSX_130625_127}", pLevel, pRValue,pBValue,pPercent)
				local szStr = "#cfff263#{"..pName.."}"..perStr;
				g_ETemper_Attr[i+1]:SetText(szStr)
				g_IsHaveAttaPro = 1
			end
		end
		
		g_EquipEducation_Temper_IsBind = GetItemBindStatus(g_EquipEducation_Temper_Item)	--»ñÈ¡°ó¶¨×´Ì¬
		local LockedNum = 0
		for i=1,3 do
			if( g_LockState[i].Button:GetCheck() == 1) then
				LockedNum = LockedNum+1;
			end
		end	
		local itemneed,cost = DataPool:GetEquipChangerate(LockedNum);
		local  strInfo = ScriptGlobal_Format("#{ZBSX_130625_20}",itemneed,PlayerPackage:GetItemName(g_ItemNeed))
		EquipEducation_Temper_NeedItem:SetText(strInfo);
		EquipEducation_Temper_WantNum:SetProperty("MoneyNumber", cost)
		EquipEducation_Temper_OK:SetProperty("Disabled", "False")
		g_EquipEducation_Temper_Confirm = -1
		-- Éè¶¨ OK Îª×ÜÊÇ¿ÉÒÔµã»÷, ÕâÑù·½±ã¼ìÑé
		-- ÅÐ¶ÏÎïÆ·ÊÇ·ñÂú×ãÒªÇóÀ´Éè¶¨¹¦ÄÜbutton
		-- EquipEducation_Temper_Check_AllItem()
	else
		EquipEducation_Temper_Clear()
	end
end




--=========================================================
-- È¡³ö´°¿ÚÄÚ·ÅÈëµÄÎïÆ·
--=========================================================
function EquipEducation_Temper_Resume_Equip()
	if this:IsVisible() then
		if g_EquipEducation_Temper_Item ~= -1 then
			LifeAbility:Lock_Packet_Item(g_EquipEducation_Temper_Item, 0)
			EquipEducation_Temper_InputIcon:SetActionItem(-1)
			g_EquipEducation_Temper_Item = -1
		end
	end
end

--=========================================================
-- ÅÐ¶ÏÊÇ·ñËùÓÐÎïÆ·¶¼ÒÑ·ÅºÃ
-- Ö»ÔÚµã»÷ OK °´Å¥µÄÊ±ºòµ÷ÓÃÕâ¸öº¯Êý
--=========================================================
function EquipEducation_Temper_Check_AllItem()
	EquipEducation_Temper_UpdateBasic()

	if g_EquipEducation_Temper_Item == -1 then
		g_EquipEducation_Temper_HaveGoldNum = 0
		EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", tostring(g_EquipEducation_Temper_HaveGoldNum))
		return 1
	end

	-- ÅÐ¶Ï×°±¸ÊÇ·ñÄÜ¹»Ç¿»¯(Ã»ÓÐÊ´¿ÌµñÎÆ»òÕßÇ¿»¯µ½¶¥¼¶ÁË·µ»Ø < 0)
	local ret = LifeAbility:CanEquipDiaowen_Enchase(g_EquipEducation_Temper_Item)
	if ret == -1 or ret == -2 then
		return 2
	end
	if ret < 0 then
		return 3
	end

	-- ÅÐ¶Ï½ð²ÏË¿ÊýÁ¿, ÊäÈëµÄ½ð²ÏË¿ÊýÁ¿
	-- ÔÚ Server ÅÐ¶Ï

	-- ÅÐ¶Ï½ðÇ®ÊÇ·ñ×ã¹»
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if selfMoney < g_EquipEducation_Temper_HaveGoldNum then
		return 44
	end

	EquipEducation_Temper_OK:Enable()
	return 0
end


local EB_FREE_BIND = 0;				-- ÎÞ°ó¶¨ÏÞÖÆ
local EB_BINDED = 1;				-- ÒÑ¾­°ó¶¨
local EB_GETUP_BIND =2			-- Ê°È¡°ó¶¨
local EB_EQUIP_BIND =3			-- ×°±¸°ó¶¨
--=========================================================
-- È·¶¨Ö´ÐÐ¹¦ÄÜ
--=========================================================
function EquipEducation_Temper_OK_Clicked()
	local lockstr = {}
	for i = 1,3 do
		if(g_LockState[i].Button:GetCheck() == 1) then
			lockstr[i] =1 
		else
			lockstr[i] =0 
		end		
	end
	
	local LockedNum = 0
	for i=1,3 do
		if( g_LockState[i].Button:GetCheck() == 1) then
			LockedNum = LockedNum+1;
		end
	end
	local itemneed,cost = DataPool:GetEquipChangerate(LockedNum);
	if PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Temper_binditem) + PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Temper_unbinditem) < itemneed then
		local Str = ScriptGlobal_Format("#{ZBSX_130625_91}", PlayerPackage:GetItemName(g_EquipEducation_Temper_binditem), PlayerPackage:GetItemName(g_EquipEducation_Temper_binditem))
		PushDebugMessage(Str)
		return
	end
	
	if PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Temper_binditem) > 0 then  --°ó¶¨µÄµÀ¾ß×Ô¼º¾Í¹»ÁË
		if(PlayerPackage:GetItemBindStatusByIndex(g_EquipEducation_Temper_Item) == 1 ) then	--Èç¹û×°±¸Ò²ÊÇ°ó¶¨µÄ¾Í²»ÓÃÌáÊ¾ÁË
			
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Temper_Item);
				Set_XSCRIPT_Parameter(1,lockstr[1])
				Set_XSCRIPT_Parameter(2,lockstr[2])
				Set_XSCRIPT_Parameter(3,lockstr[3])
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();	
		elseif g_EquipEducation_Temper_Confirm == 1 or PlayerPackage:IsChongLouItem(g_EquipEducation_Temper_Item) == 1 then
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Temper_Item);
				Set_XSCRIPT_Parameter(1,lockstr[1])
				Set_XSCRIPT_Parameter(2,lockstr[2])
				Set_XSCRIPT_Parameter(3,lockstr[3])
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();			
		else
			--±¯¾ç¿ªÊ¼£¬µ¯³öÌáÊ¾
			PushEvent("EQUIP_TEMPER_CONFIRM");
		end
	else			--È«²¿ÊÇ·Ç°ó¶¨µÄ²ÄÁÏÖ±½ÓÓÃ
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,g_EquipEducation_Temper_Item);
				Set_XSCRIPT_Parameter(1,lockstr[1])
				Set_XSCRIPT_Parameter(2,lockstr[2])
				Set_XSCRIPT_Parameter(3,lockstr[3])
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();			
	end
	
	-- Clear_XSCRIPT();
		-- Set_XSCRIPT_Function_Name("EquipCuiLian");
		-- Set_XSCRIPT_ScriptID(890088);
		-- Set_XSCRIPT_Parameter(0,g_EquipEducation_Temper_Item);
		-- Set_XSCRIPT_Parameter(1,lockstr[1])
		-- Set_XSCRIPT_Parameter(2,lockstr[2])
		-- Set_XSCRIPT_Parameter(3,lockstr[3])
		-- Set_XSCRIPT_ParamCount(4);
	-- Send_XSCRIPT();
end

--=========================================================
-- ¹Ø±Õ½çÃæ
--=========================================================
function EquipEducation_Temper_Close()
	this:Hide()
	return
end

--=========================================================
-- ½çÃæÒþ²Ø
--=========================================================
function EquipEducation_Temper_OnHiden()
	StopCareObject_EquipEducation_Temper()
	EquipEducation_Temper_Clear()
	this:Hide()
	return
end

--=========================================================
-- ¿ªÊ¼¹ØÐÄNPC£¬
-- ÔÚ¿ªÊ¼¹ØÐÄÖ®Ç°ÐèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓÐ¡°¹ØÐÄ¡±µÄNPC£¬
-- Èç¹ûÓÐµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓÐµÄ¡°¹ØÐÄ¡±
--=========================================================
function BeginCareObject_EquipEducation_Temper()

	this:CareObject(g_CaredNpc, 1, "EquipEducation_Temper")
	return
end

--=========================================================
-- Í£Ö¹¶ÔÄ³NPCµÄ¹ØÐÄ
--=========================================================
function StopCareObject_EquipEducation_Temper()
	this:CareObject(g_CaredNpc, 0, "EquipEducation_Temper")
	g_CaredNpc = -1
	return
end

--=========================================================
-- Íæ¼Ò½ðÇ®±ä»¯
--=========================================================
function EquipEducation_Temper_UserMoneyChanged()
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	-- ÅÐ¶Ï½ðÇ®¹»²»¹»
	if selfMoney < g_EquipEducation_Temper_HaveGoldNum then
		--EquipEducation_Temper_OK:Disable()
		return -1
	end
	return 1
end

function EquipEducation_Temper_Frame_On_ResetPos()
  EquipEducation_Temper_Frame:SetProperty("UnifiedPosition", g_EquipEducation_Temper_Frame_UnifiedPosition);
end

function EquipEducation_Temper_Lock_Attr(index)
	if(EquipEducation_Temper_InputIcon:GetActionItem() == -1) then

		g_LockState[index].Button:SetCheck(0);
	else
		if(g_IsHaveAttaPro == 0) then
			PushDebugMessage("#{ZBSX_130625_17}");
			g_LockState[index].Button:SetCheck(0);
		else
			local LockedNum = 0
			for i=1,3 do
				if( g_LockState[i].Button:GetCheck() == 1) then
					LockedNum = LockedNum+1;
				end
			end
			if(LockedNum == 3) then
				PushDebugMessage("#{ZBSX_130625_18}");
				g_LockState[index].Button:SetCheck(0);	
			else
				g_LockState[index].State = 1;
				local itemneed,cost = DataPool:GetEquipChangerate(LockedNum);
				local  strInfo = ScriptGlobal_Format("#{ZBSX_130625_20}",itemneed,PlayerPackage:GetItemName(g_ItemNeed))
				EquipEducation_Temper_NeedItem:SetText(strInfo);
				EquipEducation_Temper_WantNum:SetProperty("MoneyNumber", cost)
			end
		end
	end
	

end

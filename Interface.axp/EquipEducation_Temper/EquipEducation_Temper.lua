
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
-- ע�ᴰ�ڹ��ĵ������¼�
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
-- �����ʼ��
--=========================================================
function EquipEducation_Temper_OnLoad()
	g_EquipEducation_Temper_Item = -1
	g_EquipEducation_Temper_HaveGoldNum = 0
	EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", tostring(g_EquipEducation_Temper_HaveGoldNum))

	-- ʼ�տ��Ե�� OK ��ť, Ϊ�˷�����ʾ�����Ϣ
	EquipEducation_Temper_OK:Enable()
	
	g_EquipEducation_Temper_Frame_UnifiedPosition=EquipEducation_Temper_Frame:GetProperty("UnifiedPosition");
	g_ETemper_Attr[1] = EquipEducation_Temper_AttrFirstText
	g_ETemper_Attr[2] = EquipEducation_Temper_AttrSecondText
	g_ETemper_Attr[3] = EquipEducation_Temper_AttrThirdText
	
	g_LockState[1] = {Button = EquipEducation_Temper_AttrFirstButton, State = 0}	--δ����״̬
	g_LockState[2] = {Button = EquipEducation_Temper_AttrSecondButton, State = 0}
	g_LockState[3] = {Button = EquipEducation_Temper_AttrThirdButton, State = 0}
end

--=========================================================
-- �¼�����
--=========================================================
function EquipEducation_Temper_OnEvent(event)
	if (event == "UI_COMMAND" and tonumber(arg0) == 20130604) then
		local xx = Get_XParam_INT(0)
		g_CaredNpc = DataPool:GetNPCIDByServerID(xx)
		if g_CaredNpc == -1 then
			PushDebugMessage("D� li�u m�y ch� c� v�n �")
			return
		end
		BeginCareObject_EquipEducation_Temper()
		EquipEducation_Temper_Clear()
		EquipEducation_Temper_UpdateBasic()
		this:Show()
	elseif(event == "UI_COMMAND" and tonumber(arg0) == 20130724 and this:IsVisible()) then
		--�����ɹ�ˢ������
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
-- ���»�����ʾ��Ϣ
-- ����������Ǯ����ʾ
--=========================================================
function EquipEducation_Temper_UpdateBasic()
	 EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", Player:GetData("MONEY"))
	 EquipEducation_Temper_HaveNum:SetProperty("MoneyNumber", Player:GetData("MONEY_JZ"))
end

--=========================================================
-- ���ý���
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
-- ���½���
--=========================================================
function EquipEducation_Temper_Update(itemIndex)
	local index = tonumber(itemIndex)
	local theAction = EnumAction(index, "packageitem")

	if theAction:GetID() ~= 0 then


		-- ����ո����Ѿ��ж�Ӧ��Ʒ��, �滻֮
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
		
		g_EquipEducation_Temper_IsBind = GetItemBindStatus(g_EquipEducation_Temper_Item)	--��ȡ��״̬
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
		-- �趨 OK Ϊ���ǿ��Ե��, �����������
		-- �ж���Ʒ�Ƿ�����Ҫ�����趨����button
		-- EquipEducation_Temper_Check_AllItem()
	else
		EquipEducation_Temper_Clear()
	end
end




--=========================================================
-- ȡ�������ڷ������Ʒ
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
-- �ж��Ƿ�������Ʒ���ѷź�
-- ֻ�ڵ�� OK ��ť��ʱ������������
--=========================================================
function EquipEducation_Temper_Check_AllItem()
	EquipEducation_Temper_UpdateBasic()

	if g_EquipEducation_Temper_Item == -1 then
		g_EquipEducation_Temper_HaveGoldNum = 0
		EquipEducation_Temper_HaveGoldNum:SetProperty("MoneyNumber", tostring(g_EquipEducation_Temper_HaveGoldNum))
		return 1
	end

	-- �ж�װ���Ƿ��ܹ�ǿ��(û��ʴ�̵��ƻ���ǿ���������˷��� < 0)
	local ret = LifeAbility:CanEquipDiaowen_Enchase(g_EquipEducation_Temper_Item)
	if ret == -1 or ret == -2 then
		return 2
	end
	if ret < 0 then
		return 3
	end

	-- �жϽ��˿����, ����Ľ��˿����
	-- �� Server �ж�

	-- �жϽ�Ǯ�Ƿ��㹻
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if selfMoney < g_EquipEducation_Temper_HaveGoldNum then
		return 44
	end

	EquipEducation_Temper_OK:Enable()
	return 0
end


local EB_FREE_BIND = 0;				-- �ް�����
local EB_BINDED = 1;				-- �Ѿ���
local EB_GETUP_BIND =2			-- ʰȡ��
local EB_EQUIP_BIND =3			-- װ����
--=========================================================
-- ȷ��ִ�й���
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
	
	if PlayerPackage:CountAvailableItemByIDTable(g_EquipEducation_Temper_binditem) > 0 then  --�󶨵ĵ����Լ��͹���
		if(PlayerPackage:GetItemBindStatusByIndex(g_EquipEducation_Temper_Item) == 1 ) then	--���װ��Ҳ�ǰ󶨵ľͲ�����ʾ��
			
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
			--���翪ʼ��������ʾ
			PushEvent("EQUIP_TEMPER_CONFIRM");
		end
	else			--ȫ���Ƿǰ󶨵Ĳ���ֱ����
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
-- �رս���
--=========================================================
function EquipEducation_Temper_Close()
	this:Hide()
	return
end

--=========================================================
-- ��������
--=========================================================
function EquipEducation_Temper_OnHiden()
	StopCareObject_EquipEducation_Temper()
	EquipEducation_Temper_Clear()
	this:Hide()
	return
end

--=========================================================
-- ��ʼ����NPC��
-- �ڿ�ʼ����֮ǰ��Ҫ��ȷ����������ǲ����Ѿ��С����ġ���NPC��
-- ����еĻ�����ȡ���Ѿ��еġ����ġ�
--=========================================================
function BeginCareObject_EquipEducation_Temper()

	this:CareObject(g_CaredNpc, 1, "EquipEducation_Temper")
	return
end

--=========================================================
-- ֹͣ��ĳNPC�Ĺ���
--=========================================================
function StopCareObject_EquipEducation_Temper()
	this:CareObject(g_CaredNpc, 0, "EquipEducation_Temper")
	g_CaredNpc = -1
	return
end

--=========================================================
-- ��ҽ�Ǯ�仯
--=========================================================
function EquipEducation_Temper_UserMoneyChanged()
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	-- �жϽ�Ǯ������
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

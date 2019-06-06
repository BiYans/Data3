--*********************************************
--������װ��������
--*********************************************

local PetEquipSuitUpName = "PetEquipSuitUp"
local g_PetEquipItemPos  = -1
local g_PetEquipItemID	 = -1
local g_PetEquipProductID= -1
local g_ObjCareID		 = -1
local g_ProductNeedMoney = 0
local g_PetEquipUiIndex	 = 19831204
local MAX_OBJ_DISTANCE 	 = 3.0;
local g_PetEquipFunCtrl  = -1	--���ܿ���

--**********************************************
--�¼�ע��
--**********************************************
function PetEquipSuitUp_PreLoad()
	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("UNIT_MONEY")
	this:RegisterEvent("MONEYJZ_CHANGE")
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("OBJECT_CARED_EVENT")
	this:RegisterEvent("UPDATE_PETEQUIP_UP") --�½�һ���������¼�
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")
	this:RegisterEvent("NEW_DEBUGMESSAGE")
end


--**********************************************
--
--**********************************************
function PetEquipSuitUp_OnLoad()
end


--**********************************************
--�¼���Ӧ
--**********************************************
function PetEquipSuitUp_OnEvent( event )
	if (event == "UI_COMMAND") then
		PetEquipSuitUp_UiCommand(arg0)
	elseif (event == "UNIT_MONEY") then
		PetEquipSuitUp_UnitMoney()
	elseif (event == "MONEYJZ_CHANGE") then
		PetEquipSuitUp_JZMChange()
	elseif (event == "RESUME_ENCHASE_GEM") then
		PetEquipSuitUp_Resume_Equip(1)
	elseif (event == "OBJECT_CARED_EVENT") then
		PetEquipSuitUp_CareEvent(arg0,arg1,arg2)
	elseif (event == "UPDATE_PETEQUIP_UP") then
		PetEquipSuitUp_Update(arg0)
	elseif (event == "PACKAGE_ITEM_CHANGED") then
		PetEquipSuitUp_PackageItemChange(arg0)
	end
end


--**********************************************
--ȷ����ť
--**********************************************
function PetEquipSuitUp_Buttons_Clicked()
	--�Ƿ�ɳ���װ����������
	if (g_PetEquipItemPos == -1 or g_PetEquipProductID == -1) then
		return
	end

	--����ľ�װ����Table�е�ID
	if (g_PetEquipItemID == -1) then
		return
	end

	--�ж���Ʒ�Ƿ�������㹻�ڷ��������ж�

	--�жϽ�Ǯ�ǲ��ǹ�
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if (selfMoney < g_ProductNeedMoney) then
		PushDebugMessage( "Kh�ng �� ti�n, kh�ng th� ti�n h�nh th�ng c�p Trang B� Tr�n Th�!" )
		return
	end

	--���͸����������������
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnPetEquipSuitUp")
		Set_XSCRIPT_ScriptID(800109)
		Set_XSCRIPT_Parameter(0,g_PetEquipItemPos)
		Set_XSCRIPT_Parameter(1,g_ObjCareID)
		Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT()
	PetEquipSuitUp_Clear()
end


--*************************************************
--���ý���
--*************************************************
function PetEquipSuitUp_Clear()
	if (g_PetEquipItemPos ~= -1) then
		LifeAbility : Lock_Packet_Item(g_PetEquipItemPos,0);
	end

	PetEquipSuitUp_Accept:Disable()
	PetEquipSuitUp_GemItem:SetActionItem(-1)
	PetEquipSuitUp_ProductItem:SetActionItem(-1)
	PetEquipSuitUp_ProductItem:Hide();
	PetEquipSuitUp_Explain2_Info:SetText("#{ZSZBSJ_XML_05}")
	PetEquipSuitUp_Explain4:SetText("#{ZSZBSJ_XML_03}")
	PetEquipSuitUp_Demand_Jiaozi:SetProperty("MoneyNumber", "")
	PetEquipSuitUp_Explain3_Text2:SetText("")
	g_PetEquipItemPos  = -1
	g_PetEquipItemID   = -1
	g_PetEquipProductID= -1
	g_ProductNeedMoney = 0
end

--*************************************************
--����UI_COMMAND�߼�
--*************************************************
function PetEquipSuitUp_UiCommand(arg0)

	--����Ƿ���иý���
	local nUiIdx = tonumber(arg0)
	if (nUiIdx ~= g_PetEquipUiIndex) then
		return
	end

	--���ĵ�ǰ�Ի���NPC
	local targetId = Get_XParam_INT(0)
	g_ObjCareID = DataPool:GetNPCIDByServerID(targetId);
	if (g_ObjCareID == -1) then
		PushDebugMessage("D� li�u c�a server truy�n tr� l�i c� v�n �");
		return
	end

	--��ȡ���Ǹ���֧���ܵĿ��Ʒ�
	--1 Ϊ����װ�����ǹ���
	g_PetEquipFunCtrl = Get_XParam_INT(1)

	PetEquipSuitUp_BeginCareObject()
	PetEquipSuitUp_Clear()
	this:Show();
end

--*************************************************
--����UNIT_MONEY�߼�
--*************************************************
function PetEquipSuitUp_UnitMoney()
	PetEquipSuitUp_Currently_Money:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
end

--*************************************************
--����MONEYJZ_CHANGE�߼�
--*************************************************
function PetEquipSuitUp_JZMChange()
	PetEquipSuitUp_Currently_Jiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))
end

--*************************************************
--����RESUME_ENCHASE_GEM�߼�
--*************************************************
function PetEquipSuitUp_Resume_Equip(Index)
	if (Index ~= 1) then
		return
	end

	LifeAbility:Lock_Packet_Item(g_PetEquipItemPos, 0)
	PetEquipSuitUp_GemItem:SetActionItem(-1)
	g_PetEquipItemPos=-1
	PetEquipSuitUp_Clear()
	PetEquipSuitUp_ProductItem:SetActionItem(-1)
	g_PetEquipProductID=-1
	PetEquipSuitUp_Demand_Jiaozi:SetProperty("MoneyNumber", "")
	PetEquipSuitUp_Accept:Disable()
end

--*************************************************
--����OBJECT_CARED_EVENT�߼�
--*************************************************
function PetEquipSuitUp_CareEvent(arg0,arg1,arg2)
	local ObjCaredID = tonumber(arg0)
	if( ObjCaredID ~= g_ObjCareID) then
		return
	end

	local ObjDistance = tonumber(arg2)
	if( (arg1 == "distance" and ObjDistance>MAX_OBJ_DISTANCE) or arg1=="destroy") then
		PetEquipSuitUp_Close()
	end
end

--*************************************************
--����UPDATE_PETEQUIP_UP�߼� �������
--*************************************************
function PetEquipSuitUp_Update( pos_packet )
	if (pos_packet == nil) then
		return
	end

	local BagPos = tonumber(pos_packet)
	--�Ƿ����....
	if (PlayerPackage:IsLock(BagPos) == 1) then
		PushDebugMessage("#{Item_Locked}")
		return
	end

	local ItemID = PlayerPackage:GetItemTableIndex(BagPos)
	--ͨ�����ȡ������ƷID����Ҫ��Ǯ��Ŀ���������ʡ���������
	local nProductID,nPercent,nNeedMoney,nMaterialKind, strImpact= PetEquipSuitUp:GetPetEquipUpProductInfo(ItemID, 0) --debug

	if (-1 == nProductID) then
		PushDebugMessage("#{ZSZBSJ_090706_03}")
		return
	end

	--����������Ʒ���Action....
	local theAction = EnumAction(BagPos, "packageitem");
	if (theAction:GetID() == 0) then
		return
	end

	if (g_PetEquipItemPos ~= -1) then
		LifeAbility:Lock_Packet_Item(g_PetEquipItemPos, 0)
	end
	LifeAbility:Lock_Packet_Item(BagPos, 1)
	PetEquipSuitUp_GemItem:SetActionItem(theAction:GetID())

	g_PetEquipItemPos=BagPos
	--����������Ʒ��Action
	g_PetEquipItemID	= ItemID
	g_PetEquipProductID = nProductID
	g_ProductNeedMoney  = nNeedMoney

	PetEquipSuitUp_Explain4:SetText("#{ZSZBSJ_XML_04}")
	local ProductAction = PetEquipSuitUp:UpdateProductAction(nProductID,BagPos) --debug
	if (ProductAction and ProductAction:GetID() ~= 0) then
		PetEquipSuitUp_ProductItem:SetActionItem(ProductAction:GetID());
		PetEquipSuitUp_ProductItem:Show()
	else
		PetEquipSuitUp_ProductItem:SetActionItem(-1);
	end

	--������Ҫ��Ǯ��Ŀ
	PetEquipSuitUp_Demand_Jiaozi:SetProperty("MoneyNumber", tostring(g_ProductNeedMoney))
	PetEquipSuitUp_Explain3_Text2:SetText("#G"..tostring(nPercent).."%")

	--����Table�е�ID��ȡ����Ҫ�Ĳ���
	local nMaterial = {
					  [1] = {id=0,num=0,name="",},
					  [2] = {id=0,num=0,name="",},
					  [3] = {id=0,num=0,name="",},
					  }
	local szTipInfo = "#{ZSZBSJ_XML_06}"
	if (nMaterialKind > 0) then
		for i=1,nMaterialKind do
			nMaterial[i].id,nMaterial[i].num,nMaterial[i].name = PetEquipSuitUp:GetPetEquipUpMaterial(g_PetEquipItemID, 0, i) --debug
			if (-1 ~= nMaterial[i].id) then
				szTipInfo = szTipInfo..nMaterial[i].name.."#G"..nMaterial[i].num.."c�i;"
			end
		end

		if (strImpact ~= nil) then
			szTipInfo = szTipInfo.."\n"..strImpact
		end

		PetEquipSuitUp_Explain2_Info:SetText(szTipInfo)
	end

	PetEquipSuitUp_Accept:Enable()
end


--*************************************************
--����PACKAGE_ITEM_CHANGED�߼�
--*************************************************
function PetEquipSuitUp_PackageItemChange(arg0)
	if (this:IsVisible() == 0) then
		return
	end

	local NumArg0 = tonumber(arg0)
	if (arg0~= nil and -1 == NumArg0) then
		return
	end


	if (g_PetEquipItemPos == NumArg0) then
		PetEquipSuitUp_Resume_Equip(1)
	end
end

--*************************************************
--��ʼ����NPC������ȷ����ҵ�ǰ������NPC�������NPC
--̫Զ�ͻ�رմ����ڿ�ʼ����֮ǰ��Ҫ��ȷ���������
--�ǲ����Ѿ��С����ġ���NPC������еĻ�����ȡ���Ѿ�
--�еġ����ġ�
--*************************************************
function PetEquipSuitUp_BeginCareObject()
	this:CareObject(g_ObjCareID, 1, "PetEquipSuitUp");
end


--*************************************************
--ֹͣ��ĳNPC�Ĺ���
--*************************************************
function PetEquipSuitUp_StopCareObject()
	this:CareObject(g_ObjCareID, 0, "PetEquipSuitUp");
end

--*************************************************
--�رս���
--*************************************************
function PetEquipSuitUp_Close()
	this:Hide()
	PetEquipSuitUp_StopCareObject()
	PetEquipSuitUp_Clear()
end


function PetEquipSuitUp_OnHide()
	PetEquipSuitUp_Close()
end


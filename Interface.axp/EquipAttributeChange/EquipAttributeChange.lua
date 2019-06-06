
local g_ContralList = {}
local g_IsWashed = 0
local g_EquipAttributeChange_Item = -1
local g_EquipAttributeChange_Confirm = -1	--��״̬����ȷ��
local g_binditem = {38000953,38000956}
local g_unbinditem = {38000954,38000957}
local g_yuanbaoitem = {38000955,38000958}

local g_EquipAttributeChange_NPCID = -1
local g_EquipAttributeChange_objCared = -1
local g_EquipAttributeChange_OBJDISTANCE =3.0;

local g_EquipAttributeChange_Frame_UnifiedPosition = nil

function EquipAttributeChange_PreLoad()

	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("EQUIP_CHANGE_ATTR");
	this:RegisterEvent("EQUIPATTR_CHANGEEQUIP_CONFIRM_OK")
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("EQUIPATTR_BIND_CONFIRM_OK")
	this:RegisterEvent("EUQIPATTR_UPDATE_RECOIN")
	this:RegisterEvent("OBJECT_CARED_EVENT")
	--����г���
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	-- ��Ϸ���ڳߴ緢���˱仯
	this:RegisterEvent("ADJEST_UI_POS")
	-- ��Ϸ�ֱ��ʷ����˱仯
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

function EquipAttributeChange_OnLoad()
	g_ContralList = {
								ActionButton = EquipAttributeChange_Object,
								TextBefore = EquipAttributeChange_Bk1_Text2,
								TextAfter = EquipAttributeChange_Bk2_Text2,
								recoinButton = EquipAttributeChange_OK,
								obj2 = EquipAttributeChange_Object2,
							}
	g_EquipAttributeChange_Frame_UnifiedPosition = EquipAttributeChange_Frame:GetProperty("UnifiedPosition");

end

function EquipAttributeChange_OnEvent(event)
	if (event == "UI_COMMAND") and  tonumber(arg0) == 20140618 then
		g_EquipAttributeChange_NPCID = Get_XParam_INT(0);
		g_EquipAttributeChange_objCared = DataPool:GetNPCIDByServerID(g_EquipAttributeChange_NPCID);
		EquipAttributeChange_BeginCareObject(g_EquipAttributeChange_objCared)
		EquipAttributeChange_Clear(1)
		this:Show()
	elseif (event == "UI_COMMAND" ) and tonumber(arg0) == 201406181 then
		EquipAttributeChange_Clear(0)
		EquipAttributeChange_Update(g_EquipAttributeChange_Item)	
	elseif(event == "EQUIP_CHANGE_ATTR") then
		if arg0 ~= nil then
			EquipAttributeChange_Update(arg0)
		end
	elseif (event == "EQUIPATTR_CHANGEEQUIP_CONFIRM_OK") then
		if tonumber(arg1) == 1 then
			EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
			EquipAttributeChange_Update(arg0) --�ٷ����µ�~
		elseif tonumber(arg1) == 0 then
			EquipAttributeChange_Clear(1)
			this:Hide()
		elseif tonumber(arg1) == 2 then
			EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
		end
	elseif (event == "RESUME_ENCHASE_GEM") then
		EquipAttributeChange_TryClear()
	elseif (event == "EQUIPATTR_BIND_CONFIRM_OK") then
		g_EquipAttributeChange_Confirm = 1
	elseif (event == "EUQIPATTR_UPDATE_RECOIN") then
		--��������������
		EquipAttributeChange_UpDateRecoin()
	elseif (event == "OBJECT_CARED_EVENT") then
		if(tonumber(arg0) ~= g_EquipAttributeChange_objCared) then
			return;
		end
		
		if(arg1 == "distance" and tonumber(arg2) > g_EquipAttributeChange_OBJDISTANCE or arg1=="destroy" ) then
			EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
			this:Hide()
		end	
	elseif (event == "PLAYER_LEAVE_WORLD") then
			EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
			this:Hide()
	-- ��Ϸ���ڳߴ緢���˱仯
	elseif (event == "ADJEST_UI_POS" ) then
		EquipAttributeChange_ResetPos()
	-- ��Ϸ�ֱ��ʷ����˱仯
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipAttributeChange_ResetPos()
	end
end


function EquipAttributeChange_UpDateRecoin()
	local num =  DataPool : Lua_GetRecoinNum();
	
	local str = ""
	for i = 0, num-1 do
		local tempstr = DataPool :Lua_GetRecoinEnumAttr(i)
		str = str..tempstr
	end	
	
	g_ContralList.TextAfter:SetText(str)
	EquipAttributeChange_Bk1_Btn:Enable()
	EquipAttributeChange_Bk2_Btn:Enable()
end


function EquipAttributeChange_OnHiden()
	EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
end


function EquipAttributeChange_Close()
	--�ر�ǰҲҪ��������ȷ��
	if g_EquipAttributeChange_Item ~= -1 and  g_IsWashed == 1 then
		EquipEducation_SendChageEquipConfirm(g_EquipAttributeChange_Item,0)
		return
	end
	EquipAttributeChange_Clear(1)
	this:Hide()
end

function EquipAttributeChange_Clear(cleanaction)

	g_IsWashed = 0
	g_EquipAttributeChange_Confirm = -1
	g_ContralList.TextBefore:SetText("")
	g_ContralList.TextAfter:SetText("")
	EquipAttributeChange_CaiLiaoText:SetText("")
	g_ContralList.recoinButton:Disable()
	g_ContralList.obj2:SetProperty("Image","")
	EquipAttributeChange_Bk1_Btn:Disable()
	EquipAttributeChange_Bk2_Btn:Disable()
	if cleanaction == 1 then
		if g_EquipAttributeChange_Item ~= -1 then
			g_ContralList.ActionButton:SetActionItem(-1)
			LifeAbility:Lock_Packet_Item(g_EquipAttributeChange_Item, 0)
			g_EquipAttributeChange_Item = -1
		end
	end
end

function EquipAttributeChange_Update(pageIndex)
	local index = tonumber(pageIndex)
	
	local theAction = EnumAction(index, "packageitem")
	
	if theAction:GetID() ~= 0 then
	
		-- ����ո����Ѿ��ж�Ӧ��Ʒ��,��Ҫ��һ������ȷ�ϡ���
		if g_EquipAttributeChange_Item ~= -1 and index ~= g_EquipAttributeChange_Item and  g_IsWashed == 1  then
			EquipEducation_SendChageEquipConfirm(index,1)			
			return
		end	
		
		EquipAttributeChange_Clear(1)
		
		g_ContralList.ActionButton:SetActionItem(theAction:GetID())
		LifeAbility:Lock_Packet_Item(index, 1)
		g_EquipAttributeChange_Item = index
		
		local icon =  tostring(LifeAbility : Get_Item_Icon_Name(index))
		g_ContralList.obj2:SetProperty("Image",icon)
		
		local num = theAction:GetEquipAttrCount()
		local str = ""
		for i = 0, num-1 do
			local tempstr = theAction:EnumEquipExtAttr(i)
			str = str..tempstr
		end
		g_ContralList.TextBefore:SetText(str)
		g_ContralList.recoinButton:Enable()
		
		local nQual = theAction:EquipCanRecoin() 
		local index = 1
		if nQual ~= 7 and nQual ~= 8 then
			return
		end
		if nQual == 7 then
			index = 1
		elseif nQual == 8 then
			index = 2
		end	
		
		local itemname = PlayerPackage:GetItemName(tonumber(g_binditem[index]))
		local needinfo = ScriptGlobal_Format("#{ZBCZ_140618_41}", 1,itemname)
		EquipAttributeChange_CaiLiaoText:SetText(needinfo)
		
		
	end
end

--����ԭ������
function EquipAttributeChange_Bk1_Btn_Clicked()
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("DoRefreshEquipAttr");
		Set_XSCRIPT_ScriptID(890990);
		Set_XSCRIPT_Parameter(0,g_EquipAttributeChange_Item);
		Set_XSCRIPT_Parameter(1,1)
		Set_XSCRIPT_ParamCount(2);
	Send_XSCRIPT();		
	--���recoin��ʾ
	EquipAttributeChange_Clear(0)
	EquipAttributeChange_Update(g_EquipAttributeChange_Item)
end

--����������
function EquipAttributeChange_Bk2_Btn_Clicked()
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("DoRefreshEquipAttr");
		Set_XSCRIPT_ScriptID(890990);
		Set_XSCRIPT_Parameter(0,g_EquipAttributeChange_Item);
		Set_XSCRIPT_Parameter(1,0)
		Set_XSCRIPT_ParamCount(2);
	Send_XSCRIPT();		
end

--�����滻װ������ȷ��
function EquipEducation_SendChageEquipConfirm(nIndex,keepopen)
	PushEvent("EQUIPATTR_CHANGEEQUIP_CONFIRM",tostring(nIndex),tostring(keepopen))
end

function EquipAttributeChange_TryClear()
	if g_EquipAttributeChange_Item ~= -1 and g_IsWashed == 1  then
		EquipEducation_SendChageEquipConfirm(g_EquipAttributeChange_Item,2)			
		return
	end	
	
	EquipAttributeChange_Clear(1) --�Ȱ�ԭ���������
	
end

--����
function EquipAttributeChange_Buttons_Clicked()
	
	-- ��ȫʱ��
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZBCZ_140618_22}")
		return
	end	
	
	--�жϸ߼��ܱ�
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then		
		return
	end	
	
	if g_EquipAttributeChange_Item < 0 then
		PushDebugMessage("#{ZBCZ_140618_27}")
		return	
	end
	
	local theAction = EnumAction(g_EquipAttributeChange_Item, "packageitem")
	
	local nQual = theAction:EquipCanRecoin() 
	local index = 1
	if nQual ~= 7 and nQual ~= 8 then
		return
	end
	if nQual == 7 then
		index = 1
	elseif nQual == 8 then
		index = 2
	end
	
	local total = PlayerPackage:CountAvailableItemByIDTable(g_binditem[index]) + PlayerPackage:CountAvailableItemByIDTable(g_unbinditem[index]) +
			PlayerPackage:CountAvailableItemByIDTable(tonumber(g_yuanbaoitem[index])) 
	if nQual > 0 then
		if total <= 0 then
			local itemname = PlayerPackage:GetItemName(tonumber(g_binditem[index]))
			local strInfo = ScriptGlobal_Format("#{ZBCZ_140618_31}", itemname,itemname)
			PushDebugMessage(strInfo)
			return
		end
		--�󶨵��߹�
		if PlayerPackage:CountAvailableItemByIDTable(g_binditem[index]) > 0 then
			if(PlayerPackage:GetItemBindStatusByIndex(g_EquipAttributeChange_Item) == 1 ) then
			--�󶨵��ߣ���װ��
			--ֱ�ӷ���Server
				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name("OnGenNewEquipAttr");
					Set_XSCRIPT_ScriptID(890990);
					Set_XSCRIPT_Parameter(0,g_EquipAttributeChange_Item);
					Set_XSCRIPT_ParamCount(1);
				Send_XSCRIPT();				
			elseif g_EquipAttributeChange_Confirm == 1 then
			--��������ȷ�Ϲ���
				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name("OnGenNewEquipAttr");
					Set_XSCRIPT_ScriptID(890990);
					Set_XSCRIPT_Parameter(0,g_EquipAttributeChange_Item);
					Set_XSCRIPT_ParamCount(1);
				Send_XSCRIPT();					
			--ֱ�ӷ���Server
			else
				--ȥ������ȷ�϶���
				PushEvent("EQUIPATTR_BIND_CONFIRM",tostring(g_binditem[index]));
				return
			end
		else
		--�÷ǰ󶨵���

			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("OnGenNewEquipAttr");
				Set_XSCRIPT_ScriptID(890990);
				Set_XSCRIPT_Parameter(0,g_EquipAttributeChange_Item);
				Set_XSCRIPT_ParamCount(1);
			Send_XSCRIPT();				
		
		end
		
	end
	

	
	
	g_ContralList.recoinButton:Disable()
	g_IsWashed = 1
end

function EquipAttributeChange_BeginCareObject(objID)
	g_Object = objID;
	this:CareObject(g_Object, 1, "EquipAttributeChange");
end

function EquipAttributeChange_ResetPos()
	EquipAttributeChange_Frame:SetProperty("UnifiedPosition", g_EquipAttributeChange_Frame_UnifiedPosition)
end
local objCared = -1;			--����NPC���
local GEMSOURCE_BUTTONS = -1 	--�ؼ���Դ��ʯ��
local GEMDEST_BUTTONS = -1 		--�ؼ���Ŀ�ı�ʯ��
local EQUIPITEM_SOURCE = -1		--�շ�Դ��ʯ��
local EQUIPITEM_DEST = -1		--�շ�Ŀ�ı�ʯ��
local CostYuanBao_Total = ""	--ת����Ҫ���ĵ�Ԫ��
local bConfirm = -1				--����ȷ�Ͽ򣬵���������
local Gem_Source_ItemID = -1	--Դ��ʯID
local Gem_Source_ItemType = -1	--Դ��ʯType
local Gem_Source_ItemLevel = -1	--Դ��ʯLevel
local Gem_Source_Bind = 0		--Դ��ʯBind���
local Gem_Select_ItemID = -1	--Ŀ�ı�ʯID
local Gem_Source_Name = ""		--Դ��ʯName
local Gem_Dest_Name = ""		--Ŀ�ı�ʯName
local MAX_OBJ_DISTANCE = 3.0	--�Ի���رվ���
local Cost_YuanBao = {			--��ͬ���ͱ�ʯ������Ԫ�����
[5] = {normal=4200, 	special=4200*3},
[6] = {normal=19200, 	special=19200*3},
[7] = {normal=96000, 	special=96000*3},
[8] = {normal=384000,	special=384000*3},
[9] = {normal=1536000, 	special=1536000*3},
}

function GemChange_PreLoad()
	this:RegisterEvent("UI_COMMAND"); 				 --���ã��򿪱�ʯת������
	this:RegisterEvent("OBJECT_CARED_EVENT"); 		 --���ã��رձ�ʯת������
	this:RegisterEvent("UPDATE_BAOSHI_CHANGE");		 --���ã���ʯת��Դ��ʯˢ��
	this:RegisterEvent("UPDATE_YUANBAO");			 --���ã���ʯת������Ԫ��ˢ��
	this:RegisterEvent("RESUME_ENCHASE_GEM");		 --���ã�Դ��ʯ�ϻر�����
	this:RegisterEvent("SHOW_SELECT_BAOSHI");		 --���ã���ʯת��Ŀ�ı�ʯˢ��
	this:RegisterEvent("BAOSHI_CHANGE_CONFIRM");	 --���ã���ʯת���Ķ���ȷ�ϣ��򿪽���
	this:RegisterEvent("BAOSHI_CHANGE_CONFIRM_TRUE");--���ã���ʯת���Ķ���ȷ�ϣ��ٴ�ȷ�ϣ����ٴ򿪽���
	this:RegisterEvent("BAOSHI_CHANGE_CONFIRM_CANCEL"); --//By YPL,2013/3/6	
end

function GemChange_OnLoad()
	GEMSOURCE_BUTTONS = GemChange_InputGemIcon;
	GEMDEST_BUTTONS = GemChange_OutputGemIcon;
	EQUIPITEM_SOURCE = -1;
	EQUIPITEM_DEST = -1;
	GemChange_Select:Disable(); --"ѡ��ʯ"��ť״̬�� �û�
	CostYuanBao_Total = "";
	GemChange_WantNum:SetText(""..CostYuanBao_Total);
	GemChange_HaveNum:SetText(""..tostring(Player:GetData("YUANBAO")));
	GemChange_OK:Disable();	--"ȷ��"��ť״̬�� �û�
end

--���ʱ����������϶����Ҽ����������ʯ������ʯת������Ŀ���ʱ
function GemChange_CheckBaoshi(Item_index)

	local pos_packet = tonumber(Item_index)
	
	--����1��������Ʒ�Ǳ�ʯ��
	local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
	local Gem_Type = PlayerPackage : GetGemChangeRule(pos_packet)
	if (Item_Class ~= 5) or (Item_Class == 5 and Gem_Type == 6) then
		PushDebugMessage("#{BSZH_130220_14}")
		return 0
	end	

	--����2���������ͨ����ʯ��
	if Gem_Type == 4 then
		PushDebugMessage("#{BSZH_130220_15}")
		return 0
	end

	--����3���������ڤ��ʯ��
	if Gem_Type == 5 then
		PushDebugMessage("#{BSZH_130220_16}")
		return 0
	end

	--����4��������Ǳ�ʯ�ȼ�������5����
	local GemLevel = PlayerPackage : GetItemSubTableIndex(pos_packet,1)
	if GemLevel < 5 then
		PushDebugMessage("#{BSZH_130220_14}")
		return 0
	end
	
	if GemLevel > 8 then
		--PushDebugMessage("#{BSZH_130220_28}")
		return 0
	end
	 
	--����5��������Ǳ�ʯ�Ѽ�������
	if PlayerPackage:IsLock(pos_packet) == 1 then
		PushDebugMessage("#{BSZH_130220_17}")
		return 0	
	end

	--����6����ʯ�����б�ʯ��
	if PlayerPackage:IsGem(pos_packet) ~= 1 then
		return 0	
	end		
	
	return 1;
end

function GemChange_Update(UI_index, Item_index, param2, param3)
	
	local i_index = tonumber(Item_index)
	local ui_index = tonumber(UI_index)
	if ui_index < 0 or ui_index > 1 then
		return
	end
	
	--���ж���Ʒ�Ƿ���Ϸ�����������ſɽ��к����߼� ���������������������������������뱣֤��һ����������и����쳣���⣡����������������������������
	if GemChange_CheckBaoshi(i_index) == 0 then
		return
	end


	--���ڸ��ʯ
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( i_index )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_63}")
		return
	end

	local theAction = EnumAction(i_index, "packageitem");

	GemChange_HaveNum:SetText(""..tostring(Player:GetData("YUANBAO")));
	
	Gem_Source_ItemID = theAction:GetDefineID();
	Gem_Source_ItemType = PlayerPackage : GetGemChangeRule(i_index)
	Gem_Source_ItemLevel = PlayerPackage : GetItemSubTableIndex(i_index,1)
	Gem_Source_Name = theAction:GetName();
	Gem_Source_Bind = PlayerPackage:GetItemBindStatusByIndex(i_index);

	if theAction:GetID() ~= 0 then
	
		--���ж���Ʒ�Ƿ���Ϸ�����������ſɽ��к����߼� ���������������������������������뱣֤��һ����������и����쳣���⣡����������������������������
		if GemChange_CheckBaoshi(i_index) == 0 then
			return 			
		end
	
		-- --��ʯ�ƶ�������->��
		-- --�ƶ���ʽ���Ҽ����
		-- if ui_index == 0 then
			-- --���ǰ������״̬���ޱ�ʯ
			-- if EQUIPITEM_SOURCE == -1 then
				-- GEMSOURCE_BUTTONS:SetActionItem(theAction:GetID());
				-- LifeAbility : Lock_Packet_Item(i_index,1);
				-- EQUIPITEM_SOURCE = i_index;
				-- GemChange_Select:Enable(); --"ѡ��ʯ"��ť״̬���ɵ��
				-- GemChange_Flush_DestGemList(); --ˢ��ƥ�䱦ʯ�б�
			-- --���ǰ������״̬���б�ʯ
			-- else
				-- GemChange_Clear();
				-- GEMSOURCE_BUTTONS:SetActionItem(theAction:GetID());
				-- LifeAbility : Lock_Packet_Item(i_index,1);
				-- EQUIPITEM_SOURCE = i_index;
				-- GemChange_Select:Enable(); --"ѡ��ʯ"��ť״̬���ɵ��
				-- GemChange_Flush_DestGemList(); --ˢ��ƥ�䱦ʯ�б�	
			-- end
		-- --��ʯ�ƶ�������->��
		-- --�ƶ���ʽ������϶�
		-- elseif ui_index == 1 then 
				-- GemChange_Clear();
				-- GEMSOURCE_BUTTONS:SetActionItem(theAction:GetID());
				-- LifeAbility : Lock_Packet_Item(i_index,1);
				-- EQUIPITEM_SOURCE = i_index;	
				-- GemChange_Select:Enable(); --"ѡ��ʯ"��ť״̬���ɵ��
				-- GemChange_Flush_DestGemList(); --ˢ��ƥ�䱦ʯ�б�
		-- end
		
		-- GemChange_Need_YuanBao_Flush(param2, param3);
		
		if ui_index == 0 or ui_index == 1 then
				GemChange_Clear();
				GEMSOURCE_BUTTONS:SetActionItem(theAction:GetID());
				LifeAbility : Lock_Packet_Item(i_index,1);
				EQUIPITEM_SOURCE = i_index;	
				GemChange_Select:Enable(); --"ѡ��ʯ"��ť״̬���ɵ��
				GemChange_Flush_DestGemList(); --ˢ��ƥ�䱦ʯ�б�
				GemChange_Need_YuanBao_Flush(param2, param3);
		end		
	end
end

function GemChange_OnEvent(event)

	if (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if(tonumber(arg0) ~= objCared) then
			return;
		end
		if((arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE) or arg1=="destroy") then		
			--ȡ������
			GemChange_Cancel_Clicked()
		end
	elseif ( event == "UI_COMMAND" and tonumber(arg0)== 201302201 ) then
	
		if this:IsVisible() then
			GemChange_Close()
		end
		
		this:Show();
		GemChange_OnLoad();
		objCared = -1;
		local xx = Get_XParam_INT(0);
		objCared = DataPool : GetNPCIDByServerID(xx);
		if objCared == -1 then
				return;
		end
		GemChange_BeginCareObject(objCared)
		return
	elseif ( event == "UPDATE_BAOSHI_CHANGE" and this:IsVisible() ) then
		GemChange_Update(arg0, arg1, arg2, arg3);
	elseif (event == "UPDATE_YUANBAO" and this:IsVisible()) then
		GemChange_HaveNum:SetText(""..tostring(Player:GetData("YUANBAO")));
	 elseif event == "RESUME_ENCHASE_GEM" and this : IsVisible() then
		 GemChange_Clear()
		 GemChange_Select:Disable(); --"ѡ��ʯ"��ť״̬���ɵ��
		 CloseWindow("GemList", true)
	elseif (event == "SHOW_SELECT_BAOSHI" and this:IsVisible()) then --Ŀ�ı�ʯ����Ŀ�Ŀ���
		bConfirm = -1
		local nProductID = tonumber(arg0)
		local ProductAction = DoubleGem:UpdateProductAction( nProductID)
		if ProductAction and ProductAction:GetID() ~= 0 then
			GEMDEST_BUTTONS:SetActionItem(ProductAction:GetID());
			Gem_Select_ItemID=nProductID
			EQUIPITEM_DEST = nProductID
			Gem_Dest_Name = ProductAction:GetName()
			GemChange_OK:Enable();
		else
			GEMDEST_BUTTONS:SetActionItem(-1);
			Gem_Select_ItemID=-1
		end
	elseif (event == "BAOSHI_CHANGE_CONFIRM_TRUE" and this:IsVisible()) then --���ã���ʯת���Ķ���ȷ�ϣ��ٴ�ȷ�ϣ����ٴ򿪽���
		GemChange_Buttons_Clicked();
	elseif (event == "BAOSHI_CHANGE_CONFIRM_CANCEL" and this:IsVisible()) then
		bConfirm = -1		
	end

end

function GemChange_Clear()
	if (EQUIPITEM_SOURCE ~= -1) then
		GEMSOURCE_BUTTONS:SetActionItem(-1);
		LifeAbility : Lock_Packet_Item(EQUIPITEM_SOURCE,0);
		EQUIPITEM_SOURCE = -1
	end
	
	if (EQUIPITEM_DEST ~= -1) then
		GEMDEST_BUTTONS:SetActionItem(-1);
		EQUIPITEM_DEST = -1
	end	
	
	GemChange_Select:Disable();
	CostYuanBao_Total = ""
	GemChange_WantNum:SetText(""..CostYuanBao_Total);	
	GemChange_OK:Disable();
	bConfirm = -1
	Gem_Source_Bind = 0
end

function GemChange_Close()
	GemChange_Clear()
	this:Hide()
	CloseWindow("GemList", true)
end

function GemChange_Cancel_Clicked()
	GemChange_Close();
	return;
end

function GemChange_Buttons_Clicked()

	-- �ж��Ƿ�Ϊ��ȫʱ��
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{OR_PILFER_LOCK_FLAG}")
		return
	end
	
	--�жϵ绰�ܱ��Ͷ������뱣��
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then	
		return
	end
	
	if GemChange_CheckBaoshi(EQUIPITEM_SOURCE) ~=1 then
		return
	end
	
	--����7��Ŀ�걦ʯ�Ƿ����ת������
	if GetGemChangRule(Gem_Source_ItemID) == -1 or GetGemChangRule(Gem_Select_ItemID) == -1 then
		return
	end
	if GetGemChangRule(Gem_Source_ItemID) ~= GetGemChangRule(Gem_Select_ItemID) then
		PushDebugMessage("#{BSZH_130220_19}")
		return
	end
	
	--����8�����Ԫ���Ƿ��㹻
	if Player:GetData("YUANBAO") < CostYuanBao_Total then
		PushDebugMessage("#{BSZH_130220_20}")
		return
	end
	
	if bConfirm == -1 then
		PushEvent("BAOSHI_CHANGE_CONFIRM", tostring(Gem_Source_Name), tostring(Gem_Dest_Name), tonumber(CostYuanBao_Total))--����ȷ�Ͽ�
		bConfirm = 1
	elseif bConfirm == 1 then
		bConfirm = 2
	elseif bConfirm == 2 then
		--��������Client��������server��world��ȥ����ʼ��Ԫ��������ʯ
		LifeAbility : Do_Gem_Change("change", tonumber(EQUIPITEM_SOURCE), tonumber(Gem_Select_ItemID))
		GemChange_Clear();
		bConfirm = -1
		--ת��ȷ�Ϻ󣬹رձ�ʯ�б����
		CloseWindow("GemList", true);			
	end
	
end


--��ʯ�ƶ�����->����
--�ƶ���ʽ���Ҽ����
--�������壺1��Դ��ʯ�Ŀ�2��Ŀ�ı�ʯ�Ŀ�
function GemChange_Resume_Equip(nIndex)

	if nIndex ~=1 then
		return
	end
	
	if (nIndex == 1) and (EQUIPITEM_SOURCE ~= -1) then
		GEMSOURCE_BUTTONS:SetActionItem(-1);
		LifeAbility : Lock_Packet_Item(EQUIPITEM_SOURCE,0);
		EQUIPITEM_SOURCE = -1
		GemChange_Select:Disable(); --"ѡ��ʯ"��ť״̬�����ɵ��
		CloseWindow("GemList", true)

		GEMDEST_BUTTONS:SetActionItem(-1);
		LifeAbility : Lock_Packet_Item(EQUIPITEM_DEST,0);
		EQUIPITEM_DEST = -1	
		
		--Ԫ��ʯ����պ�����Ԫ�������
		CostYuanBao_Total = ""
		GemChange_WantNum:SetText(""..CostYuanBao_Total);
		
		--Ԫ��ʯ����պ󣬽���ȷ����ť���
		GemChange_OK:Disable();	
		GemChange_Clear(); ---------------------20130304			
	end
	
end

--�򿪽��棺��Դ��ʯƥ��ı�ʯ�б����ڵĽ���(GemList)
function GemChange_Open_DestGemList()
	if EQUIPITEM_SOURCE ~= -1 then
		CGemChangeDataPool:RequestDestGemList(Gem_Source_ItemID, Gem_Source_ItemType, Gem_Source_ItemLevel, Gem_Source_Bind);
		OpenWindow("GemList");
	end
end

--���򿪽��棬ֻˢ�±�ʯ�б���Դ��ʯƥ��ı�ʯ�б����ڵĽ���(GemList)
function GemChange_Flush_DestGemList()
	if EQUIPITEM_SOURCE ~= -1 then
		CGemChangeDataPool:RequestDestGemList(Gem_Source_ItemID, Gem_Source_ItemType, Gem_Source_ItemLevel, Gem_Source_Bind);
	end
end

function GemChange_BeginCareObject(objCaredId)
	this:CareObject(objCaredId, 1, "GemChange");
end

function GemChange_StopCareObject(objCaredId)
	this:CareObject(objCaredId, 0, "GemChange");
end

function GemChange_OnHidden()
	GemChange_StopCareObject(objCared)
	GemChange_Close()
	return
end

function GemChange_Help_Clicked()
	Helper:GotoHelper("*GemChange")
end

function GemChange_Need_YuanBao_Flush(param2, param3)

	local gem_level = tonumber(param2) --Դ��ʯ���ȼ�
	local gem_type  = tonumber(param3) --Դ��ʯ�����
	
	if Cost_YuanBao[gem_level] ~= nil then
		if gem_type == 3 then
			CostYuanBao_Total = Cost_YuanBao[gem_level].special
		else
			CostYuanBao_Total = Cost_YuanBao[gem_level].normal
		end
		GemChange_WantNum:SetText(""..CostYuanBao_Total);
	else
		GemChange_WantNum:SetText("");
	end
	
end
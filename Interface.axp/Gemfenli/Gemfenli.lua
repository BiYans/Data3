----***************************
----�����ͱ�ʯ�������
----***************************
local MAX_OBJ_DISTANCE = 3.0;

local g_GemItemPos = -1;
local g_GemItemID = -1;

local g_NeedMoney = 50000; --5J

local ObjCaredIDID = -1;


local g_Gemfenli_Frame_UnifiedPosition;
--�������
local g_fenlifuSTID={38000447, 38000448}--���󶨵��µ��ߣ�--�����󶨵��µ��ߣ�
local g_fenlifuID=-1
local g_fenlifuPos=-1

local g_ShowBind=0

function Gemfenli_PreLoad()

	this:RegisterEvent("UPDATE_DOUBLEGEM_FENLI");
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("PACKAGE_ITEM_CHANGED");
	this:RegisterEvent("UNIT_MONEY");
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("MONEYJZ_CHANGE")		--�����ռ� Vega
	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

function Gemfenli_OnLoad()
    g_Gemfenli_Frame_UnifiedPosition=Gemfenli_Frame:GetProperty("UnifiedPosition");
end

function Gemfenli_OnEvent(event)

	if ( event == "UI_COMMAND" and tonumber(arg0) == 201210121 ) then

			local npcObjId = tonumber(Variable:GetVariable("GemNPCObjId"));
			Variable:SetVariable("GemNPCObjId", "", 1)
			if(npcObjId == nil) then
				npcObjId = Get_XParam_INT( 0 )
			end
			
			ObjCaredID = DataPool : GetNPCIDByServerID(npcObjId);
			if ObjCaredID == -1 then
					PushDebugMessage("Error!");
					return;
			end
			ObjCaredIDID = npcObjId
			Gemfenli_BeginCareObject()
			Gemfenli_Clear()
			Gemfenli_UserMoneyChanged()
			local GemUnionPos = Variable:GetVariable("GemUnionPos");
			if(GemUnionPos ~= nil) then
			  Gemfenli_Frame:SetProperty("UnifiedPosition", GemUnionPos);
			end
			Gemfenli_FenYe5:SetCheck(1)
			this:Show();

	elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then

		if(tonumber(arg0) ~= ObjCaredID) then
			return;
		end

		--�����NPC�ľ������һ��������߱�ɾ�����Զ��ر�
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			Gemfenli_Close()
		end

	elseif ( event == "PACKAGE_ITEM_CHANGED" and this:IsVisible() ) then

		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end

		if ( g_GemItemPos == tonumber(arg0) ) then
			Gemfenli_Resume_Equip(1)
		elseif ( g_fenlifuPos == tonumber(arg0) ) then
			Gemfenli_Resume_Equip(2)
		end

	elseif( event == "UPDATE_DOUBLEGEM_FENLI") then

		if arg0 == nil or arg1 == nil then
			return
		end

		--arg0 ��UI�ĵڼ���λ��
		--arg1 �Ǳ����ĸ���
		Gemfenli_Update(tonumber(arg0),tonumber(arg1));

	elseif( event == "UNIT_MONEY" or event =="MONEYJZ_CHANGE") then

		Gemfenli_UserMoneyChanged();

	elseif ( event == "RESUME_ENCHASE_GEM" and this:IsVisible() ) then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end
		if tonumber(arg0) == 126 then
			Gemfenli_Resume_Equip(1)
		elseif tonumber(arg0) == 127 then
			Gemfenli_Resume_Equip(2)
		end
		
	elseif (event == "ADJEST_UI_POS" ) then
		Gemfenli_Frame_On_ResetPos()
		
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		Gemfenli_Frame_On_ResetPos()

	end

end

--=========================================================
--���ý���
--=========================================================
function Gemfenli_Clear()

	if(g_GemItemPos ~= -1) then
		LifeAbility : Lock_Packet_Item(g_GemItemPos,0);
	end

	Gemfenli_Object : SetActionItem(-1);
	
	g_GemItemPos = -1;
	g_GemItemID = -1;

	Gemfenli_info3:SetText("")
	if(g_fenlifuPos ~= -1) then
		LifeAbility : Lock_Packet_Item(g_fenlifuPos,0);
	end
	Gemfenli_Object2 : SetActionItem(-1);

	g_fenlifuPos = -1;
	g_fenlifuID = -1;

	Gemfenli_OK:Disable();
	g_ShowBind=0

end

--=========================================================
--���½���
--=========================================================
function Gemfenli_Update( pos_ui, pos_packet )

	local theAction = EnumAction(pos_packet, "packageitem");
	--1 �Ҽ����
	if theAction:GetID() == 0 then
		return
	end
	local itemID = PlayerPackage : GetItemTableIndex( pos_packet )
	if pos_ui == 1 then
		local bJianKangGem=0
		local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
		--��ȡ˫���Ա�ʯ��ֵ���Ϣ....
		if Item_Class==5 then
			local GemType = PlayerPackage : GetItemSubTableIndex(pos_packet,2)
			local GemIndex = PlayerPackage : GetItemSubTableIndex(pos_packet,3)--Сindex
			if GemType==21 and GemIndex>100 then
				bJianKangGem=1
			end
		end
		if itemID~=g_fenlifuSTID[1] and itemID~=g_fenlifuSTID[2] and bJianKangGem==0 then
			PushDebugMessage("#{BSZK_121012_58}")--��������̺�ĺ���Ŀ�꿹�Ա�ʯ�������̷����
			return
		end
		if bJianKangGem==1 then
			local nMainID, nAssistID, nAssistCount=DoubleGem:GetDoubleGemInfobyID(itemID)
			if nMainID<=0 or nAssistID==nil or nAssistCount==nil then
				return
			end
			g_GemItemID = GemItemID;

			--����ActionButton....
			if g_GemItemPos ~= -1 then
				LifeAbility : Lock_Packet_Item(g_GemItemPos,0);
			end
			g_GemItemPos = pos_packet;
			LifeAbility : Lock_Packet_Item(g_GemItemPos,1);
			Gemfenli_Object:SetActionItem(theAction:GetID());
			--��ʾ�ɵ���Ʒ
			local gemMainName = DoubleGem:GetGemNamebyID( nMainID )
			local gemAssisName = DoubleGem:GetGemNamebyID( nAssistID )
			local szShow=ScriptGlobal_Format( "#{BSZK_121012_35}", gemMainName, nAssistCount, gemAssisName)
			Gemfenli_info3:SetText(szShow)

			Gemfenli_LightfenliBtn()
		elseif itemID~=g_fenlifuSTID[1] or itemID~=g_fenlifuSTID[2] then
			--���̷����
			g_fenlifuID=itemID
			--����ActionButton....
			if g_fenlifuPos ~= -1 then
				LifeAbility : Lock_Packet_Item(g_fenlifuPos,0);
			end
			g_fenlifuPos = pos_packet;
			LifeAbility : Lock_Packet_Item(g_fenlifuPos,1);
			Gemfenli_Object2:SetActionItem(theAction:GetID());
			Gemfenli_LightfenliBtn()
		end
	--2 ��ק����ʯ�ؼ���
	elseif pos_ui==2 then
		local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
		--��ȡ˫���Ա�ʯ��ֵ���Ϣ....
		if Item_Class~=5 then
			PushDebugMessage("#{BSZK_121012_37}")
			return
		end
		local GemType = PlayerPackage : GetItemSubTableIndex(pos_packet,2)
		local GemIndex = PlayerPackage : GetItemSubTableIndex(pos_packet,3)--Сindex
		if GemType~=21 or GemIndex<100 then
			PushDebugMessage("#{BSZK_121012_37}")
			return
		end
		local nMainID, nAssistID, nAssistCount=DoubleGem:GetDoubleGemInfobyID(itemID)
		if nMainID<=0 or nAssistID==nil or nAssistCount==nil then
			return
		end
		g_GemItemID = GemItemID;

		--����ActionButton....
		if g_GemItemPos ~= -1 then
			LifeAbility : Lock_Packet_Item(g_GemItemPos,0);
		end
		g_GemItemPos = pos_packet;
		LifeAbility : Lock_Packet_Item(g_GemItemPos,1);
		Gemfenli_Object:SetActionItem(theAction:GetID());
		--��ʾ�ɵ���Ʒ
		local gemMainName = DoubleGem:GetGemNamebyID( nMainID )
		local gemAssisName = DoubleGem:GetGemNamebyID( nAssistID )
		local szShow=ScriptGlobal_Format( "#{BSZK_121012_35}", gemMainName, nAssistCount, gemAssisName)
		Gemfenli_info3:SetText(szShow)

		Gemfenli_LightfenliBtn()
	--3 ��ק��������ؼ���
	elseif pos_ui==3 then
		if itemID~=g_fenlifuSTID[1] and itemID~=g_fenlifuSTID[2] then
			PushDebugMessage("#{BSZK_121012_57}")
			return
		end
		--���̷����
		g_fenlifuID=itemID
		--����ActionButton....
		if g_fenlifuPos ~= -1 then
			LifeAbility : Lock_Packet_Item(g_fenlifuPos,0);
		end
		g_fenlifuPos = pos_packet;
		LifeAbility : Lock_Packet_Item(g_fenlifuPos,1);
		Gemfenli_Object2:SetActionItem(theAction:GetID());
		--����Ƿ���Ե������밴ť
		Gemfenli_LightfenliBtn()
	end

end

function Gemfenli_LightfenliBtn()
	if g_GemItemPos==-1 or g_fenlifuPos==-1 then
		return
	end
	Gemfenli_OK:Enable();
	g_ShowBind=0
end

--=========================================================
--���ActionButton
--=========================================================
function Gemfenli_Resume_Equip(index)

	if index==1 then
		if(g_GemItemPos ~= -1) then
			LifeAbility : Lock_Packet_Item(g_GemItemPos,0);
		end
		Gemfenli_Object : SetActionItem(-1);
		g_GemItemPos = -1;
		g_GemItemID = -1;
		Gemfenli_info3:SetText("")
		Gemfenli_OK:Disable();
		g_ShowBind=0
	elseif index==2 then
		if(g_fenlifuPos ~= -1) then
			LifeAbility : Lock_Packet_Item(g_fenlifuPos,0);
		end
		Gemfenli_Object2 : SetActionItem(-1);
		g_fenlifuPos = -1;
		g_fenlifuID = -1;

		Gemfenli_OK:Disable();
		g_ShowBind=0
	end

end

--=========================================================
--ȷ��
--=========================================================
function Gemfenli_OK_Clicked()

	if g_GemItemPos == -1 then
		PushDebugMessage("#{BSZK_121012_37}")
		return
	end
	if g_fenlifuPos == -1 then
		PushDebugMessage("#{BSZK_121012_57}")
		return
	end

	local GemItemID = PlayerPackage : GetItemTableIndex( g_GemItemPos )
	local nMainID, nAssistID, nAssistCount=DoubleGem:GetDoubleGemInfobyID(GemItemID)
	if nMainID<=0 or nAssistID==nil or nAssistCount==nil then
		return
	end

	--�жϵ绰�ܱ��Ͷ������뱣��2012.6.8-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then			
		return
	end
	-- ��ȫʱ��
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZYXT_120528_16}")
		return
	end

	--Ǯ��
	-- ������ϵĽ�Ǯ�Ƿ��㹻
	local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < g_NeedMoney then
		PushDebugMessage( "#{BSZK_121012_39}" )
		return
	end
	--��״̬���ж�
	local GemBind = GetItemBindStatus(g_GemItemPos)
	local fenlifuBind = GetItemBindStatus(g_fenlifuPos)
	if g_ShowBind==0 and GemBind==0 and fenlifuBind==1 then
		local szShow="#{BSZK_121012_60}"
		 PushEvent( "BIND_DOUBLEGEM_ZHUOKE", szShow )
		g_ShowBind = 1;
		return
	end
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnDoubleGemfenli");
		Set_XSCRIPT_ScriptID(290205);
		Set_XSCRIPT_Parameter(0,g_GemItemPos);
		Set_XSCRIPT_Parameter(1,g_fenlifuPos);
		Set_XSCRIPT_ParamCount(2);
	Send_XSCRIPT();

end

--=========================================================
--�ر�
--=========================================================
function Gemfenli_Close_Click()
	Gemfenli_StopCareObject()
	Gemfenli_Clear();
	this:Hide();
end

function Gemfenli_OnHiden()
	Gemfenli_StopCareObject()
	Gemfenli_Clear();
	this:Hide();
end

--=========================================================
--��ʼ����NPC��
--�ڿ�ʼ����֮ǰ��Ҫ��ȷ����������ǲ����Ѿ��С����ġ���NPC��
--����еĻ�����ȡ���Ѿ��еġ����ġ�
--=========================================================
function Gemfenli_BeginCareObject()
	this:CareObject(ObjCaredID, 1, "Gemfenli");
end

--=========================================================
--ֹͣ��ĳNPC�Ĺ���
--=========================================================
function Gemfenli_StopCareObject()
	this:CareObject(ObjCaredID, 0, "Gemfenli");
end

--=========================================================
--��ҽ�Ǯ�仯
--=========================================================
function Gemfenli_UserMoneyChanged()
	--��������Ǯ��....
	Gemfenli_DemandMoney : SetProperty("MoneyNumber", tostring(g_NeedMoney));
	Gemfenli_SelfMoney: SetProperty("MoneyNumber", Player:GetData("MONEY"))
	Gemfenli_SelfJiaozi: SetProperty("MoneyNumber", Player:GetData("MONEY_JZ"))
end

function Gemfenli_Frame_On_ResetPos()
  Gemfenli_Frame:SetProperty("UnifiedPosition", g_Gemfenli_Frame_UnifiedPosition);
end

--TAB�����л�
function Gemfenli_ChangeTabIndex( nIndex )
	local nUI = 0
	if 1 == nIndex then
		nUI = 23
	elseif 2 == nIndex then
		nUI = 112236
	elseif 3 == nIndex then
		nUI = 112237
	elseif 4 == nIndex then
		nUI = 201210120
	elseif 5 == nIndex then
		return 0
	elseif 6 == nIndex then
		nUI = 201408140
	end
	if nUI ~= 0 then
		Variable:SetVariable("GemUnionPos", Gemfenli_Frame:GetProperty("UnifiedPosition"), 1)
		Variable:SetVariable("GemNPCObjId", tostring(ObjCaredIDID), 1)
		PushEvent("UI_COMMAND", nUI)
		Gemfenli_OnHiden()
	end
end


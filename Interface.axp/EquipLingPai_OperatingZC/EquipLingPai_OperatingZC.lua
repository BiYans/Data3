local m_EquipBagIndex = -1
local m_CurSel_Rs = -1
local m_Rs_Idx = {}

local g_ObjCared = -1

local g_RS_UnActived_Image  = "set:CommonFrame25 image:EquipLingPai_Feng"    --- δ���

local g_MainFram_UnifiedPosition

local g_UnActived_tip = {"" , "#{BHZB_140521_169}" , "#{BHZB_140521_170}" , "#{BHZB_140521_171}"}

local g_ZC_NeedMoney = 100000

--�ؼ�����
local m_MainFram
local m_ActionButton_Equip
local m_ActionButton_Rs = {}
local m_Text_RsLevel = {}
local m_Image_NoMove = {}
local m_Button_OK
local m_CheckButton_Page = {}

local m_StaticText_NeedMoney
local m_StaticText_HaveJZ
local m_StaticText_HaveMoney

function EquipLingPai_OperatingZC_PreLoad( )

	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("RL_OPZC_PUTIN_EQUIP")
	this:RegisterEvent("RL_OPZC_PACKET_RCLICK")
	this:RegisterEvent("RL_OPZC_REMOVE_EQUIP")
	this:RegisterEvent("UNIT_MONEY")
	this:RegisterEvent("MONEYJZ_CHANGE")
	this:RegisterEvent("OPEN_RLOPPAGE")
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")

	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("SCENE_TRANSED");
	this:RegisterEvent("ON_SCENE_TRANSING");
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	
end

function EquipLingPai_OperatingZC_OnLoad( )

	if SystemSetup:IsClassic() == 0 then	--���ͻ�����Ψ���棬����������ͼƬ�ز�ΪΨ����
		g_RS_UnActived_Image  = "set:WM_MainFrame09 image:EquipLingPai_Feng"    --- δ���
	end
	
	m_MainFram = EquipLingPai_OperatingZC_Frame
	m_ActionButton_Equip = EquipLingPai_OperatingZC_InputIcon
	m_Button_OK = EquipLingPai_OperatingZC_OK
	
	m_ActionButton_Rs[1] = EquipLingPai_OperatingZC_FirstGem
	m_ActionButton_Rs[2] = EquipLingPai_OperatingZC_SecondGem
	m_ActionButton_Rs[3] = EquipLingPai_OperatingZC_ThirdGem
	m_ActionButton_Rs[4] = EquipLingPai_OperatingZC_FourthGem
	
	m_Text_RsLevel[1] = EquipLingPai_OperatingZC_FirstGrade
	m_Text_RsLevel[2] = EquipLingPai_OperatingZC_SecondGrade
	m_Text_RsLevel[3] = EquipLingPai_OperatingZC_ThirdGrade
	m_Text_RsLevel[4] = EquipLingPai_OperatingZC_FourthGrade
	
	m_Image_NoMove[1] = EquipLingPai_OperatingZC_FirstTuCeng
	m_Image_NoMove[2] = EquipLingPai_OperatingZC_SecondTuCeng
	m_Image_NoMove[3] = EquipLingPai_OperatingZC_ThirdTuCeng
	m_Image_NoMove[4] = EquipLingPai_OperatingZC_FourthTuCeng
	
	m_CheckButton_Page[1] = EquipLingPai_OperatingZC_Page1
	m_CheckButton_Page[2] = EquipLingPai_OperatingZC_Page2
	m_CheckButton_Page[3] = EquipLingPai_OperatingZC_Page3
	
	m_StaticText_NeedMoney =  EquipLingPai_OperatingZCWantNum
	m_StaticText_HaveJZ =  EquipLingPai_OperatingZCHaveNum
	m_StaticText_HaveMoney =  EquipLingPai_OperatingZC_HaveGoldNum

	g_MainFram_UnifiedPosition = m_MainFram:GetProperty( "UnifiedPosition" )

end

function EquipLingPai_OperatingZC_OnEvent( event )

	if event == "OPEN_RLOPPAGE" and  tonumber( arg0 ) == 3 then

		local nPos = Variable:GetVariable("RL_OP_Pos");
		if(nPos ~= nil) then
			m_MainFram:SetProperty("UnifiedPosition", nPos);
		end
		
		EquipLingPai_OperatingZC_Init()
		this:Show()
		g_ObjCared = tonumber( arg1 )
		if g_ObjCared == -1 then
			return
		end
		this:CareObject( g_ObjCared, 1)
		return
	
	end

	if (event == "RL_OPZC_PUTIN_EQUIP"  and this:IsVisible()) then
		if arg0 ~= nil then
			EquipLingPai_OperatingZC_OnItemDragedDropFromBag( tonumber(arg0)  )
		end
		return
	end
	
	if (event == "RL_OPZC_PACKET_RCLICK"  and this:IsVisible()) then
		if arg0 ~= nil  then
			EquipLingPai_OperatingZC_OnBagItemRClicked( tonumber(arg0)  )
		end
		return
	end 
	
	if (event == "RL_OPZC_REMOVE_EQUIP"  and this:IsVisible()) then
		EquipLingPai_OperatingZC_OnItemDragedDropAway()
		return
	end 

	if event == "PLAYER_LEAVE_WORLD"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingZC_CleanUp()
			this:Hide()
		end
		return
	end
	
	if event == "SCENE_TRANSED"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingZC_CleanUp()
			this:Hide()
		end
		return
	end
	
	if event == "ON_SCENE_TRANSING"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingZC_CleanUp()
			this:Hide()
		end
		return
	end
	
	if (event == "ADJEST_UI_POS" ) then
		EquipLingPai_OperatingZC_On_ResetPos()
		return
	end
	
	if (event == "VIEW_RESOLUTION_CHANGED") then
		EquipLingPai_OperatingZC_On_ResetPos()
		return
	end
	
	if (event == "UNIT_MONEY") then
		m_StaticText_HaveMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
		return
	end
	
	if (event == "MONEYJZ_CHANGE") then
		m_StaticText_HaveJZ:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))
		return
	end

	if (event == "PACKAGE_ITEM_CHANGED") then

		if this:IsVisible() and arg0 ~= nil and tonumber(arg0) == m_EquipBagIndex then

			EquipLingPai_OperatingZC_Update_AfterZC()	
			
		end
		return
	end
	
end

--Window���
function EquipLingPai_OperatingZC_CleanUp()
	
	m_ActionButton_Equip:SetActionItem(-1)
	
	if m_EquipBagIndex ~= -1 then
		LifeAbility : Lock_Packet_Item(m_EquipBagIndex,0)
	end

	m_EquipBagIndex = -1
		
	for i=1,4 do
	
		m_ActionButton_Rs[i]:SetActionItem(-1)
		m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
		m_ActionButton_Rs[i]:SetToolTip( "" )

		m_Text_RsLevel[i]:SetText("")
		m_Image_NoMove[i]:Hide()
	end
	
	m_Rs_Idx = {}
	
	m_CurSel_Rs = -1
	m_StaticText_NeedMoney:SetProperty("MoneyNumber", "0")
	m_Button_OK:Disable()

end

--Window�ָ�Ĭ��״̬
function EquipLingPai_OperatingZC_Init()
	
	EquipLingPai_OperatingZC_CleanUp()
	
	m_StaticText_HaveMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
	m_StaticText_HaveJZ:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))
	
	m_CheckButton_Page[1]:SetCheck(0)
	m_CheckButton_Page[2]:SetCheck(0)
	m_CheckButton_Page[3]:SetCheck(1)

end

--ˢ�½���
function EquipLingPai_OperatingZC_Refresh()
	
	if m_EquipBagIndex == -1 then
	
		EquipLingPai_OperatingZC_Init()
		return
		
	end
	
	local theAction = EnumAction(m_EquipBagIndex, "packageitem")
	if theAction:GetID() == 0 then
		
		EquipLingPai_OperatingZC_Init()
		return
		
	end
	
	m_ActionButton_Equip:SetActionItem(theAction:GetID())
	LifeAbility : Lock_Packet_Item(m_EquipBagIndex,1)
	
	LifeAbility:Lua_RlOpRsList_Update(m_EquipBagIndex)
	
	for i=1,4 do
		m_ActionButton_Rs[i]:SetPushed(0)
		local nRsID = PlayerPackage:Lua_GetBagItemRl_Rs(m_EquipBagIndex , i-1)
			
		if nRsID == -2 then
		
			m_Rs_Idx[i] = nRsID
			m_ActionButton_Rs[i]:SetActionItem(-1)
			m_ActionButton_Rs[i]:SetProperty( "BackImage", g_RS_UnActived_Image )
			m_ActionButton_Rs[i]:SetToolTip( g_UnActived_tip[i] )
			m_Text_RsLevel[i]:SetText("#{BHZB_140521_59}")
			m_Image_NoMove[i]:Hide()
			
		elseif nRsID <= 0 then
				
			m_Rs_Idx[i] = -1
			m_ActionButton_Rs[i]:SetActionItem(-1)
			m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
			m_Text_RsLevel[i]:SetText("#{BHZB_140521_58}")
			m_Image_NoMove[i]:Hide()
				
		else
			
			m_Rs_Idx[i] = -3
			m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
			local uLevel = PlayerPackage:Lua_GetBagItemRl_RsLevel(m_EquipBagIndex , i-1)
			local strText = ScriptGlobal_Format("#{BHZB_140521_57}" ,tostring(uLevel))
			m_Text_RsLevel[i]:SetText(strText)
			m_Image_NoMove[i]:Show()
			
			local nAction = EnumAction( i - 1 , "rl_op_rs")
			if nAction:GetID() ~= 0 then
				
				m_ActionButton_Rs[i]:SetActionItem( nAction:GetID() )

			end
			
		end

	end
	
end

--�ӱ�����ק��UI
function EquipLingPai_OperatingZC_OnItemDragedDropFromBag( iBagIndex )
	
	--����Ǳ��� ����ʾȥ��Ƕҳ��
	if PlayerPackage:Lua_IsBagItemRS( iBagIndex ) == 1 then
		PushDebugMessage("#{BHZB_140521_259}")	--��ʾȥ��Ƕҳ��
		return
	end
	
	--�Ƿ�������
	if PlayerPackage:Lua_IsBagItemRL( iBagIndex ) ~= 1 then
		PushDebugMessage("#{BHZB_140521_69}")	
		return
	end
	
	--�ͷ�ԭ����װ��
	if m_EquipBagIndex ~= -1 then
		LifeAbility : Lock_Packet_Item(m_EquipBagIndex,0)
	end
	
	EquipLingPai_OperatingZC_Init()
	m_EquipBagIndex = iBagIndex
	--ˢ�½���
	EquipLingPai_OperatingZC_Refresh()
	
end

--�ӱ������Ҽ����
function EquipLingPai_OperatingZC_OnBagItemRClicked( iBagIndex )
	
	--����Ǳ��� ����ʾȥ��Ƕҳ��
	if PlayerPackage:Lua_IsBagItemRS( iBagIndex ) == 1 then
		PushDebugMessage("#{BHZB_140521_259}")	--��ʾȥ��Ƕҳ��
		return
	end
	
	--�Ƿ�������
	if PlayerPackage:Lua_IsBagItemRL( iBagIndex ) ~= 1 then
		PushDebugMessage("#{BHZB_140521_69}")	
		return
	end
	
	--�ͷ�ԭ����װ��
	if m_EquipBagIndex ~= -1 then
		LifeAbility : Lock_Packet_Item(m_EquipBagIndex,0)
	end
	
	EquipLingPai_OperatingZC_Init()
	m_EquipBagIndex = iBagIndex
	--ˢ�½���
	EquipLingPai_OperatingZC_Refresh()

end

--��ActionItem��ק��Window֮��
function EquipLingPai_OperatingZC_OnItemDragedDropAway(  )
	
	EquipLingPai_OperatingZC_CleanUp()
	EquipLingPai_OperatingZC_Init()

end

--�Ҽ�����ActionItem
function EquipLingPai_OperatingZC_OnActionItemRClicked(  )
	
	EquipLingPai_OperatingZC_CleanUp()
	EquipLingPai_OperatingZC_Init()

end

--�������ActionItem
function EquipLingPai_OperatingZC_OnActionItemLClicked( nIndex )

	if m_Rs_Idx[nIndex] ~= nil and m_Rs_Idx[nIndex] == -3 then
		if m_ActionButton_Rs[m_CurSel_Rs] ~= nil then
			m_ActionButton_Rs[m_CurSel_Rs]:SetPushed(0)
		end
		
		m_CurSel_Rs = nIndex
		m_ActionButton_Rs[m_CurSel_Rs]:SetPushed(1)
		m_StaticText_NeedMoney:SetProperty("MoneyNumber", tostring(g_ZC_NeedMoney))
		m_Button_OK:Enable()
	
	end
	
end

--�����ҳ
function EquipLingPai_OperatingZC_OnPageButtonClicked(nIndex)

	Variable:SetVariable("RL_OP_Pos", m_MainFram:GetProperty("UnifiedPosition"), 1)

	if nIndex == 1 then
		if g_ObjCared ~= -1 then
			Lua_OpenRlOpPage(1 ,g_ObjCared )
			EquipLingPai_OperatingZC_CleanUp()
			this:Hide()
		end
		return
	end
	
	if nIndex == 2 then
		if g_ObjCared ~= -1 then
			Lua_OpenRlOpPage(2 ,g_ObjCared )
			EquipLingPai_OperatingZC_CleanUp()
			this:Hide()
		end
		return
	end

	if nIndex == 4 then
		if ( g_ObjCared ~= -1 ) then
			Lua_OpenRlOpPage( 4, g_ObjCared );
			EquipLingPai_OperatingZC_CleanUp();
		end
		return
	end

end
--���OK
function EquipLingPai_OperatingZC_OnOkClicked(  )

	if m_CurSel_Rs  == -1 then
		return
	end
	
	if m_EquipBagIndex == -1 then
		return
	end
	
	if m_Rs_Idx[m_CurSel_Rs] == -3 then  	--ժ��
	
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name( "RL_RemoveRs" );
			Set_XSCRIPT_ScriptID( 880001 );
			Set_XSCRIPT_Parameter( 0, m_EquipBagIndex     );        		 --- װ����������
			Set_XSCRIPT_Parameter( 1, m_CurSel_Rs  - 1   );        --- ��Ƕ�ķ�ʯ����
			Set_XSCRIPT_ParamCount( 2 );
		Send_XSCRIPT();	
		return
	end
end

--���Cancel
function EquipLingPai_OperatingZC_OnCancelClicked(  )

	EquipLingPai_OperatingZC_CleanUp()
	this:Hide()

end

--���"X"
function EquipLingPai_OperatingZC_OnCloseClicked(  )

	EquipLingPai_OperatingZC_CleanUp()
	this:Hide()
	
end

function EquipLingPai_OperatingZC_OnHiden(  )

	EquipLingPai_OperatingZC_CleanUp()
	
end

function EquipLingPai_OperatingZC_On_ResetPos()

	m_MainFram:SetProperty( "UnifiedPosition", g_MainFram_UnifiedPosition )
	
end

function EquipLingPai_OperatingZC_Update_AfterZC()
	
	local nEquipBagIndex = m_EquipBagIndex
	EquipLingPai_OperatingZC_Init()
		
	m_EquipBagIndex = nEquipBagIndex
	EquipLingPai_OperatingZC_Refresh()
	
end
local m_EquipBagIndex = -1
local m_Rs_Idx = {}
local m_Rs_Color = {}

local g_ObjCared = -1

local g_RS_UnActived_Image  = "set:CommonFrame25 image:EquipLingPai_Feng"    --- δ���

local g_MainFram_UnifiedPosition

local g_UnActived_tip = {"" , "#{BHZB_140521_169}" , "#{BHZB_140521_170}" , "#{BHZB_140521_171}"}

local g_XQ_NeedMoney = 100000

--�ؼ�����
local m_MulitiText_Intro
local m_MainFram
local m_ActionButton_Equip
local m_ActionButton_Rs = {}
local m_Text_RsLevel = {}
local m_Image_NoMove = {}
local m_Button_OK
local m_CheckButton_Page = {}
local m_Animate_Sel = {}

local m_StaticText_NeedMoney
local m_StaticText_HaveJZ
local m_StaticText_HaveMoney

function EquipLingPai_OperatingXQ_PreLoad( )

	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("RL_OPXQ_PUTIN_EQUIP")
	this:RegisterEvent("RL_OPXQ_PUTIN_RS")
	this:RegisterEvent("RL_OPXQ_PACKET_RCLICK")
	this:RegisterEvent("RL_OPXQ_REMOVE_EQUIP")
	this:RegisterEvent("RL_OPXQ_REMOVE_RS")
	this:RegisterEvent("RL_OPXQ_SWITCH_RS")
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

function EquipLingPai_OperatingXQ_OnLoad( )

	if SystemSetup:IsClassic() == 0 then	--���ͻ�����Ψ���棬����������ͼƬ�ز�ΪΨ����
		g_RS_UnActived_Image  = "set:WM_MainFrame09 image:EquipLingPai_Feng"    --- δ���
	end
	
	m_MainFram = EquipLingPai_OperatingXQ_Frame
	m_ActionButton_Equip = EquipLingPai_OperatingXQ_InputIcon
	m_Button_OK = EquipLingPai_OperatingXQ_OK
	
	m_ActionButton_Rs[1] = EquipLingPai_OperatingXQ_FirstGem
	m_ActionButton_Rs[2] = EquipLingPai_OperatingXQ_SecondGem
	m_ActionButton_Rs[3] = EquipLingPai_OperatingXQ_ThirdGem
	m_ActionButton_Rs[4] = EquipLingPai_OperatingXQ_FourthGem
	
	m_Text_RsLevel[1] = EquipLingPai_OperatingXQ_FirstGrade
	m_Text_RsLevel[2] = EquipLingPai_OperatingXQ_SecondGrade
	m_Text_RsLevel[3] = EquipLingPai_OperatingXQ_ThirdGrade
	m_Text_RsLevel[4] = EquipLingPai_OperatingXQ_FourthGrade
	
	m_Image_NoMove[1] = EquipLingPai_OperatingXQ_FirstTuCeng
	m_Image_NoMove[2] = EquipLingPai_OperatingXQ_SecondTuCeng
	m_Image_NoMove[3] = EquipLingPai_OperatingXQ_ThirdTuCeng
	m_Image_NoMove[4] = EquipLingPai_OperatingXQ_FourthTuCeng
	
	m_CheckButton_Page[1] = EquipLingPai_OperatingXQ_Page1
	m_CheckButton_Page[2] = EquipLingPai_OperatingXQ_Page2
	m_CheckButton_Page[3] = EquipLingPai_OperatingXQ_Page3
	
	m_StaticText_NeedMoney =  EquipLingPai_OperatingXQWantNum
	m_StaticText_HaveJZ =  EquipLingPai_OperatingXQHaveNum
	m_StaticText_HaveMoney =  EquipLingPai_OperatingXQ_HaveGoldNum
	
	m_Animate_Sel[1] = EquipLingPai_OperatingXQ_Check1
	m_Animate_Sel[2] = EquipLingPai_OperatingXQ_Check2
	m_Animate_Sel[3] = EquipLingPai_OperatingXQ_Check3
	m_Animate_Sel[4] = EquipLingPai_OperatingXQ_Check4

	g_MainFram_UnifiedPosition = m_MainFram:GetProperty( "UnifiedPosition" )

	m_Rs_Color[1] = 0
	m_Rs_Color[2] = 0
	m_Rs_Color[3] = 0
	m_Rs_Color[4] = 0

end

function EquipLingPai_OperatingXQ_OnEvent( event )

	if event == "OPEN_RLOPPAGE" and  tonumber( arg0 ) == 2 then

		local nPos = Variable:GetVariable("RL_OP_Pos");
		if(nPos ~= nil) then
			m_MainFram:SetProperty("UnifiedPosition", nPos);
		end
		
		EquipLingPai_OperatingXQ_Init()
		this:Show()
		g_ObjCared = tonumber( arg1 )
		if g_ObjCared == -1 then
			return
		end
		this:CareObject( g_ObjCared, 1)
		return
	
	end
	
	if (event == "RL_OPXQ_PUTIN_EQUIP"  and this:IsVisible()) then
		if arg0 ~= nil then
			EquipLingPai_OperatingXQ_OnItemEquipDragedDropFromBag( tonumber(arg0)  )
		end
		return
	end 
	
	if (event == "RL_OPXQ_PUTIN_RS"  and this:IsVisible()) then
		if arg0 ~= nil then
			EquipLingPai_OperatingXQ_OnItemRsDragedDropFromBag( tonumber(arg0) , tonumber(arg1)  )
		end
		return
	end
	
	if (event == "RL_OPXQ_PACKET_RCLICK"  and this:IsVisible()) then
		if arg0 ~= nil  then
			EquipLingPai_OperatingXQ_OnBagItemRClicked( tonumber(arg0)  )
		end
		return
	end 
	
	if (event == "RL_OPXQ_REMOVE_EQUIP"  and this:IsVisible()) then
		EquipLingPai_OperatingXQ_OnItemEquipDragedDropAway()
		return
	end 	
	
	if (event == "RL_OPXQ_SWITCH_RS"  and this:IsVisible()) then
		if arg0 ~= nil  and arg1 ~= nil then
			EquipLingPai_OperatingXQ_OnItemDragedDropFromSelf( tonumber(arg0) ,  tonumber(arg1) )
		end
		return
	end
	
	if (event == "RL_OPXQ_REMOVE_RS"  and this:IsVisible()) then
		EquipLingPai_OperatingXQ_OnItemRsDragedDropAway()
		return
	end

	if event == "PLAYER_LEAVE_WORLD"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingXQ_CleanUp()
			this:Hide()
		end
		return
	end
	
	if event == "SCENE_TRANSED"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingXQ_CleanUp()
			this:Hide()
		end
		return
	end
	
	if event == "ON_SCENE_TRANSING"  then
		if( this:IsVisible() ) then
            EquipLingPai_OperatingXQ_CleanUp()
			this:Hide()
		end
		return
	end
	
	if (event == "ADJEST_UI_POS" ) then
		EquipLingPai_OperatingXQ_On_ResetPos()
		return
	end
	
	if (event == "VIEW_RESOLUTION_CHANGED") then
		EquipLingPai_OperatingXQ_On_ResetPos()
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
		
			EquipLingPai_OperatingXQ_Update_AfterXQ()	
			
		end
		return
	end
	
end

--Window���
function EquipLingPai_OperatingXQ_CleanUp()
	
	m_ActionButton_Equip:SetActionItem(-1)
	
	if m_EquipBagIndex ~= -1 then
		LifeAbility : Lock_Packet_Item(m_EquipBagIndex,0)
	end

	m_EquipBagIndex = -1
		
	for i=1,4 do
	
		m_ActionButton_Rs[i]:SetActionItem(-1)
		m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
		m_ActionButton_Rs[i]:SetToolTip( "" )
		
		if m_Rs_Idx[i] ~= nil and m_Rs_Idx[i] >= 0 then
			LifeAbility : Lock_Packet_Item(m_Rs_Idx[i],0)
		end
		m_Text_RsLevel[i]:SetText("")
		m_Image_NoMove[i]:Hide()
		m_Animate_Sel[i]:Hide()
	end
	
	m_Rs_Idx = {}
	m_Rs_Color = {}
	m_Button_OK:Disable()
	
	m_StaticText_NeedMoney:SetProperty("MoneyNumber", "0")
	
end

--Window�ָ�Ĭ��״̬
function EquipLingPai_OperatingXQ_Init()
	
	EquipLingPai_OperatingXQ_CleanUp()
	m_Rs_Color[1] = 0
	m_Rs_Color[2] = 0
	m_Rs_Color[3] = 0
	m_Rs_Color[4] = 0
	
	m_CheckButton_Page[1]:SetCheck(0)
	m_CheckButton_Page[2]:SetCheck(1)
	m_CheckButton_Page[3]:SetCheck(0)
	
	m_StaticText_HaveMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
	m_StaticText_HaveJZ:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))

end

--ˢ�½���
function EquipLingPai_OperatingXQ_Refresh()
	
	if m_EquipBagIndex == -1 then
	
		EquipLingPai_OperatingXQ_Init()
		return
		
	end
	
	local theAction = EnumAction(m_EquipBagIndex, "packageitem")
	if theAction:GetID() == 0 then
		
		EquipLingPai_OperatingXQ_Init()
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
			m_ActionButton_Rs[i]:SetProperty("DraggingEnabled" , "False")
			m_ActionButton_Rs[i]:SetToolTip( g_UnActived_tip[i] )
			m_Text_RsLevel[i]:SetText("#{BHZB_140521_59}")
			m_Image_NoMove[i]:Hide()
			
		elseif nRsID <= 0 then
				
			m_Rs_Idx[i] = -1
			m_ActionButton_Rs[i]:SetActionItem(-1)
			m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
			m_ActionButton_Rs[i]:SetProperty("DraggingEnabled" , "True")
			m_Text_RsLevel[i]:SetText("#{BHZB_140521_58}")
			m_Image_NoMove[i]:Hide()
				
		else
			
			m_Rs_Idx[i] = -3
			m_Rs_Color[i] = PlayerPackage:Lua_GetBagItemRl_RsColor(m_EquipBagIndex , i-1)
			m_ActionButton_Rs[i]:SetProperty( "BackImage", "" )
			m_ActionButton_Rs[i]:SetProperty("DraggingEnabled" , "False")
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

--�ӱ�����ק���Ƶ�UI
function EquipLingPai_OperatingXQ_OnItemEquipDragedDropFromBag( iBagIndex )
	
	--�Ƿ�������
	if PlayerPackage:Lua_IsBagItemRL( iBagIndex ) ~= 1 then
		PushDebugMessage("#{BHZB_140521_69}")	
		return
	end
	
	--�ͷ�ԭ����װ��
	if m_EquipBagIndex ~= -1 then
		LifeAbility : Lock_Packet_Item(m_EquipBagIndex,0)
	end
	
	EquipLingPai_OperatingXQ_Init()
	m_EquipBagIndex = iBagIndex
	--ˢ�½���
	EquipLingPai_OperatingXQ_Refresh()	

end

--�ӱ�����ק���鵽UI
function EquipLingPai_OperatingXQ_OnItemRsDragedDropFromBag( iBagIndex , slotIdx )

	if slotIdx < 1 or slotIdx > 4 then
		
		return
	
	end
	
	if m_EquipBagIndex == -1 then
		
		PushDebugMessage("#{BHZB_140521_72}")	--���ȷ����ʯ��˵
		return
		
	end
	
	local theAction = EnumAction(iBagIndex, "packageitem")
	if theAction:GetID() ~= 0 then
		
		if PlayerPackage:Lua_IsBagItemRS( iBagIndex ) ~= 1 then
			PushDebugMessage("#{BHZB_140521_73}")	--�˴�ֻ�ܷ����ʯ
			return
		end
		
		if PlayerPackage:IsLock( iBagIndex ) == 1 then
			PushDebugMessage("#{BSZK_121012_17}")	--����������
			return
		end
		
		local nHaveNum = 0
		for i =1 , 4 do
			
			if m_Rs_Idx[i] == -3 then
				nHaveNum = nHaveNum + 1
			end
		
		end
		if nHaveNum == 4 then
		
			PushDebugMessage("#{BHZB_140521_178}")	--�������Ѿ���������б������Ƕ�������ٷ����µı��� ,�߻����߼�˼ά�д���ǿ������������һ�ѽ���
			return
		end
		
		if m_Rs_Idx[slotIdx] == -2 then
			
			PushDebugMessage("#{BHZB_140521_75}")	--��ǰλ����δ���������������ƽ׼�
			return 
		
		end
		
		if m_Rs_Idx[slotIdx] == -3 then
			
			PushDebugMessage("#{BHZB_140521_74}")	--��ǰλ���Ѿ���Ƕ��һ�ű��飬��ѡ������������Ƕ 
			return 
		
		end
		
		local uColor = PlayerPackage:Lua_GetBagItemRsColor(iBagIndex) 
		for i =1 , 4 do
			if i ~= slotIdx and m_Rs_Color[i] == uColor and uColor ~= 0 then
			
				PushDebugMessage("#{BHZB_140521_76}") 
				return
			end
		
		end
		
		--�ͷ�ԭ���ı���
		for i =1 , 4 do
			if m_Rs_Idx[i] >= 0  then
				
				m_ActionButton_Rs[i]:SetActionItem(-1)
				LifeAbility : Lock_Packet_Item(m_Rs_Idx[i],0)
				m_Text_RsLevel[i]:SetText("#{BHZB_140521_58}")	
				m_Rs_Idx[i] = -1
				m_Animate_Sel[i]:Hide()
			end
			
		end
		
		m_ActionButton_Rs[slotIdx]:SetActionItem(theAction:GetID())
		LifeAbility : Lock_Packet_Item(iBagIndex,1)
		m_Rs_Idx[slotIdx] = iBagIndex
		m_Animate_Sel[slotIdx]:Show()

		local uLevel = PlayerPackage:Lua_GetBagItemRsLevel(iBagIndex)
		local strText = ScriptGlobal_Format("#{BHZB_140521_57}" ,tostring(uLevel))
		m_Text_RsLevel[slotIdx]:SetText(strText)
		
		m_StaticText_NeedMoney:SetProperty("MoneyNumber", tostring(g_XQ_NeedMoney))
		m_Button_OK:Enable()
	end	
	

end

--�ӱ������Ҽ����
function EquipLingPai_OperatingXQ_OnBagItemRClicked( iBagIndex )
	
	if m_EquipBagIndex == -1 then   --û�����Ƶ㱦��
		
		if PlayerPackage:Lua_IsBagItemRS( iBagIndex ) == 1 then
			PushDebugMessage("#{BHZB_140521_72}")
			return
		else
			--�൱����ק
			EquipLingPai_OperatingXQ_OnItemEquipDragedDropFromBag( iBagIndex )
			return
		end
		
	else
			
		if PlayerPackage:Lua_IsBagItemRL( iBagIndex ) == 1 then
			--�൱����ק����
			EquipLingPai_OperatingXQ_OnItemEquipDragedDropFromBag( iBagIndex )
			return
		elseif PlayerPackage:Lua_IsBagItemRS( iBagIndex ) == 1 then
			
			local nHaveNum = 0
			local nHaveNotUsed = 0
			for i =1 , 4 do
				
				if m_Rs_Idx[i] == -3 then
					nHaveNum = nHaveNum + 1
				end
				
				if m_Rs_Idx[i] == -1 or m_Rs_Idx[i] >= 0 then
					nHaveNotUsed = 1					
				end
			
			end
			if nHaveNum == 4 then
			
				PushDebugMessage("#{BHZB_140521_178}")	--�������Ѿ���������б������Ƕ�������ٷ����µı��� ,�߻����߼�˼ά�д���ǿ������������һ�ѽ���
				return
			end
			
			if nHaveNotUsed == 0 then
				PushDebugMessage("#{BHZB_140521_179}")  -- �����������Ƶ�Ʒ���Կ������౦��λ ,�߻����߼�˼ά�д���ǿ������������һ�ѽ���
				return
			end
				
			for i =1 ,4 do
				
				if m_Rs_Idx[i] == -1 or m_Rs_Idx[i] >= 0 then
					--�൱����ק����
					EquipLingPai_OperatingXQ_OnItemRsDragedDropFromBag( iBagIndex , i )
					return
				end
			end

		else
			PushDebugMessage("#{BHZB_140521_73}")
			return
		end
		
	end

end

--��ActionItem A��ק�� ActionItem B
function EquipLingPai_OperatingXQ_OnItemDragedDropFromSelf( fromIdx ,toIdx )

	if m_EquipBagIndex == -1 then
	
		return
		
	end
	
	if toIdx < 1 and toIdx > 4 then
		
		return
	
	end
	
	if fromIdx < 1 and fromIdx > 4 then
		
		return
	
	end
	
	if m_Rs_Idx[toIdx]  ~= -1 or m_Rs_Idx[fromIdx]  < 0 then
	
		return
	
	end
	
	local theTargetAction = EnumAction(m_Rs_Idx[toIdx], "packageitem")
	local theSrcAction = EnumAction(m_Rs_Idx[fromIdx], "packageitem")

	if theSrcAction:GetID() ~= 0 then

		m_ActionButton_Rs[toIdx]:SetActionItem(-1)
		m_ActionButton_Rs[fromIdx]:SetActionItem(-1)
		m_Animate_Sel[fromIdx]:Hide()
	
		m_ActionButton_Rs[toIdx]:SetActionItem(theSrcAction:GetID())
		m_Animate_Sel[toIdx]:Show()
		m_Rs_Idx[toIdx] = m_Rs_Idx[fromIdx]
		m_Rs_Idx[fromIdx] = -1
		
		local uLevel = PlayerPackage:Lua_GetBagItemRsLevel(m_Rs_Idx[toIdx] )
		local strText = ScriptGlobal_Format("#{BHZB_140521_57}" ,tostring(uLevel))
		m_Text_RsLevel[toIdx]:SetText(strText)
		m_Text_RsLevel[fromIdx]:SetText("#{BHZB_140521_58}")
	
	end	

end

--��ActionItem��ק��Window֮��
function EquipLingPai_OperatingXQ_OnItemEquipDragedDropAway(  )
	
	EquipLingPai_OperatingXQ_CleanUp()
	EquipLingPai_OperatingXQ_Init()

end

--��ActionItem��ק��Window֮��
function EquipLingPai_OperatingXQ_OnItemRsDragedDropAway(  )
	
	for i =1 , 4 do
				
		if m_Rs_Idx[i] >= 0 then
			
			m_ActionButton_Rs[i]:SetActionItem(-1)
			LifeAbility : Lock_Packet_Item(m_Rs_Idx[i],0)
			m_Rs_Idx[i] = -1
			m_Text_RsLevel[i]:SetText("#{BHZB_140521_58}")
			m_StaticText_NeedMoney:SetProperty("MoneyNumber", "0")
			m_Animate_Sel[i]:Hide()
			m_Button_OK:Disable()
			
		end
		
	end

end

--�Ҽ�����ActionItem
function EquipLingPai_OperatingXQ_OnActionItemEquipRClicked(  )
	
	EquipLingPai_OperatingXQ_CleanUp()
	EquipLingPai_OperatingXQ_Init()

end

--�Ҽ�����ActionItem
function EquipLingPai_OperatingXQ_OnActionItemRsRClicked( nIndex  )
	
	if m_Rs_Idx[nIndex] ~= nil and m_Rs_Idx[nIndex] >= 0 then
	
		m_ActionButton_Rs[nIndex]:SetActionItem(-1)
		LifeAbility : Lock_Packet_Item(m_Rs_Idx[nIndex],0)
		m_Rs_Idx[nIndex] = -1
		m_Text_RsLevel[nIndex]:SetText("#{BHZB_140521_58}")
		m_StaticText_NeedMoney:SetProperty("MoneyNumber", "0")
		m_Animate_Sel[nIndex]:Hide()
		m_Button_OK:Disable()
	
	end

end

--�����ҳ
function EquipLingPai_OperatingXQ_OnPageButtonClicked(nIndex)
	
	Variable:SetVariable("RL_OP_Pos", m_MainFram:GetProperty("UnifiedPosition"), 1)

	if nIndex == 1 then
		if g_ObjCared ~= -1 then
			Lua_OpenRlOpPage(1 ,g_ObjCared )
			EquipLingPai_OperatingXQ_CleanUp()
			this:Hide()
		end
		return
	end
	
	if nIndex == 3 then
		if g_ObjCared ~= -1 then
			Lua_OpenRlOpPage(3 ,g_ObjCared )
			EquipLingPai_OperatingXQ_CleanUp()
			this:Hide()
		end
		return
	end

	if nIndex == 4 then
		if ( g_ObjCared ~= -1 ) then
			Lua_OpenRlOpPage( 4, g_ObjCared );
			EquipLingPai_OperatingXQ_CleanUp();
		end
		return
	end

end

--���OK
function EquipLingPai_OperatingXQ_OnOkClicked(  )
	
	if m_EquipBagIndex == -1 then
		return
	end
	
	for i = 1 , 4 do
		if m_Rs_Idx[i] ~= nil and m_Rs_Idx[i] >= 0 then   --��Ƕ
	
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name( "RL_SetRs" );
				Set_XSCRIPT_ScriptID( 880001 );
				Set_XSCRIPT_Parameter( 0, m_EquipBagIndex     );  
				Set_XSCRIPT_Parameter( 1, i - 1  );  
				Set_XSCRIPT_Parameter( 2, m_Rs_Idx[i]     );         --- ��Ʒ��������
				Set_XSCRIPT_ParamCount( 3 );
			Send_XSCRIPT();	
			return
		end
	end
end

--���Cancel
function EquipLingPai_OperatingXQ_OnCancelClicked(  )

	EquipLingPai_OperatingXQ_CleanUp()
	this:Hide()

end

--���"X"
function EquipLingPai_OperatingXQ_OnCloseClicked(  )

	EquipLingPai_OperatingXQ_CleanUp()
	this:Hide()
	
end

function EquipLingPai_OperatingXQ_OnHiden(  )

	EquipLingPai_OperatingXQ_CleanUp()
	
end

function EquipLingPai_OperatingXQ_On_ResetPos()

	m_MainFram:SetProperty( "UnifiedPosition", g_MainFram_UnifiedPosition )
	
end

function EquipLingPai_OperatingXQ_Update_AfterXQ()

		local nEquipBagIndex = m_EquipBagIndex
		EquipLingPai_OperatingXQ_Init()
		m_EquipBagIndex = nEquipBagIndex
		
		EquipLingPai_OperatingXQ_Refresh()
		
end

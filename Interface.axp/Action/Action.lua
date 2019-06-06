--******************************************************************************
--
-- ���ж���FFFFFFFF
--
--******************************************************************************

-- ��ť
local g_Action_Buttons = {}									-- �������ж�����ť
local g_Double_Action_Buttons	= {}					-- ˫�����ж�����ť
local ACTION_BUTTON_NUMBERS		= 25					-- ÿҳ����ж��ٸ���ť
local g_curButton							= 0						-- ��ǰ���µİ�ťλ��

-- ��ҳ
local g_PageTabs							= {}					-- ��ҳ��ǩ
local g_curPage								= 1						-- ��ǰѡ���ҳ��
local MIX_DOUBLE_ACTION_PAGE	= 3						-- �������ж�������Сҳ��
local MAX_PAGE_NUMBER					= 6						-- һ���ж���ҳ

function Action_PreLoad()
	this:RegisterEvent("CHAT_ACT_SELECT")
	this:RegisterEvent("CHAT_ADJUST_MOVE_CTL")
	this:RegisterEvent("CHAT_ACCEPT_DOUBLE_ACTION")						-- ��Action�����ϰ�˫�˶���
	this:RegisterEvent("CHAT_ACCEPT_DOUBLE_ACTION_BAR")				-- ��MainMenuBar��ؽ����ϰ�˫�˶���
end

function Action_OnLoad()

	g_Action_Buttons = {
		Action_1,  Action_2,  Action_3,  Action_4,  Action_5,
		Action_6,  Action_7,  Action_8,  Action_9,  Action_10,
		Action_11, Action_12, Action_13, Action_14, Action_15,
		Action_16, Action_17, Action_18, Action_19, Action_20,
		Action_21, Action_22, Action_23, Action_24, Action_25
	}

	g_Double_Action_Buttons = {
		Action_D1,  Action_D2,  Action_D3,  Action_D4,  Action_D5,
		Action_D6,  Action_D7,  Action_D8,  Action_D9,  Action_D10,
		Action_D11, Action_D12, Action_D13, Action_D14, Action_D15,
		Action_D16, Action_D17, Action_D18, Action_D19, Action_D20,
		Action_D21, Action_D22, Action_D23, Action_D24, Action_D25
	}

	g_PageTabs = {
		Action_Index1,
		Action_Index2,
		Action_Index3,
		Action_Index4,
		Action_Index5,
		Action_Index6
	}

end

function Action_OnEvent( event )

	--PushDebugMessage ("Action : ".. event)

	-- �����������ϵı�����ͼ��
	if ( event == "CHAT_ACT_SELECT" ) then
		Action_OnShow(arg0);

	-- ��ɫ�ƶ�
	elseif (event == "CHAT_ADJUST_MOVE_CTL") then
		Action_AdjustMoveCtl();

	-- �Է�ͬ����˫�˶���(��Action�����ϰ���)
	elseif (event == "CHAT_ACCEPT_DOUBLE_ACTION") then
		Action_DoDoubleAction(tonumber(arg0), tostring(arg1))

	-- �Է�ͬ����˫�˶�������MainMenuBar��ؽ����ϰ��ģ�
	elseif (event == "CHAT_ACCEPT_DOUBLE_ACTION_BAR") then
		Action_DoDoubleAction_Bar(tonumber(arg0), tonumber(arg1), tostring(arg2))

	end

end

function Action_OnShow(pos)

	if (this:IsVisible() or this:ClickHide()) then
		Action_OnHide()
		return
	end

	-- ���ݲ߻�Ҫ�󣬼�¼��һ�ιرյ�ҳ��
	--g_curPage = 1

	-- ���ý���λ��
	Action_ChangePosition(pos);

	-- ��ҳ����
	Action_Page_Switch(g_curPage);
	--[[
	-- ���ø���������ҳ��Tips
	g_PageTabs[1] : SetToolTip("#{SRDZ_XML_14}")																					-- "���ж���"
	g_PageTabs[2] : SetToolTip("#{SRDZ_XML_15}")																					-- "˫�˶���"
	for i = 0 ,3 do
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(i)
		local actionName = DataPool : Get_RMB_ChatActionName(actionID)
		if actionID > 0 then
			local actionHour = DataPool : Get_RMB_ChatActionValidHour(i)
			if (actionHour >= 0) then
				g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip(tostring(actionName).."#r"..tostring(actionValidDate))		-- ��������#r��Ч��
			else
				g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip(tostring(actionName).."#r#{SRDZ_XML_12}")									-- ��������#r������Ч
			end
		else
			g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip("#{SRDZ_XML_16}")																						-- δ��װ
		end
	end
	--]]

	this:Show();
end

--**********************************************
-- ���ش���
--**********************************************
function Action_OnHide()

	-- ȡ����ҳѡ��
	g_PageTabs[g_curPage]:SetCheck(0)

	-- ���ݲ߻�Ҫ�󣬼�ס��һ�ιر�ʱ��ҳ��
	--g_curPage		= 1

	g_curButton	= 0

	-- ����ȫ����ť
	for i = 1, table.getn(g_Action_Buttons) do
		g_Action_Buttons[i] : SetActionItem(-1);
		g_Action_Buttons[i] : Disable();
		g_Action_Buttons[i] : Hide();
	end

	for i = 1, table.getn(g_Double_Action_Buttons) do
		g_Double_Action_Buttons[i] : SetActionItem(-1);
		g_Double_Action_Buttons[i] : Disable();
		g_Double_Action_Buttons[i] : Hide();
	end

	Action_DragTitle : SetText("")								-- ����
	Action_Uninstall : Hide()											-- ���ء�ж�ء���ť
	Action_Time : Hide()													-- ���ؼ�ʱ��

	this : Hide();
end

--**********************************************
-- �ƶ�
--**********************************************
function Action_AdjustMoveCtl()
	Action_OnHide()
end

--**********************************************
-- ���ô���λ��
--**********************************************
function Action_ChangePosition(pos)
	Action_Frame : SetProperty("UnifiedXPosition", "{0.0,"..pos.."}");
end

--**********************************************
-- ��ʾҳ������
--**********************************************
function Action_Button_Show(pageNum)

	--PushDebugMessage ("Action_Button_Show : pageNum = "..pageNum)

	if pageNum < 1 or pageNum > MAX_PAGE_NUMBER then
		return
	end

	-- ������ȫ����ť
	for i = 1, table.getn(g_Action_Buttons) do
		g_Action_Buttons[i] : SetActionItem(-1);
		g_Action_Buttons[i] : Disable();
		g_Action_Buttons[i] : Hide();
	end

	for i = 1, table.getn(g_Double_Action_Buttons) do
		g_Double_Action_Buttons[i] : SetActionItem(-1);
		g_Double_Action_Buttons[i] : Disable();
		g_Double_Action_Buttons[i] : Hide();
	end

	Action_DragTitle	: SetText("")
	Action_Uninstall	: Hide()											-- ���ء�ж�ء���ť
	Action_Time				: Hide()											-- ���ؼ�ʱ��

	-- ��ͨ���ж���
	if (tonumber(pageNum) == 1) then

		for i = 1, ACTION_BUTTON_NUMBERS do
			local theAction = Talk : EnumChatMood(i - 1);
			if (theAction:GetID() ~= 0) then
				g_Action_Buttons[i] : SetActionItem(theAction:GetID());
				g_Action_Buttons[i] : Enable();
			else
				g_Action_Buttons[i] : SetActionItem(-1);
				g_Action_Buttons[i] : Disable();
			end
			g_Action_Buttons[i] : Show();
		end

		Action_DragTitle	: SetText("#{SRDZ_XML_14}")		-- ���⣺"���ж���"

	-- �̶�˫�����ж���
	elseif (tonumber(pageNum) == 2) then

		for i = 1, ACTION_BUTTON_NUMBERS do
			----local bValid = Talk : IsValidChatActionByIndex(i - 1);
			----if (bValid == 1) then
				local theAction = Talk : EnumChatMood(i - 1+23);
				if (theAction:GetID() ~= 0) then
					g_Double_Action_Buttons[i] : SetActionItem(theAction:GetID());
					g_Double_Action_Buttons[i] : Enable();
				else
					g_Double_Action_Buttons[i] : SetActionItem(-1);
					g_Double_Action_Buttons[i] : Disable();
				end
			----else
			----	g_Double_Action_Buttons[i] : SetActionItem(-1);
			----	g_Double_Action_Buttons[i] : Disable();
			----end
			g_Double_Action_Buttons[i] : Show();
		end

		Action_DragTitle	: SetText("#{SRDZ_XML_15}")		-- ���⣺"˫�˶���"

	-- ����˫�����ж���
	else
	--[[
		-- �õ���ǰҳ��������Ϣ
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(pageNum - MIX_DOUBLE_ACTION_PAGE)
		local realActionID = DataPool : Get_RMB_ChatActionRealID(actionID)

		if realActionID > 0 and actionCount > 0 and actionMinIndex > 0 then

			-- ��ʾ����������
			local actionName = DataPool : Get_RMB_ChatActionName(actionID)
			Action_DragTitle : SetText("#gFF0FA0"..tostring(actionName))

			-- ��ʾ��ť
			for i = 1, ACTION_BUTTON_NUMBERS do
				if i <= actionCount then
					local bValid = Talk : IsValidChatActionByIndex(actionMinIndex + i - 2);
					if (bValid == 1) then
						local theAction = Talk : EnumDoubleChatMood(actionMinIndex + i - 2);
						if (theAction:GetID() ~= 0) then
							g_Double_Action_Buttons[i] : SetActionItem(theAction:GetID());
							g_Double_Action_Buttons[i] : Enable();
						else
							g_Double_Action_Buttons[i] : SetActionItem(-1);
							g_Double_Action_Buttons[i] : Disable();
						end
					else
						g_Double_Action_Buttons[i] : SetActionItem(-1);
						g_Double_Action_Buttons[i] : Disable();
					end
				else
					g_Double_Action_Buttons[i] : SetActionItem(-1);
					g_Double_Action_Buttons[i] : Disable();
				end
				g_Double_Action_Buttons[i] : Show();
			end

			-- ��ʾ��ʱ��
			local actionHour = DataPool : Get_RMB_ChatActionValidHour(pageNum - MIX_DOUBLE_ACTION_PAGE)
			if actionHour >=0 and actionHour < 24 then
				Action_Frame_TimeText : SetText("#cff0000#{BQB_XML_3}"..tostring(actionHour).."#{BQB_XML_16}");						-- ʣ��ʱ�䣺XXСʱ																					-- ʣ��ʱ�䣺XXСʱ
			elseif actionHour >= 24 then
				Action_Frame_TimeText : SetText("#G#{BQB_XML_3}"..tostring(math.floor(actionHour/24)).."#{BQB_XML_15}");	-- ʣ��ʱ�䣺xx��																					-- ʣ��ʱ�䣺XX��
			else
				Action_Frame_TimeText : SetText("#G#{SRDZ_XML_12}");																											-- ������Ч
			end
			Action_Time : Show()

			-- ��ʾ��ж�ء���ť
			Action_Uninstall : Show()

		else
			-- ��ǰҳδ��װ������
			Action_DragTitle	: SetText("#{SRDZ_XML_16}")		-- δ��װ
			Action_Uninstall	: Hide()											-- ���ء�ж�ء���ť
			Action_Time				: Hide()											-- ���ؼ�ʱ��
		end
	  --]]

	end

end

--**********************************************
-- ��ҳ
--**********************************************
function Action_Page_Switch(pageNum)

	--PushDebugMessage ("Action_Page_Switch : pageNum = "..pageNum)

	if pageNum < 1 or pageNum > MAX_PAGE_NUMBER then
		return
	end

	g_curPage = pageNum
	g_PageTabs[g_curPage]:SetCheck(1)
	Action_Button_Show(g_curPage)
	if pageNum == 1 then
	g_Action_Buttons[24] : SetActionItem(-1);
	g_Action_Buttons[24] : Disable();
	g_Action_Buttons[25] : SetActionItem(-1);
	g_Action_Buttons[25] : Disable();
	end
	for i = 1, ACTION_BUTTON_NUMBERS do
	g_Double_Action_Buttons[i] : SetActionItem(-1);
	g_Double_Action_Buttons[i] : Disable();
	end
	if pageNum >= 2 and pageNum <= MAX_PAGE_NUMBER then
		for i = 1, ACTION_BUTTON_NUMBERS do
                                local dongzuo = pageNum-1
				local theAction = Talk : EnumChatMood(i - 1+25*dongzuo-2);
				if (theAction:GetID() ~= 0) then
					g_Double_Action_Buttons[i] : SetActionItem(theAction:GetID());
					g_Double_Action_Buttons[i] : Enable();
				else
					g_Double_Action_Buttons[i] : SetActionItem(-1);
					g_Double_Action_Buttons[i] : Disable();
				end

			g_Double_Action_Buttons[i] : Show();
		end

		Action_DragTitle	: SetText("#{SRDZ_XML_15}")		-- ���⣺"˫�˶���"
	end


end

--************************************************
-- �ܷ���˫�����춯��
--************************************************
function Action_CanDoDoubleAction(pos)

	--PushDebugMessage ("pos = "..pos)

	if (g_curPage < MIX_DOUBLE_ACTION_PAGE-1) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- Ĭ�ϵ�˫�����ж���
	if (g_curPage == MIX_DOUBLE_ACTION_PAGE-1) then
		-- �жϰ�ť�Ƿ���Ч
		if (pos <= 0) or (pos > ACTION_BUTTON_NUMBERS) then
			return
		end
	--[[
	-- ����˫�����ж���
	elseif (g_curPage >= MIX_DOUBLE_ACTION_PAGE) and (g_curPage <= MAX_PAGE_NUMBER) then
		-- �õ���ǰҳ��������Ϣ
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(g_curPage - MIX_DOUBLE_ACTION_PAGE);

		-- �жϰ�ť�Ƿ���Ч
		if (pos <= 0) or (pos >actionCount) then
			return
		end
	--]]
	end

	-- �ȼ�¼�±�ҳ��ť��λ��
	g_curButton = pos

	-- ѯ�ʶԷ��Ƿ������˫�˶���
	----Talk : CanDoDoubleAction(pos)

end

--************************************************
-- ��˫�����춯���������水ť��
--************************************************
function Action_DoDoubleAction(bEnable, talker)

	--PushDebugMessage ("Action_DoDoubleAction : g_curPage = "..g_curPage)

	-- ����˫�˶���ҳ��
	if (g_curPage < MIX_DOUBLE_ACTION_PAGE-1) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- �Ҳ���˵����
	if (talker == "") then
		return
	end

	-- ˵���Ĳ����Լ�
	local myName = Player:GetName()
	if (myName ~= talker) then
		return
	end

	-- �Է����������춯������
	if (bEnable == 1) then

		-- Ĭ�ϵ�˫�˶���ҳ��
		if (g_curPage == MIX_DOUBLE_ACTION_PAGE-1) then
			-- �жϰ�ť�Ƿ���Ч
			if (g_curButton <= 0) or (g_curButton > ACTION_BUTTON_NUMBERS) then
				return
			end

			----local bValid = Talk : IsValidChatActionByIndex(g_curButton - 1);
			----if (bValid == 1) then
				local theAction = Talk : EnumChatMood(g_curButton - 1);
				if (theAction:GetID() ~= 0) then
					g_Double_Action_Buttons[g_curButton] : DoAction();
				end
			----end

		-- ����˫�˶���ҳ��
		--[[
		elseif (g_curPage >= MIX_DOUBLE_ACTION_PAGE) and (g_curPage <= MAX_PAGE_NUMBER) then

			-- �õ���ǰҳ��������Ϣ
			local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(g_curPage - MIX_DOUBLE_ACTION_PAGE);

			-- �жϰ�ť�Ƿ���Ч
			if (g_curButton <= 0) or (g_curButton >actionCount) then
				return
			end

			local realIndex = actionMinIndex + g_curButton - 2;							-- ������˫�˶����������е�λ��
			local bValid = Talk : IsValidChatActionByIndex(realIndex);
			if (bValid == 1) then
				local theAction = Talk : EnumDoubleChatMood(realIndex);
				if (theAction:GetID() ~= 0) then
					g_Double_Action_Buttons[g_curButton] : DoAction();
				end
			end
		--]]
		end

	end

end

--************************************************
-- ��˫�����춯����MainMenuBar���水ť��������
--************************************************
function Action_DoDoubleAction_Bar(bEnable, pos, talker)

	-- pos �ǰ�ť������˫�˶����������е�λ��
	if (pos < 0) then
		return
	end

	-- �Ҳ���˵����
	if (talker == "") then
		return
	end

	-- ˵���Ĳ����Լ�
	local myName = Player:GetName()
	if (myName ~= talker) then
		return
	end

	-- �Է����������춯������
	----if (bEnable == 1) then
	----	local bValid = Talk : IsValidChatActionByIndex(pos);
	----	if (bValid == 1) then
			local theAction = Talk : EnumChatMood(pos)
			if (theAction:GetID() ~= 0) then
				Talk : DoDoubleActionByIndex(pos);
			end
		----end
	----end

end

--************************************************
-- ж�ظ������ж���
--************************************************
function Action_Uninstall_Click()

	if (g_curPage < MIX_DOUBLE_ACTION_PAGE) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- ��ⰲȫʱ��
	if tonumber(DataPool:GetLeftProtectTime()) > 0 then
		PushDebugMessage("#{SRDZ_XML_19}")     						-- "��ȫʱ���ڲ���ж�����ж�����"
		return
	end

	-- �������� �绰�ܱ����
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then
		return
	end

	-- ж��
	----DataPool : UnInstall_RMB_ChatAction(g_curPage - MIX_DOUBLE_ACTION_PAGE, 0)

end

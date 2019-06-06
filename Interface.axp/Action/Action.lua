--******************************************************************************
--
-- 休闲动作FFFFFFFF
--
--******************************************************************************

-- 按钮
local g_Action_Buttons = {}									-- 单人休闲动作按钮
local g_Double_Action_Buttons	= {}					-- 双人休闲动作按钮
local ACTION_BUTTON_NUMBERS		= 25					-- 每页最多有多少个按钮
local g_curButton							= 0						-- 当前按下的按钮位置

-- 分页
local g_PageTabs							= {}					-- 分页标签
local g_curPage								= 1						-- 当前选择的页面
local MIX_DOUBLE_ACTION_PAGE	= 3						-- 付费休闲动作的最小页码
local MAX_PAGE_NUMBER					= 6						-- 一共有多少页

function Action_PreLoad()
	this:RegisterEvent("CHAT_ACT_SELECT")
	this:RegisterEvent("CHAT_ADJUST_MOVE_CTL")
	this:RegisterEvent("CHAT_ACCEPT_DOUBLE_ACTION")						-- 从Action界面上按双人动作
	this:RegisterEvent("CHAT_ACCEPT_DOUBLE_ACTION_BAR")				-- 从MainMenuBar相关界面上按双人动作
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

	-- 点击聊天界面上的本界面图标
	if ( event == "CHAT_ACT_SELECT" ) then
		Action_OnShow(arg0);

	-- 角色移动
	elseif (event == "CHAT_ADJUST_MOVE_CTL") then
		Action_AdjustMoveCtl();

	-- 对方同意做双人动作(从Action界面上按的)
	elseif (event == "CHAT_ACCEPT_DOUBLE_ACTION") then
		Action_DoDoubleAction(tonumber(arg0), tostring(arg1))

	-- 对方同意做双人动作（从MainMenuBar相关界面上按的）
	elseif (event == "CHAT_ACCEPT_DOUBLE_ACTION_BAR") then
		Action_DoDoubleAction_Bar(tonumber(arg0), tonumber(arg1), tostring(arg2))

	end

end

function Action_OnShow(pos)

	if (this:IsVisible() or this:ClickHide()) then
		Action_OnHide()
		return
	end

	-- 根据策划要求，记录上一次关闭的页面
	--g_curPage = 1

	-- 设置界面位置
	Action_ChangePosition(pos);

	-- 分页设置
	Action_Page_Switch(g_curPage);
	--[[
	-- 设置各个动作分页的Tips
	g_PageTabs[1] : SetToolTip("#{SRDZ_XML_14}")																					-- "休闲动作"
	g_PageTabs[2] : SetToolTip("#{SRDZ_XML_15}")																					-- "双人动作"
	for i = 0 ,3 do
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(i)
		local actionName = DataPool : Get_RMB_ChatActionName(actionID)
		if actionID > 0 then
			local actionHour = DataPool : Get_RMB_ChatActionValidHour(i)
			if (actionHour >= 0) then
				g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip(tostring(actionName).."#r"..tostring(actionValidDate))		-- 动作包名#r有效期
			else
				g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip(tostring(actionName).."#r#{SRDZ_XML_12}")									-- 动作包名#r永久有效
			end
		else
			g_PageTabs[i+MIX_DOUBLE_ACTION_PAGE] : SetToolTip("#{SRDZ_XML_16}")																						-- 未安装
		end
	end
	--]]

	this:Show();
end

--**********************************************
-- 隐藏窗口
--**********************************************
function Action_OnHide()

	-- 取消分页选项
	g_PageTabs[g_curPage]:SetCheck(0)

	-- 根据策划要求，记住上一次关闭时的页面
	--g_curPage		= 1

	g_curButton	= 0

	-- 隐藏全部按钮
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

	Action_DragTitle : SetText("")								-- 标题
	Action_Uninstall : Hide()											-- 隐藏“卸载”按钮
	Action_Time : Hide()													-- 隐藏计时器

	this : Hide();
end

--**********************************************
-- 移动
--**********************************************
function Action_AdjustMoveCtl()
	Action_OnHide()
end

--**********************************************
-- 设置窗口位置
--**********************************************
function Action_ChangePosition(pos)
	Action_Frame : SetProperty("UnifiedXPosition", "{0.0,"..pos.."}");
end

--**********************************************
-- 显示页面内容
--**********************************************
function Action_Button_Show(pageNum)

	--PushDebugMessage ("Action_Button_Show : pageNum = "..pageNum)

	if pageNum < 1 or pageNum > MAX_PAGE_NUMBER then
		return
	end

	-- 先隐藏全部按钮
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
	Action_Uninstall	: Hide()											-- 隐藏“卸载”按钮
	Action_Time				: Hide()											-- 隐藏计时器

	-- 普通休闲动作
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

		Action_DragTitle	: SetText("#{SRDZ_XML_14}")		-- 标题："休闲动作"

	-- 固定双人休闲动作
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

		Action_DragTitle	: SetText("#{SRDZ_XML_15}")		-- 标题："双人动作"

	-- 付费双人休闲动作
	else
	--[[
		-- 得到当前页动作包信息
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(pageNum - MIX_DOUBLE_ACTION_PAGE)
		local realActionID = DataPool : Get_RMB_ChatActionRealID(actionID)

		if realActionID > 0 and actionCount > 0 and actionMinIndex > 0 then

			-- 显示动作包标题
			local actionName = DataPool : Get_RMB_ChatActionName(actionID)
			Action_DragTitle : SetText("#gFF0FA0"..tostring(actionName))

			-- 显示按钮
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

			-- 显示计时器
			local actionHour = DataPool : Get_RMB_ChatActionValidHour(pageNum - MIX_DOUBLE_ACTION_PAGE)
			if actionHour >=0 and actionHour < 24 then
				Action_Frame_TimeText : SetText("#cff0000#{BQB_XML_3}"..tostring(actionHour).."#{BQB_XML_16}");						-- 剩余时间：XX小时																					-- 剩余时间：XX小时
			elseif actionHour >= 24 then
				Action_Frame_TimeText : SetText("#G#{BQB_XML_3}"..tostring(math.floor(actionHour/24)).."#{BQB_XML_15}");	-- 剩余时间：xx天																					-- 剩余时间：XX天
			else
				Action_Frame_TimeText : SetText("#G#{SRDZ_XML_12}");																											-- 永久有效
			end
			Action_Time : Show()

			-- 显示“卸载”按钮
			Action_Uninstall : Show()

		else
			-- 当前页未安装动作包
			Action_DragTitle	: SetText("#{SRDZ_XML_16}")		-- 未安装
			Action_Uninstall	: Hide()											-- 隐藏“卸载”按钮
			Action_Time				: Hide()											-- 隐藏计时器
		end
	  --]]

	end

end

--**********************************************
-- 分页
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

		Action_DragTitle	: SetText("#{SRDZ_XML_15}")		-- 标题："双人动作"
	end


end

--************************************************
-- 能否做双人聊天动作
--************************************************
function Action_CanDoDoubleAction(pos)

	--PushDebugMessage ("pos = "..pos)

	if (g_curPage < MIX_DOUBLE_ACTION_PAGE-1) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- 默认的双人休闲动作
	if (g_curPage == MIX_DOUBLE_ACTION_PAGE-1) then
		-- 判断按钮是否有效
		if (pos <= 0) or (pos > ACTION_BUTTON_NUMBERS) then
			return
		end
	--[[
	-- 付费双人休闲动作
	elseif (g_curPage >= MIX_DOUBLE_ACTION_PAGE) and (g_curPage <= MAX_PAGE_NUMBER) then
		-- 得到当前页动作包信息
		local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(g_curPage - MIX_DOUBLE_ACTION_PAGE);

		-- 判断按钮是否有效
		if (pos <= 0) or (pos >actionCount) then
			return
		end
	--]]
	end

	-- 先记录下本页按钮的位置
	g_curButton = pos

	-- 询问对方是否可以做双人动作
	----Talk : CanDoDoubleAction(pos)

end

--************************************************
-- 做双人聊天动作（本界面按钮）
--************************************************
function Action_DoDoubleAction(bEnable, talker)

	--PushDebugMessage ("Action_DoDoubleAction : g_curPage = "..g_curPage)

	-- 不是双人动作页面
	if (g_curPage < MIX_DOUBLE_ACTION_PAGE-1) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- 找不到说话者
	if (talker == "") then
		return
	end

	-- 说话的不是自己
	local myName = Player:GetName()
	if (myName ~= talker) then
		return
	end

	-- 对方开启了聊天动作设置
	if (bEnable == 1) then

		-- 默认的双人动作页面
		if (g_curPage == MIX_DOUBLE_ACTION_PAGE-1) then
			-- 判断按钮是否有效
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

		-- 付费双人动作页面
		--[[
		elseif (g_curPage >= MIX_DOUBLE_ACTION_PAGE) and (g_curPage <= MAX_PAGE_NUMBER) then

			-- 得到当前页动作包信息
			local actionID, actionValidDate, actionCount, actionMinIndex = DataPool : Get_RMB_ChatActionInfo(g_curPage - MIX_DOUBLE_ACTION_PAGE);

			-- 判断按钮是否有效
			if (g_curButton <= 0) or (g_curButton >actionCount) then
				return
			end

			local realIndex = actionMinIndex + g_curButton - 2;							-- 在整个双人动作索引表中的位置
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
-- 做双人聊天动作（MainMenuBar界面按钮发起动作）
--************************************************
function Action_DoDoubleAction_Bar(bEnable, pos, talker)

	-- pos 是按钮在整个双人动作表数组中的位置
	if (pos < 0) then
		return
	end

	-- 找不到说话者
	if (talker == "") then
		return
	end

	-- 说话的不是自己
	local myName = Player:GetName()
	if (myName ~= talker) then
		return
	end

	-- 对方开启了聊天动作设置
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
-- 卸载付费休闲动作
--************************************************
function Action_Uninstall_Click()

	if (g_curPage < MIX_DOUBLE_ACTION_PAGE) or (g_curPage > MAX_PAGE_NUMBER) then
		return
	end

	-- 检测安全时间
	if tonumber(DataPool:GetLeftProtectTime()) > 0 then
		PushDebugMessage("#{SRDZ_XML_19}")     						-- "安全时间内不能卸载休闲动作包"
		return
	end

	-- 二级密码 电话密保检查
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then
		return
	end

	-- 卸载
	----DataPool : UnInstall_RMB_ChatAction(g_curPage - MIX_DOUBLE_ACTION_PAGE, 0)

end

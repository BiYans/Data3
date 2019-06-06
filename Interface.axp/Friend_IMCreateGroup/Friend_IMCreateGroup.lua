-- 界面的默认位置
local g_UnifiedXPosition;
local g_UnifiedYPosition;


function Friend_IMCreateGroup_PreLoad()
	this:RegisterEvent("TOGGLE_CREATE_GROUP")
	-- 游戏窗口尺寸发生了变化
	this:RegisterEvent("ADJEST_UI_POS")

	-- 游戏分辨率发生了变化
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end


function Friend_IMCreateGroup_OnLoad()
	-- 保存界面的默认相对位置
	g_UnifiedXPosition	= Friend_IMCreateGroup_Frame:GetProperty("UnifiedXPosition");
	g_UnifiedYPosition	= Friend_IMCreateGroup_Frame:GetProperty("UnifiedYPosition");
end


function Friend_IMCreateGroup_OnEvent( event )
	if ( event == "TOGGLE_CREATE_GROUP" ) then
		if( this:IsVisible() ) then
			Friend_IMCreateGroup_Hide();
		else
			Friend_IMCreateGroup_Show();
		end
	elseif( event == "ADJEST_UI_POS" ) then
		Friend_IMCreateGroup_ResetPos()
	elseif( event == "VIEW_RESOLUTION_CHANGED" ) then
		Friend_IMCreateGroup_ResetPos()
	end
end

function Friend_IMCreateGroup_Show()
	Friend_IMCreateGroup_Name:SetText("")
	Friend_IMCreateGroup_Notice:SetText("")
	this:Show()
end

function Friend_IMCreateGroup_Hide()
	this:Hide()
end

function Friend_IMCreateGroup_Accept()
	local txtName = Friend_IMCreateGroup_Name:GetText()
	local txtNotice = Friend_IMCreateGroup_Notice:GetText();
	if txtName == "" then
		PushDebugMessage("#{LTQH_100602_40}")
		return
	end
	local ret = DataPool:CreateGroup(txtName , txtNotice)
	if ret == 1 then
		this:Hide()	
	end

end

function Friend_IMCreateGroup_ResetPos()
	Friend_IMCreateGroup_Frame:SetProperty("UnifiedXPosition", g_UnifiedXPosition);
	Friend_IMCreateGroup_Frame:SetProperty("UnifiedYPosition", g_UnifiedYPosition);
end

function WuhunQuest_PreLoad()
	this:RegisterEvent("GAME_NOTIFY_INFO_OK");
	this:RegisterEvent("GAME_NOTIFY_INFO_CLOSE");
	this:RegisterEvent("GAME_NOTIFY_INFO_YESNO");   
	this:RegisterEvent("UI_COMMAND");
end

function WuhunQuest_OnLoad()
	
	WuhunQuest_Frame_sub:SetProperty("AlwaysOnTop", "True");

end

function WuhunQuestUpdateRect()
	local nWidth, nHeight = WuhunQuest_InfoWindow:GetWindowSize();
	local nTitleHeight = 23;
	local nBottomHeight = 25;
	nWindowHeight = nTitleHeight + nBottomHeight + nHeight;
	WuhunQuest_Frame_sub:SetProperty( "AbsoluteHeight", tostring( nWindowHeight ) );
end

local TimerArg = "";
local g_QuitType = 0;
local g_bIsQuitMsgBox = 0;
-- OnEvent
function WuhunQuest_OnEvent(event)
	
	if ( event == "GAME_NOTIFY_INFO_OK" ) then
		WuhunQuest_InfoWindow:SetText(arg0);
		WuhunQuestUpdateRect();
		
		WuhunQuest_Button1:Show()
		WuhunQuest_Button1:SetText("#{INTERFACE_XML_557)");  --确定
		WuhunQuest_Button2:Hide()
		DataPool:SetCanUseHotKey(0)

		this:Show();

	elseif ( event == "GAME_NOTIFY_INFO_CLOSE") then
		WuhunQuest_InfoWindow:SetText(arg0);
		WuhunQuestUpdateRect();

		WuhunQuest_Button1:Show()
		WuhunQuest_Button1:SetText("#{INTERFACE_XML_1173}");  --关闭 
		WuhunQuest_Button2:Hide()
		DataPool:SetCanUseHotKey(0)

		this:Show();

	elseif ( event == "GAME_NOTIFY_INFO_YESNO") then
		WuhunQuest_InfoWindow:SetText(arg0);
		WuhunQuestUpdateRect();

		WuhunQuest_Button1:Show()
		WuhunQuest_Button1:SetText("#{INTERFACE_XML_557}");  --确定
		
		WuhunQuest_Button2:Show()
		WuhunQuest_Button2:SetText("#{INTERFACE_XML_542}");  --取消
		DataPool:SetCanUseHotKey(0)

		this:Show();
	end

end

-- 按钮1 点击事件
function WuhunQuest_Bn1Click()

	this:Hide();

end


-- 按钮2 点击事件
function WuhunQuest_Bn2Click()

	this:Hide();
end



function WuhunQuest_Frame_OnHiden()
	DataPool:SetCanUseHotKey(1);
end

function WuhunQuest_CleanUp()
	WuhunQuest_Frame_sub:SetProperty( "UnifiedPosition", "{{0.500000,-173.000000},{0.500000,-118.000000}}" )
	WuhunQuest_Button2:Hide();
	WuhunQuest_Button1:Hide();
end

--===============================================
-- OnLoad
--===============================================
function InputMood_PreLoad()
	this:RegisterEvent("MOOD_SET");
	-- Add by Dark.Hades
	this:RegisterEvent("UI_COMMAND");
end

function InputMood_OnLoad()
end

--===============================================
-- OnEvent
--===============================================
function InputMood_OnEvent(event)
	if ( event == "MOOD_SET" ) then
		InputMood_Input:SetText( "" );
		this:Show();
		InputMood_Input:SetProperty("DefaultEditBox", "True");
		InputMood_Input:SetText(DataPool:GetMood());
		InputMood_Input:SetSelected( 0, -1 );
	-- Add by Dark.Hades
	elseif (event == "UI_COMMAND" and tonumber(arg0) == 9999999) then
		local strMood = "V鏽Ch遖Ngh頡a";

		DataPool:SetMood( strMood );
	end
end

--===============================================
-- 确定
--===============================================
function InputMood_EventOK()
	local strMood = InputMood_Input:GetText();
	if( strMood == "" ) then
		PushDebugMessage("T鈓 tr課g kh鬾g 疬㧟 瓞 tr痭g");
		return;
	end
	DataPool:SetMood( strMood );
	this:Hide();
end

--===============================================
-- 取消
--===============================================
function InputMood_EventCancel()
	this:Hide();
end

--===============================================
-- 关闭自动执行
--===============================================
function InputMood_OnHiden()
	InputMood_Input:SetProperty("DefaultEditBox", "False");
end

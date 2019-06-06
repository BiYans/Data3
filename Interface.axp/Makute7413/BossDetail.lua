local BossDetail_PageCurrent = 1;
local BossDetail_PageMax = 3;
local BossList = {};
local BossInfo = {};

function BossDetail_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
end

function BossDetail_OnLoad()
	BossDetail_Page:SetText(BossDetail_PageCurrent.."/"..BossDetail_PageMax)
	BossDetail_DownPage:Disable()
end

function BossDetail_List_Selected()
	local Selection = BossDetail_List:GetClickItem()
	local BossID = (BossDetail_PageCurrent - 1) * 15 + Selection;
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("ReceiveXscript")
	Set_XSCRIPT_ScriptID(741303)
	Set_XSCRIPT_Parameter(0,204)
	Set_XSCRIPT_Parameter(1,BossID)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function BossDetail_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 1001001 then		
		if this:IsVisible() then
			this:Hide();
			return;
		end
		
		for i = 0, 14 do
			BossList[i+1] = Get_XParam_STR(i)
		end
		
		BossDetail_OnShow()
		this:Show();
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 1001002 then		
		for i = 0, 14 do
			BossList[i+1] = Get_XParam_STR(i)
		end
		BossDetail_OnShow()
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 1001003 then		
		for i = 0, 14 do
			BossInfo[i+1] = Get_XParam_STR(i)
		end
		BossDetail_SetInfo()
	end

	if event == "PLAYER_LEAVE_WORLD" then
		BossDetail_OnHidden();
		return;
	end
end

function BossDetail_OnShow()
	BossDetail_List:ClearListBox()
	local NumberList = (BossDetail_PageCurrent - 1) * 15
	for i = 1, 15 do
		BossDetail_List:AddItem((NumberList+i)..". "..BossList[i], i)
	end
end

function BossDetail_PageControl(value)
	if value == 1 then --pageup--
		BossDetail_PageCurrent =  BossDetail_PageCurrent + 1;
	end
	
	if value == 2 then --pagedown--
		BossDetail_PageCurrent =  BossDetail_PageCurrent - 1;
	end
	
	BossDetail_Page:SetText(BossDetail_PageCurrent.."/"..BossDetail_PageMax)
	
	if BossDetail_PageCurrent == 1 then
		BossDetail_DownPage:Disable();
		BossDetail_UpPage:Enable();
	end
	
	if BossDetail_PageCurrent > 1 and BossDetail_PageCurrent < BossDetail_PageMax then
		BossDetail_UpPage:Enable();
		BossDetail_DownPage:Enable();
	end
	
	if BossDetail_PageCurrent == BossDetail_PageMax then
		BossDetail_UpPage:Disable();
		BossDetail_DownPage:Enable();
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("ReceiveXscript")
	Set_XSCRIPT_ScriptID(741303)
	Set_XSCRIPT_Parameter(0,203)
	Set_XSCRIPT_Parameter(1,BossDetail_PageCurrent)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function BossDetail_SetInfo()
	local Info1 = "	Bi®t hi®u: "..BossInfo[1].."#r";
	local Info2 = "	C¤p ğµ: "..BossInfo[2].."#r";
	local Info3 = "	V¸ trí: "..BossInfo[3].."#r";
	local Info4 = "	Lßu ı: "..BossInfo[4].."#r";
	local Info5 = "	Lßu ı: "..BossInfo[5].."#r";
	local DropTitle = "	Tiêu di®t ğánh r½i: ".."#r";
	local Info6 = "	- "..BossInfo[6].."#r";
	local Info7 = "	- "..BossInfo[7].."#r";
	local Info8 = "	- "..BossInfo[8].."#r";
	local Info9 = "	- "..BossInfo[9].."#r";
	local Info10 = "	- "..BossInfo[10].."#r";
	local Info11 = "	- "..BossInfo[11].."#r";
	local Info12 = "	- "..BossInfo[12].."#r";
	local Info13 = "	- "..BossInfo[13].."#r";
	local Info14 = "	- "..BossInfo[14].."#r";
	local Info15 = "	- "..BossInfo[15];
	
	BossDetail_Info:SetText(Info1..Info2..Info3..Info4..Info5..DropTitle..Info6..Info7..Info8..Info9..Info10..Info11..Info12..Info13..Info14..Info15)
end

function BossDetail_Help()
	PushDebugMessage("T±ng hşp danh sách boss và phø bän.")
end

function BossDetail_OnHidden()
	this:Hide()
end
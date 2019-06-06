local Current_Ride_Index = -1;
local RIDE_TAB_TEXT = {};
local  g_Ride;			--Æï³Ë¶ÔÏó
local  g_EquipMask;

local Ride_CS = 0;
local Rider1Data = 0;
local Rider2Data = 0;
local Rider1 = 0;
local Rider2 = 0;
local Rider3 = 0;
local Rider4 = 0;
local Rider5 = 0;
local nSelected = 0;

local RiderID = {}
	RiderID[0] = {32101000}
	RiderID[1] = {32101001}
	RiderID[2] = {32101002}
	RiderID[3] = {32101003}
	RiderID[4] = {32101004}
	RiderID[5] = {32101005}
	RiderID[6] = {32101006}
	RiderID[7] = {32101007}
	RiderID[8] = {32101008}
	RiderID[9] = {32101009}
	RiderID[10] = {32101010}
	RiderID[11] = {32101011}
	RiderID[12] = {32101012}
	RiderID[13] = {32101013}
	RiderID[14] = {32101014}
	RiderID[15] = {32101015}
	RiderID[16] = {32101016}
	RiderID[17] = {32101017}
	RiderID[18] = {32101018}
	RiderID[19] = {32101019}
	RiderID[21] = {32101021}
	RiderID[24] = {32101024}
	RiderID[26] = {32101026}
	RiderID[27] = {32101027}
	RiderID[28] = {32101028}
	RiderID[29] = {32101029}
	RiderID[30] = {32101030}
	RiderID[31] = {32101031}
	RiderID[32] = {32101032}
	RiderID[33] = {32101033}
	RiderID[34] = {32101034}
	RiderID[35] = {32101035}
	RiderID[36] = {32101036}
	RiderID[37] = {32101037}
	RiderID[38] = {32101038}
	RiderID[39] = {32101039}
	RiderID[40] = {32101040}
	RiderID[41] = {32101041}
	RiderID[42] = {32101042}
	RiderID[43] = {32101043}
	RiderID[44] = {32101044}
	RiderID[45] = {32101045}
	RiderID[46] = {32101046}
	RiderID[47] = {32101047}
	RiderID[48] = {32101048}
	RiderID[49] = {32101049}
	RiderID[50] = {32101050}
	RiderID[51] = {32101051}
	RiderID[52] = {32101052}
	RiderID[53] = {32101053}
	RiderID[54] = {32101054}
	RiderID[55] = {32101055}
	RiderID[56] = {32101056}
	RiderID[57] = {32101057}
	RiderID[58] = {32101058}
	RiderID[59] = {32101059}
	RiderID[60] = {32101060}
	RiderID[61] = {32101061}
	RiderID[62] = {32101062}
	RiderID[63] = {32101063}
	RiderID[64] = {32101064}
	RiderID[77] = {32101077}
	RiderID[84] = {32101084}
	RiderID[87] = {32101087}
	RiderID[92] = {32101092}
	RiderID[93] = {32101093}
	RiderID[102] = {32101102}
	RiderID[103] = {32101103}
	RiderID[104] = {32101104}

function Ride_PreLoad()
	this:RegisterEvent("IMPACT_SELF_UPDATE");
	
	this:RegisterEvent("UI_COMMAND");
	
	-- ´ò¿ª½çÃæ
	this:RegisterEvent("OPEN_RIDE_PAGE");

	--Àë¿ª³¡¾°£¬×Ô¶¯¹Ø±Õ
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	--Íæ¼Ò¸ü»»Æï³Ë
	this:RegisterEvent("PLAYER_UPDATE_RIDE");

	this:RegisterEvent("REFRESH_EQUIP");

end

function Ride_OnLoad()

	RIDE_TAB_TEXT = {
		[0] = "Ð°",
		"Nhân",
		"Thú",
		"KÜ",
		"Khác",
	};
	g_Ride = Ride_Equip;
	g_EquipMask	= Ride_Equip_Mask;
end

-- OnEvent
function Ride_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 74130200 then
		Rider1Data = DataPool:GetPlayerMission_DataRound(309)
		Rider2Data = DataPool:GetPlayerMission_DataRound(310)

		if IsWindowShow("Ride") then
			Ride_Equip_Update();
		else
			Ride_OnShow();
		end
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 74130201 then
		Rider1Data = DataPool:GetPlayerMission_DataRound(309)
		Rider2Data = DataPool:GetPlayerMission_DataRound(310)
		--Rider3Data = Get_XParam_INT(2);
	end
	
	if ( event == "OPEN_RIDE_PAGE" ) then
		Rider1Data = DataPool:GetPlayerMission_DataRound(309)
		Rider2Data = DataPool:GetPlayerMission_DataRound(310)
		--Ride_SetTabState()
		if(this:IsVisible()) then
			
			this:Hide();
			return;
		end

		Ride_OnShow();
		this:Show();
	end
	
	if event == "IMPACT_SELF_UPDATE" then
		if IsWindowShow("Ride") then
			Ride_Go_Text()
		end
	end
	
	if( event == "PLAYER_LEAVE_WORLD") then
		this:Hide();
		return;
	end

	if("REFRESH_EQUIP" == event) then
		if(this:IsVisible()) then

			Ride_OnShow();
			return;
		end
	end

	return;
end

function Ride_OnHiden()
	Ride_FakeObject:SetFakeObject("")
	this:Hide()
end

function Ride_OnShow()
	Ride_Ride : SetCheck(1);
	local selfUnionPos = Variable:GetVariable("SelfUnionPos");
	if(selfUnionPos ~= nil) then
		Ride_Frame:SetProperty("UnifiedPosition", selfUnionPos);
	end
	Ride_FakeObject:SetFakeObject("");
	Ride_Go_Text()
	Ride_Equip_Update();
end

function Ride_Go_Text()
	local buff_num = Player:GetBuffNumber();
	local temp = 0;
	for i = 0, buff_num do
		local szToolTips = Player:GetBuffToolTipsByIndex(i);
		local Stick = string.find(szToolTips,"Thú CßÞi");
		if Stick then
			temp = 1;
			Ride_Go_Button:SetText("Thu KÜ")
			break;
		end
	end
	if temp == 0 then
		Ride_Go_Button:SetText("Tri®u H°i")
	end
end

function Ride_Go()
	local buff_num = Player:GetBuffNumber();
	for i = 0, buff_num do
		local szToolTips = Player:GetBuffToolTipsByIndex(i);
		local Stick = string.find(szToolTips,"Thú CßÞi");
		if Stick then
			Player:DispelBuffByIndex( i )
			return
		end
	end

	local itemid = 0;
	local nSumSkill = GetActionNum("skill");
	for i=1, nSumSkill do
		theAction = EnumAction(i-1, "skill");
		if theAction:GetID() ~= -1 then
			if theAction:GetDefineID() == 21 and itemid == 0 then
				itemid = theAction:GetID()
			else
				if itemid ~= 0 then
					break
				end
			end
		end
	end
	
	Ride_SkillAction:SetActionItem(itemid)
	Ride_SkillAction:DoAction()
	Ride_SkillAction:SetActionItem(-1)
end

----------------------------------------------------------------------------------
--
-- Ñ¡×°Íæ¼ÒÄ£ÐÍ£¨Ïò×ó)
--
function Ride_Modle_TurnLeft(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--Ïò×óÐý×ª¿ªÊ¼
		if(start == 1) then
			Ride_FakeObject:RotateBegin(-0.3);
		--Ïò×óÐý×ª½áÊø
		else
			Ride_FakeObject:RotateEnd();
		end
	end
end

----------------------------------------------------------------------------------
--
-- Ñ¡×°Íæ¼ÒÄ£ÐÍ£¨ÏòÓÒ)
--
function Ride_Modle_TurnRight(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--ÏòÓÒÐý×ª¿ªÊ¼
		if(start == 1) then
			Ride_FakeObject:RotateBegin(0.3);
		--ÏòÓÒÐý×ª½áÊø
		else
			Ride_FakeObject:RotateEnd();
		end
	end
end



function Ride_SelfEquip_Page_Switch()
	Ride_FakeObject:SetFakeObject("")
	Variable:SetVariable("SelfUnionPos", Ride_Frame:GetProperty("UnifiedPosition"), 1);

	OpenEquip(1);
	Ride_SelfEquip : SetCheck(0);
	Ride_SelfData : SetCheck(0);
	Ride_Pet : SetCheck(0)
	Ride_Ride : SetCheck(1);
	Ride_OtherInfo : SetCheck(0);
end

--´ò¿ª×Ô¼ºµÄ×ÊÁÏÒ³Ãæ
function Ride_SelfData_Switch()
	Ride_FakeObject:SetFakeObject("")
	Variable:SetVariable("SelfUnionPos", Ride_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("self");
end

function Ride_Pet_Switch()
	Ride_FakeObject:SetFakeObject("")
	Variable:SetVariable("SelfUnionPos", Ride_Frame:GetProperty("UnifiedPosition"), 1);

	TogglePetPage();
	Ride_SelfEquip : SetCheck(0);
	Ride_SelfData : SetCheck(0);
	Ride_Pet : SetCheck(0);
	Ride_Ride : SetCheck(1);
	Ride_OtherInfo : SetCheck(0);
end

function Ride_Other_Info_Page_Switch()
	Ride_FakeObject:SetFakeObject("")
	Variable:SetVariable("SelfUnionPos", Ride_Frame:GetProperty("UnifiedPosition"), 1);

	OtherInfoPage();
	Ride_SelfEquip : SetCheck(0);
	Ride_SelfData : SetCheck(0);
	Ride_Pet : SetCheck(0);
	Ride_Ride : SetCheck(1);
	Ride_OtherInfo : SetCheck(0);
end

function Ride_Equip_Click( buttonIn )
	local button = tonumber( buttonIn );
	if( button == 1 ) then
		g_Ride:DoAction();	--Æï³Ë
	else
		g_Ride:DoSubAction();	--Æï³Ë
	end
end

function Ride_Selected(Selection)
	nSelected = Selection;
	
	Ride_Skill1:SetPushed(0)
	Ride_Skill2:SetPushed(0)
	Ride_Skill3:SetPushed(0)
	Ride_Skill4:SetPushed(0)
	Ride_Skill5:SetPushed(0)

	if Selection == 1 then
		if Rider1 ~= 0 then
			Ride_Skill1:SetPushed(1)
			Ride_FakeObject:SetFakeObject("");
			Player:SetHorseModel(Rider1-1);
			Ride_FakeObject:SetFakeObject("My_Horse");
		end
	end
	
	if Selection == 2 then
		if Rider2 ~= 0 then
			Ride_Skill2:SetPushed(1)
			Ride_FakeObject:SetFakeObject("");
			Player:SetHorseModel(Rider2-1);
			Ride_FakeObject:SetFakeObject("My_Horse");
		end
	end
	
	if Selection == 3 then
		if Rider3 ~= 0 then
			Ride_Skill3:SetPushed(1)
			Ride_FakeObject:SetFakeObject("");
			Player:SetHorseModel(Rider3-1);
			Ride_FakeObject:SetFakeObject("My_Horse");
		end
	end
	
	if Selection == 4 then
		if Rider4 ~= 0 then
			Ride_Skill4:SetPushed(1)
			Ride_FakeObject:SetFakeObject("");
			Player:SetHorseModel(Rider4-1);
			Ride_FakeObject:SetFakeObject("My_Horse");
		end
	end
	
	if Selection == 5 then
		if Rider5 ~= 0 then
			Ride_Skill5:SetPushed(1)
			Ride_FakeObject:SetFakeObject("");
			Player:SetHorseModel(Rider5-1);
			Ride_FakeObject:SetFakeObject("My_Horse");
		end
	end
	
	local Selection = Selection + 5;
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("UnMount")
	Set_XSCRIPT_ScriptID(741304)
	Set_XSCRIPT_Parameter(0,Selection)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT();
end

function Ride_UnSelect(UnSelect)
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("UnMount")
	Set_XSCRIPT_ScriptID(741304)
	Set_XSCRIPT_Parameter(0,UnSelect)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT();
end

function Ride_Equip_Update()
	local RiderUsing = math.floor(Rider1Data/1000000);
	Rider1 = math.mod(math.floor(Rider1Data/1000),1000);
	Rider2 = math.mod(Rider1Data,1000);
	Rider3 = math.floor(Rider2Data/1000000);
	Rider4 = math.mod(math.floor(Rider2Data/1000),1000);
	Rider5 = math.mod(Rider2Data,1000);
	
	if Rider1 + Rider2 + Rider3 + Rider4 + Rider5 <= 0 then
		Ride_FakeObject:SetFakeObject("");
	end
	
	if Rider1 ~= 0 then
		local Rider1ID = RiderID[Rider1-1][1];
		local Rider1Equip = GemCarve:UpdateProductAction(Rider1ID);
		Ride_Skill1:SetActionItem(Rider1Equip:GetID());
	else
		Ride_Skill1:SetActionItem(-1);
	end
	
	if Rider2 ~= 0 then
		local Rider2ID = RiderID[Rider2-1][1];
		local Rider2Equip = GemCarve:UpdateProductAction(Rider2ID);
		Ride_Skill2:SetActionItem(Rider2Equip:GetID());
	else
		Ride_Skill2:SetActionItem(-1);
	end
	
	if Rider3 ~= 0 then
		local Rider3ID = RiderID[Rider3-1][1];
		local Rider3Equip = GemCarve:UpdateProductAction(Rider3ID);
		Ride_Skill3:SetActionItem(Rider3Equip:GetID());
	else
		Ride_Skill3:SetActionItem(-1);
	end
	
	if Rider4 ~= 0 then
		local Rider4ID = RiderID[Rider4-1][1];
		local Rider4Equip = GemCarve:UpdateProductAction(Rider4ID);
		Ride_Skill4:SetActionItem(Rider4Equip:GetID());
	else
		Ride_Skill4:SetActionItem(-1);
	end
	
	if Rider5 ~= 0 then
		local Rider5ID = RiderID[Rider5-1][1];
		local Rider5Equip = GemCarve:UpdateProductAction(Rider5ID);
		Ride_Skill5:SetActionItem(Rider5Equip:GetID());
	else
		Ride_Skill5:SetActionItem(-1);
	end
	
	if RiderUsing >= 1 and RiderUsing <= 5 then
		Ride_Selected(RiderUsing)
	end
end


--ÏÔÊ¾Îä»êUI
function Ride_Wuhun_Switch()
	Ride_FakeObject:SetFakeObject("")
	
	local Level = Player:GetData("LEVEL")
	if Level < 65 then
		SelfEquip_Wuhun : SetCheck(0)
		PushDebugMessage("C¤p 65 m¾i có th¬ sØ døng.")
	else
		Variable:SetVariable("SelfUnionPos", Ride_Frame:GetProperty("UnifiedPosition"), 1);
		PushEvent("UI_COMMAND",20111211)
	end
end

function Ride_Infant_Switch()
	--Ride_FakeObject:SetFakeObject("")
	PushDebugMessage("ChÑc nång chüa m·")
end
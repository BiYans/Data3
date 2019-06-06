local Current_Ride_Index = -1;
local INVALID_ID =-1;
local RIDE_TAB_TEXT = {};
local OtherRide_g_Ride;			--Æï³Ë¶ÔÏó
local OtherRide_g_EquipMask;

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
	
function OtherRide_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("TOGLE_OTHERRIDE_PAGE");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
end

function OtherRide_OnLoad()
	
	RIDE_TAB_TEXT = {
		[0] = "Ð°",
		"Nhân",
		"Blog",
		"Thú",
		"KÜ",
	};
	
	OtherRide_g_Ride = OtherRide_Equip;
	OtherRide_g_EquipMask = OtherRide_Equip_Mask;
end

-- OnEvent
function OtherRide_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 74130202 then
		Rider1Data = Get_XParam_INT(0);
		Rider2Data = Get_XParam_INT(1);
		
		if IsWindowShow("OtherRide") then
			OtherRide_Equip_Update();
		else
			OtherRide_OnShow();
			this:Show();
		end
	end
	
	if ( event == "TOGLE_OTHERRIDE_PAGE" ) then
	
		if(this:IsVisible()) then
			
			this:Hide();
			return;
		end
		
		local obj_id = CachedTarget:GetData("NPCID", 1)
		if (type(obj_id) ~="number") then
			PushDebugMessage ("#{JSCK_90507_1}")				-- ¾àÀë¸ÃÍæ¼ÒÌ«Ô¶£¬ÎÞ·¨²é¿´×ÊÁÏ¡£
			return
		end
		this:CareObject(obj_id , 1)

		OtherRide_OnShow();
		this:Show();
	end
	
	if( event == "PLAYER_LEAVE_WORLD") then
		this:Hide();
		return;
	end	
	return;		
end
function OtherRide_SetTabColor(idx)

end
function OtherRide_OnShow()
	OtherRide_Ride:SetCheck(1);
	local selfUnionPos = Variable:GetVariable("OtherUnionPos");
	if(selfUnionPos ~= nil) then
		OtherRide_Frame:SetProperty("UnifiedPosition", selfUnionPos);
	end
	OtherRide_FakeObject:SetFakeObject( "" );
	OtherRide_Equip_Update();

end
----------------------------------------------------------------------------------
--
-- Ñ¡×°Íæ¼ÒÄ£ÐÍ£¨Ïò×ó)
--
function OtherRide_Modle_TurnLeft(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--Ïò×óÐý×ª¿ªÊ¼
		if(start == 1) then
			OtherRide_FakeObject:RotateBegin(-0.3);
		--Ïò×óÐý×ª½áÊø
		else
			OtherRide_FakeObject:RotateEnd();
		end
	end
end

----------------------------------------------------------------------------------
--
-- Ñ¡×°Íæ¼ÒÄ£ÐÍ£¨ÏòÓÒ)
--
function OtherRide_Modle_TurnRight(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--ÏòÓÒÐý×ª¿ªÊ¼
		if(start == 1) then
			OtherRide_FakeObject:RotateBegin(0.3);
		--ÏòÓÒÐý×ª½áÊø
		else
			OtherRide_FakeObject:RotateEnd();
		end
	end
end



--===============================================
-- ´ò¿ªÍæ¼Ò×°±¸UI
--===============================================
function OtherRide_TargetEquip_Down()
	OtherRide_FakeObject:SetFakeObject( "" );
	Variable:SetVariable("OtherUnionPos", OtherRide_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenEquipFrame("other");
end

--===============================================
-- ´ò¿ªÍæ¼Ò×ÊÁÏUI
--===============================================
function OtherRide_TargetData_Down()
	OtherRide_FakeObject:SetFakeObject( "" );
	Variable:SetVariable("OtherUnionPos", OtherRide_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("other")
end
--===============================================
-- ´ò¿ªÍæ¼Ò²©¿ÍUI
--===============================================
function OtherRide_TargetBlog_Down()
	OtherRide_FakeObject:SetFakeObject( "" );
	Variable:SetVariable("OtherUnionPos", OtherRide_Frame:GetProperty("UnifiedPosition"), 1);

	local strCharName =  CachedTarget:GetData("NAME");
	local strAccount =  CachedTarget:GetData("ACCOUNTNAME")
	Blog:OpenBlogPage(strAccount,strCharName,false);
end

function OtherRide_OtherPet_Down()
	OtherRide_FakeObject:SetFakeObject( "" );
	Variable:SetVariable("OtherUnionPos", OtherRide_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPetFrame("other");
end

--Îä»ê

function OtherRide_TargetWuhun_Switch()
	OtherRide_FakeObject:SetFakeObject( "" );
	Variable:SetVariable("OtherUnionPos", OtherRide_Frame:GetProperty("UnifiedPosition"), 1);
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("ReceiveXscript")
	Set_XSCRIPT_ScriptID(741303)
	Set_XSCRIPT_Parameter(0,201)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT();
end

function OtherRide_OnHiden()
	OtherRide_FakeObject:SetFakeObject( "" );
	this:Hide();
end

function OtherRide_Equip_Click( buttonIn )
	local button = tonumber( buttonIn );
	if( button == 1 ) then
		OtherRide_g_Ride:DoAction();	--Æï³Ë
	else
		OtherRide_g_Ride:DoSubAction();	--Æï³Ë
	end
end


function OtherRide_Equip_Update()
	local RiderUsing = math.floor(Rider1Data/1000000);
	Rider1 = math.mod(math.floor(Rider1Data/1000),1000);
	Rider2 = math.mod(Rider1Data,1000);
	Rider3 = math.floor(Rider2Data/1000000);
	Rider4 = math.mod(math.floor(Rider2Data/1000),1000);
	Rider5 = math.mod(Rider2Data,1000);
	
	if Rider1 + Rider2 + Rider3 + Rider4 + Rider5 <= 0 then
		OtherRide_FakeObject:SetFakeObject("");
	end
	
	--if RiderUsing >= 1 and RiderUsing <= 5 then
	--	OtherRide_Selected(RiderUsing)
	--end
	
	if Rider1 ~= 0 then
		local Rider1ID = RiderID[Rider1-1][1];
		local Rider1Equip = GemCarve:UpdateProductAction(Rider1ID);
		OtherRide_Skill1:SetActionItem(Rider1Equip:GetID());
	else
		OtherRide_Skill1:SetActionItem(-1);
	end
	
	if Rider2 ~= 0 then
		local Rider2ID = RiderID[Rider2-1][1];
		local Rider2Equip = GemCarve:UpdateProductAction(Rider2ID);
		OtherRide_Skill2:SetActionItem(Rider2Equip:GetID());
	else
		OtherRide_Skill2:SetActionItem(-1);
	end
	
	if Rider3 ~= 0 then
		local Rider3ID = RiderID[Rider3-1][1];
		local Rider3Equip = GemCarve:UpdateProductAction(Rider3ID);
		OtherRide_Skill3:SetActionItem(Rider3Equip:GetID());
	else
		OtherRide_Skill3:SetActionItem(-1);
	end
	
	if Rider4 ~= 0 then
		local Rider4ID = RiderID[Rider4-1][1];
		local Rider4Equip = GemCarve:UpdateProductAction(Rider4ID);
		OtherRide_Skill4:SetActionItem(Rider4Equip:GetID());
	else
		OtherRide_Skill4:SetActionItem(-1);
	end
	
	if Rider5 ~= 0 then
		local Rider5ID = RiderID[Rider5-1][1];
		local Rider5Equip = GemCarve:UpdateProductAction(Rider5ID);
		OtherRide_Skill5:SetActionItem(Rider5Equip:GetID());
	else
		OtherRide_Skill5:SetActionItem(-1);
	end
	
	if RiderUsing >= 1 and RiderUsing <= 5 then
		OtherRide_Selected(RiderUsing)
	end
end

function OtherRide_Selected(Selection)
	nSelected = Selection;
	OtherRide_Skill1:SetPushed(0)
	OtherRide_Skill2:SetPushed(0)
	OtherRide_Skill3:SetPushed(0)
	OtherRide_Skill4:SetPushed(0)
	OtherRide_Skill5:SetPushed(0)
	
	if Selection == 1 then
		if Rider1 ~= 0 then
			OtherRide_Skill1:SetPushed(1)
			OtherRide_FakeObject:SetFakeObject("");
			--Player:SetHorseModel(Rider1-1);
			Target:SetHorseModel(Rider1-1);
			OtherRide_FakeObject:SetFakeObject("Other_Horse");
		end
	end
	
	if Selection == 2 then
		if Rider2 ~= 0 then
			OtherRide_Skill2:SetPushed(1)
			OtherRide_FakeObject:SetFakeObject("");
			--Player:SetHorseModel(Rider2-1);
			Target:SetHorseModel(Rider2-1);
			OtherRide_FakeObject:SetFakeObject("Other_Horse");
		end
	end
	
	if Selection == 3 then
		if Rider3 ~= 0 then
			OtherRide_Skill3:SetPushed(1)
			OtherRide_FakeObject:SetFakeObject("");
			--Player:SetHorseModel(Rider3-1);
			Target:SetHorseModel(Rider3-1);
			OtherRide_FakeObject:SetFakeObject("Other_Horse");
		end
	end
	
	if Selection == 4 then
		if Rider4 ~= 0 then
			OtherRide_Skill4:SetPushed(1)
			OtherRide_FakeObject:SetFakeObject("");
			--Player:SetHorseModel(Rider4-1);
			Target:SetHorseModel(Rider4-1);
			OtherRide_FakeObject:SetFakeObject("Other_Horse");
		end
	end
	
	if Selection == 5 then
		if Rider5 ~= 0 then
			OtherRide_Skill5:SetPushed(1)
			OtherRide_FakeObject:SetFakeObject("");
			--Player:SetHorseModel(Rider5-1);
			Target:SetHorseModel(Rider5-1);
			OtherRide_FakeObject:SetFakeObject("Other_Horse");
		end
	end
end
local g_nSelect_Index = -1;
local g_PreSelect = -1;
local g_PetIndex  = {};
local PET_MAX_NUMBER = 10	--◊Ó¥Û’‰ ﬁ–Ø¥¯…œœﬁ --add by xindefeng

--===============================================
-- OnLoad()
--===============================================
function PetList_PreLoad()

	this:RegisterEvent("OPEN_PET_LIST");
	this:RegisterEvent("REPLY_MISSION");
	this:RegisterEvent("REPLY_MISSION_PET");
	this:RegisterEvent("CLOSE_PET_LIST");
	this:RegisterEvent("CLOSE_PET_FRAME");
	this:RegisterEvent("CLOSE_MISSION_REPLY");
	this:RegisterEvent("OPEN_EXCHANGE_FRAME");
	this:RegisterEvent("TOGGLE_PETLIST");
	this:RegisterEvent("UPDATE_PET_LIST");
	this:RegisterEvent("UPDATE_PET_PAGE");
	this : RegisterEvent("DELETE_PET");

end

function PetList_OnLoad()

	for i=1 ,20   do
		g_PetIndex[i] = -1;
	end

end

--===============================================
-- OnEvent()
--===============================================
function PetList_OnEvent(event)
	--PushDebugMessage("PetList : "..event);

	-- ¥Úø™’‰ ﬁ¡–±ÌΩÁ√Ê
	if(event == "OPEN_PET_LIST") then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{1.0,-215}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,201}");

	-- ¥Úø™»ŒŒÒÃ·ΩªΩÁ√Ê
	elseif(event == "REPLY_MISSION") then
		this:Show();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,604}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,71}");
		PetList_UpdateFrame();

	-- ¥Úø™Ωª“◊ΩÁ√Ê
	elseif( event == "OPEN_EXCHANGE_FRAME" )  then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,588}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,1}");

	-- ∏¸–¬’‰ ﬁ¡–±ÌΩÁ√Ê
	elseif ( event == "UPDATE_PET_LIST" ) then
		PetList_UpdateFrame();

	-- ÕÊº“…Ì…œµƒ’‰ ﬁ ˝æ›∑¢…˙±‰ªØ£¨∞¸¿®’‰ ﬁ≥ˆ’Ω°¢–›œ¢°¢‘ˆº”“ª÷ª’‰ ﬁ
	elseif ( event == "UPDATE_PET_PAGE" ) then
		PetList_UpdateFrame();

	-- ÕÊº“¥”¡–±Ì—°∂®“ª÷ª’‰ ﬁ
	elseif(event == "REPLY_MISSION_PET") then
		PetList_UpdateFrame();

	-- ÕÊº“…Ì…œºı…Ÿ1÷ª’‰ ﬁ
	elseif (event == "DELETE_PET") then
		PetList_UpdateFrame();

	-- πÿ±’»ŒŒÒÃ·ΩªΩÁ√Ê
	elseif ( event == "CLOSE_MISSION_REPLY" ) then
		PetList_Refuse_Click();

	-- πÿ±’’‰ ﬁ¡–±ÌΩÁ√Ê
	elseif ( event == "CLOSE_PET_LIST" ) then
		PetList_Refuse_Click();

	elseif ( event == "CLOSE_PET_FRAME" ) then
		PetList_Refuse_Click();

	elseif ( event == "TOGGLE_PETLIST" ) then
--		this:TogleShow();

	end

end

--===============================================
-- ∏¸–¬ΩÁ√Ê
--===============================================
function PetList_UpdateFrame()

	-- œ»«Âø’µ±«∞¡–±Ì
	PetList_List:ClearListBox();

	local PetInListIndex = 0;
	for	i=0, PET_MAX_NUMBER-1 do	--modify by xindfeng	≤ªƒ‹”√µ±«∞’‰ ﬁµƒ ˝ƒø£¨“ÚŒ™÷–º‰µƒƒ≥–© ﬁ¿∏ø…ƒ‹Œ™ø’°£
		local szPetName,szOn = Pet:GetPetList_Appoint(i);
		local strToolTips = "";

		if(szPetName ~= "")   then
			-- ’‰ ﬁ≤ª‘⁄±≥∞¸¿Ô
			if ( szOn ~= "on_packa" ) then
				szPetName = "#c808080" .. szPetName;		-- ª“…´œ‘ æ
			end

			-- ’‰ ﬁ‘⁄±≥∞¸¿Ô£¨≤¢«““—æ≠Ã·ΩªµΩƒ≥ΩÁ√Ê
			--local nLocation = Pet:GetPetLocation(i)
			--if ( szOn == "on_packa" ) and ( nLocation ~= -1 ) then
			--	szPetName = "#G" .. szPetName;					-- ¬Ã…´œ‘ æ
			--end

			if(PlayerPackage:IsPetLock(i) == 1)    then
			  local nUnlockElapsedTime = PlayerPackage:GetPUnlockElapsedTime_Pet(i);
				if( nUnlockElapsedTime == 0 ) then
					szPetName = szPetName.. "  #-05";
					strToolTips =  "–„ khÛa" ;
				else
					szPetName = szPetName.. "  #-10";
					local strLeftTime = g_GetUnlockingStr(nUnlockElapsedTime);
					strToolTips = strLeftTime ;
				end
			end
			PetList_List:AddItem(szPetName, i);
			PetList_List:SetItemTooltip( PetInListIndex, strToolTips );
			PetInListIndex = PetInListIndex + 1 ;
		end
	end

end

--===============================================
-- —°‘Ò
--===============================================
function PetList_Choose_Click()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();
	if( g_nSelect_Index == -1 )  then
		return;
	end

	local NeedCheckLock = 1
	if 	IsWindowShow("PetLingXingUp")
		or IsWindowShow("PetSkillStudy")
		or IsWindowShow("PetSavvy")
		or IsWindowShow("PetSavvyGGD")
		or IsWindowShow("PetXingGe")
		or IsWindowShow("PetProcreate")
		or IsWindowShow("PetZhengYou")
		or IsWindowShow("PetFriendSearch")
		or IsWindowShow("PetLevelup")
		or IsWindowShow("PetStudyNewSkill")
		or IsWindowShow("PetPropagateCheck")
		or IsWindowShow("Pethuantong") then
		NeedCheckLock = 0
	end

	if IsWindowShow("PetHuanhua")  then
		NeedCheckLock = 0
	end

	if NeedCheckLock == 1 and PlayerPackage:IsPetLock(g_nSelect_Index) == 1 then
		PushDebugMessage("–„ thÍm khÛa væi Tr‚n Th˙")
		return;
	end

  if (IsWindowShow("Pethuantong")) then
    PushEvent("UI_COMMAND",20170121,g_nSelect_Index)
	elseif (IsWindowShow("PetLingXingUp")) then
    PushEvent("UI_COMMAND",20170122,g_nSelect_Index)
	elseif (IsWindowShow("PetHuanhua")) then
    PushEvent("UI_COMMAND",20170123,g_nSelect_Index)
  else
    Exchange:AddPet(g_nSelect_Index);
  end

end

--===============================================
-- ∑≈∆˙
--===============================================
function PetList_Refuse_Click()
	--if g_nSelect_Index ~= -1 then
	--	Pet:SetPetLocation(g_nSelect_Index,-1);
	--end
	this:Hide();
end

--===============================================
-- —°÷–¡–±Ì÷–µƒ’‰ ﬁ
--===============================================
function PetList_List_Selected()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();
end

--===============================================
--∏˘æ›—°‘Òµƒ’‰ ﬁ£¨œ‘ æœ‡”¶µƒœÍœ∏–≈œ¢
--===============================================
function PetList_ShowTargetPet()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();

	if( -1 == g_nSelect_Index ) then
		return;
	end
	Pet:ShowTargetPet(g_nSelect_Index);

end

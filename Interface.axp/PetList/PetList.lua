local g_nSelect_Index = -1;
local g_PreSelect = -1;
local g_PetIndex  = {};
local PET_MAX_NUMBER = 10	--最大珍兽携带上限 --add by xindefeng

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

	-- 打开珍兽列表界面
	if(event == "OPEN_PET_LIST") then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{1.0,-215}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,201}");

	-- 打开任务提交界面
	elseif(event == "REPLY_MISSION") then
		this:Show();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,604}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,71}");
		PetList_UpdateFrame();

	-- 打开交易界面
	elseif( event == "OPEN_EXCHANGE_FRAME" )  then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,588}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,1}");

	-- 更新珍兽列表界面
	elseif ( event == "UPDATE_PET_LIST" ) then
		PetList_UpdateFrame();

	-- 玩家身上的珍兽数据发生变化，包括珍兽出战、休息、增加一只珍兽
	elseif ( event == "UPDATE_PET_PAGE" ) then
		PetList_UpdateFrame();

	-- 玩家从列表选定一只珍兽
	elseif(event == "REPLY_MISSION_PET") then
		PetList_UpdateFrame();

	-- 玩家身上减少1只珍兽
	elseif (event == "DELETE_PET") then
		PetList_UpdateFrame();

	-- 关闭任务提交界面
	elseif ( event == "CLOSE_MISSION_REPLY" ) then
		PetList_Refuse_Click();

	-- 关闭珍兽列表界面
	elseif ( event == "CLOSE_PET_LIST" ) then
		PetList_Refuse_Click();

	elseif ( event == "CLOSE_PET_FRAME" ) then
		PetList_Refuse_Click();

	elseif ( event == "TOGGLE_PETLIST" ) then
--		this:TogleShow();

	end

end

--===============================================
-- 更新界面
--===============================================
function PetList_UpdateFrame()

	-- 先清空当前列表
	PetList_List:ClearListBox();

	local PetInListIndex = 0;
	for	i=0, PET_MAX_NUMBER-1 do	--modify by xindfeng	不能用当前珍兽的数目，因为中间的某些兽栏可能为空。
		local szPetName,szOn = Pet:GetPetList_Appoint(i);
		local strToolTips = "";

		if(szPetName ~= "")   then
			-- 珍兽不在背包里
			if ( szOn ~= "on_packa" ) then
				szPetName = "#c808080" .. szPetName;		-- 灰色显示
			end

			-- 珍兽在背包里，并且已经提交到某界面
			--local nLocation = Pet:GetPetLocation(i)
			--if ( szOn == "on_packa" ) and ( nLocation ~= -1 ) then
			--	szPetName = "#G" .. szPetName;					-- 绿色显示
			--end

			if(PlayerPackage:IsPetLock(i) == 1)    then
			  local nUnlockElapsedTime = PlayerPackage:GetPUnlockElapsedTime_Pet(i);
				if( nUnlockElapsedTime == 0 ) then
					szPetName = szPetName.. "  #-05";
					strToolTips =  "秀 kh骯" ;
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
-- 选择
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
		PushDebugMessage("秀 th阭 kh骯 v緄 Tr鈔 Th�")
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
-- 放弃
--===============================================
function PetList_Refuse_Click()
	--if g_nSelect_Index ~= -1 then
	--	Pet:SetPetLocation(g_nSelect_Index,-1);
	--end
	this:Hide();
end

--===============================================
-- 选中列表中的珍兽
--===============================================
function PetList_List_Selected()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();
end

--===============================================
--根据选择的珍兽，显示相应的详细信息
--===============================================
function PetList_ShowTargetPet()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();

	if( -1 == g_nSelect_Index ) then
		return;
	end
	Pet:ShowTargetPet(g_nSelect_Index);

end

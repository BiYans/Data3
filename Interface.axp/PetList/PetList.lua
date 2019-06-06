local g_nSelect_Index = -1;
local g_PreSelect = -1;
local g_PetIndex  = {};
local PET_MAX_NUMBER = 10	--�������Я������ --add by xindefeng

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

	-- �������б����
	if(event == "OPEN_PET_LIST") then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{1.0,-215}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,201}");

	-- �������ύ����
	elseif(event == "REPLY_MISSION") then
		this:Show();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,604}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,71}");
		PetList_UpdateFrame();

	-- �򿪽��׽���
	elseif( event == "OPEN_EXCHANGE_FRAME" )  then
		this:Show();
		PetList_UpdateFrame();
		PetList_Frame:SetProperty("UnifiedXPosition","{0.0,588}");
		PetList_Frame:SetProperty("UnifiedYPosition","{0.0,1}");

	-- ���������б����
	elseif ( event == "UPDATE_PET_LIST" ) then
		PetList_UpdateFrame();

	-- ������ϵ��������ݷ����仯���������޳�ս����Ϣ������һֻ����
	elseif ( event == "UPDATE_PET_PAGE" ) then
		PetList_UpdateFrame();

	-- ��Ҵ��б�ѡ��һֻ����
	elseif(event == "REPLY_MISSION_PET") then
		PetList_UpdateFrame();

	-- ������ϼ���1ֻ����
	elseif (event == "DELETE_PET") then
		PetList_UpdateFrame();

	-- �ر������ύ����
	elseif ( event == "CLOSE_MISSION_REPLY" ) then
		PetList_Refuse_Click();

	-- �ر������б����
	elseif ( event == "CLOSE_PET_LIST" ) then
		PetList_Refuse_Click();

	elseif ( event == "CLOSE_PET_FRAME" ) then
		PetList_Refuse_Click();

	elseif ( event == "TOGGLE_PETLIST" ) then
--		this:TogleShow();

	end

end

--===============================================
-- ���½���
--===============================================
function PetList_UpdateFrame()

	-- ����յ�ǰ�б�
	PetList_List:ClearListBox();

	local PetInListIndex = 0;
	for	i=0, PET_MAX_NUMBER-1 do	--modify by xindfeng	�����õ�ǰ���޵���Ŀ����Ϊ�м��ĳЩ��������Ϊ�ա�
		local szPetName,szOn = Pet:GetPetList_Appoint(i);
		local strToolTips = "";

		if(szPetName ~= "")   then
			-- ���޲��ڱ�����
			if ( szOn ~= "on_packa" ) then
				szPetName = "#c808080" .. szPetName;		-- ��ɫ��ʾ
			end

			-- �����ڱ���������Ѿ��ύ��ĳ����
			--local nLocation = Pet:GetPetLocation(i)
			--if ( szOn == "on_packa" ) and ( nLocation ~= -1 ) then
			--	szPetName = "#G" .. szPetName;					-- ��ɫ��ʾ
			--end

			if(PlayerPackage:IsPetLock(i) == 1)    then
			  local nUnlockElapsedTime = PlayerPackage:GetPUnlockElapsedTime_Pet(i);
				if( nUnlockElapsedTime == 0 ) then
					szPetName = szPetName.. "  #-05";
					strToolTips =  "�� kh�a" ;
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
-- ѡ��
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
		PushDebugMessage("�� th�m kh�a v�i Tr�n Th�")
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
-- ����
--===============================================
function PetList_Refuse_Click()
	--if g_nSelect_Index ~= -1 then
	--	Pet:SetPetLocation(g_nSelect_Index,-1);
	--end
	this:Hide();
end

--===============================================
-- ѡ���б��е�����
--===============================================
function PetList_List_Selected()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();
end

--===============================================
--����ѡ������ޣ���ʾ��Ӧ����ϸ��Ϣ
--===============================================
function PetList_ShowTargetPet()
	g_nSelect_Index = PetList_List:GetFirstSelectItem();

	if( -1 == g_nSelect_Index ) then
		return;
	end
	Pet:ShowTargetPet(g_nSelect_Index);

end

-- ÈÎÎñ¸ú×Ù   author£ºhouzhifang

local g_strWndName = "MissionTrack";

local g_dlgctrls = {}; --¿Ø¼þ¼¯ºÏ
local MissionPucker = {};
local g_nNowCheck = 0;   --0:³õÊ¼»¯£¬1:ÒÑ½ÓÈÎÎñ£¬2£º¿É½ÓÈÎÎñ
local g_LockState = 0;   --0:Î´Ëø¶¨£¬1£ºÒÑËø¶¨
local LEVEL_TO_MY_LEVEL = 10000;
local g_Temp_Mylevel = 1;

local g_DiFu_Scene_Id = 77; --µØ¸®³¡¾°ID
--TT53675¶ÔËùÓÐ²»·ûºÏ¹æ·¶£¬Ã»ÓÐ½«missionparamµÚ0Î»×öÎªÈÎÎñÍê³É±êÖ¾µÄÈÎÎñ½Å±¾×öÌØÊâ´¦Àí,ÐèÒªÌØÊâ´¦ÀíµÄÈÎÎñ½Å±¾ºÅÁÐ±í£º
local SpecialMissionList = {200006,200031}

function MissionTrack_PreLoad()
	this:RegisterEvent("OPEN_WINDOW");
	this:RegisterEvent("CLOSE_WINDOW");
	this:RegisterEvent("PACKAGE_ITEM_CHANGED");
	this:RegisterEvent("OPEN_MISSION_TRACK");
	this:RegisterEvent("UPDATE_MISSION_TRACK");
	this:RegisterEvent("UPDATE_WILLGET_MISSION_TRACK");

	this:RegisterEvent("TRACK_ALPHA_ACTION");
	this:RegisterEvent("UNIT_LEVEL"); --Íæ¼ÒÉý¼¶µÄÊ±ºò¸üÐÂ¿É½ÓÁÐ±í
	this:RegisterEvent("UI_COMMAND");
end

function MissionTrack_OnLoad()
	local i=1;
	for i=1,200 do
		MissionPucker[i] = 1;
	end;
	MissionTrack_Lock:Show();
	MissionTrack_UnLock:Hide();
	MissionTrack_ShowORHideFunc(0);
end

function MissionTrack_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 244001 then
		MissionTrack_ShowORHideFunc(0);
		MissionTrack_UpdateHaveGetMission(-1);
		this:Show();
	end
	if(event == "OPEN_WINDOW") then
		if( arg0 == "MissionTrack") then
			this:Show();
			MissionTrack_ShowORHideFunc(0);
			MissionTrack_UpdateHaveGetMission(-1);
			DataPool:UpdateTrackStateButton(0);
		end
	elseif(event == "CLOSE_WINDOW") then
		if( arg0 == "MissionTrack") then
			this:Hide();
		end
	elseif (event == "PACKAGE_ITEM_CHANGED") then
		if not this:IsVisible() then
			return;
		end
		if (g_nNowCheck == 1) then
			MissionTrack_UpdateHaveGetMission(-1);
		end
	elseif (event == "OPEN_MISSION_TRACK") then
		--local nMissionTrackShow = DataPool:IsTrackFuncShow(1);
		--if (nMissionTrackShow > 0) then
		--	AxTrace(0, 0, "11111111111111111");
			local nType = tonumber(arg0);
			if (nType == 1) then
				this:Show();
				MissionTrack_ShowORHideFunc(0);
				MissionTrack_UpdateHaveGetMission(-1);
				DataPool:UpdateTrackStateButton(0);
			end
		--end
	elseif (event == "UPDATE_MISSION_TRACK") then
		if not this:IsVisible() then
			return;
		end
		if (g_nNowCheck == 1) then
			local nSelect = tonumber(arg0)
			MissionTrack_UpdateHaveGetMission(nSelect);
		end
	elseif (event == "UPDATE_WILLGET_MISSION_TRACK" or event == "UNIT_LEVEL") then
		if not this:IsVisible() then
			return;
		end
		if (g_nNowCheck == 2) then
			MissionTrack_UpdateWillGet();
		end
	elseif (event == "TRACK_ALPHA_ACTION") then
		MissionTrack_SetAlpha(arg0)
	end
end

function MissionTrack_UpdateHaveGetMission(nSelectMissionID)
    local nMissionNum = DataPool:GetPlayerMission_Num();
    local i;

    HaveGetMissionNum = 0
    local color;

    for i=1, 20 do
        if (DataPool:GetPlayerMission_InUse(i-1) == 1) then
            DataPool:GetPlayerMission_Description(i-1);
        end
    end;

    --  ÒÑ½ÓÈÎÎñ·ÖÀà×Ü±í
    local Sequence_Assemble = {}

    --  ±äÁ¿ËùÓÐÀàÐÍµÄÒÑ½ÓÈÎÎñ, ·ÖÀàÅÅÐò²åÈë×Ü±í
    for j=1, 200 do
        local Sequence_OnefoldGenre = QuestLog_UpdateHaveGetMission( j, {} );
        table.sort(Sequence_OnefoldGenre,QuestLog_CompareTable)
        for i,n in ipairs(Sequence_OnefoldGenre) do
            table.insert(Sequence_Assemble,n)
        end
    end

    --  ½«ÒÑ½ÓÈÎÎñÊý¾Ý²åÈëÈÎÎñÁÐ±í
    local Per_Segment,xxxx,i,j;
    local xieziTrack = ""
    for i,Per_Segment in ipairs(Sequence_Assemble) do
        if Per_Segment[3] ~= "" then
            --MissionTrack_ListBoxTransparent:AddItem(Per_Segment[1],Per_Segment[2],Per_Segment[3])
            local strInfo,strDesc = DataPool:GetPlayerMission_Memo(Per_Segment[2]);
            xieziTrack = xieziTrack.."#cffcc00"..tostring(Per_Segment[1]).."#r#W"..strDesc.."#r"
        --else
            --MissionTrack_ListBoxTransparent : SetText("#H"..tostring(Per_Segment[1])..tostring(Per_Segment[2]).."")
        end
    end

            MissionTrack_ListBoxTransparent : ClearAllElement();
            MissionTrack_ListBoxTransparent : AddTextElement(xieziTrack) 

    --  Èç¹ûÃ»ÓÐÈÎÎñ, ÔòÈÎÎñÁÐ±íÏÔÊ¾Ïà¹ØÌáÊ¾
    --if(HaveGetMissionNum<1) then
    -- MissionTrack_ListBoxTransparent:AddTextElement("#HÃ»ÓÐÈÎºÎÈÎÎñ¡£")
    --end

    if First_Open == 1 then  --Ê×´Î´ò¿ª£¬Ñ¡ÖÐ×îºóÒ»¸ö
        First_Open = 0    
        Current_Select = HaveGetMissionNum - 1
    end
end

function MissionTrack_AddMissionTrackInfo(nMissionIndex, nMissionTrackType, nFinished)
	local nNewIndex = nMissionIndex+200;
	local color = "FFCCCCCC";
	local MissionParam_Index = 0;
	local strTarget = "";

	local strFinishNPC, strFinishSceneName, nFinishSceneID, nFinishX, nFinishY = DataPool:GetMissionFinishInfo(nMissionIndex);
	--PushDebugMessage(strFinishNPC);
	--PushDebugMessage(nFinished);
	if (nFinished == 1 and strFinishNPC ~= "") then       --ÒÑÍê³ÉµÄÈÎÎñ
		--if (strFinishNPC ~= "") then
			--local strTemp = string.format("   #WÈ¥#G%s#WÕÒ#R%s#{_INFOAIM%d,%d,%d,%s}#W", strFinishSceneName, strFinishNPC, nFinishX, nFinishY, nFinishSceneID, strFinishNPC);
			local strTemp = "";
			local nIndex = DataPool:GetPlayerMission_Display(nMissionIndex,7)--czf modify,2009.08.26
			if nIndex == 1018870 then
				strTemp = string.format("   #WÐªn #G%s#W tìm #R%s#W", strFinishSceneName, strFinishNPC);
			else
				strTemp = string.format("   #WÐªn #G%s#W tìm #R%s#{_INFOAIM%d,%d,%d,%s}", strFinishSceneName, strFinishNPC, nFinishX, nFinishY, nFinishSceneID, strFinishNPC);
			end
			strTarget = strTemp;
		--end
	else    --Î´Íê³ÉµÄÈÎÎñ
		--local nRound = DataPool:GetPlayerMission_Display(nMissionIndex,3);
		--if( nRound >= 0 ) then
		--	Mission_Variable = DataPool:GetPlayerMission_DataRound(nRound);
		--	if(Mission_Variable >= 0) then
		--		strTarget = "ÈÎÎñµ±Ç°»·Êý£º#W"..tostring(Mission_Variable);
		--	end
		--end
			--ÏÔÊ¾ÈÎÎñÒøÆ±ÊýÁ¿
		--if( DataPool:GetPlayerMission_Display(nMissionIndex,4) > 0 ) then
		--	Mission_Variable = DataPool:GetPlayerMission_Variable(nMissionIndex,MissionParam_Index);
		--	MissionParam_Index = MissionParam_Index + 1;

		--	if(Mission_Variable >0) then
		--		silverdesc = DataPool:GetPlayerMission_BillName(nMissionIndex);
		--		strTarget = "ÐèÒªµÃµ½½ðÇ®£º#W"..tostring(Mission_Variable);
		--	end
		--end

		local strAppend = "";
		local Mission_Variable = 0;
		--TT53675¶ÔËùÓÐ²»·ûºÏ¹æ·¶£¬Ã»ÓÐ½«missionparamµÚ0Î»×öÎªÈÎÎñÍê³É±êÖ¾µÄÈÎÎñ½Å±¾×öÌØÊâ´¦Àí
		local IsSpecial = 0
	    local nScriptId1 = DataPool:GetPlayerMission_Display(nMissionIndex,7)
	    for i, findId in SpecialMissionList do
		    if nScriptId1 == findId then
			     IsSpecial = 1
			     break
		    end
	   end
	   if nScriptId1>=1020000 and nScriptId1<=1029999 then --ËùÓÐµÄÌ½Ë÷Åä±íÈÎÎñ¶¼ÐèÒªÌØÊâ´¦Àí
	   	    IsSpecial = 1
	   end
	   if IsSpecial==0 then
		    MissionParam_Index = MissionParam_Index + 1;
		end
		--ÈÎÎñÐèÒªÉ±µÄnpc
		local nDemandKillNum,Kill_Random_Type = DataPool:GetPlayerMissionDemandKill_Num(nMissionIndex);
		if( nDemandKillNum > 0 ) then
			strAppend = "   #WÐã hÕ gøc:";
			for i=1, nDemandKillNum do
				--    ÐèÒªµÄNPC£¬ÐèÒªNPC ID£¬ÐèÒª¶àÉÙ¸ö
				local nNPCName, nNum = DataPool:GetPlayerMissionDemand_NPC(i-1,Kill_Random_Type,nMissionIndex);
				Mission_Variable = DataPool:GetPlayerMission_Variable(nMissionIndex,MissionParam_Index,Kill_Random_Type,i-1);
				MissionParam_Index = MissionParam_Index + 1;
				if (i == 1 and nDemandKillNum > 1) then
					strAppend = strAppend.."#W"..nNPCName..": "..tostring(Mission_Variable).."/"..tostring(nNum).."#r";
				elseif (i == 1 and nDemandKillNum == 1) then
					strAppend = strAppend.."#W"..nNPCName..": "..tostring(Mission_Variable).."/"..tostring(nNum);
				elseif( i == nDemandKillNum) then
					strAppend = strAppend.."#W            "..nNPCName..": "..tostring(Mission_Variable).."/"..tostring(nNum);
				else
					strAppend = strAppend.."#W            "..nNPCName..": "..tostring(Mission_Variable).."/"..tostring(nNum).."#r";
				end
				nNewIndex = nNewIndex + 1;
			end
		end

	--ÈÎÎñÐèÒªµÄÎïÆ·
		local nDemandNum,Item_Random_Type= DataPool:GetPlayerMissionDemand_Num(nMissionIndex);
		if( nDemandNum > 0 ) then
			if(Item_Random_Type == -100) then
				strAppend = "   #WÐã giao:";
				nNewIndex = nNewIndex + 1;
				Item_Random_Type = 0
			else
				strAppend = "   #WÐã ðÕt ðßþc:";
				nNewIndex = nNewIndex + 1;
			end
		end

		for i=1, nDemandNum do
			--    ÐèÒªµÄÀàÐÍ£¬ÐèÒªÎïÆ·ID£¬ÐèÒª¶àÉÙ¸ö
			local szName,nItemID, nNum = DataPool:GetPlayerMissionDemand_Item(i-1,Item_Random_Type,nMissionIndex);
			Mission_Variable = DataPool : GetPlayerMission_ItemCountNow(nItemID)

			if Mission_Variable > nNum then
				Mission_Variable = nNum
			end


			local Mission_Variable2 = DataPool:GetPlayerMission_Variable(nMissionIndex,0);
			if Mission_Variable2 > 0 then
				Mission_Variable = nNum
			end

			if (i == 1 and nDemandNum > 1) then
				strAppend = strAppend.."#W"..szName..":"..tostring(Mission_Variable).."/"..tostring(nNum).."#r";
			elseif(i == 1 and nDemandNum == 1) then
				strAppend = strAppend.."#W"..szName..":"..tostring(Mission_Variable).."/"..tostring(nNum);
			elseif(i == nDemandNum) then
				strAppend = strAppend.."#W            "..szName..":"..tostring(Mission_Variable).."/"..tostring(nNum);
			else
				strAppend = strAppend.."#W            "..szName..":"..tostring(Mission_Variable).."/"..tostring(nNum).."#r";
			end
		end

		--ÈÎÎñ×Ô¶¨ÒåµÄÎïÆ·
		local nCustomNum = DataPool:GetPlayerMissionCustom_Num(nMissionIndex);
		for i=1, nCustomNum do
			--    ÐèÒªµÄNPC£¬ÐèÒªNPC ID£¬ÐèÒª¶àÉÙ¸ö
			local strCustom, nNum = DataPool:GetPlayerMissionCustom(i-1);
			Mission_Variable = DataPool:GetPlayerMission_Variable(nMissionIndex,MissionParam_Index);
			AxTrace(0, 0, strCustom..tostring(Mission_Variable));
			MissionParam_Index = MissionParam_Index + 1;

			local strDot = "";
			if (i < nCustomNum) then
				strDot = "#r";
			end

			if nNum == 0 then
				strAppend = strAppend.."   " .. strCustom..strDot;
			else
				strAppend = strAppend.."   " .. strCustom .. " :  ".. Mission_Variable .. "/" .. nNum..strDot;

			end
		end

		--ÈÎÎñ×Ô¶¨ÒåµÄËæ»úÎïÆ· zzÌí¼Ó
		local nRandomCustomNum = DataPool:GetPlayerMissionRandomCustom_Num(nMissionIndex);
		for i=1,nRandomCustomNum do
			local strCustom, nNeedNum,nCompleteNum = DataPool:GetPlayerMissionRandomCustom(i-1,nMissionIndex);

			local strDot = "";
			if (i < nCustomNum) then
				strDot = "#r";
			end

			if nNeedNum == 0 then
				strAppend = strAppend..strCustom..strDot;
			else
				strAppend = strAppend..strCustom .. " :  ".. nCompleteNum .. "/" .. nNeedNum..strDot;
			end
		end


		local strTemp = "";
		strTarget = "";
		if (nMissionTrackType == 1) then   --½Å±¾ÈÎÎñ£¬Ö±½Ó¶ÁÈ¡ÈÎÎñ¸ú×ÙÐÅÏ¢
			strTarget = DataPool:GetLuaMissionTrackInfo(nMissionIndex);
			if (strAppend ~= "") then
				strTarget = "   #W" .. strTarget.."#r#W"..strAppend;
			else
				strTarget = "   #W" .. strTarget;
			end
		elseif(nMissionTrackType == 2) then   --±í¸ñËÍÎïÈÎÎñ£¬¸ù¾Ý²»Í¬ÀàÐÍ½øÐÐÎÄ×ÖÆ¥Åä
			local strNPCName, strSceneName, nTargetScene, nPosX, nPosY = DataPool:GetDeliveryMissionTrackInfo(nMissionIndex);
			if (strNPCName ~= "") then
				-- Ó¢ÐÛÈÎÎñ¶ÔÓ¦ ³¡¾°Îª-1
				local strTemp = "";
				if(nTargetScene ~= -1) then
					--strTemp = string.format("   #WÈ¥#G%s#WÕÒ#R%s#{_INFOAIM%d,%d,%d,%s}#W", strSceneName, strNPCName, nPosX, nPosY, nTargetScene, strNPCName);
					local nIndex = DataPool:GetPlayerMission_Display(nMissionIndex,7)--czf modify,2009.08.26
					if nIndex == 1018870 then
						strTemp = string.format("   #WÐªn #G%s#W tìm #R%s#W", strSceneName, strNPCName);
					else
						strTemp = string.format("   #WÐªn #G%s#W tìm #R%s#{_INFOAIM%d,%d,%d,%s}", strSceneName, strNPCName, nPosX, nPosY, nTargetScene, strNPCName);
					end
				else
					strTemp = string.format("   #WÐªn #G%s#W tìm #R%s#W", strSceneName, strNPCName);
				end
				strTarget = strTarget .. strTemp .. "#r";
			end
			if (strAppend ~= "") then
				strTarget = strTarget .. strAppend;
			end
		elseif(nMissionTrackType == 3) then   --±í¸ñÅäÖÃÉ±¹ÖÈÎÎñ
			local nMonsterNum = DataPool:GetKillMonsterMissionTrackInfo_num(nMissionIndex);
			if (nMonsterNum > 0) then
				for nn = 1, nMonsterNum do
					local strMonsterName, strSceneName, nSceneId, nCount, nXpos, nYpos = DataPool:GetKillMonsterMissionTrackInfo_MonsterInfo(nMissionIndex, nn-1);
					if(strMonsterName ~= "") then
						local strTemp = "";
						if(nSceneId ~= -1) then
							 strTemp = string.format("   #WÐªn #G%s#W giªt #R%s#{_INFOAIM%d,%d,%d,%s}#W", tostring(strSceneName),tostring(strMonsterName), tonumber(nXpos), tonumber(nYpos), tonumber(nSceneId), tostring(strMonsterName));
						else
							 strTemp = string.format("   #WÐªn #G%s#W giªt #R%s#W", tostring(strSceneName),tostring(strMonsterName));
						end
						strTarget = strTarget .. strTemp;
						strTarget = strTarget .. "#r";
					end
				end
			end
			if (strAppend ~= "") then
				strTarget = strTarget .. strAppend;
			end
		elseif(nMissionTrackType == 4) then
			local nLootItemNum = DataPool:GetLootItemMissionTrackInfo_num(nMissionIndex);
			if(nLootItemNum > 0) then
				for nn = 1, nLootItemNum do
					local strMonsterName, strSceneName, strItemName, nSceneID, nItemNum, xPos, yPos = DataPool:GetLootItemMissionTrackInfo_ItemInfo(nMissionIndex, nn-1);
					if (strMonsterName ~= "") then
						local strTemp = "";
						if(nSceneID ~= -1) then
							 strTemp = string.format("   #WÐªn #G%s#W giªt #R%s#{_INFOAIM%d,%d,%d,%s}#W", strSceneName, strMonsterName, xPos, yPos, nSceneID, strMonsterName);
						else
							 strTemp = string.format("   #WÐªn #G%s#W giªt #R%s#W", strSceneName, strMonsterName);
						end
						strTarget = strTarget .. strTemp;
						strTarget = strTarget .. "#r";
					end
				end
			end
			if (strAppend ~= "") then
				strTarget = strTarget .. strAppend;
			end
		elseif (nMissionTrackType == 6) then
			local strObjName, strTargetNPC, strTargetScene, nTargetScene, xPos, yPos = DataPool:GetHusongMissionTrackInfo(nMissionIndex);
			if (strObjName ~= "") then
				local strTemp = "";
				if(nTargetScene ~= -1) then
					strTemp = string.format("   #WÐªn %s tìm #R%s#{_INFOAIM%d,%d,%d,%s}#W#r",strTargetScene, strTargetNPC, xPos, yPos, nTargetScene, strTargetNPC);
				else
					strTemp = string.format("   #WÐªn %s tìm #R%s#W",strTargetScene, strTargetNPC);
				end
				strTarget = strTarget .. strTemp;
			end
			if (strAppend ~= "") then
				strTarget = strTarget .. strAppend;
			end
		end
	end

	MissionTrack_ListBoxTransparent:AddItemExWithoutLayout(strTarget, nMissionIndex, 0, color, 4);
end

function MissionTrack_UpdateWillGet()

	MissionTrack_HaveGet:SetCheck(0);
	MissionTrack_WillGet:SetCheck(1);
	g_nNowCheck = 2;

	local nMyLevel = Player:GetData( "LEVEL" )
	MissionTrack_ListBoxTransparent:ClearListBoxEx();

	CollectMissionOutline();

	for iMissionType=1,200 do             --ÏÖÈÎÎñÀàÐÍÒ»¹²200ÖÖ
	    local strOutlineName = "#cff9900" .. DataPool:GetMissionInfo_Kind( iMissionType );  --#gFE7E82

		if( strOutlineName ~= "" or strOutlineName ~= 0) then
	   		local iStart = iMissionType*10000;
	    	local DeployNum = GetMissionOutlineNum( iMissionType )
	   		if( DeployNum > 0 and iMissionType ~= 50) then       --°ï»á³ÇÊÐÈÎÎñ£¬ÕâÀï²»ÒªÁË
	        	local OutLineMission_Seq = {};
	        	local i = 1;
				for i=1, DeployNum do
				    local color= "";
					local MissionLevel, MinLevel, MaxLevel, strNpcName, strNpcPos, strScene, strMissionName, PosX, PosY, SceneID = GetMissionOutlineInfo( iMissionType, i );
					if( MissionLevel - nMyLevel <= 5 and MissionLevel >= nMyLevel -3) then
						local strInfo = "";
						strInfo = " #Y("..MissionLevel..")"..strMissionName;   --ÈÎÎñÃû
						table.insert(OutLineMission_Seq,strInfo)
						--MissionTrack_ListBoxTransparent:AddItemExWithoutLayout( strInfo, (iStart+i), 0);
						strInfo = "";
	    				strNpcPos = "#{_INFOAIM"..(PosX)..","..(PosY)..","..(SceneID)..","..(strNpcName).."}";
	    				if strScene and strScene ~= "" then
	    					strInfo = strInfo.."   #G"..strScene.."  #R"..strNpcName..strNpcPos;
	    				else
	    					strInfo = strInfo.."   #R"..strNpcName..strNpcPos
	    				end
						table.insert(OutLineMission_Seq,strInfo)        --ÈÎÎñ×·×ÙÐÅÏ¢
					end
				end

				if (table.getn(OutLineMission_Seq) > 0) then
					MissionTrack_ListBoxTransparent:AddItemExWithoutLayout( strOutlineName, iStart, 0 )
					local nn = 1;
					color = "FFD9F80A";	--»ÆÉ«
					for nn,Per_Seq in ipairs(OutLineMission_Seq) do
						MissionTrack_ListBoxTransparent:AddItemExWithoutLayout( Per_Seq, (iStart+nn), 0, color, 4);
					end
				end
	    	end
		end
	end
	MissionTrack_ListBoxTransparent:RequestLayout();
end

function MissionTrack_CloseFunc()
	this:Hide();
	--DataPool:SetTrackFuncShow(1, 0);
	--DataPool:UpdateTrackStateButton(0);
end

function MissionTrack_HaveGetFunc()
	MissionTrack_HaveGet:SetCheck(1);
	MissionTrack_WillGet:SetCheck(0);
	if(g_nNowCheck ~= 1) then
		MissionTrack_UpdateHaveGetMission(-1);
	end
end

function MissionTrack_WillGetFunc()
	PushDebugMessage("ChÑc nång Chßa m·")
	--MissionTrack_HaveGet:SetCheck(0);
	--MissionTrack_WillGet:SetCheck(1);
	--if(g_nNowCheck ~= 2) then
	--	MissionTrack_UpdateWillGet();
	--end
end

function MissionTrack_ItemContextClickedForEye()
	local curSceneID = GetSceneID();
	if (curSceneID == g_DiFu_Scene_Id) then
			return
	end

	local nClickedItemInx = MissionTrack_ListBoxTransparent:GetClickedButtonItem();
	DataPool:MissionTrackGotoQuestLog(nClickedItemInx);
end

function MissionTrack_ItemContextClickedForClose()
	local nClickedItemInx = MissionTrack_ListBoxTransparent:GetClickedButtonItem();
	DataPool:SetMissionTrackOpen(nClickedItemInx, 0);
	MissionTrack_UpdateHaveGetMission(-1);
	DataPool:UpdateQuestLogByTrack();
end

function MissionTrack_On_Height_Add()
	local nHeightOld = MissionTrack_Frame:GetProperty("AbsoluteHeight");
	local nListTopOld = MissionTrack__Frame:GetProperty("AbsoluteYPosition");
	local nHeightOld2 = MissionTrack__Frame:GetProperty("AbsoluteHeight");
	local nFunctionTopOld = MissionTrack_Function_Frame:GetProperty("AbsoluteYPosition");
	if (tonumber(nHeightOld) < 379) then
		MissionTrack_Frame:SetProperty("AbsoluteHeight", nHeightOld+17);
		MissionTrack__Frame:SetProperty("AbsoluteHeight", nHeightOld2+17);
		MissionTrack__Frame:SetProperty("AbsoluteYPosition", nListTopOld);
		MissionTrack_Function_Frame:SetProperty("AbsoluteYPosition", nFunctionTopOld);
	end
end

function MissionTrack_On_Height_Reduce()
	local nHeightOld = MissionTrack_Frame:GetProperty("AbsoluteHeight");
	local nListTopOld = MissionTrack__Frame:GetProperty("AbsoluteYPosition");
	local nHeightOld2 = MissionTrack__Frame:GetProperty("AbsoluteHeight");
	local nFunctionTopOld = MissionTrack_Function_Frame:GetProperty("AbsoluteYPosition");
	if (tonumber(nHeightOld) > 158) then
		MissionTrack_Frame:SetProperty("AbsoluteHeight", nHeightOld-17);
		MissionTrack__Frame:SetProperty("AbsoluteYPosition", nListTopOld);
		MissionTrack__Frame:SetProperty("AbsoluteHeight", nHeightOld2-17);
		MissionTrack_Function_Frame:SetProperty("AbsoluteYPosition", nFunctionTopOld);
	end
end

function MissionTrack_On_Width_Add()
	--MissionTrack_Frame_Context:SetProperty("Alpha", "10");

	local nWidthOld = MissionTrack_Frame:GetProperty("AbsoluteWidth");
	local nFrameLeftOld = MissionTrack_Frame:GetProperty("AbsoluteXPosition");
	local nCheckBoxX = MissionTrack_CheckBox_Frame:GetProperty("AbsoluteXPosition");
	local nDragX = MissionTrack_DragTitle:GetProperty("AbsoluteXPosition");
	local nCloseX = MissionTrack_Close:GetProperty("AbsoluteXPosition");
	local nWidthOld2 = MissionTrack__Frame:GetProperty("AbsoluteWidth");
	local nFuncLeft = MissionTrack_Function_Frame:GetProperty("AbsoluteXPosition");
	local nLockX = MissionTrack_Lock:GetProperty("AbsoluteXPosition");
	if (tonumber(nWidthOld) < 310) then
		MissionTrack_Frame:SetProperty("AbsoluteWidth", nWidthOld + 10);
		MissionTrack_Frame:SetProperty("AbsoluteXPosition", nFrameLeftOld-10);
		MissionTrack_CheckBox_Frame:SetProperty("AbsoluteXPosition", nCheckBoxX + 10);
		MissionTrack_DragTitle:SetProperty("AbsoluteXPosition", nDragX + 10);
		MissionTrack_Close:SetProperty("AbsoluteXPosition", nCloseX + 10);
		MissionTrack__Frame:SetProperty("AbsoluteWidth", nWidthOld2 + 10);
		MissionTrack_Function_Frame:SetProperty("AbsoluteXPosition", nFuncLeft + 10);
		MissionTrack_Lock:SetProperty("AbsoluteXPosition", nLockX + 10);
		MissionTrack_UnLock:SetProperty("AbsoluteXPosition", nLockX + 10);
	end
end

function MissionTrack_On_Width_Reduce()
	local nWidthOld = MissionTrack_Frame:GetProperty("AbsoluteWidth");
	local nFrameLeftOld = MissionTrack_Frame:GetProperty("AbsoluteXPosition");
	local nCheckBoxX = MissionTrack_CheckBox_Frame:GetProperty("AbsoluteXPosition");
	local nDragX = MissionTrack_DragTitle:GetProperty("AbsoluteXPosition");
	local nCloseX = MissionTrack_Close:GetProperty("AbsoluteXPosition");
	local nWidthOld2 = MissionTrack__Frame:GetProperty("AbsoluteWidth");
	local nFuncLeft = MissionTrack_Function_Frame:GetProperty("AbsoluteXPosition");
	local nLockX = MissionTrack_Lock:GetProperty("AbsoluteXPosition");
	if (tonumber(nWidthOld) > 230) then
		MissionTrack_Frame:SetProperty("AbsoluteWidth", nWidthOld - 10);
		MissionTrack_Frame:SetProperty("AbsoluteXPosition", nFrameLeftOld+10);
		MissionTrack_CheckBox_Frame:SetProperty("AbsoluteXPosition", nCheckBoxX - 10);
		MissionTrack_DragTitle:SetProperty("AbsoluteXPosition", nDragX - 10);
		MissionTrack_Close:SetProperty("AbsoluteXPosition", nCloseX - 10);
		MissionTrack__Frame:SetProperty("AbsoluteWidth", nWidthOld2 - 10);
		MissionTrack_Function_Frame:SetProperty("AbsoluteXPosition", nFuncLeft - 10);
		MissionTrack_Lock:SetProperty("AbsoluteXPosition", nLockX - 10);
		MissionTrack_UnLock:SetProperty("AbsoluteXPosition", nLockX - 10);
	end
end

function MissionTrack_On_Lock()

	if (g_LockState == 0) then   --×¼±¸Ëø¶¨
		g_LockState = 1;
		MissionTrack_UnLock:Show();
		MissionTrack_Lock:Hide();
		MissionTrack_HaveGet:SetProperty("MouseHollow", "True");
		MissionTrack_WillGet:SetProperty("MouseHollow", "True");
		MissionTrack_Close:SetProperty("MouseHollow", "True");
		MissionTrack_Frame:SetProperty("MouseHollow", "True");
		MissionTrack_DragTitle:SetProperty("MouseHollow", "True");
		MissionTrack_Function_Frame:SetProperty("MouseHollow", "True");
		MissionTrack_Height_Add:SetProperty("MouseHollow", "True");
		MissionTrack_Height_Reduce:SetProperty("MouseHollow", "True");
		MissionTrack_Width_Add:SetProperty("MouseHollow", "True");
		MissionTrack_Width_Reduce:SetProperty("MouseHollow", "True");
		MissionTrack_Reset:SetProperty("MouseHollow", "True");
	else               --½âËø
		g_LockState = 0;
		MissionTrack_Lock:Show();
		MissionTrack_UnLock:Hide();
		MissionTrack_HaveGet:SetProperty("MouseHollow", "False");
		MissionTrack_WillGet:SetProperty("MouseHollow", "False");
		MissionTrack_Close:SetProperty("MouseHollow", "False");
		MissionTrack_Frame:SetProperty("MouseHollow", "False");
		MissionTrack_DragTitle:SetProperty("MouseHollow", "False");
		MissionTrack_Function_Frame:SetProperty("MouseHollow", "False");
		MissionTrack_Height_Add:SetProperty("MouseHollow", "False");
		MissionTrack_Height_Reduce:SetProperty("MouseHollow", "False");
		MissionTrack_Width_Add:SetProperty("MouseHollow", "False");
		MissionTrack_Width_Reduce:SetProperty("MouseHollow", "False");
		MissionTrack_Reset:SetProperty("MouseHollow", "False");
	end
	MissionTrack_ShowORHideFunc(0);

end

function MissionTrack_On_Reset()

	MissionTrack_Frame:SetProperty("UnifiedSize", "{{0,230},{0.0,158}}");
	MissionTrack_Frame:SetProperty("UnifiedXPosition", "{1.0,-266}");
	MissionTrack_Frame:SetProperty("UnifiedYPosition", "{0.0,228}");

	MissionTrack__Frame:SetProperty("AbsolutePosition", "x:0.000000 y:17.000000");
	MissionTrack__Frame:SetProperty("AbsoluteSize", "w:212.000000 h:139.000000");

	MissionTrack_Function_Frame:SetProperty("AbsolutePosition", "x:211.0 y:17.0");

	MissionTrack_DragTitle:SetProperty("AbsolutePosition", "x:80.000000 y:0.000000");
	MissionTrack_Close:SetProperty("AbsolutePosition", "x:196.000000 y:0.000000");
	MissionTrack_CheckBox_Frame:SetProperty("AbsolutePosition", "x:0.0 y:0.0");
	MissionTrack_Lock:SetProperty("AbsolutePosition", "x:180.000000 y:0.000000");
	MissionTrack_UnLock:SetProperty("AbsolutePosition", "x:180.000000 y:0.000000");
end

function MissionTrack_Func_MouseEnter()
	MissionTrack_ShowORHideFunc(1);
end

function MissionTrack_Func_MouseLeave()
	MissionTrack_ShowORHideFunc(0);
end

function MissionTrack_ShowORHideFunc( nShow )

	if (nShow >= 1 and g_LockState == 0) then
		MissionTrack_Height_Add:Show();
		MissionTrack_Height_Reduce:Show();
		MissionTrack_Width_Add:Show();
		MissionTrack_Width_Reduce:Show();
		MissionTrack_Reset:Show();
	else
		MissionTrack_Height_Add:Hide();
		MissionTrack_Height_Reduce:Hide();
		MissionTrack_Width_Add:Hide();
		MissionTrack_Width_Reduce:Hide();
		MissionTrack_Reset:Hide();
	end
end


function MissionTrack_SetAlpha(val)
	local bNum = val
	if tonumber(bNum) < 0.3 then
		MissionTrack_Frame:SetProperty( "Alpha", "0.5" );
		MissionTrack_Function_Frame:SetProperty( "Alpha", "0.5" );
		MissionTrack_ListBoxTransparent:SetVScrollbarAlpha("0.3");
	elseif tonumber(bNum) < 0.5 then
		MissionTrack_Frame:SetProperty( "Alpha", "0.5" );
		MissionTrack_Function_Frame:SetProperty( "Alpha", "0.5" );
		MissionTrack_ListBoxTransparent:SetVScrollbarAlpha(val);
	else
		MissionTrack_Frame:SetProperty( "Alpha", val );
		MissionTrack_Function_Frame:SetProperty( "Alpha", val );
		MissionTrack_ListBoxTransparent:SetVScrollbarAlpha(val);
	end
	MissionTrack_Frame_Context:SetProperty( "Alpha", val );
end

--TT53675¶ÔËùÓÐ²»·ûºÏ¹æ·¶£¬Ã»ÓÐ½«missionparamµÚ0Î»×öÎªÈÎÎñÍê³É±êÖ¾µÄÈÎÎñ½Å±¾×öÌØÊâ´¦Àí£¬ÅÐ¶ÏÈÎÎñÊÇ·ñÍê³É
function IsMissionSuccess(nSelIndex)
       local MissionParam_Index = 0
       local Mission_Variable = 0
--ÈÎÎñÐèÒªÉ±µÄnpc
		local nDemandKillNum,Kill_Random_Type = DataPool:GetPlayerMissionDemandKill_Num(nSelIndex);
		if( nDemandKillNum > 0 ) then
			for i=1, nDemandKillNum do
				--    ÐèÒªµÄNPC£¬ÐèÒªNPC ID£¬ÐèÒª¶àÉÙ¸ö
				local nNPCName, nNum = DataPool:GetPlayerMissionDemand_NPC(i-1,Kill_Random_Type,nSelIndex);
				Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index,Kill_Random_Type,i-1);
				MissionParam_Index = MissionParam_Index + 1;
				if Mission_Variable < nNum then
					return 0
				end
			end
		end

--ÈÎÎñÐèÒªµÄÎïÆ·
		local nDemandNum,Item_Random_Type= DataPool:GetPlayerMissionDemand_Num(nSelIndex);
		if( nDemandNum > 0 ) then
			for i=1, nDemandNum do
				--    ÐèÒªµÄÀàÐÍ£¬ÐèÒªÎïÆ·ID£¬ÐèÒª¶àÉÙ¸ö
				local szName,nItemID, nNum = DataPool:GetPlayerMissionDemand_Item(i-1,Item_Random_Type,nSelIndex);
				Mission_Variable = DataPool : GetPlayerMission_ItemCountNow(nItemID)
				 if Mission_Variable < nNum then
					return 0
				 end
			 end
		 end

-----------------------------------------------------------------------------------
--ÈÎÎñ×Ô¶¨ÒåµÄÎïÆ·
		local nCustomNum = DataPool:GetPlayerMissionCustom_Num(nSelIndex);
		if( nCustomNum > 0 ) then
			for i=1, nCustomNum do
				--    ÐèÒªµÄNPC£¬ÐèÒªNPC ID£¬ÐèÒª¶àÉÙ¸ö
				local strCustom, nNum = DataPool:GetPlayerMissionCustom(i-1);
				Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index);
				MissionParam_Index = MissionParam_Index + 1;
				if Mission_Variable < nNum then
				    return 0
				end
			end
		end

-----------------------------------------------------------------------------------

--ÈÎÎñ×Ô¶¨ÒåµÄËæ»úÎïÆ· zzÌí¼Ó

	local nRandomCustomNum = DataPool:GetPlayerMissionRandomCustom_Num(nSelIndex);
	if( nRandomCustomNum > 0 ) then
		for i=1,nRandomCustomNum do
			local strCustom, nNeedNum,nCompleteNum = DataPool:GetPlayerMissionRandomCustom(i-1,nSelIndex);
			if nCompleteNum < nNeedNum then
				return 0
			end
		end
	end

	return 1
end

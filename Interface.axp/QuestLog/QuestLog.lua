local bBeingRadio = 0;                  --
--local MissionType = {};               --  ·ÏÆú, ¶øÇÒ»¹¼ÌĞø±»ÖØ¶¨Òå, ±ÜÃâ´íÎó, ÔÚ´ËÈ¡Ïû¶¨Òå
local MissionPucker = {};               --  ÒÑ½ÓÈÎÎñµÄPhútÀàÕÛµş±êÖ¾, 1: ·ÇÕÛµş, 0: ÕÛµş
local Current_Select;                   --  µ±Ç°Ñ¡ÔñÈÎÎñ
local First_Open = 1;                   --  Ê×´Î´ò¿ª?
local MissionParam_Index = 0;           --  ÈÎÎñ±äÁ¿Ë÷Òı
local HaveGetMissionNum = 0;            --  ÒÑ½ÓÈÎÎñÊıÁ¿

local LEVEL_TO_MY_LEVEL = 10000;        --  ÓëÍæ¼ÒµÈ¼¶Ò»ÖÂµÄÈÎÎñµÈ¼¶

local g_nMissionNum = 20;               --  ×î´ó¿É½ÓÈÎÎñÊı

local MissionOutlineDeploy = {}         --  Î´½ÓÈÎÎñµÄPhútÀàÕÛµş±êÖ¾, 1: ·ÇÕÛµş, 0: ÕÛµş

local CurList                           -- 1ÎªÈÎÎñÁĞ±í,2ÎªÈÎÎñË÷Òı

local Current_Clicked = -1;
--TT53675¶ÔËùÓĞ²»·ûºÏ¹æ·¶£¬Ã»ÓĞ½«missionparamµÚ0Î»×öÎªÈÎÎñTrä±êÖ¾µÄÈÎÎñ½Å±¾×öÌØÊâ´¦Àí,ĞèÒªÌØÊâ´¦ÀíµÄÈÎÎñ½Å±¾ºÅÁĞ±í:
local SpecialMissionList = {200006,200031}

-- ½çÃæµÄÄ¬ÈÏÏà¶ÔÎ»ÖÃ
local g_QuestLog_Frame_UnifiedXPosition;
local g_QuestLog_Frame_UnifiedYPosition;

local g_QuestLog_LastSelect=-1;                   --  µ±Ç°Ñ¡ÔñÈÎÎñ

local g_MenPai_Special_id = 0

--  ½çÃæÔ¤¼ÓÔØ...
function QuestLog_PreLoad()
    this:RegisterEvent("TOGLE_MISSION");
    this:RegisterEvent("UPDATE_MISSION");
    this:RegisterEvent("PACKAGE_ITEM_CHANGED");
    this:RegisterEvent("UPDATE_DOUBLE_EXP");
    this:RegisterEvent("UPDATE_QUESTTIME");
    this:RegisterEvent("NEW_MISSION");
    this:RegisterEvent("DELETE_MISSION");
    this:RegisterEvent("TOGLE_MISSION_OUTLINE");
    this:RegisterEvent("UI_COMMAND")
    this:RegisterEvent("OPEN_FROM_MISSIONTRACK");
    this:RegisterEvent("UPDATE_QUESTLOG_BY_TRACK");
    this:RegisterEvent("UPDATE_TRACK_STATE_BUTTON");

    -- ÓÎÏ·´°¿Ú³ß´ç·¢ÉúÁË±ä»¯
    this:RegisterEvent("ADJEST_UI_POS")

    -- ÓÎÏ·Phút±æÂÊ·¢ÉúÁË±ä»¯
    this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

--  ½çÃæÊ×´Î¼ÓÔØ³õÊ¼»¯, ËùÓĞÈÎÎñÀàĞÍÕÛµş±êÖ¾ÎªÕ¹¿ª, ¼ÇÂ¼½çÃæµÄ³õÊ¼Î»ÖÃ
function QuestLog_OnLoad()

    local i=1;
    for i=1,200 do
        MissionPucker[i] = 1;
    end;

    for i=1,200 do
        MissionOutlineDeploy[ i ] = 1  --ÈÎÎñË÷ÒıÄ¬ÈÏ¶¼ÎªÕ¹¿ª
    end

    First_Open = 1;
    CurList = 1

    -- ±£´æ½çÃæµÄÄ¬ÈÏÏà¶ÔÎ»ÖÃ
    g_QuestLog_Frame_UnifiedXPosition    = QuestLog_Frame : GetProperty("UnifiedXPosition");
    g_QuestLog_Frame_UnifiedYPosition    = QuestLog_Frame : GetProperty("UnifiedYPosition");

end

--  ½çÃæÊÂ¼ş´¦Àí
--  ÒòÎªÍ¬Ò»Ê±¿ÌÖ»»áÓĞÒ»¸öÊÂ¼ş, Òò´Ë²»ÓÃ´¦Àí¶à¸öifµÄÇé¿ö
function QuestLog_OnEvent(event)
--    if(this:IsVisible()) then
--        QuestLog_OnShown();
--        return;
--    end

    --PushDebugMessage("event = " .. event)

	g_MenPai_Special_id = 0

    if(event == "UI_COMMAND" and tonumber(arg0) == 831020) then
        QuestLog_UpdateListbox();
        QuestLog_UpdateMissionOutline();
        QuestLog_ShowWindow();
    elseif(event == "TOGLE_MISSION" or (event == "UI_COMMAND" and tonumber(arg0) == 110921)) then
		if tonumber(arg0) == 110921 then
			g_MenPai_Special_id = 1
		end

        QuestLog_UpdateListbox();
        QuestLog_ShowWindow();
    elseif(event == "TOGLE_MISSION_OUTLINE" ) then
        QuestLog_UpdateMissionOutline();
        QuestLog_ShowWindow();
    elseif(event == "UPDATE_MISSION" ) then
        if not this:IsVisible() then
            return;
        end
        if (CurList == 1) then
            QuestLog_UpdateListbox();
        end
    elseif(event == "PACKAGE_ITEM_CHANGED" ) then
        if not this:IsVisible() then
            return;
        end
        if CurList == 1 then
            QuestLog_UpdateListbox();
        end
    elseif(event == "UPDATE_DOUBLE_EXP" ) then
        local DT = SystemSetup : GetDoubleExp("remaintime");
        QuestLog_Watch:SetProperty("Timer",DT);
    elseif(event == "UPDATE_QUESTTIME") then
        if not this:IsVisible() then
            return;
        end

        if( 2 == CurList ) then
            return    --Õâ¸öÏûÏ¢ÊÇÓÃÀ´¸üĞÂÈÎÎñ¼ÆÊ±µÄ,µ±µ±Ç°Ñ¡ÖĞÏîÎªÈÎÎñË÷ÒıÊ±,Ôò²»Ó¦¸Ã½øĞĞ¸üĞÂ.
        end

        if arg0 ~= nil and tonumber(arg0) <= 20 and tonumber(arg0) >= 0 then
            if tonumber(arg0) == Current_Select then
                QuestLog_ListBox_SelectChanged()
            end
        end
    elseif(event == "NEW_MISSION" ) then
        Current_Select = tonumber(arg0)
        if not this:IsVisible() then
            return;
        else
            QuestLog_UpdateListbox();
        end
    elseif(event == "DELETE_MISSION") then
        if Current_Select == tonumber(arg0) then
            DataPool:GetPlayerMission_DelActivePos(Current_Select);
            return;
        end
    elseif (event == "OPEN_FROM_MISSIONTRACK") then
        Current_Select = tonumber(arg0)
        if not this:IsVisible() then
            First_Open = 0;

            --È«²¿Õ¹¿ª
            for i=1,200 do
                MissionPucker[i] = 1;
            end;

            QuestLog_UpdateListbox();
            QuestLog_ShowWindow();
        else
            --QuestLog_UpdateListbox();
            this:Hide();
        end
    elseif (event == "UPDATE_QUESTLOG_BY_TRACK") then
        if this:IsVisible() then
            QuestLog_UpdateListbox();
        end
    elseif (event == "UPDATE_TRACK_STATE_BUTTON") then
        local nType = tonumber(arg0);
        if not this:IsVisible() then
            return;
        end
    -- ÓÎÏ·´°¿Ú³ß´ç·¢ÉúÁË±ä»¯
    elseif (event == "ADJEST_UI_POS" ) then
        -- ¸üĞÂ±³°ü½çÃæÎ»ÖÃ
        QuestLog_Frame_On_ResetPos()

    -- ÓÎÏ·Phút±æÂÊ·¢ÉúÁË±ä»¯
    elseif (event == "VIEW_RESOLUTION_CHANGED") then
        -- ¸üĞÂ±³°ü½çÃæÎ»ÖÃ
        QuestLog_Frame_On_ResetPos()
    end
end

--2011Q3ĞÂÊÖÈÎÎñuiÖ¸Òı
function QuestLog_OnShown()     
    QuestLog_FreshManGuide(1, 1, 1)
end
function QuestLog_OnMoved()

end
function QuestLog_OnHidden()

end

--  »î¶¯ÈÕ³Ì°´Å¥µã»÷»Øµ÷
function QuestLog_HitRiCheng()
    OpenTodayCampaignList();
end

--  ¸üĞÂ¿É½ÓÈÎÎñÀàĞÍ
--  ²ÉÈ¡¶ÌÂ·Ğ´·¨, ¾¡¿ì·µ»Ø, ¼õÉÙËõ½ø
function QuestLog_UpdateMissionType( iMissionType )
    local strOutlineName = ""
    --  ¹¹ÔìÈÎÎñÀàĞÍÃû³ÆºÍÏÔÊ¾ÑÕÉ«
    if( 1 == MissionOutlineDeploy[ iMissionType ] ) then
        strOutlineName = "#gFE7E82- " .. DataPool:GetMissionInfo_Kind( iMissionType )
    else
        strOutlineName = "#gFE7E82+ " .. DataPool:GetMissionInfo_Kind( iMissionType )
    end

    --  Õâ¾äÅĞ¶ÏÓÀÔ¶Í¨¹ı, ¶øÇÒ ²»Ó¦¸ÃÊÇ or ¶øÓ¦¸ÃÊÇ and
    --if( strOutlineName ~= "" or strOutlineName ~= 0 ) then
    --  Èç¹ûÊÇÎŞĞ§µÄÈÎÎñÃû³Æ
    if( strOutlineName == "" or strOutlineName == 0 ) then
        return;
    end

    local iStart = iMissionType*10000;
    local DeployNum = GetMissionOutlineNum( iMissionType )

    --  Èç¹ûµ±Ç°ÈÎÎñPhútÀàÃ»ÓĞ¿É½ÓÈÎÎñ
    if( DeployNum <= 0 ) then
        return;
    end

    --  Ôö¼Ó¸ÃÈÎÎñPhútÀàµÄÃû³ÆÏÔÊ¾
    QuestLog_Listbox:AddItem( strOutlineName, iStart )
    --  ¸ÃÈÎÎñPhútÀà²»ÊÇÕ¹¿ªµÄ
    if( 1 ~= MissionOutlineDeploy[ iMissionType ] ) then
        return;
    end

    --  Ôö¼Ó¸ÃPhútÀàÏÂ¿É½ÓµÄÈÎÎñÃû³ÆºÍÆä¶ÔÓ¦ÑÕÉ«ÅäÖÃ
    local nMyLevel = Player:GetData( "LEVEL" )
    for i=1, DeployNum do
        local color= ""
        local MissionLevel, MinLevel, MaxLevel, strNpcName, strNpcPos, strScene, strMissionName = GetMissionOutlineInfo( iMissionType, i )

        if( MissionLevel - nMyLevel < -11 ) then
            color = "FFB9B9B9"; --»ÒÉ«
        elseif( MissionLevel - nMyLevel <=-6 ) then
            color = "FF0A9605";    --ÂÌÉ«
        elseif( MissionLevel - nMyLevel <= 5 ) then
            color = "FFD9F80A";    --»ÆÉ«
        elseif( MissionLevel - nMyLevel <= 10 ) then
            color = "FFF8A10A";    --³ÈÉ«
        else
            color = "FFFA0A0A"; --ºìÉ«
        end

        QuestLog_Listbox:AddItem( "    "..MissionLevel.." "..strMissionName, (iStart+i), color )
    end
end

--  ¸üĞÂ¿É½ÓÈÎÎñÁĞ±í
--  Õâ²¿Phút¸úÖØ¹¹ºóµÄMissionTrackÒ»Ñù... Òò´Ë²»ÔÙ×ö±ä¸üÁË
function QuestLog_UpdateMissionOutline()

    --  ´ÓÒÑ½ÓÈÎÎñÁĞ±íÇĞ»»µ½¿É½ÓÈÎÎñÁĞ±í
    if( 1 == CurList ) then
        CurList = 2
        QuestLog_AcceptMission:SetCheck(1);
        QuestLog_Stop:Hide()
        QuestLog_AcceptMission_Button:Hide()
        QuestLog_TargetMission : SetText( "" );
    end

    --  ¼ÇÂ¼µ±Ç°ÁĞ±íÏÔÊ¾Î»ÖÃ
    local FirstItem = QuestLog_Listbox : GetCurrentFirstItem();
    --AxTrace( 0, 0, Current_Clicked )

    --  »ñÈ¡ËùÓĞ¿É½ÓÈÎÎñ, Çå³ıµ±Ç°ÁĞ±íÏÔÊ¾ÄÚÈİ
    CollectMissionOutline()
    QuestLog_Listbox:ClearListBox()
    QuestLog_Desc:ClearAllElement();

    --  PhútÀà¸üĞÂ200ÖĞÈÎÎñ...
    for i=1,200 do             --ÏÖÈÎÎñÀàĞÍÒ»¹²200ÖÖ
        QuestLog_UpdateMissionType( i )
    end

    --QuestLog_Listbox : EnsureItemIsVisable( Current_Clicked );
    QuestLog_Listbox : SetCurrentFirstItem( FirstItem );
    QuestLog_TrackButtonState();
    --AxTrace( 0, 0, Current_Clicked )

end

--  µã»÷¿É½ÓÈÎÎñÌõÄ¿
function QuestLog_MissionOutlineClicked()
    local nSelIndex = QuestLog_Listbox:GetFirstSelectItem();

    local iMod = math.mod( nSelIndex, 10000 )
    local iFloor = math.floor( nSelIndex / 10000 );

    --  ¸ù¾İµã»÷Ñ¡ÏîµÄidÖµÅĞ¶Ï¸ÃÏîÄ¿ÊÇ ÈÎÎñÀàĞÍ(iMod==0) »¹ÊÇ¾ßÌåÈÎÎñ(iMod!=0)
    if( 0 == iMod ) then
        --  ·´×ª¸ÃÀàĞÍµÄÕÛµşÊôĞÔ
        if( 0 == MissionOutlineDeploy[ iFloor ] ) then
            MissionOutlineDeploy[ iFloor ] = 1
        else
            MissionOutlineDeploy[ iFloor ] = 0
        end

        --  ¸üĞÂÁĞ±íÏÔÊ¾
        QuestLog_UpdateMissionOutline()
        QuestLog_Desc:ClearAllElement();
        return
        --QuestLog_Listbox:SetItemSelectByItemID( nSelIndex )
    end

    --  Èç¹ûÊÇ¾ßÌåÈÎÎñ, ÔÚÈÎÎñÃèÊöÇøÏÔÊ¾ÆäÃèÊöĞÅÏ¢
    QuestLog_Desc:ClearAllElement();
    local MissionLevel, MinLevel, MaxLevel, strNpcName, strNpcPos, strScene, strMissionName, PosX, PosY, SceneID = GetMissionOutlineInfo( iFloor, iMod )
    QuestLog_Desc:AddTextElement("#Y"..strMissionName.."#W")

    strNpcPos = "#{_INFOAIM"..(PosX)..","..(PosY)..","..(SceneID)..","..(strNpcName).."}"
    --strNpcPos = "[["..(PosX)..","..(PosY)..","..(SceneID)..","..(strNpcName).."]]"
    --strNpcPos = "£¨"..PosX.."£¬"..PosY.."£©"

    if strScene and strScene ~= "" then
            QuestLog_Desc:AddTextElement("Nhi®m vø n½i s· tÕi"..strScene.."  "..strNpcPos )
    end
    QuestLog_Desc:AddTextElement("Ngß¶i công b¯ nhi®m vø:"..strNpcName )
    QuestLog_Desc:AddTextElement("C¤p nhi®m vø:"..tostring(MissionLevel) )
end

--  ¸üĞÂÒÑ½ÓÈÎÎñÁĞ±íµÄÖ¸¶¨PhútÀà
--  ÒÔ¶ÌÂ·Ğ´·¨ÖØ¹¹, ¼õÉÙËõ½ø
function QuestLog_UpdateHaveGetMission( kind, kindTbl )
    --  µ¥ÌõÈÎÎñ¼ÇÂ¼
    local Constitutes = {};
    --  Íæ¼Òµ±Ç°µÈ¼¶
    local nMyLevel = Player:GetData( "LEVEL" );
    --  ÊÇ·ñÓĞ¸ÃPhútÀàµÄÈÎÎñ
    local bHave = 0;

    --  ±éÀúËùÓĞÒÑ½ÓÈÎÎñ
    for i=1, g_nMissionNum do
        --  µ±Ç°Î»ÖÃÎªÎŞĞ§ÈÎÎñ
        if (DataPool:GetPlayerMission_InUse(i-1) ~= 1) then
            continue;
        end

        --  ·Çµ±Ç°ÀàĞÍµÄÈÎÎñ
        local MissionKind = DataPool:GetPlayerMission_Kind(i-1);
        if(MissionKind ~= kind) then
            continue;
        end

        AxTrace(0,0,"kind = ".. kind .. " i-1 ="..(i-1));

        --  µ±Ç°ÈÎÎñÀàĞÍÊÇ·ÇÕÛµşµÄ
        if ( MissionPucker[kind] > 0 ) then
            --  »ñµÃÈÎÎñ g_MissionTarget ×Ö¶Î
            local strInfo = DataPool:GetPlayerMission_Memo(i-1);
            --  »ñµÃÈÎÎñ g_MissionLevel ×Ö¶Î
            local nMissionLevel = DataPool:GetPlayerMission_Level(i-1);

            --  Èç¹ûÈÎÎñµÈ¼¶ÊÇÍæ¼ÒµÈ¼¶, ½«ÈÎÎñµÈ¼¶ÉèÖÃÎªÍæ¼ÒµÈ¼¶
            --  ÕâÀïÃ»ÓĞÏòMissionTrackÖĞ¶ÔÀŞÌ¨µÄ 0 µÈ¼¶×öÌØÊâ´¦Àí
            if nMissionLevel == LEVEL_TO_MY_LEVEL then
                nMissionLevel =  Player:GetData( "LEVEL" );
            end

            --  Èç¹ûÊ×´ÎÓĞ¸ÃPhútÀàÈÎÎñ, Ôö¼Ó¸ÃPhútÀàµÄÌõÄ¿¼ÇÂ¼
            if(bHave == 0) then
                local str= "#gFE7E82- " .. DataPool:GetMissionInfo_Kind(kind);
                Constitutes = {str,100+kind,"",0}
                table.insert(kindTbl,Constitutes)
                bHave = 1;

                --  for debug only
                local xx;
                for i,xx in ipairs(Constitutes) do
                    AxTrace(3,1,"Constitutes["..i.."]="..xx)
                end
                AxTrace(0,0,"100+kind = ".. (100+kind) .. " name = " ..DataPool:GetMissionInfo_Kind(kind));
            end

            --------------------------------------------------
            local strOKFail = "";
            --ÏÔÊ¾ÈÎÎñÊÇ·ñÒÑTrä»òÒÑTh¤t bÕi
            local Mission_Variable = DataPool:GetPlayerMission_Variable(i-1,0);

            if QuestLog_IsSpecialMission(i-1) == 1 then
                Mission_Variable = IsMissionSuccess(i-1)
            end

            if(Mission_Variable >0) then
                if(Mission_Variable == 1) then
                    strOKFail = "Trä";
                elseif(Mission_Variable == 2) then
                    strOKFail = "Th¤t bÕi";
                end
            end

            ----------------------------------------------------
            if(nMissionLevel - nMyLevel < -11) then
                color = "FFB9B9B9"; --»ÒÉ«
            elseif(nMissionLevel - nMyLevel <=-6) then
                color = "FF0A9605";    --ÂÌÉ«
            elseif(nMissionLevel - nMyLevel <= 5) then
                color = "FFD9F80A";    --»ÆÉ«
            elseif(nMissionLevel - nMyLevel <= 10) then
                color = "FFF8A10A";    --³ÈÉ«
            else
                color = "FFFA0A0A"; --ºìÉ«
            end

            local nMissionTrackType = 0;
            local nIsMissionTrackOpen = 0;
            if (nIsMissionTrackOpen > 0 and nMissionTrackType > 0) then
                Constitutes = {"   *" .. nMissionLevel .." " .. strInfo .. " " .. strOKFail,i-1,color,nMissionLevel}
            else
                Constitutes = {"     " .. nMissionLevel .." " .. strInfo .. " " .. strOKFail,i-1,color,nMissionLevel}
            end
            table.insert(kindTbl,Constitutes)
        else
            --  ¸ÃÈÎÎñPhútÀàÊÇÕÛµşµÄ, Òò´ËÖ»ÏÔÊ¾Ò»ÌõÈÎÎñPhútÀàÃû³Æ
            if(bHave == 0) then
                local str= "#gFE7E82+ " .. DataPool:GetMissionInfo_Kind(kind);

                Constitutes = {str,100+kind,"",0}
                table.insert(kindTbl,Constitutes)

                bHave = 1;
            end
        end
        --  Ôö¼ÓÒÑ½ÓÈÎÎñÊı
        HaveGetMissionNum=HaveGetMissionNum+1;
    end

    --  ·µ»Ø¸ÃPhútÀàÏÂµÄÈÎÎñ¼ÇÂ¼
    return kindTbl;
end

--  ¸üĞÂÒÑ½ÓÈÎÎñÁĞ±í
function QuestLog_UpdateListbox()

    --  ´Ó¿É½ÓÈÎÎñÁĞ±íÇĞ»»ÎªÒÑ½ÓÈÎÎñÁĞ±í
    if( 2 == CurList ) then
        CurList = 1
        QuestLog_CurrentMission:SetCheck(1);
        QuestLog_Stop:Show()
        QuestLog_AcceptMission_Button:Hide()
    end

    --  ÇĞ»»°´Å¥×´Ì¬.
    --  JOY: ¿É½ÓÈÎÎñÁĞ±í¸üĞÂÊ±ÎªÊ²Ã´Ã»ÓĞÏà¹ØÇĞ»»
    QuestLog_CurrentMission:SetCheck( 1 )
    QuestLog_AcceptMission:SetCheck( 0 )

--    local nMissionNum = DataPool:GetPlayerMission_Num();
    local i;

    QuestLog_Listbox:ClearListBox();

    HaveGetMissionNum = 0
    local color;

    for i=1,g_nMissionNum do
        if (DataPool:GetPlayerMission_InUse(i-1) == 1) then
            DataPool:GetPlayerMission_Description(i-1);
        end
    end;

    --  ÒÑ½ÓÈÎÎñPhútÀà×Ü±í
    local Sequence_Assemble = {}

    --  ±äÁ¿ËùÓĞÀàĞÍµÄÒÑ½ÓÈÎÎñ, PhútÀàÅÅĞò²åÈë×Ü±í
    for j=1, 200 do
        local Sequence_OnefoldGenre = QuestLog_UpdateHaveGetMission( j, {} );
        ----
        table.sort(Sequence_OnefoldGenre,QuestLog_CompareTable)

        for i,n in ipairs(Sequence_OnefoldGenre) do
            table.insert(Sequence_Assemble,n)
        end
        ----
    end

    --  ½«ÒÑ½ÓÈÎÎñÊı¾İ²åÈëÈÎÎñÁĞ±í
    local Per_Segment,xxxx,i,j;
    for i,Per_Segment in ipairs(Sequence_Assemble) do
        if Per_Segment[3] ~= "" then
            QuestLog_Listbox:AddItem(Per_Segment[1],Per_Segment[2],Per_Segment[3])
        else
            QuestLog_Listbox:AddItem(Per_Segment[1],Per_Segment[2])
        end

--        for j,xxxx in ipairs(xxx) do
--            AxTrace(3,0,"xxx["..j.."]="..xxxx)
--        end
    end

    --  Èç¹ûÃ»ÓĞÈÎÎñ, ÔòÈÎÎñÁĞ±íÏÔÊ¾Ïà¹ØÌáÊ¾
    if(HaveGetMissionNum<1) then
        QuestLog_Listbox:AddItem("Không có b¤t kì nhi®m vø nào",0);
    end

    if First_Open == 1 then  --Ê×´Î´ò¿ª£¬Ñ¡ÖĞ×îºóÒ»¸ö
        First_Open = 0    
        Current_Select = HaveGetMissionNum - 1
    end

    --  ÉèÖÃÔ­±¾µÄÈÎÎñÑ¡ÔñÏî
	if g_MenPai_Special_id == 1 then
		QuestLog_Listbox : SetItemSelectByItemID(HaveGetMissionNum-1);
	else
		QuestLog_Listbox : SetItemSelectByItemID(Current_Select);
	end

    QuestLog_Amount : SetText( HaveGetMissionNum .. "/" .. g_nMissionNum);

	if g_MenPai_Special_id == 1 then
		QuestLog_Listbox : SetCurrentFirstItem(HaveGetMissionNum-1);
	end

    QuestLog_ListBox_SelectChanged();

    --  ¸üĞÂµ±Ç°µÄÏÔÊ¾Î»ÖÃ
    if Current_Clicked ~= -1 then
        --QuestLog_Listbox : EnsureItemIsVisable(Current_Clicked);
        QuestLog_Listbox : SetCurrentFirstItem(Current_Clicked);
        Current_Clicked = -1
    end
    QuestLog_TrackButtonState();
--
end

--  ²åÈëÈÎÎñÀàĞÍ, ·ÏÆú
--function MissionType_Insert(str)
--ÅÅĞòËã·¨ÔÚÉÏÃæÒÑ¾­ÊµÏÖÁË£¬ÀíÂÛÉÏ½²Õâ¸ö²»»á±»µ÷ÓÃµ½¡£chris
--        for i=1,table.getn(MissionType) do
--        for i,Per_Segment in ipairs(MissionType) do
--            if(MissionType[i] == str) then
--                return;
--            elseif( MissionType[i] > str ) then
--                    table.insert(MissionType,i,str);
--                    AxTrace(0,0,"MissionType [" ..i.."] =".. MissionType[i]);
--                    return;
--            end
--        end
--        table.insert(MissionType,str);
--        return;
--end

--  ±ä»»µ±Ç°ÈÎÎñÑ¡Ôñ
--  ±¾Éí¾ÍÊÇÊ¹ÓÃ¶ÌÂ·Ğ´·¨, ²»ÓÃÖØ¹¹, ½öÖØĞÂµ÷ÕûËõ½øÔö¼Ó×¢ÊÍ
function QuestLog_ListBox_SelectChanged()

    -- Èç¹ûµ±Ç°ÏÔÊ¾Îª¿É½ÓÈÎÎñ, ×ªÏò¿É½ÓÈÎÎñ´¦Àí
    if( 2 == CurList ) then
        QuestLog_MissionOutlineClicked()
        return
    end

    --  ¿ªÊ¼µ±Ç°Ñ¡ÔñÈÎÎñµÄÊı¾İ¸üĞÂ
    local MissionParam_Index = 0;
    local nSelIndex = QuestLog_Listbox:GetFirstSelectItem();
    local Mission_Variable;

    --  Èç¹ûÃ»ÓĞ½ÓÈÎºÎÈÎÎñ... Nothing
    if(HaveGetMissionNum<1) then
        QuestLog_Desc:ClearAllElement();
        QuestLog_TargetMission : SetText("");
        return;
    end

    --  Èç¹ûÈÎÎñÁĞ±í¼ÇÂ¼µÄµ±Ç°ÈÎÎñÎŞĞ§, ²¢ÇÒ½çÃæ±¾ÉíÒ²Ã»ÓĞ¼ÇÂ¼µ±Ç°Ñ¡ÔñÈÎÎñ.. Nothing
    if nSelIndex == -1 then
        if Current_Select == -1 then
            QuestLog_Desc:ClearAllElement();
            QuestLog_TargetMission : SetText("");
            return;
        else
            --  ½«µ±Ç°Ñ¡ÔñÈÎÎñÖÃÎª½çÃæ¼ÇÂ¼µÄÈÎÎñ
            nSelIndex = Current_Select;
        end
    end

    --  Èç¹ûµ±Ç°µã»÷ÏîÄ¿ÎªPhútÀàÃû³ÆÏî
    if nSelIndex > 20 then

        --  ÇĞ»»ÆäÕÛµş×´Ì¬, ²¢¸üĞÂÏÔÊ¾
        if MissionPucker[nSelIndex-100] == 1 then
            MissionPucker[nSelIndex-100] = 0;
        else
            MissionPucker[nSelIndex-100] = 1;
        end
        Current_Clicked = QuestLog_Listbox : GetCurrentFirstItem();
        QuestLog_UpdateListbox();

        return;
    end;

    --  Èç¹ûµ±Ç°Ñ¡ÖĞÏîÎªÎŞĞ§µÄÈÎÎñ¼ÇÂ¼, Nothing
    if (DataPool:GetPlayerMission_InUse(nSelIndex) ~= 1) then
        QuestLog_Desc:ClearAllElement();
        QuestLog_TargetMission : SetText("");
        return;
    end

    --  Çå³ıÈÎÎñÃèÊö
    QuestLog_Desc:ClearAllElement();
    QuestLog_TargetMission : SetText("");

    --  »ñµÃÈÎÎñÃèÊö
    local desc = DataPool:GetPlayerMission_Description(nSelIndex)
    DataPool:GetPlayerMission_DelActivePos(Current_Select)
    Current_Select = nSelIndex;

    local strInfo,strDesc = DataPool:GetPlayerMission_Memo(nSelIndex);
    local i = 0
    local m = 0
    local nBegin = DataPool:GetPlayerMission_ForePart(nSelIndex);
    AxTrace(5,1,"nBegin="..nBegin)
    AxTrace(5,1,"strDesc="..strDesc)
    local strReplace = ""
    local strOriginal = ""

    --  ºÏ²¢ÈÎÎñµÄ¶àÌõÃèÊöÎª1Ìõ
    while 1 do
        i = string.find(strDesc,"%%s")
        if i == nil then break end
        local strIndex =  DataPool:GetPlayerMission_VariableByByte(nSelIndex,nBegin,m)
        local strTemp = DataPool : GetPlayerMission_StrList(strIndex)
        AxTrace(5,1,"strIndex="..strIndex.." strTemp="..strTemp.." strDesc="..strDesc)
--        string.format(strDesc,strTemp)
        AxTrace(5,1,"strIndex="..strIndex.." strTemp="..strTemp.." strDesc="..strDesc)
        strReplace = strReplace .. string.sub(strDesc,1,i-1) .. strTemp
        AxTrace(5,1,"strReplace="..strReplace)
        AxTrace(5,1,"i="..i)
        strDesc = string.sub(strDesc,i+2)
        m = m + 1;
        AxTrace(5,1,"m="..m)
    end

    --  ÏÔÊ¾ÈÎÎñÃèÊö
    strReplace = strReplace .. strDesc
    strDesc = strReplace
    QuestLog_TargetMission : SetText("#gFF0FA0" ..strInfo);
    QuestLog_Desc:AddTextElement("#YMøc tiêu nhi®m vø: #W")
    QuestLog_Desc:AddTextElement("" .. strDesc);

    --  ÌØÊâ´¦Àí
    if(DataPool:GetPlayerMission_Display(nSelIndex,7) == 500510) then
        QuestLog_Desc:AddTextElement("" .. QuestLog_GetSCMTarget(nSelIndex));
    end

    if(DataPool:GetPlayerMission_Display(nSelIndex,7) == 889265) then
        QuestLog_Desc:AddTextElement("" .. QuestLog_GetHLXQJTarget(nSelIndex));
    end

--    QuestLog_Desc:AddTextElement("" .. strReplace);

    DataPool:GetPlayerMission_ActivePos(nSelIndex);

    --ÏÔÊ¾ÊÇ·ñË«±¶Ê±¼ä
    local nDoubleExp = DataPool:GetPlayerMission_Display(nSelIndex,6)

    local DoubleExp_Text = "";
    if nDoubleExp > 0 then
        local IsDouble = DataPool:GetPlayerMission_DataRound(nDoubleExp);

        if IsDouble > 0 then
            DoubleExp_Text = "#BThß·ng nhi«u l¥n"
            QuestLog_Desc:AddTextElement(DoubleExp_Text);
        end
    end

    --        AxTrace(0, 0, "strInfo= " .. strInfo );
    --Ç°ÃæÊÇ·ñÓĞÒ»Î»ÏÔÊ¾ÈÎÎñÊÇ·ñÒÑTrä,µÚÒ»Î»ÎªTräĞÅÏ¢
    if QuestLog_IsSpecialMission(nSelIndex)==0 then
        MissionParam_Index = MissionParam_Index + 1;
    end

--        for i =0,7 do
--            AxTrace(0,0, "variable [" .. i .."] = " .. DataPool:GetPlayerMission_Variable(nSelIndex,i) );
--        end

    --ÏÔÊ¾ÈÎÎñÊ£ÓàÊ±¼ä
    local nTotalTime = DataPool:GetPlayerMission_Display(nSelIndex,2);
    AxTrace(1,1,"nTotalTime="..nTotalTime)
    if( nTotalTime > 0 ) then
        --73637¡¾ÌìÁú·şÎñÆ÷×é¡¿QuestLogÖĞÊ£ÓàÊ±¼ä¶¨Ê±Æ÷Âß¼­
        local nRemainTime = DataPool:GetPlayerMission_RemainTime(nSelIndex);
        AxTrace(1,1,"nRemainTime="..nRemainTime)
        --²»ºÃÒâË¼£¬¼Óµã×¢ÊÍ£¬ÅÂÒÔºóÍüÁË£¬µ±È»ÄúÈç¹ûÒ»¿´¾ÍÃ÷°×£¬ÄÇ¾ÍÌø¹ı
        --73637µÄ¸ÄÔìÊÇÎªÁË±ÜÃâ·şÎñ¶ËÃ¿´ÎÏìÓ¦ÈÎÎñontimerÊ±¶¼Ïò¿Í»§¶Ë·¢°ü£¬ÒÔ¸æÖªµ¹¼ÆÊ±µÄ±ä»¯
        --¸ÄÔìÒÔºó£¬ÈÎÎñ7ºÅ²ÎÊı²»´æµ¹¼ÆÊ±Ê±¼ä£¬´æÈÎÎñÆô¶¯timer»òÕßËµÊÇ½ÓÊÜÈÎÎñµÄÊ±¼ä
        --·şÎñ¶ËÔÚ½ÓÊÜÈÎÎñ¡¢ÇĞ³¡¾°¡¢µÇÂ¼£¬¶¼»áÏÂ·¢´ËÊ±¼äÖµ£¬¿Í»§¶Ë¸ù¾İÕâ¸ö×Ô¼ºtickµ¹¼ÆÊ±
        --GetPlayerMission_RemainTime»ñÈ¡µÄ¾ÍÊÇ7ºÅ²ÎÊı£¬GetPlayerMission_RemainTimeExÊÇ¿Í»§¶Ë×Ô¼ºËãµÄ£¬Ò²ÊÇ¸ÄÔìºó½çÃæÏÔÊ¾ÕæÕıÊ¹ÓÃµÄ
        --¶ønTotalTimeÊÇÏŞÊ±Ê±¼ä£¬ËùÒÔÏÂÃæÕâ¸öÅĞ¶ÏÆäÊµÊÇ±È½ÏÈ¡ÇÉµÄ
        if(nRemainTime == 0 or nRemainTime > nTotalTime ) then
            nRemainTime = nTotalTime - DataPool:GetPlayerMission_RemainTimeEx(nSelIndex);
        end
        if(nTotalTime >0) then
--          QuestLog_Desc:AddTextElement(" ");
            local strRemainTime,strTotalTime,nSecond,nMinute,nHour; --Dengxx

            if(nTotalTime >= 60000*60) then
                nHour = math.floor(nTotalTime/60000/60)
                nMinute = math.floor((math.mod(nTotalTime,60000*60))/60000)
                nSecond = math.floor((math.mod(nTotalTime,60000))/1000)
                strTotalTime = nHour .. "gi¶"..nMinute.."Phút"..nSecond.."Giây"
            elseif(nTotalTime >= 60000) then
                nMinute = nTotalTime/60000;
                strTotalTime = nMinute .. "Phút"
                nSecond = (nTotalTime - nMinute * 60000)/1000;
                strTotalTime = strTotalTime .. nSecond .."Giây"
            elseif(nTotalTime >= 1000) then
                strTotalTime = nTotalTime/1000 .."Giây"
            end

            if(nRemainTime >= 60000*60) then
                nHour = math.floor(nRemainTime/60000/60)
                nMinute = math.floor((math.mod(nRemainTime,60000*60))/60000)
                nSecond = math.floor((math.mod(nRemainTime,60000))/1000)
                strRemainTime = nHour .. "gi¶"..nMinute.."Phút"..nSecond.."Giây"
            elseif(nRemainTime >= 60000) then
                nMinute = math.floor(nRemainTime/60000);
                strRemainTime = nMinute .. "Phút"
                nSecond = math.floor((nRemainTime - nMinute * 60000)/1000);
                strRemainTime = strRemainTime .. nSecond .."Giây"
            elseif(nRemainTime >= 1000) then
                strRemainTime = math.floor(nRemainTime/1000) .."Giây"
            else
                strRemainTime = "0Giây"
            end

--          QuestLog_Desc:AddTextElement("Ê£ÓàÊ±¼ä: " .. strRemainTime .."/".. strTotalTime);
            local remainTimeColor = "#c00ff00"
            if (nRemainTime <= 5*60000) then
                remainTimeColor = "#cff0000"
            end
            QuestLog_Desc:AddTextElement("#Yth¶i gian còn? " .. remainTimeColor .. strRemainTime );
            --QuestLog_TargetMission : SetText("#cFF0FA0" ..strInfo .. "  #cff0000[Ê£Óà:" .. strRemainTime .. "]");
--          AxTrace(0,0, "Ê±¼ä [" .. nSelIndex .."] = " .. strRemainTime .. " param_index = "..MissionParam_Index);
        end
    end

    --ÏÔÊ¾ÈÎÎñµ±Ç°»·Êı£¬misInfoµÄµÚÈıºÅ²ÎÊıÎª»·Êı£¬Í¨¹ımission dataÏÔÊ¾
    --yanghui£¬ÉèÖÃ±êÖ¾£¬Í¨¹ımission dataÏÔÊ¾»·Êı»¹ÊÇmission paramÏÔÊ¾»·Êı
    local bShowByMD = 0;
    local nRound = DataPool:GetPlayerMission_Display(nSelIndex,3);
    if( nRound >= 0 ) then
        Mission_Variable = DataPool:GetPlayerMission_DataRound(nRound);

        if(Mission_Variable >= 0) then
            QuestLog_Desc:AddTextElement("#r#Y S¯ vòng nhi®m vø trß¾c ğó:#W"..Mission_Variable);
            bShowByMD = 1;
        end
    end

    --yanghui£¬Ç§Ñ°ÈÎÎñÊ¹ÓÃmission paramÔö¼Ó»·ÊıÏÔÊ¾
    if (bShowByMD == 0) then
        Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex, 2);
        if (Mission_Variable == 229024) then
            Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex, 5);
            if(Mission_Variable >= 0) then
                QuestLog_Desc:AddTextElement("#r#Y S¯ vòng nhi®m vø trß¾c ğó:#W"..Mission_Variable);
            end
        end
    end

    --TT76649£¬ÀÏ´øĞÂÊ¹ÓÃmission paramÔö¼ÓÁ¬ĞøTräÌìÊıÏÔÊ¾
    if( DataPool:GetPlayerMission_Display(nSelIndex,7) == 210254 ) then --Èç¹ûÈÎÎñ´¦Àí½Å±¾ÊÇ210254£¨ÀÏ´øĞÂ»î¶¯£©
        Mission_Variable = DataPool:GetPlayerMission_DataRound(511);--ÀÏ´øĞÂ»î¶¯µÄÁ¬ĞøÌìÊı´æ´¢ÔÚmissiondataµÄ
        																														--MD_HELPNEWBIE_SUBMIT_TIMES_SEQUENCE = 511 --°ïÖúĞÂÈËÈÎÎñÁ¬ĞøTräÌìÊı
        local strseqdays = string.format("#{LDX_100726_05}%d",Mission_Variable)
 				QuestLog_Desc:AddTextElement(strseqdays);
    end


    --ÏÔÊ¾ÈÎÎñPhiªu bÕcÊıÁ¿
    if( DataPool:GetPlayerMission_Display(nSelIndex,4) > 0 ) then
        Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index);
        MissionParam_Index = MissionParam_Index + 1;

        if(Mission_Variable >0) then
--            QuestLog_Desc:AddTextElement(" ");
            silverdesc = DataPool:GetPlayerMission_BillName(nSelIndex);
            QuestLog_Desc:AddTextElement(silverdesc .. ":");
            QuestLog_Desc:AddMoneyElement(Mission_Variable);
            AxTrace(0,0, "Phiªu bÕc [" .. nSelIndex .."] =" ..MissionParam_Index );
        end
    end
    QuestLog_Desc:AddTextElement(" ");
    if( DataPool:GetPlayerMission_Display(nSelIndex,5) <= 0 ) then
        QuestLog_Desc:AddTextElement("#YĞi«u ki®n c¥n thiªt: #W")
    end

    if(DataPool:GetPlayerMission_Display(nSelIndex,7) == 500510) then
        QuestLog_Desc:AddTextElement("" .. QuestLog_GetSCMComplete(nSelIndex));
    end

    if(DataPool:GetPlayerMission_Display(nSelIndex,7) == 889265) then
        QuestLog_Desc:AddTextElement("" .. QuestLog_GetHLXQJComplete(nSelIndex));
    end

    --ÈÎÎñĞèÒªÉ±µÄnpc
    local nDemandKillNum,Kill_Random_Type = DataPool:GetPlayerMissionDemandKill_Num(nSelIndex);
    if( nDemandKillNum > 0 ) then
--        QuestLog_Desc:AddTextElement(" ");
        QuestLog_Desc:AddTextElement("Ğã giªt chªt:");
    end

    for i=1, nDemandKillNum do
        --    ĞèÒªµÄNPC, ĞèÒªµÄÊıÁ¿
        local nNPCName, nNum = DataPool:GetPlayerMissionDemand_NPC(i-1,Kill_Random_Type,nSelIndex);
        Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index,Kill_Random_Type,i-1);
        MissionParam_Index = MissionParam_Index + 1;
        AxTrace(0, 0, "nNPCName:" .. nNPCName);
        AxTrace(0, 0, "num:" .. nNum);

        QuestLog_Desc:AddTextElement(nNPCName .. " : "..Mission_Variable.. " / " .. nNum);
        AxTrace(0,0, "NPC [" .. nSelIndex .."] =" ..MissionParam_Index );
    end

    --ÈÎÎñĞèÒªµÄÎïÆ·
    local nDemandNum,Item_Random_Type = DataPool:GetPlayerMissionDemand_Num(nSelIndex);
    if( nDemandNum > 0 ) then
--      QuestLog_Desc:AddTextElement(" ");
        if(Item_Random_Type == -100) then
            QuestLog_Desc:AddTextElement("Ğã ğßa cho: ");
            Item_Random_Type = 0
        else
            QuestLog_Desc:AddTextElement("Ğã ğÕt ğßşc:");
        end
    end

    for i=1, nDemandNum do
        --    ĞèÒªµÄÀàĞÍ£¬ĞèÒªÎïÆ·ID£¬ĞèÒª¶àÉÙ¸ö
        local szName,nItemID, nNum = DataPool:GetPlayerMissionDemand_Item(i-1,Item_Random_Type,nSelIndex);
--      Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index);
--      MissionParam_Index = MissionParam_Index + 1
        Mission_Variable = DataPool : GetPlayerMission_ItemCountNow(nItemID)
        --71435 ¡°Ñ°ÕÒÍòÁéÊ¯¡±ÈÎÎñÂß¼­µÄĞŞ¸Ä
        if nItemID == 20309012 then
            Mission_Variable = Mission_Variable + DataPool : GetPlayerMission_ItemCountNow(20309020)
        end
        AxTrace(0, 0, "itemid:" .. nItemID)
        AxTrace(0, 0, "szName:" .. szName)
        AxTrace(0, 0, "num:" .. nNum)

        if Mission_Variable > nNum then
            Mission_Variable = nNum
        end


--      QuestLog_Desc:AddItemElement(nItemID, nNum, 0);
        local Mission_Variable2 = DataPool:GetPlayerMission_Variable(nSelIndex,0);
        if Mission_Variable2 > 0 then
            Mission_Variable = nNum
        end
        QuestLog_Desc:AddTextElement(szName .. " : " .. Mission_Variable .. " / " .. nNum);
    end

    -----------------------------------------------------------------------------------
    --ÈÎÎñ×Ô¶¨ÒåµÄÎïÆ·
    local nCustomNum = DataPool:GetPlayerMissionCustom_Num(nSelIndex);
    if( nCustomNum > 0 ) then
        QuestLog_Desc:AddTextElement(" ");
    end

    for i=1, nCustomNum do
        --    ĞèÒªµÄNPC£¬ĞèÒªNPC ID£¬ĞèÒª¶àÉÙ¸ö
        local strCustom, nNum = DataPool:GetPlayerMissionCustom(i-1);
        Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index);
        MissionParam_Index = MissionParam_Index + 1;
        AxTrace(0, 0, "strCustom = " .. strCustom);
        AxTrace(0, 0, "nNum = " .. nNum);

        if nNum == 0 then
            QuestLog_Desc:AddTextElement(strCustom);
        else
            QuestLog_Desc:AddTextElement(strCustom .. " : ".. Mission_Variable .. " / " .. nNum);
        end
    end

    -----------------------------------------------------------------------------------
    --ÈÎÎñ×Ô¶¨ÒåµÄËæ»úÎïÆ· zzÌí¼Ó
    local nRandomCustomNum = DataPool:GetPlayerMissionRandomCustom_Num(nSelIndex);
    if( nRandomCustomNum > 0 ) then
            --QuestLog_Desc:AddTextElement(" ");
    end
    for i=1,nRandomCustomNum do
        local strCustom, nNeedNum,nCompleteNum = DataPool:GetPlayerMissionRandomCustom(i-1,nSelIndex);
        if nNeedNum == 0 then
            QuestLog_Desc:AddTextElement(strCustom);
        else
            QuestLog_Desc:AddTextElement(strCustom .. " : ".. nCompleteNum .. " / " .. nNeedNum);
        end
    end


    ----------------------------------------------------------------------------------
    --  ÈÎÎñ½±ÀøËµÃ÷
    QuestLog_Desc:AddTextElement(" ");
    local nBonusNum = DataPool:GetPlayerMissionBonus_Num();

    if( nBonusNum > 0 ) then
        QuestLog_Desc:AddTextElement("#YKhen thß·ng:#W");
    end
    local nRadio = 1;
    local nRand = 1;

    for i=1, nBonusNum do
        --½±ÀøµÄÀàĞÍ£¬½±ÀøÎïÆ·ID£¬½±Àø¶àÉÙ¸ö
        local strType, nItemID, nNum = DataPool:GetPlayerMissionBonus_Item(i-1);
        if(strType == "money" and nNum > 0 )then
--            QuestLog_Desc:AddTextElement("½±Àø½ğÇ®:");
            --ÕâÀïÓĞ¶Ô¾çÇéÑ­»·ÈÎÎñµÄÌØÊâ´¦Àí
            local nScriptId = DataPool:GetPlayerMission_Display(nSelIndex,7)
            if (nScriptId >= 890000 and nScriptId <= 890005) then
                QuestLog_Desc:AddJiaoZiElement(nNum)
            else
                if (nScriptId >= 1010243 and nScriptId <= 1010250) or
                    (nScriptId >= 1010402 and nScriptId <= 1010409) or
                    (nScriptId >= 1018000 and nScriptId <= 1018033) or
                    (nScriptId >= 1018050 and nScriptId <= 1018084) or
                    (nScriptId >= 1018100 and nScriptId <= 1018155) or
                    (nScriptId >= 1018200 and nScriptId <= 1018235) or
                    (nScriptId >= 1018300 and nScriptId <= 1018311) or
                    (nScriptId >= 1018350 and nScriptId <= 1018352) or
                    (nScriptId >= 1018360 and nScriptId <= 1018367) or
                    (nScriptId >= 1018400 and nScriptId <= 1018455) or
                    (nScriptId >= 1018500 and nScriptId <= 1018504) or
                    (nScriptId >= 1018530 and nScriptId <= 1018541) or
                    (nScriptId >= 1018560 and nScriptId <= 1018566) or
                    (nScriptId >= 1038000 and nScriptId <= 1038040) or
                    (nScriptId >= 1038110 and nScriptId <= 1038114) or
                    (nScriptId >= 1039000 and nScriptId <= 1039011) or
                    (nScriptId >= 1039020 and nScriptId <= 1039024) or
                    (nScriptId >= 1039100 and nScriptId <= 1039104) or
                    (nScriptId >= 1038100 and nScriptId <= 1038104) or
                    (nScriptId >= 1039110 and nScriptId <= 1039126) or
                    (nScriptId >= 1039200 and nScriptId <= 1039211) or
                    (nScriptId >= 1039250 and nScriptId <= 1039259) or
                    (nScriptId >= 1039300 and nScriptId <= 1039312) or
                    (nScriptId >= 1039350 and nScriptId <= 1039357) or
                    (nScriptId >= 1039400 and nScriptId <= 1039412) or
                    (nScriptId >= 1039450 and nScriptId <= 1039462) or
                    (nScriptId >= 1039500 and nScriptId <= 1039511) or
                    (nScriptId >= 1039550 and nScriptId <= 1039554) or
                    (nScriptId >= 1039600 and nScriptId <= 1039612) or
                    (nScriptId >= 1009000 and nScriptId <= 1009027) or
                    (nScriptId >= 1009100 and nScriptId <= 1009103) then

                    -- Ê¹ÓÃÍæ¼Ò×Ô¼ºµÄµÈ¼¶À´¼ÆËãµÃµ½µÄ½±Àø
                    nNum = tonumber(Player:GetData("LEVEL") * 18 -101)
                end

                QuestLog_Desc:AddMoneyElement(nNum);
            end
        elseif(strType == "moneyjz" and nNum > 0) then
            QuestLog_Desc:AddJiaoZiElement(nNum)
        elseif(strType == "item") then
--            QuestLog_Desc:AddTextElement("¹Ì¶¨½±ÀøÎïÆ·:");
            local ActionID = DataPool:EnumPlayerMission_ItemAction(nItemID);
            QuestLog_Desc:AddActionElement(ActionID, nNum, 0);
        elseif(strType == "itemrand") then
            if (nRand == 1) then
                nRand = 0;
                QuestLog_Desc:AddTextElement("Tùy ch÷n v§t ph¦m khen thß·ng:");
                local ActionID = DataPool:EnumPlayerMission_ItemAction(nItemID);
                QuestLog_Desc:AddActionElement(ActionID, nNum, 0);
            end
--          local ActionID = DataPool:EnumPlayerMission_ItemAction(nItemID);
--          QuestLog_Desc:AddActionElement(ActionID, nNum, 0);
--          QuestLog_Desc:AddItemElement(-1, nNum, 0);
        elseif(strType == "itemradio") then
            bBeingRadio = 1;
            if (nRadio == 1) then
                nRadio = 0;
                QuestLog_Desc:AddTextElement("TÕi t¤t cä v§t ph¦m dß¾i kia ch÷n mµt møc làm khen thß·ng");
            end
            AxTrace(0, 0, "nItemID:" .. nItemID);
            local ActionID = DataPool:EnumPlayerMission_ItemAction(nItemID);
            AxTrace(0, 0, "ActionID:" .. ActionID);
            QuestLog_Desc:AddActionElement(ActionID,nNum, 0 ,0);
--            QuestLog_Desc:AddItemElement(nItemID, nNum, 1 ,1);
        end
    end

    --------------------------------------------------------------------------------
    --2009Ê¥µ®ÈÕ³£»î¶¯µÄÌØÊâ´¦Àí
    --Add by Jiang Yin
    --------------------------------------------------------------------------------
    local nScriptId = DataPool:GetPlayerMission_Display(nSelIndex, 7)
    if nScriptId == 808200 then
        local strIndex = DataPool:GetPlayerMission_Variable(nSelIndex, 1)
        local strTemp = DataPool:GetPlayerMission_StrList(strIndex)
        local pos = string.find(strTemp, "%%s")
        if pos ~= nil then
            strTemp = string.sub(strTemp, 1, pos - 1) .. DataPool:GetPlayerMission_Variable(nSelIndex, 2) .. string.sub(strTemp,  pos + 2)
        end
        QuestLog_Desc:AddTextElement(strTemp)
    end
    --------------------------------------------------------------------------------
    --2009Ê¥µ®ÈÕ³£»î¶¯µÄÌØÊâ´¦ÀíÍê±Ï
    --------------------------------------------------------------------------------
    QuestLog_TrackButtonState();
end

--  ·ÅÆúÈÎÎñ °´Å¥µã»÷»Øµ÷
function Abnegate_Quest()
    if(HaveGetMissionNum<1 or QuestLog_Listbox:GetFirstSelectItem() < 0) then
        return;
    end
    if(Current_Select < 100) then
        DataPool : Mission_Abnegate_Popup( Current_Select, DataPool:GetPlayerMission_Memo(Current_Select));
    end
end

--  ÒÑ½ÓÈÎÎñPhútÀàÅÅĞòº¯Êı
function QuestLog_CompareTable(table_a,table_b)
    if table_a[4] < table_b[4] then
        return true
    else
        return false
    end
end

--  ÈÎÎñ×·×Ù¸´Ñ¡¿òµã»÷»Øµ÷
function QuestLog_MissionTrack_Clicked()

end

--  »î¶¯×·×Ù¸´Ñ¡¿òµã»÷»Øµ÷
function QuestLog_CampaignTrack_Clicked()

end

--  ÏÔÊ¾ÈÎÎñÁĞ±í
function QuestLog_ShowWindow()
    this:TogleShow();
    local nMissionTrackShow = 0;
    local nCampaignTrackShow = 0;
    if (nMissionTrackShow > 0) then
        QuestLog_Mode1:SetCheck(1);
    else
        QuestLog_Mode1:SetCheck(0);
    end
    if (nCampaignTrackShow > 0) then
        QuestLog_Mode2:SetCheck(1);
    else
        QuestLog_Mode2:SetCheck(0);
    end
    g_QuestLog_LastSelect=-1
end

--  ¸üĞÂÈÎÎñµÄ×·×ÙÑ¡Ïî°´Å¥, ÉèÖÃ×·×Ù°´Å¥Îª È¡Ïû×·×Ù/¿ªÊ¼×·×Ù
function QuestLog_TrackButtonState()

end

--  ¿ªÆôÈÎÎñ×·×Ù»òÕßÈ¡ÏûÈÎÎñ×·×Ù
function QuestLog_TrackCancelOrOpen()

end


--TT53675¶ÔËùÓĞ²»·ûºÏ¹æ·¶£¬Ã»ÓĞ½«missionparamµÚ0Î»×öÎªÈÎÎñTrä±êÖ¾µÄÈÎÎñ½Å±¾×öÌØÊâ´¦Àí£¬ÅĞ¶ÏÈÎÎñÊÇ·ñTrä
function IsMissionSuccess(nSelIndex)
    local MissionParam_Index = 0
    local Mission_Variable = 0

    --ÈÎÎñĞèÒªÉ±µÄnpc
    local nDemandKillNum,Kill_Random_Type = DataPool:GetPlayerMissionDemandKill_Num(nSelIndex);
    if( nDemandKillNum > 0 ) then
        for i=1, nDemandKillNum do
            --  ĞèÒªµÄNPC, ĞèÒªµÄÊıÁ¿
            local nNPCName, nNum = DataPool:GetPlayerMissionDemand_NPC(i-1,Kill_Random_Type,nSelIndex);
            --  TräµÄÊıÁ¿
            Mission_Variable = DataPool:GetPlayerMission_Variable(nSelIndex,MissionParam_Index,Kill_Random_Type,i-1);
            MissionParam_Index = MissionParam_Index + 1;
            if Mission_Variable < nNum then
                return 0
            end
        end
    end

    --ÈÎÎñĞèÒªµÄÎïÆ·
    local nDemandNum,Item_Random_Type= DataPool:GetPlayerMissionDemand_Num(nSelIndex);
    if( nDemandNum > 0 ) then
        for i=1, nDemandNum do
            --    ĞèÒªµÄÀàĞÍ£¬ĞèÒªÎïÆ·ID£¬ĞèÒª¶àÉÙ¸ö
            local szName,nItemID, nNum = DataPool:GetPlayerMissionDemand_Item(i-1,Item_Random_Type,nSelIndex);
            --  TräµÄÊıÁ¿
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
            --    ĞèÒªµÄÀàĞÍ, ĞèÒªµÄÊıÁ¿
            local strCustom, nNum = DataPool:GetPlayerMissionCustom(i-1);
            --  TräµÄÊıÁ¿
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
            --  ĞèÒªµÄÀàĞÍ, ĞèÒªµÄÊıÁ¿, TräµÄÊıÁ¿
            local strCustom, nNeedNum,nCompleteNum = DataPool:GetPlayerMissionRandomCustom(i-1,nSelIndex);
            if nCompleteNum < nNeedNum then
                return 0
            end
        end
    end

    return 1
end

--================================================
-- »Ö¸´½çÃæµÄÄ¬ÈÏÏà¶ÔÎ»ÖÃ
--================================================
function QuestLog_Frame_On_ResetPos()

    QuestLog_Frame : SetProperty("UnifiedXPosition", g_QuestLog_Frame_UnifiedXPosition);
    QuestLog_Frame : SetProperty("UnifiedYPosition", g_QuestLog_Frame_UnifiedYPosition);

end

function QuestLog_GetSCMTarget(nSelIndex)
    --µÚÎåÎ»µÄµÚÒ»×Ö½Ú´æÈÎÎñÀàĞÍ£¬µÚ¶ş×Ö½Ú³¡¾°ĞòºÅ
    local missionType = DataPool:GetPlayerMission_VariableByByte(nSelIndex, 5, 0) - 1
    local sceneIndex = DataPool:GetPlayerMission_VariableByByte(nSelIndex, 5, 1) - 1
    local strScript = DataPool:GetPlayerMission_StrList(missionType)
    local strTarget = ParserString(strScript,"Color")
    local strReplace = ""
    if missionType < 2 and  missionType >= 0 then
        strReplace = DataPool:GetPlayerMission_StrList(missionType*33 + 3 + sceneIndex)--ÕâÀïµÄ33ÊÇ³¡¾°ÊıÁ¿£¬Èç¹ûÒªÔö¼ÓĞèÒªĞŞ¸ÄÕâ¸öÊı×Ö
    elseif missionType == 2 then--¶Á±í
        local monster={}
        local killNumber = 0
        killNumber,monster[1],monster[2],monster[3],monster[4],monster[5],monster[6],monster[7],monster[8] = DataPool:GetSCMKillMonsterInfo(sceneIndex+1)
        for i=1,8 do
            if monster[i]~=nil and monster[i]~="" then
                strReplace = strReplace .. monster[i] .. "#{SDHDRW_091216_02}"
            end
        end
        --È¥µô×îºóÒ»¸ö¶ººÅ
        strReplace = string.sub(strReplace, 1, string.len(strReplace) - string.len("#{SDHDRW_091216_02}"))
        strReplace = strReplace .. "#{CJXH_100517_14}" .. tostring(killNumber)
    end

    local pos = string.find(strTarget,"%%s")

    if(pos~=nil) then
        strTarget = string.sub(strTarget, 1 ,pos-1)..strReplace..string.sub(strTarget,pos+2)
    end

    local SceneList = {170,169,171,156,173,176,445,174,157,177,175,178,517,519,520,179,427,434,432,202,400,401,
                        402,203,159,160,161,162,163,164,165,166,167}
    local sceneId = SceneList[sceneIndex + 1]
    strReplace = GetSceneNameByID(sceneId)
    pos = string.find(strTarget,"%%t")
    if(pos~=nil and strReplace~=nil) then
	    strTarget = string.sub(strTarget, 1 ,pos-1)..strReplace..string.sub(strTarget,pos+2)
    end
    return strTarget
end

function QuestLog_GetSCMComplete(nSelIndex)
    local missionType = DataPool:GetPlayerMission_VariableByByte(nSelIndex, 5, 0) - 1
    local sceneIndex = DataPool:GetPlayerMission_VariableByByte(nSelIndex, 5, 1) - 1
    local strComplete = ""
    if(missionType==0) then
        strComplete = strComplete.."#{CJXH_100517_17}"
        local alreadyKill = DataPool:GetPlayerMission_Variable(nSelIndex, 1)
        local needKill = DataPool:GetPlayerMission_Variable(nSelIndex, 2)
	if alreadyKill > needKill then
		alreadyKill = needKill
	end
        strComplete = strComplete..tostring(alreadyKill).." / "..tostring(needKill)
    elseif (missionType == 1) then
        local itemName = PlayerPackage:GetItemName(40004526)
        strComplete = strComplete.."#{CJXH_100517_21}\n"..itemName..":"
        local alreadyObtain = DataPool:GetPlayerMission_Variable(nSelIndex, 1)
        local needObtain = DataPool:GetPlayerMission_Variable(nSelIndex, 2)
	if alreadyObtain > needObtain then
		alreadyObtain = needObtain
	end
        strComplete = strComplete..tostring(alreadyObtain).." / "..tostring(needObtain)
    elseif(missionType == 2) then
        strComplete = strComplete.."#{CJXH_100517_24}\n"
        local monster={}
        local killNumber = 0
        local alreadyKill = {}
        alreadyKill[1] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 1),1)
        alreadyKill[2] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 1),2)
        alreadyKill[3] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 2),1)
        alreadyKill[4] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 2),2)
        alreadyKill[5] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 3),1)
        alreadyKill[6] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 3),2)
        alreadyKill[7] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 4),1)
        alreadyKill[8] = DataPool:GetSCMAlreadyKillNumber(DataPool:GetPlayerMission_Variable(nSelIndex, 4),2)
        killNumber,monster[1],monster[2],monster[3],monster[4],monster[5],monster[6],monster[7],monster[8] = DataPool:GetSCMKillMonsterInfo(sceneIndex+1)
        for i=1,8 do
            if monster[i]~=nil and monster[i]~="" then
                strComplete = strComplete .. monster[i] ..":" .. tostring(alreadyKill[i]) .. " / " .. tostring(killNumber) .. "\n"
            end
        end
    end
    return strComplete
end



function QuestLog_GetHLXQJComplete( nSelIndex )
	local AlreadyPlay = {}

	AlreadyPlay[1] = DataPool:GetPlayerMission_Variable( nSelIndex, 1 )
	AlreadyPlay[2] = DataPool:GetPlayerMission_Variable( nSelIndex, 2 )
	AlreadyPlay[3] = DataPool:GetPlayerMission_Variable( nSelIndex, 3 )
	AlreadyPlay[4] = DataPool:GetPlayerMission_Variable( nSelIndex, 4 )
	AlreadyPlay[5] = DataPool:GetPlayerMission_Variable( nSelIndex, 5 )

	local MenPaiList = {
		[0] = { id = 0, rate = 10, name = "#{XQ_MP_1}" },    --ÉÙÁÖ
		[1] = { id = 1, rate = 20, name = "#{XQ_MP_2}" },    --Ã÷½Ì
		[2] = { id = 2, rate = 30, name = "#{XQ_MP_3}" },    --Ø¤°ï
		[3] = { id = 3, rate = 40, name = "#{XQ_MP_4}" },    --Îäµ±
		[4] = { id = 4, rate = 50, name = "#{XQ_MP_5}" },    --¶ëÃ¼
		[5] = { id = 5, rate = 60, name = "#{XQ_MP_6}" },    --ĞÇËŞ
		[6] = { id = 6, rate = 70, name = "#{XQ_MP_7}" },    --ÌìÁú
		[7] = { id = 7, rate = 80, name = "#{XQ_MP_8}" },    --ÌìÉ½
		[8] = { id = 8, rate = 90, name = "#{XQ_MP_9}" },    --åĞÒ£
        [9] = { id = 9, rate = 100, name = "#{XQ_MP_10}" },         --ÎŞÃÅÅÉ
		[10] = { id = 10, rate = 100, name = "#{XQ_MP_10}" },  --Ä½Èİ
	}

	local strComplete = ""

	for i = 1, 5 do
		local aimMenpai = 0
		local isDone = 1
		if AlreadyPlay[i] >= 100 then
			aimMenpai = 1
			AlreadyPlay[i] = AlreadyPlay[i] - 100
		end
        local temp_str = "#{XQ_MP_11}"..MenPaiList[AlreadyPlay[i]].name.."#{XQ_MP_12}".." "..tostring( aimMenpai ).."/"..tostring( isDone )
        strComplete = strComplete..temp_str.."\n"
	end

	return strComplete
end

function QuestLog_GetHLXQJTarget( nSelIndex )
	local AlreadyPlay = {}

    AlreadyPlay[1] = DataPool:GetPlayerMission_Variable( nSelIndex, 1 )
	AlreadyPlay[2] = DataPool:GetPlayerMission_Variable( nSelIndex, 2 )
	AlreadyPlay[3] = DataPool:GetPlayerMission_Variable( nSelIndex, 3 )
	AlreadyPlay[4] = DataPool:GetPlayerMission_Variable( nSelIndex, 4 )
	AlreadyPlay[5] = DataPool:GetPlayerMission_Variable( nSelIndex, 5 )

    for i = 1, 5 do
        if AlreadyPlay[i] >= 100 then
            AlreadyPlay[i] = AlreadyPlay[i] - 100
        end
    end

	local MenPaiList = {
		[0] = { id = 0, rate = 10, name = "#{XQ_MP_1}" },    --ÉÙÁÖ
		[1] = { id = 1, rate = 20, name = "#{XQ_MP_2}" },    --Ã÷½Ì
		[2] = { id = 2, rate = 30, name = "#{XQ_MP_3}" },    --Ø¤°ï
		[3] = { id = 3, rate = 40, name = "#{XQ_MP_4}" },    --Îäµ±
		[4] = { id = 4, rate = 50, name = "#{XQ_MP_5}" },    --¶ëÃ¼
		[5] = { id = 5, rate = 60, name = "#{XQ_MP_6}" },    --ĞÇËŞ
		[6] = { id = 6, rate = 70, name = "#{XQ_MP_7}" },    --ÌìÁú
		[7] = { id = 7, rate = 80, name = "#{XQ_MP_8}" },    --ÌìÉ½
		[8] = { id = 8, rate = 90, name = "#{XQ_MP_9}" },    --åĞÒ£
        [9] = { id = 9, rate = 100, name = "#{XQ_MP_10}" },         --ÎŞÃÅÅÉ
		[10] = { id = 10, rate = 100, name = "#{XQ_MP_10}" },  --Ä½Èİ
	}

	local strComplete = ""

	strComplete = "#{XQHLJ_101108_59}"..MenPaiList[AlreadyPlay[1]].name.."#{XQHLJ_101108_65}"..MenPaiList[AlreadyPlay[2]].name.."#{XQHLJ_101108_65}"..MenPaiList[AlreadyPlay[3]].name.."#{XQHLJ_101108_65}"..MenPaiList[AlreadyPlay[4]].name.."#{XQHLJ_101108_65}"..MenPaiList[AlreadyPlay[5]].name.."#{XQHLJ_101108_60}"

	return strComplete
end


--  ÊÇ·ñÊÇÌØÊâÈÎÎñ, ÈÎÎñ×´Ì¬²»ÊÇ¼ÇÂ¼ÔÚ0ºÅÎ»ÖÃµÄ.
function QuestLog_IsSpecialMission( index )
    --TT53675¶ÔÓÚËùÓĞÃ»ÓĞÓÃmissionparamµÚ0Î»±íÊ¾ÈÎÎñÊÇ·ñTräµÄÈÎÎñ£¬Ê¹ÓÃIsMissionSuccessÅĞ¶ÏÈÎÎñÊÇ·ñTrä
    local IsSpecial = 0
    local nScriptId = DataPool:GetPlayerMission_Display(index,7);

    for i, findId in SpecialMissionList do
          if nScriptId == findId then
             IsSpecial = 1
            break
        end
    end

    if nScriptId >= 1020000 and nScriptId <= 1029999 then --ËùÓĞµÄÌ½Ë÷Åä±íÈÎÎñ¶¼ĞèÒªÌØÊâ´¦Àí
          IsSpecial = 1
    end

    return IsSpecial;
end

--!!!reloadscript =QuestLog
function QuestLog_FreshManGuide(nType, nTextID, nPosID)
    if nType ~= 1 and      --1 is reset and open
        nType ~= 2 then    --2 is modify
        return
    end
    if 1 ~= CurList then   --²»ÊÇ¿É½ÓÈÎÎñÁĞ±í²»¹Ü
        return
    end
    if Player:GetData("LEVEL") > 10 then
        return
    end
    local nSelIndex = QuestLog_Listbox:GetFirstSelectItem()
    if nSelIndex < 0 then
        return
    end 
    local nScriptId = DataPool:GetPlayerMission_Display(nSelIndex, 7)
    if nScriptId ~= 210262 and   --³õÉæ½­ºş
        nScriptId ~= 210255 and  --µÚÒ»°ÑÎäÆ÷ 
        nScriptId ~= 210256 then --µÚÒ»¼ş·À¾ß
        return  
    end  
    
    local nTipPosX = 0
    local nTipPosY = 0
    if 1 == nPosID then  --QuestLog_Desc
        nTipPosX = QuestLog_Frame:GetProperty("AbsoluteXPosition") + QuestLog_MainFrame:GetProperty("AbsoluteXPosition") +
            QuestLog_Frame_Client:GetProperty("AbsoluteXPosition") + QuestLog_Bk:GetProperty("AbsoluteXPosition") +
            QuestLog_Desc:GetProperty("AbsoluteXPosition") + QuestLog_Desc:GetProperty("AbsoluteWidth") / 2
        nTipPosY = QuestLog_Frame:GetProperty("AbsoluteYPosition") + QuestLog_MainFrame:GetProperty("AbsoluteYPosition") + 
            QuestLog_Frame_Client:GetProperty("AbsoluteYPosition") + QuestLog_Bk:GetProperty("AbsoluteYPosition") +
            QuestLog_Desc:GetProperty("AbsoluteYPosition") + 30
    else 
        return           --unkown position
    end  
    OpenFreshManGuide(nType, nTextID, nTipPosX, nTipPosY, "QuestLog", nPosID, "northeast")
end
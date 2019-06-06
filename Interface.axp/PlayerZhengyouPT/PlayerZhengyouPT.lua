--Õ÷ÓÑÆ½Ì¨£¬Õ÷ÓÑÍæ¼ÒÁÐ±í cuiyinjie 2008.10.20
-- ÁÐ±íÇëÇó¹ý³Ì£º lua½Å±¾·¢ËÍÇëÇóµÄÀàÐÍÓëÒ³£¬ ·þÎñÆ÷·µ»Øºó¿Í»§¶Ëpushevent¸æËßlua£¬luaÈ»ºóÈ¡ÊýÁ¿ÔÙÒ»ÌõÌõÈ¡ÐÅÏ¢ÏÔÊ¾ÔÚÁÐ±í
-- ÐÞ¸Ä£º	WTT	2009-3-27	Èç¹ûÊÇ²éÑ¯ÈËÆøÐÅÏ¢ÁÐ±í£¬¿Í»§¶ËÖ»ÐèÏò·þÎñÆ÷·¢ËÍÇëÇóÒ³£¬¶ø²»Ðè·¢ËÍÇëÇóÀàÐÍ£¬·þÎñÆ÷·µ»ØÈËÆøÁÐ±íÐÅÏ¢¡£
--											Ä¿Ç°ÈËÆøÁÐ±íÐÅÏ¢×î¶àÏÔÊ¾1Ò³£¨20Ìõ£©												
-- ÆµµÀÀàÐÍºÍÐÔ±ð¶¨Òå
local g_Genders = { "Næ", "Nam" };
local g_Channels = {"#{ZYPT_081103_008}", "#{ZYPT_081103_009}", "#{ZYPT_081103_010}", "#{ZYPT_081103_011}",}; --{"ÀÉ²ÅÅ®Ã²", "À­°ï½á»ï", "°ÝÊ¦Ñ°Í½", "Òå½á½ðÀ¼"};
local g_TypesDesc = {"Kªt Hôn", "Bang Hµi", "Sß Ð°", "Kªt Nghîa"};   --·¢ÓÊ¼þÊ±ÎÞ·¨×ªÒå
local g_MenPaiName = {"Thiªu Lâm", "Minh Giáo", "Cái Bang", "Võ Ðang", "Nga My", "Tinh Túc", "Thiên Long", "Thiên S½n", "Tiêu Dao", "Không có"};
local g_MarryDesc = {"Chßa kªt hôn", "Ðã kªt hôn"};
--local g_ZhengyouMudi = { {"ÈÎÒâ","°ïÅÉÊÕÈË","Ñ°ÕÒ°ïÅÉ",}, {"ÈÎÒâ","°ÝÊ¦","ÊÕÍ½",},};

-- ´ËÌõ¼þºÍÕ÷ÓÑÒªÇóÀï¶¨ÒåÒ»ÖÂ£¬ÒªÍ¬Ê±¸ü¸Ä,¼ÇµÃÏÂ±ê¼Ó1
local g_Conditions = {
	MenPai = {"Toàn bµ", "Thiªu Lâm", "Minh Giáo", "Cái Bang", "Võ Ðang", "Nga My", "Tinh Túc", "Thiên Long", "Thiên S½n", "Tiêu Dao"},
	Level = {"B¤t kÏ", "Dß¾i c¤p 10", "C¤p 10 ðªn 20", "C¤p 20 ðªn 30", "C¤p 30 ðªn 40", "C¤p 40 ðªn 50", "C¤p 50 ðªn 60", "C¤p 60 ðªn 70", "C¤p 70 ðªn 80", "C¤p 80 ðªn 90", "C¤p 90 ðªn 100", "Trên c¤p 100"},
	Sexy = {"Không gi¾i hÕn", "Nam", "Næ"},
	Mudi = { {"B¤t kÏ","Bang phái chiêu mµ","Tìm bang phái",}, {"B¤t kÏ","Bái sß","Thu nh§n ð® tØ",},}, 
};

-- ÉÔµÈµã»÷µÄÌáÊ¾
local g_strWaitClickTipText = "#{ZYPT_081127_2}"; --"²»¿ÉÁ¬Ðøµã»÷£¬ÇëÉÔµÈÆ¬¿ÌºóÔÙµã»÷¡£";

-- µ±Ç°ÆµµÀÀà±ðÓëÒ³Âë
local g_totalPlayerCount = 1
local g_curChannel = 6					-- Ä¬ÈÏÏÔÊ¾¡°×îÍúÈËÆø¡±ÆµµÀ
local g_curPageIndex = 1				-- Ä¬ÈÏÏÔÊ¾µÚ1Ò³
local g_totalPageCount = 1			-- ÐÅÏ¢ÁÐ±íµÄ×ÜÒ³Êý
local	g_totalVotePageCount = 1	-- ÈËÆøÐÅÏ¢ÁÐ±íµÄ×ÜÒ³Êý

-- ÆµµÀ×ÜÊý
local g_totalChannelCount = 7

-- µ±Ç°Íæ¼Ò¹ÜÀíµÄÕ÷ÓÑÀàÐÍ
local g_curZhengyouType = 1; 

-- µ±Ç°²éÑ¯½á¹ûÀàÐÍ£¬ÓÃÓÚÏÔÊ¾ÌáÊ¾ÐÅÏ¢ 
local g_curSearchResultType = -1; 

local MAXPAGECOUNT 			= 200;				-- ÐÅÏ¢ÁÐ±í×î¶à200Ò³
local MAXVOTEPAGECOUNT	= 1;					-- ÈËÆøÐÅÏ¢ÁÐ±í×î¶à1Ò³¡¢20Ìõ£¨ÒÔºó¿ÉÄÜ»áÀ©³äÖÁ5Ò³¡¢100Ìõ£©
local MAXCOUNTPERPAGE 	= 20;					-- Ã¿Ò³×î¶àÏÔÊ¾20Ìõ
local LEVEL_LIMIT 			= 10;					-- 10¼¶ÒÔÏÂÎÞ·¨´ò¿ª

-- Ö´ÐÐ²éÑ¯ºÍ¾ßÌå²Ù×÷µÄÀàÐÍ
local OPT_VOTE					= 1;					-- Í¶Æ±
local OPT_VIEWVOTE			= 2;					-- ²é¿´
local OPT_CHECK_EDIT		= 3;					-- ¸ü¸ÄÒªÇó
local OPT_CHECK_FABU    = 4;					-- ·¢²¼
local OPT_CHECK_CHEXIAO = 5;					-- ³·Ïú
local OPT_CHECK_GUANLI  = 6;					-- ¹ÜÀí

-- ½çÃæ¿Ø¼þ
local BtnPageUpDown = {};
local g_Ctrls = {};

-- ÀäÈ´Ê±¼äÏà¹Ø 
local g_iLastTime = 0;

local g_Timers = {0, 0, 0, 0, 0}; -- ÀäÈ´Ê±¼ä·Ö×é
local TIMER_TAB = 1;							-- tabÒ³     timerµÄË÷ÒýÖµ
local TIMER_SEARCH = 2;						-- ²éÕÒ
local TIMER_UPDATE = 3;						-- Ë¢ÐÂ
local TIMER_COMMONBTN = 4;				-- Ò»°ã°´Å¥

local MIN_TABTIME = 3; --°´tabµÄÊ±¼ä 
local MIN_SEARCHTIME = 10; 
local MIN_BTNTIME = 3; --µã¹¦ÄÜ°´Å¥µÄ¼ä¸ô £¨Ãë£© 
local MIN_UPDATETIME = 3;

function PlayerZhengyouPT_PreLoad()
	this:RegisterEvent("OPEN_WINDOW");														-- ´ò¿ªÕ÷ÓÑÆ½Ì¨Ö÷´°¿Ú
	this:RegisterEvent("UPDATE_FINDFRIEND_LIST");									-- ¸üÐÂÐÅÏ¢ÁÐ±í£¨ÆÕÍ¨ or ÈËÆø£©×ÜÌõÊý£¬µ±Ç°Ò³ÌõÊý
	this:RegisterEvent("ZHENGYOUPT_RESPONSE_PLAYERDETAILINFO");  	-- ÏÔÊ¾Ï¸½ÚÐÅÏ¢
	this:RegisterEvent("ZHENGYOUPT_RESPONSE_QUERYRESULT");				-- Ö´ÐÐ²Ù×÷µÄ·´À¡´¦Àí
	this:RegisterEvent("ZHENGYOUPT_FOCUSROW");										-- Ñ¡ÖÐÄÄÒ»ÐÐ¡¢ÄÄÒ»Ò³
	this:RegisterEvent("ZHENGYOUPT_RESPONSE_SEARCHPLAYERLIST");  	-- ²éÑ¯½á¹û
end

-- ÏÔÊ¾ÐÅÏ¢µÄ·¢²¼ÆµµÀÀàÐÍ
function PlayerZhengyouPT_GetTypeName(eType)
	if PlayerZhengyouPT_IsRealType(eType) then
		return g_Channels[eType];
	end
	
	if (eType == 6) then
		return "#{ZYPT_081103_108}"		-- "×îÍúÈËÆø"
	else		
		return "#{ZYPT_081103_007}"		-- ¡°È«²¿¡±ºÍ¡°²éÑ¯½á¹û¡±¾ù·µ»Ø¡°È«²¿¡±
	end
end

function PlayerZhengyouPT_GetGenderDesc(eSex)
	if ( 0 == eSex ) then
		return g_Genders[1];
	else
		return g_Genders[2];
	end
end

function PlayerZhengyouPT_GetMarryDesc(iMarry)
	if ( 0 == iMarry ) then
		return g_MarryDesc[1];
	else
		return g_MarryDesc[2];
	end
end

function PlayerZhengyouPT_GetMenpaiName(iMenpai)
	if ( iMenpai >= 0 and iMenpai < 10 ) then
		return g_MenPaiName[iMenpai + 1];
	end
	return "";
end

-- È¡µÃÃÅÅÉÐèÇóÃèÊö
function  PlayerZhengyouPT_GetMenpaiNeedDesc(iRet)
	local sDesc = g_Conditions.MenPai[iRet + 1];
	if ( nil ~= sDesc ) then
	    return sDesc;
	else
	    return "";
	end
end

-- È¡µÃÐÔ±ðÐèÇóÃèÊö
function  PlayerZhengyouPT_GetSexyNeedDesc(iRet)
	local sDesc = g_Conditions.Sexy[iRet + 1];
	if ( nil ~= sDesc ) then
	    return sDesc;
	else
	    return "";
	end
end

-- È¡µÃµÈ¼¶ÐèÇóÃèÊö
function  PlayerZhengyouPT_GetLevelNeedDesc(iRet)
	local sDesc = g_Conditions.Level[iRet + 1];
	if ( nil ~= sDesc ) then
	    return sDesc;
	else
	    return "";
	end
end

-- Õ÷ÓÑÄ¿µÄÃèÊö
-- ÊäÈë£ºÕ÷ÓÑÀàÐÍ£¬Ä¿µÄ 
function  PlayerZhengyouPT_GetZhengyouMudiDesc(iAdtype, iMudi)
    local iIdx = 0;
    if ( 2 == tonumber(iAdtype) ) then 
       PlayerZhengyouPT_Text4:Show();
       iIdx = 1;
       iMudi = iMudi - 1;
    elseif( 3 == tonumber(iAdtype) ) then
       PlayerZhengyouPT_Text4:Show();
       iIdx = 2;
       iMudi = iMudi - 4;
    else
       PlayerZhengyouPT_Text4:Hide();
       return "Trßng hæu giao tª";
    end
	local sDesc = g_Conditions.Mudi[iIdx][iMudi + 1];
	if ( nil ~= sDesc ) then
	    return sDesc;
	else
	    return "Trßng hæu giao tª";
	end
end 


function PlayerZhengyouPT_OnLoad()
	BtnPageUpDown = {PlayerZhengyouPT_PageUp, PlayerZhengyouPT_PageDown};
	g_Ctrls = {
		TxtName 	= PlayerZhengyouPT_Info2,     -- ¸öÈËÐÅÏ¢
		TxtSexy 	= PlayerZhengyouPT_Info3,
		TxtLevel 	= PlayerZhengyouPT_Info4,
		TxtMenpai 	= PlayerZhengyouPT_Info5,
        
		TxtBangpai 	= PlayerZhengyouPT_Info6,
		TxtMarry 	= PlayerZhengyouPT_Info7,
		TxtFabuTime	= PlayerZhengyouPT_Info8,   -- ·¢²¼Ê±¼ä
		TxtShyuTime = PlayerZhengyouPT_Info9,   -- Ê£ÓàÊ±¼ä
        
		TxtSexyNeed   = PlayerZhengyouPT_Text1,   -- ¸öÈËÒªÇó
		TxtLevelNeed  = PlayerZhengyouPT_Text2,
		TxtMenpaiNeed = PlayerZhengyouPT_Text3,
		TxtZhengyouMudi = PlayerZhengyouPT_Text4,
		
		TxtRenqi1     = PlayerZhengyouPT_Info_1,  -- ÈËÆøÏÔÊ¾
		TxtRenqi2     = PlayerZhengyouPT_Info_2,
		TxtRenqi3     = PlayerZhengyouPT_Info_3,
		TxtRenqi4     = PlayerZhengyouPT_Info_4,
		
		CtrlList	  = PlayerZhengyouPT_List,
		
		BtnChangeInfo = PlayerZhengyouPT_Change,
		
		TabSearch	  = PlayerZhengyouPT_Tab6,		-- ²éÑ¯½á¹û
		
		TxtVoteFull	  = PlayerZhengyouPT_Info12,
		
		TxtSearchResultTip = PlayerZhengyouPT_ResultInfo,
		
		Tabs		  = {
						 PlayerZhengyouPT_Tab1,					-- È«²¿
						 PlayerZhengyouPT_Tab2,					-- ÀÉ²ÅÅ®Ã²
						 PlayerZhengyouPT_Tab3,					-- À­°ï½á»ï
						 PlayerZhengyouPT_Tab4,					-- °ÝÊ¦Ñ°Í½
						 PlayerZhengyouPT_Tab5,					-- Òå½á½ðÀ¼
						 PlayerZhengyouPT_Tab6,					-- ²éÑ¯½á¹û
						 PlayerZhengyouPT_Tab7,					-- ×îÍúÈËÆø
						 },
	};
    
	g_Ctrls.TxtVoteFull:Hide(); --Í¶Æ±ÒÑÂúÐÅÏ¢ÒªÒþ²Ø 
	PlayerZhengyouPT_PageHeader:SetText("#{ZYPT_081103_006}");
end

-- Í¨Öª½Å±¾È¥¿Í»§¶ËÈ¡ÏêÏ¸ÐÅÏ¢
function PlayerZhengyouPT_NotifyPlayerDetailInfo(sResult, sMyInfo, sType)
	if ( "ok" ~= sResult ) then
		-- Ã»ÓÐÕý³£·µ»ØÏ¸½ÚÐÅÏ¢ÔòÐèÇå¿ÕÏÔÊ¾
		PlayerZhengyouPT_CleanDetailInfo();
		PushDebugMessage("R¤t tiªc, không có tin tÑc cüa ngß¶i ch½i này");    -- µ÷ÊÔÐÅÏ¢£¬Ó¦¸Ã²»»áÖ´ÐÐµ½
		return;
	end

	-- Èç¹ûÊÇÍæ¼Ò×Ô¼º·¢²¼µÄÐÅÏ¢£¬ÔòÏÔÊ¾¡°¸ü¸Ä¡±°´Å¥£¬·ñÔòÒþ²Ø¡£
	if ( "myinfo" == sMyInfo ) then
		g_curZhengyouType = tonumber(sType);
		g_Ctrls.BtnChangeInfo:Show();
	else
		g_Ctrls.BtnChangeInfo:Hide();
	end

	local iSexy = FindFriendDataPool:GetDetailInfo("SEX");
	local iMenpai = FindFriendDataPool:GetDetailInfo("MENPAI");
	local iMarry = FindFriendDataPool:GetDetailInfo("MARRY");
	local sFabuTime, sSpareTime = FindFriendDataPool:GetDetailInfo("SENDTIME");
	local iLevelNeed, iMenpaiNeed, iSexyNeed, iZhengyouMudi = FindFriendDataPool:GetDetailInfo("CONDITION");
	local iRenqi1, iRenqi2, iRenqi3, iRenqi4 = FindFriendDataPool:GetDetailInfo("HOTLEVEL");
	
	g_Ctrls.TxtName:SetText( "#{ZYPT_081103_024}" .. FindFriendDataPool:GetDetailInfo("NAME") );
	g_Ctrls.TxtSexy:SetText( "#{ZYPT_081103_035}" .. PlayerZhengyouPT_GetGenderDesc(iSexy) );
	g_Ctrls.TxtMarry:SetText( "#{ZYPT_081103_027}" .. PlayerZhengyouPT_GetMarryDesc(iMarry) );
	g_Ctrls.TxtLevel:SetText( "#{ZYPT_081103_025}" .. FindFriendDataPool:GetDetailInfo("LEVEL") );
	g_Ctrls.TxtMenpai:SetText( "#{ZYPT_081103_026}" .. PlayerZhengyouPT_GetMenpaiName(iMenpai) );
	g_Ctrls.TxtBangpai:SetText( "#{ZYPT_081103_028}" .. FindFriendDataPool:GetDetailInfo("GUILD") );
	g_Ctrls.TxtFabuTime:SetText( "#{ZYPT_081103_029}" .. sFabuTime );
	g_Ctrls.TxtShyuTime:SetText( "#{ZYPT_081103_030}" .. sSpareTime .."Ngày");
	
	g_Ctrls.TxtSexyNeed:SetText( "#{ZYPT_081103_035}" .. PlayerZhengyouPT_GetSexyNeedDesc(iSexyNeed) );
	g_Ctrls.TxtLevelNeed:SetText( "#{ZYPT_081103_036}" .. PlayerZhengyouPT_GetLevelNeedDesc(iLevelNeed) );
	g_Ctrls.TxtMenpaiNeed:SetText( "#{ZYPT_081103_037}" .. PlayerZhengyouPT_GetMenpaiNeedDesc(iMenpaiNeed) );
	g_Ctrls.TxtZhengyouMudi:SetText( "Møc ðích: " .. PlayerZhengyouPT_GetZhengyouMudiDesc(sType, iZhengyouMudi) );
    
	g_Ctrls.TxtRenqi1:SetText( tostring(iRenqi1) );
	g_Ctrls.TxtRenqi2:SetText( tostring(iRenqi2) );
	g_Ctrls.TxtRenqi3:SetText( tostring(iRenqi3) );
	g_Ctrls.TxtRenqi4:SetText( tostring(iRenqi4) );
end

-- Çå¿ÕÕ÷ÓÑ´°¿ÚÓÒ²à¿Ø¼þÏÔÊ¾µÄÄÚÈÝ
function  PlayerZhengyouPT_CleanDetailInfo()
	g_Ctrls.TxtName:SetText( "#{ZYPT_081103_024}" );
	g_Ctrls.TxtSexy:SetText( "#{ZYPT_081103_035}" );
	g_Ctrls.TxtMarry:SetText( "#{ZYPT_081103_027}" );
	g_Ctrls.TxtLevel:SetText( "#{ZYPT_081103_025}" );
	g_Ctrls.TxtMenpai:SetText( "#{ZYPT_081103_026}" );
	g_Ctrls.TxtBangpai:SetText( "#{ZYPT_081103_028}" );
	g_Ctrls.TxtFabuTime:SetText( "#{ZYPT_081103_029}" );
	g_Ctrls.TxtShyuTime:SetText( "#{ZYPT_081103_030}" );

	g_Ctrls.TxtSexyNeed:SetText( "#{ZYPT_081103_035}" );
	g_Ctrls.TxtLevelNeed:SetText( "#{ZYPT_081103_036}"  );
	g_Ctrls.TxtMenpaiNeed:SetText( "#{ZYPT_081103_037}"  );
	g_Ctrls.TxtZhengyouMudi:SetText( "" );

	g_Ctrls.TxtRenqi1:SetText( "" );
	g_Ctrls.TxtRenqi2:SetText( "" );
	g_Ctrls.TxtRenqi3:SetText( "" );
	g_Ctrls.TxtRenqi4:SetText( "" );
    
	g_Ctrls.BtnChangeInfo:Hide();
end

function PlayerZhengyouPT_OnEvent(event)
	--PushDebugMessage("Event : "..event)

	if(event == "OPEN_WINDOW") then		
		if( arg0 == "PlayerZhengyouPTWindow") then
			--Èç¹ûÒÑ¾­ÏÔÊ¾¾ÍÓ¦¸Ã¹Øµô
			if ( this:IsVisible() ) then
			   this:Hide();
			   return;
			end
			CloseWindow("ZhengyouWindow");
			InitAndShowZhengyouWindow();
		end
	
	elseif(event == "CLOSE_WINDOW") then
		if( arg0 == "PlayerZhengyouPTWindow") then
			this:Hide();
		end

	elseif(event == "UPDATE_FINDFRIEND_LIST") then
		--PushDebugMessage ("iTotal = "..arg0..", iTotalOfCurPage = "..arg1)
		PlayerZhengyouPT_UpdateFriendList(arg0, arg1);

	elseif (event == "ZHENGYOUPT_RESPONSE_QUERYRESULT") then
		--PushDebugMessage ("sOptType = "..arg0..", sRet = "..arg1..", eType = "..arg2..", iReserve = "..arg3)
	  PlayerZhengyouPT_OnQueryResponse(arg0, arg1, arg2, arg3);			-- Ö´ÐÐ²Ù×÷µÄ·´À¡´¦Àí

	elseif ("ZHENGYOUPT_RESPONSE_PLAYERDETAILINFO" 	== event) then
		--PushDebugMessage ("sResult = "..arg0..", sMyInfo = "..arg1..", sType = "..arg2)
	  PlayerZhengyouPT_NotifyPlayerDetailInfo(arg0, arg1, arg2);

	elseif ("ZHENGYOUPT_FOCUSROW" == event) then
		--PushDebugMessage ("iRowIndex = "..arg0..", iPageNo = "..arg1)
	  PlayerZhengyouPT_SetFocusRowAndPageNo(arg0, arg1);						-- Ñ¡ÖÐÐÐºÅ¡¢Ò³ºÅ

	elseif ("ZHENGYOUPT_RESPONSE_SEARCHPLAYERLIST" == event ) then
		--PushDebugMessage ("sRet = "..arg0..", eType = "..arg2)
		PlayerZhengyouPT_OnSearchPlayerResponse(arg0, arg2); 					-- µÚ3¸ö²ÎÊý±íÊ¾ÀàÐÍ£¬ÎªintÖµ
	end

end

-- ³õÊ¼»¯Íæ¼ÒÕ÷ÓÑÆ½Ì¨´°¿Ú
function InitAndShowZhengyouWindow()
	PlayerZhengyouPT_UpdateBtnStatus();
	PlayerZhengyouPT_CleanPlayerList(); --ÐèÒªÏÈÇå³ýÁÐ±í£¬·ÀÖ¹ÏÔÊ¾ÎÞÓÃµÄ
	PlayerZhengyouPT_SetCurrentTab(6);	-- Ä¬ÈÏÑ¡ÖÐ¡°×îÍúÈËÆø¡±ÆµµÀ
	this:Show();

	-- ´Ë´¦ÇëÇóÏÔÊ¾¡°×îÍúÈËÆø¡±ÀàÐÍµÄÁÐ±í
	RequestFindFriendList(g_curChannel, g_curPageIndex); -- 6ÀàÐÍ£¬µÚ1Ò³	
end

--¸üÐÂÍæ¼ÒÁÐ±í
function PlayerZhengyouPT_UpdateFriendList(iTotal, iTotalOfCurPage)
	--PushDebugMessage("UpdateFriendList : CurrentChannel = "..g_curChannel)

	PlayerZhengyouPT_CleanPlayerList();

	--¸ù¾Ý´ËÀàÐÍÍæ¼Ò×ÜÊý¼ÆËãÒ³Êý
	g_totalPlayerCount = iTotal;
	
	-- ÆäËûÆµµÀÒ³Êý
	if (math.mod(g_totalPlayerCount, MAXCOUNTPERPAGE) ~= 0 ) then
		g_totalPageCount = math.floor(g_totalPlayerCount / MAXCOUNTPERPAGE) + 1;
	else
		g_totalPageCount = math.floor(g_totalPlayerCount / MAXCOUNTPERPAGE);
	end
	
	-- ÆäËûÆµµÀ×î¶àÏÔÊ¾µÄÒ³Êý
	if(g_totalPageCount > MAXPAGECOUNT) then
		g_totalPageCount = MAXPAGECOUNT;
	end

	-- ÈËÆøÆµµÀÒ³Êý
	if (math.mod(g_totalPlayerCount, MAXCOUNTPERPAGE) ~= 0 ) then
		g_totalVotePageCount = math.floor(g_totalPlayerCount / MAXCOUNTPERPAGE) + 1;
	else
		g_totalVotePageCount = math.floor(g_totalPlayerCount / MAXCOUNTPERPAGE);
	end
	
	-- ÈËÆøÆµµÀ×î¶àÏÔÊ¾µÄÒ³Êý	
	if(g_totalVotePageCount > MAXVOTEPAGECOUNT) then
		g_totalVotePageCount = MAXVOTEPAGECOUNT;
	end

	-- È¡µÃµ±Ç°Ò³ÃæÍæ¼ÒµÄÊýÄ¿
	local playercount = iTotalOfCurPage;
	local i = 0;
	for i = 0, playercount -1 do
		local iGuid, strName, iGender, iRenqi, iType, iLevel;
		if (g_curChannel ~= 6) then			
			-- Èç¹û²»ÊÇ¡°×îÍúÈËÆø¡±ÆµµÀ£¬°´·¢²¼Ê±¼äµÄÏÈºóÀ´ÏÔÊ¾
			iGuid, strName, iGender, iRenqi, iType, iLevel = PlayerZhengyouPT_GetPlayerSimpleInfo(i);
		else
			-- ¡°ÈËÆø×îÍú¡±ÆµµÀ£¬°´ÕÕÈËÆøµÄ¸ßµÍË³ÐòÀ´ÏÔÊ¾
			iGuid, strName, iGender, iRenqi, iType, iLevel = PlayerZhengyouPT_GetPlayerSimpleVoteInfoByPos(i);			
		end
			
		-- µÚ1ÁÐ£ºÐÕÃû
		PlayerZhengyouPT_List:AddNewItem(strName, 0, i);
		
		-- µÚ2ÁÐ£ºÀàÐÍ or µÈ¼¶
		if ( 0 == g_curChannel or 5 == g_curChannel or 6 == g_curChannel) then
			-- È«²¿¡¢²éÑ¯½á¹û¡¢×îÍúÈËÆøÆµµÀÀïÏÔÊ¾ÀàÐÍ
		  PlayerZhengyouPT_List:AddNewItem(PlayerZhengyouPT_GetTypeName(iType), 1, i);
		else
			-- ¾ßÌåÀàÐÍÀïÏÔÊ¾µÈ¼¶
		  PlayerZhengyouPT_List:AddNewItem(iLevel, 1, i);			
		end
		
		-- µÚ3ÁÐ£ºÐÔ±ð
		PlayerZhengyouPT_List:AddNewItem(PlayerZhengyouPT_GetGenderDesc(iGender), 2, i);

		-- µÚ4ÁÐ£ºÈËÆø(ÈËÆøµÄÆ±ÊýÊÇ¡°Âú×ãÒªÇó¡±¡¢¡°Ìõ¼þ²»´í¡±¡¢¡°ÒªÇóÌ«¸ß¡±¡¢¡°ÎÒÃ»ÐËÈ¤¡±Õâ4ÏîµÄ×ÜÆ±Êý)
		-- ¸ù¾ÝÈËÆø¼Ó±ê¼Ç
		local strRenqi;
		if (iRenqi >= 80) then
			strRenqi = tostring(iRenqi) .. "" .. "#cff0000(ð¥y)";
		elseif ( iRenqi >= 60 ) then
			strRenqi = tostring(iRenqi) .. "" .. "#cff6633(nóng)";
		else
			strRenqi = tostring(iRenqi);
		end
		PlayerZhengyouPT_List:AddNewItem(strRenqi, 3, i);
	end	
	
	-- ¸üÐÂÏÂÃæµÄº¯ÊýÖÐÖ¸¶¨µÄ¼¸¸ö°´Å¥×´Ì¬
	PlayerZhengyouPT_UpdateBtnStatus();
end

-- µÃµ½µ±Ç°Ò³ÉÏµÚiIdx¸öÍæ¼ÒµÄÏÔÊ¾ÐÅÏ¢£¨°´·¢²¼Ê±¼äÏÈºóÅÅÁÐ£©
function PlayerZhengyouPT_GetPlayerSimpleInfo(iIdx)	
	return FindFriendDataPool:GetSimpleInfoByPos(iIdx);	
end

-- µÃµ½µ±Ç°Ò³ÉÏµÚiIdx¸öÍæ¼ÒµÄÏÔÊ¾ÐÅÏ¢£¨°´Í¶Æ±ÊýÄ¿¶àÉÙÅÅÁÐ£©
function PlayerZhengyouPT_GetPlayerSimpleVoteInfoByPos(iIdx)
	return FindFriendDataPool:GetSimpleVoteInfoByPos(iIdx);	
end

-- ·­Ò³
function OnPlayerZhengyouPT_PageUpClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_BTNTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	g_curPageIndex = g_curPageIndex - 1;
	PlayerZhengyouPT_UpdateBtnStatus();
	if ( g_curPageIndex < 1 ) then
		g_curPageIndex = 1;
	end
	
	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

function OnPlayerZhengyouPT_PageDownClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_BTNTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	g_curPageIndex = g_curPageIndex + 1;
	PlayerZhengyouPT_UpdateBtnStatus();
	
	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

-- ¸üÐÂ¡°Ê×Ò³¡±¡¢¡°Ä©Ò³¡±¡¢¡°Ç°Ò»Ò³¡±¡¢¡°ºóÒ»Ò³¡±Õâ4¸ö°´Å¥ºÍÒ³ÂëÏÔÊ¾µÄ×´Ì¬
function PlayerZhengyouPT_UpdateBtnStatus()
	-- ÈËÆøÆµµÀ
	if (g_curChannel == 6) then
		-- µ±Ç°µÚ1Ò³£º½ûÓÃ¡°Ç°Ò»Ò³¡±¡¢¡°Ê×Ò³¡±
		if( g_curPageIndex <= 1 ) then
			BtnPageUpDown[1]:Disable();
			PlayerZhengyouPT_FirstPage:Disable();
		end
  	
		-- µ±Ç°×îºóÒ»Ò³£º½ûÓÃ¡°ºóÒ»Ò³¡±¡¢¡°Ä©Ò³¡±
		if( g_curPageIndex >= g_totalVotePageCount ) then
			BtnPageUpDown[2]:Disable();
			PlayerZhengyouPT_LastPage:Disable();
		end
  	
		-- µ±Ç°²»ÊÇµÚ1Ò³£º¼¤»î¡°Ç°Ò»Ò³¡±¡¢¡°Ê×Ò³¡±
		if (g_curPageIndex > 1 ) then 
			BtnPageUpDown[1]:Enable(); 
			PlayerZhengyouPT_FirstPage:Enable();
		end
  	
		-- µ±Ç°²»ÊÇ×îºóÒ»Ò³£º¼¤»î¡°ºóÒ»Ò³¡±¡¢¡°Ä©Ò³¡±
		if (g_curPageIndex < g_totalVotePageCount ) then 
			BtnPageUpDown[2]:Enable(); 
			PlayerZhengyouPT_LastPage:Enable();
		end
		
		local curPage = g_curPageIndex;
		if ( curPage > g_totalVotePageCount ) then
			curPage = g_totalVotePageCount;
		end
  	
		-- ¸üÐÂAmount¿Ø¼þÏÔÊ¾µÄ¡°µ±Ç°Ò³/ËùÓÐÒ³¡±
		PlayerZhengyouPT_Amount:SetText(curPage.."/"..g_totalVotePageCount);
		
		-- ¸üÐÂGotoEditBox¿Ø¼þÏÔÊ¾µÄÐèÒªÇ°ÍùµÄÒ³Âë
		PlayerZhengyouPT_GotoEditBox:SetText(tostring(g_curPageIndex));

	-- ÆäËûÆµµÀ
	else	
		-- µ±Ç°µÚ1Ò³£º½ûÓÃ¡°Ç°Ò»Ò³¡±¡¢¡°Ê×Ò³¡±
		if( g_curPageIndex <= 1 ) then
			BtnPageUpDown[1]:Disable();
			PlayerZhengyouPT_FirstPage:Disable();
		end
  	
		-- µ±Ç°×îºóÒ»Ò³£º½ûÓÃ¡°ºóÒ»Ò³¡±¡¢¡°Ä©Ò³¡±
		if( g_curPageIndex >= g_totalPageCount ) then
			BtnPageUpDown[2]:Disable();
			PlayerZhengyouPT_LastPage:Disable();
		end
  	
		-- µ±Ç°²»ÊÇµÚ1Ò³£º¼¤»î¡°Ç°Ò»Ò³¡±¡¢¡°Ê×Ò³¡±
		if (g_curPageIndex > 1 ) then 
			BtnPageUpDown[1]:Enable(); 
			PlayerZhengyouPT_FirstPage:Enable();
		end
  	
		-- µ±Ç°²»ÊÇ×îºóÒ»Ò³£º¼¤»î¡°ºóÒ»Ò³¡±¡¢¡°Ä©Ò³¡±
		if (g_curPageIndex < g_totalPageCount ) then 
			BtnPageUpDown[2]:Enable(); 
			PlayerZhengyouPT_LastPage:Enable();
		end
		
		local curPage = g_curPageIndex;
		if ( curPage > g_totalPageCount ) then
			curPage = g_totalPageCount;
		end
  	
		-- ¸üÐÂAmount¿Ø¼þÏÔÊ¾µÄ¡°µ±Ç°Ò³/ËùÓÐÒ³¡±
		PlayerZhengyouPT_Amount:SetText(curPage.."/"..g_totalPageCount);
		
		-- ¸üÐÂGotoEditBox¿Ø¼þÏÔÊ¾µÄÐèÒªÇ°ÍùµÄÒ³Âë
		PlayerZhengyouPT_GotoEditBox:SetText(tostring(g_curPageIndex));
	end
end

function PlayerZhengyouPT_PassTime(iIdx, iSeconds)
   local iCur = FindFriendDataPool:GetTickCount();
   if ( iCur - g_Timers[iIdx] < iSeconds * 1000) then
      return false;
   else
      g_Timers[iIdx] = iCur;
   	  return true;
   end
end 

-- Ñ¡Ôñ²»Í¬µÄ±êÇ©µÄÏÔÊ¾ ,  ´Ë´¦Ó¦ÑÓÊ±£¬·ÀÖ¹Á¬Ðøµã»÷
function PlayerZhengyouPT_ChannalChange(iChannel)
	-- µã»÷µ±Ç°Ñ¡ÖÐµÄ±êÇ©Ó¦¸ÃÎÞ²Ù×÷
	if (g_curChannel == iChannel) then
		return;
	end

	-- ²»ÄÜ¹ýÆµÇÐ»»±êÇ©
	if not PlayerZhengyouPT_PassTime(TIMER_TAB, MIN_TABTIME) then
		--PlayerZhengyouPT_SetCurrentTab(g_curChannel);
		-- Ñ¡ÖÐµ±Ç°ÆµµÀ
		g_Ctrls.Tabs[g_curChannel + 1]:SetCheck(1);
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	PlayerZhengyouPT_CleanPlayerList();
	
	-- µãµ½²éÑ¯tabÊ±Ó¦Çå³ýÁÐ±íµ«²»Ìá½»ÇëÇó
	--if ( 5 == iChannel ) then
	   --return;
	--end 
	
	g_curChannel 			= iChannel;
	g_curPageIndex 		= 1;
	g_totalPageCount 	= 0;
	g_totalVotePageCount = 0;
	
	PlayerZhengyouPT_UpdateBtnStatus(); --·ÀÖ¹µãµ½¿ÕÒ³Ê±°´Å¥Ã»±ä»Ò
	
	PlayerZhengyouPT_SetCurrentTab(iChannel);
	
	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

-- È«²¿µÄ×´Ì¬ÏÂ´ò¿ª¡°·¢²¼¡±ÐÅÏ¢½çÃæ£¬ÔÚ¾ßÌåÀàÐÍ±êÇ©ÏÂ´ò¿ªÌõ¼þÉè¶¨½çÃæ
function OnPlayerZhengyouPT_FabuClicked()
	local level = Player:GetData("LEVEL");
	if level < LEVEL_LIMIT then
		PushDebugMessage("R¤t tiªc, c¥n ðÕt ðªn c¤p " .. LEVEL_LIMIT .. "m¾i ðßþc công b¯ " .. PlayerZhengyouPT_GetTypeName(g_curChannel) .. "Thông tin");
		return;
	end
	-- Ñ¡ÔñÁË¾ßÌåÀàÐÍÔòÖ±½Ó²éÑ¯ÊÇ·ñÂú×ã·¢²¼Ìõ¼þ£¬·ñÔò´ò¿ªÀàÐÍÑ¡Ôñ½çÃæ
	if ( not PlayerZhengyouPT_SendCheckRequest(g_curChannel, OPT_CHECK_FABU) ) then
		OpenWindow("ZhengyouInfoFabu_fabu"); --Ã»Ñ¡Ôñ¾ßÌå·¢²¼ÀàÐÍ		
	end
end

-- È«²¿µÄ×´Ì¬ÏÂ´ò¿ª¡°³·Ïú¡±ÐÅÏ¢½çÃæ£¬ÔÚ¾ßÌåÀàÐÍ±êÇ©ÏÂ´ò¿ªÌõ¼þÉè¶¨½çÃæ
function OnPlayerZhengyouPT_ChexiaoClicked()
	if ( not PlayerZhengyouPT_SendCheckRequest(g_curChannel, OPT_CHECK_CHEXIAO) ) then
		OpenWindow("ZhengyouInfoFabu_chexiao");	--Ã»Ñ¡Ôñ¾ßÌå·¢²¼ÀàÐÍ		
	end
end

-- È«²¿µÄ×´Ì¬ÏÂ´ò¿ª¡°¹ÜÀí¡±ÐÅÏ¢½çÃæ£¬ÔÚ¾ßÌåÀàÐÍ±êÇ©ÏÂ´ò¿ªÌõ¼þÉè¶¨½çÃæ
function OnPlayerZhengyouPT_GuanliClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_BTNTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	if ( not PlayerZhengyouPT_SendCheckRequest(g_curChannel, OPT_CHECK_GUANLI) ) then
		OpenWindow("ZhengyouInfoFabu_guanli");	--Ã»Ñ¡Ôñ¾ßÌå·¢²¼ÀàÐÍ		
	end
end

-- Ö´ÐÐ·¢²¼¡¢³·Ïú»ò¹ÜÀíµÄÇëÇó
-- eType : Õ÷ÓÑÀàÐÍ
-- opt   : Ö´ÐÐµÄÇëÇóÀàÐÍ£º·¢²¼, ³·Ïú ,¹ÜÀí
function PlayerZhengyouPT_SendCheckRequest(eType, opt)
	if (not PlayerZhengyouPT_IsRealType(eType) ) then
	    return false;
	end
	
	-- ·¢ËÍ¾ßÌå²éÑ¯ÇëÇó
	FindFriendQuery(opt, eType, g_curChannel);
	return true;
end

-- Íæ¼ÒÈ·ÈÏÒª³·Ïú
function PlayerZhengyouPT_MessageChexiaoOK(eType)
	RequestDeleteFindFriendInfo(tonumber(eType), g_curChannel);
end

function PlayerZhengyouPT_MessageChexiaoCancel()

end

-- Ö´ÐÐ²Ù×÷µÄ·´À¡´¦Àí 
function PlayerZhengyouPT_OnQueryResponse(sOptType, sRet, eType, iReserve)
	local iType = tonumber(eType);
	if ( nil == iType ) then
	    PushDebugMessage("Thao tác Chính Hæu phän h°i thông tin sai");
	    return;
	end

	-- ¹ÜÀí
	if ( "check_guanli" == sOptType ) then
	    if ( "ok" == sRet ) then
				-- ¶¨Î»µ½¹ÜÀíµÄÏàÓ¦ÀàÐÍ±êÇ©
				PlayerZhengyouPT_SetCurrentTab(iType); 
	    elseif ( "noinfo" == sRet ) then
	      PushDebugMessage("#{ZYPT_081103_068}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_073}");
	    end

	-- ÊÇ·ñ¿ÉÒÔ³·Ïú
	elseif ( "check_chexiao" == sOptType ) then
	    if ("sure"  == sRet ) then -- ÒªÇóÈ·ÈÏÉ¾³ý
	      MessageBoxCommon("#{ZYPT_081103_101}", "#{ZYPT_081103_070}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_071}",
				"PlayerZhengyouPT", "MessageChexiaoOK(" .. iType .. ")", "MessageChexiaoCancel()");
	    elseif ("noinfo" == sRet) then
	      PushDebugMessage("#{ZYPT_081103_068}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_069}");
	    end

	-- ÊÇ·ñ¿ÉÒÔ·¢²¼
	elseif ( "check_fabu" == sOptType ) then
	    if ( "ok" == sRet) then
	      --PushDebugMessage("ÌáÊ¾·¢²¼Ìõ¼þ");
	    elseif ( "in24hours" == sRet ) then
	      PushDebugMessage("#{ZYPT_081103_060}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_061}");
	    elseif ( "exist" == sRet ) then
	      PushDebugMessage("#{ZYPT_081103_058}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_059}");
	    elseif ( "full" == sRet ) then
	      PushDebugMessage("#{ZYPT_081103_062}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_063}");
	    end

	-- ·¢²¼
	elseif ( "fabu" == sOptType ) then
		if ( "ok" == sRet ) then
		  PushDebugMessage("#{ZYPT_081103_106}" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_107}");    -- ·¢²¼³É¹¦µÄÌáÊ¾ 
		  -- ·¢²¼ºó£¬ÇÐ»»µ½·¢²¼ÀàÐÍ¶ÔÓ¦µÄÆµµÀ
		  PlayerZhengyouPT_SetCurrentTab(iType);
		end

	-- ²é¿´
	elseif ("view_vote" == sOptType) then
		if ( "noinfo" == sRet ) then 
		  PushDebugMessage("Xin l²i, thông tin các hÕ bö phiªu không t°n tÕi.");		-- Ó¦¸Ã²»»áÖ´ÐÐµ½ÕâÀï
		end

	-- Í¶Æ±
  elseif ("vote" == sOptType) then
    if ("done" == sRet) then
      PushDebugMessage("#{ZYPT_081103_080}"); --("¶Ô²»Æð£¬ÄúÒÑ¾­¶Ô±¾ÌõÐÅÏ¢Í¶¹ýÆ±ÁË£¬ÎÞÐèÔÙ´ÎÍ¶Æ±¡£");
    elseif("full" == sRet) then
      PushDebugMessage("#{ZYPT_081103_079}"); --("¶Ô²»Æð£¬±¾ÌõÐÅÏ¢Í¶Æ±ÈËÊýÒÑÂú£¬ÎÞ·¨½øÐÐÍ¶Æ±¡£");
		elseif("ok" == sRet) then
		  -- Èç¹ûÊÇÔÚ²éÑ¯½á¹ûÆµµÀ£¬ÇÐtabºÍ¸øÌáÊ¾
		  -- ×¢Òâ£º×îÍúÈËÆøÆµµÀ²»ÇÐTab£¬Í¶Æ±ºóÈÔÏÔÊ¾×îÍúÈËÆøÒ³Ãæ£¡£¡£¡
      if (g_curChannel == 5) then
        PlayerZhengyouPT_SetCurrentTab(iType); 		-- Èç¹ûÊÇÔÚ²éÑ¯½á¹ûÆµµÀ£¬Í¶Æ±Íê³Éºó£¬ÇÐ»»µ½Í¶Æ±ÀàÐÍ¶ÔÓ¦µÄÆµµÀ
      end
          
		  local sVoteOkTip = string.format("Các hÕ ðã bö phiêu cho %s thành công", FindFriendDataPool:GetDetailInfo("NAME") );
		  PushDebugMessage( sVoteOkTip );
    end

  -- ³·Ïú
  elseif ("delete" == sOptType) then
	  if( "ok" == sRet ) then
	  	-- ³·Ïúºó£¬ÇÐ»»µ½·¢²¼ÀàÐÍ¶ÔÓ¦µÄÆµµÀ
    	PlayerZhengyouPT_SetCurrentTab(iType);
	    PushDebugMessage("Các hÕ giäi khóa thành công" .. PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_107}");
	  end

	-- ¸ü¸ÄÕ÷ÓÑÒªÇó
	elseif ("editcondition" == sOptType ) then
		if( "ok" == sRet ) then
			-- ¸ü¸ÄÕ÷ÓÑÒªÇóºó£¬ÇÐ»»µ½·¢²¼ÀàÐÍ¶ÔÓ¦µÄÆµµÀ
    	PlayerZhengyouPT_SetCurrentTab(iType);
	    PushDebugMessage("SØa ð±i thông tin thành công");
	  end
	end

end


	--*****************************************
	--CEGUIÓÐÒ»´¦Ð´µÄ²»ºÏÀíµÄµØ·½(Bug?)....µ¼ÖÂ¶àÁÐÁÐ±íÉèÖÃÊôÐÔÊ±»á³öÏÖÒ»Ð©´íÎó....
	--¾ßÌåÎª£º
	--ÔÚXMLÖÐ¸ø¶àÁÐÁÐ±íÅäÖÃÁËColumnsSizable=True....¾Í»áÉèÖÃ¸Ã¿Ø¼þµÄColumnsSizable=True....»¹»áÉèÖÃÆäËùÓÐÁÐµÄColumnsSizable=True....
	--ÓÐÐ©¶àÁÐÁÐ±íÈç±¾´°¿ÚµÄÐèÒªÔÚ½Å±¾ÖÐ¶¯Ì¬µÄ²åÈëÁÐ....ÕâÊ±XMLÖÐÅäÖÃµÄColumnsSizable=TrueÖ»»áÉèÖÃ¸Ã¿Ø¼þµÄColumnsSizable=True....²»»áÉèÖÃÁÐµÄColumnsSizable=True(ÒòÎªµ±Ê±Ò»¸öÁÐ¶¼Ã»ÓÐ)....
	--Òò´ËÔÚ½Å±¾ÖÐ¶¯Ì¬²åÈëÁÐºóÁÐµÄColumnsSizableÒòÎªÃ»±»ÉèÖÃ¹ý¾Í²»ÊÇTrue....
	--Èç¹ûÏëÔÚ¶¯Ì¬²åÈëÁÐºóÔÚ½Å±¾ÀïÔÙÖØÐÂ¸ø¶àÁÐÁÐ±íÉèÖÃColumnsSizable=TrueÒ²²»ÐÐ....
	--ÒòÎªÉèÖÃ¸ÃÊôÐÔµÄÖµÊ±»áÅÐ¶ÏÊÇ·ñÓëµ±Ç°¸ÃÊôÐÔµÄÖµÒ»Ñù....Èç¹ûÒ»Ñù¾ÍÖ±½Ó·µ»Ø....¶ø¸Ã¿Ø¼þµÄColumnsSizableÔÚ³õÊ¼»¯XMLµÄÊ±ºò±»Éè³ÉTrueÁËËùÒÔ»áÖ±½Ó·µ»Ø....Ò²¾Í²»»á¸øËüµÄÁÐÉèÖÃ¸ÃÊôÐÔ....
	--Òò´ËÈç¹ûÏë¶¯Ì¬²åÈëÁÐ¾ÍÐèÒªÔÚ¶¯Ì¬²åÈëºóÔÙÉèÖÃºÍÁÐÓÐ¹ØµÄÊôÐÔ....Í¬Ê±ÔÚXMLÖÐ²»ÄÜ¶ÔºÍÁÐÓÐ¹ØµÄÊôÐÔ½øÐÐÉèÖÃ....
	--*****************************************
	
	-- ×¢£º ÉÏ±ßµÄ½âÊÍÒý×ÔAutoSearch.lua, ´Ë´¦³¢ÊÔÔÚ½Å±¾ÀïÏÈÉèÖÃ³É×Ô¼ºÒªÉèÖÃ³ÉµÄÊôÐÔÖµµÄÏà·´Öµ£¬ÔÙÉèÖÃ³ÉÄ¿±êÖµ£¬Ö¤Ã÷ÊÇ¿ÉÐÐµÄ¡£ by cuiyinjie 2008-10-29 
  -- ×¢ÒâÒªÏÈµ÷ÓÃ´Ëº¯ÊýÔÙÍùlistctrlÀï²åÈë£¬·ñÔò»áÉ¾µô1ÁÐµÄÐÅÏ¢¡£ 
-- ¼¤»îÖ¸¶¨µÄ±êÇ© 
function PlayerZhengyouPT_SetCurrentTab(iTab)
	local sText = "#{ZYPT_081103_014}"; --"ÀàÐÍ";

	-- ÆµµÀÀàÐÍÎª1¡¢2¡¢3¡¢4Ê±ÏÔÊ¾¡°µÈ¼¶¡±£¬0¡¢5¡¢6Ê±ÏÔÊ¾¡°ÀàÐÍ¡±¡£
	if ( iTab > 0 and iTab < 5 ) then
		sText = "ÐÆng c¤p";	
	end
   
	g_Ctrls.CtrlList:SetProperty("ColumnsSizable", "True");
	g_Ctrls.CtrlList:SetProperty("ColumnsMovable", "True");
	g_Ctrls.CtrlList:SetProperty("ColumnsAdjust", "False");
   
	PlayerZhengyouPT_CleanPlayerList(); --ÏÈÇåµô£¬·ÀÖ¹ÐÂÊý¾Ý»ØÀ´Íí³öÏÖ¿ÕÁÐ
	g_Ctrls.CtrlList:RemoveColumnByPos(1);
	g_Ctrls.CtrlList:InsertColumn(sText, 1, 0.23, 1);
	
	g_Ctrls.CtrlList:SetProperty("ColumnsSizable", "False");
	g_Ctrls.CtrlList:SetProperty("ColumnsMovable", "False");
	g_Ctrls.CtrlList:SetProperty("ColumnsAdjust", "True");
   
	if ( iTab >= 0 and iTab < g_totalChannelCount ) then
		-- Ñ¡ÖÐµ±Ç°ÆµµÀ
    g_Ctrls.Tabs[iTab + 1]:SetCheck(1);
    g_curChannel = iTab;
  end
  
	PlayerZhengyouPT_UpdateSearchTip();	
end

-- ÊÇ·ñ¾ßÌåÀàÐÍ
function PlayerZhengyouPT_IsRealType(eType)
  local iType = tonumber(eType);
	if ( nil == iType ) then
	  PushDebugMessage("Thao tác Chính Hæu phän h°i thông tin sai");
	end
	
	-- ÆµµÀÀàÐÍÎª1¡¢2¡¢3¡¢4ÎªºÏ·¨£¬0¡ª¡ª¡°È«²¿¡±¡¢5¡ª¡ª¡°²éÑ¯½á¹û¡±¡¢6¡ª¡ª¡°×îÍúÈËÆø¡±²»ÊôÓÚ¾ßÌåµÄÆµµÀÀàÐÍ
  if ( iType > 0 and iType < 5 ) then
    return true;
  end

  return false;
end

-- ÁÐ±íÖÐÑ¡ÔñÄ³Ò»ÐÐµÄÏàÓ¦º¯Êý
function PlayerZhengyouPT_List_OnSelectionChanged()
	local nSel = PlayerZhengyouPT_List:GetSelectItem();	-- µ±Ç°Ñ¡ÔñµÄÐÐºÅ
	local nSearchTab = g_Ctrls.TabSearch:GetCheck();		-- ÊÇ·ñÊÇ²éÑ¯ÆµµÀ	
	
	if ( nSel < 0 ) then
		return;
	else
		-- Èç¹ûÊÇÈËÆøÆµµÀ£¬Ôò´Ó°´ÈËÆøÅÅÁÐµÄÈËÆøÐÅÏ¢ÁÐ±íÖÐÇëÇóÊý¾Ý¡£
		-- ÆäËûÆµµÀÔò´Ó°´Ê±¼äÅÅÁÐµÄÔ­Ê¼Êý¾ÝÁÐ±íÖÐÇëÇóÊý¾Ý¡£
		RequestFindFriendDetailInfo(nSel, nSearchTab, g_curChannel);	 -- µ÷ÓÃc++µÄº¯Êý,ÒªÇø·ÖÊÇ·ñÔÚ²éÕÒ½á¹ûÀïÑ¡Ôñ£¬¿Í»§¶ËÒª´Ó²»Í¬µÄ½á¹û³ØÀï·µ»Ø½á¹û
	end
end

-- ÉèÖÃÑ¡ÖÐÐÐºÍµ±Ç°Ò³ºÅ 
function PlayerZhengyouPT_SetFocusRowAndPageNo(iRowIndex, iPageNo)
	local iRow = tonumber(iRowIndex);
	if (PlayerZhengyouPT_List:GetItemCount() > iRow) then
		PlayerZhengyouPT_List:SetSelectItem(iRow);
	end
	g_curPageIndex = tonumber(iPageNo);
	PlayerZhengyouPT_UpdateBtnStatus();
end

function PlayerZhengyouPT_CleanPlayerList()
	PlayerZhengyouPT_List:RemoveAllItem();
	PlayerZhengyouPT_CleanDetailInfo();
end

-- ´ò¿ª¡°²éÕÒ¡±Ìõ¼þ½çÃæ
function OnPlayerZhengyouPT_ChazhaoClicked()
	
	if not PlayerZhengyouPT_PassTime(TIMER_SEARCH, MIN_SEARCHTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	OpenWindow("ZhengyouSearch" .. g_curChannel);
end

-- ´ò¿ªÍ¶Æ±²é¿´½çÃæ
function OnPlayerZhengyouPT_Chakan1Clicked(iVoteViewId)
	if not PlayerZhengyouPT_PassTime(TIMER_TAB, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	if( iVoteViewId < 0 or iVoteViewId > 3 ) then
		return;
	end 

	PlayerZhengyouPT_CloseOtherWindow();
	
	local  nRowIndex =  PlayerZhengyouPT_List:GetSelectItem();
	if (nRowIndex < 0 ) then 
   		return; 
    end
    --local nSearchTab = g_Ctrls.TabSearch:GetCheck();
  local nSearchTab = g_curChannel;
	RequestVoteFindFriendInfo( OPT_VIEWVOTE, nRowIndex, iVoteViewId , nSearchTab);
end

-- Í¶Æ±
-- iSel : 0 ~ 3 
function PlayerZhengyouPT_Toupiao(iSel)

	-- ÉÔµÈµã»÷µÄÌáÊ¾
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	local nSel = PlayerZhengyouPT_List:GetSelectItem();
	if ( nSel < 0 ) then
	PushDebugMessage("Mong hãy t× bên trái ch÷n ra mµt ngß¶i công b¯ thông tin");
	return;
	end

	local szName = FindFriendDataPool:GetDetailInfo("NAME");
	local player = Player:GetName();
	if(szName == player) then
		PushDebugMessage("Không th¬ bö phiªu cho mình.");
		return;
	end

	if ( iSel < 0 or iSel > 3 ) then
		return;
	end

	-- ·¢ËÍÍ¶Æ±ÇëÇó 
	local  nRowIndex =  PlayerZhengyouPT_List:GetSelectItem();
	if (nRowIndex < 0 ) then 
		return; 
	end

	--local nSearchTab = g_Ctrls.TabSearch:GetCheck();
	local nSearchTab = g_curChannel;
	RequestVoteFindFriendInfo( OPT_VOTE, nRowIndex, iSel , nSearchTab);
end

-- ¸ü¸ÄÍæ¼ÒÕ÷ÓÑÒªÇó 
function PlayerZhengyouPT_Change_OnClick()
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	FindFriendQuery(OPT_CHECK_EDIT, g_curZhengyouType, g_curChannel);
end

-- ²éÑ¯½á¹ûµÄ´¦Àí
function PlayerZhengyouPT_OnSearchPlayerResponse(sRet, eType)
   local iType = tonumber(eType);
   if ( "ok" ==  sRet ) then
      g_Ctrls.TxtSearchResultTip:SetText(PlayerZhengyouPT_GetTypeName(iType) .. "#{ZYPT_081103_012}");   -- ×¢Òâ£¬Ö»ÓÐ·µ»ØokÊ±²ÅÄÜ¸üÐÂ²éÑ¯½á¹ûÌáÊ¾
      --g_Ctrls.TabSearch:SetCheck(1); --Ñ¡ÖÐ²éÕÒ½á¹û±êÇ©
   		PlayerZhengyouPT_CleanPlayerList();
   		g_curChannel 		= 5;
   		g_curPageIndex   = 1;
	    g_totalPageCount = 1;												-- Ö»ÏÔÊ¾1Ò³
	    g_totalVotePageCount = 1;
	    PlayerZhengyouPT_SetCurrentTab(5); 					-- Ñ¡ÖÐ²éÕÒ½á¹û±êÇ©
      PlayerZhengyouPT_ShowSearchPlayerResult();
      PlayerZhengyouPT_UpdateBtnStatus();
      PlayerZhengyouPT_UpdateSearchTip();
   elseif( "noinfo" == sRet ) then
      PushDebugMessage("Không tìm ðßþc ngß¶i ch½i phù hþp ði«u ki®n.");
   end
end

-- ÏÔÊ¾²éÕÒÍæ¼Ò½á¹û 
function PlayerZhengyouPT_ShowSearchPlayerResult()
  local iCount = FindFriendDataPool:GetSearchRetInfoNum();
  local i = 0;
	for i = 0, iCount -1 do
		local iGuid, strName, iGender, iRenqi, iType, iLevel = FindFriendDataPool:GetSearchRetInfoByPos(i);
		PlayerZhengyouPT_List:AddNewItem(strName, 0, i);
		PlayerZhengyouPT_List:AddNewItem(PlayerZhengyouPT_GetTypeName(iType), 1, i);
		PlayerZhengyouPT_List:AddNewItem(PlayerZhengyouPT_GetGenderDesc(iGender), 2, i);
		PlayerZhengyouPT_List:AddNewItem(iRenqi, 3, i);
	end
end

-- ²é¿´Íæ¼Ò×ÊÁÏ
function PlayerZhengyouPT_View_OnClick()

  local nSel = PlayerZhengyouPT_List:GetSelectItem();
  if ( nSel < 0 ) then
  	PushDebugMessage("Mong hãy t× bên trái ch÷n ra mµt ngß¶i công b¯ thông tin");
		return;
  end
   
  -- ¹Ø±ÕËùÓÐÒÑ¾­´ò¿ªµÄ¶þ¼¶Õ÷ÓÑ½çÃæ
  CloseWindow("VotedPlayer");
  PlayerZhengyouPT_CloseOtherWindow();

	-- ¸ù¾ÝÍæ¼ÒÃû×ÖÀ´È¡×ÊÁÏ 
  local szName = FindFriendDataPool:GetDetailInfo("NAME"); 
	if(nil ~= szName) then
		if( Friend:IsPlayerIsFriend( szName ) == 1 ) then
			local nGroup,nIndex;
			nGroup,nIndex = DataPool:GetFriendByName( szName );
			DataPool:ShowFriendInfo( szName );
		else
			DataPool:ShowChatInfo( szName );
		end
	end
end 

function PlayerZhengyouPT_CloseOtherWindow()
   local OtherWindows = {
   		"ZhengyouInfoFabu",
   		"ZhengyouYaoqiu",
   		"ZhengyouSearch",
   };
   local i = 1;
   for i = 1, table.getn( OtherWindows ) do
      CloseWindow( OtherWindows[i] );
   end
end

-- ½áÊ¶Íæ¼Ò
function PlayerZhengyouPT_Jieshi_OnClick()
	--¶Ô²»Æð£¬Äú²»ÄÜºÍ×Ô¼º½áÊ¶¡£
	--Äú¸Õ¸ÕÒÑ¾­ºÍ¸ÃÍæ¼Ò½áÊ¶¹ýÁË£¬ÇëÔÚÁÙÊ±ºÃÓÑÁÐ±íÖÐ²éÕÒ¡£
	--¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄ³ðÈËÁÐ±íÖÐ£¬ÎÞ·¨½áÊ¶¡£
	--¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄºÃÓÑÁÐ±íÖÐ£¬ÇëÔÚºÃÓÑÁÐ±íÖÐ²éÕÒ¡£
	--¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄÁÙÊ±ºÃÓÑÁÐ±íÖÐ£¬ÇëÔÚÁÙÊ±ºÃÓÑÁÐ±íÖÐ²éÕÒ¡£
	--½áÊ¶³É¹¦£¬ÄúÒÑ¾­½«¸ÃÍæ¼Ò¼ÓÈëÁÙÊ±ºÃÓÑÁÐ±í¡£
	--Íæ¼ÒXXX¿´µ½ÁËÄú·¢²¼µÄÕ÷»éÐÅÏ¢£¬ÏëÓëÄú½áÊ¶£¬ÒÑ¾­ÔÚÄúµÄÁÙÊ±ºÃÓÑÁÐ±íÖÐ¡£
	
	local nSel = PlayerZhengyouPT_List:GetSelectItem();
	if ( nSel < 0 ) then
	PushDebugMessage("Mong hãy t× bên trái ch÷n ra mµt ngß¶i công b¯ thông tin");
	return;      --Èç¹ûÃ»ÓÐÑ¡ÖÐµÄÓÃ»§£¬²»ÄÜ½áÊ¶
	end

  -- Ê×ÏÈÅÐ¶ÏÊÇ·ñ×Ô¼º     
  local owner = FindFriendDataPool:GetDetailInfo("NAME"); 
	local player = Player:GetName();
	if(owner == player) then
		PushDebugMessage("#{ZYPT_081103_046}"); --("¶Ô²»Æð£¬Äú²»ÄÜºÍ×Ô¼º½áÊ¶¡£");
		return;
	end

	--  ÅÐ¶ÏÊÇ·ñ³ðÈË 
	local currentList = 6; -- ³ðÈË 
	local friendnumber = DataPool:GetFriendNumber( tonumber( currentList ) );
	local index = 0;
	while index < friendnumber  do
		local name =  DataPool:GetFriend( currentList, tonumber( index ), "NAME" );	
		if (name == owner) then
		    PushDebugMessage("#{ZYPT_081103_048}"); --("¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄ³ðÈËÁÐ±íÖÐ£¬ÎÞ·¨½áÊ¶¡£");
			return;
		end
		index = index + 1;
	end

	--  ÅÐ¶ÏÊÇ·ñºÚÃûµ¥
	local currentList = 5; -- ºÚÃûµ¥ 
	local friendnumber = DataPool:GetFriendNumber( tonumber( currentList ) );
	local index = 0;
	while index < friendnumber  do
		local name =  DataPool:GetFriend( currentList, tonumber( index ), "NAME" );	
		if (name == owner) then
		    PushDebugMessage("Ngß¶i ch½i này có tên trong danh sách ðen cüa các hÕ, không th¬ kªt bÕn.");
			return;
		end
		index = index + 1;
	end

	-- ÅÐ¶ÏÊÇ·ñÔÚÁÙÊ±ºÃÓÑÁÐ±í 
	currentList = 8; -- temp friend 
	friendnumber = DataPool:GetFriendNumber( tonumber( currentList ) );
	index = 0;
	while index < friendnumber  do
		local name =  DataPool:GetFriend( currentList, tonumber( index ), "NAME" );	
		if (name == owner) then
		    PushDebugMessage("#{ZYPT_081103_050}"); --("¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄÁÙÊ±ºÃÓÑÁÐ±íÖÐ£¬ÇëÔÚÁÙÊ±ºÃÓÑÁÐ±íÖÐ²éÕÒ¡£");
			return;
		end
		index = index + 1;
	end

	-- ÅÐ¶ÏÊÇ·ñºÃÓÑ
	local iTmp = 1;
	for iTmp = 1, 4 do
	  currentList = iTmp; -- friend 
	 	friendnumber = DataPool:GetFriendNumber( tonumber( currentList ) );
	 	index = 0;
	 	while index < friendnumber  do
	 		local name =  DataPool:GetFriend( currentList, tonumber( index ), "NAME" );	
	 		if (name == owner) then
	 		    PushDebugMessage("#{ZYPT_081103_049}"); --("¸ÃÍæ¼ÒÒÑ¾­ÔÚÄúµÄºÃÓÑÁÐ±íÖÐ£¬ÇëÔÚºÃÓÑÁÐ±íÖÐ²éÕÒ¡£");
	 			return;
	 		end
	 		index = index + 1;
	  end
	end

	-- °Ñ¶Ô·½¼ÓÈë×Ô¼ºÁÙÊ±ºÃÓÑÁÐ±í
	DataPool:AddFriend(8, owner);
	PushDebugMessage("#{ZYPT_081103_051}"); --½áÊ¶³É¹¦£¬ÄúÒÑ¾­½«¸ÃÍæ¼Ò¼ÓÈëÁÙÊ±ºÃÓÑÁÐ±í¡£
	-- ·¢ËÍÓÊ¼þ 
	local iAdType = FindFriendDataPool:GetDetailInfo("ADTYPE");
	local sType = g_TypesDesc[iAdType];
	if ( nil == sType ) then sType = ""; end
	
	DataPool:OpenMail( owner,"Xin chào, tÕi hÕ th¤y các hÕ công b¯" .. sType .. "thông tin Chính Hæu, mu¯n cùng các hÕ kªt bÕn!" );
	  
end 

-- ÔÚÇÐ»»±êÇ©Ê±´¦Àí²éÑ¯½á¹ûºÍÍæ¼ÒÁÐ±í´°¿Ú´óÐ¡
function  PlayerZhengyouPT_UpdateSearchTip()
	 -- ÎÞÌáÊ¾Ê±Íæ¼ÒÁÐ±ítop = 23, height = 272  
	 -- <Property Name="UnifiedPosition" Value="{{0.000000,1.000000},{0.000000,23.000000}" />
	 -- <Property Name="AbsoluteSize" Value="w:399 h:272" />
	 -- ÓÐÌáÊ¾Ê±
	 --<Property Name="UnifiedPosition" Value="{{0.000000,1.000000},{0.000000,47.000000}" />
     --<Property Name="AbsoluteSize" Value="w:399 h:248" />
     if ( 5 == g_curChannel ) then
         --PlayerZhengyouPT_Result:Show();
         g_Ctrls.CtrlList:SetProperty("UnifiedPosition", "{{0.000000,1.000000},{0.000000,68.000000}");
         g_Ctrls.CtrlList:SetProperty("AbsoluteSize", "w:567 h:248");
     else
         --PlayerZhengyouPT_Result:Hide();
         g_Ctrls.CtrlList:SetProperty("UnifiedPosition", "{{0.000000,1.000000},{0.000000,23.000000}");
         g_Ctrls.CtrlList:SetProperty("AbsoluteSize", "w:567 h:272");
     end
end

-- Ë¢ÐÂ
function OnPlayerZhengyouPT_RefreshClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_UPDATE, MIN_UPDATETIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	if (g_curChannel == 5) then      --²éÕÒ½á¹ûÖÐ²»ÈÃË¢ÐÂ
		return;
	end

	PlayerZhengyouPT_UpdateBtnStatus();
	if ( g_curPageIndex < 1 ) then
		g_curPageIndex = 1;
	end

	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

-- Ç°Íù
function OnPlayerZhengyouPT_GotoClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_COMMONBTN, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	local nPage = PlayerZhengyouPT_GotoEditBox:GetText();
	if(nPage~=nil and tonumber(nPage)~=nil) then
		if (g_curChannel == 6) then															-- ÈËÆøÆµµÀ
			if (tonumber(nPage)>g_totalVotePageCount or tonumber(nPage) < 1) then
				PushDebugMessage("Xin nh§p s¯ trang chính xác.")
			else
				g_curPageIndex = tonumber(nPage);
				PlayerZhengyouPT_UpdateBtnStatus();
				RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
			end
		else																										-- ÆäËûÆµµÀ
			if (tonumber(nPage)>g_totalPageCount or tonumber(nPage) < 1) then
				PushDebugMessage("Xin nh§p s¯ trang chính xác.")
			else
				g_curPageIndex = tonumber(nPage);
				PlayerZhengyouPT_UpdateBtnStatus();
				RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
			end
		end		
	end	
end

-- Ê×Ò³
function OnPlayerZhengyouPT_FirstPageClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_UPDATE, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end

	g_curPageIndex = 1;
	PlayerZhengyouPT_UpdateBtnStatus();
	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

-- Ä©Ò³
function OnPlayerZhengyouPT_LastPageClicked()
	if not PlayerZhengyouPT_PassTime(TIMER_UPDATE, MIN_TABTIME) then
		PushDebugMessage(g_strWaitClickTipText);
		return
	end
	
	if (g_curChannel == 6) then
		g_curPageIndex = g_totalVotePageCount;							-- ÈËÆøÆµµÀ
	else
		g_curPageIndex = g_totalPageCount;									-- ÆäËûÆµµÀ
	end
	
	PlayerZhengyouPT_UpdateBtnStatus();
	RequestFindFriendList(g_curChannel, g_curPageIndex);	-- ÇëÇóµ±Ç°ÆµµÀ¡¢µ±Ç°Ò³µÄÐÅÏ¢ÁÐ±í
end

-- ¹Ø±Õ
function OnPlayerZhengyouPT_CloseClicked()
	this:Hide();
	
	-- »Ö¸´Ä¬ÈÏÑ¡ÖÐÆµµÀÎª¡°×îÍúÈËÆø¡±¡¢µÚ1Ò³
	g_curChannel = 6;	
	g_curPageIndex = 1;
	-- Çå¿ÕÕ÷ÓÑÆ½Ì¨´°¿ÚÓÒ²à¿Ø¼þÏÔÊ¾µÄÄÚÈÝ¡£
	PlayerZhengyouPT_CleanDetailInfo();
end
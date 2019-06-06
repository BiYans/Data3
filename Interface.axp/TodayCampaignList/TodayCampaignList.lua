local	campaign_today = 0	--µ±ÌìËùÓĞ»î¶¯
local	campaign_curDaily = 1	--Ä¿Ç°ÈÕ³£»î¶¯
local	campaign_other	=2	--µ±ÌìËùÓĞÆäËû»î¶¯
local	campaign_daily	=3	--µ±ÌìËùÓĞÈÕ³£»î¶¯

local g_TodalCampaignCount = 0;		--½ñÌìµÄ»î¶¯ÊıÄ¿

-- ½çÃæ¿Ø¼ş
local g_AllCampaignDetailDescs = {};	-- ËùÓĞ»î¶¯µÄÏêÏ¸ÃèÊöĞÅÏ¢ÁĞ±í
local g_AllCampaignID = {};          --¼ÇÂ¼ÏÂËùÓĞ»î¶¯ID

function TodayCampaignList_PreLoad()
	this:RegisterEvent("SHOW_TODAY_CAMPAIGN_LIST")
	this:RegisterEvent("SHOW_TODAY_CAMPAIGN_LIST_FROM_TRACK");
	this:RegisterEvent("UPDATE_CAMPAGIN_BY_TRACK");
end

function TodayCampaignList_OnLoad()

end

-- OnEvent
function TodayCampaignList_OnEvent(event)
	if ( event == "SHOW_TODAY_CAMPAIGN_LIST" ) then
		this:TogleShow();
		TodayCampaignList_Init();
	elseif ( event == "SHOW_TODAY_CAMPAIGN_LIST_FROM_TRACK") then
		local nSelectID = tonumber(arg0)
		if not this:IsVisible() then
			this:TogleShow();
			TodayCampaignList_Init(nSelectID);
		else
			--TodayCampaignList_Init(-1);
			TodayCampaignList_OnClosed();
		end
	elseif (event == "UPDATE_CAMPAGIN_BY_TRACK") then
		if not this:IsVisible() then
			return;
		else
			TodayCampaignList_Init(-1);
		end
	elseif (event == "UPDATE_CAMPAGIN_BY_TRACK") then
		if this:IsVisible() then
			TodayCampaignList_Init(-1);
		end
	end
end

function TodayCampaignList_Init(nSelectID)
	-- Çå³ı¸Õ²Å´ò¿ªÊ±µÄĞÅÏ¢
	TodayCampaignList_DetailDesc:ClearAllElement();
	TodayCampaignList_ListCtl:RemoveAllItem();
	local g_Current_Select_index = -1;

	local g_TodalCampaignCount = GetCampaignCount(tonumber(campaign_today));

	for i=0 , g_TodalCampaignCount-1 do
		-- »î¶¯Ê±¼ä
		local strTime = "";
		local strEnd = EnumCampaign(tonumber(campaign_today),i,"endtime");
		if(strEnd ~= -1) then
			strTime = EnumCampaign(tonumber(campaign_today),i,"starttime").."--"..strEnd;
		else
			strTime = EnumCampaign(tonumber(campaign_today),i,"starttime");
		end

		-- »î¶¯Ãû
		local strHuodong = EnumCampaign(tonumber(campaign_today),i,"name");

		-- »î¶¯ÃèÊö
		local strDesc = EnumCampaign(tonumber(campaign_today),i,"desc");
		local ends = EnumCampaign(tonumber(campaign_today),i,"addtiondesc");
		if(ends and ends~="")then
			strDesc = strDesc..", "..ends;
		end
		AxTrace( 5,3, strDesc );

		-- ÏêÏ¸»î¶¯ÃèÊö
		local strDetailDesc = EnumCampaign(tonumber(campaign_today),i,"detailDesc");

		-- »î¶¯ÀàĞÍ
		local isCur  =  EnumCampaign(tonumber(campaign_today),i,"iscurcampaign");
		if(tonumber(isCur) == 1)then
			strTime = "#G" .. strTime;
			strHuodong = "#G" .. strHuodong;
			strDesc = "#G" .. strDesc;
		else
			local isDaliy  =  EnumCampaign(tonumber(campaign_today),i,"timetype");
			if(tonumber(isDaliy) == 1)then
				strTime = "#W" .. strTime;
				strHuodong = "#W" .. strHuodong;
				strDesc = "#W" .. strDesc;
			else
				strTime = "#Y" .. strTime;
				strHuodong = "#Y" .. strHuodong;
				strDesc = "#Y" .. strDesc;
			end
		end

		TodayCampaignList_ListCtl:AddNewItem(strTime, 0, i);

		local nCampaignID = EnumCampaign(tonumber(campaign_today),i,"id");
		local nIsTrack = EnumCampaign(tonumber(campaign_today),i,"TrackIsOrNot");
		if ( nSelectID == nCampaignID) then
			g_Current_Select_index = i;
		end
		--if (DataPool:IsCampaignTrackOpen(nCampaignID) >= 1 and nIsTrack == 1) then
		--	strHuodong = "* " .. strHuodong;
		--else
			strHuodong = "  " .. strHuodong;
		--end
		TodayCampaignList_ListCtl:AddNewItem(strHuodong, 1, i);
		TodayCampaignList_ListCtl:AddNewItem(strDesc, 2, i);

		g_AllCampaignDetailDescs[i+1] = strDetailDesc;		-- ¼ÇÂ¼µ±Ç°»î¶¯µÄÏêÏ¸ÃèÊöĞÅÏ¢
		g_AllCampaignID[i+1] = nCampaignID;
	end

	if (g_Current_Select_index == -1) then
		g_Current_Select_index = 0;
	end
	TodayCampaignList_ListCtl:SetSelectItem(g_Current_Select_index);
	TodayCampaignList_ListCtl:SetVertScollPosition(g_Current_Select_index);
	TodayCampaignList_TrackButtonState();
	g_Current_Select_index = -1;

	-- ´ò¿ª´°¿ÚÊ±£¬Ã»ÓĞÑ¡ÖĞÈÎºÎÈÎÎñÊ±µÄÏÔÊ¾ÄÚÈİ
	--TodayCampaignList_DetailDesc:AddTextElement("#{MRHD_090413_1}");
	TodayCampaignList_DetailDesc:Show();

end

-- Êó±êµã»÷¾ßÌå»î¶¯ºóµÄÏàÓ¦º¯Êı
function TodayCampaignList_List_OnSelectionChanged()

	-- Çå³ı¸Õ²ÅÑ¡ÔñµÄ»î¶¯ĞÅÏ¢
	TodayCampaignList_DetailDesc:ClearAllElement();		-- Çå³ı»î¶¯ÃèÊöĞÅÏ¢

	local nSel = TodayCampaignList_ListCtl:GetSelectItem();	-- µ±Ç°Ñ¡ÔñµÄĞĞºÅ (0 ~ g_TodalCampaignCount-1)
	TodayCampaignList_TrackButtonState();
	-- ÏÔÊ¾µ±Ç°Ñ¡ÖĞµÄ»î¶¯ĞÅÏ¢
	if (g_AllCampaignDetailDescs[nSel+1] ~= nil) then
		TodayCampaignList_DetailDesc:AddTextElement(tostring(g_AllCampaignDetailDescs[nSel+1]));
	end
	TodayCampaignList_DetailDesc:Show();
end

-- ¹Ø±Õ
function TodayCampaignList_OnClosed()
	this:Hide();

	-- Çå¿Õµ±Ç°»î¶¯Êı¾İ
	TodayCampaignList_DetailDesc:ClearAllElement();		-- Çå³ı»î¶¯ÃèÊöĞÅÏ¢

	-- Çå¿ÕËùÓĞÒÑ¾­¶ÁÈ¡µÄ½ñÈÕ»î¶¯ÁĞ±íÊı¾İ
	for i=1 , g_TodalCampaignCount do
		g_AllCampaignDetailDescs[i] = "";
		g_AllCampaignID = 0;
	end
end

-- È¡Ïû
function TodayCampaignList_OnCancel()
	--this:Hide();
	-- Çå¿Õµ±Ç°»î¶¯Êı¾İ
	--TodayCampaignList_DetailDesc:ClearAllElement();		-- Çå³ı»î¶¯ÃèÊöĞÅÏ¢
	-- Çå¿ÕËùÓĞÒÑ¾­¶ÁÈ¡µÄ½ñÈÕ»î¶¯ÁĞ±íÊı¾İ
	--for i=1 , g_TodalCampaignCount do
	--	g_AllCampaignDetailDescs[i] = "";
	--end


	local nSel = TodayCampaignList_ListCtl:GetSelectItem();	-- µ±Ç°Ñ¡ÔñµÄĞĞºÅ (0 ~ g_TodalCampaignCount-1)
	local nCampaignID = tonumber(g_AllCampaignID[nSel+1]);
	if (nCampaignID == nil or nCampaignID < 0) then
		return
	end
	-- if (DataPool:IsCampaignCanTrack(nCampaignID) > 0) then
	-- 	if (DataPool:IsCampaignTrackOpen(nCampaignID) > 0) then
	-- 		DataPool:SetCampaignTrackOpen(nCampaignID, 0);
	-- 	else
	-- 		if (DataPool:IsTrackFuncShow(2) == 0) then
	-- 			OpenWindow("CampaignTrack");
	-- 			DataPool:SetTrackFuncShow(2, 1);
	-- 		end
	-- 		DataPool:SetCampaignTrackOpen(nCampaignID, 1);
	-- 	end
	-- 	DataPool:UpdateCampaignTrack();
	-- 	TodayCampaignList_TrackButtonState();
	-- 	TodayCampaignList_Init(nCampaignID);
	-- end
end

function TodayCampaignList_TrackButtonState()
	local nSel = TodayCampaignList_ListCtl:GetSelectItem();	-- µ±Ç°Ñ¡ÔñµÄĞĞºÅ (0 ~ g_TodalCampaignCount-1)
	local nCampaignID = tonumber(g_AllCampaignID[nSel+1]);

	-- if (nCampaignID ~= nil and DataPool:IsCampaignCanTrack(nCampaignID) > 0) then
	-- 	if (DataPool:IsCampaignTrackOpen(nCampaignID) > 0) then
	-- 		TodayCampaignList_Cancel:SetText("Hüy theo");
	-- 	else
	-- 		TodayCampaignList_Cancel:SetText("B¡t ğ¥u theo");
	-- 	end
	-- 	TodayCampaignList_Cancel:Enable();
	-- else
	-- 	TodayCampaignList_Cancel:SetText("Không th¬ theo");
	-- 	TodayCampaignList_Cancel:Disable();
	-- end
end

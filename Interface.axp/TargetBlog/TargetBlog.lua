local Link = {}
local TARGETBLOG_TAB_TEXT = {}
function TargetBlog_PreLoad()
	this:RegisterEvent("OPEN_BLOG");
	this:RegisterEvent("UPDATE_BLOG");
end

function TargetBlog_OnLoad()
	Link[0] = "http://blog.sohu.com"
	Link[1] = "http://blog.sohu.com"
	Link[2] = "http://blog.sohu.com"
	Link[3] = "http://blog.sohu.com"
	Link[4] = "http://blog.sohu.com"
	Link[5] = "http://blog.sohu.com"
	TARGETBLOG_TAB_TEXT = {
		[0] = "Ð°",
		"Nhân",
		"Blog",
		"Thú",
		"KÜ",
	};	
end
function TargetBlog_SetTabColor(idx)

	local i = 0;
	local selColor = "#e010101#Y";
	local noselColor = "#e010101";
	local tab = {
								[0] = TargetBlog_SelfEquip,
								TargetBlog_TargetData,								
								TargetBlog_Blog,
								TargetBlog_Pet,
								TargetBlog_Ride,
							};
	
	while i < 5 do
		if(i == idx) then
			tab[i]:SetText(selColor..TARGETBLOG_TAB_TEXT[i]);
		else
			tab[i]:SetText(noselColor..TARGETBLOG_TAB_TEXT[i]);
		end
		i = i + 1;
	end
end
-- OnEvent
function TargetBlog_OnEvent(event)
	if ( event == "OPEN_BLOG" and tostring(arg0) == CachedTarget:GetData("NAME") and tostring(arg0) ~= Player:GetName() ) then
		local otherUnionPos = Variable:GetVariable("OtherUnionPos");
		if(otherUnionPos ~= nil) then
			TargetBlog_Frame:SetProperty("UnifiedPosition", otherUnionPos);
		end
		
		local obj_id = CachedTarget:GetData("NPCID", 1)
		if (type(obj_id) ~="number") then
			PushDebugMessage ("#{JSCK_90507_1}")				-- ¾àÀë¸ÃÍæ¼ÒÌ«Ô¶£¬ÎÞ·¨²é¿´×ÊÁÏ¡£
			return
		end
		this:CareObject(obj_id , 1)

		TargetBlog_SetTabColor(2)
		TargetBlog_Blog:SetCheck(1)
		this:Show();
		if(arg1 == "BLOG_STATUS_FAILED") then
			TargetBlog_Show_Cover("#YTh¤t bÕi khi m· blog cüa bÕn");
		elseif(arg1 == "BLOG_STATUS_WORKING") then
			TargetBlog_Show_Cover("Ðang m· blog cüa bÕn...");
		end
	elseif(event == "UPDATE_BLOG") then
		
		if(arg0 == "BLOG_STATUS_INEXIT") then
			TargetBlog_Show_Cover("#YBlog không t°n tÕi!");
		elseif(arg0 == "BLOG_STATUS_FAILED") then
			TargetBlog_Show_Cover("#YTh¤t bÕi khi m· blog cüa bÕn");
		elseif(arg0 == "BLOG_STATUS_SUCCESS") then
			TargetBlog_UpdateFrame();
		else 
			TargetBlog_Show_Cover("#RChßa biªt sai" .. arg1);
		end
	end

end

function TargetBlog_Show_Cover(title_text)
	TargetBlog_Function_Frame_Contents:Hide();
	TargetBlog_Function_Frame_Cover:Show();
	
	TargetBlog_Cover_Text:SetText(title_text);

end

function TargetBlog_UpdateFrame()
	TargetBlog_Function_Frame_Cover:Hide();
	TargetBlog_Function_Frame_Contents:Show();

	local strName = ""
	local HyperLink = ""
	local strTime = ""
	local max_size = 200
	
	strName = Blog:GetBlogContents("title")
	TargetBlog_Text1:SetProperty("Text_Utf8",strName)

	strName = Blog:GetBlogContents("description")
	TargetBlog_Text2:SetProperty("Text_Utf8",strName)
	
	strName = Blog:GetBlogContents("link")
	TargetBlog_Text3:SetProperty("Text_Utf8",strName)
	Link[0] = strName
	
	--ÐÞ¸Ä³¬Á´½ÓÏÔÊ¾µÄÑùÊ½(ÓëÕæÊµ³¬Á´½ÓµØÖ·²»Ò»Ñù) --add by xindefeng
	local strShowLink = CachedTarget:GetData("NAME").." Ðích Bác Khách"
	TargetBlog_Text3:SetText(strShowLink)

	strName = Blog:GetBlogContents("article_title_0");
	HyperLink = Blog:GetBlogContents("article_link_0");
	strTime = Blog:GetBlogContents("article_time_0");
	
	Link[1] = HyperLink
	strTime = string.sub(strTime,6,11);
	TargetBlog_Text6:SetProperty("Text_Utf8", strTime.." | "..strName)
	
	strName = Blog:GetBlogContents("article_description_0")
	local str = strName
	TargetBlog_Text7:SetProperty("Text_Utf8",str)
	
	strName = Blog:GetBlogContents("article_title_1");
	HyperLink = Blog:GetBlogContents("article_link_1");
	strTime = Blog:GetBlogContents("article_time_1");
	Link[2] = HyperLink;

	strTime = string.sub(strTime,6,11);
	TargetBlog_Text8:SetProperty("Text_Utf8",strTime.." | "..strName)
	
	strName = Blog:GetBlogContents("article_title_2");
	HyperLink = Blog:GetBlogContents("article_link_2");
	strTime = Blog:GetBlogContents("article_time_2");
	Link[3] = HyperLink

	strTime = string.sub(strTime,6,11);
	TargetBlog_Text9:SetProperty("Text_Utf8",strTime.." | "..strName)
	
end

function TargetBlog_Click(nAddress)
	Blog:Blog_Click(Link[nAddress])
end

----------------------------------------------------------------------------------------
--
-- ´ò¿ªÍæ¼ÒÐÅÏ¢½çÃæ
--
function TargetBlog_TargetData_Down()
	Variable:SetVariable("OtherUnionPos", TargetBlog_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("other")
end

--===============================================
-- ´ò¿ªÍæ¼Ò×°±¸UI
--===============================================
function TargetBlog_TargetEquip_Down()

	Variable:SetVariable("OtherUnionPos", TargetBlog_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenEquipFrame("other");
end
--===============================================
-- ´ò¿ªÍæ¼Ò×°±¸UI
--===============================================
function TargetBlog_OtherPet_Down()

	Variable:SetVariable("OtherUnionPos", TargetBlog_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPetFrame("other");
end

function TargetBlog_OtherRide_Down()
	Variable:SetVariable("OtherUnionPos", TargetBlog_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenRidePage("other");
end

--Îä»ê

function TargetBlog_TargetWuhun_Switch()
	Variable:SetVariable("OtherUnionPos", TargetBlog_Frame:GetProperty("UnifiedPosition"), 1);
	--SystemSetup:OpenOtherWuhun();
	OpenOtherWuhun();
end
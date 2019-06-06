local Link = {}
function Blog_PreLoad()
	this:RegisterEvent("OPEN_BLOG");
	this:RegisterEvent("UPDATE_BLOG");
end

function Blog_OnLoad()
	Link[0] = "http://blog.sohu.com"
	Link[1] = "http://blog.sohu.com"
	Link[2] = "http://blog.sohu.com"
	Link[3] = "http://blog.sohu.com"
	Link[4] = "http://blog.sohu.com"
	Link[5] = "http://blog.sohu.com"
end

-- OnEvent
function Blog_OnEvent(event)
	if ( event == "OPEN_BLOG" ) then
		if( tostring(arg0) == Player:GetName() ) then
			SelfBlog_Blog:SetCheck(1);
			this:Show();
		else
			return;
		end

		if(arg1 == "BLOG_STATUS_FAILED") then
			Blog_Show_Cover("#YTh¤t bÕi khi m· blog cüa bÕn");
		elseif(arg1 == "BLOG_STATUS_WORKING") then
			Blog_Show_Cover("Ðang m· blog cüa bÕn...");
		end
	elseif(event == "UPDATE_BLOG") then

		if(arg0 == "BLOG_STATUS_INEXIT") then
			Blog_Show_Cover("#YBlog không t°n tÕi!");
		elseif(arg0 == "BLOG_STATUS_FAILED") then
			Blog_Show_Cover("#YTh¤t bÕi khi m· blog cüa bÕn");
		elseif(arg0 == "BLOG_STATUS_SUCCESS") then
			Blog_UpdateFrame();
		else
			Blog_Show_Cover("#RChßa biªt sai" .. arg1);
		end
	end

end

function Blog_Show_Cover(title_text)
	Blog_Function_Frame_Contents:Hide();
	Blog_Function_Frame_Cover:Show();

	Blog_Cover_Text:SetText(title_text);

end

function Blog_UpdateFrame()
	Blog_Function_Frame_Cover:Hide();
	Blog_Function_Frame_Contents:Show();

	local strName = ""
	local HyperLink = ""
	local strTime = ""
	local max_size = 200

	strName = Blog:GetBlogContents("title")
	Blog_Text1:SetProperty("Text_Utf8",strName)

	strName = Blog:GetBlogContents("description")
	Blog_Text2:SetProperty("Text_Utf8",strName)

	strName = Blog:GetBlogContents("link")
	Blog_Text3:SetProperty("Text_Utf8",strName)
	Link[0] = strName

	--ÐÞ¸Ä³¬Á´½ÓÏÔÊ¾µÄÑùÊ½(ÓëÕæÊµ³¬Á´½ÓµØÖ·²»Ò»Ñù) --add by xindefeng
	local strShowLink = Player:GetName().." Ðích Bác Khách"
	Blog_Text3:SetText(strShowLink)

	strName = Blog:GetBlogContents("article_title_0");
	HyperLink = Blog:GetBlogContents("article_link_0");
	strTime = Blog:GetBlogContents("article_time_0");

	Link[1] = HyperLink
	strTime = string.sub(strTime,6,11);
	Blog_Text6:SetProperty("Text_Utf8", strTime.." | "..strName)

	strName = Blog:GetBlogContents("article_description_0")
	local str = strName
	Blog_Text7:SetProperty("Text_Utf8",str)

	strName = Blog:GetBlogContents("article_title_1");
	HyperLink = Blog:GetBlogContents("article_link_1");
	strTime = Blog:GetBlogContents("article_time_1");
	Link[2] = HyperLink;

	strTime = string.sub(strTime,6,11);
	Blog_Text8:SetProperty("Text_Utf8",strTime.." | "..strName)

	strName = Blog:GetBlogContents("article_title_2");
	HyperLink = Blog:GetBlogContents("article_link_2");
	strTime = Blog:GetBlogContents("article_time_2");
	Link[3] = HyperLink

	strTime = string.sub(strTime,6,11);
	Blog_Text9:SetProperty("Text_Utf8",strTime.." | "..strName)

end

function Blog_Click(nAddress)
	Blog:Blog_Click(Link[nAddress])
end


function Blog_SelfEquip_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	OpenEquip(1);
end

--´ò¿ª×Ô¼ºµÄ×ÊÁÏÒ³Ãæ
function Blog_SelfData_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("self");
end

function Blog_Pet_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	TogglePetPage();
end

function Blog_Ride_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	OpenRidePage();
end

function Blog_Other_Info_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	OtherInfoPage();
end

--ÏÔÊ¾Îä»êUI
function SelfBlog_Wuhun_Switch()
	Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
	ToggleWuhunPage();
end

function Blog_XiuLian_Switch()
    nLevel = Player:GetData("LEVEL")
	if(nLevel >= 70) then
		Variable:SetVariable("SelfUnionPos", Blog_Frame:GetProperty("UnifiedPosition"), 1);
		XiuLianPage();
	else
	    SelfBlog_Xiulian:SetCheck(0)
	    PushDebugMessage("#{XL_090707_62}")
	end
end

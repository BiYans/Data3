
--ÊÇ·ñÔ¤ÀÀ×´Ì¬
local currentmode = 0;
local nChannel = -1
local nIndex = -1

local g_ChatBtn ={};

local isFirstClick = false;
--===============================================
-- OnLoad()
--===============================================
function InfoEdit_PreLoad()

	this:RegisterEvent("OPEN_EMAIL_WRITE");
	this:RegisterEvent("SEND_MAIL");
end

function InfoEdit_OnLoad()
end

--===============================================
-- OnEvent()
--===============================================
function InfoEdit_OnEvent( event )
	
	if ( event == "OPEN_EMAIL_WRITE" ) then
		InfoEdit_Target:SetText( arg1 );
		InfoEdit_EditInfo:SetText(arg2);
		InfoEdit_Show();
		if arg1 ~= ""  then 
			if IsWindowShow("PetFriendSearch") or IsWindowShow("PetZhengYou") then
				InfoEdit_EditInfo:SetProperty("SelectionStart",0);
				InfoEdit_EditInfo:SetProperty("SelectionLength", -1);
				isFirstClick = true;
			end
		end
	elseif( event == "SEND_MAIL" ) then
		InfoEdit_SendMail();
	end

end

function InfoEdit_Empty()
	if isFirstClick == true then
		isFirstClick = false;
		InfoEdit_EditInfo:SetText("");
	end
end

--===============================================
-- UpdateFrame()
--===============================================
function InfoEdit_Update()
	InfoEdit_History:SetText("Nh§t ký") -- zchw
	InfoEdit_Preview:SetText( "Xem" );
	InfoEdit_PreviewInfo:Hide();
	InfoEdit_EditInfo:Show();
	InfoEdit_EditInfo:SetForce();
end

function InfoEdit_UpdateHistory()

--	local nChannel = tonumber( Friend:GetCurrentTeam() )
--	local nIndex = tonumber( Friend:GetCurrentSelect() )
	nChannel, nIndex = DataPool:GetFriendByName( InfoEdit_Target:GetText() )
	local maxHistroyNumber = Friend:GetHistroyNumber( nChannel, nIndex )
	
	--Ö»ÏÔÊ¾×îºó100¸öÓÊ¼þ
	local i = 0
	if maxHistroyNumber > 100 then
		i = maxHistroyNumber - 100
	end

	InfoEdit_ChatHistory:ClearListBox()
	local str = ""
	while i < maxHistroyNumber do 
		str = Friend:GetHistroyData( nChannel, nIndex, i, "TIME" )
		str = str .. " " 
		local MailStr
		local sender = Friend:GetHistroyData( nChannel, nIndex, i, "SENDER" )
		local recver = Friend:GetHistroyData( nChannel, nIndex, i, "RECIVER" )
		if Player:GetName() == sender then
			MailStr = string.format( "GØi nµi dung ðªn cho #G%s#W", recver )
		elseif Player:GetName() == recver then
			MailStr = string.format( "#G%s #W gØi nµi dung ðªn", sender )
		else
			MailStr = "#G" .. sender .. "#W"
		end

		str = str .. MailStr
		str = str .. "#r";
		str = str .. Friend:GetHistroyData( nChannel, nIndex, i, "CONTEX" )
		InfoEdit_ChatHistory:AddItem( str, i, "FFFFFFFF", 4 )
		i = i + 1
	end
	local nItemCount = InfoEdit_ChatHistory:GetItemNumber()
	InfoEdit_ChatHistory:EnsureItemIsVisable( nItemCount - 1 )
end

function InfoEdit_Show()
	this:Show();
	InfoEdit_Update();
	InfoEdit_UpdateHistory();
	InfoEdit_EditInfo:SetText("");
end

function InfoEdit_Hide()
	this:Hide();
end

function InfoEdit_ClosePreviewClick()
	
	InfoEdit_Preview:SetText( "Xem" );
	InfoEdit_PreviewInfo:Hide();
	InfoEdit_EditInfo:Show();
		
	
end
function InfoEdit_PreviewClick()
	if( InfoEdit_PreviewInfo:IsVisible() ) then
		InfoEdit_ClosePreviewClick();
	else
		InfoEdit_PreviewInfo:SetText( InfoEdit_EditInfo:GetText() );
		InfoEdit_Preview:SetText( "Quay lÕi" );
		InfoEdit_PreviewInfo:Show();
		InfoEdit_EditInfo:Hide();
	end
	
end

function InfoEdit_SendMail()	
	local SendRet = nil	--±êÊ¶·¢ÓÊ¼þÊÇ·ñ³É¹¦--add by xindefeng
	
	if isFirstClick then
		isFirstClick = false;
	end
	local szValue= InfoEdit_EditInfo:GetText();
	if( szValue == "" ) then
		PushDebugMessage("Không ðßþc gØi email tr¯ng");
		return;
	end
	if( this:IsVisible() ) then
		SendRet = DataPool:SendMail( InfoEdit_Target:GetText(), InfoEdit_EditInfo:GetText() )	--modify by xindefeng
		
		local nchannel,nindex;
		nchannel, nindex  = DataPool:GetFriendByName( InfoEdit_Target:GetText() );
		if( tonumber( nchannel ) == -1 ) then
			DataPool:AddFriend( 7, InfoEdit_Target:GetText() );
		end
	end
		
	if(SendRet == 0)then	--Èç¹û·¢ÓÊ¼þ³É¹¦,¹Ø±Õ½çÃæ--modify by xindefeng
		InfoEdit_Hide()
	end
	
end

function InfoEdit_OnHidden()
	InfoEdit_EditInfo:SetProperty("DefaultEditBox", "False");
end

function InfoEdit_GetBtnScreenPosX(btn)
	InfoEdit_PrepareBtnCtl();
	local barxpos = InfoEdit_Frame:GetProperty("AbsoluteXPosition");
	local btnxpos = g_ChatBtn[btn]:GetProperty("AbsoluteXPosition");
	
	return barxpos+btnxpos;
end
function InfoEdit_GetBtnScreenPosY(btn)
	InfoEdit_PrepareBtnCtl();
	local barxpos = InfoEdit_Frame:GetProperty("AbsoluteYPosition");
	local btnxpos = InfoEdit_Frame:GetProperty("AbsoluteHeight");
	return barxpos+btnxpos+2;
end
function InfoEdit_SelectTextColor()
	Talk:SelectTextColor("select", InfoEdit_GetBtnScreenPosX("color"),InfoEdit_GetBtnScreenPosY("color"));
end

function InfoEdit_SelectFaceMotion()
	Talk:SelectFaceMotion("select", InfoEdit_GetBtnScreenPosX("face"),InfoEdit_GetBtnScreenPosY("face"));
end

function InfoEdit_PrepareBtnCtl()
	g_ChatBtn = {
								color		= InfoEdit_LetterColor,
								face		= InfoEdit_Face,

							};
end

-- add by zchw
function InfoEdit_MailHistory()
	DataPool:OpenHistroy( nChannel, nIndex );
end

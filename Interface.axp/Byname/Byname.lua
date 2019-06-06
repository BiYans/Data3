local TITLE_COUNT = {};
local EVENT_TYPE;
local strFrontTitle1
local strFrontTitle2

--===============================================
-- PreLoad
--===============================================
function Byname_PreLoad()
	this:RegisterEvent("DRAW_SWEAR_TITLE");
	this:RegisterEvent("CHANGE_SWEAR_TITLE");
end

--===============================================
-- OnLoad
--===============================================
function Byname_OnLoad()
	TITLE_COUNT[0] = "Linh";
	TITLE_COUNT[1] = "Nh¤t";
	TITLE_COUNT[2] = "Nh¸";
	TITLE_COUNT[3] = "Tam";
	TITLE_COUNT[4] = "B¯n";
	TITLE_COUNT[5] = "Nåm";
	TITLE_COUNT[6] = "Sáu";
	
	Byname_Text4:SetText( "Chi" );
end

--===============================================
-- OnEvent
--===============================================
function Byname_OnEvent(event)
	EVENT_TYPE = event
	if ( event == "DRAW_SWEAR_TITLE" ) then
		Byname_Item1_Frame:Show();
		Byname_Item2_Frame:Hide();
		Byname_Text2:SetText( TITLE_COUNT[tonumber( arg0 )] )
	elseif ( event == "CHANGE_SWEAR_TITLE" ) then
		Byname_Item1_Frame:Hide();
		Byname_Item2_Frame:Show();
		Byname_Text3:SetText( tostring( arg0 ) )
		Byname_Text5:SetText( tostring( arg1 ) )
		strFrontTitle1 = tostring( arg0 )
		strFrontTitle2 = tostring( arg1 )
	end
	this:Show()
end

--===============================================
-- ÁìÈ¡/ÐÞ¸Ä³ÆºÅ
--===============================================
function DrawSwearTitle_Accept()
	--ÁìÈ¡³ÆºÅ
	if EVENT_TYPE == "DRAW_SWEAR_TITLE" then
		local msg = Byname_Input1:GetText();
		if msg == "" then
			AxTrace(0,0,"Danh hi®u sai r°i 1")
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end
		msg = Byname_Input3:GetText();
		if msg == "" then
			AxTrace(0,0,"Danh hi®u sai r°i 3")
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end
		local	buf	= Byname_Input1:GetText()..Byname_Text2:GetText()..Byname_Input3:GetText()
		if string.len( buf ) > 8 then
			AxTrace(0,0,"Danh hi®u sai r°i 9")
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end

		if Player:CheckSwearTitle(buf) == 0 then
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end
			
		Player:DrawSwearTitle(buf)
	end
	
	--ÐÞ¸Ä³ÆºÅ
	if EVENT_TYPE == "CHANGE_SWEAR_TITLE" then
		local msg = Byname_Input4:GetText();
		if msg == "" then
			AxTrace(0,0,"Danh hi®u sai r°i 4")
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end
		local	buf	= strFrontTitle1..Byname_Text4:GetText()..Byname_Input4:GetText()..strFrontTitle2
		if string.len( buf ) > 16 then
			AxTrace(0,0,"Danh hi®u sai r°i 9 "..buf)
			PushDebugMessage( "Danh hi®u nh§p sai" )
			return
		end

		if Player:CheckSwearTitle(buf) == 0 then
				PushDebugMessage( "Danh hi®u nh§p sai" )
				return
		end

		Player:ChangeSwearTitle(buf)
	end
	
	DrawSwearTitle_Cancel()
end

function DrawSwearTitle_Cancel()
	Byname_Input1:SetText( "" )
	Byname_Input3:SetText( "" )
	Byname_Input4:SetText( "" )
	this:Hide();
end


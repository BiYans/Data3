function ErjimimaShezhi_PreLoad()
	-- ´ò¿ª½çÃæ
	this:RegisterEvent("MINORPASSWORD_OPEN_SET");
	this:RegisterEvent("MINORPASSWORD_CLEAR_PASSWORD_DLG");
end


function ErjimimaShezhi_OnLoad()


end

function ErjimimaShezhi_OnEvent( event )
	if(event == "MINORPASSWORD_OPEN_SET") then

		if( this:IsVisible() ) then
			return;
		end
		CloseWindow("SafeTime" , true)
		CloseWindow("ErjimimaXiugai", true)
		CloseWindow("ErjimimaJiesuo", true)
		CloseWindow("Fangdao", true)
		CloseWindow("DianhuaMibao", true)

		local safeTimePos = Variable:GetVariable("SafeTimePos");
		if(safeTimePos ~= nil) then
			ErjimimaShezhi_Frame:SetProperty("UnifiedPosition", safeTimePos);
		end

		this:Show();
		ErjimimaShezhi_Shuru:SetText( "" );
		ErjimimaShezhi_Queren:SetText( "" );

		ErjimimaShezhi_SoftKey:SetAimEditBox( "ErjimimaShezhi_Shuru" );

		ErjimimaShezhi_AQtime:SetCheck(0)
		ErjimimaShezhi_Erjimima:SetCheck(1)
		ErjimimaShezhi_TelMibao:SetCheck(0)

	elseif(event == "MINORPASSWORD_CLEAR_PASSWORD_DLG") then

		ErjimimaShezhi_Shuru:SetText( "" );
		ErjimimaShezhi_Queren:SetText( "" );
	end

end

function ErjimimaShezhi_Shuru_OnActive()
	ErjimimaShezhi_SoftKey:SetAimEditBox( "ErjimimaShezhi_Shuru" );
end
function ErjimimaShezhi_Queren_OnActive()
	ErjimimaShezhi_SoftKey:SetAimEditBox( "ErjimimaShezhi_Queren" );
end

function ErjimimaShezhi_AQtime_Clicked()
	ErjimimaShezhi_Close();
	OpenDlg4ProtectTime();
end


function ErjimimaShezhi_Close()
	Variable:SetVariable("SafeTimePos", ErjimimaShezhi_Frame:GetProperty("UnifiedPosition"), 1);
	this:Hide();
end

function ErjimimaShezhi_OnHide()
	Variable:SetVariable("SafeTimePos", ErjimimaShezhi_Frame:GetProperty("UnifiedPosition"), 1);
end

function ErjimimaShezhi_gotoWeb()
--	GameProduceLogin:OpenURL( "http://sde.game.sohu.com/lndex.jsp" )
end

function ErjimimaShezhi_OK_Click()
	local strPassword1 = ErjimimaShezhi_Shuru:GetText();
	local strPassword2 = ErjimimaShezhi_Queren:GetText();

	-- Èç¹ûÃÜÂë²»Ò»ÖÂ
	if(strPassword1 ~= strPassword2) then

		ShowSystemTipInfo("M§t kh¦u nh§p vào không ðúng");
		ErjimimaShezhi_Shuru:SetText( "" );
		ErjimimaShezhi_Queren:SetText( "" );
		return;
	end;

	local iLen = string.len(strPassword1);
	if(iLen < 4) then

		ShowSystemTipInfo("M§t kh¦u không ðßþc ít h½n 4 ký tñ!");
		return;
	end;

	-- Èç¹ûÃÜÂëÒ»ÖÂ¡£·¢ËÍ¸Ä±äÃÜÂëÏûÏ¢¡£
	SendSetMinorPassword(tostring(strPassword1));
	this:Hide();
end

function ErjimimaShezhi_TelMibao_Clicked()
	ErjimimaShezhi_Close();
	OpenDianhuaMibao();
end

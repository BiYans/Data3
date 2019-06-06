function DianhuaMibao_PreLoad()
	this:RegisterEvent("OPEN_MINBAO_STATUS");
end

function DianhuaMibao_OnLoad()
end

function DianhuaMibao_OnEvent( event )
	if ( event == "OPEN_MINBAO_STATUS" ) then
		if( this:IsVisible() ) then
			DianhuaMibao_Close();
		else
			DianhuaMibao_Open();
		end
	end
end

function DianhuaMibao_Close()
	Variable:SetVariable("SafeTimePos", DianhuaMibao_Frame:GetProperty("UnifiedPosition"), 1);
	this:Hide();
end

function DianhuaMibao_Open()
	CloseWindow("ErjimimaShezhi", true)
	CloseWindow("ErjimimaXiugai", true)
	CloseWindow("ErjimimaJiesuo", true)
	CloseWindow("Fangdao", true)
	CloseWindow("SafeTime", true);
	DianhuaMibao_InitDlg();
	this:Show();

	DianhuaMibao_AQtime:SetCheck(0);
	DianhuaMibao_TelMibao:SetCheck(1);
	DianhuaMibao_Erjimima:SetCheck(0);
end

function DianhuaMibao_InitDlg()
	local isPhoneProtect = IsPhoneProtectSetup();
	if(tonumber(isPhoneProtect) == 1) then
		DianhuaMibao_ErjimimaShezhi:SetText("#{DHMB_90417_4}");
	else
		DianhuaMibao_ErjimimaShezhi:SetText("#{DHMB_90417_3}");
	end

	local safeTimePos = Variable:GetVariable("SafeTimePos");
	if(safeTimePos ~= nil) then
		DianhuaMibao_Frame:SetProperty("UnifiedPosition", safeTimePos);
	end
end

function DianhuaMibao_OnHide()
	Variable:SetVariable("SafeTimePos", DianhuaMibao_Frame:GetProperty("UnifiedPosition"), 1);
end

function DianhuaMibao_Close()
	Variable:SetVariable("SafeTimePos", DianhuaMibao_Frame:GetProperty("UnifiedPosition"), 1);
	this:Hide();
end

function DianhuaMibao_AQtime_Clicked()
	DianhuaMibao_Close();
	OpenDlg4ProtectTime();
end

function DianhuaMibao_TelMibao_Clicked()

end

function DianhuaMibao_Erjimima_Clicked()
	DianhuaMibao_Close();
	OpenMinorPassword();
end

function DianhuaMibao_ErjimimaShezhi_Clicked()
--	GameProduceLogin:OpenURL( "http://sde.game.sohu.com/lndex.jsp" );
end

function DianhuaMibao_OK_Click()
	Variable:SetVariable("SafeTimePos", DianhuaMibao_Frame:GetProperty("UnifiedPosition"), 1);
	this:Hide();
end

function DianhuaMibao_gotoWeb()
--	GameProduceLogin:OpenURL( "http://sde.game.sohu.com/lndex.jsp" )
end

function DianhuaMibao_Close()
	Variable:SetVariable("SafeTimePos", DianhuaMibao_Frame:GetProperty("UnifiedPosition"), 1);
	this:Hide();
end

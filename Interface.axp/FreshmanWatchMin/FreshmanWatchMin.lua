--新人按时开奖功能
function FreshmanWatchMin_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OPEN_MINI_WATCH");
	this:RegisterEvent("COUNTDOWN_10SEC");
end

function FreshmanWatchMin_OnLoad()
end

function FreshmanWatchMin_OnEvent(event)
	if ( event == "UI_COMMAND" and tonumber(arg0) == 889103 ) then
			local state = Get_XParam_INT(0)
			local countDownMinute = Get_XParam_INT(1)
			local isPlayerJustLogin = Get_XParam_INT(2)--表示该UICommand是玩家登陆时发送的，还是领奖成功后发送的
			g_State = state
			if state == 0 then
				this:Hide();
				FreshmanWatchMin_StopWatch:SetProperty("Timer",tostring(0));
				FreshmanWatchMin_StopWatch1:SetProperty("Timer",tostring(0));
				return
			end
			if countDownMinute == 0 then
				this:Hide();
				FreshmanWatchMin_StopWatch:SetProperty("Timer",tostring(0));
				FreshmanWatchMin_StopWatch1:SetProperty("Timer",tostring(0));
				return
			else
				FreshmanWatchMin_StopWatch1:SetProperty("Timer",tostring(countDownMinute*60 - 10));
				FreshmanWatchMin_StopWatch:SetProperty("Timer",tostring(countDownMinute*60));
				FreshmanWatchMin_StopWatch:SetProperty("Flash",tostring(0));--停止闪烁	
				FreshmanWatchMin_StopWatch:SetProperty("TextColor","ff00ffff");--改回蓝色
				this:Show()
				--玩家刚刚登陆的时候，需要隐藏
				if g_State == 1 or isPlayerJustLogin == 1 then
					this:Hide()
				end
			end
	elseif  ( event == "OPEN_MINI_WATCH") then
		this:Show()
	elseif ( event == "COUNTDOWN_10SEC") then--倒数最后十秒变色、闪烁
		FreshmanWatchMin_StopWatch:SetProperty("TextColor","ffff0000");
    	FreshmanWatchMin_StopWatch:SetProperty("Flash",tostring(1));
	end
end

function FreshmanWatchMin_TimeOut()
	FreshmanWatchMinDlg()
end
--显示正常倒计时界面
function FreshmanWatchMinDlg()
	if(this:IsVisible()) then
		this:Hide()
		DataPool:ShowNormalWatch()
	end
end

function FreshmanWatchMin_TimeOut1()
	CountDown10Sec()	
end
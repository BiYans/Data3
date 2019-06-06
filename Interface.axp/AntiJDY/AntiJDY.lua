--简单游互斥界面
------------------------------------------------------------------------------------------------------
--
-- 全局变量区
--
--
local g_Type = -1;

-- 注册onLoad事件
function AntiJDY_PreLoad()

	--检测到简单游
	this:RegisterEvent("DETECT_WAIGUA_JDY")
end

function AntiJDY_OnLoad()

	-- 设置总是在最上层显示
	AntiJDY_sub:SetProperty("AlwaysOnTop", "True");
	--

end

-- OnEvent
function AntiJDY_OnEvent(event)
    AntiJDY_sub:SetProperty( "UnifiedPosition", "{{0.500000,-173.000000},{0.500000,-73.000000}}" )

	AntiJDY_Button:Hide();
	AntiJDY_InfoWindow:Show();

	--guochenshu
	if (event == "DETECT_WAIGUA_JDY" ) then
		g_Type = 1;
		local isWaiGuaShow = tonumber(arg0)
		if(isWaiGuaShow == 1) then
		
-- 注释下面两行， 永远不要打开了， 开始倒计时
-- 再次决定打开 ..#71100
			AntiJDY_Button:SetText("确定");
			AntiJDY_Button:Show();

			--计算随即位置，使窗口在屏幕距屏幕1/5的范围内
			--再次随机位置把 相当于功能回退. #71100
			local x_Left= math.random(2,5)/10; --3/10;
			local y_Top= math.random(2,7)/10; --6/10;

			AntiJDY_sub:SetProperty("UnifiedPosition", "{{" .. x_Left .. ", 0.0},{" ..  y_Top .. ", 0.0}}");



			this:Show();
			Variable:SetVariable("WaiGua_ForceGameQuiting", "1", 1); --禁止WM_CLOSE消息.
			--不退出了不退了  #71100
			--EnterQuitWait(3); --强制退出游戏咯.
			
		else
			this:Hide();
		end
	end

end


-------------------------------------------------------------
--
-- 按钮 点击事件
--
function AntiJDY_Bn1Click()

	if( -1 == g_Type ) then
		return
	end

	if (1 == g_Type) then
--		local isWaiGua = CheckWaiGuaJDY()
--		if( 1 == isWaiGua ) then
--			return
--		else
--			this:Hide()
--		end
	end
	this:Hide();
end

function AntiJDY_Frame_OnHiden()
	DataPool:SetCanUseHotKey(1);
	Variable:SetVariable("WaiGua_ForceGameQuiting", "0", 1); --当然要修改咯。 要不然关了窗口用户点 X 或alt+f4等关没用 打开WM_CLOSE消息 #71100
end

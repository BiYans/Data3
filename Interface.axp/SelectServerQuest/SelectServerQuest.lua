

------------------------------------------------------------------------------------------------------
--
-- 全局变量区
--
--
local g_iYesNoType = -1;	-- yes-no 对话框类型
													-- -1 -- 普通信息提示
													-- 0 - 退出游戏
													-- 1 - 删除角色
													-- 2 - 更换帐号
													-- 3 - 断开网络
													-- 4 - 确认是否删除10级以上玩家
													-- 5 - 7天内提醒删除10级以上玩家
													-- 6 - 7天后，14天内提醒删除10级以上玩家
													-- 7 - 是否删除10级以下玩家
													-- 8 删除玩家
													-- 9 是否注册
local g_strMessageData;

local g_bagIndex = -1
local g_bagIndex2 = -1
local g_objCared = -1
-- 注册onLoad事件
function LoginSelectServerQuest_PreLoad()
	
	-- 打开界面
	this:RegisterEvent("GAMELOGIN_SHOW_SYSTEM_INFO");
	
	-- 关闭界面
	this:RegisterEvent("GAMELOGIN_CLOSE_SYSTEM_INFO");
	
	
	-- 点击确定按钮关闭网络
	this:RegisterEvent("GAMELOGIN_SHOW_SYSTEM_INFO_CLOSE_NET");   

	-- 显示不带按钮的信息
	this:RegisterEvent("GAMELOGIN_SHOW_SYSTEM_INFO_NO_BUTTON");   
	-- 显示yes-no信息
	this:RegisterEvent("GAMELOGIN_SYSTEM_INFO_YESNO");   
	this:RegisterEvent("GAMELOGIN_SYSTEM_INFO_OK");   
	this:RegisterEvent("GAMELOGIN_SYSTEM_INFO_CANCEL"); 
	this:RegisterEvent("GAMELOGIN_SYSTEM_INFO_CLOSE"); 
	this:RegisterEvent("UI_COMMAND");
	-- 珍兽装备分解确认
	this:RegisterEvent("PET_EQUIP_DEPART_CONFIRM")

end

function LoginSelectServerQuest_OnLoad()
	
	-- 设置总是在最上层显示
	SelectServerQuest_Frame_sub:SetProperty("AlwaysOnTop", "True");
	
	-- 
	

end
function LoginSelectUpdateRect()
	local nWidth, nHeight = SelectServerQuest_InfoWindow:GetWindowSize();
	local nTitleHeight = 23;
	local nBottomHeight = 25;
	local nWindowHeight = nTitleHeight + nBottomHeight + nHeight;
	SelectServerQuest_Frame_sub:SetProperty( "AbsoluteHeight", tostring( nWindowHeight ) );
	AxTrace( 0,0, "LastWindowSize ="..tostring( nWindowWidth )..","..tostring(nWindowHeight) );
	--SelectServerQuest_Frame_sub:SetWindowSize( nWindowWidth, nWindowHeight );
end

local TimerArg = "";
local g_QuitType = 0;
local g_bIsQuitMsgBox = 0;
-- OnEvent
function LoginSelectServerQuest_OnEvent(event)
		g_bIsQuitMsgBox = 0;
    SelectServerQuest_Frame_sub:SetProperty( "UnifiedPosition", "{{0.500000,-173.000000},{0.500000,-118.000000}}" )

	--AxTrace( 0,0, "get event");
	SelectServerQuest_Button2:Hide();
	SelectServerQuest_Button1:Hide();
	SelectServerQuest_LostPassword:Hide()
	SelectServerQuest_Time_Text : Hide();
	SelectServerQuest_InfoWindow:Show();
	if( event == "GAMELOGIN_SHOW_SYSTEM_INFO" ) then
	
		g_iYesNoType = -1;
		--AxTrace( 0,0, "显示系统信息");
		if( arg1 ~= "WAITFORQUIT" ) then
			SelectServerQuest_InfoWindow:SetText(arg0);
			LoginSelectUpdateRect();
		end
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:SetText("畜ng");
		SelectServerQuest_Button1:Enable()


		if( arg1 == "USERONLINE" ) then
		    SelectServerQuest_Time_Text : SetProperty("Timer",tostring(20));
		    SelectServerQuest_Time_Text : Show()
		    SelectServerQuest_Button1:Disable()
		    TimerArg = arg1;
		    arg1 = nil;
		elseif (arg1 == "UserId_Password_Err") then
			SelectServerQuest_LostPassword:Show();
			SelectServerQuest_LostPassword:Enable()
		elseif(arg1 == "USERFROMMAINPRO") then
		    SelectServerQuest_Time_Text : SetProperty("Timer",tostring(20));
		    SelectServerQuest_Time_Text : Show()
		    SelectServerQuest_Button1:Hide();
		    SelectServerQuest_Button2:Hide();
		    TimerArg = arg1;
		    arg1 = nil;
		elseif( arg1 == "MIBAOERROR" ) then
		    SelectServerQuest_Time_Text : SetProperty("Timer",tostring(60));
		    SelectServerQuest_Time_Text : Show()
		    SelectServerQuest_Button1:Disable()
		    TimerArg = arg1;
		    arg1 = nil;
		elseif( arg1 == "WAITFORQUIT" ) then
		    if(arg3~=nil and tonumber(arg3)~=nil)then
			if(tonumber(arg3)>0)then
				SelectServerQuest_Time_Text : SetProperty("Timer",tostring(10));
				SelectServerQuest_InfoWindow:SetText("Sau 10 gi鈟 s� tho醫 kh鰅 tr� ch絠");
				LoginSelectUpdateRect();
				
			else
				SelectServerQuest_Time_Text : SetProperty("Timer",tostring(3));
				SelectServerQuest_InfoWindow:SetText("Sau 3 gi鈟 s� tho醫 kh鰅 tr� ch絠!");
				LoginSelectUpdateRect();
			end
		    else
			 SelectServerQuest_Time_Text : SetProperty("Timer",tostring(3));
			 SelectServerQuest_InfoWindow:SetText("Sau 3 gi鈟 s� tho醫 kh鰅 tr� ch絠!");
			LoginSelectUpdateRect();
		    end
		    SelectServerQuest_Time_Text : Show()
		    SelectServerQuest_Button1:SetText("Hu�");
		    SelectServerQuest_Button1:Show();
		    SelectServerQuest_Button1:Enable()
		    TimerArg = arg1;
		    g_QuitType = tonumber(arg2);
		    g_bIsQuitMsgBox = 1;
		    arg1 = nil;
		else
		    TimerArg = nil;
		    arg1 = nil;
		    SelectServerQuest_Time_Text : Hide()    
		end
				
		this:Show();
		return;
	end
	
	
	
	
	if( event == "GAMELOGIN_CLOSE_SYSTEM_INFO") then
		
		g_iYesNoType = -1;
		this:Hide();
		return;
	end
	
	--AxTrace( 0,0, "event yes no");
	if( event == "GAMELOGIN_SYSTEM_INFO_YESNO") then
		
		if( tonumber(arg1) == 11 ) then
			GameProduceLogin:CheckAccountNoMibao();
		else 
			--AxTrace( 0,0, "显示yes no");
			SelectServerQuest_InfoWindow:SetText(arg0);
			LoginSelectUpdateRect();
			g_iYesNoType = tonumber(arg1);
		
		if g_iYesNoType == 20 and arg2 ~= nil  and arg3 ~= nil then
			g_objCared = tonumber(arg2)
			g_bagIndex = tonumber(arg3)
		end
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button2:SetText("Hu�");
		SelectServerQuest_Button2:Show();
		SelectServerQuest_Button1:Show();
		this:Show();
		return;
		end
	end
	if( event == "GAMELOGIN_SHOW_SYSTEM_INFO_NO_BUTTON" ) then
	
	    if( nil ~= arg1 ) then
	        local strArg = tostring( arg1 )
			if( strArg == "CharSel_EnterGame" ) then
			--if( strArg == "CharSel_EnterGam" ) then
				SelectServerQuest_Frame_sub:SetProperty( "UnifiedPosition", "{{0.500000,-173.000000},{0.900000,-118.000000}}" )
			end
		arg1 = nil;
	    end
	
		g_iYesNoType = -1;--tonumber(arg1);
		SelectServerQuest_InfoWindow:SetText(arg0);
		LoginSelectUpdateRect();
		this:Show();
		SelectServerQuest_Button1:Hide();
		SelectServerQuest_Button2:Hide();
		return;


	end
	if( event == "GAMELOGIN_SYSTEM_INFO_OK" ) then
		AxTrace( 0,0,"GAMELOGIN_SYSTEM_INFO_OK" );
		g_iYesNoType = tonumber(arg1);
		SelectServerQuest_InfoWindow:SetText(arg0);
		LoginSelectUpdateRect();
		if g_iYesNoType == 0 then
			SelectServerQuest_Button1:SetText("畜ng");
		else
			SelectServerQuest_Button1:SetText("Duy畉");
		end
		this:Show();
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button2:Hide();
		return;
	end
	if( event == "GAMELOGIN_SYSTEM_INFO_CANCEL" ) then
	
		g_iYesNoType = tonumber(arg1);
		SelectServerQuest_InfoWindow:SetText(arg0);
		LoginSelectUpdateRect();
		SelectServerQuest_Button1:SetText("Hu�");
		this:Show();
		SelectServerQuest_Button2:Hide();
		return;
	end
	if( event == "GAMELOGIN_SYSTEM_INFO_CLOSE" ) then
	
		g_iYesNoType = tonumber(arg1);
		SelectServerQuest_InfoWindow:SetText(arg0);
		LoginSelectUpdateRect();
		SelectServerQuest_Button1:SetText("畜ng");
		this:Show();
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button2:Hide();
		return;
	end
	
	
	
	if( event == "GAMELOGIN_SHOW_SYSTEM_INFO_CLOSE_NET") then
		
		--AxTrace( 0,0, "需要关闭网络.");
		g_iYesNoType = 3;
		SelectServerQuest_InfoWindow:SetText(arg0);
		LoginSelectUpdateRect();
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:SetText("畜ng");
		this:Show();
		return;
	end
	
	-- 血浴神兵——神器铸造
	if ( event == "UI_COMMAND" and tonumber(arg0) == 13906) then
		g_iYesNoType = -1;
		SelectServerQuest_InfoWindow:SetText("#cFFF263#{XYSB_080925_001}");
		LoginSelectUpdateRect();

		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:SetText("畜ng");
		SelectServerQuest_Button1:Enable()
		
		this:Show();
	end
	
	-- 血浴神兵——神器重铸
	if ( event == "UI_COMMAND" and tonumber(arg0) == 12032203) then
		g_iYesNoType = -1;
		SelectServerQuest_InfoWindow:SetText("#cFFF263 Sau khi ti猵 t鴆 r鑞 luy畁 th kh� s� b� h鼀 di畉, nh鎛g b鋙 th誧h 疸 kh鋗 n誱 ho c叨ng h骯 l阯 Th kh� c鹡g s� m theo.");
		LoginSelectUpdateRect();

		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:SetText("畜ng");
		SelectServerQuest_Button1:Enable()
		
		this:Show();
	end

	if( event == "UI_COMMAND" and tonumber(arg0) == 300077) then
		g_iYesNoType = 12;
		local slzExp = Get_XParam_INT( 0 )
		local levelCanUp = Get_XParam_INT( 1 )
		local petLevel = Get_XParam_INT( 2 )
		local toMaxLevel = Get_XParam_INT( 3 )
		local PetGuidH = Get_XParam_INT( 4 )
		local PetGuidL = Get_XParam_INT( 5 )
		g_bagIndex = Get_XParam_INT( 6 )
		local petClass = Pet:GetPetDBCName(PetGuidH,PetGuidL)

		if levelCanUp == 0 then
			local strText = string.format("#{SLZSDSJ_090915_2}%s#{SLZSDSJ_090915_3}%d#{SLZSDSJ_090915_4}",petClass,slzExp)
			SelectServerQuest_InfoWindow:SetText( strText );
		elseif levelCanUp > 0 then
			--升级界面不在这里，在PetShelizi_Msg中
			return
		end
		
		LoginSelectUpdateRect();
		
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button2:SetText("Hu�");
		SelectServerQuest_Button2:Show();
		SelectServerQuest_Button1:Show();
		this:Show();
		
	end
	
	--天元金丹 hzp
	if( event == "UI_COMMAND" and tonumber(arg0) == 332004) then
		g_iYesNoType = 13;
		g_bagIndex = Get_XParam_INT( 0 )
		SelectServerQuest_InfoWindow:SetText("#{TSXF_090408_03}");
		
		LoginSelectUpdateRect();
		
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button2:SetText("Hu�");
		SelectServerQuest_Button2:Show();
		SelectServerQuest_Button1:Show();
		this:Show();
		
	end
	
	--暗器升级
	if( event == "UI_COMMAND" and tonumber(arg0) == 260001) then
		g_iYesNoType = -1;
		g_bagIndex = Get_XParam_INT( 0 );
		g_bagIndex2 = Get_XParam_INT( 1 )
		SelectServerQuest_InfoWindow:SetText("#{AQSJ_090709_10}");
		
		LoginSelectUpdateRect();
		
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:Enable()
		this:Show();
		
	end

	--神器升级
	if( event == "UI_COMMAND" and tonumber(arg0) == 500505) then
		g_iYesNoType = -1;
		g_bagIndex = Get_XParam_INT( 0 );
		g_bagIndex2 = Get_XParam_INT( 1 )
		SelectServerQuest_InfoWindow:SetText("#{SQSJ_0708_09}");

		LoginSelectUpdateRect();

		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:Enable()
		this:Show();
	end

	--新舍利子 add by hzp 09-06-29
	if( event == "UI_COMMAND" and tonumber(arg0) == 300088) then
		g_iYesNoType = 14;
		local slzExp = Get_XParam_INT( 0 )
		local levelCanUp = Get_XParam_INT( 1 )
		local petLevel = Get_XParam_INT( 2 )
		local toMaxLevel = Get_XParam_INT( 3 )
		local PetGuidH = Get_XParam_INT( 4 )
		local PetGuidL = Get_XParam_INT( 5 )
		g_bagIndex = Get_XParam_INT( 6 )
		local petClass = Pet:GetPetDBCName(PetGuidH,PetGuidL)

		if levelCanUp == 0 then
			local strText = string.format("#{ZSKSSJ_081113_19}%s#{ZSKSSJ_081113_20}%d#{ZSKSSJ_081113_21}%d#{ZSKSSJ_081113_22}",petClass,slzExp ,toMaxLevel)	
			SelectServerQuest_InfoWindow:SetText( strText );
		elseif levelCanUp > 0 then
			local strText = string.format("#{ZSKSSJ_081113_19}%s#{ZSKSSJ_081113_20}%d#{ZSKSSJ_081113_28}%d#{ZSKSSJ_081113_29}%d#{ZSKSSJ_081113_30}%d#{ZSKSSJ_081113_22}",petClass,slzExp ,petLevel ,petLevel + levelCanUp ,toMaxLevel)
			SelectServerQuest_InfoWindow:SetText( strText );
		end
		
		LoginSelectUpdateRect();
		
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button2:SetText("Hu�");
		SelectServerQuest_Button2:Show();
		SelectServerQuest_Button1:Show();
		this:Show();
		
	end
	-- 雕纹拆除确认 by lhx tt80366
	if ( event == "UI_COMMAND" and tonumber(arg0) == 20101026) then
		g_iYesNoType = -1;
		SelectServerQuest_InfoWindow:SetText("#{CCDW_101026_01}");
		LoginSelectUpdateRect();

		SelectServerQuest_Button1:Show();
		SelectServerQuest_Button1:SetText("畜ng");
		SelectServerQuest_Button1:Enable()

		this:Show();
	end

	if (event == "PET_EQUIP_DEPART_CONFIRM") then
		local equipname = arg0
		g_iYesNoType = tonumber(arg1)
		SelectServerQuest_InfoWindow:SetText("#{ZSZBSJ_XML_17}" .. equipname .. "#{ZSZBSJ_XML_18}")
		LoginSelectUpdateRect()
		SelectServerQuest_Button1:SetText("Duy畉");
		SelectServerQuest_Button2:SetText("Hu�");
		SelectServerQuest_Button2:Show();
		SelectServerQuest_Button1:Show();
		this:Show();
	end

end

function SelectServerQuest_LostPassWord()
	if(Variable:GetVariable("System_CodePage") == "1258") then
    GameProduceLogin:OpenURL( "https://psp.gate.vn/Account/ForgotPass/" )
	else
    GameProduceLogin:OpenURL( "http://sde.game.sohu.com/reg/changepwd.jsp" )
	end
end

-------------------------------------------------------------
--
-- 按钮1 点击事件
--
function SelectServerQuest_Bn1Click()
-- 0 - 退出游戏
-- 4 - 确认是否删除10级以上玩家
-- 5 - 7天内提醒删除10级以上玩家
-- 6 - 7天后，14天内提醒删除10级以上玩家
-- 7 - 是否删除10级以下玩家
-- 8 - 大于10级得提示
	if( -1 == g_iYesNoType and 1 == g_bIsQuitMsgBox) then
		CancelQuitWait(); --取消退出
	end
	if(0 == g_iYesNoType) then		
		QuitApplication("quit");
	elseif(1 == g_iYesNoType) then		
	elseif(2==g_iYesNoType) then
		GameProduceLogin:ChangeToAccountInputDlgFromSelectRole();
	elseif( 3 == g_iYesNoType ) then
		GameProduceLogin:CloseNetConnect();
	elseif( 4 == g_iYesNoType ) then
			local strInfo;
		  strInfo ="Nh鈔 v c黙 c醕 h� kh鬾g th� x骯 ngay 疬㧟, xin 3 ng鄖 sau trong v騨g 14 ng鄖 疱ng nh v鄌 tr� ch絠, 皙n L誧 D呓ng (268, 46) t靘 Quan H醤 Th� ho 姓i L� (80, 136) t靘 Chu X呓ng x醕 nh, l� c� th� x骯. L鷆 x醕 nh x骯 nh鈔 v kh鬾g th� c� bang h礽, k猼 h鬾, k猼 b醝, m� ti甿 tr課g th醝, n猽 kh鬾g vi甤 x骯 nh鈔 v s� b� h鼀. Qu� 14 ng鄖 kh鬾g x醕 nh thao t醕 x骯 nh鈔 v s� v� hi畊."
		  GameProduceLogin:ShowMessageBox( strInfo, "OK", "8" );--qds 没有给出对话框造成不能删除角色
		  --strInfo ="您的角色不能马上删除，请在3天以后14天以内登录游戏，到洛阳（268，46）找到关汉寿或者到大理（80，136）找到周仓确认，即可永久删除。确认删除时角色不能处于有帮会、结婚、结拜、师徒、开店状态，否则删除将被取消。超过14天没有再次删除则删除操作无效。"
	elseif( 5 == g_iYesNoType ) then
	elseif( 6 == g_iYesNoType ) then
	elseif( 7 == g_iYesNoType ) then
		GameProduceLogin:DelSelRole();
	elseif( 8 == g_iYesNoType ) then
		GameProduceLogin:DelSelRole();
	elseif( 9 == g_iYesNoType ) then
		GameProduceLogin:LoginPlayer( 1 );
	elseif( 10 == g_iYesNoType ) then
		AxTrace( 0,0, "Ph鋓 ch錸g k韈h ho誸_g� n鷗 OK");
	elseif(11 == g_iYesNoType) then
		GameProduceLogin:CheckAccountNoMibao();
	elseif(12 == g_iYesNoType) then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "UseShelizi" )
			Set_XSCRIPT_ScriptID( 300077 )
			Set_XSCRIPT_Parameter( 0, g_bagIndex )
			Set_XSCRIPT_Parameter( 1, 0)
			Set_XSCRIPT_ParamCount(2)
		Send_XSCRIPT()
	elseif(13 == g_iYesNoType) then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "UseTianYuanJinDan" )
			Set_XSCRIPT_ScriptID( 332004 )
			Set_XSCRIPT_Parameter( 0, g_bagIndex )
			Set_XSCRIPT_ParamCount(1)
		Send_XSCRIPT()
	elseif(14 == g_iYesNoType) then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "UseShelizi" )
			Set_XSCRIPT_ScriptID( 300088 )
			Set_XSCRIPT_Parameter( 0, g_bagIndex )
			Set_XSCRIPT_ParamCount(1)
		Send_XSCRIPT()
	elseif(15 == g_iYesNoType) then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "Anqi2Shenzhen" )
			Set_XSCRIPT_ScriptID( 260001 )
			Set_XSCRIPT_Parameter( 0, g_bagIndex )
			Set_XSCRIPT_Parameter( 1, g_bagIndex2 )
			Set_XSCRIPT_ParamCount(2)
		Send_XSCRIPT()
	elseif (17 == g_iYesNoType) then
		PetEquipSuitDepart:ConfirmDepart()
	elseif (20 == g_iYesNoType) then
		if g_objCared ~= -1 and g_bagIndex ~= -1 then
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("DelProtectGoods");
				Set_XSCRIPT_ScriptID(124);
				Set_XSCRIPT_Parameter(0,tonumber(g_objCared));
				Set_XSCRIPT_Parameter(1,tonumber(g_bagIndex));
				Set_XSCRIPT_ParamCount(2);
			Send_XSCRIPT();
		end
	elseif (19 == g_iYesNoType) then
		LifeAbility:ConfirmDiaowenShike(1)
	elseif (21 == g_iYesNoType) then
		LifeAbility:ConfirmDiaowenHecheng(1)
	elseif (22 == g_iYesNoType) then
		LifeAbility:ConfirmDiaowenQianghua(1)
	elseif (23 == g_iYesNoType) then
		LifeAbility:ConfirmDiaowenShike(2)
	end
	
	this:Hide();
end


-------------------------------------------------------------
--
-- 按钮2 点击事件
--
function SelectServerQuest_Bn2Click()

	if(3 == g_iYesNoType) then
		GameProduceLogin:CloseNetConnect();
	elseif( 9 == g_iYesNoType ) then
		GameProduceLogin:PassportButNotReg();
	elseif( 10 == g_iYesNoType ) then
		AxTrace( 0,0, "Ph鋓 ch錸g k韈h ho誸_g� n鷗 NO");	
	end
	
	this:Hide();
end

function SelectServerQuest_TimeOut()
  if( TimerArg == "USERONLINE" ) then
    SelectServerQuest_Button1:Enable()
    TimerArg = nil
  elseif(TimerArg == "MIBAOERROR" ) then
    SelectServerQuest_Button1:Enable()
    TimerArg = nil
  elseif(TimerArg == "USERFROMMAINPRO") then
	this:Hide();
	TimerArg = nil
  elseif(TimerArg == "WAITFORQUIT") then
	if(tonumber(g_QuitType)==0)then
		QuitApplication("quit");
	else
		AskRet2SelServer();
	end
	this:Hide();
	TimerArg = nil
	g_QuitType = nil
   end
end

function SelectServerQuest_Frame_OnHiden()
	DataPool:SetCanUseHotKey(1);
end


-----------------------------------------------------------------------------------------------------------------
--
-- 全局变量区
--

-- 名字
local g_RoleName = {};

-- 门派
local g_iMenPai = {};

-- 等级
local g_iLevel = {};

-- 等级
local g_iDelTime = {};

-- 在界面上显示的ui模型
local g_UIModel = {};

-- 选择按钮
local g_BnSelCheck = {};

-- 当前选择的角色
local g_iCurSelRole = 0;

-- 当前角色的个数
local g_iCurRoleCount = 0;

-- 如果是创建成功后刷新界面， 要选中最后创建的这个角色.
--
-- 0 -- 创建角色失败。
-- 1 -- 创建角色成功。
local g_bCreateSuccess = 0;

------------------------------------------------------------------------------------------------------------------
--
-- 函数区
--

-- 注册onLoad事件
function LoginSelectRole_PreLoad()
	-- 打开界面
	this:RegisterEvent("GAMELOGIN_OPEN_SELECT_CHARACTOR");
	
	-- 关闭界面
	this:RegisterEvent("GAMELOGIN_CLOSE_SELECT_CHARACTOR");
	
	-- 刷新角色信息
	this:RegisterEvent("GAMELOGIN_REFRESH_ROLE_SELECT_CHARACTOR"); 
	
	-- 创建角色成功。
	this:RegisterEvent("GAMELOGIN_CREATE_ROLE_OK"); 

	this:RegisterEvent("ENTER_GAME"); 
	
	this:RegisterEvent("GAMELOGIN_SELECTCHARACTER"); 
	
end

-- 注册onLoad事件
function LoginSelectRole_OnLoad()

	-- 角色名字
	--g_RoleName[1] = SelectRole_Role1_Name;
	--g_RoleName[2] = SelectRole_Role2_Name;
	--g_RoleName[3] = SelectRole_Role3_Name;
	
	g_RoleName[1] = ""
	g_RoleName[2] = ""
	g_RoleName[3] = ""
		
	-- 角色门派
	g_iMenPai[1] = 0;
	g_iMenPai[2] = 0;
	g_iMenPai[3] = 0;
	
	-- 角色等级
	g_iLevel[1] = 0;
	g_iLevel[2] = 0;
	g_iLevel[3] = 0;
	
	g_iDelTime[1] = 0;
	g_iDelTime[2] = 0;
	g_iDelTime[3] = 0;
	-- 角色选择按钮
	--g_BnSelCheck[1] = SelectRole_Role1;
	--g_BnSelCheck[2] = SelectRole_Role2;
	--g_BnSelCheck[3] = SelectRole_Role3;
	
	-- 选择按钮
	--g_BnSelCheck[1]:SetProperty("CheckMode", "1");	
	--g_BnSelCheck[2]:SetProperty("CheckMode", "1");	
	--g_BnSelCheck[3]:SetProperty("CheckMode", "1");	
	
	--g_BnSelCheck[1]:SetCheck( 0 );	
	--g_BnSelCheck[2]:SetCheck( 0 );	
	--g_BnSelCheck[3]:SetCheck( 0 );	
	-- ui模型名字
	--g_UIModel[1] = SelectRole_Role1_Model;
	--g_UIModel[2] = SelectRole_Role2_Model;
	--g_UIModel[3] = SelectRole_Role3_Model;
	
	--SelectRole_Role1_Model:SetProperty("MouseHollow", "True");	
	--SelectRole_Role2_Model:SetProperty("MouseHollow", "True");	
	--SelectRole_Role3_Model:SetProperty("MouseHollow", "True");	
	
	
	
end

-- OnEvent
function LoginSelectRole_OnEvent(event)

	if( event == "GAMELOGIN_OPEN_SELECT_CHARACTOR" ) then
	    
	    local CurSelIndex = GameProduceLogin:GetCurSelectRole();
	    
		-- 默认选择第一个人物。
		g_iCurSelRole = CurSelIndex + 1  --1;
		
		AxTrace( 1, 0, g_iCurSelRole )
		
		SelectRole_ClearInfo();
		SelectRole_RefreshRoleInfo();
		this:Show();
		return;
	end
	
	
	if( event == "GAMELOGIN_CLOSE_SELECT_CHARACTOR" ) then
	
		-- 清空数据
		SelectRole_ClearInfo();
		this:Hide();
		return;
	end
	
	
	-- 刷新角色
	if( event == "GAMELOGIN_REFRESH_ROLE_SELECT_CHARACTOR") then
		
		SelectRole_RefreshRoleInfo();
		return;
	end
	
	
	-- 创建角色成功。
	if( event == "GAMELOGIN_CREATE_ROLE_OK") then
		
		g_bCreateSuccess = 1;
		return;
	end

	if( event == "ENTER_GAME" ) then
		GameProduceLogin:SendEnterGameMsg(g_iCurSelRole - 1);
		return;
	end
	
	if( event == "GAMELOGIN_SELECTCHARACTER" ) then
	   local CurSel = tonumber( arg0 )
	   
	   if( 0 == CurSel ) then 
	     SelectRole_SelectRole1()
	   end
	   
	   if( 1 == CurSel ) then 
	     SelectRole_SelectRole2()
	   end
	   
	   if( 2 == CurSel ) then 
	     SelectRole_SelectRole3()
	   end
	   
	end
			
 		
end



---------------------------------------------------------------------------------------------
--
-- 进入游戏
--
function SelectRole_EnterGame()

	-- 发送进入游戏消息
	GameProduceLogin:SendEnterGameMsg(g_iCurSelRole - 1);
end

---------------------------------------------------------------------------------------------
--
-- 创建角色
--
function SelectRole_CreateRole()

	--此处不直接从人物选择界面切换到人物创建界面....
	--向Login请求创建人物的图形验证信息....验证信息到来后会开启验证界面....验证通过后验证界面会切换到人物创建流程....
	DataPool:AskCreateCharCode();

end



---------------------------------------------------------------------------------------------
--
-- 删除角色
--
function SelectRole_DelRole()

	GameProduceLogin:SetCurSelect( g_iCurSelRole - 1 );
	-- 从人物选择界面切换到人物创建界面.
		local strName;
	local iMenPai;
	local iLevel;
	local iDelTime;
	local strInfo;
	strName
	,iMenPai
	,iLevel
	,iDelTime
	= GameProduceLogin:GetRoleInfo(g_iCurSelRole-1);
	if( iLevel == 0 ) then --说明没有角色
		strInfo="Kh鬾g ch鱪 nh鈔 v";
			GameProduceLogin:ShowMessageBox( strInfo, "OK", "6" );
		return;
	end
	if( iLevel >= 1 ) then --如果大于10级
		if( iDelTime >= 11 ) then--说明还不能删除呢，出提示对话框
			strInfo="H鼀 b� xin 疸 疬a cho"..tostring( 14 - iDelTime ).."ng鄖 r癷, sau 3 ng鄖 khi h鼀 b� nh鈔 v, trong v騨g 14 ng鄖 疱ng nh tr� ch絠, h銀 皙n th鄋h L誧 D呓ng (268, 46) t靘 Quan H醤 Th� ho ho 姓i L� (80, 136) t靘 Chu X呓ng x醕 nh.";
			GameProduceLogin:ShowMessageBox( strInfo, "OK", "6" );
		elseif( iDelTime > 0 ) then		--说明可以删除呢，出提示对话框
			strInfo="Xin 疱ng nh v鄌 tr� ch絠, 皙n L誧 D呓ng (268,46) t靘 Quan H醤 Th� ho 姓i L� (80,136) t靘 Chu X呓ng x醕 nh, c� th� x骯 b�. C醕 h� c ph鋓 kh鬾g c� bang h礽, k猼 h鬾, m� ti甿, k猼 b醝, s� 鸢 c醕 lo読 quan h� n鄖 m緄 c� th� x骯 b�. ";
			GameProduceLogin:ShowMessageBox( strInfo, "OK", "5" );
		else --说明要删除了，出现提示对话框
			strInfo = "C醕 h� quy猼 鸶nh mu痭 s�"..tostring( iLevel ).."Nh鈔 v c #c00ff00"..strName.."#cffffff h鼀 b� kh鬾g?";
			GameProduceLogin:ShowMessageBox( strInfo, "YesNo", "4" );
		end
	else --直接出现提示，是否删除
		strInfo = "C醕 h� quy猼 鸶nh mu痭 s�"..tostring( iLevel ).."Nh鈔 v c #c00ff00"..strName.."#cffffff h鼀 b� kh鬾g?";
		GameProduceLogin:ShowMessageBox( strInfo, "YesNo", "7" );
	end
	
end
	
	
---------------------------------------------------------------------------------------------
--
-- 返回到上一步
--				
function SelectRole_Return()
			
	GameProduceLogin:ExitToAccountInput_YesNo();	
	--GameProduceLogin:ChangeToAccountInputDlgFromSelectRole();
end
				

---------------------------------------------------------------------------------------------------------------
--
--   刷新角色信息
--
function SelectRole_RefreshRoleInfo()

	-- 清空界面.
	SelectRole_ClearInfo();
	
	g_iCurRoleCount = GameProduceLogin:GetRoleCount();
	-- 得到人物的个数
	AxTrace( 0,0, "姓t 疬㧟 s� nh鈔 v"..tostring(g_iCurRoleCount));
	
	if(0 == g_iCurRoleCount) then
	
		return;
	end;
	
	for index =0 , g_iCurRoleCount-1 do
	 		
	 		AxTrace( 0,0, "Hi琻 th� nh鈔 v"..tostring(index));
			SelectRole_GetRoleInfo(index);
	end
	
	-- 选择角色
	if(1 == g_bCreateSuccess) then
			
			-- 创建成功后
			g_iCurSelRole = g_iCurRoleCount;
			g_bCreateSuccess = 0;
	end
			
	SelectRole_ShowSelRoleInfo(g_iCurSelRole);
	
end


---------------------------------------------------------------------------------------------------------------
--
--   刷新角色信息
--
function SelectRole_GetRoleInfo(index)

	local strName;
	local iMenPai;
	local iLevel;
	local iDelTime;
	
	strName
	,iMenPai
	,iLevel
	,iDelTime
	= GameProduceLogin:GetRoleInfo(index);
	
	-- 设置名字
	--g_RoleName[index+1]:SetText(strName);
	g_RoleName[index+1] = strName;
	g_iMenPai[index+1] = iMenPai;
	g_iLevel[index+1]  = iLevel;
	g_iDelTime[index+1] = iDelTime;
	
end

---------------------------------------------------------------------------------------------------------------
--
--   清空角色信息.
--
function SelectRole_ClearInfo()

	SelectRole_TargetInfo_Name_Text:SetText("");
	SelectRole_TargetInfo_Menpai_Text:SetText("");
	SelectRole_TargetInfo_Level_Text:SetText("");
	SelectRole_TargetInfo_Delete:Hide();
	--g_RoleName[1]:SetText("");
	--g_RoleName[2]:SetText("");
	--g_RoleName[3]:SetText("");
	
	--g_UIModel[1]:SetFakeObject("");
	--g_UIModel[2]:SetFakeObject("");
	--g_UIModel[3]:SetFakeObject("");
		
end


---------------------------------------------------------------------------------------------------------------
--
--   选择角色1.
--
function SelectRole_SelectRole1()

	AxTrace( 0,0, " Ch鱪 1");	
	g_iCurSelRole = 1;
	if(g_iCurRoleCount < g_iCurSelRole) then

		AxTrace( 0,0, " Ch遖 ch鱪 1 trong s� d呔i 疴y");	
		SelectRole_TargetInfo_Name_Text:SetText("");
		SelectRole_TargetInfo_Menpai_Text:SetText("");
		SelectRole_TargetInfo_Level_Text:SetText("");
		return;
	end
	
	SelectRole_ShowSelRoleInfo(g_iCurSelRole);
	
end

---------------------------------------------------------------------------------------------------------------
--
--   选择角色2.
--
function SelectRole_SelectRole2()

	AxTrace( 0,0, " Ch鱪 2");	
	g_iCurSelRole = 2;
	if(g_iCurRoleCount < g_iCurSelRole) then
	
		SelectRole_TargetInfo_Name_Text:SetText("");
		SelectRole_TargetInfo_Menpai_Text:SetText("");
		SelectRole_TargetInfo_Level_Text:SetText("");
		return;
	end
	
	SelectRole_ShowSelRoleInfo(g_iCurSelRole);
	
end


---------------------------------------------------------------------------------------------------------------
--
--   选择角色3.
--
function SelectRole_SelectRole3()

	AxTrace( 0,0, " Ch鱪 3");	
	g_iCurSelRole = 3;
	if(g_iCurRoleCount < g_iCurSelRole) then
	
		SelectRole_TargetInfo_Name_Text:SetText("");
		SelectRole_TargetInfo_Menpai_Text:SetText("");
		SelectRole_TargetInfo_Level_Text:SetText("");
		return;
	end
	
	SelectRole_ShowSelRoleInfo(g_iCurSelRole);
	
end


---------------------------------------------------------------------------------------------------------------
--
--   通过索引, 选择角色
--
function SelectRole_ShowSelRoleInfo(index)

	if(g_iCurRoleCount < index or 0 >= index ) then
	
		SelectRole_TargetInfo_Name_Text:SetText("");
		SelectRole_TargetInfo_Menpai_Text:SetText("");
		SelectRole_TargetInfo_Level_Text:SetText("");
		return;
	end
		
	if(index < 1)	then
	
		return;
	end;
	-- 显示名字
	AxTrace(0, 0, "show sel info index="..index);
	--SelectRole_TargetInfo_Name_Text:SetText(g_RoleName[index]:GetText());
	--added by dun.liu 2008-04-18
	SelectRole_TargetInfo_Name_Text:SetText( "#c00ff00Nh鈔 v: #cffffff"..g_RoleName[index] );
	
	
	-- 显示门派
	local strName = "Kh鬾g c�";
	local Family  = g_iMenPai[index];

	-- 得到门派名称.
	if(0 == Family) then
		strName = "Thi猽 L鈓";

	elseif(1 == Family) then
		strName = "Minh Gi醥";

	elseif(2 == Family) then
		strName = "C醝 Bang";

	elseif(3 == Family) then
		strName = "V� 衋ng";

	elseif(4 == Family) then
		strName = "Nga My";

	elseif(5 == Family) then
		strName = "Tinh T鷆";

	elseif(6 == Family) then
		strName = "Thi阯 Long";

	elseif(7 == Family) then
		strName = "Thi阯 S絥";

	elseif(8 == Family) then
		strName = "Ti陁 Dao";

	elseif(9 == Family) then
		strName = "Kh鬾g c�";
	end
	SelectRole_TargetInfo_Menpai_Text:SetText("#c00ff00M鬾 ph醝: #cffffff"..strName);
	
	-- 显示等级
	SelectRole_TargetInfo_Level_Text:SetText("#c00ff00衅ng c: #cffffff"..tostring(g_iLevel[index]));

	if(tonumber(g_iDelTime[index])>0)then
		if(g_iDelTime[index]>=11)then
			SelectRole_TargetInfo_Delete:SetText("#c00ff00"..(3-(14-g_iDelTime[index])).."ng鄖 sau c� th� x骯 nh鈔 v");
		else
			SelectRole_TargetInfo_Delete:SetText("#c00ff00 疸 c� th� x骯 nh鈔 v");
		end
		
		SelectRole_TargetInfo_Delete:Show();
	else
		SelectRole_TargetInfo_Delete:Hide();
	end
	-- 设为选择状态
	--g_BnSelCheck[index]:SetCheck(1);
	

end


function SelectRole_SelRole_MouseEnter(index)

	SelectRole_Info:SetText("L馻 ch鱪 nh鈔 v 疱ng nh");
end
	
function SelectRole_MouseLeave()

	SelectRole_Info:SetText("");
end

function SelectRole_Play_MouseEnter()

	SelectRole_Info:SetText("V鄌 tr� ch絠");
end

function SelectRole_Create_MouseEnter()

	SelectRole_Info:SetText("T誳 nh鈔 v");
end

function SelectRole_Delete_MouseEnter()

	SelectRole_Info:SetText("X骯 nh鈔 v");
end

function SelectRole_Last_MouseEnter()

	SelectRole_Info:SetText("Quay l読 giao di畁 疱ng k� t鄆 kho鋘");	--帐号  to  账号
end;


function SelectRole_Role_Modle_TurnRightBegin(index)

	if(1 == index) then
		
		SelectRole_Role1_Model:RotateBegin(0.3);
	
	elseif(2 == index) then
	
		SelectRole_Role2_Model:RotateBegin(0.3);
		
	elseif(3 == index) then
	
		SelectRole_Role3_Model:RotateBegin(0.3);
		
	end;
		
end;
		
		
function SelectRole_Role_Modle_TurnRightEnd(index)

	if(1 == index) then
		
		SelectRole_Role1_Model:RotateEnd();
	
	elseif(2 == index) then
	
		SelectRole_Role2_Model:RotateEnd();
		
	elseif(3 == index) then
	
		SelectRole_Role3_Model:RotateEnd();
	
	end;	
		
end;

function SelectRole_Role_Modle_TurnLeftBegin(index)

	if(1 == index) then
		
		SelectRole_Role1_Model:RotateBegin(-0.3);
	
	elseif(2 == index) then
	
		SelectRole_Role2_Model:RotateBegin(-0.3);
		
	elseif(3 == index) then
	
		SelectRole_Role3_Model:RotateBegin(-0.3);
		
	end;
	
end;


function SelectRole_Role_Modle_TurnLeftEnd(index)
		
	if(1 == index) then
		
		SelectRole_Role1_Model:RotateEnd();
	
	elseif(2 == index) then
	
		SelectRole_Role2_Model:RotateEnd();
		
	elseif(3 == index) then
	
		SelectRole_Role3_Model:RotateEnd();
	
	end;	
		
end;





function SelectRole_Role_Modle_TurnRight( start )
	--向右旋转开始
	if(start == 1) then		
        --GameProduceLogin:ModelRotBegin(0.3)
            GameProduceLogin:ModelRotBegin(1.0)   --每秒一圈
	--向右旋转结束
	else
        GameProduceLogin:ModelRotEnd( 0.0 )
	end
	
end

function SelectRole_Role_Modle_TurnLeft( start )
	if(start == 1) then
            --GameProduceLogin:ModelRotBegin(-0.3)
            GameProduceLogin:ModelRotBegin(-1.0)   --每秒-1圈
	else		
        GameProduceLogin:ModelRotEnd( 0.0 )
	end
	
end

function SelectRole_Modle_ZoomOut( start )
	if(start == 1) then
	    GameProduceLogin:ModelZoom( -1.0 )
	else
	    GameProduceLogin:ModelZoom( 0.0 )
	end
	
end

function SelectRole_Modle_ZoomIn( start )
    if(start == 1) then
         GameProduceLogin:ModelZoom( 1.0 )
	else
	     GameProduceLogin:ModelZoom( 0.0 )
	end
	
end
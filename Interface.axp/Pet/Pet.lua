local WuXingTbl = {
			{level =1,	per = "1.0%" ,	maxlevel=1,	color = "#c00D000"},
			{level =2,	per = "1.5%" ,	maxlevel=1,	color = "#c00D000"},
			{level =3,	per = "2.1%" ,	maxlevel=2,	color = "#c00D000"},
			{level =4,	per = "3.0%" ,	maxlevel=2,	color = "#c00D000"},
			{level =5,	per = "8.0%" ,	maxlevel=3,	color = "#c43DBFF"},
			{level =6,	per = "11.0%" ,	maxlevel=3,	color = "#c43DBFF"},
			{level =7,	per = "14.5%" ,	maxlevel=4,	color = "#c43DBFF"},
			{level =8,	per = "23.5%" ,	maxlevel=4,	color = "#cFF8001"},
			{level =9,	per = "30.0%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =10,	per = "39.3%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =11,	per = "42.3%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =12,	per = "46.0%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =13,	per = "50.2%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =14,	per = "54.7%" ,	maxlevel=5,	color = "#cFF8001"},
			{level =15,	per = "59.5%" , maxlevel=5,	color = "#cFF8001"},
}
local ShowColor = "#H";
local PETSKILL_BUTTONS_NUM = 12;
local PETSKILL_BUTTONS = {};
local PETATTR = {};
local PET_POTREMAIN = 0;
local PET_ATTR_COUNT = 5;
local PET_MAX_NUMBER = 6+4;
local PETNUM = 0;
local PET_REST = 1;
local PET_FIGHT= 0;
local PET_CURRENT_SELECT = 0;
local PET_AITYPE = {};
local Changed_Name_Flag = 0;
--			// 创建珍兽(即放出) 0
--			// 收回珍兽					1
--			// 销毁珍兽(即放生)	2
--			// 捕捉珍兽					3
--			可以在被放出后，通过消息，改变该珍兽在listbox中的名字的颜色。
local PET_TAB_TEXT = {};
local PET_ORIGINAL_NAME = "";

------------------------------------------------------
--珍兽装备按钮数据定义 zchw
local g_Pet_Head; 		--头
local g_Pet_Claw;			--爪
local g_Pet_Body; 		--躯干
local g_Pet_Neck;			--项圈
local g_Pet_Charm;		--护符

------------------------------------------------------
-- 提供长按左键进行连加的功能	-- HenryFour@2010-04-16
local g_AutoClick_BtnFlag = -1			-- 记录当前鼠标左键是在哪个按钮按下
local g_AutoClickTimer_Step = 50		-- 多少时间(毫秒)模拟一次 Click 操作
local g_AutoClick_FunList = {}			-- 将公用一个 Timer 的回调功能函数放到一个数组
local g_AutoClick_Going = -1			-- 标志是否开始自动点击操作(第一次LButton后经过X个Timer才算开始, 也就是说是 g_AutoClickTimer_Step * X 的时候开始进行自动加, 这样为了防止本来要点击一下的结果点了好多下)

function Pet_PreLoad()
	this:RegisterEvent("TOGLE_PET_PAGE");
	this:RegisterEvent("UPDATE_PET_PAGE");
	this:RegisterEvent("DELETE_PET");
	this:RegisterEvent("ACCELERATE_KEYSEND");
	this:RegisterEvent("RESET_ALLUI");
	this:RegisterEvent("UPDATE_PET_EXTRANUM");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("PET_EQUIP_ATTR_CHANGE")
end

function Pet_OnLoad()

	PETSKILL_BUTTONS[1] = Pet_Skill1;
	PETSKILL_BUTTONS[2] = Pet_Skill2;
	PETSKILL_BUTTONS[3] = Pet_Skill3;
	PETSKILL_BUTTONS[4] = Pet_Skill4;
	PETSKILL_BUTTONS[5] = Pet_Skill5;
	PETSKILL_BUTTONS[6] = Pet_Skill6;
	PETSKILL_BUTTONS[7] = Pet_Skill7;
	PETSKILL_BUTTONS[8] = Pet_Skill8;
	PETSKILL_BUTTONS[9] = Pet_Skill9;
	PETSKILL_BUTTONS[10] = Pet_Skill10;
	PETSKILL_BUTTONS[11] = Pet_Skill11;
	PETSKILL_BUTTONS[12] = Pet_Skill12;
	PET_AITYPE[0] = "Nh醫 gan";
	PET_AITYPE[1] = "C th";
	PET_AITYPE[2] = "Trung th馽";
	PET_AITYPE[3] = "Nhanh nh﹏";
	PET_AITYPE[4] = "D鹡g m鉵h";

	PET_TAB_TEXT = {
		[0] = "邪",
		"Nh鈔",
		"Th�",
		"K�",
		"Kh醕",
	};
	--------------------------
	--zchw
	g_Pet_Head = PetEquip_1;
	g_Pet_Claw = PetEquip_2;
	g_Pet_Body = PetEquip_3;
	g_Pet_Neck = PetEquip_4;
	g_Pet_Charm = PetEquip_5;
	--------------------------

	Pet_chenghao:SetText("Danh hi畊");

		-- 初始化自动加点功能相关变量
	g_AutoClick_FunList[1] = Pet_Str_Add_Clicked
	g_AutoClick_FunList[2] = Pet_Int_Add_Clicked
	g_AutoClick_FunList[3] = Pet_PF_Add_Clicked
	g_AutoClick_FunList[4] = Pet_Sta_Add_Clicked
	g_AutoClick_FunList[5] = Pet_Dex_Add_Clicked
	g_AutoClick_FunList[6] = Pet_Str_Sub_Clicked
	g_AutoClick_FunList[7] = Pet_Int_Sub_Clicked
	g_AutoClick_FunList[8] = Pet_PF_Sub_Clicked
	g_AutoClick_FunList[9] = Pet_Sta_Sub_Clicked
	g_AutoClick_FunList[10] = Pet_Dex_Sub_Clicked

	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = -1
end

function Pet_OnEvent(event)
	-- 显示tooltips zchw
	Pet_SetStateTooltip();

	if ( event == "TOGLE_PET_PAGE" ) then
		local arg0_cache = nil;
		if arg0 ~= nil and tonumber(arg0)~=nil and tonumber(arg0) < PET_MAX_NUMBER and tonumber(arg0) >= 0 then
			arg0_cache = tonumber(arg0)
		end

		if( this:IsVisible() ) then
			Pet_Close();
			return
		else
			Pet_Open();
		end
		for i=1,PET_ATTR_COUNT do
			PETATTR[i] = 0;
		end

		if arg0_cache ~= nil then
			PET_CURRENT_SELECT = arg0_cache
		end

		Pet_OnShown();
		return;
	elseif ( event == "UPDATE_PET_PAGE") then
		if(this:IsVisible())then
			Pet_Update();
			--Pet_FakeObject:Hide();
			--Pet_FakeObject:Show();
		else
			Pet_Update_NotVisible();
		end
		return;
	elseif( event == "ACCELERATE_KEYSEND" ) then
		Pet_HandleAccKey(arg0);
	elseif ( event == "DELETE_PET" ) then
		if(this:IsVisible())then
			for i=1,PET_ATTR_COUNT do
				PETATTR[i] = 0;
			end
			Pet_Update();
		else
			Pet_Update_NotVisible();
		end
	elseif(event == "RESET_ALLUI")then
		PET_CURRENT_SELECT = 0;
		Pet:SetSelectPetIdx(0);
	elseif(event == "UPDATE_PET_EXTRANUM" or event == "UNIT_LEVEL")then
		local nPetCount = Pet:GetPet_Count()
		local nMaxPetCount = GetMyCurMaxPetCount()
		Pet_List_Text:SetText("B鋘g tr鈔 th� "..nPetCount.."/"..nMaxPetCount)

	-- Tooltips 更新 zchw
	elseif(event == "PET_EQUIP_ATTR_CHANGE") then
		Pet_SetStateTooltip();
	end

end

function Pet_HandleAccKey(op)
	if(op == "acc_pet") then
		if(this:IsVisible()) then
			Pet_Close();
			return;
		end

		--模拟收到了一个打开珍兽界面的事件。
		arg0 = "-1";
		Pet_OnEvent("TOGLE_PET_PAGE");
	end
end

function Pet_OnShown()
	local selfUnionPos = Variable:GetVariable("SelfUnionPos");
	if(selfUnionPos ~= nil) then
		Pet_Frame:SetProperty("UnifiedPosition", selfUnionPos);
	end

	Pet_SelfEquip : SetCheck(0);
	Pet_SelfData : SetCheck(0);
	Pet_Pet : SetCheck(1);
	Pet_Ride : SetCheck(0);
	--Pet_Xiulian : SetCheck(0);
	Pet_OtherInfo : SetCheck(0);

	Pet_Accept:Disable();
	Pet_Cancel:Disable();
	Pet_Amend:Disable();
	Pet_Free:Disable();
	Pet_LockPet:Disable();
	Pet_Domesticate:Disable();
	Pet_Feed:Disable();
	Pet_Rest:Disable();
	Pet_Campaign:Disable();
	Pet_Str_Addition:Disable();
	Pet_Int_Addition:Disable();
	Pet_Dex_Addition:Disable();
	Pet_PF_Addition:Disable();
	Pet_Sta_Addition:Disable();
	Pet_Str_Subtraction:Disable();
	Pet_Int_Subtraction:Disable();
	Pet_Dex_Subtraction:Disable();
	Pet_PF_Subtraction:Disable();
	Pet_Sta_Subtraction:Disable();
	Pet_Page_Clear();


	Pet_Update();


end

function Pet_Page_Clear()
	Pet_FakeObject:RotateEnd();
	Pet_FakeObject:RotateEnd();
	Pet_Accept:Disable();
	Pet_Cancel:Disable();
	Pet_Amend:Disable();
	Pet_Rest:Disable();
	Pet_Free:Disable();
	Pet_LockPet:Disable();
	Pet_Domesticate:Disable();
	Pet_Feed:Disable();
	Pet_Campaign:Disable();
	Pet_Str_Addition:Disable();
	Pet_Int_Addition:Disable();
	Pet_Dex_Addition:Disable();
	Pet_PF_Addition:Disable();
	Pet_Sta_Addition:Disable();
	Pet_Str_Subtraction:Disable();
	Pet_Int_Subtraction:Disable();
	Pet_Dex_Subtraction:Disable();
	Pet_PF_Subtraction:Disable();
	Pet_Sta_Subtraction:Disable();

	Pet_PetName : SetText( "" );
	Pet_PetName : Disable();
	Pet_Type : SetText("");

	Pet_PageHeader : SetText( "#gFF0FA0Tr鈔 th�" );
	Pet_ConsortID : SetText( "" );
	Pet_PetID : SetText( "" );
	Pet_Sex : SetText("");
	Pet_Life : SetText( "" );
	Pet_Happy : SetText("");
--	Pet_LoyalgGade : SetText( "" );
	Pet_Level : SetText( "" );
--	Pet_Type : SetText( "" );
	Pet_StrAptitude : SetText( "" );
	Pet_PhysicalStrengthAptitude : SetText( "" );
	Pet_DexterityAptitude : SetText( "" );
	Pet_NimbusAptitude : SetText( "" );
	Pet_StabilityAptitude : SetText( "" );
	Pet_Exp : SetText( "" );
	Pet_Blood : SetText( "" );
--	Pet_MP : SetText( "" .. " / " .. "" );
	Pet_Str : SetText( "" );
--	Pet_Str : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_Nimbus : SetText( "" );
--	Pet_Nimbus : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_Dexterity : SetText( "" );
--	Pet_Dexterity : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_PhysicalStrength : SetText( "" );
--	Pet_PhysicalStrength : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_Stability : SetText( "" );
--	Pet_Stability : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_GenGu : SetText( "" );
	Pet_Potential : SetText( "" );
--	Pet_Potential : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_PhysicsAttack : SetText( "" );
	Pet_MagicAttack : SetText( "" );
	Pet_PhysicsRecovery : SetText( "" );
	Pet_MagicRecovery : SetText( "" );
	Pet_Miss : SetText( "" );
	Pet_WuXing : SetText( "" );
	Pet_ShootProbability : SetText( "" );
	Pet_CriticalAttack:SetText("");
	Pet_CriticalDefence:SetText("")
	Pet_Growth : SetText("")
	Pet_Lingxing : SetText("")
	Pet_Lingxing_Info:SetText("")
	-------------------------------
	--zchw 44493
	Pet_Growth1 : SetText("")
	Pet_GenGu	: SetToolTip("")
	Pet_WuXing : SetToolTip("")
	Pet_Growth : SetToolTip("")
	Pet_Type : SetToolTip("")
	-------------------------------
	Pet_FakeObject : SetFakeObject( "" );
	PetAttack_Type : Hide();
	for i=1, PETSKILL_BUTTONS_NUM do
		PETSKILL_BUTTONS[i]:SetActionItem(-1);
	end
	PetFood_Type : Hide();
	Pet_lock : Hide();
	Pet_Model_Protect_Text:SetText( "" );
	PET_POTREMAIN = 0
	Pet_Refresh_ADDSUB_Button();
	Pet_NeedLevel:SetText( "" );
	Pet_Jian : Hide();

	--设置珍兽数量信息--add by xindefeng
	local nPetCount = Pet:GetPet_Count()
	local nMaxPetCount = GetMyCurMaxPetCount()
	Pet_List_Text:SetText("B鋘g tr鈔 th� "..nPetCount.."/"..nMaxPetCount)
end

function Pet_ListBox_Selected()
	PETNUM = Pet_List : GetFirstSelectItem();
	local nPetCount = Pet : GetPet_Count();

	if(PETNUM == PET_CURRENT_SELECT) then
		return;
	end

	if(PETNUM < 0 and nPetCount > 0) then
		PETNUM = PET_CURRENT_SELECT;
		return;
	end

	for i=1,PET_ATTR_COUNT do
		PETATTR[i] = 0;
	end

	Pet_Page_Clear();
	Changed_Name_Flag = 0;
	PET_CURRENT_SELECT = PETNUM;
	AxTrace(0,1,"here="..PET_CURRENT_SELECT)
	Pet_FakeObject : SetFakeObject( "" );
	Pet : SetModel(PETNUM);
	Pet_FakeObject : SetFakeObject( "My_Pet" );


	Pet_Show_Appoint(PETNUM);

	Pet:NotifySelChange(PETNUM);

	local	tcount = Pet:GetTitleNum(PET_CURRENT_SELECT);
	if(tcount>0)then
		Pet_chenghao:Enable()
	else
		Pet_chenghao:Disable()
	end

	Pet_SetStateTooltip();
	Pet_Refresh_Equip()
end

function Pet_ListBox_RClicked()
	local clkNum = Pet_List : GetClickItem();
	--AxTrace(0,0,"Pet_ListBox_RClicked "..tostring(clkNum));
	if(clkNum >= 0) then
		Pet:CheckRClick(clkNum);
	end
end

function Pet_Update_NotVisible()
	local nPetCount = Pet : GetPet_Count();
	if nPetCount < 1 then
		PET_CURRENT_SELECT = -1;
		Pet:SetSelectPetIdx(-1);
		return;
	end
	local bSelect = 0;
	local firSel = -1;
	for	i=1, PET_MAX_NUMBER do
		if Pet:IsPresent(i-1) then
			if(firSel == -1)then
				firSel = i-1;
			end
			if( i-1 == PET_CURRENT_SELECT) then
				bSelect = 1;
			end
		end
	end
	--有选中对象的，才进行选中操作。
	if bSelect == 1 then
		--do nothing
	else
		PET_CURRENT_SELECT = firSel;
		Pet:SetSelectPetIdx(firSel);
	end
end

function Pet_Update()
	Pet_chenghao:Disable()
	Pet_SelfEquip : SetCheck(0);
	Pet_SelfData : SetCheck(0);
	Pet_Pet : SetCheck(1);
	Pet_Ride : SetCheck(0);
	Pet_OtherInfo : SetCheck(0);
	local nPetCount = Pet : GetPet_Count();
	AxTrace(3,3,"nPetCount = "..nPetCount);
	local szPetName;

	Pet_Page_Clear();
	Pet_List : ClearListBox();
	if nPetCount < 1 then
		PET_CURRENT_SELECT = -1;
		Pet:SetSelectPetIdx(-1);
		--zchw
		OneKeyUnEquip:Disable();
		return;
	end

	local bSelect = 0;
	local firSel = -1;
	for	i=1, PET_MAX_NUMBER do
		if Pet:IsPresent(i-1) then
			if(firSel == -1)then
				firSel = i-1;
			end
			szPetName = Pet : GetPetList_Appoint(i-1);
			AxTrace(0,1,"Th� "..i.."Ch� g鱥"..szPetName);

			if(Pet : GetIsFighting(i-1)) then
				Pet_List : AddItem(szPetName, i-1,"FF0A9605");
			else
				Pet_List : AddItem(szPetName, i-1);
			end
			if( i-1 == PET_CURRENT_SELECT) then
				bSelect = 1;
			end
			--这里必须有这么2句，要不会出错。
			Pet_DisableAddButton();
			Pet_DisableSubButton();
		end
	end
	local tcount = 0;
	--有选中对象的，才进行选中操作。
	if bSelect == 1 then
		Pet_List : SetItemSelectByItemID(PET_CURRENT_SELECT);
		Pet_FakeObject : SetFakeObject( "" );
		Pet : SetModel(PET_CURRENT_SELECT);
		Pet_FakeObject : SetFakeObject( "My_Pet" );
		Pet_Show_Appoint(PET_CURRENT_SELECT);
		tcount = Pet:GetTitleNum(PET_CURRENT_SELECT);
		if(tcount>0)then
			Pet_chenghao:Enable()
		end
	else
		PET_CURRENT_SELECT = firSel;
		if(firSel == -1)then
			Pet:SetSelectPetIdx(-1);
			--zchw
			OneKeyUnEquip:Disable();
			return;
		end
		Pet_List : SetItemSelectByItemID(PET_CURRENT_SELECT);
		Pet_FakeObject : SetFakeObject( "" );
		Pet : SetModel(PET_CURRENT_SELECT);
		Pet_FakeObject : SetFakeObject( "My_Pet" );
		Pet_Show_Appoint(PET_CURRENT_SELECT);
		tcount = Pet:GetTitleNum(PET_CURRENT_SELECT);
		if(tcount>0)then
			Pet_chenghao:Enable()
		end
	end

	if PET_CURRENT_SELECT > PET_MAX_NUMBER then
		PET_CURRENT_SELECT = PET_MAX_NUMBER;
	end

	Pet_PetName:SetProperty("DefaultEditBox", "False");
	local strNeedLevel;
	local strNeedLevelColor;
	local nTakeLevel = Pet:GetTakeLevel(PET_CURRENT_SELECT );

	if( nTakeLevel > Player:GetData( "LEVEL" ) )then
		strNeedLevelColor="#cFF0000";
	else
		strNeedLevelColor="#c00FF00";
	end
	strNeedLevel = strNeedLevelColor..tostring( nTakeLevel ).." C #Wc� th� mang theo";
	Pet_NeedLevel:SetText( strNeedLevel );

end

--zchw
function PetEquip_Equip_Click(num, type)
	if num == 1 then
		if type == 1 then
			g_Pet_Head : DoAction();
		elseif type == 0 then
			g_Pet_Head : DoSubAction();
		end
	elseif num == 2 then
		if type == 1 then
			g_Pet_Claw : DoAction();
		elseif type == 0 then
			g_Pet_Claw : DoSubAction();
		end
	elseif num == 3 then
		if type == 1 then
			g_Pet_Body : DoAction();
		elseif type == 0 then
			g_Pet_Body : DoSubAction();
		end
	elseif num == 4 then
		if type == 1 then
			g_Pet_Neck : DoAction();
		elseif type == 0 then
			g_Pet_Neck : DoSubAction();
		end
	elseif num == 5 then
		if type == 1 then
			g_Pet_Charm : DoAction();
		elseif type == 0 then
			g_Pet_Charm : DoSubAction();
		end
	end
end

--zchw
function Pet_Refresh_Equip()
	--  清空按钮显示图标
	g_Pet_Head : SetActionItem(-1);
	g_Pet_Claw : SetActionItem(-1);
	g_Pet_Body : SetActionItem(-1);
	g_Pet_Neck : SetActionItem(-1);
	g_Pet_Charm : SetActionItem(-1);

	local ActionClaw 		= EnumAction(5*PET_CURRENT_SELECT, "my_pet_equip");
	local ActionHead		= EnumAction(5*PET_CURRENT_SELECT + 1, "my_pet_equip");
	local ActionBody  	= EnumAction(5*PET_CURRENT_SELECT + 2, "my_pet_equip");
	local ActionNeck   	= EnumAction(5*PET_CURRENT_SELECT + 3, "my_pet_equip");
	local ActionCharm   = EnumAction(5*PET_CURRENT_SELECT + 4, "my_pet_equip");

	g_Pet_Head : SetActionItem(ActionHead : GetID());
	g_Pet_Claw : SetActionItem(ActionClaw : GetID());
	g_Pet_Body : SetActionItem(ActionBody : GetID());
	g_Pet_Neck : SetActionItem(ActionNeck : GetID());
	g_Pet_Charm : SetActionItem(ActionCharm : GetID());

end

--zchw
function Pet_SetStateTooltip()

	-- 得到状态属性
	local iIceAttack  		= 0;--Pet:GetData( "ATTACKCOLD" );
	local iFireAttack 		= 0;--Pet:GetData( "ATTACKFIRE" );
	local iThunderAttack	= 0;--Pet:GetData( "ATTACKLIGHT" );
	local iPoisonAttack		= 0;--Pet:GetData( "ATTACKPOISON" );

	local iIceDefine  		= 0;--Pet:GetData( "DEFENCECOLD" );
	local iFireDefine 		= 0;--Pet:GetData( "DEFENCEFIRE" );
	local iThunderDefine	= 0;--Pet:GetData( "DEFENCELIGHT" );
	local iPoisonDefine		= 0;--Pet:GetData( "DEFENCEPOISON" );

	local iIceResistOther	= 0;--Pet:GetData( "RESISTOTHERCOLD" );
	local iFireResistOther= 0;--Pet:GetData( "RESISTOTHERFIRE" );
	local iThunderResistOther	= 0;--Pet:GetData( "RESISTOTHERLIGHT" );
	local iPoisonResistOther= 0;--Pet:GetData( "RESISTOTHERPOISON" );

	Pet_IceFastness:SetToolTip("B錸g c鬾g:"..tostring(iIceAttack).."#rKh醤g B錸g:"..tostring(iIceDefine).."#rGi鋗 kh醤g B錸g:"..tostring(iIceResistOther) );
	Pet_FireFastness:SetToolTip("H鯽 c鬾g:"..tostring(iFireAttack).."#rKh醤g H鯽:"..tostring(iFireDefine).."#rGi鋗 kh醤g H鯽:"..tostring(iFireResistOther) );
	Pet_ThunderFastness:SetToolTip("Huy玭 c鬾g:"..tostring(iThunderAttack).."#rKh醤g Huy玭:"..tostring(iThunderDefine).."#rGi鋗 kh醤g Huy玭:"..tostring(iThunderResistOther) );
	Pet_PoisonFastness:SetToolTip("械c c鬾g:"..tostring(iPoisonAttack).."#rKh醤g 械c:"..tostring(iPoisonDefine).."#rGi鋗 kh醤g 械c:"..tostring(iPoisonResistOther) );

end

function Pet_Show_Appoint(nIndex)

	local i;

	if(not (Pet:IsPresent(nIndex)) ) then
		return;
	end
	Pet:SetSelectPetIdx(nIndex);
	Pet_Accept:Disable();
	Pet_Cancel:Disable();
	Pet_Amend:Enable();
	Pet_Rest:Enable();
	Pet_Free:Enable();
	Pet_LockPet:Enable();
	Pet_Domesticate:Enable();
	Pet_Feed:Enable();
	Pet_Campaign:Enable();

	Pet_Str_Addition:Disable();
	Pet_Int_Addition:Disable();
	Pet_Dex_Addition:Disable();
	Pet_PF_Addition:Disable();
	Pet_Sta_Addition:Disable();
	Pet_Str_Subtraction:Disable();
	Pet_Int_Subtraction:Disable();
	Pet_Dex_Subtraction:Disable();
	Pet_PF_Subtraction:Disable();
	Pet_Sta_Subtraction:Disable();
	for i=1, PETSKILL_BUTTONS_NUM do
		PETSKILL_BUTTONS[i]:SetActionItem(-1);
	end

 	local strName = Pet:GetAIType(nIndex);

	local strAI;
	if(strName>4 or strName <0) then
		strAI = "Sai s髏";
	else
		strAI =	PET_AITYPE[strName];
	end

	local strName2 = ""
 	strName,strName2 = Pet:GetName(nIndex);
	local nEra, strTypeName = Pet:GetPetTypeName(nIndex);
 	if( 1 == nEra ) then
 	    strName2 = "卸i th� 2 "..strTypeName
 	end


 	Pet_PageHeader : SetText("#gFF0FA0"..strName2);
 	Pet_Type :SetText("#gFF8E92"..strAI);
 	Changed_Name = Pet_PetName : GetText();

 	if(PlayerPackage:IsPetLock(nIndex) == 1) then
	 	Pet_lock : Show();

	 	local nUnlockElapsedTime = PlayerPackage:GetPUnlockElapsedTime_Pet(nIndex);
	 	if( nUnlockElapsedTime ==0) then
	 		Pet_lock : SetProperty("Image","set:UIIcons image:Icon_Lock");
	 		Pet_lock : SetToolTip ("秀 kh骯");
	 	else
	 		local strLeftTime = g_GetUnlockingStr(nUnlockElapsedTime);
	 		Pet_lock : SetProperty("Image","set:CommonFrame6 image:NewLock");
	 		Pet_lock : SetToolTip (strLeftTime);
	 	end

	else
	 	Pet_lock : Hide();
 end

  --if(PlayerPackage:IsGoodsProtect_Pet(nIndex) == 1) then
	 	--Pet_Model_Protect_Text : Show();
	 	--Pet_Model_Protect_Text : SetText( "#{GDWPBH_090507_4}" );
	--else
	 	Pet_Model_Protect_Text : Hide();
  --end

	AxTrace(0,1,"Changed_Name="..Changed_Name)
--	if Changed_Name_Flag == 1 then
--		Pet_PetName : SetText( strName );
	if Changed_Name ~= strName and Changed_Name ~= "" then
		Pet_PetName : Enable();
--		PET_ORIGINAL_NAME = strName;
	else
		Pet_PetName : Enable();
		Pet_PetName : SetText( strName );
		Pet_PetName : SetProperty("ClearOffset" ,"True" )
	end

--	Pet_PageHeader : SetText( strAI .. strName2 );

	strName,strName2,sex = Pet : GetID(nIndex);	
	Pet_PetID : SetText( "Tr鈔 th� ID: "..strName2 );
	AxTrace(0,0,"GetID="..strName .. strName2);

	strName = Pet : GetConsort(nIndex);
	if(strName == "00000000") then
		strName = "";
	end;
	Pet_ConsortID : SetText( "Phu ph� ID: "..strName );

	if(sex == 1) then
		strName = "旭c";
	else
		strName = "C醝";
	end
	local nGeneration  = 0;--Pet : GetGeneration(nIndex)
	if nGeneration ~= nil and nGeneration >= 100 then
		strName = "#{RXZS_XML_35}";
	end

	Pet_Sex : SetText( strName );
	local strNeedLevel;
	local strNeedLevelColor;
	local nTakeLevel = Pet:GetTakeLevel(nIndex);

	if( nTakeLevel > Player:GetData( "LEVEL" ) )then
		strNeedLevelColor="#cFF0000";
	else
		strNeedLevelColor="#c00FF00";
	end
	strNeedLevel = strNeedLevelColor..tostring( nTakeLevel ).." C #Wc� th� mang theo";
	Pet_NeedLevel:SetText( strNeedLevel );
	strName = Pet : GetNaturalLife(nIndex);
--	strName2 = Pet:	GetMaxLife(nIndex);
	Pet_Life : SetText( "Th� m畁h: "..strName );

--	strName = Pet : GetLoyalgGade(nIndex);
--	Pet_LoyalgGade : SetText( strName );

--	strName = Pet : GetBasic(nIndex);
--	Pet_GenGu : SetText( "根骨:"..strName );

	strName = Pet : GetLevel(nIndex);
	Pet_Level : SetText( "C: "..strName );

--	strName = Pet : GetType(nIndex);
--	Pet_Type : SetText( "第".. tostring(strName).."代" );

	strName = Pet : GetHappy(nIndex);
	Pet_Happy : SetText( "Hoan h�: "..strName );

	strName = "0";--Pet : GetLixing(nIndex);
	Pet_Lingxing : SetText("#{RXZS_XML_28}"..strName)

	strName = 10;--Pet : GetPercent_Lx(nIndex)
	if tonumber(strName) ~= nil and tonumber(strName) > 0 then
		local rateStr = string.format("%0.1f" , strName / 10.0)
		Pet_Lingxing_Info:SetText("#cFF00FF(+"..rateStr.."%)")
	end


	strName = Pet : GetSavvy(nIndex);
	Pet_WuXing : SetText( "Ng� t韓h: "..strName );

	local WuXingVal = tonumber(strName);
	strName = Pet : GetStrAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	Pet_StrAptitude : SetText( strName );

	strName = Pet : GetPFAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	Pet_PhysicalStrengthAptitude : SetText( strName );

	strName = Pet : GetDexAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	Pet_DexterityAptitude : SetText( strName );

	strName = Pet : GetIntAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	Pet_NimbusAptitude : SetText( strName );

	strName = Pet : GetStaAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	Pet_StabilityAptitude : SetText( strName );

	strName,strName2 = Pet : GetExp(nIndex);
	Pet_Exp : SetText( "Kinh nghi甿: "..strName .."/"..strName2);
--yy说，不空格
	strName = Pet : GetHP(nIndex);
	strName2 = Pet:	GetMaxHP(nIndex);
	Pet_Blood : SetText( "Huy猼: "..strName .."/".. strName2);
--	strName = Pet : GetMP(nIndex);
--	strName2 = Pet:	GetMaxMP(nIndex);
--	Pet_MP : SetText( strName .." / ".. strName2);

	strName = Pet : GetStr(nIndex);
	Pet_Str : SetText( tonumber(strName) + PETATTR[1] );
--	Pet_Str : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = Pet : GetInt(nIndex);
	Pet_Nimbus : SetText( tonumber(strName) + PETATTR[2] );
--	Pet_Nimbus : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = Pet : GetDex(nIndex);
	Pet_Dexterity : SetText( tonumber(strName) + PETATTR[3] );
--	Pet_Dexterity : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = Pet : GetPF(nIndex);
	Pet_PhysicalStrength : SetText( tonumber(strName) + PETATTR[4] );
--	Pet_PhysicalStrength : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = Pet : GetSta(nIndex);
	Pet_Stability : SetText( tonumber(strName) + PETATTR[5] );
--	Pet_Stability : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = Pet : GetBasic(nIndex);
	Pet_GenGu : SetText( "C錸 c痶: "..tonumber(strName) );

	Pet_CriticalAttack : SetText( Pet:GetCriticalAttack(nIndex)  );
	Pet_CriticalDefence : SetText(Pet:GetCriticalDefence(nIndex) )

	strName = Pet : GetPotential(nIndex);
	strName2 = tonumber(strName);
	local Sum_Attr = 0;
	for i=1,PET_ATTR_COUNT do
		Sum_Attr = Sum_Attr + PETATTR[i];
	end
	strName2 = strName2 - Sum_Attr;
	--出现这种情况是
	if(strName2 < 0) then
	 strName2 = 0
	 for i=1,PET_ATTR_COUNT do
			PETATTR[i] = 0;
	 end
	end
	PET_POTREMAIN = strName2
	AxTrace(2,1,"Sum_Attr="..Sum_Attr)
	AxTrace(2,1,"strName2="..strName2)
	AxTrace(2,1,"PET_POTREMAIN="..PET_POTREMAIN)
	Pet_Potential : SetText( strName2 );
--	Pet_Potential : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	Pet_Refresh_ADDSUB_Button();

	strName = Pet : GetPhysicsAttack(nIndex);
	Pet_PhysicsAttack : SetText( strName );

	strName = Pet : GetMagicAttack(nIndex);
	Pet_MagicAttack : SetText( strName );

	strName = Pet : GetPhysicsRecovery(nIndex);
	Pet_PhysicsRecovery : SetText( strName );

	strName = Pet : GetMagicRecovery (nIndex);
	Pet_MagicRecovery : SetText( strName );

	strName = Pet : GetGrowRate(nIndex);
	-----------------------------------------
	-- zchw 44493
	Pet_Growth1 : SetText("#{ZS_CZL}");
	Pet_GenGu : SetToolTip("#{INTERFACE_XML_287}");
	Pet_WuXing : SetToolTip("#{INTERFACE_XML_733}");
	Pet_Growth : SetToolTip("#{INTERFACE_XML_986}")
	Pet_Type : SetToolTip("#{INTERFACE_XML_857}")
	-----------------------------------------
	Pet_Growth : SetText("#GCh遖 bi猼")
	local nGrowLevel = Pet : GetPetGrowLevel(nIndex,tonumber(strName));
	local strTbl = {"S� c","Xu s","Ki畉 xu","Tr醕 vi畉","To鄋 m�"};

	if(nGrowLevel >= 0) then
		nGrowLevel = nGrowLevel + 1;	--c里是从0开始的枚举
		local nGrowRate = Pet : GetGrowRate(nIndex);
		if(strTbl[nGrowLevel]) then
			Pet_Growth : SetText("#G"..strTbl[nGrowLevel]..nGrowRate)
		end
	end

	--闪避率
	strName = Pet : GetMiss(nIndex);
	Pet_Miss : SetText( strName );

	--命中率
	strName = Pet : GetShootProbability(nIndex);
	Pet_ShootProbability : SetText( strName );

	strName,strIcon = Pet : GetAttackTrait(nIndex);
	AxTrace(0,0,"strIcon="..strIcon)
	if strIcon ~= "" then
		PetAttack_Type : SetProperty( "Image", "set:Button6 image:"..strIcon )
		PetAttack_Type : SetToolTip(strName)
		PetAttack_Type : Show();
	end

	local SumPetSkill = GetActionNum("petskill");
	local k=1;
	local i=1;
	AxTrace(0,1,"SumPetSkill="..SumPetSkill);

	while i <= PETSKILL_BUTTONS_NUM do
		local theSkillAction = Pet:EnumPetSkill( nIndex, i-1, "petskill");
		i = i + 1;
		if theSkillAction:GetID() ~= 0 then
			AxTrace(0,1,"pet="..nIndex.." skill position="..i.." id="..theSkillAction:GetID());
			PETSKILL_BUTTONS[k]:SetActionItem(theSkillAction:GetID());
			k = k+1;

--		if( (theSkillAction : GetPetSkillOwner() == nIndex) and (k <= PETSKILL_BUTTONS_NUM ) ) then
--			PETSKILL_BUTTONS[k]:SetActionItem(theSkillAction:GetID());
--			AxTrace(0,1,"pet="..nIndex.." skill position="..k.." id="..theSkillAction:GetID())
--			k = k + 1;
--		else
--			PETSKILL_BUTTONS[i]:SetActionItem(-1);
		end

--	PETSKILL_DESC[i]:SetText(theSkillAction:GetName());
	end

	-- 珍兽装备 zchw
	----------------------------------------
	Pet_Refresh_Equip();
	--if Pet:IsPetHaveEquip(nIndex) == 1 then
	--	OneKeyUnEquip:Enable();
	--else
		OneKeyUnEquip:Disable();
	--end
	---------------------------------------

	if(Pet : GetIsFighting(nIndex)) then
		Pet_Campaign : Hide();
		Pet_Rest : Show();
		AxTrace(0,0,"V竧 c� th� ngh� ng絠");
	else
		Pet_Rest : Hide();
		Pet_Campaign : Show();
		AxTrace(0,0,"V竧 c� th� chi猲 黏u");
	end

	local food = Pet : GetFoodType(nIndex);
	strName = "";
	AxTrace(0,1,"food="..food);
	if(food >= 1000) then
		strName = strName .. "Th竧";
		food = food - 1000;
		if food > 0 then
			strName = strName .. ",";
		end
	end
	if(food >= 100) then
		strName = strName .. "C�";
		food = food - 100;
		if food > 0 then
			strName = strName .. ",";
		end
	end
	if(food >= 10) then
		strName = strName .. "Tr鵱g";
		food = food - 10;
		if food > 0 then
			strName = strName .. ",";
		end
	end

	if(food >= 1) then
		strName = strName .. "C痗";
	end
	PetFood_Type : Show();
	PetFood_Type : SetToolTip( strName );

	Pet_Jian : Show();
end

--***************************************************
-- 清空鼠标长按标记
--***************************************************
function Pet_AutoClick_Clear(id)
	id = tonumber(id)
	if (id == g_AutoClick_BtnFlag) then
		g_AutoClick_BtnFlag = -1
	end
end

--***************************************************
-- 定时器回调函数
--    实现慢启动, 以后可以考虑加速(必要性不大)
--***************************************************
function Pet_AutoClick_Timer()
	if (g_AutoClick_BtnFlag ~= -1) then
		-- 第一次LButton后经过X个Timer才算开始, 也就是说是 g_AutoClickTimer_Step * X 的时候开始进行自动加, 这样为了防止本来要点击一下的结果点了好多下
		if (g_AutoClick_Going < 4) then
			g_AutoClick_Going = g_AutoClick_Going + 1
		else
			--目前先设置 6 Step 的等待时间, 下面注释的代码可以后来用于实现慢启动, 逐渐加速效果.
			--if (g_AutoClick_Going == 2 or g_AutoClick_Going == 5) then
				--g_AutoClick_FunList[g_AutoClick_BtnFlag]()
			--end
			g_AutoClick_FunList[g_AutoClick_BtnFlag]()
		end
	end
end

--***************************************************
-- 鼠标左键松开操作
--    注意这里其实是代替 Click, 所以需要执行一次 Click 操作
--***************************************************
function Pet_AutoClick_LButtonUp(id)
	id = tonumber(id)
	Pet_AutoClick_Clear(id)
	g_AutoClick_FunList[id]()
end

--***************************************************
-- 设置定时器
--    设置标记说明鼠标已经按下
--***************************************************
function Pet_AutoClick_SetTimer(id)
	id = tonumber(id)
	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = id
end

function Pet_Str_Add_Clicked()
	if( PET_POTREMAIN >0 ) then
		PETATTR[1] = PETATTR[1] +1;
		PET_POTREMAIN = PET_POTREMAIN - 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Str : SetText( Pet_Str : GetText() + 1 );
--		Pet_Str : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
	Pet_Str_Subtraction:Enable()
	end
	if( PET_POTREMAIN <=0 ) then
--		Pet_Str_Addition:Disable();
		Pet_DisableAddButton();
	end
end

function Pet_Int_Add_Clicked()
	if( PET_POTREMAIN >0 ) then
		PETATTR[2] = PETATTR[2] +1;
		PET_POTREMAIN = PET_POTREMAIN - 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Nimbus : SetText( Pet_Nimbus : GetText() + 1 );
--		Pet_Nimbus : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Int_Subtraction:Enable();
	end
	if( PET_POTREMAIN <=0 ) then
--		Pet_Int_Addition:Disable();
		Pet_DisableAddButton();
	end
end

function Pet_Dex_Add_Clicked()
	if( PET_POTREMAIN >0 ) then
		PETATTR[3] = PETATTR[3] +1;
		PET_POTREMAIN = PET_POTREMAIN - 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Dexterity : SetText( Pet_Dexterity : GetText() + 1 );
--		Pet_Dexterity : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Dex_Subtraction:Enable();
	end
	if( PET_POTREMAIN <=0 ) then
--		Pet_Dex_Addition:Disable();
		Pet_DisableAddButton();
	end
end

function Pet_PF_Add_Clicked()
	if( PET_POTREMAIN >0 ) then
		PETATTR[4] = PETATTR[4] +1;
		PET_POTREMAIN = PET_POTREMAIN - 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_PhysicalStrength : SetText( Pet_PhysicalStrength : GetText() + 1 );
--		Pet_PhysicalStrength : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_PF_Subtraction:Enable();
	end
	if( PET_POTREMAIN <=0 ) then
--		Pet_PF_Addition:Disable();
		Pet_DisableAddButton();
	end
end

function Pet_Sta_Add_Clicked()
	if( PET_POTREMAIN >0 ) then
		PETATTR[5] = PETATTR[5] +1;
		PET_POTREMAIN = PET_POTREMAIN - 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Stability : SetText( Pet_Stability : GetText() + 1 );
--		Pet_Stability : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Sta_Subtraction:Enable();
	end
	if( PET_POTREMAIN <=0 ) then
--		Pet_Sta_Addition:Disable();
		Pet_DisableAddButton();
	end
end

function Pet_Str_Sub_Clicked()
	if( PETATTR[1] >0 ) then
		PETATTR[1] = PETATTR[1] -1;
		PET_POTREMAIN = PET_POTREMAIN + 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Str : SetText( Pet_Str : GetText() - 1 );
--		Pet_Str : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
--		Pet_Str_Addition:Enable();
		Pet_EnableAddButton();
	end
	if( PETATTR[1] <= 0 ) then
		Pet_Str_Subtraction:Disable();
	end
end

function Pet_Int_Sub_Clicked()
	if( PETATTR[2] >0 ) then
		PETATTR[2] = PETATTR[2] -1;
		PET_POTREMAIN = PET_POTREMAIN + 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Nimbus : SetText( Pet_Nimbus : GetText() - 1 );
--		Pet_Nimbus : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
--		Pet_Int_Addition:Enable();
		Pet_EnableAddButton();
	end
	if( PETATTR[2] <= 0 ) then
		Pet_Int_Subtraction:Disable();
	end
end

function Pet_Dex_Sub_Clicked()
	if( PETATTR[3] >0 ) then
		PETATTR[3] = PETATTR[3] -1;
		PET_POTREMAIN = PET_POTREMAIN + 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Dexterity : SetText( Pet_Dexterity : GetText() - 1 );
--		Pet_Dexterity : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
--		Pet_Dex_Addition:Enable();
		Pet_EnableAddButton();
	end
	if( PETATTR[3] <= 0 ) then
		Pet_Dex_Subtraction:Disable();
	end
end

function Pet_PF_Sub_Clicked()
	if( PETATTR[4] >0 ) then
		PETATTR[4] = PETATTR[4] -1;
		PET_POTREMAIN = PET_POTREMAIN + 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_PhysicalStrength : SetText( Pet_PhysicalStrength : GetText() - 1 );
--		Pet_PhysicalStrength : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
--		Pet_PF_Addition:Enable();
		Pet_EnableAddButton();
	end
	if( PETATTR[4] <= 0 ) then
		Pet_PF_Subtraction:Disable();
	end
end

function Pet_Sta_Sub_Clicked()
	if( PETATTR[5] >0 ) then
		PETATTR[5] = PETATTR[5] -1;
		PET_POTREMAIN = PET_POTREMAIN + 1;
		Pet_Potential : SetText( PET_POTREMAIN );
--		Pet_Potential : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
		Pet_Stability : SetText( Pet_Stability : GetText() - 1 );
--		Pet_Stability : SetProperty("TextColours","tl:FFFEE601 tr:FFFEE601 bl:FFFEE601 br:FFFEE601");
--		Pet_Sta_Addition:Enable();
		Pet_EnableAddButton();
	end
	if( PETATTR[5] <= 0 ) then
		Pet_Sta_Subtraction:Disable();
	end
end

function Pet_Accept_Clicked()
	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end
	--if(PlayerPackage:IsPetLock(PETNUM) == 1)    then
	--	PushDebugMessage("珍兽已加锁")
	--	for i=1,PET_ATTR_COUNT do
	--		PETATTR[i] = 0;
	--	end
	--	Pet_Show_Appoint(PETNUM);
	--	return;
	--end
	if(tonumber(DataPool:GetLeftProtectTime()) >0)    then
		PushDebugMessage("#{OR_PILFER_LOCK_FLAG}")
		for i=1,PET_ATTR_COUNT do
			PETATTR[i] = 0;
		end
		Pet_Show_Appoint(PETNUM);
		return;
	end
 	Pet : Add_Attribute(PETNUM ,PETATTR[1] ,PETATTR[2], PETATTR[3], PETATTR[4], PETATTR[5]);
	for i=1,PET_ATTR_COUNT do
		PETATTR[i] = 0;
	end
end

function Pet_Cancel_Clicked()
	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end

	for i=1,PET_ATTR_COUNT do
		PETATTR[i] = 0;
	end

	Pet_Show_Appoint(PETNUM);
end

function Pet_Relax_Clicked()
	Pet : Go_Relax(PETNUM);
end

function Pet_Fight_Clicked()
	-- 已经提交到指定界面容器的珍兽不能出战
	if (IsWindowShow("PetSavvy") and Pet:GetPetLocation(PETNUM) == 2)							-- 用成年珍兽提升珍兽悟性
		or (IsWindowShow("PetSavvyGGD")	and Pet:GetPetLocation(PETNUM) == 3)				-- 用根骨丹提升珍兽悟性
		or (IsWindowShow("MissionReply") and Pet:GetPetLocation(PETNUM) == 7) then	-- 任务提交物品或珍兽
		-- "珍兽处于提交状态，无法出战。"
		PushDebugMessage("#{ZSTJZT_090904}")
		return
	end

	Pet	:	Go_Fight(PETNUM);
end

function Pet_Free_Clicked()
	if(Pet : GetIsFighting(PETNUM)) then
		--此为BUG 3921中杨婷的原话，在策划案中并没有该需求。
		--但项目紧急，没时间确认，所以就以BUG系统为准。
		PushDebugMessage("Th� qu� 餫ng tham chi猲, kh鬾g th� ph髇g sinh.")
		return;
	end

	if(PlayerPackage:IsPetLock(PETNUM) == 1)    then
		PushDebugMessage("秀 th阭 kh骯 v緄 Tr鈔 Th�")
		return;
	end

	if Pet:GetPetLocation(PETNUM) ~= -1 then
		PushDebugMessage("Th� qu� 餫ng ti猲 h鄋h thao t醕 kh醕, kh鬾g th� ph髇g sinh.")
		return;
	end

	Pet	:	Free_Confirm(PETNUM);
end

function Pet_LockPet_Clicked()
	PlayerPackage:OpenLockFrame(2);
end

function Pet_Feed_Clicked()
	Pet:Feed(PETNUM);
end

function Pet_Dome_Clicked()
	Pet:Dome(PETNUM);
end

function Pet_AmendName_Clicked()
	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end
	local strName = Pet_PetName : GetText()
	Changed_Name_Flag = 0;
	AxTrace(0,1,"string.len(strName)="..string.len(strName));
	if(string.len(strName) < 2  or string.len(strName) > 12 ) then
		Pet_Update();
		return;
	end
	Pet : Change_Name(PETNUM,Pet_PetName : GetText());
end

function Pet_Skill_Button_Clicked(nIndex)
--将来主动技能和被动技能，可以在表里查到。
	if(nIndex < 3) then

	end

	PETSKILL_BUTTONS[nIndex] : DoAction();

	local SumPetSkill = GetActionNum("petskill");
	local k=1;
	for i=1, SumPetSkill do
		local theSkillAction = EnumAction( i-1, "petskill");
		if( (theSkillAction : GetPetSkillOwner() == nIndex) and (k <= PETSKILL_BUTTONS_NUM ) ) then
			PETSKILL_BUTTONS[k]:SetActionItem(theSkillAction:GetID());
			k = k + 1;
		end
	end
end

----------------------------------------------------------------------------------
--
-- 旋转珍兽模型（向左)
--
function Pet_Modle_TurnLeft(start)
	--向左旋转开始
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		Pet_FakeObject:RotateBegin(-0.3);
	--向左旋转结束
	else
		Pet_FakeObject:RotateEnd();
	end
end

----------------------------------------------------------------------------------
--
--旋转珍兽模型（向右)
--
function Pet_Modle_TurnRight(start)
	--向右旋转开始
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		Pet_FakeObject:RotateBegin(0.3);
	--向右旋转结束
	else
		Pet_FakeObject:RotateEnd();
	end
end

function SelfEquip_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);

	OpenEquip(1);
	Pet_Close();
	Pet_SelfEquip : SetCheck(0);
	Pet_SelfData : SetCheck(0);
	Pet_Pet : SetCheck(1);

end

function Pet_Skill_Clicked(nSkillIndex)

	AxTrace(0,1,"234PETNUM="..PETNUM);

	if(PETNUM < 0 or PETNUM > PET_MAX_NUMBER) then
		return;
	end

	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end

	if Pet : GetSkillPassive(PETNUM,nSkillIndex-1) == 0 then

		PushDebugMessage("M秈 疬a k� n錸g n鄖 v鄌 khung s� d鴑g k� n錸g t.");

	end

end

function Pet_OnHiden()
	Pet:NotifyPetDlgClosed()
	Pet_PetName:SetProperty("DefaultEditBox", "False");
end

function Pet_EnableAddButton()
		Pet_Str_Addition:Enable();
		Pet_Int_Addition:Enable();
		Pet_Dex_Addition:Enable();
		Pet_PF_Addition:Enable();
		Pet_Sta_Addition:Enable();
end

function Pet_EnableSubButton()
		Pet_Str_Subtraction:Enable();
		Pet_Int_Subtraction:Enable();
		Pet_Dex_Subtraction:Enable();
		Pet_PF_Subtraction:Enable();
		Pet_Sta_Subtraction:Enable();
end

function Pet_DisableAddButton()
		Pet_Str_Addition:Disable();
		Pet_Int_Addition:Disable();
		Pet_Dex_Addition:Disable();
		Pet_PF_Addition:Disable();
		Pet_Sta_Addition:Disable();
end

function Pet_DisableSubButton()
		Pet_Str_Subtraction:Disable();
		Pet_Int_Subtraction:Disable();
		Pet_Dex_Subtraction:Disable();
		Pet_PF_Subtraction:Disable();
		Pet_Sta_Subtraction:Disable();
end

function Pet_Refresh_ADDSUB_Button()

	AxTrace(0,1,"PETATTR1="..PETATTR[1])
	AxTrace(0,1,"PETATTR2="..PETATTR[2])
	AxTrace(0,1,"PETATTR3="..PETATTR[3])
	AxTrace(0,1,"PETATTR4="..PETATTR[4])
	AxTrace(0,1,"PETATTR5="..PETATTR[5])
	AxTrace(0,1,"PET_POTREMAIN="..PET_POTREMAIN)

	if PETATTR[1] > 0 then
		Pet_Str_Subtraction:Enable();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	end
	if PETATTR[2] > 0 then
		Pet_Int_Subtraction:Enable();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	end
	if PETATTR[3] > 0 then
		Pet_Dex_Subtraction:Enable();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	end
	if PETATTR[4] > 0 then
		Pet_PF_Subtraction:Enable();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	end
	if PETATTR[5] > 0 then
		Pet_Sta_Subtraction:Enable();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	end

	if PET_POTREMAIN > 0 then
		AxTrace(0,1,"yes here")
		Pet_EnableAddButton();
		Pet_Accept:Enable();
		Pet_Cancel:Enable();
	else
		Pet_DisableAddButton();
	end

	local Sum_Attr = 0;
	for i=1,PET_ATTR_COUNT do
		Sum_Attr = Sum_Attr + PETATTR[i];
	end

	if PET_POTREMAIN <=0 and Sum_Attr <= 0 then
		Pet_Accept:Disable();
		Pet_Cancel:Disable();
	end

end

function PetName_Change()
	if Pet_PetName:GetText() ~= "" then
		Changed_Name_Flag = 0;
		AxTrace(0,1,"here");
	end
end

function Pet_Ride_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);

	OpenRidePage();
	Pet_Close();
	Pet_SelfEquip : SetCheck(0);
	Pet_SelfData : SetCheck(0);
	Pet_Pet : SetCheck(1);
	Pet_Ride : SetCheck(0);
	Pet_OtherInfo : SetCheck(0);
end

function Pet_Other_Info_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);

	OtherInfoPage();
	Pet_Close();
	Pet_SelfEquip : SetCheck(0);
	Pet_SelfData : SetCheck(0);
	Pet_Pet : SetCheck(1);
	Pet_Ride : SetCheck(0);
	Pet_OtherInfo : SetCheck(0);
end

function Pet_Xiulian_Switch()
    nLevel = Player:GetData("LEVEL")
	if(nLevel >= 70) then
		Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);
		XiuLianPage();
	else
	    Pet_Xiulian : SetCheck(0);
	    PushDebugMessage("#{XL_090707_62}")
	end
end

--打开自己的资料页面
function Pet_SelfData_Switch()
	Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);

	SystemSetup:OpenPrivatePage("self");
	Pet_Close();
end


function Pet_Open()
	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = -1
	SetTimer("Pet", "Pet_AutoClick_Timer()", g_AutoClickTimer_Step)

	this:Show();
end
function Pet_Close()
	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = -1
	KillTimer("Pet_AutoClick_Timer()")

	this:Hide();
end

function Pet_chenghao_Clicked()
	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end
	Pet:PetOpenTitleList(PETNUM);
end

function Pet_Jian_Clicked()
	if(not (Pet:IsPresent(PETNUM)) ) then
		return;
	end
	Pet:PetOpenPetJian(PETNUM,"self");
end


--获取玩家当前等级最大携带数量(以后增加兽栏后要废除,而采用新的方法)-add by xindefeng
function GetMyCurMaxPetCount()
	local mylevel = Player:GetData("LEVEL") --获取玩家等级
	if mylevel == nil or type(mylevel) ~= "number" then
		return 2;
	end
	local MaxCount = 0	--携带上限

	if mylevel < 21 then
		MaxCount = 2	--一开始就携带上限就是2
	elseif mylevel < 41 then
		MaxCount = 3
	elseif mylevel < 61 then
		MaxCount = 4
	elseif mylevel < 81 then
		MaxCount = 5
	else
		MaxCount = 6
	end
	MaxCount = MaxCount + Player:GetData("PET_EXTRANUM")

	if MaxCount > PET_MAX_NUMBER then
		MaxCount = PET_MAX_NUMBER
	end

	return MaxCount
end

--zchw 一键卸装
function OneKeyUnEquip_Clicked()
	Pet:Lua_OneKeyUnEquip();
end

--显示武魂UI
function Pet_Wuhun_Switch()
	Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);
	ToggleWuhunPage();
end

function Pet_Wuhun_Page_Switch()
	local Level = Player:GetData("LEVEL")
	if Level < 65 then
		SelfEquip_Wuhun : SetCheck(0)
		PushDebugMessage("C 65 m緄 c� th� s� d鴑g.")
	else
		Variable:SetVariable("SelfUnionPos", Pet_Frame:GetProperty("UnifiedPosition"), 1);
		PushEvent("UI_COMMAND",20111211)
	end
end

function Pet_Infant_Page_Switch()
	PushDebugMessage("Ch裞 n錸g ch黙 m�")
end
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
			{level =15,	per = "59.5%", maxlevel=5,	color = "#cFF8001"},
}
local ShowColor = "#H";
local TARGETPETSKILL_BUTTONS_NUM = 12;
local TARGETPETSKILL_BUTTONS = {};
local Currend_Pet = -1;
local PET_AITYPE = {};

function TargetPet_PreLoad()
--	this:RegisterEvent("TOGLE_PET_PAGE");
	this:RegisterEvent("UPDATE_TARGETPET_PAGE");
	this:RegisterEvent("VIEW_EXCHANGE_PET")
	this:RegisterEvent("UPDATE_PETINVITEFRIEND")
	this:RegisterEvent("CLOSE_PET_FRAME")
	this:RegisterEvent("TOGLE_PET_PAGE");
	
end

function TargetPet_OnLoad()
	TARGETPETSKILL_BUTTONS[1] = TargetPet_Skill1;
	TARGETPETSKILL_BUTTONS[2] = TargetPet_Skill2;
	TARGETPETSKILL_BUTTONS[3] = TargetPet_Skill3;
	TARGETPETSKILL_BUTTONS[4] = TargetPet_Skill4;
	TARGETPETSKILL_BUTTONS[5] = TargetPet_Skill5;
	TARGETPETSKILL_BUTTONS[6] = TargetPet_Skill6;
	TARGETPETSKILL_BUTTONS[7] = TargetPet_Skill7;
	TARGETPETSKILL_BUTTONS[8] = TargetPet_Skill8;
	TARGETPETSKILL_BUTTONS[9] = TargetPet_Skill9;
	TARGETPETSKILL_BUTTONS[10] = TargetPet_Skill10;
	TARGETPETSKILL_BUTTONS[11] = TargetPet_Skill11;
	TARGETPETSKILL_BUTTONS[12] = TargetPet_Skill12;

	PET_AITYPE[0] = "Nh醫 gan";
	PET_AITYPE[1] = "C th";
	PET_AITYPE[2] = "Trung th馽";
	PET_AITYPE[3] = "Nhanh nh﹏";
	PET_AITYPE[4] = "D鹡g m鉵h";
end

function TargetPet_OnEvent(event)
--	if ( event == "TOGLE_PET_PAGE" ) then
--	this:TogleShow();
--		Pet_Update();
--		return;
--	else
	if ( event == "UPDATE_TARGETPET_PAGE" ) then
		if( tonumber(arg0) >= 0) then		
			Currend_Pet = tonumber(arg0);
			TargetPet : CopyMyPet(Currend_Pet);
		end
		if(IsWindowShow("OtherPet")) then
			CloseWindow("OtherPet", true);
		end
		-- zchw
		if IsWindowShow("TargetPet2") then
			CloseWindow("TargetPet2", true);
		end
		TargetPet_FakeObject : SetFakeObject( "" );
		TargetPet : SetModel();
		TargetPet_FakeObject : SetFakeObject( "My_TargetPet" );
		TargetPet_Update();
		this:Show();
	
	--交易过程中的珍兽显示	
	elseif (event == "VIEW_EXCHANGE_PET")  then
		if(IsWindowShow("OtherPet")) then
			CloseWindow("OtherPet", true);
		end
		--zchw
		if IsWindowShow("TargetPet2") then
			CloseWindow("TargetPet2", true);
		end
		TargetPet_FakeObject : SetFakeObject( "" );
		TargetPet : SetModel();
		TargetPet_FakeObject : SetFakeObject( "My_TargetPet" );		
		TargetPet_Update();
		this:Show();

	elseif (event == "UPDATE_PETINVITEFRIEND") then
		if("target" == tostring(arg0)) then
			if(IsWindowShow("OtherPet")) then
				CloseWindow("OtherPet", true);
			end
			--zchw
			if IsWindowShow("TargetPet2") then
				CloseWindow("TargetPet2", true);
			end
			TargetPet_FakeObject : SetFakeObject( "" );
			TargetPet:SetModel();
			TargetPet_FakeObject : SetFakeObject( "My_TargetPet" );
			TargetPet_Update();
			this:Show();
		end
		
	elseif ( event == "CLOSE_PET_FRAME" and this:IsVisible() ) then
		this:Hide();
		return
	elseif ( event == "TOGLE_PET_PAGE" and this:IsVisible() ) then
		this:Hide();
		return
	end
	
end

function TargetPet_OnShown()

	TargetPet_Page_Clear();

	if( TargetPet:IsPresent() ) then
		TargetPet_Update();
		return;
	end;

end

function TargetPet_Page_Clear()

--	TargetPet_PetName : SetText( "" );
	TargetPet_PageHeader : SetText( "#gFF0FA0" );
	TargetPet_ConsortID : SetText( "" );
	TargetPet_Model_Protect_Text : SetText( "" );
	TargetPet_TargetPetID : SetText( "" );
	TargetPet_Sex : SetText("");
	TargetPet_Life : SetText( "" );
	TargetPet_Happy : SetText("");
--	Pet_LoyalgGade : SetText( "" );
	TargetPet_Level : SetText( "" );
--	Pet_Type : SetText( "" );
	TargetPet_StrAptitude : SetText( "" );
	TargetPet_PhysicalStrengthAptitude : SetText( "" );
	TargetPet_DexterityAptitude : SetText( "" );
	TargetPet_NimbusAptitude : SetText( "" );
	TargetPet_StabilityAptitude : SetText( "" );
--	TargetPet_Exp : SetText( "" );
	TargetPet_Blood : SetText( "" .. "  " .. "" );
--	Pet_MP : SetText( "" .. " / " .. "" );
	TargetPet_Str : SetText( "" );
	TargetPet_Str : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_Nimbus : SetText( "" );
	TargetPet_Nimbus : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_Dexterity : SetText( "" );
	TargetPet_Dexterity : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_PhysicalStrength : SetText( "" );
	TargetPet_PhysicalStrength : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_Stability : SetText( "" );
	TargetPet_Stability : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_GenGu : SetText( "" );
	TargetPet_WuXing : SetText( "" );
	TargetPet_Potential : SetText( "" );
	TargetPet_Potential : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	TargetPet_PhysicsAttack : SetText( "" );
	TargetPet_MagicAttack : SetText( "" );
	TargetPet_PhysicsRecovery : SetText( "" );
	TargetPet_MagicRecovery : SetText( "" );
	TargetPet_Miss : SetText( "" );
	TargetPet_ShootProbability : SetText( "" );
	TargetPet_CriticalAttack:SetText("");
	TargetPet_CriticalDefence:SetText("");
	TargetPet_Growth:SetText("")
	TargetPet_Lingxing : SetText("")
	--TargetPet_FakeObject : SetFakeObject( "" );
	for i=1, TARGETPETSKILL_BUTTONS_NUM do
		TARGETPETSKILL_BUTTONS[i]:SetActionItem(-1);
	end
	TargetPetFood_Type : Hide()
	TargetPet_NeedLevel : SetText("")
	TargetPet_lock:Hide();
	TargetPetAttack_Type:Hide();
	TargetPet_Jian : Hide();
end

function TargetPet_Update()

	local i;

	if(not (TargetPet:IsPresent()) ) then
		return;
	end
	
	local strName, strName2, sex
	TargetPet_Page_Clear();
	strName = TargetPet:GetAIType(nIndex);
 	
	local strAI,strIcon;
	if(strName>4 or strName <0) then
		strAI = "Sai s髏 ";
	else
		strAI =	PET_AITYPE[strName];
	end
	
 	strName,strName2 = TargetPet:GetName();
	local nEra, strTypeName = TargetPet:GetPetTypeName(nIndex);
 	if( 1 == nEra ) then
 	    strName2 = "卸i th� 2 "..strTypeName
 	end
	TargetPet_PetName : SetText( strName2 );
	TargetPet_PageHeader : SetText( "#gFF0FA0"..strName2 );
	TargetPet_Type : SetText("#gFF8E92"..strAI)

	strName,strName2,sex = TargetPet : GetID();
	TargetPet_TargetPetID : SetText( "Tr鈔 th� ID: "..strName2 );
	AxTrace(0,0,"GetID="..strName .. strName2);
	
	strName = TargetPet : GetConsort();
	if tonumber(strName) == 0 then
		TargetPet_ConsortID : SetText( "Kh鬾g c� ai 瓞 ch絠 c鵱g" );
	else
		TargetPet_ConsortID : SetText( "Phu ph� ID: ".. strName );
	end
	
	if 2 == 1 then
	--if TargetPet : GetGoodsProtect_Pet() == 1 then
		TargetPet_Model_Protect_Text : SetText( "#{GDWPBH_090507_4}" );
	else
		TargetPet_Model_Protect_Text : SetText( "" );
	end
		
	if(sex == 1) then 
		strName = "旭c";
	else
		strName = "C醝";
	end

	local nGeneration  = 0;--TargetPet : GetGeneration()
	if nGeneration ~= nil and nGeneration >= 100 then
		strName = "#{RXZS_XML_35}";
	end

	TargetPet_Sex : SetText( strName );
	
	strName = TargetPet : GetNaturalLife();
	TargetPet_Life : SetText( "Th� m畁h: "..strName );

	strName = TargetPet : GetLevel();
	TargetPet_Level : SetText( "C: "..strName.." c" );
	
	strName = TargetPet : GetHappy();
	TargetPet_Happy : SetText( "Hoan h�: "..strName );
	
	strName = TargetPet : GetBasic();
	TargetPet_GenGu : SetText( "C錸 c痶: "..strName );
	
	strName = "0";--TargetPet : GetLixing(nIndex);
	TargetPet_Lingxing : SetText("#{RXZS_XML_28}"..strName)

	strName = TargetPet : GetSavvy();
	AxTrace(0,0,"targetpet savvy="..strName)
	TargetPet_WuXing : SetText( "Ng� t韓h: ".. strName);
	
	local WuXingVal = tonumber(strName);
	strName = TargetPet : GetStrAptitude();
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	TargetPet_StrAptitude : SetText( strName );

	strName = TargetPet : GetPFAptitude(nIndex);
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	TargetPet_PhysicalStrengthAptitude : SetText( strName );
	
	strName = TargetPet : GetDexAptitude();
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	TargetPet_DexterityAptitude : SetText( strName );
	
	strName = TargetPet : GetIntAptitude();
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	TargetPet_NimbusAptitude : SetText( strName );
	
	strName = TargetPet : GetStaAptitude();
	if(WuXingTbl[WuXingVal])then
		strName = (WuXingTbl[WuXingVal].color)..strName..ShowColor.."(+"..(WuXingTbl[WuXingVal].per)..")";
	end
	TargetPet_StabilityAptitude : SetText( strName );
	
--	strName = TargetPet : GetExp();
--	TargetPet_Exp : SetText( "经验:"..strName );
	
	strName = TargetPet : GetHP(nIndex);
	strName2 = TargetPet:	GetMaxHP(nIndex);
	TargetPet_Blood : SetText( "Huy猼: "..strName .." / ".. strName2);

	strName = TargetPet : GetStr();
	TargetPet_Str : SetText( strName );
	TargetPet_Str : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	
	strName = TargetPet : GetInt();
	TargetPet_Nimbus : SetText( tonumber(strName) );
	TargetPet_Nimbus : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	
	strName = TargetPet : GetDex();
	TargetPet_Dexterity : SetText( tonumber(strName) );
	TargetPet_Dexterity : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	
	strName = TargetPet : GetPF();
	TargetPet_PhysicalStrength : SetText( tonumber(strName) );
	TargetPet_PhysicalStrength : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	
	strName = TargetPet : GetSta();
	TargetPet_Stability : SetText( tonumber(strName) );
	TargetPet_Stability : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");
	
--	strName = TargetPet : GetBasic();
--	TargetPet_Basic : SetText( tonumber(strName) );

	strName = TargetPet : GetCriticalAttack();
	TargetPet_CriticalAttack : SetText( tonumber(strName) );

	strName = TargetPet : GetCriticalDefence();
	TargetPet_CriticalDefence : SetText( tonumber(strName) );

	strName = TargetPet : GetPotential();
	strName2 = tonumber(strName);
	TargetPet_Potential : SetText( strName2 );
	TargetPet_Potential : SetProperty("TextColours","tl:FFEFEFEF tr:FFEFEFEF bl:FFEFEFEF br:FFEFEFEF");

	strName = TargetPet : GetPhysicsAttack();
	TargetPet_PhysicsAttack : SetText( strName );
	
	strName = TargetPet : GetMagicAttack();
	TargetPet_MagicAttack : SetText( strName );
	
	strName = TargetPet : GetPhysicsRecovery();
	TargetPet_PhysicsRecovery : SetText( strName );
	
	strName = TargetPet : GetMagicRecovery ();
	TargetPet_MagicRecovery : SetText( strName );

	--闪避率
	strName = TargetPet : GetMiss();
	TargetPet_Miss : SetText( strName );

	--命中率
	strName = TargetPet : GetShootProbability();
	TargetPet_ShootProbability : SetText( strName );
	
	local SumPetSkill = GetActionNum("petskill");
	local k=1;
	
	for i=1, SumPetSkill+TARGETPETSKILL_BUTTONS_NUM do
		local theSkillAction = Pet : EnumPetSkill( 100, i-1, "petskill");
		if( theSkillAction ~= nil and (theSkillAction : GetPetSkillOwner() == 100) and (k <= TARGETPETSKILL_BUTTONS_NUM ) ) then
			TARGETPETSKILL_BUTTONS[k]:SetActionItem(theSkillAction:GetID());
			k = k + 1;
		end
	end
	
	local strNeedLevel;
	local strNeedLevelColor;
	local nTakeLevel = TargetPet:GetTakeLevel();
	
	if( nTakeLevel > Player:GetData( "LEVEL" ) )then
		strNeedLevelColor="#cFF0000";
	else
		strNeedLevelColor="#c00FF00";
	end
	strNeedLevel = strNeedLevelColor..tostring( nTakeLevel ).."C #Wc� th� mang theo";

	TargetPet_NeedLevel : SetText(strNeedLevel)

	strName = TargetPet : GetGrowRate();
	TargetPet_Growth : SetText("#GCh遖 bi猼")
	local nGrowLevel = TargetPet : GetPetGrowLevel(tonumber(strName));
	local strTbl = {"S� c","Xu s","Ki畉 xu","Tr醕 vi畉","To鄋 m�"};
	
	if(nGrowLevel >= 0) then
		nGrowLevel = nGrowLevel + 1;	--c里是从0开始的枚举
		local nGrowRate = TargetPet : GetGrowRate();
		if(strTbl[nGrowLevel]) then
			TargetPet_Growth : SetText("#G"..strTbl[nGrowLevel]..nGrowRate)
		end
	end

	local food = TargetPet : GetFoodType();
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
	TargetPetFood_Type : Show();
	TargetPetFood_Type : SetToolTip( strName );
	
	strName,strIcon = TargetPet : GetAttackTrait();
	AxTrace(0,0,"strIcon="..strIcon)
	AxTrace(0,0,"strName="..strName)
	if strIcon ~= "" then
		TargetPetAttack_Type : SetProperty( "Image", "set:Button6 image:"..strIcon )
		TargetPetAttack_Type : SetToolTip(strName)
		TargetPetAttack_Type : Show();
	end

	TargetPet_Jian : Show();
end

function TargetPet_Skill_Button_Clicked(nIndex)
--将来主动技能和被动技能，可以在表里查到。
--	if(nIndex < 3) then
		
--	end

--	PETSKILL_BUTTONS[nIndex] : DoAction();

--	local SumPetSkill = GetActionNum("petskill");
--	local k=1;
--	for i=1, SumPetSkill do
--		local theSkillAction = EnumAction( i-1, "petskill");
--		if( (theSkillAction : GetPetSkillOwner() == nIndex) and (k <= TARGETPETSKILL_BUTTONS_NUM ) ) then
--			PETSKILL_BUTTONS[k]:SetActionItem(theSkillAction:GetID());
--			k = k + 1;
--		end
--	end
end

----------------------------------------------------------------------------------
--
-- 旋转珍兽模型（向左)
--
function TargetPet_Modle_TurnLeft(start)
	--向左旋转开始
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--向左旋转开始
		if(start == 1) then
			TargetPet_FakeObject:RotateBegin(-0.3);
		--向左旋转结束
		else
			TargetPet_FakeObject:RotateEnd();
		end
	end
end

----------------------------------------------------------------------------------
--
--旋转珍兽模型（向右)
--
function TargetPet_Modle_TurnRight(start)
	--向右旋转开始
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--向右旋转开始
		if(start == 1) then
			TargetPet_FakeObject:RotateBegin(0.3);
		--向右旋转结束
		else
			TargetPet_FakeObject:RotateEnd();
		end
	end
end

function TargetPet_Jian_Clicked()
	if(not (TargetPet:IsPresent()) ) then
		return;
	end
	Pet:PetOpenPetJian(-1,"target");
end

local cooldownTime = 15*1000;		--结识的冷却时间
local pageCoolDownTime = 5*1000;	--翻页冷却时间，翻页消耗较大
local PET_AITYPE = {};
local FlashTextHeader = "#ecc33cc#cffcccc";		--调节这个来控制文字颜色和闪烁
local showWindowFlag = false;
local listflag = 0;
local showPrevPage = true;
local showNextPage = true;

function PetZhengYou_PreLoad()
	this:RegisterEvent("UPDATE_PETINVITEFRIEND");
	this:RegisterEvent("OPEN_WINDOW");
end


function PetZhengYou_OnLoad()
	PET_AITYPE[0] = "#gFF0FA0Nh醫 gan";
	PET_AITYPE[1] = "#gFF0FA0C th";
	PET_AITYPE[2] = "#gFF0FA0Trung th鄋h";
	PET_AITYPE[3] = "#gFF0FA0Nhanh nh﹏";
	PET_AITYPE[4] = "#gFF0FA0D鹡g m鉵h";
end

function PetZhengYou_Hide()
	this:Hide();
end

function PetZhengYou_OnEvent(event)
	if(event == "UPDATE_PETINVITEFRIEND") then
		if("notifypetlist" == arg0) then
			PetZhengYou_ShowWindow(listflag);
		elseif("searchlist" == arg0 or "searchlistbegin" == arg0) then
			this:Hide();
		elseif("noprevpage" == arg0) then
			showPrevPage = false;
			PetZhengYou_PageUp:Disable();
			PushDebugMessage("秀 l� trang 馥u ti阯 r癷");
		elseif("notifypetlistnone" == arg0) then
			if listflag == -1 then
				showPrevPage = false;
				PetZhengYou_PageUp:Disable();
				PushDebugMessage("秀 l� trang 馥u ti阯 r癷");
			elseif listflag == 1 then
				showNextPage = false;
				PetZhengYou_PageDown:Disable();
				PushDebugMessage("秀 l� trang cu痠 c鵱g r癷");
			else
				PetZhengYou_ShowWindow(-2);
			end
		end

	elseif ( event == "OPEN_WINDOW") then
		if( arg0 == "Show_Pet_Friends") then
			if(this:IsVisible()) then
				this:Hide();
			else
				PetInviteFriend:ShowPetFriends(0);
				listflag = 0;
			end
		end
	end
end
--收到World的数据后调用显示界面
local needEnable = false;
function PetZhengYou_ShowWindow(who)
	local num = PetInviteFriend:GetInviteNum("friends")
	if who == -2 then
		PetZhengYou_DisableAllWindow();
		this:Show();
		needEnable = true;
		return;
	end
	if needEnable then
		PetZhengYou_EnableAllWindow();
		needEnable = false;
	end
	if( num <= 0) then
		if who == -1 then
			PushDebugMessage("Trong server kh鬾g c� d� li畊 c黙 Tr鈔 Th� Chinh H鎢");
			showPrevPage = false;
		elseif who == 1 then
			PushDebugMessage("Trong server kh鬾g c� d� li畊 c黙 Tr鈔 Th� Chinh H鎢");
			showNextPage = false;
		else
			PetZhengYou_DisableAllWindow();
			showWindowFlag = true;
			this:Show();
		end
		return;
	else
		showNextPage = true;
		showPrevPage = true;
	end
	if who == 0 then
		showPrevPage = false;
	end
	if num <= 1 then
		showNextPage = false;
	end
	PetZhengYou_Clear_All();
	for i=1, num do
		PetZhengYou_Update(i);
	end
	if( num == 1 ) then
		PetZhengYou_DisableButton(1);
		PetZhengYou_HideWindow(1);
	end
	if showNextPage then
		PetZhengYou_PageDown:Enable();
	end
	if showPrevPage then
		PetZhengYou_PageUp:Enable();
	end
	this:Show();
end

function PetZhengYou_Update( idx )
	if(idx < 0 or idx > 2 or idx == nil) then
		return;
	end
	idx = idx + 2;

	--获取珍兽主人信息
	local humanName = PetInviteFriend:GetHumanINFO(idx, "NAME");
	local humanMenPai = PetInviteFriend:GetHumanINFO(idx, "MENPAI");	
	local humanLevel = PetInviteFriend:GetHumanINFO(idx, "LEVEL");
	local humanSex  = PetInviteFriend:GetHumanINFO(idx, "SEX");
	humanMenPai = PetZhengYou_ConvertNumToMenPai(humanMenPai);
	if( humanSex == 0 ) then
		humanSex = "N�";
	else
		humanSex = "Nam";
	end
		
	--获取珍兽信息
	local petName = PetInviteFriend:GetPetINFO(idx, "NAME");
	local petGrow = PetInviteFriend:GetPetINFO(idx, "GROW");	
	local petLevel = PetInviteFriend:GetPetINFO(idx, "LEVEL");
	local petSex  = PetInviteFriend:GetPetINFO(idx, "SEX");
	local petAI   = PetInviteFriend:GetPetINFO(idx, "AITYPE");
	local petTypeName = PetInviteFriend:GetPetINFO(idx, "TYPENAME");
	petTypeName = FlashTextHeader .. petTypeName .. "B鋙 B鋙";
	if( petSex == 0 ) then
		petSex = "C醝";
	else
		petSex = "旭c";
	end
	local strTbl = {"S� c","Xu s","Ki畉 xu","Tr醕 vi畉","To鄋 m�"};
	
	if(petGrow >= 0) then
		petGrow = petGrow + 1;	--c里是从0开始的枚举
		if(strTbl[petGrow]) then
			petGrow = strTbl[petGrow];
		else
			petGrow = "Ch遖 bi猼";
		end
	else
		petGrow = "Ch遖 bi猼";
	end
	
	if(petAI>4 or petAI <0) then
		petAI = "Sai s髏 ";
	else
		petAI =	PET_AITYPE[petAI];
	end
	--PushDebugMessage("idx = " .. tostring(idx));
	--PushDebugMessage(humanName);
	
	if( idx == 3 ) then
	  --设置珍兽信息
		PetZhengYou_Master1Pet_NameInfo:SetText(petName);
		PetZhengYou_Master1Pet_GenderInfo:SetText(petSex);
		PetZhengYou_Master1Pet_ChenZhangInfo:SetText(petGrow);
		PetZhengYou_Master1Pet_LevelInfo:SetText(petLevel);
		PetZhengYou_Type1:SetText(petAI);
		PetZhengYou_Flash_Name1:SetText(petTypeName);
		
		--设置主人信息
		PetZhengYou_Master1_NameInfo:SetText(humanName);
		PetZhengYou_Master1_LevelInfo:SetText(humanLevel);
		PetZhengYou_Master1_ManPaiInfo:SetText(humanMenPai);
		PetZhengYou_Master1_GenderInfo:SetText(humanSex);
			
		--设置模型信息
		PetInviteFriend:SetPetModel(idx);
		PetZhengYou_PetModel1:SetFakeObject("My_PetFriend01");
			
		PetZhengYou_Pet1_Investigate:Enable();
		PetZhengYou_Pet1_Investigate:Enable();
		PetZhengYou_PetModel1_TurnRight:Enable();
		PetZhengYou_PetModel1_TurnLeft:Enable();

	
	elseif( idx == 4 ) then
	  --设置珍兽信息
		PetZhengYou_Master2Pet_NameInfo:SetText(petName);
		PetZhengYou_Master2Pet_GenderInfo:SetText(petSex);
		PetZhengYou_Master2Pet_ChenZhangInfo:SetText(petGrow);
		PetZhengYou_Master2Pet_LevelInfo:SetText(petLevel);
		PetZhengYou_Type2:SetText(petAI);
		PetZhengYou_Flash_Name2:SetText(petTypeName);
		
		--设置主人信息
		PetZhengYou_Master2_NameInfo:SetText(humanName);
		PetZhengYou_Master2_LevelInfo:SetText(humanLevel);
		PetZhengYou_Master2_ManPaiInfo:SetText(humanMenPai);
		PetZhengYou_Master2_GenderInfo:SetText(humanSex);
			
		--设置模型信息
		PetInviteFriend:SetPetModel(idx);
		PetZhengYou_PetModel2:SetFakeObject("My_PetFriend02");
		
		--激活按钮
		PetZhengYou_Pet2_Investigate:Enable();
		PetZhengYou_Pet2_Acquaintance:Enable();
		PetZhengYou_PetModel2_TurnRight:Enable();
		PetZhengYou_PetModel2_TurnLeft:Enable();
		
			
		--显示文本
		PetZhengYou_Master2Pet_Name:Show();
		PetZhengYou_Master2Pet_Gender:Show();
		PetZhengYou_Master2Pet_ChenZhang:Show();
		PetZhengYou_Master2Pet_Level:Show();
		PetZhengYou_Master2_Name:Show();
		PetZhengYou_Master2_Level:Show();
		PetZhengYou_Master2_ManPai:Show();
		PetZhengYou_Master2_Gender:Show();
		PetZhengYou_Master2Pet_NameInfo:Show();
		PetZhengYou_Master2Pet_GenderInfo:Show();
		PetZhengYou_Master2Pet_ChenZhangInfo:Show();
		PetZhengYou_Master2Pet_LevelInfo:Show();
		PetZhengYou_Master2_NameInfo:Show();
		PetZhengYou_Master2_LevelInfo:Show();
		PetZhengYou_Master2_ManPaiInfo:Show();
		PetZhengYou_Master2_GenderInfo:Show();
		PetZhengYou_Master2Info2:Show();
		PetZhengYou_Type2:Show();
		PetZhengYou_Flash_Name2:Show();
	end	

end

--隐藏一些 窗口
function PetZhengYou_HideWindow(idx)
	if( idx == 0 ) then
		PetZhengYou_Master1Pet_Name:Hide();
		PetZhengYou_Master1Pet_Gender:Hide();
		PetZhengYou_Master1Pet_ChenZhang:Hide();
		PetZhengYou_Master1Pet_Level:Hide();
		PetZhengYou_Master1_Name:Hide();
		PetZhengYou_Master1_Level:Hide();
		PetZhengYou_Master1_ManPai:Hide();
		PetZhengYou_Master1_Gender:Hide();
	else
		PetZhengYou_Master2Pet_Name:Hide();
		PetZhengYou_Master2Pet_Gender:Hide();
		PetZhengYou_Master2Pet_ChenZhang:Hide();
		PetZhengYou_Master2Pet_Level:Hide();
		PetZhengYou_Master2_Name:Hide();
		PetZhengYou_Master2_Level:Hide();
		PetZhengYou_Master2_ManPai:Hide();
		PetZhengYou_Master2_Gender:Hide();
		PetZhengYou_Master2Pet_NameInfo:Hide();
		PetZhengYou_Master2Pet_GenderInfo:Hide();
		PetZhengYou_Master2Pet_ChenZhangInfo:Hide();
		PetZhengYou_Master2Pet_LevelInfo:Hide();
		PetZhengYou_Master2_NameInfo:Hide();
		PetZhengYou_Master2_LevelInfo:Hide();
		PetZhengYou_Master2_ManPaiInfo:Hide();
		PetZhengYou_Master2_GenderInfo:Hide();
		PetZhengYou_Master2Info2:Hide();
		PetZhengYou_Type2:Hide();
		PetZhengYou_Flash_Name2:Hide();
	end
end

--禁用一些按钮
function PetZhengYou_DisableButton(idx)
	if( idx == 0 ) then
		PetZhengYou_Pet1_Investigate:Disable();
		PetZhengYou_Pet1_Acquaintance:Disable();
		PetZhengYou_PetModel1_TurnRight:Disable();
		PetZhengYou_PetModel1_TurnLeft:Disable();
	else
		PetZhengYou_Pet2_Investigate:Disable();
		PetZhengYou_Pet2_Acquaintance:Disable();
		PetZhengYou_PetModel2_TurnRight:Disable();
		PetZhengYou_PetModel2_TurnLeft:Disable();

	end
end


function PetZhengYou_Clear_All()
	
		if showWindowFlag then
			PetZhengYou_EnableAllWindow();
			showWindowFlag = false;
		end
		PetZhengYou_DisableButton(1);
		PetZhengYou_HideWindow(1);
		PetZhengYou_PetModel1:SetFakeObject("");
		PetZhengYou_PetModel2:SetFakeObject("");
		if( Pet:GetPet_Count() == 0 ) then
			PetZhengYou_Search:Disable();
		else
			PetZhengYou_Search:Enable();
		end
		PetZhengYou_PageDown:Disable();
		PetZhengYou_PageUp:Disable();
	--end
end


function PetZhengYou_ShowTargetFrame(who)
	PetInviteFriend:ShowTargetPet(who);
end

function PetZhengYou_ConvertNumToMenPai( MenPaiId )
	local strMenPai = "???";
	-- 得到门派名称.
	if(0 == MenPaiId) then
		strMenPai = "Thi猽 L鈓";

	elseif(1 == MenPaiId) then
		strMenPai = "Minh Gi醥";

	elseif(2 == MenPaiId) then
		strMenPai = "C醝 Bang";

	elseif(3 == MenPaiId) then
		strMenPai = "V� 衋ng";

	elseif(4 == MenPaiId) then
		strMenPai = "Nga My";

	elseif(5 == MenPaiId) then
		strMenPai = "Tinh T鷆";

	elseif(6 == MenPaiId) then
		strMenPai = "Thi阯 Long";

	elseif(7 == MenPaiId) then
		strMenPai = "Thi阯 S絥";

	elseif(8 == MenPaiId) then
		strMenPai = "Ti陁 Dao";

	elseif(9 == MenPaiId) then
		strMenPai = "Kh鬾g c�";
	end
	
	return strMenPai;
end
----------------------------------------------------------------------------------
--
-- 旋转珍兽模型（向左)
--
function PetZhengYou_Modle_TurnLeft(modelIdx,start)

		if( modelIdx == 3 ) then
		--向左旋转开始
			if(start == 1) then
				PetZhengYou_PetModel1:RotateBegin(-0.3);
			--向左旋转结束
			else
				PetZhengYou_PetModel1 :RotateEnd();
			end
		end
		if( modelIdx == 4 ) then
			if(start == 1) then
				PetZhengYou_PetModel2:RotateBegin(-0.3);
			--向左旋转结束
			else
				PetZhengYou_PetModel2 :RotateEnd();
			end
	 end
end

----------------------------------------------------------------------------------
--
--旋转珍兽模型（向右)
--
function PetZhengYou_Modle_TurnRight(modelIdx, start)
	if( modelIdx == 3 ) then
		--向左旋转开始
			if(start == 1) then
				PetZhengYou_PetModel1:RotateBegin(0.3);
			--向左旋转结束
			else
				PetZhengYou_PetModel1 :RotateEnd();
			end
	elseif( modelIdx == 4 ) then
			if(start == 1) then
				PetZhengYou_PetModel2:RotateBegin(0.3);
			--向左旋转结束
			else
				PetZhengYou_PetModel2 :RotateEnd();
			end
	end
end

--查询上一篇的珍兽征友信息
function PetZhengYou_PrevPage()
	listflag = -1;
	PetInviteFriend:ShowPetFriends(-1);
	PetZhengYou_PageUp:Disable();
	if showPrevPage then
		SetTimer("PetZhengYou","PetZhengYou_CoolPageUp();", pageCoolDownTime);
	end
end

function PetZhengYou_CoolPageUp()
	if showPrevPage then
		PetZhengYou_PageUp:Enable();
	else
		PetZhengYou_PageUp:Disable();
	end
	KillTimer("PetZhengYou_CoolPageUp();");
end


--查询下一篇的珍兽征友信息
function PetZhengYou_NextPage()
	listflag = 1;
	PetInviteFriend:ShowPetFriends(1);
	PetZhengYou_PageDown:Disable();
	if showNextPage then
		SetTimer("PetZhengYou","PetZhengYou_CoolPageDown();", pageCoolDownTime);
	end
end

function PetZhengYou_CoolPageDown()
	if showNextPage then
		PetZhengYou_PageDown:Enable();
	else
		PetZhengYou_PageDown:Disable();
	end
	KillTimer("PetZhengYou_CoolPageDown();");
end


--给珍兽主人发邮件，说明想征友
function PetZhengYou_SendMail( idx )
	if( idx == 3 or idx == 4 ) then
		local owner = PetInviteFriend:GetHumanINFO(idx, "NAME");
		local player = Player:GetName();
		if(owner == player) then
			PushDebugMessage("Kh鬾g th� t� k猼 th鈔 Tr鈔 Th�");
			return;
		end
			--给该珍兽主人发送邮件告诉他她你的珍兽想和他她的珍兽结识
		DataPool:OpenMail( owner,"Ta mu痭 k猼 th鈔 v緄 B鋙 B鋙 c黙 b課" );
	end
	
	if( idx == 3 ) then
		SetTimer("PetZhengYou","PetZhengYou_CoolDown3();" ,cooldownTime);
		PetZhengYou_Pet1_Acquaintance:Disable();
	elseif(idx == 4 ) then
		SetTimer("PetZhengYou","PetZhengYou_CoolDown4();" ,cooldownTime);
		PetZhengYou_Pet2_Acquaintance:Disable();
	end
end

function PetZhengYou_CoolDown3()
		PetZhengYou_Pet1_Acquaintance:Enable();
		KillTimer("PetZhengYou_CoolDown3();");
end
function PetZhengYou_CoolDown4()
		PetZhengYou_Pet2_Acquaintance:Enable();
		KillTimer("PetZhengYou_CoolDown4();");
end

--搜索合适珍兽
function PetZhengYou_OnSearch()
	Pet:ShowPetList(1);
	--this:Hide();
end

--这个函数写的很无奈呀！，窗口没有设计好，如果有个父窗口，就好了
function PetZhengYou_DisableAllWindow()
		PetZhengYou_Master1Pet_Name:Hide();
		PetZhengYou_Master1Pet_Gender:Hide();
		PetZhengYou_Master1Pet_ChenZhang:Hide();
		PetZhengYou_Master1Pet_Level:Hide();
		PetZhengYou_Master1_Name:Hide();
		PetZhengYou_Master1_Level:Hide();
		PetZhengYou_Master1_ManPai:Hide();
		PetZhengYou_Master1_Gender:Hide();
		PetZhengYou_Master1Pet_NameInfo:Hide();
		PetZhengYou_Master1Pet_GenderInfo:Hide();
		PetZhengYou_Master1Pet_ChenZhangInfo:Hide();
		PetZhengYou_Master1Pet_LevelInfo:Hide();
		PetZhengYou_Master1_NameInfo:Hide();
		PetZhengYou_Master1_LevelInfo:Hide();
		PetZhengYou_Master1_ManPaiInfo:Hide();
		PetZhengYou_Master1_GenderInfo:Hide();
		PetZhengYou_Master1Info:Hide();
		PetZhengYou_Type1:Hide();
		PetZhengYou_Flash_Name1:Hide();
			
		PetZhengYou_Master2Pet_Name:Hide();
		PetZhengYou_Master2Pet_Gender:Hide();
		PetZhengYou_Master2Pet_ChenZhang:Hide();
		PetZhengYou_Master2Pet_Level:Hide();
		PetZhengYou_Master2_Name:Hide();
		PetZhengYou_Master2_Level:Hide();
		PetZhengYou_Master2_ManPai:Hide();
		PetZhengYou_Master2_Gender:Hide();
		PetZhengYou_Master2Pet_NameInfo:Hide();
		PetZhengYou_Master2Pet_GenderInfo:Hide();
		PetZhengYou_Master2Pet_ChenZhangInfo:Hide();
		PetZhengYou_Master2Pet_LevelInfo:Hide();
		PetZhengYou_Master2_NameInfo:Hide();
		PetZhengYou_Master2_LevelInfo:Hide();
		PetZhengYou_Master2_ManPaiInfo:Hide();
		PetZhengYou_Master2_GenderInfo:Hide();
		PetZhengYou_Master2Info2:Hide();
		PetZhengYou_Type2:Hide();
		PetZhengYou_Flash_Name2:Hide();
			
		PetZhengYou_Pet1_Investigate:Disable();
		PetZhengYou_Pet1_Acquaintance:Disable();
		PetZhengYou_PetModel1_TurnRight:Disable();
		PetZhengYou_PetModel1_TurnLeft:Disable();
		PetZhengYou_Pet2_Investigate:Disable();
		PetZhengYou_Pet2_Acquaintance:Disable();
		PetZhengYou_PetModel2_TurnRight:Disable();
		PetZhengYou_PetModel2_TurnLeft:Disable();
		PetZhengYou_PageDown:Disable();
		PetZhengYou_PageUp:Disable();
		PetZhengYou_Search:Disable();
		PetZhengYou_PetModel1:SetFakeObject("");
		PetZhengYou_PetModel2:SetFakeObject("");
end

--这个函数写的很无奈呀！，窗口没有设计好，如果有个父窗口，就好了
function PetZhengYou_EnableAllWindow()
		PetZhengYou_Master1Pet_Name:Show();
		PetZhengYou_Master1Pet_Gender:Show();
		PetZhengYou_Master1Pet_ChenZhang:Show();
		PetZhengYou_Master1Pet_Level:Show();
		PetZhengYou_Master1_Name:Show();
		PetZhengYou_Master1_Level:Show();
		PetZhengYou_Master1_ManPai:Show();
		PetZhengYou_Master1_Gender:Show();
		PetZhengYou_Master1Pet_NameInfo:Show();
		PetZhengYou_Master1Pet_GenderInfo:Show();
		PetZhengYou_Master1Pet_ChenZhangInfo:Show();
		PetZhengYou_Master1Pet_LevelInfo:Show();
		PetZhengYou_Master1_NameInfo:Show();
		PetZhengYou_Master1_LevelInfo:Show();
		PetZhengYou_Master1_ManPaiInfo:Show();
		PetZhengYou_Master1_GenderInfo:Show();
		PetZhengYou_Master1Info:Show();
		PetZhengYou_Type1:Show();
		PetZhengYou_Flash_Name1:Show();
			
		PetZhengYou_Master2Pet_Name:Show();
		PetZhengYou_Master2Pet_Gender:Show();
		PetZhengYou_Master2Pet_ChenZhang:Show();
		PetZhengYou_Master2Pet_Level:Show();
		PetZhengYou_Master2_Name:Show();
		PetZhengYou_Master2_Level:Show();
		PetZhengYou_Master2_ManPai:Show();
		PetZhengYou_Master2_Gender:Show();
		PetZhengYou_Master2Pet_NameInfo:Show();
		PetZhengYou_Master2Pet_GenderInfo:Show();
		PetZhengYou_Master2Pet_ChenZhangInfo:Show();
		PetZhengYou_Master2Pet_LevelInfo:Show();
		PetZhengYou_Master2_NameInfo:Show();
		PetZhengYou_Master2_LevelInfo:Show();
		PetZhengYou_Master2_ManPaiInfo:Show();
		PetZhengYou_Master2_GenderInfo:Show();
		PetZhengYou_Master2Info2:Show();
		PetZhengYou_Type2:Show();
		PetZhengYou_Flash_Name2:Show();
			
		PetZhengYou_Pet1_Investigate:Enable();
		PetZhengYou_Pet1_Acquaintance:Enable();
		PetZhengYou_PetModel1_TurnRight:Enable();
		PetZhengYou_PetModel1_TurnLeft:Enable();
		PetZhengYou_Pet2_Investigate:Enable();
		PetZhengYou_Pet2_Acquaintance:Enable();
		PetZhengYou_PetModel2_TurnRight:Enable();
		PetZhengYou_PetModel2_TurnLeft:Enable();
		PetZhengYou_PageDown:Enable();
		PetZhengYou_PageUp:Enable();
		PetZhengYou_Search:Enable();
end

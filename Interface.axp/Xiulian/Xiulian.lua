local SELFEQUIP_TAB_TEXT = {}
local XIULIAN_BOOKS = {}
local XIULIAN_MIJI = {}
local XIULIAN_MIJI_TEXT = {}

local XIULIAN_BOOK_SELECT = 1;
local XIULIAN_MIJI_SELECT = -1;

local MIJI_CAN_SELECT = false;

function Xiulian_PreLoad()

	-- 打开界面
	this:RegisterEvent("OPEN_XIULIAN_PAGE");

	--离开场景，自动关闭
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("UNIT_XIULIAN");
	this:RegisterEvent("UINT_POWER");
	--open or close this window Fake
	this:RegisterEvent("UI_COMMAND");

end

function Xiulian_OnLoad()

	XIULIAN_BOOKS[1] = Xiulian_XinfaSkill_1
	XIULIAN_BOOKS[2] = Xiulian_XinfaSkill_2
	XIULIAN_BOOKS[3] = Xiulian_XinfaSkill_3
	XIULIAN_BOOKS[4] = Xiulian_XinfaSkill_4

	XIULIAN_MIJI[1] = Xiulian_ZhaoshiSkill_1
	XIULIAN_MIJI[2] = Xiulian_ZhaoshiSkill_2
	XIULIAN_MIJI[3] = Xiulian_ZhaoshiSkill_3
	XIULIAN_MIJI[4] = Xiulian_ZhaoshiSkill_4
	XIULIAN_MIJI[5] = Xiulian_ZhaoshiSkill_5
	XIULIAN_MIJI[6] = Xiulian_ZhaoshiSkill_6

	XIULIAN_MIJI_TEXT[1] = Xiulian_ZhaoshiSkill_level1
	XIULIAN_MIJI_TEXT[2] = Xiulian_ZhaoshiSkill_level2
	XIULIAN_MIJI_TEXT[3] = Xiulian_ZhaoshiSkill_level3
	XIULIAN_MIJI_TEXT[4] = Xiulian_ZhaoshiSkill_level4
	XIULIAN_MIJI_TEXT[5] = Xiulian_ZhaoshiSkill_level5
	XIULIAN_MIJI_TEXT[6] = Xiulian_ZhaoshiSkill_level6

end

-- OnEvent
function Xiulian_OnEvent(event)

	--if ( event == "OPEN_XIULIAN_PAGE" ) then
  if (event == "UI_COMMAND" and tonumber(arg0) == 20111212) then

	    if(this:IsVisible()) then
			this:Hide();
			return;
		end

	    local selfUnionPos = Variable:GetVariable("SelfUnionPos");
	    if(selfUnionPos ~= nil) then
		    Xiulian_Frame:SetProperty("UnifiedPosition", selfUnionPos);
    	end

	    XIULIAN_BOOK_SELECT = 1;
			XIULIAN_MIJI_SELECT = -1;
			this:Show();
			Xiulian_Update()

			Xiulian_SetTabState()
	end

	if( event == "PLAYER_LEAVE_WORLD") then
		this:Hide();
		return;
	end

	if( event == "UNIT_XIULIAN" ) then

	    for i = 1, 4 do
			local theAction = EnumAction(i - 1, "xiulianbook")
			if(theAction:GetID() ~= 0) then
				XIULIAN_BOOKS[i] : SetActionItem(theAction:GetID())
			end
		end
		Xiulian_JingJie_Selected_Update()
		Xiulian_Skill_Clicked_Update()
		Xiulian_SetSelectState()
	end

	if(event == "UINT_POWER" ) then
             --设置功力
            Xiulian_Gongli_Text:SetText("#{XL_XML_87}")
            local nPower =  Player:GetData("POWER")
	    Xiulian_Vigor:SetText(nPower.."/100")
	end
end


function Xiulian_SelfEquip_Page_Switch()

	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);

	OpenEquip(1);
	this:Hide();
end

function Xiulian_Pet_Switch()
	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);

	TogglePetPage();
	this:Hide();
end

function Xiulian_Ride_Switch()
	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);

	OpenRidePage();
	this:Hide();
end

function Xiulian_SelfData_Switch()
	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);

	SystemSetup:OpenPrivatePage("self");
	this:Hide();
end

function Xiulian_Blog_Switch()

	local strCharName =  Player:GetName();
	local strAccount =  Player:GetData("ACCOUNTNAME")
	Blog:OpenBlogPage(strAccount,strCharName,true);

end

function Xiulian_Xiulian_Switch()
    Xiulian_Xiulian:SetCheck(1)
end

function Xiulian_Other_Info_Page_Switch()
	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);

	OtherInfoPage();
	this:Hide();
end

function Xiulian_Wuhun_Switch()
	Variable:SetVariable("SelfUnionPos", Xiulian_Frame:GetProperty("UnifiedPosition"), 1);
	ToggleWuhunPage();
	this:Hide();
end

function Xiulian_SetTabState()
	Xiulian_SelfEquip:SetCheck(0)
	Xiulian_SelfData:SetCheck(0)
	Xiulian_Blog:SetCheck(0)
	Xiulian_Pet:SetCheck(0)
	Xiulian_Xiulian:SetCheck(1)
	Xiulian_Ride:SetCheck(0)
	Xiulian_OtherInfo:SetCheck(0)
end


function Xiulian_Xinfa_Clicked(nIndex)
	if(nIndex < 3) then
		XIULIAN_BOOK_SELECT = nIndex
		XIULIAN_MIJI_SELECT = -1
		Xiulian_JingJie_Selected_Update()
	else
	    PushDebugMessage("#{XL_090707_50}")
	end
end
--===============================================
-- 更新
--===============================================
function Xiulian_Update()
	for i = 1, 4 do
		local theAction = EnumAction(i - 1, "xiulianbook")
		if(theAction:GetID() ~= 0) then
			XIULIAN_BOOKS[i] : SetActionItem(theAction:GetID())
		end
	end
    Xiulian_JingJie_Selected_Update()
    --设置功力
    Xiulian_Gongli_Text:SetText("#{XL_XML_87}")
    local nPower =  Player:GetData("POWER")
	Xiulian_Vigor:SetText(nPower.."/100")
end

--===============================================
-- 关闭
--===============================================
function Xiulian_Close_Cilcked()
		this:Hide()
end

function Xiulian_Skill_Clicked(nIndex)
	if MIJI_CAN_SELECT == false then
		return
	end
	if(XIULIAN_BOOK_SELECT == 1) then
	   if (nIndex ~= 6)  then
         XIULIAN_MIJI_SELECT  = nIndex
	   else
	     XIULIAN_MIJI_SELECT  = -1
	   end
	elseif(XIULIAN_BOOK_SELECT == 2)  then
	     XIULIAN_MIJI_SELECT  = nIndex + 5
	else
         XIULIAN_MIJI_SELECT = -1
	end
	Xiulian_Skill_Clicked_Update()
end

function  Xiulian_Skill_Clicked_Update()
	Xiulian_SetSelectState()
    	--刷新中间图标
	if (XIULIAN_MIJI_SELECT ~= -1)   then
        --PushDebugMessage("Refresh XiuLian MiJi--"..XIULIAN_MIJI_SELECT)
		local	theAction = EnumAction(XIULIAN_MIJI_SELECT-1, "xiulianmiji")
		Xiulian_SkillIcon : SetActionItem(theAction:GetID())
		local XiuLianMiJiName = 0;--Player:GetXiuLianMiJiInfo(XIULIAN_MIJI_SELECT-1,"Name");
		local XiuLianMiJiJingJie = 0;--Player:GetXiuLianMiJiInfo(XIULIAN_MIJI_SELECT-1,"JingJie")
		local XiuLianMiJiLevel = 0;--Player:GetXiuLianMiJiInfo(XIULIAN_MIJI_SELECT-1,"Level")
		local CurMaxLevel = 0;--Player:GetXiuLianMiJiInfo(XIULIAN_MIJI_SELECT-1,"MaxLevel")
		local XiuLianMiJiExplain = 0;--Player:GetXiuLianMiJiInfo(XIULIAN_MIJI_SELECT-1,"Explain")

		local StrJingJie = "#{XL_XML_32}".."#{XL_XML_85}"..XiuLianMiJiJingJie.."#{XL_XML_86}"
		local StrDengJi = "#{XL_XML_33}"..XiuLianMiJiLevel.."/"..CurMaxLevel

		Xiulian_SkillName:SetText(XiuLianMiJiName);
		Xiulian_SkillJingjie:SetText(StrJingJie);
		Xiulian_SkillLevel:SetText(StrDengJi);
		local strCondition
		if(XIULIAN_BOOK_SELECT == 1) then
			if(Player:GetData("LEVEL") >= 70) then
				strCondition = "\n#G#{XL_XML_30}"
			else
				strCondition = "\n#cff0000#{XL_XML_30}"
			end
		else
			local XiuLianBook1Level = 0;--Player:GetXiuLianBookInfo(0,"Level")
			if (XiuLianBook1Level >= 3) then
				strCondition = "\n#G#{XL_XML_34}"
			else
				strCondition = "\n#cff0000#{XL_XML_34}"
			end
		end
		Xiulian_SkillInfo:SetText(XiuLianMiJiExplain.."\n#{XL_XML_31}"..strCondition);

	else
		if(XIULIAN_BOOK_SELECT == -1)	then
			Xiulian_SkillIcon : SetActionItem(-1)
		end
	end


end

--===============================================
-- 选择修炼境界后刷新
--===============================================
function  Xiulian_JingJie_Selected_Update()

    if XIULIAN_BOOK_SELECT == 1  then
		for i = 1, 5 do
			local theAction = EnumAction(i - 1, "xiulianmiji")
			if theAction ~= 0 then
				XIULIAN_MIJI[i] : SetActionItem(theAction:GetID())
				local CurMaxLevel  = 0;--Player:GetXiuLianMiJiInfo(i - 1,"MaxLevel")
				local XiuLianMiJiLevel = 0;--Player:GetXiuLianMiJiInfo(i - 1,"Level")
				if (CurMaxLevel == nil) or (XiuLianMiJiLevel == nil) then
					MIJI_CAN_SELECT =false
					return
				else
					MIJI_CAN_SELECT =true
				end
				XIULIAN_MIJI_TEXT[i]:SetText(XiuLianMiJiLevel.."/"..CurMaxLevel);
			end
		end
		XIULIAN_MIJI[6] : SetActionItem(-1)
		XIULIAN_MIJI_TEXT[6]:SetText("");
	elseif XIULIAN_BOOK_SELECT == 2  then
	    for i = 1, 6 do
			local theAction = EnumAction(i + 5 - 1, "xiulianmiji")
			if theAction ~= 0 then
		        XIULIAN_MIJI[i] : SetActionItem(theAction:GetID())
		        local CurMaxLevel = 0;--Player:GetXiuLianMiJiInfo(i + 5 - 1,"MaxLevel")
		        local XiuLianMiJiLevel = 0;--Player:GetXiuLianMiJiInfo(i + 5 - 1,"Level")
		        if (CurMaxLevel == nil) or (XiuLianMiJiLevel == nil) then
		        	MIJI_CAN_SELECT =false
					return
		        else
		        	MIJI_CAN_SELECT =true
				end
		        XIULIAN_MIJI_TEXT[i]:SetText(XiuLianMiJiLevel.."/"..CurMaxLevel);
			end
		end
	else
		for i=1, 6 do
	        XIULIAN_MIJI[i] : SetActionItem(-1)
	        XIULIAN_MIJI_TEXT[i]:SetText("")
		end
	end
	Xiulian_SetSelectState()
    	--刷新中间图标
	if (XIULIAN_BOOK_SELECT ~= -1)   then
		local theAction = EnumAction(XIULIAN_BOOK_SELECT-1, "xiulianbook")
		Xiulian_SkillIcon : SetActionItem(theAction:GetID())
		--PushDebugMessage("BOOK ID is --"..theAction:GetID())
		local XiuLianBookName = 0;--Player:GetXiuLianBookInfo(XIULIAN_BOOK_SELECT-1,"Name");
		local XiuLianBookLevel = 0;--Player:GetXiuLianBookInfo(XIULIAN_BOOK_SELECT-1,"Level")
		local XiuLianBookExplain = 0;--Player:GetXiuLianBookInfo(XIULIAN_BOOK_SELECT-1,"Explain")


		local StrJingJie = "#{XL_XML_29}".."#{XL_XML_85}"..XiuLianBookLevel.."#{XL_XML_86}"

		Xiulian_SkillName:SetText(XiuLianBookName);
		Xiulian_SkillJingjie:SetText(StrJingJie);
		Xiulian_SkillLevel:SetText("");
		local strCondition
		if(XIULIAN_BOOK_SELECT == 1) then
			if(Player:GetData("LEVEL") >= 70) then
				strCondition = "\n#G#{XL_XML_30}"
			else
				strCondition = "\n#cff0000#{XL_XML_30}"
			end
		else
			local XiuLianBook1Level = 0;--Player:GetXiuLianBookInfo(0,"Level")
			if (XiuLianBook1Level >= 3) then
				strCondition = "\n#G#{XL_XML_34}"
			else
				strCondition = "\n#cff0000#{XL_XML_34}"
			end
		end
		Xiulian_SkillInfo:SetText(XiuLianBookExplain.."\n#{XL_XML_31}"..strCondition);
	else
	    Xiulian_SkillIcon : SetActionItem(-1)
	end

end
--===============================================
-- 设置选中状态
--===============================================
function Xiulian_SetSelectState()

  	for i=1, 2 do
  	  if(i == XIULIAN_BOOK_SELECT) then
  	       XIULIAN_BOOKS[i]:SetPushed(1)
  	  else
  	       XIULIAN_BOOKS[i]:SetPushed(0)
  	  end
	end
	for i=1, 6 do
		if((XIULIAN_MIJI_SELECT <= 5 and i==XIULIAN_MIJI_SELECT) or (XIULIAN_MIJI_SELECT > 5 and i == XIULIAN_MIJI_SELECT - 5)) then
			XIULIAN_MIJI[i]:SetPushed(1);
		else
			XIULIAN_MIJI[i]:SetPushed(0);
		end
	end
end

-- H鄊 g鱥 khung Tu Luy?n Fake
function XiuLianPage()
	__isDisabledFunc();
	--PushDebugMessage("#{XL_090707_62}")
	--PushEvent("UI_COMMAND",20111212)
end
local xx = nil;
function Denaturalization_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	
	this:RegisterEvent("UNIT_DEF_COLD");				--防御属性
	this:RegisterEvent("UNIT_DEF_FIRE");
	this:RegisterEvent("UNIT_DEF_LIGHT");
	this:RegisterEvent("UNIT_DEF_POSION");

	this:RegisterEvent("UNIT_RESISTOTHER_COLD");			--减抗属性
	this:RegisterEvent("UNIT_RESISTOTHER_FIRE");
	this:RegisterEvent("UNIT_RESISTOTHER_LIGHT");
	this:RegisterEvent("UNIT_RESISTOTHER_POSION");
		
	this:RegisterEvent("UNIT_ATT_COLD");				--攻击属性
	this:RegisterEvent("UNIT_ATT_FIRE");
	this:RegisterEvent("UNIT_ATT_LIGHT");
	this:RegisterEvent("UNIT_ATT_POSION");
end

function Denaturalization_OnLoad()
	Denaturalization_CleanData();
end

function Denaturalization_OnEvent(event)
	if ( event == "UI_COMMAND" ) then
		if(tonumber(arg0) == 0147000) then
			Denaturalization_OnShow();
			this : Show();
			xx =  Get_XParam_INT(0)
			objCared = DataPool : GetNPCIDByServerID(xx);
			this:CareObject(objCared, 1, "Denaturalization");
			
		elseif (tonumber(arg0) == 0147005) then
			DoDenaturalization()
		end
		
	elseif(event == "UNIT_DEF_COLD" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_DEF_FIRE" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_DEF_LIGHT" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_DEF_POSION" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_RESISTOTHER_COLD" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_RESISTOTHER_FIRE" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_RESISTOTHER_LIGHT" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	elseif(event == "UNIT_RESISTOTHER_POSION" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
		
	--冰攻击
	elseif(event == "UNIT_ATT_COLD" and arg0 == "player") then
		Denaturalization_SetStateTooltip();	
	--火攻击
	elseif(event == "UNIT_ATT_FIRE" and arg0 == "player") then
		Denaturalization_SetStateTooltip();
	--电攻击
	elseif(event == "UNIT_ATT_LIGHT" and arg0 == "player") then
		Denaturalization_SetStateTooltip();
	--毒攻击
	elseif(event == "UNIT_ATT_POSION" and arg0 == "player") then
		Denaturalization_SetStateTooltip();
		
	end
end

---------------------------------------------------------------------------------
--
-- 设置状态tooltip
--
function Denaturalization_SetStateTooltip()

	-- 得到状态属性
	local iIceDefine  		= Player:GetData( "DEFENCECOLD" );
	local iFireDefine 		= Player:GetData( "DEFENCEFIRE" );
	local iThunderDefine	= Player:GetData( "DEFENCELIGHT" );
	local iPoisonDefine		= Player:GetData( "DEFENCEPOISON" );
	
	--不显示负抗性 add by hukai#48117
	if iIceDefine < 0 then
		iIceDefine = 0
	end
	if iFireDefine < 0 then
		iFireDefine = 0
	end
	if iThunderDefine < 0 then
		iThunderDefine = 0
	end
	if iPoisonDefine < 0 then
		iPoisonDefine = 0
	end
	
	local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
	local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
	local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
	local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
	
	local iIceResistOther	= Player:GetData( "RESISTOTHERCOLD" );
	local iFireResistOther= Player:GetData( "RESISTOTHERFIRE" );
	local iThunderResistOther	= Player:GetData( "RESISTOTHERLIGHT" );
	local iPoisonResistOther= Player:GetData( "RESISTOTHERPOISON" );
	
	Denaturalization_IceFastness:SetToolTip("B錸g c鬾g:"..tostring(iIceAttack).."#rKh醤g B錸g:"..tostring(iIceDefine).."#rGi鋗 kh醤g B錸g:"..tostring(iIceResistOther) );
	Denaturalization_FireFastness:SetToolTip("H鯽 c鬾g:"..tostring(iFireAttack).."#rKh醤g H鯽:"..tostring(iFireDefine).."#rGi鋗 kh醤g H鯽:"..tostring(iFireResistOther) );
	Denaturalization_ThunderFastness:SetToolTip("Huy玭 c鬾g:"..tostring(iThunderAttack).."#rKh醤g Huy玭:"..tostring(iThunderDefine).."#rGi鋗 kh醤g Huy玭:"..tostring(iThunderResistOther) );
	Denaturalization_PoisonFastness:SetToolTip("械c c鬾g:"..tostring(iPoisonAttack).."#rKh醤g 械c:"..tostring(iPoisonDefine).."#rGi鋗 kh醤g 械c:"..tostring(iPoisonResistOther) );
		
end

---------------------------------------------------------------------------------
--清空数据
--
function Denaturalization_CleanData()
	Denaturalization_FakeObject:SetFakeObject("");	

	Denaturalization_IceFastness:SetToolTip("");
	Denaturalization_FireFastness:SetToolTip("" );
	Denaturalization_ThunderFastness:SetToolTip("");
	Denaturalization_PoisonFastness:SetToolTip("");
end

---------------------------------------------------------------------------------
--OnShow
--
function Denaturalization_OnShow()
	Player : CreateDenaObj();
	Denaturalization_FakeObject:SetFakeObject("Denaturalization_MySelf");	
	
	Denaturalization_SetStateTooltip();

	local nNumber = Player:GetData( "LEVEL" );
	Denaturalization_Level : SetText(nNumber.." c")
end

----------------------------------------------------------------------------------
--
-- 选装玩家模型（向左)
--
function Denaturalization_Modle_TurnLeft(start)
	--向左旋转开始
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		Denaturalization_FakeObject:RotateBegin(-0.3);
	--向左旋转结束
	else
		Denaturalization_FakeObject:RotateEnd();
	end
end

----------------------------------------------------------------------------------
--
-- 选装玩家模型（向右)
--
function Denaturalization_Modle_TurnRight(start)
	--向右旋转开始
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		Denaturalization_FakeObject:RotateBegin(0.3);
	--向右旋转结束
	else
		Denaturalization_FakeObject:RotateEnd();
	end
end

function Denaturalization_Cancel_Click()
	this : Hide();
end

function DoDenaturalization()
	if(this : IsVisible()) then
		PushDebugMessage("Thao t醕 d� th叨ng !");
		this:Hide();
		return;
	end
	

	local isCan = Player : CheckIfCanDena(30900048);
	if(isCan == -1) then
		PushDebugMessage("Thao t醕 d� th叨ng !");
		return;
	end
	
	--弹出确认框
	
	
	if(isCan == 5)then
		PushDebugMessage("Bg h鎢 thi猽 s髏 v ph Chuy琻 T韓h 衋n, ho l� Chuy琻 T韓h 衋n c黙 bg h鎢 疸 kh骯.")
		return;
	end
	if(isCan == 1)then
		PushDebugMessage("Trong tr課g th醝 c咿i kh鬾g th� th馽 hi畁 疬㧟 thao t醕 Chuy琻 T韓h !")
		return;
	end
	if(isCan == 2)then
		PushDebugMessage("Trong tr課g th醝 b鄖 b醤 kh鬾g th� th馽 hi畁 疬㧟 thao t醕 Chuy琻 T韓h !")
		return;
	end
	if(isCan == 3)then
		PushDebugMessage("Trong tr課g th醝 th� c咿i, th� m kh鬾g th� th馽 hi畁 疬㧟 thao t醕 Chuy琻 T韓h !")
		return;
	end

	if(isCan == 4)then
		PushDebugMessage("Trong tr課g th醝 t� 鸬i kh鬾g th� th馽 hi畁 疬㧟 thao t醕 Chuy琻 T韓h !")
		return;
	end
	--取得变性数据
	local sex,hairColor,hairModle,faceModle,nFaceId = Player : GetDenaAttr();
	--调函数去也
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnZhuanXingConfirm");
		Set_XSCRIPT_ScriptID(0147);
		Set_XSCRIPT_Parameter(0,tonumber(xx));
		Set_XSCRIPT_Parameter(1,tonumber(sex));
		Set_XSCRIPT_Parameter(2,tonumber(hairColor));
		Set_XSCRIPT_Parameter(3,tonumber(hairModle));
		Set_XSCRIPT_Parameter(4,tonumber(faceModle));
		Set_XSCRIPT_Parameter(5,tonumber(nFaceId));
		Set_XSCRIPT_ParamCount(6);
	Send_XSCRIPT();
end

function Denaturalization_OK_Click()
	--请求确认界面
	Clear_XSCRIPT();
		Set_XSCRIPT_ScriptID(0147);
		Set_XSCRIPT_Function_Name("OnZhuanXingRequest");
		Set_XSCRIPT_Parameter(0,tonumber(xx));
		Set_XSCRIPT_ParamCount(1);
	Send_XSCRIPT();
	--保存变性数据
	Player : SaveDenaAttr();
	this:Hide();
end

function Denaturalization_OnHide()
	Denaturalization_CleanData();
end
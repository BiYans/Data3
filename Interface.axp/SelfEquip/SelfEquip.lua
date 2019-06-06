local GK_Am = "*00*00*00*00*";
-- ���ݳ��ж����װ������.
--HEQUIP_WEAPON		=0,		//����	WEAPON
--HEQUIP_CAP			=1,		//ñ��	DEFENCE
--HEQUIP_ARMOR		=2,		//�·�	DEFENCE
--HEQUIP_CUFF			=3,		//����	DEFENCE
--HEQUIP_BOOT			=4,		//Ь	DEFENCE
--HEQUIP_SASH			=5,		//����	ADORN
--HEQUIP_RING			=6,		//��ָ	ADORN
--HEQUIP_NECKLACE	=7,		//����	ADORN
--HEQUIP_RIDER		=8,		//����	ADORN
--HEQUIP_BAG			=9,		//����
--HEQUIP_BOX			=10,	//���
--HEQUIP_RING_2		=11,	//�ڶ�����ָ	ADORN
--HEQUIP_CHARM		=12,	//����				ADORN
--HEQUIP_CHARM_2	=13,	//�ڶ�������	ADORN
--HEQUIP_WRIST		=14,	//����				ADORN
--HEQUIP_SHOULDER	=15,	//����				DEFENCE
--HEQUIP_DRESS		=16,	//ʱװ				DEFENCE
--HEQUIP_RESERVE	=17,	//Ԥ��1
--HEQUIP_RESERVE_2=18,	//Ԥ��2


--------------------------------------------------------------------------------
-- װ����ť���ݶ���
--
local  g_WEAPON;		--����
local  g_ARMOR;			--�·�
local  g_CAP;				--ñ��
local  g_CUFF;			--����
local  g_BOOT;			--Ь
local  g_RING;			--��ָ
local  g_SASH;			--����
local  g_NECKLACE;	--����
local  g_Dark;			--����
local  g_RING_2;		--��ָ2
local  g_CHARM;			--����
local  g_CHARM_2;		--����2
local  g_WRIST;			--����
local  g_SHOULDER;	--����
local  g_DRESS;			--ʱװ

local  g_EquipMask ={}
---------------------------------------------------------------------------------
-- ��������
--

local g_RemainPoint 			= 0;	-- ʣ�����
local g_CurExperience 	  = 0;	-- ��ǰʣ�ྭ��
local g_RequireExperience = 0;  -- �������辭��

local g_AddStr = 0;					-- �����������ϵ�ʣ�����.
local g_AddSpr = 0;					-- �����������ϵ�ʣ�����.
local g_AddCon = 0;					-- �����������ϵ�ʣ�����.
local g_AddInt = 0;					-- �����ڶ����ϵ�ʣ�����.
local g_AddDex = 0;					-- ���������ϵ�ʣ�����.

local g_CurRemainPoint = 0;				-- ������ʣ�����


local g_AutoClick_BtnFlag = -1			-- 记录当�?鼠标左键是在哪个按钮按下
local g_AutoClickTimer_Step = 50		-- 多少时间(毫秒)模拟一次 Click �?作
local g_AutoClick_FunList = {}			-- 将公用一个 Timer 的回调功能函数放到一个数组
local g_AutoClick_Going = -1			-- 标志是�?�开始自动点击�?作(第一次LButton�?��?过X个Timer�?算开始, 也就是说是 g_AutoClickTimer_Step * X 的时候开始进行自动加, 这样为了防止本�?��?点击一下的结果点了好多下)

-- �Ƿ�򿪳ƺŽ���
local g_bOpenTitleDlg = 0;
local SELFEQUIP_TAB_TEXT = {};
local LEVEL_MAX_ENABLE =149;	--�������ȼ�

local g_PropertyTable = {}

local g_XiulianTipTable = {"#{XL_XML_90}","#{XL_XML_91}","#{XL_XML_92}","#{XL_XML_93}","#{XL_XML_94}"
,"#{XL_XML_95}","#{XL_XML_96}","#{XL_XML_97}","#{XL_XML_98}","#{XL_XML_99}"
,"#{XL_XML_100}"}

local m_ZhiZunAnimate = {}

function SelfEquip_PreLoad()

	-- �򿪽���
	this:RegisterEvent("OPEN_EQUIP");
	this:RegisterEvent("UI_COMMAND");
	--�뿪�������Զ��ر�
	this:RegisterEvent("PLAYER_LEAVE_WORLD");

	-- ����װ��
	this:RegisterEvent("REFRESH_EQUIP");

	this:RegisterEvent("UNIT_HP");
	this:RegisterEvent("UNIT_MAX_HP");
	this:RegisterEvent("UNIT_MP");
	this:RegisterEvent("UNIT_MAX_MP");
	this:RegisterEvent("UNIT_RAGE");			-- ע��ŭ��


	this:RegisterEvent("UNIT_EXP");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MAX_EXP");
	this:RegisterEvent("UNIT_STR");
	this:RegisterEvent("UNIT_SPR");
	this:RegisterEvent("UNIT_CON");
	this:RegisterEvent("UNIT_INT");
	this:RegisterEvent("UNIT_DEX");
	this:RegisterEvent("UNIT_POINT_REMAIN");
	this:RegisterEvent("UNIT_XIULIAN_STR");
	this:RegisterEvent("UNIT_XIULIAN_SPR");
	this:RegisterEvent("UNIT_XIULIAN_CON");
	this:RegisterEvent("UNIT_XIULIAN_INT");
	this:RegisterEvent("UNIT_XIULIAN_DEX");

	this:RegisterEvent("UNIT_ATT_PHYSICS");
	this:RegisterEvent("UNIT_ATT_MAGIC");
	this:RegisterEvent("UNIT_DEF_PHYSICS");
	this:RegisterEvent("UNIT_DEF_MAGIC");
	this:RegisterEvent("UNIT_HIT");
	this:RegisterEvent("UNIT_MISS");
	this:RegisterEvent("UNIT_CRITICAL_ATTACK");
	this:RegisterEvent("UNIT_CRITICAL_DEFENCE");
	this:RegisterEvent("CUR_TITLE_CHANGED"); 		--��ǰ�ƺŸı�
	this:RegisterEvent("UNIT_XIULIAN_ATT_PHYSICS");
	this:RegisterEvent("UNIT_XIULIAN_ATT_MAGIC");
	this:RegisterEvent("UNIT_XIULIAN_DEF_PHYSICS");
	this:RegisterEvent("UNIT_XIULIAN_DEF_MAGIC");
	this:RegisterEvent("UNIT_XIULIAN_HIT");
	this:RegisterEvent("UNIT_XIULIAN_MISS");

	this:RegisterEvent("UNIT_DEF_COLD");				--��������
	this:RegisterEvent("UNIT_DEF_FIRE");
	this:RegisterEvent("UNIT_DEF_LIGHT");
	this:RegisterEvent("UNIT_DEF_POSION");
	this:RegisterEvent("UNIT_MENPAI");

	this:RegisterEvent("UNIT_ATT_COLD");				--��������
	this:RegisterEvent("UNIT_ATT_FIRE");
	this:RegisterEvent("UNIT_ATT_LIGHT");
	this:RegisterEvent("UNIT_ATT_POSION");

	this:RegisterEvent("UNIT_RESISTOTHER_COLD");			--��������
	this:RegisterEvent("UNIT_RESISTOTHER_FIRE");
	this:RegisterEvent("UNIT_RESISTOTHER_LIGHT");
	this:RegisterEvent("UNIT_RESISTOTHER_POSION");

	this:RegisterEvent("UNIT_VIGOR");		-- ע�����ֵ
	this:RegisterEvent("UNIT_ENERGY");	-- ע�ᾫ��ֵ


	this:RegisterEvent("GUILD_SHOW_MYGUILDNAME"); --�����Ϣ����


	-- �ֶ����������ɹ�
	this:RegisterEvent("MANUAL_ATTR_SUCCESS_EQUIP");

	this:RegisterEvent("UPDATE_DUR");

	this:RegisterEvent("SEX_CHANGED");
end

function SelfEquip_OnLoad()

	-- action buttion ��ť
	g_WEAPON   = SelfEquip_11;		--����
	g_ARMOR    = SelfEquip_12;		--�·�
	g_CAP      = SelfEquip_1;		--ñ��
	g_CUFF     = SelfEquip_4;		--����
	g_BOOT     = SelfEquip_6;		--Ь
	g_RING     = SelfEquip_7;		--��ָ
	g_SASH     = SelfEquip_5;		--����
	g_NECKLACE = SelfEquip_13;		--����
	g_Dark	   = SelfEquip_14;		--����
	g_RING_2	 = SelfEquip_8;		--��ָ2
	g_CHARM		 = SelfEquip_9;		--����
	g_CHARM_2	 = SelfEquip_10;		--����2
	g_WRIST		 = SelfEquip_3;		--����
	g_SHOULDER = SelfEquip_2;		--����
	g_DRESS		 = SelfEquip_15;		--ʱװ

	g_EquipMask[0]	= SelfEquip_11_Mask;
	g_EquipMask[2]	= SelfEquip_12_Mask;
	g_EquipMask[1]	= SelfEquip_1_Mask;
	g_EquipMask[3]	= SelfEquip_4_Mask;
	g_EquipMask[4]	= SelfEquip_6_Mask;
	g_EquipMask[6]	= SelfEquip_7_Mask;
	g_EquipMask[5]	= SelfEquip_5_Mask;
	g_EquipMask[7]	= SelfEquip_13_Mask;
	--g_EquipMask[8]	= SelfEquip_25_Mask;
	g_EquipMask[11]	= SelfEquip_8_Mask;
	g_EquipMask[12]	= SelfEquip_9_Mask;
	g_EquipMask[13]	= SelfEquip_10_Mask;
	g_EquipMask[14]	= SelfEquip_3_Mask;
	g_EquipMask[15]	= SelfEquip_2_Mask;
	g_EquipMask[16]	= SelfEquip_15_Mask;
	g_EquipMask[17]	= SelfEquip_14_Mask;

	g_PropertyTable[1] = SelfEquip_Str_Plus;
	g_PropertyTable[2] = SelfEquip_Nimbus_Plus;
	g_PropertyTable[3] = SelfEquip_PhysicalStrength_Plus;
	g_PropertyTable[4] = SelfEquip_Stability_Plus;
	g_PropertyTable[5] = SelfEquip_Footwork_Plus;
	g_PropertyTable[6] = SelfEquip_Perporty1_Plus;
	g_PropertyTable[7] = SelfEquip_Perporty2_Plus;
	g_PropertyTable[8] = SelfEquip_Perporty3_Plus;
	g_PropertyTable[9] = SelfEquip_Perporty4_Plus;
	g_PropertyTable[10] = SelfEquip_Perporty7_Plus;
	g_PropertyTable[11] = SelfEquip_Perporty6_Plus;


	g_AutoClick_FunList[1] = SelfEquip_Add1_Click
	g_AutoClick_FunList[2] = SelfEquip_Add2_Click
	g_AutoClick_FunList[3] = SelfEquip_Add3_Click
	g_AutoClick_FunList[4] = SelfEquip_Add4_Click
	g_AutoClick_FunList[5] = SelfEquip_Add5_Click
	g_AutoClick_FunList[6] = SelfEquip_Dec1_Click
	g_AutoClick_FunList[7] = SelfEquip_Dec2_Click
	g_AutoClick_FunList[8] = SelfEquip_Dec3_Click
	g_AutoClick_FunList[9] = SelfEquip_Dec4_Click
	g_AutoClick_FunList[10] = SelfEquip_Dec5_Click

	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = -1

	SELFEQUIP_TAB_TEXT = {
		[0] = "а",
		"Nh�n",
		"Th�",
		"K�",
		"Kh�c",
	};

	m_ZhiZunAnimate[0]	= SelfEquip_11_Animate;
	m_ZhiZunAnimate[2]	= SelfEquip_12_Animate;
	m_ZhiZunAnimate[1]  = SelfEquip_1_Animate;
	m_ZhiZunAnimate[3]	= SelfEquip_4_Animate;
	m_ZhiZunAnimate[4]	= SelfEquip_6_Animate;
	m_ZhiZunAnimate[6]	= SelfEquip_7_Animate;
	m_ZhiZunAnimate[5]	= SelfEquip_5_Animate;
	m_ZhiZunAnimate[7]	= SelfEquip_13_Animate;
	--m_ZhiZunAnimate[8]	= SelfEquip_25_Animate;
	m_ZhiZunAnimate[11]	= SelfEquip_8_Animate;
	m_ZhiZunAnimate[12]	= SelfEquip_9_Animate;
	m_ZhiZunAnimate[13]	= SelfEquip_10_Animate;
	m_ZhiZunAnimate[14]	= SelfEquip_3_Animate;
	m_ZhiZunAnimate[15]	= SelfEquip_2_Animate;
	m_ZhiZunAnimate[16]	= SelfEquip_15_Animate;
	m_ZhiZunAnimate[17]	= SelfEquip_14_Animate;

end

-- OnEvent
function SelfEquip_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 74130100 then
		Player:SendAskManualAttr(1, 1, 1, 1, 1);
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 74130101 then
		GK_Am = Get_XParam_STR(0);
		SelfEquip_SetStateTooltip();
	end

	-- ��ʾtooltip
	SelfEquip_SetStateTooltip();

	if ( event == "OPEN_EQUIP" ) then

		if(this:IsVisible()) then
			SelfEquip_Close();
			return;
		end
		SelfEquip_Open();


		SelfEquip_FakeObject:SetFakeObject("Player");
		local selfUnionPos = Variable:GetVariable("SelfUnionPos");
		if(selfUnionPos ~= nil) then
			SelfEquip_Frame:SetProperty("UnifiedPosition", selfUnionPos);
		end

		Equip_OnUpdateShow();
		Equip_RefreshEquip();

		--�ڴ򿪵�ʱ�򣬽�����ҳ��ȱʡҳ���е���
		SelfEquip_SelfEquip:SetCheck(1);
		SelfEquip_SelfData:SetCheck(0);
		SelfEquip_Pet:SetCheck(0);

		-- ��ʾ����
		SelfEquip_ShowVigor();

		-- ��ʾ����
		SelfEquip_ShowEnergy();
		SelfEquip_SetTabColor(0);
	end

	if( event == "PLAYER_LEAVE_WORLD") then
		SelfEquip_Close();
		return;
	end
	--[[
	if("CUR_TITLE_CHANGED" == event) then
	GetCurTitle();
	return;
end

if(event == "GUILD_SHOW_MYGUILDNAME") then
GetGuildTitle();
return;
end
--]]
-- װ���仯ʱˢ��װ��.
	if("REFRESH_EQUIP" == event) then
		Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("ReloadPoint")
		Set_XSCRIPT_ScriptID(741301)
		Set_XSCRIPT_ParamCount(0)
		Send_XSCRIPT();
		Equip_RefreshEquip();
	end

	if("MANUAL_ATTR_SUCCESS_EQUIP" == event) then

		-- �������Գɹ�.
		SelfEquip_ManualAttr_Success();
		--AxTrace( 0,0, "even  ��������ɹ� ====  "..tostring(event));

		-- �����ֶ����ڵ�����ť��״̬.
		SetAcceptButtonState();

		Equip_OnUpdateShow();
		return;
	end

--�����¼����ڴ��ڴ�ʱ
if(this:IsVisible()) then

	local nNumber=0;
	local nMaxnumber=0;
	local strName;
	--AxTrace( 0,0, "even ===="..tostring(event));
	-- �ȼ�
	if ((event == "UNIT_LEVEL" or event == "UNIT_MAX_EXP") and arg0 == "player") then
		--nNumber = Player:GetData( "LEVEL" );
		--SelfEquip_Level:SetText( "Level " .. tostring( nNumber ) );
		--nNumber = Player:GetData("NEEDEXP");
		--SelfEquip_Exp1:SetText( tostring( nNumber ) );
		-- ˢ��������Ϣ
		Equip_OnUpdateShow();

		-- Ѫ
	elseif((event == "UNIT_HP" or event == "UNIT_MAX_HP")  and arg0 == "player") then
		nNumber = Player:GetData("HP");
		nMaxnumber = Player:GetData( "MAXHP" );

		local strHpText = tostring( nNumber ).."/"..tostring( nMaxnumber );
		strHpText = "#cFAFFA4"..strHpText;
		SelfEquip_HP:SetText( strHpText );
		-- mana
	elseif((event == "UNIT_MP" or event == "UNIT_MAX_MP")  and arg0 == "player") then
		nNumber = Player:GetData( "MP" );
		nMaxnumber = Player:GetData( "MAXMP" );

		local strMpText = tostring( nNumber ).."/"..tostring( nMaxnumber ) ;
		strMpText = "#cFAFFA4"..strMpText;
		SelfEquip_MP:SetText( strMpText );

		-- ŭ��
	elseif((event == "UNIT_RAGE" )  and arg0 == "player") then
		-- ŭ��
		nNumber = Player:GetData("RAGE");
		nMaxnumber = Player:GetData("MAXRAGE");

		local strRageText = tostring( nNumber ).."/"..tostring( nMaxnumber );
		strRageText = "#cFAFFA4"..strRageText;
		SelfEquip_SP:SetText(strRageText );
		--����ֵ
	elseif(event == "UNIT_EXP" and arg0 == "player") then
		nNumber = Player:GetData("EXP");
		SelfEquip_Exp2:SetText( "#cC8B88E"..tostring( nNumber ) );

		-- �õ�������Ҫ�ľ���
		g_RequireExperience = Player:GetData("NEEDEXP");
		SelfEquip_Exp1:SetText( "#cC8B88E"..tostring( g_RequireExperience ) );

		-- ���ݾ����ֹ���ߴ�����
		if(nNumber >= g_RequireExperience and tonumber(Player:GetData("LEVEL"))<LEVEL_MAX_ENABLE) then

			SelfEquip_UpLevel:Enable();
		else

			SelfEquip_UpLevel:Disable();
		end


		--STR
	elseif(event == "UNIT_STR" and arg0 == "player") then
		nNumber = Player:GetData("STR");
		SelfEquip_Str:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_STR" and arg0 == "player") then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_STR");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Str_Plus:SetText( StrText );
		else
			SelfEquip_Str_Plus:SetText("");
		end


		--SPR
	elseif(event == "UNIT_SPR" and arg0 == "player") then
		nNumber = Player:GetData("SPR");
		SelfEquip_Nimbus:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_SPR" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_SPR");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Nimbus_Plus:SetText( StrText );
		else
			SelfEquip_Nimbus_Plus:SetText("");
		end

		--CON
	elseif(event == "UNIT_CON" and arg0 == "player") then
		nNumber = Player:GetData("CON");
		SelfEquip_PhysicalStrength:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_CON" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_CON");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_PhysicalStrength_Plus:SetText( StrText );
		else
			SelfEquip_PhysicalStrength_Plus:SetText("");
		end

		--INT
	elseif(event == "UNIT_INT" and arg0 == "player") then
		nNumber = Player:GetData("INT");
		SelfEquip_Stability:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_INT" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_INT");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Stability_Plus:SetText( StrText );
		else
			SelfEquip_Stability_Plus:SetText("");
		end

		--DEX
	elseif(event == "UNIT_DEX" and arg0 == "player") then
		nNumber = Player:GetData("DEX");
		SelfEquip_Footwork:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_DEX" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_DEX");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Footwork_Plus:SetText( StrText );
		else
			SelfEquip_Footwork_Plus:SetText("");
		end
		--POINT_REMAIN
	elseif(event == "UNIT_POINT_REMAIN" and arg0 == "player") then
		-- �������Ե�ķ���
		SelfEquip_ResetCharRemainPoint();

		--ATT_PHYSICS
	elseif(event == "UNIT_ATT_PHYSICS" and arg0 == "player") then
		nNumber = Player:GetData("ATT_PHYSICS");
		SelfEquip_Perporty1:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_ATT_PHYSICS" and arg0 == "player") then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_ATTP");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty1_Plus:SetText( StrText );
		else
			SelfEquip_Perporty1_Plus:SetText("");
		end
		--DEF_PHYSICS
	elseif(event == "UNIT_DEF_PHYSICS" and arg0 == "player") then
		nNumber = Player:GetData("DEF_PHYSICS");
		if nNumber > 999999 then --Ϊ��ս�޸ĵ� modified by hukai
			SelfEquip_Perporty3:SetText( "??????" );
		else
			SelfEquip_Perporty3:SetText( tostring( nNumber ) );
		end

	elseif(event == "UNIT_XIULIAN_DEF_PHYSICS" and arg0 == "player") then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_DEFP");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty3_Plus:SetText( StrText );
		else
			SelfEquip_Perporty3_Plus:SetText("");
		end
		--ATT_MAGIC
	elseif(event == "UNIT_ATT_MAGIC" and arg0 == "player") then
		nNumber = Player:GetData("ATT_MAGIC");
		SelfEquip_Perporty2:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_ATT_MAGIC" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_ATTM");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty2_Plus:SetText( StrText );
		else
			SelfEquip_Perporty2_Plus:SetText("");
		end

		--DEF_MAGIC
	elseif(event == "UNIT_DEF_MAGIC" and arg0 == "player") then
		nNumber = Player:GetData("DEF_MAGIC");
		if nNumber > 999999 then --Ϊ��ս�޸ĵ� modified by hukai
			SelfEquip_Perporty4:SetText( "??????" );
		else
			SelfEquip_Perporty4:SetText( tostring( nNumber ) );
		end

	elseif(event == "UNIT_XIULIAN_DEF_MAGIC" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_DEFM");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty4_Plus:SetText( StrText );
		else
			SelfEquip_Perporty4_Plus:SetText("");
		end


		--UNIT_HUIXINFANGYU
		--		elseif(event == "UNIT_MISS" and arg0 == "player") then
		--			nNumber = Player:GetData("MISS");
		--			SelfEquip_Perporty5:SetText( tostring( nNumber ) );

		--UNIT_MISS
	elseif(event == "UNIT_MISS" and arg0 == "player") then
		nNumber = Player:GetData("MISS");
		SelfEquip_Perporty6:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_MISS" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_MISS");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty6_Plus:SetText( StrText );
		else
			SelfEquip_Perporty6_Plus:SetText("");
		end

		--UNIT_HIT
	elseif(event == "UNIT_HIT" and arg0 == "player") then
		nNumber = Player:GetData("HIT");
		SelfEquip_Perporty7:SetText( tostring( nNumber ) );

	elseif(event == "UNIT_XIULIAN_HIT" and arg0 == "player" ) then
		if(Player:GetData("XIULIANFLAG") > 0) then
			nNumber = Player:GetData("XIULIAN_HIT");
			local StrText = "#H+" .. tostring( nNumber );
			SelfEquip_Perporty7_Plus :SetText( StrText );
		else
			SelfEquip_Perporty7_Plus :SetText("");
		end

		--UNIT_CRITICAL_ATTACK
	elseif(event == "UNIT_CRITICAL_ATTACK" and arg0 == "player") then
		nNumber = Player:GetData("CRITICALATTACK");
		SelfEquip_Perporty8:SetText( tostring( nNumber ) );

		--UNIT_CRITICAL_DEFENCE
	elseif(event == "UNIT_CRITICAL_DEFENCE" and arg0 == "player") then
		nNumber = Player:GetData("CRITICALDEFENCE");
		SelfEquip_Perporty9:SetText( tostring( nNumber ) );

		--������
	elseif(event == "UNIT_DEF_COLD" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--�����
	elseif(event == "UNIT_DEF_FIRE" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--�����
	elseif(event == "UNIT_DEF_LIGHT" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--������
	elseif(event == "UNIT_DEF_POSION" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--������
	elseif(event == "UNIT_RESISTOTHER_COLD" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--����
	elseif(event == "UNIT_RESISTOTHER_FIRE" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--���翹
	elseif(event == "UNIT_RESISTOTHER_LIGHT" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--������
	elseif(event == "UNIT_RESISTOTHER_POSION" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

		--������
	elseif(event == "UNIT_ATT_COLD" and arg0 == "player") then
		SelfEquip_SetStateTooltip();
		--�𹥻�
	elseif(event == "UNIT_ATT_FIRE" and arg0 == "player") then
		SelfEquip_SetStateTooltip();
		--�繥��
	elseif(event == "UNIT_ATT_LIGHT" and arg0 == "player") then
		SelfEquip_SetStateTooltip();
		--������
	elseif(event == "UNIT_ATT_POSION" and arg0 == "player") then
		SelfEquip_SetStateTooltip();

	elseif(event == "UNIT_VIGOR" and arg0 == "player") then

		SelfEquip_ShowVigor();

	elseif(event == "UNIT_ENERGY" and arg0 == "player") then

		SelfEquip_ShowEnergy();
	elseif( event == "UPDATE_DUR" ) then
		SelfEquip_UpdateMask();
	else

		-- ��ҪĬ�ϵ�����µ������������ ��������Ե���Ī�������ˢ�¡�
		-- 2006-3-23
		--Equip_OnUpdateShow();
	end;

	if event == "SEX_CHANGED"  then
		SelfEquip_FakeObject : Hide();
		SelfEquip_FakeObject : Show();
		SelfEquip_FakeObject:SetFakeObject("Player");
	end
	return;
end

-- �����¼�����������Ļ�����Ϣ.
--Equip_OnUpdateShow();

end

-- �������ǻ�����Ϣ
function Equip_OnUpdateShow()



	g_RemainPoint 			= 0;	-- ʣ�����
	g_CurExperience 	  = 0;	-- ��ǰʣ�ྭ��
	g_RequireExperience = 0;  -- �������辭��

	g_AddStr = 0;					-- �����������ϵ�ʣ�����.
	g_AddSpr = 0;					-- �����������ϵ�ʣ�����.
	g_AddCon = 0;					-- �����������ϵ�ʣ�����.
	g_AddInt = 0;					-- �����ڶ����ϵ�ʣ�����.
	g_AddDex = 0;					-- ���������ϵ�ʣ�����.
	g_CurRemainPoint = 0;	-- ������ʣ�����


	local nNumber=0;
	local nMaxnumber=0;
	local strName;

	-- ��ֹ����Ǳ�ܰ�ť.
	Equip_Addition_Button1:Disable();
	Equip_Decrease_Button1:Disable();

	Equip_Addition_Button2:Disable();
	Equip_Decrease_Button2:Disable();

	Equip_Addition_Button3:Disable();
	Equip_Decrease_Button3:Disable();

	Equip_Addition_Button4:Disable();
	Equip_Decrease_Button4:Disable();

	Equip_Addition_Button5:Disable();
	Equip_Decrease_Button5:Disable();

	-- ����ť
	-- SelfEquip_Accept:Enalbe();

	-- ��ֹ���Ӱ�ť
	-- SelfEquip_Accept:Disable();

	-- �õ��Լ�������
	strName = Player:GetName();
	SelfEquip_PageHeader:SetText("#gFF0FA0"..strName);

	-- �õ�Ѫֵ
	nNumber = Player:GetData("HP");
	nMaxnumber = Player:GetData( "MAXHP" );
	local HPText = tostring( nNumber ).."/"..tostring( nMaxnumber );
	HPText = "#cFAFFA4"..HPText;
	SelfEquip_HP:SetText( HPText );


	-- �õ�ħ��ֵ
	nNumber = Player:GetData( "MP" );
	nMaxnumber = Player:GetData( "MAXMP" );

	local MPText = tostring( nNumber ).."/"..tostring( nMaxnumber );
	MPText = "#cFAFFA4"..MPText;
	SelfEquip_MP:SetText( MPText );

	-- ŭ��
	nNumber = Player:GetData("RAGE");
	nMaxnumber = Player:GetData("MAXRAGE");
	local RageText = tostring( nNumber ).."/"..tostring( nMaxnumber );
	RageText = "#cFAFFA4"..RageText;
	SelfEquip_SP:SetText( RageText );

	-- �õ���ǰ����
	g_CurExperience = Player:GetData("EXP");
	local CurExpText = tostring( g_CurExperience );
	CurExpText = "#cC8B88E"..CurExpText;
	SelfEquip_Exp2:SetText( CurExpText );

	-- �õ�������Ҫ�ľ���
	g_RequireExperience = Player:GetData("NEEDEXP");
	local NeedExpText =  tostring( g_RequireExperience );
	NeedExpText = "#cC8B88E"..NeedExpText;
	SelfEquip_Exp1:SetText( NeedExpText );

	-- ���ݾ����ֹ���ߴ�����
	if(g_CurExperience >= g_RequireExperience) then

		SelfEquip_UpLevel:Enable();
	else

		SelfEquip_UpLevel:Disable();
	end

	-- �õ��ȼ�
	nNumber = Player:GetData( "LEVEL" );
	local LevelText = "C�p "..tostring( nNumber );
	LevelText = "#cC8B88E"..LevelText;
	SelfEquip_Level:SetText( LevelText );

	-- ����ȼ�����ĳֵ��ֹ��ť.
	if( LEVEL_MAX_ENABLE <= nNumber ) then
		SelfEquip_UpLevel:Disable();
	end

	-- ����
	nNumber = Player:GetData("STR");
	local StrText = tostring( nNumber );
	--StrText = "#DED784"..StrText;
	SelfEquip_Str:SetText( StrText );

	-- ����
	nNumber = Player:GetData("SPR");
	local SprText = tostring( nNumber );
	--SprText = "#DED784"..SprText;
	SelfEquip_Nimbus:SetText( SprText );

	-- ����
	nNumber = Player:GetData("CON");
	local ConText = tostring( nNumber );
	SelfEquip_PhysicalStrength:SetText( ConText );


	-- ����
	nNumber = Player:GetData("INT");
	SelfEquip_Stability:SetText( tostring( nNumber ) );

	-- ��
	nNumber = Player:GetData("DEX");
	SelfEquip_Footwork:SetText( tostring( nNumber ) );

	-- ʣ�����
	g_RemainPoint = Player:GetData("POINT_REMAIN");
	SelfEquip_Potential:SetText( tostring( g_RemainPoint ) );
	--AxTrace( 0,0, "�õ�ʣ�����"..tostring( g_RemainPoint ));
	g_CurRemainPoint = g_RemainPoint;

	if(g_CurRemainPoint > 0) then

		Equip_Addition_Button1:Enable();
		Equip_Addition_Button2:Enable();
		Equip_Addition_Button3:Enable();
		Equip_Addition_Button4:Enable();
		Equip_Addition_Button5:Enable();

	end;


	-- ������
	nNumber = Player:GetData("ATT_PHYSICS");
	SelfEquip_Perporty1:SetText( tostring( nNumber ) );

	-- �������
	nNumber = Player:GetData("DEF_PHYSICS");
	if nNumber > 999999 then --Ϊ��ս�޸ĵ� modified by hukai
		SelfEquip_Perporty3:SetText( "??????" );
	else
		SelfEquip_Perporty3:SetText( tostring( nNumber ) );
	end

	-- ħ������
	nNumber = Player:GetData("ATT_MAGIC");
	SelfEquip_Perporty2:SetText( tostring( nNumber ) );

	-- ħ������
	nNumber = Player:GetData("DEF_MAGIC");
	if nNumber > 999999 then --Ϊ��ս�޸ĵ� modified by hukai
		SelfEquip_Perporty4:SetText( "??????" );
	else
		SelfEquip_Perporty4:SetText( tostring( nNumber ) );
	end

	-- ������
	nNumber = Player:GetData("MISS");
	SelfEquip_Perporty6:SetText( tostring( nNumber ) );

	-- ������
	nNumber = Player:GetData("HIT");
	SelfEquip_Perporty7:SetText( tostring( nNumber ) );

	--zhangqiang���������Լӳ�==============================
	if Player:GetData("XIULIANFLAG") > 0 then
		nNumber = Player:GetData("XIULIAN_STR");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Str_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_SPR");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Nimbus_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_CON");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_PhysicalStrength_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_INT");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Stability_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_DEX");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Footwork_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_HIT");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty7_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_ATTP");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty1_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_DEFP");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty3_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_ATTM");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty2_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_DEFM");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty4_Plus:SetText( StrText );

		nNumber = Player:GetData("XIULIAN_MISS");
		local StrText = "#H+" .. tostring( nNumber );
		SelfEquip_Perporty6_Plus:SetText( StrText );
	else
		SelfEquip_Str_Plus:SetText( "" );
		SelfEquip_Nimbus_Plus:SetText( "" );
		SelfEquip_PhysicalStrength_Plus:SetText( "" );
		SelfEquip_Stability_Plus:SetText( "" );
		SelfEquip_Footwork_Plus:SetText( "" );
		SelfEquip_Perporty7_Plus:SetText( "" );
		SelfEquip_Perporty1_Plus:SetText( "" );
		SelfEquip_Perporty3_Plus:SetText( "" );
		SelfEquip_Perporty2_Plus:SetText( "" );
		SelfEquip_Perporty4_Plus:SetText( "" );
		SelfEquip_Perporty6_Plus:SetText( "" );
	end
	--=======================================================

	-- ���Ĺ���
	nNumber = Player:GetData("CRITICALATTACK");
	SelfEquip_Perporty8:SetText( tostring( nNumber ) );

	SelfEquip_Perporty8_Plus:SetText( "" );

	-- ���ķ���
	nNumber = Player:GetData("CRITICALDEFENCE");
	SelfEquip_Perporty9:SetText( tostring( nNumber ) );

	SelfEquip_Perporty9_Plus:SetText( "" );

	-- ����
	SelfEquip_ShowVigor();

	-- ����
	SelfEquip_ShowEnergy();

	-- ����
	local menpai = Player:GetData("MEMPAI");
	local strName = "";

	-- �õ���������.
	if(0 == menpai) then
		strName = "Thi�u L�m";

	elseif(1 == menpai) then
		strName = "Minh Gi�o";

	elseif(2 == menpai) then
		strName = "C�i Bang";

	elseif(3 == menpai) then
		strName = "V� �ang";

	elseif(4 == menpai) then
		strName = "Nga My";

	elseif(5 == menpai) then
		strName = "Tinh T�c";

	elseif(6 == menpai) then
		strName = "Thi�n Long";

	elseif(7 == menpai) then
		strName = "Thi�n S�n";

	elseif(8 == menpai) then
		strName = "Ti�u Dao";

	elseif(9 == menpai) then
		strName = "Kh�ng c�";

	elseif(10 == menpai) then
		strName = "M� Dung";
	end

	-- ������ʾ������.
	SelfEquip_MenPai:SetText(strName);

	-- ���ð����ʾ
	--	GetGuildTitle();

	-- �õ��ƺ�
	--	GetCurTitle();

	-- �����ֶ����ڵ�����ť��״̬.
	SetAcceptButtonState();

end

-- ˢ��װ��
function Equip_RefreshEquip()


	--  ��հ�ť��ʾͼ��
	g_WEAPON:SetActionItem(-1);			--����
	g_CAP:SetActionItem(-1);				--ñ��
	g_ARMOR:SetActionItem(-1);			--����
	g_CUFF:SetActionItem(-1);				--����
	g_BOOT:SetActionItem(-1);				--Ь
	g_SASH:SetActionItem(-1);				--����
	g_RING:SetActionItem(-1);				--��ָ
	g_NECKLACE:SetActionItem(-1);		--����
	g_Dark:SetActionItem(-1);			--����
	g_RING_2:SetActionItem(-1);			--��ָ2
	g_CHARM:SetActionItem(-1);			--����
	g_CHARM_2:SetActionItem(-1);		--����2
	g_WRIST:SetActionItem(-1);			--����
	g_SHOULDER:SetActionItem(-1);		--����
	g_DRESS:SetActionItem(-1);			--ʱװ

	local ActionWeapon 		= EnumAction(0, "equip");
	local ActionCap    		= EnumAction(1, "equip");
	local ActionArmor  		= EnumAction(2, "equip");
	local ActionCuff   		= EnumAction(3, "equip");
	local ActionBoot   		= EnumAction(4, "equip");
	local ActionSash   		= EnumAction(5, "equip");
	local ActionRing    	= EnumAction(6, "equip");
	local ActionNecklace	= EnumAction(7, "equip");
	local ActionMount			= EnumAction(17, "equip");
	local ActionRing_2		= EnumAction(11, "equip");
	local ActionCharm 		= EnumAction(12, "equip");
	local ActionCharm_2   = EnumAction(13, "equip");
	local ActionWrist  		= EnumAction(14, "equip");
	local ActionShoulder  = EnumAction(15, "equip");
	local ActionDress   	= EnumAction(16, "equip");

	-- ��ʾ�����ϵ�����װ��
	g_WEAPON:SetActionItem(ActionWeapon:GetID());			--����
	g_CAP:SetActionItem(ActionCap:GetID());						--ñ��
	g_ARMOR:SetActionItem(ActionArmor:GetID());				--����
	g_CUFF:SetActionItem(ActionCuff:GetID());					--����
	g_BOOT:SetActionItem(ActionBoot:GetID());					--Ь
	g_SASH:SetActionItem(ActionSash:GetID());					--����
	g_RING:SetActionItem(ActionRing:GetID());					--����
	g_NECKLACE:SetActionItem(ActionNecklace:GetID());	--����
	g_Dark:SetActionItem(ActionMount:GetID());				--����
	g_RING_2:SetActionItem(ActionRing_2:GetID());			--��ָ2
	g_CHARM:SetActionItem(ActionCharm:GetID());			--����
	g_CHARM_2:SetActionItem(ActionCharm_2:GetID());		--����2
	g_WRIST:SetActionItem(ActionWrist:GetID());			--����
	g_SHOULDER:SetActionItem(ActionShoulder:GetID());		--����
	g_DRESS:SetActionItem(ActionDress:GetID());			--ʱװ

	local IsDisplay = SystemSetup:Get_Display_Dress();
	if IsDisplay == 1 then
		IsDisplay = 0
	else
		IsDisplay = 1
	end
	SelfEquip_Mode:SetCheck(IsDisplay);
	SelfEquip_UpdateMask();
end

function SelfEquip_Equip_Click( nTypeIn,buttonIn )

	local nType = tonumber( nTypeIn );
	local button = tonumber( buttonIn );
	if( nType == 11 ) then
		if( button == 1 ) then
			g_WEAPON:DoAction();	--����
		else
			g_WEAPON:DoSubAction();	--����
		end
	elseif( nType == 12 ) then
		if( button == 1 ) then
			g_ARMOR:DoAction();	--�·�
		else
			g_ARMOR:DoSubAction();	--�·�
		end
	elseif( nType == 1 ) then
		if( button == 1 ) then
			g_CAP:DoAction();	--ñ��
		else
			g_CAP:DoSubAction();	--ñ��
		end
	elseif( nType == 4 ) then
		if( button == 1 ) then
			g_CUFF:DoAction();	--����
		else
			g_CUFF:DoSubAction();	--����
		end
	elseif( nType == 6 ) then
		if( button == 1 ) then
			g_BOOT:DoAction();	--Ь
		else
			g_BOOT:DoSubAction();	--Ь
		end
	elseif( nType == 7 ) then
		if( button == 1 ) then
			g_RING:DoAction();	--��ָ
		else
			g_RING:DoSubAction();	--��ָ
		end
	elseif( nType == 5 ) then
		if( button == 1 ) then
			g_SASH:DoAction();	--����
		else
			g_SASH:DoSubAction();	--����
		end
	elseif( nType == 13) then
		if( button == 1 ) then
			g_NECKLACE:DoAction();	--����
		else
			g_NECKLACE:DoSubAction();	--����
		end
	elseif( nType == 14 ) then
		if( button == 1 ) then
			g_Dark:DoAction();	--����
		else
			g_Dark:DoSubAction();	--����
		end
	elseif( nType == 2 ) then
		if( button == 1 ) then
			g_SHOULDER:DoAction();	--����
		else
			g_SHOULDER:DoSubAction();	--����
		end
	elseif( nType == 3 ) then
		if( button == 1 ) then
			g_WRIST:DoAction();	--����
		else
			g_WRIST:DoSubAction();	--����
		end
	elseif( nType == 8 ) then
		if( button == 1 ) then
			g_RING_2:DoAction();	--��ָ2
		else
			g_RING_2:DoSubAction();	--��ָ
		end
	elseif( nType == 9 ) then
		if( button == 1 ) then
			g_CHARM:DoAction();	--����
		else
			g_CHARM:DoSubAction();	--����
		end
	elseif( nType == 10 ) then
		if( button == 1 ) then
			g_CHARM_2:DoAction();	--����2
		else
			g_CHARM_2:DoSubAction();	--����2
		end
	elseif( nType == 15 ) then
		if( button == 1 ) then
			g_DRESS:DoAction();	--ʱװ
		else
			g_DRESS:DoSubAction();	--ʱװ
		end
	end
end


----------------------------------------------------------------------------
-- ����������ť
--
-- ��������������ť
function SelfEquip_Dec1_Click()

	if (g_AddStr > 0) then
		g_CurRemainPoint = g_CurRemainPoint + 1;
		if(g_CurRemainPoint > 0) then
			EanblePointAddButtion();
		end;

		g_AddStr = g_AddStr - 1;
	end

	if(g_AddStr <= 0) then
		g_AddStr = 0;
		Equip_Decrease_Button1:Disable();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurStr();

end

-- ��������������ť
function SelfEquip_Add1_Click()

	if (g_CurRemainPoint > 0) then
		g_AddStr = g_AddStr + 1;
		if(g_AddStr > 0) then
			Equip_Decrease_Button1:Enable();
		end

		g_CurRemainPoint = g_CurRemainPoint - 1;
	end

	if(g_CurRemainPoint <= 0) then
		g_CurRemainPoint = 0;
		DisablePointAddButtion();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurStr();

end


-----------------------------------------------------------------------------
-- ����������ť
--
-- ��������������ť
function SelfEquip_Dec2_Click()

	if (g_AddSpr > 0) then
		g_CurRemainPoint = g_CurRemainPoint + 1;
		if(g_CurRemainPoint > 0) then
			EanblePointAddButtion();
		end

		g_AddSpr = g_AddSpr - 1;
	end

	if(g_AddSpr <= 0) then

		g_AddSpr = 0;
		Equip_Decrease_Button2:Disable();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurSpr();

end

-- ��������������ť
function SelfEquip_Add2_Click()

	if (g_CurRemainPoint > 0) then
		g_AddSpr = g_AddSpr + 1;
		if(g_AddSpr > 0) then
			Equip_Decrease_Button2:Enable();
		end

		g_CurRemainPoint = g_CurRemainPoint - 1;
	end

	if(g_CurRemainPoint <= 0) then
		g_CurRemainPoint = 0;
		DisablePointAddButtion();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurSpr();

end


-----------------------------------------------------------------------------
-- ���ʵ�����ť
--
-- �������ʵ�����ť
function SelfEquip_Dec3_Click()

	if (g_AddCon > 0) then
		g_CurRemainPoint = g_CurRemainPoint + 1;
		if(g_CurRemainPoint > 0) then
			EanblePointAddButtion();
		end

		g_AddCon = g_AddCon - 1;
	end

	if(g_AddCon <= 0) then

		g_AddCon = 0;
		Equip_Decrease_Button3:Disable();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurCon();


end

-- �������ʵ�����ť
function SelfEquip_Add3_Click()

	if (g_CurRemainPoint > 0) then
		g_AddCon = g_AddCon + 1;
		if(g_AddCon > 0) then
			Equip_Decrease_Button3:Enable();
		end

		g_CurRemainPoint = g_CurRemainPoint - 1;
	end

	if(g_CurRemainPoint <= 0) then
		g_CurRemainPoint = 0;
		DisablePointAddButtion();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurCon();

end


-------------------------------------------------------------------------------
-- ����������ť
--
-- ���ٶ���������ť
function SelfEquip_Dec4_Click()

	if (g_AddInt > 0) then
		g_CurRemainPoint = g_CurRemainPoint + 1;
		if(g_CurRemainPoint > 0) then
			EanblePointAddButtion();
		end

		g_AddInt = g_AddInt - 1;
	end

	if(g_AddInt <= 0) then

		g_AddInt = 0;
		Equip_Decrease_Button4:Disable();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurInt();

end

-- ���Ӷ���������ť
function SelfEquip_Add4_Click()

	if (g_CurRemainPoint > 0) then
		g_AddInt = g_AddInt + 1;
		if(g_AddInt > 0) then
			Equip_Decrease_Button4:Enable();
		end

		g_CurRemainPoint = g_CurRemainPoint - 1;
	end

	if(g_CurRemainPoint <= 0) then

		g_CurRemainPoint = 0;
		DisablePointAddButtion();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ����
	ShowCurInt();

end



--------------------------------------------------------------------------------
-- ��������ť
--
-- ������������ť
function SelfEquip_Dec5_Click()

	if (g_AddDex > 0) then
		g_CurRemainPoint = g_CurRemainPoint + 1;
		if(g_CurRemainPoint > 0) then
			EanblePointAddButtion();
		end

		g_AddDex = g_AddDex - 1;
	end

	if(g_AddDex <= 0) then

		g_AddDex = 0;
		Equip_Decrease_Button5:Disable();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ��
	ShowCurDex();

end

-- ������������ť
function SelfEquip_Add5_Click()

	if (g_CurRemainPoint > 0) then
		g_AddDex = g_AddDex + 1;
		if(g_AddDex > 0) then
			Equip_Decrease_Button5:Enable();
		end

		g_CurRemainPoint = g_CurRemainPoint - 1;
	end

	if(g_CurRemainPoint <= 0) then

		g_CurRemainPoint = 0;
		DisablePointAddButtion();
	end

	-- ��ʾ��ǰʣ��ĵ���
	ShowCurRemainPoint();

	-- ����ʣ�������ť״̬
	SetAcceptButtonState();

	-- ��ʾ��
	ShowCurDex();

end

--------------------------------------------------------------------------------
--
-- �����еĵ������Ӱ�ť
--
function EanbleAskAttrBn(bEnable)

	Equip_Addition_Button1:Enable();
	Equip_Addition_Button2:Enable();
	Equip_Addition_Button3:Enable();
	Equip_Addition_Button4:Enable();
	Equip_Addition_Button5:Enable();
end

--------------------------------------------------------------------------------
--
-- �����еĵ������Ӱ�ť
--
function EanblePointAddButtion()

	Equip_Addition_Button1:Enable();
	Equip_Addition_Button2:Enable();
	Equip_Addition_Button3:Enable();
	Equip_Addition_Button4:Enable();
	Equip_Addition_Button5:Enable();
end


--------------------------------------------------------------------------------
--
-- ��ֹ���еĵ������Ӱ�ť
--
function DisablePointAddButtion()

	Equip_Addition_Button1:Disable();
	Equip_Addition_Button2:Disable();
	Equip_Addition_Button3:Disable();
	Equip_Addition_Button4:Disable();
	Equip_Addition_Button5:Disable();
end


--------------------------------------------------------------------------------
--
-- �����еĵ������Ӱ�ť
--
function EanblePointDecButtion()

	Equip_Decrease_Button1:Enable();
	Equip_Decrease_Button2:Enable();
	Equip_Decrease_Button3:Enable();
	Equip_Decrease_Button4:Enable();
	Equip_Decrease_Button5:Enable();
end


--------------------------------------------------------------------------------
--
-- ��ֹ���еĵ������Ӱ�ť
--
function DisablePointDecButtion()

	Equip_Decrease_Button1:Disable();
	Equip_Decrease_Button2:Disable();
	Equip_Decrease_Button3:Disable();
	Equip_Decrease_Button4:Disable();
	Equip_Decrease_Button5:Disable();
end


---------------------------------------------------------------------------------
--
-- ��ʾ��ǰ��Ǳ��
--
function ShowCurRemainPoint()

	SelfEquip_Potential:SetText( tostring( g_CurRemainPoint ) );

end

---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function ShowCurStr()

	SelfEquip_Str:SetText( tostring( g_AddStr + Player:GetData("STR") ) );

end

---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function ShowCurSpr()

	SelfEquip_Nimbus:SetText( tostring( g_AddSpr + Player:GetData("SPR"))  );

end

---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function ShowCurCon()

	SelfEquip_PhysicalStrength:SetText( tostring( g_AddCon + Player:GetData("CON"))  );

end

---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function ShowCurInt()

	SelfEquip_Stability:SetText( tostring( g_AddInt + Player:GetData("INT"))  );

end

---------------------------------------------------------------------------------
--
-- ��ʾ��
--
function ShowCurDex()

	SelfEquip_Footwork:SetText( tostring( g_AddDex + Player:GetData("DEX"))  );

end



---------------------------------------------------------------------------------
--
-- ��ֹ, ������Ǳ�ܰ�ťǱ�ܰ�ť
--
function SetAcceptButtonState()

	if(g_CurRemainPoint == g_RemainPoint) then

		SelfEquip_Accept:Disable();
	else

		--SelfEquip_Accept:Disable();
		SelfEquip_Accept:Enable();
	end;

end

---------------------------------------------------------------------------------
--
-- ��������Ǳ��
--
function SelfEquip_Accept_Click()

	-- ���͸�����������.
	Player:SendAskManualAttr(g_AddStr, g_AddSpr, g_AddCon, g_AddInt, g_AddDex);
	--AxTrace( 0,0, "Ǳ�ܵ���"..tostring( g_AddStr ).."\n"..tostring( g_AddSpr ).."\n"..tostring( g_AddCon ).."\n"..tostring( g_AddInt ).."\n"..tostring(g_AddDex));

	-- ����ʹ��, �������Ҫװ������ϸ��Ϣ
	--AskEquipDetial();

end


---------------------------------------------------------------------------------
--
-- �ֶ������ɹ�
--
function SelfEquip_ManualAttr_Success()

	g_AddStr = 0;					-- �����������ϵ�ʣ�����.
	g_AddSpr = 0;					-- �����������ϵ�ʣ�����.
	g_AddCon = 0;					-- �����������ϵ�ʣ�����.
	g_AddInt = 0;					-- �����ڶ����ϵ�ʣ�����.
	g_AddDex = 0;					-- ���������ϵ�ʣ�����.

	-- ��ֹ���м��ٵ�����ť
	DisablePointDecButtion();

	-- ʣ��û�з���ĵ���
	g_RemainPoint = g_CurRemainPoint;
	if(g_CurRemainPoint > 0) then

		EanblePointAddButtion();
	end


end

---------------------------------------------------------------------------------
--
-- ����ƺŰ�ť
--
function TitleButton_Click()

	g_bOpenTitleDlg = 1;
	-- �򿪳ƺŽ���
	OpenTitleList();
	--AxTrace( 0,0, "�򿪳ƺŽ���");

end

----------------------------------------------------------------------------------
--
-- �����ᰴť
--
function OpenConfraternity_click()

	-- �򿪻�رհ�����.
	--Guild:AskGuildDetailInfo();
	Guild:ToggleGuildDetailInfo();
end


----------------------------------------------------------------------------------
--
-- �õ���ǰ��title
--
--[[
function GetCurTitle()

-- �õ���ǰ�ĳƺ�.
local strCurTitle = Player:GetCurTitle();
SelfEquip_Agname:SetText(strCurTitle);

end

function GetGuildTitle()
local szGuildName = Guild:GetMyGuildInfo("Name");
--AxTrace(0,0,"szGuildName:"..szGuildName);
if(nil ~= szGuildName and "" ~= szGuildName) then
SelfEquip_Confraternity:SetText(szGuildName);
else
SelfEquip_Confraternity:SetText("");
end
end
--]]
----------------------------------------------------------------------------------
--
-- ѡװ���ģ�ͣ�����)
--
function SelfEquip_Modle_TurnLeft(start)
	--������ת��ʼ
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		SelfEquip_FakeObject:RotateBegin(-0.3);
		--������ת����
	else
		SelfEquip_FakeObject:RotateEnd();
	end
end

----------------------------------------------------------------------------------
--
-- ѡװ���ģ�ͣ�����)
--
function SelfEquip_Modle_TurnRight(start)
	--������ת��ʼ
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		SelfEquip_FakeObject:RotateBegin(0.3);
		--������ת����
	else
		SelfEquip_FakeObject:RotateEnd();
	end
end

---------------------------------------------------------------------------------
--
-- ����״̬tooltip
--
function SelfEquip_SetStateTooltip()
	--GK_Am = *99*99*99*99*
	local GKA_Bang = tonumber(string.sub(GK_Am,2,3));
	local GKA_Hoa = tonumber(string.sub(GK_Am,5,6));
	local GKA_Huyen = tonumber(string.sub(GK_Am,8,9));
	local GKA_Doc = tonumber(string.sub(GK_Am,11,12));

	-- �õ�״̬����
	local iIceDefine  		= Player:GetData( "DEFENCECOLD" );
	local iFireDefine 		= Player:GetData( "DEFENCEFIRE" );
	local iThunderDefine	= Player:GetData( "DEFENCELIGHT" );
	local iPoisonDefine		= Player:GetData( "DEFENCEPOISON" );

	local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
	local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
	local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
	local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );

	local iIceResistOther	= Player:GetData( "RESISTOTHERCOLD" );
	local iFireResistOther= Player:GetData( "RESISTOTHERFIRE" );
	local iThunderResistOther	= Player:GetData( "RESISTOTHERLIGHT" );
	local iPoisonResistOther= Player:GetData( "RESISTOTHERPOISON" );

	SelfEquip_IceFastness:SetToolTip("B�ng c�ng: "..tostring(iIceAttack).."#rKh�ng B�ng: "..tostring(iIceDefine).."#rGi�m kh�ng B�ng: "..tostring(iIceResistOther).."#rGi�m �m kh�ng B�ng: "..GKA_Bang );
	SelfEquip_FireFastness:SetToolTip("H�a c�ng: "..tostring(iFireAttack).."#rKh�ng H�a: "..tostring(iFireDefine).."#rGi�m kh�ng H�a: "..tostring(iFireResistOther).."#rGi�m �m kh�ng H�a: "..GKA_Hoa );
	SelfEquip_ThunderFastness:SetToolTip("Huy�n c�ng: "..tostring(iThunderAttack).."#rKh�ng Huy�n: "..tostring(iThunderDefine).."#rGi�m kh�ng Huy�n: "..tostring(iThunderResistOther).."#rGi�m �m kh�ng Huy�n: "..GKA_Huyen );
	SelfEquip_PoisonFastness:SetToolTip("еc c�ng: "..tostring(iPoisonAttack).."#rKh�ng еc: "..tostring(iPoisonDefine).."#rGi�m kh�ng еc: "..tostring(iPoisonResistOther).."#rGi�m �m kh�ng еc: "..GKA_Doc );

end


---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function SelfEquip_ShowVigor()
	--

	--this:RegisterEvent("UNIT_VIGOR");		-- ע�����ֵ
	--this:RegisterEvent("UNIT_ENERGY");	-- ע�ᾫ��ֵ
	local iVigor = Player:GetData("VIGOR");
	local iVigorMax = Player:GetData("MAXVIGOR");
	local VigorText = tostring(iVigor).."/"..tostring(iVigorMax);
	SelfEquip_Vigor:SetText( VigorText );

end

---------------------------------------------------------------------------------
--
-- ��ʾ����
--
function SelfEquip_ShowEnergy()
	--

	local iEnergy 	 = Player:GetData("ENERGY");
	local iEnergyMax = Player:GetData("MAXENERGY");
	local EnergyText = tostring(iEnergy).."/"..tostring(iEnergyMax);
	SelfEquip_Energy:SetText(EnergyText);


end


----------------------------------------------------------------------------------------
--
-- �رս���
--

function SelfEquip_CloseUI()

	-- �򿪻��߹رճƺŽ���
	CloseTitleList();
	SelfEquip_FakeObject:SetFakeObject("");
	SelfEquip_Close();

end;


function Pet_Page_Switch()
	Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
	TogglePetPage();
	SelfEquip_SetTabColor(0);
end

--���Լ�������ҳ��
function Pet_Page_SelfData()
	Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("self");

end

function SelfEquip_SetTabColor(idx)
	if(idx == nil or idx < 0 or idx > 4) then
		return;
	end

	--AxTrace(0,0,tostring(idx));
	local i = 0;
	local selColor = "#e010101#Y";
	local noselColor = "#e010101";
	local tab = {
		[0] = SelfEquip_SelfEquip,
		SelfEquip_SelfData,
		SelfEquip_Pet,
		SelfEquip_Ride,
		SelfEquip_OtherInfo,
	};

	while i < 5 do
		if(i == idx) then
			tab[i]:SetText(selColor..SELFEQUIP_TAB_TEXT[i]);
		else
			tab[i]:SetText(noselColor..SELFEQUIP_TAB_TEXT[i]);
		end
		i = i + 1;
	end
end

function XiuLian_Page_Switch()
	local nLevel = Player:GetData("LEVEL")
	if(nLevel >= 70) then
		Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
		XiuLianPage();
		SelfEquip_SetTabColor(0);
	else
		SelfEquip_Xiulian : SetCheck(0)
		PushDebugMessage("#{XL_090707_62}")
	end
end

function Ride_Page_Switch()
	Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
	OpenRidePage();

end

function Other_Info_Page_Switch()
	Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
	OtherInfoPage();
	UpdateDoubleExpData();

end

function SelfEquip_UpdateMask()

	local i
	for i=0,17 do
		if i ~= 9 and i ~=10 then
			SelfEquip_UpdateMaskByIndex( i );
		end
	end
end
function SelfEquip_UpdateMaskByIndex( index )

	local ActionIndex = EnumAction(index, "equip");
	--	local cur_dur = LifeAbility : Get_UserEquip_Current_Durability(index);
	--	local max_dur = LifeAbility : Get_UserEquip_Maximum_Durability(index);
	--	AxTrace(5,0,index.." max_dur="..max_dur)
	--	AxTrace(5,0,index.." cur_dur="..cur_dur)

	--	if( (cur_dur / max_dur) < 0.1 ) then

  -- Set Animate
  if (m_ZhiZunAnimate[ index ] ~= nil) then
    m_ZhiZunAnimate[ index ]:Hide()
    if (tonumber(ActionIndex:GetID()) ~= 0) then
      if index == 16 or index == 17 then			--8:��� 9:���� 10:����
        if index == 17 then
          m_ZhiZunAnimate[ index ]:SetProperty("Animate" , "ZhiZun_Flash_Big")
        end
        m_ZhiZunAnimate[ index ]:Show()
      else
        --m_ZhiZunAnimate[ index ]:SetProperty("Animate" , "JunXian_Flash3")
      end
      --m_ZhiZunAnimate[ index ]:Show()
    end
  end

	-- Set Item Red Mask
  if (g_EquipMask[ index ] ~= nil) then
  	if( ActionIndex:GetEquipDur() < 0.1 ) then
  		g_EquipMask[ index ]:Show();
  	else
  		g_EquipMask[ index ]:Hide();
  	end
  end

end

function SelfEquip_OpenBlog()
	local strCharName =  Player:GetName();
	local strAccount =  Player:GetData("ACCOUNTNAME")
	Blog:OpenBlogPage(strAccount,strCharName,true);
end


function SelfEquip_Open()
	SetTimer("SelfEquip", "SelfEquip_AutoClick_Timer()", g_AutoClickTimer_Step)
	this:Show();
end
function SelfEquip_Close()
	KillTimer("SelfEquip_AutoClick_Timer()")
	this:Hide();
end

function SelfEquip_DressDisPlay()

	if(IsWindowShow("Shop_Fitting")) then
		CloseWindow("Shop_Fitting", true);
	end

	local IsDisplay = SystemSetup:Get_Display_Dress();
	--	local IsDisplay = SelfEquip_Mode : GetCheck()
	AxTrace(0,0,"IsDisplay="..IsDisplay)
	SelfEquip_Mode : SetCheck(IsDisplay)
	if IsDisplay == 1 then
		IsDisplay = 0
	else
		IsDisplay = 1
	end
	AxTrace(0,0,"IsDisplay 2 ="..IsDisplay)

	SystemSetup:Set_Display_Dress(IsDisplay);
end

function SelfEquip_AskLevelup()
	local PlayerLevel = Player:GetData( "LEVEL" )
	local EvaluateLevelList = { 30, 45, 65, 75, 85 }

	local strMasterName = GetMasterName()

	if "" ~= strMasterName then   --�մ���ʾ�ں����б���û���ҵ�ʦ������,��û��ʦ��
		local ListSize = table.getn( EvaluateLevelList )
		for i = 1, ListSize do
			if EvaluateLevelList[ i ] == ( PlayerLevel+1 ) and PlayerLevel < 45 then
				--�����۽���

				AskEvaluateAndLevelup()
				return
			end
		end
	end

	AskLevelUp( tonumber(0) )

end

--��ʾ���UI
function SelfEquip_Wuhun_Switch()
	Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
	ToggleWuhunPage();
	SelfEquip_SetTabColor(0);
end

function SelfEquip_ShowTooltip(Subject)
	if (g_PropertyTable[Subject] ~= nil) then
		if g_PropertyTable[Subject]:GetText() == "" then
			g_PropertyTable[Subject]:SetToolTip("")
		else
			if (g_XiulianTipTable[Subject] ~= nil) then
				g_PropertyTable[Subject]:SetToolTip( g_XiulianTipTable[Subject] )
			end
		end
	end
end

-- ���������ɫ��ʣ�����Ե���Ѿ���������Ե�
function SelfEquip_ResetCharRemainPoint()
	g_AddStr = 0;					-- �����������ϵ�ʣ�����.
	g_AddSpr = 0;					-- �����������ϵ�ʣ�����.
	g_AddCon = 0;					-- �����������ϵ�ʣ�����.
	g_AddInt = 0;					-- �����ڶ����ϵ�ʣ�����.
	g_AddDex = 0;					-- ���������ϵ�ʣ�����.

	-- �������Ե�����Ӻͼ��ٲ���
	DisablePointAddButtion();
	DisablePointDecButtion();

	-- ��ȡʣ�����Ե�
	local nNumber 		= Player:GetData("POINT_REMAIN");
	g_CurRemainPoint 	= nNumber;
	g_RemainPoint   	= nNumber;

	-- ������ʾ
	ShowCurStr();
	ShowCurSpr();
	ShowCurCon();
	ShowCurInt();
	ShowCurDex();
	ShowCurRemainPoint();

	if(g_CurRemainPoint > 0) then
		EanblePointAddButtion();
	end

	-- �����ֶ����ڵ�����ť��״̬.
	SetAcceptButtonState();
end

--***************************************************
-- 清空鼠标长按标记
--***************************************************
function SelfEquip_AutoClick_Clear(id)
	id = tonumber(id)
	if (id == g_AutoClick_BtnFlag) then
		g_AutoClick_BtnFlag = -1
	end
end

--***************************************************
-- 定时器回调函数
--    实现慢�?�动, 以�?��?�以考虑加速(必�?性�?大)
--***************************************************
function SelfEquip_AutoClick_Timer()
	if (g_AutoClick_BtnFlag ~= -1) then
		-- 第一次LButton�?��?过X个Timer�?算开始, 也就是说是 g_AutoClickTimer_Step * X 的时候开始进行自动加, 这样为了防止本�?��?点击一下的结果点了好多下
		if (g_AutoClick_Going < 4) then
			g_AutoClick_Going = g_AutoClick_Going + 1
			--目�?先设置 6 Step 的等待时间, 下�?�注释的代�?�?�以�?��?�用于实现慢�?�动, �?�?加速效果.
			--if (g_AutoClick_Going == 2 or g_AutoClick_Going == 5) then
			--g_AutoClick_FunList[g_AutoClick_BtnFlag]()
			--end
		else
			g_AutoClick_FunList[g_AutoClick_BtnFlag]()
		end
	end
end

--***************************************************
-- 鼠标左键�?�开�?作
--    注�?这里其实是代替 Click, 所以需�?执行一次 Click �?作
--***************************************************
function SelfEquip_AutoClick_LButtonUp(id)
	id = tonumber(id)
	SelfEquip_AutoClick_Clear(id)
	g_AutoClick_FunList[id]()
end

--***************************************************
-- 设置定时器
--    设置标记说明鼠标已�?按下
--***************************************************
function SelfEquip_AutoClick_SetTimer(id)
	id = tonumber(id)
	g_AutoClick_Going = -1
	g_AutoClick_BtnFlag = id
end

function Wuhun_Page_Switch()
	--PushDebugMessage("Ch�c n�ng ch�a m�.")
	local Level = Player:GetData("LEVEL")
	if Level < 65 then
		SelfEquip_Wuhun : SetCheck(0)
		PushDebugMessage("C�p 65 m�i c� th� s� d�ng.")
	else
		Variable:SetVariable("SelfUnionPos", SelfEquip_Frame:GetProperty("UnifiedPosition"), 1);
		PushEvent("UI_COMMAND",20111211)
	end
end

function Infant_Page_Switch()
	PushDebugMessage("Ch�c n�ng ch�a m�.")
end
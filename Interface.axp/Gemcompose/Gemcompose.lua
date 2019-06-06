--/* modified by cuiyinjie ¿ª·Å4¼¶Èı¾«ºÏ³É¹¦ÄÜ */
local STUFF_SLOTS = {}										-- ÎïÆ·²Û
local ITEM_IN_SLOTS = {}									-- ÎïÆ·²ÛÖĞµÄÎïÆ·±³°üÎ»ÖÃ
local Current = 0											-- ½çÃæµÄµ±Ç°×´Ì¬ 1£º±¦Ê¯ºÏ³É 2£º²ÄÁÏºÏ³É 3: º®ÓñºÏ³É
local Type = -1												-- µ±Ç°ºÏ³ÉµÄ²ÄÁÏÀàĞÍ
local Grade = -1											-- µ±Ç°ºÏ³ÉµÄ²ÄÁÏµµ´Î
local theNPC = -1											-- ¹¦ÄÜ NPC
local MATERIAL_COUNT = 5									-- ·ÅºÏ³É²ÄÁÏµÄ²ÛµÄÊıÁ¿
local SLOT_COUNT = 6										-- ËùÓĞÄÜ·Å¶«Î÷µÄ²ÛµÄÊıÁ¿
local SPECIAL_MATERIAL_SLOT = 6								-- ·ÅÌØÊâ²ÄÁÏµÄ¸ñ×ÓºÅ
local MAX_OBJ_DISTANCE = 3.0

local LaskPack = {}

local curSuccRate = 0;
local RuleTable = {
	{
		msgDiffTypeErr = "Bäo thÕch cùng loÕi m¾i có th¬ hşp thành.",
		msgDiffGradeErr = "Chï ğßşc hşp thành bäo thÕch ngang c¤p",
		msgLackMoney = "Ti«n không ğü #{_EXCHG%d}. ",
		msgLackStuff = "V§t ph¦m hşp thành m²i l¥n phäi l¾n h½n 2.",
		msgSlotEmpty = "Hãy ğ£t Bäo ThÕch c¥n hşp thành vào.",         -- add  by zchw
		maxGrade = 9,
		msgGradeLimited = "Bäo thÕch cao nh¤t là c¤p 9, không th¬ hşp thành næa.",
		[1] = { SpecialStuff = 30900015, MoneyCost = 5000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[2] = { SpecialStuff = 30900015, MoneyCost = 6000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[3] = { SpecialStuff = 30900015, MoneyCost = 7000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[4] = { SpecialStuff = 30900016, MoneyCost = 8000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[5] = { SpecialStuff = 30900016, MoneyCost = 9000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[6] = { SpecialStuff = 30900016, MoneyCost = 10000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[7] = { SpecialStuff = 30900128, MoneyCost = 11000, CountTable = { [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
		[8] = { SpecialStuff = 30900016, MoneyCost = 12000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	},
	{
		msgDiffTypeErr = "Nguyên li®u cùng loÕi m¾i ğßşc hşp thành.",
		msgDiffGradeErr = "Nguyên li®u cùng c¤p m¾i ğßşc hşp thành.",
		msgLackMoney = "Ti«n không ğü #{_EXCHG%d}. ",
		msgLackStuff = "V§t ph¦m hşp thành m²i l¥n phäi l¾n h½n 2.",
		msgSlotEmpty = "Hãy ğßa nguyên li®u c¥n hşp thành vào.",				-- add by zchw
		maxGrade = 5,	-- ÎïÆ·±íÀïµÄµÈ¼¶£¬3¼¶²ÄÁÏÎª4¼¶£¬ËùÒÔ±ß½çÎª5¼¶ mark by cuiyinjie maxGrade add 1
		msgGradeLimited = "T¯i ğa ğ£t vào nguyên li®u c¤p 3, nguyên li®u cüa các hÕ không th¬ tiªp tøc hşp thành.", --µÈ¼¶¼Ó1¼¶
		[1] = { SpecialStuff = -1, MoneyCost = 500, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
		[2] = { SpecialStuff = -1, MoneyCost = 1000, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
		[3] = { SpecialStuff = -1, MoneyCost = 1500, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
		[4] = { SpecialStuff = -1, MoneyCost = 5000, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, }, -- modify by cuiyinjie cost 20yin -> cost 50yin
--		[5] = { SpecialStuff = -1, MoneyCost = 2500, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[6] = { SpecialStuff = -1, MoneyCost = 3000, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[7] = { SpecialStuff = -1, MoneyCost = 3500, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[8] = { SpecialStuff = -1, MoneyCost = 4000, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
	},
	{
		msgDiffTypeErr = "C¥n phäi sØ døng Huy«n Thiên Hàn Ng÷c ğ¬ hşp thành.",
		msgDiffGradeErr = "C¥n phäi sØ døng cùng mµt loÕi Huy«n Thiên Hàn Ng÷c ğ¬ hşp thành.",
		msgLackMoney = "Ti«n không ğü #{_EXCHG%d}. ",
		msgLackStuff = "V§t ph¦m hşp thành m²i l¥n phäi l¾n h½n 2.",
		msgSlotEmpty = "Hãy ğßa Huy«n Thiên Hàn Ng÷c c¥n hşp thành vào.",
		maxGrade = 2,
		msgGradeLimited = "C¥n phäi nh§p vào cùng mµt loÕi Huy«n Thiên Hàn Ng÷c, Huy«n Thiên Hàn Ng÷c cüa b¢ng hæu không th¬ tiªp tøc hşp thành.",
		[1] = { SpecialStuff = -1, MoneyCost = 10000, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[2] = { SpecialStuff = -1, MoneyCost = 1000, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[3] = { SpecialStuff = -1, MoneyCost = 1500, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[4] = { SpecialStuff = -1, MoneyCost = 2000, CountTable = { [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[5] = { SpecialStuff = -1, MoneyCost = 2500, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[6] = { SpecialStuff = -1, MoneyCost = 3000, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[7] = { SpecialStuff = -1, MoneyCost = 3500, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
--		[8] = { SpecialStuff = -1, MoneyCost = 4000, CountTable = { [3] = { SuccOdds = 50, SuccOddsWithSpecStuff = 0, }, [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 0, }, [5] = { SuccOdds = 100, SuccOddsWithSpecStuff = 0, }, }, },
	},
}

local g_Gemcompose_Frame_UnifiedPosition;
local npcObjId = -1

-- ×¢²áÊÂ¼ş
function Gemcompose_PreLoad()
	this:RegisterEvent("UI_COMMAND")						-- ¼¤»î½çÃæÊÂ¼ş

	this:RegisterEvent("UPDATE_COMPOSE_GEM")				-- Ë¢ĞÂ±¦Ê¯ºÏ³É½çÃæ
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")				-- ±³°üÖĞÎïÆ·¸Ä±äĞèÒªÅĞ¶Ï¡­¡­
	this:RegisterEvent("OBJECT_CARED_EVENT")				-- ¹Ø×¢ÊµÊ©ºÏ³ÉµÄ NPC
	this:RegisterEvent("RESUME_ENCHASE_GEM")				-- ºÏ³ÉÍê±Ï
	this:RegisterEvent("CLOSE_SYNTHESIZE_ENCHASE")			-- ¹Ø±Õ±¾½çÃæ
	-- this:RegisterEvent("TOGLE_SKILL_BOOK")				-- ´ò¿ªÃÅÅÉ¼¼ÄÜ½çÃæÊÇ·ñĞèÒª¹Ø±Õ´Ë½çÃæ
	-- this:RegisterEvent("TOGLE_COMMONSKILL_PAGE")			-- ´ò¿ªÆÕÍ¨¼¼ÄÜ½çÃæÊÇ·ñĞèÒª¹Ø±Õ£¿
	-- this:RegisterEvent("CLOSE_SKILL_BOOK")				-- ¹Ø±ÕÃÅÅÉ¼¼ÄÜ½çÃæ
	-- this:RegisterEvent("DISABLE_ENCHASE_ALL_GEM")		-- ËùÓĞºÏ³ÉÏà¹ØµÄÎïÆ·ĞèÒªËø¶¨
	-- this:RegisterEvent("UPDATE_COMPOSE_ITEM")			-- ÎïÆ·ºÏ³É½çÃæ´ò¿ª£¬´Ë½çÃæÊÇ·ñĞèÒª¹Ø±Õ£¿
	-- this:RegisterEvent("OPEN_COMPOSE_ITEM")				-- ÎïÆ·ºÏ³É½çÃæ´ò¿ª£¬´Ë½çÃæÊÇ·ñĞèÒª¹Ø±Õ£¿
	this:RegisterEvent("UNIT_MONEY");
	this:RegisterEvent("MONEYJZ_CHANGE")		--½»×ÓÆÕ¼° Vega
	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	
end

-- ½çÃæÔØÈë
function Gemcompose_OnLoad()
	STUFF_SLOTS[1] = Gemcompose_Space1
	STUFF_SLOTS[2] = Gemcompose_Space2
	STUFF_SLOTS[3] = Gemcompose_Space3
	STUFF_SLOTS[4] = Gemcompose_Space4
	STUFF_SLOTS[5] = Gemcompose_Space5
	STUFF_SLOTS[6] = Gemcompose_Special_Button

	ITEM_IN_SLOTS[1] = -1
	ITEM_IN_SLOTS[2] = -1
	ITEM_IN_SLOTS[3] = -1
	ITEM_IN_SLOTS[4] = -1
	ITEM_IN_SLOTS[5] = -1
	ITEM_IN_SLOTS[6] = -1

	LaskPack[1] = -1
	LaskPack[2] = -1
	LaskPack[3] = -1
	LaskPack[4] = -1
	LaskPack[5] = -1
	LaskPack[6] = -1
	
	 g_Gemcompose_Frame_UnifiedPosition=Gemcompose_Frame:GetProperty("UnifiedPosition");
	 
end

-- ¼à¿Ø¸÷ÖÖÊÂ¼ş
function Gemcompose_OnEvent( event )
	if event == "UI_COMMAND" and tonumber( arg0 ) == 23 then	-- ±¦Ê¯ºÏ³É
		Gemcompose_Clear();			-- add by zchw
		if this : IsVisible() and Current ~= 1 then				-- Èç¹û½çÃæ¿ª×Å£¬Ôò¹Øµô
			Gemcompose_Close()
		end
		Gemcompose_SuccessValue : SetText("#cFF0000Tï l® thành công");
		Current = 1
		Gemcompose_DragTitle : SetText("#gFF0FA0Hşp thành bäo thÕch")
		Gemcompose_Info : SetText("#{BSQHB_120830_01}")
		Gemcompose_Static1 : Show()
		Gemcompose_Special : Show()
		
		local GemUnionPos = Variable:GetVariable("GemUnionPos");
		if(GemUnionPos ~= nil) then
		  Gemcompose_Frame:SetProperty("UnifiedPosition", GemUnionPos);
		end
		Gemcompose_FenYe1:SetCheck(1)
		this : Show()

		npcObjId = tonumber(Variable:GetVariable("GemNPCObjId"));
		Variable:SetVariable("GemNPCObjId", "", 1)
		if(npcObjId == nil) then
			npcObjId = Get_XParam_INT( 0 )
		end
		Gemcompose_BeginCareObject( npcObjId )
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		Gemcompose_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	if event == "OBJECT_CARED_EVENT" and this : IsVisible() then
		if tonumber( arg0 ) ~= theNPC then
			return
		end

		--Èç¹ûºÍNPCµÄ¾àÀë´óÓÚÒ»¶¨¾àÀë»òÕß±»É¾³ı£¬×Ô¶¯¹Ø±Õ
		if arg1 == "distance" and tonumber( arg2 ) > MAX_OBJ_DISTANCE or arg1 == "destroy" then
			Gemcompose_Cancel_Clicked()
		end
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		Gemcompose_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	if event == "UPDATE_COMPOSE_GEM" and this : IsVisible() then
		Gemcompose_Update( arg0, arg1 )
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		Gemcompose_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	if event == "PACKAGE_ITEM_CHANGED" and this : IsVisible() then
		if not arg0 or tonumber( arg0 ) == -1 then
			return
		end

		for i = 1, SLOT_COUNT do
			if ITEM_IN_SLOTS[i] == tonumber( arg0 ) then
				Gemcompose_Remove( i )
				break
			end
		end
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		Gemcompose_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	if event == "RESUME_ENCHASE_GEM" and this : IsVisible() then
		if arg0 then
			Gemcompose_Remove( tonumber( arg0 ) - 6 )
		end

		return
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
	end

	if event == "CLOSE_SYNTHESIZE_ENCHASE" and this : IsVisible() then
		Gemcompose_Cancel_Clicked()
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		return
	end
	if (event == "UNIT_MONEY" and this:IsVisible()) then
		Gemcompose_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
	end
	if (event == "MONEYJZ_CHANGE" and this:IsVisible()) then
		Gemcompose_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
	end
	
	if (event == "ADJEST_UI_POS" ) then
		Gemcompose_Frame_On_ResetPos()
		
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		Gemcompose_Frame_On_ResetPos()
		end
		
end

-- µã»÷ºÏ³É°´Å¥
function Gemcompose_OK_Clicked()
	-- ¸ù¾İµ±Ç°Ëù´¦µÄ½çÃæ½øĞĞ¼ì²é
	local Notify = 0;
	local CurrentRule = RuleTable[Current]
	if not CurrentRule then
		return
	end

	--ÅĞ¶Ïµç»°ÃÜ±£ºÍ¶ş¼¶ÃÜÂë±£»¤2012.6.8-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then			
		return
	end
	-- ÅĞ¶ÏÊÇ·ñÎª°²È«Ê±¼ä2012.6.8-LIUBO
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZYXT_120528_16}")
		return
	end
	
	--¼ì²é°ó¶¨×´Ì¬
	--ÏÂÃæÕâÒ»¶ÎÊÇ²ÄÁÏ°ó¶¨ÌáÊ¾£¬ÕÅÄşĞ´µÄÓĞbug£¬È«²¿×¢µô£¬²ÉÓÃĞÂµÄÂß¼­
--		for i = 1, MATERIAL_COUNT do

--			if(LaskPack[i] ~= ITEM_IN_SLOTS[i]) then

--				LaskPack[i] = ITEM_IN_SLOTS[i];
--				Notify = 1;

--			end

--		end

--		if(Notify == 1) then

--			for i = 1, MATERIAL_COUNT do

--				if(ITEM_IN_SLOTS[i] == -1) then

--					continue

--				end

--				if(Gemcompose_IsBind(ITEM_IN_SLOTS[i]) == 1) then
				--¼ì²éÓĞÃ»ÓĞ°ó¶¨µÄÎïÆ·
--					ShowSystemInfo("BSHE_20070924_001");
--					return;

--				end

--			end

--		end

	local materialCount = 0

	-- add by zchw
	for i = 1, MATERIAL_COUNT do
		if ITEM_IN_SLOTS[i] ~= -1 then
			Grade = Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] );
			break;
		end
	end
	if Grade == -1 then
		PushDebugMessage( CurrentRule.msgSlotEmpty )
		return
	end
	-- end of zchw

	for i = 1, MATERIAL_COUNT do
		if ITEM_IN_SLOTS[i] ~= -1 then

			materialCount = materialCount + 1

			-- ¼ì²éÊÇ·ñ¶¼ÊÇÍ¬ÖÖ²ÄÁÏ
			if Gemcompose_ItemInterface( ITEM_IN_SLOTS[i] ) ~= Current then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			if Type ~= Gemcompose_GetItemType( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			-- ¼ì²é²ÄÁÏÊÇ·ñµÈ¼¶ÏàÍ¬
			if not CurrentRule[Grade] or Grade ~= Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffGradeErr )
				return
			end

			-- ¼ì²é²ÄÁÏÊÇ·ñÊÇ×î¸ßµÈ¼¶
			if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) >= RuleTable[Current].maxGrade then
				PushDebugMessage( CurrentRule.msgGradeLimited )
				return
			end
			--ºÏ³É8£¬9¼¶±¦Ê¯¹¦ÄÜ¹Ø±Õ£»·Å¿ª8¼¶±¦Ê¯¡£[LiChengjie]
			if Current == 1 then
				if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) > 7 then
					PushDebugMessage( "#{BSHC_090313_1}" )
					return
				end
			end

			--- Àñ½ğ±¦Ê¯ºÏ³É¹¦ÄÜ¹Ø±Õ   --add by YGQ Í¨±¦±¦Ê¯ºÏ³É¿ª·Å TT149838
			--if Gemcompose_IsLiJinGem( ITEM_IN_SLOTS[i] ) == 1 then
			--	PushDebugMessage( "#{LJSD_120508_41}" )
			--	return
			--end
		end
	end

	-- ¼ì²éÉíÉÏµÄ½ğÇ®ÊÇ·ñ×ã¹»
	local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < CurrentRule[Grade].MoneyCost then
		PushDebugMessage( string.format( CurrentRule.msgLackMoney, CurrentRule[Grade].MoneyCost ) )
		return
	end

	-- ¼ì²é²ÄÁÏÊıÁ¿ÊÇ·ñ×ã¹»
	if not CurrentRule[Grade].CountTable[materialCount] then
		PushDebugMessage( CurrentRule.msgLackStuff )
		return
	end

	-- Èç¹ûÊÇ±¦Ê¯ºÏ³É½çÃæ£¬ÔòÈç¹ûÃ»ÓĞ·ÅÈëÌØÊâ²ÄÁÏ½«¸ø³ö½çÃæÌáÊ¾
	if Current == 1 then
		if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
--			local dialogStr = "Èç¹û²»Ê¹ÓÃ#{_ITEM" .. CurrentRule[Grade].SpecialStuff ..
--				"}½øĞĞºÏ³ÉµÄ»°£¬ºÏ³ÉµÄ³É¹¦ÂÊ×î¸ßÖ»ÓĞ75£¥£¬ÄúÊÇ·ñÈ·¶¨¼ÌĞøºÏ³É£¿"
--			LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
--				ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
--				ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6], 0, dialogStr )
			PushDebugMessage( "Hşp thành bäo thÕch c¥n ğ£t bäo thÕch hşp thành phù." )
			return
		end
	end

	LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
		ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
		ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6],(curSuccRate.."%") )
end

-- µã»÷È¡Ïû»òÕß¹Ø±Õ°´Å¥
function Gemcompose_Cancel_Clicked()
	Gemcompose_Close()
	Gemcompose_StopCareObject()
end

-- ¹Ø±Õ½çÃæ
function Gemcompose_Close()
	this : Hide()
	Gemcompose_Clear()
end

-- Çå¿Õ½çÃæÔªËØ
function Gemcompose_Clear()
	Current = 0
	Type = -1
	Grade = -1
	Gemcompose_SuccessValue : SetText("#cFF0000Tï l® thành công")
	Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )
	Gemcompose_OK : Disable()

	for i = 1, SLOT_COUNT do
		STUFF_SLOTS[i] : SetActionItem(-1)

		if ITEM_IN_SLOTS[i] ~= -1 then
			LifeAbility : Lock_Packet_Item( ITEM_IN_SLOTS[i], 0 )
		end

		STUFF_SLOTS[i] : Enable()
		ITEM_IN_SLOTS[i] = -1
	end
	LifeAbility:ClearComposeItems();
	LaskPack[1] = -1
	LaskPack[2] = -1
	LaskPack[3] = -1
	LaskPack[4] = -1
	LaskPack[5] = -1
	LaskPack[6] = -1
end

-- ÅĞ¶ÏÄ³¸ö±³°ü¸ñ×ÓÖĞµÄÎïÆ·ÊÇ·ñ±¦Ê¯
function Gemcompose_IsGem( bagPos )
	if PlayerPackage : IsGem( bagPos ) == 1 then
		return 1
	else
		return 0
	end
end

-- ÅĞ¶ÏÄ³¸ö±³°ü¸ñ×ÓÖĞµÄÎïÆ·ÊÇ·ñ²ÄÁÏ
function Gemcompose_IsMaterial( bagPos )
	--local MatIdentifier = PlayerPackage : GetItemSubTableIndex( bagPos, 0 ) * 10000000 + PlayerPackage : GetItemSubTableIndex( bagPos, 1 )*100000 + PlayerPackage : GetItemSubTableIndex( bagPos, 2 )*1000 + PlayerPackage : GetItemSubTableIndex( bagPos, 3 )
	local itemId = PlayerPackage:GetItemTableIndex(bagPos)
	if itemId >= 20500000 and itemId <= 20500008 then
		return 1
	end

	if itemId >= 20501000 and itemId <= 20501008 then
		return 1
	end

	if itemId >= 20502000 and itemId <= 20502008 then
		return 1
	end

	return 0

end

-- µÃµ½Ä³¸ö±³°ü¸ñ×ÓÖĞµÄÎïÆ·µÄÀàĞÍ
function Gemcompose_GetItemType( bagPos )
	if Gemcompose_IsGem( bagPos ) == 1 then
--		local a=( PlayerPackage : GetItemSubTableIndex( bagPos, 2 ) * 1000 + PlayerPackage : GetItemSubTableIndex( bagPos, 3 ) )
--		PushDebugMessage(a)
		return ( PlayerPackage : GetItemSubTableIndex( bagPos, 2 ) * 1000 + PlayerPackage : GetItemSubTableIndex( bagPos, 3 ) )
	elseif Gemcompose_IsMaterial( bagPos ) == 1 then
		return PlayerPackage : GetItemSubTableIndex( bagPos, 2 )
	elseif PlayerPackage:GetItemTableIndex(bagPos) == 20310110 then
		return PlayerPackage : GetItemSubTableIndex( bagPos, 2 )
	end

	return -1
end

-- µÃµ½Ä³¸ö±³°ü¸ñ×ÓÖĞµÄÎïÆ·µÄµÈ¼¶
function Gemcompose_GetItemGrade( bagPos )
	if Gemcompose_IsGem( bagPos ) == 1 then
		return PlayerPackage : GetItemSubTableIndex( bagPos, 1 )
	elseif Gemcompose_IsMaterial( bagPos ) == 1 then
		return PlayerPackage : GetItemGrade( bagPos )
	elseif PlayerPackage:GetItemTableIndex(bagPos) == 20310110 then
		return PlayerPackage : GetItemGrade( bagPos )
	end

	return PlayerPackage : GetItemGrade( bagPos )
end

-- µÃµ½µ±Ç°½çÃæÓ¦¸ÃÆ¥ÅäµÄÌØÊâ²ÄÁÏºÅ
-- Èç¹û²»ÊÇ±¦Ê¯½çÃæÔò·µ»Ø -1
-- Èç¹ûÊÇ±¦Ê¯½çÃæµ«ÊÇ»¹Ã»ÓĞ·ÅÈÎºÎ±¦Ê¯Ôò·µ»Ø -1
function Gemcompose_GetSpecialMaterial()
	local CurrentRule = RuleTable[Current]
	if CurrentRule then
		if CurrentRule[Grade] then
			return CurrentRule[Grade].SpecialStuff
		end
	end

	return -1
end

-- ÅĞ¶ÏÄ³¸ö±³°ü¸ñ×ÓÖĞµÄÎïÆ·ÊôÓÚÄÇ¸ö½çÃæ£¬Æ¥Åä Current£¬Ã»ÓĞÆ¥ÅäµÄÓÃ 0
-- ½çÃæµÄµ±Ç°×´Ì¬ 1£º±¦Ê¯ºÏ³É 2£º²ÄÁÏºÏ³É
function Gemcompose_ItemInterface( bagPos )
	if Current == 1 then
		if Gemcompose_IsGem( bagPos ) == 1 then
			return Current
		end

		if PlayerPackage : GetItemTableIndex( bagPos ) == Gemcompose_GetSpecialMaterial() then
			return Current
		end
	elseif Current == 2 then
		if Gemcompose_IsMaterial( bagPos ) == 1 then
			return Current
		end
	elseif Current == 3 then
		if(PlayerPackage:GetItemTableIndex(bagPos)==20310110)then
			return Current
		end
	end

	return 0
end

-- Ë¢ĞÂºÏ³É½çÃæÉÏµÄÎïÆ·
function Gemcompose_Update( pos0, pos1 )
	local slot = tonumber( pos0 )
	local bagPos = tonumber( pos1 )

	-- AxTrace( 0, 1, "Current=".. Current )
	-- AxTrace( 0, 1, "slot=".. slot )
	-- AxTrace( 0, 1, "bagPos=".. bagPos )
	local CurrentRule = RuleTable[Current]
	if not CurrentRule then
		return
	end

	if not this : IsVisible() then					-- ½çÃæÎ´´ò¿ª
		return
	end

	-- ÑéÖ¤ÎïÆ·ÓĞĞ§ĞÔ
	local bagItem = EnumAction( bagPos, "packageitem" )
	if bagItem : GetID() == 0 then
		return
	end

	--ÊÇ·ñÊÇË«ÊôĞÔ±¦Ê¯
	local bDoubleGem = DoubleGem: IsDoubleGem(bagPos)
	if bDoubleGem > 0 then
		PushDebugMessage("#{BSZK_121012_43}")
		return
	end
	--·ÖÆÚ¸¶¿î±¦Ê¯
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( bagPos )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_55}")
		return
	end

	-- AxTrace( 0, 1, "Gemcompose_ItemInterface( bagPos )=".. Gemcompose_ItemInterface( bagPos ) )
	-- ÕÒµ½ bagPos µÄÎïÆ·ÀàĞÍ£¬À´ÅĞ¶ÏÊÇ·ñ·ûºÏµ±Ç°½çÃæ£¬·ñÔòÃ»ÓĞÈÎºÎÌáÊ¾
	if Gemcompose_ItemInterface( bagPos ) ~= Current then
		if Current == 1 then
			--Ã»ÓĞ·ÅÈë±¦Ê¯µÄÊ±ºò£¬ÌØÊâ²ÄÁÏĞèÇó·µ»Ø-1£»ÆäËûÇé¿öÒ²ĞèÒªÌáÊ¾²ÄÁÏ²»×ã
			if  Gemcompose_GetSpecialMaterial() == -1 then
				PushDebugMessage( "#{BSQHB_120830_06}" )
				return
			end
			local nStuff =  PlayerPackage : GetItemTableIndex( bagPos )
			if 30900128 == nStuff or 30900015 == nStuff or 30900016 == nStuff then
				if Grade < 4 then
					PushDebugMessage( "#{BSQHB_120830_12}" )
				elseif Grade < 7 then
					PushDebugMessage( "#{BSQHB_120830_13}" )
				elseif Grade < 8 then
					PushDebugMessage( "#{BSQHB_120830_07}" )
				end
			else
				PushDebugMessage( "#{BSQHB_120830_03}" )
			end
		else
			PushDebugMessage( "#{BSQHB_120830_03}" )
		end
		return
	end

	-- Èç¹û bagPos ÊÇµ±Ç°½çÃæĞèÒªµÄÎïÆ·£¬ÕÒµ½¸ÃÎïÆ·Ó¦¸Ã´¦ÔÚµÄ¸ñ×Ó·¶Î§
	-- Èç¹ûÊÇ±¦Ê¯»òÕß²ÄÁÏ
	if Gemcompose_IsGem( bagPos ) == 1 or Gemcompose_IsMaterial( bagPos ) == 1 or PlayerPackage:GetItemTableIndex(bagPos) == 20310110 then
		-- AxTrace( 0, 1, "it's a main material." )
		-- ÅĞ¶ÏÒ»ÏÂÊÇ·ñÀàĞÍÏàÍ¬£¬²»ÏàÍ¬¸ø³öÌáÊ¾
		if Type ~= -1 then
			if Type ~= Gemcompose_GetItemType( bagPos ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end
		end

		-- ÅĞ¶ÏÒ»ÏÂÊÇ·ñµµ´ÎÏàÍ¬£¬Èç¹û²»ÏàÍ¬¸ø³öÌáÊ¾
		if Grade ~= -1 then
			if Grade ~= Gemcompose_GetItemGrade( bagPos ) then
				PushDebugMessage( CurrentRule.msgDiffGradeErr )
				return
			end
		elseif Gemcompose_GetItemGrade( bagPos ) >= RuleTable[Current].maxGrade then
			PushDebugMessage( CurrentRule.msgGradeLimited )
			return
		end

		if Gemcompose_IsGem( bagPos ) == 1 then
			local tGrade = Gemcompose_GetItemGrade( bagPos )
			if tGrade > 7 then
				PushDebugMessage("#{BSQHB_120830_04}")
				return
			end
			if tGrade == 7 then
				local nleftSpace = 0
				for i = 1, MATERIAL_COUNT do
					if ITEM_IN_SLOTS[i] == -1 then
						nleftSpace = nleftSpace + 1
					end
				end
				--Ò»¹²5¸ö¸ñ×Ó£¬ÒòÎª4¸ö±¦Ê¯ÓÃÓÚºÏ³É£¬Èç¹ûÒÑ¾­·ÅÁË4¸ö£¬Ê£ÓàµÄ¸ñ×ÓÊıÄ¿Ò²¾ÍĞ¡ÓÚ2
				if nleftSpace < 2 then
					PushDebugMessage("#{BSQHB_120830_05}")
					return
				end
			end
		end

		if slot == 0 then						-- ×Ô¶¯Ñ°ÕÒ¿Õ¸ñ
			-- ´Ó 1 ~ MATERIAL_COUNT Ö®¼äÕÒÒ»¸ö¿Õ×ÅµÄ¸ñ×Ó£¬Èç¹ûÃ»ÓĞ¿Õ¸ñ×ÓÁË£¬Ôò·µ»Ø
			for i = 1, MATERIAL_COUNT do
				if ITEM_IN_SLOTS[i] == -1 then
					slot = i
					break
				end
			end

			-- AxTrace( 0, 1, "slot=".. slot )

			if slot == 0 then
				return
			end
		else
			-- ÅĞ¶Ï bagPos ÊÇ·ñÓ¦¸Ã´¦ÔÚÕâ¸ö¸ñ×Ó£¬¸ñ×Ó²»¶ÔÔòÖ±½Ó·µ»Ø
			if slot < 1 or slot > MATERIAL_COUNT then
				return
			end
		end
	-- Èç¹ûÊÇÌØÊâ²ÄÁÏ
	elseif PlayerPackage : GetItemTableIndex( bagPos ) == Gemcompose_GetSpecialMaterial() then
		-- AxTrace( 0, 1, "it's a special material." )
		if slot == 0 then						-- ×Ô¶¯Ñ°ÕÒ¿Õ¸ñ
			-- ¿´¿´µÚ SPECIAL_MATERIAL_SLOT ¸ö¸ñ×ÓÊÇ·ñ¿Õ×ÅµÄ¸ñ×Ó£¬Èç¹û²»ÊÇ£¬Ôò·µ»Ø
			if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
				slot = SPECIAL_MATERIAL_SLOT
			else
				return
			end
		else
			-- ÅĞ¶Ï bagPos ÊÇ·ñÓ¦¸Ã´¦ÔÚÕâ¸ö¸ñ×Ó£¬¸ñ×Ó²»¶ÔÔòÖ±½Ó·µ»Ø
			if slot ~= SPECIAL_MATERIAL_SLOT then
				if Current == 1 then
					PushDebugMessage( "#{BSQHB_120830_09}" )--Çë·ÅÈë±¦Ê¯ºÏ³É·û¿ò
				else
					PushDebugMessage( "Hãy ğ£t vào ô nguyên li®u ğ£c thù." )
				end
				return
			end
		end
	end

	-- AxTrace( 0, 1, "ITEM_IN_SLOTS[slot]=".. ITEM_IN_SLOTS[slot] )
	-- °ÑÎïÆ··Åµ½¸ñ×ÓÉÏ
	-- Èç¹ûÔ­À´µÄ¸ñ×ÓÓĞÎïÆ·£¬ÔòÒÆ³ıÔ­À´µÄÎïÆ·
	if ITEM_IN_SLOTS[slot] ~= -1 then
		Gemcompose_Remove( slot )
	end

	-- ½«±¾ÎïÆ··Åµ½ÎïÆ·¸ñ£¬²¢Ëø¶¨ËùÔÚµÄ±³°ü¸ñ
	STUFF_SLOTS[slot] : SetActionItem( bagItem : GetID() )
	ITEM_IN_SLOTS[slot] = bagPos
	LifeAbility : Lock_Packet_Item( bagPos, 1 )

	if Type == -1 then
		Type = Gemcompose_GetItemType( bagPos )
	end

	if Grade == -1 then
		Grade = Gemcompose_GetItemGrade( bagPos )
	end

	-- ¸üĞÂ½çÃæµÄ³É¹¦ÂÊÏÔÊ¾
	Gemcompose_RecalcSuccOdds()

	-- Èç¹ûÎïÆ·²»ÊÇÌØÊâ²ÄÁÏ£¬²¢ÇÒµ±Ç°µÄÀàĞÍºÍµµ´Î¶¼ÊÇ -1£¬Ôò¸ù¾İ¸ÃÎïÆ·½øĞĞÏàÓ¦ÉèÖÃ£¬²¢¾İ´ËÏÔÊ¾½ğÇ®ÏûºÄ
	if PlayerPackage : GetItemTableIndex( bagPos ) ~= Gemcompose_GetSpecialMaterial() then
		Gemcompose_RecalcCost()
	end
end

-- ÒÆ³ıÒ»¸ö²ÄÁÏ
function Gemcompose_Remove( slot )
	if not this : IsVisible() then
		return
	end

	if slot < 1 or slot > SLOT_COUNT then
		return
	end

	if ITEM_IN_SLOTS[slot] == -1 then
		return
	end

	STUFF_SLOTS[slot] : SetActionItem( -1 )
	LifeAbility : Lock_Packet_Item( ITEM_IN_SLOTS[slot], 0 )
	ITEM_IN_SLOTS[slot] = -1

	if slot >= 1 and slot <= MATERIAL_COUNT then
		local materialCount = 0

		for i = 1, MATERIAL_COUNT do
			if ITEM_IN_SLOTS[i] ~= -1 then
				materialCount = materialCount + 1
			end
		end

		if materialCount == 0 then					-- Ã»ÓĞ²ÄÁÏÁËÔòÒÆ³ıÌØÊâ²ÄÁÏ
			Type = -1
			Grade = -1
			Gemcompose_Remove( SPECIAL_MATERIAL_SLOT )
		end

		Gemcompose_RecalcSuccOdds()
		Gemcompose_RecalcCost()
	elseif slot == SPECIAL_MATERIAL_SLOT then
		Gemcompose_RecalcSuccOdds()
	end
end

-- ÖØĞÂ¼ÆËã³É¹¦ÂÊ
function Gemcompose_RecalcSuccOdds()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_SuccessValue : SetText("#cFF0000Tï l® thành công")
		Gemcompose_OK : Disable()
		return
	end

	local currentRule = RuleTable[Current][Grade]
	local materialCount = 0

	for i = 1, MATERIAL_COUNT do
		if ITEM_IN_SLOTS[i] ~= -1 then
			materialCount = materialCount + 1
		end
	end

	-- AxTrace( 0, 1, "materialCount=".. materialCount )
	local str = "#cFF0000Tï l® thành công: "

	if not currentRule.CountTable[materialCount] then
		curSuccRate = 0;
		str = str .. "Không th¬ hşp thành"
		Gemcompose_OK : Disable()
	elseif ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] ~= -1
	 and currentRule.SpecialStuff == PlayerPackage : GetItemTableIndex( ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] )
	then
		-- AxTrace( 0, 1, "SuccOddsWithSpecStuff=".. currentRule.CountTable[materialCount].SuccOddsWithSpecStuff )
		str = str .. currentRule.CountTable[materialCount].SuccOddsWithSpecStuff .. "%"
		curSuccRate = currentRule.CountTable[materialCount].SuccOddsWithSpecStuff;
		Gemcompose_OK : Enable()
	else
		-- AxTrace( 0, 1, "SuccOdds=".. currentRule.CountTable[materialCount].SuccOdds )
		str = str .. currentRule.CountTable[materialCount].SuccOdds .. "%"
		curSuccRate = currentRule.CountTable[materialCount].SuccOdds;
		Gemcompose_OK : Enable()
	end

	Gemcompose_SuccessValue : SetText( str )
end

-- ÖØĞÂ¼ÆËã½ğÇ®ÏûºÄ
function Gemcompose_RecalcCost()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )
		return
	end

	Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( RuleTable[Current][Grade].MoneyCost ) )
end

--=========================================================
--¿ªÊ¼¹ØĞÄNPC£¬
--ÔÚ¿ªÊ¼¹ØĞÄÖ®Ç°ĞèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓĞ¡°¹ØĞÄ¡±µÄNPC£¬
--Èç¹ûÓĞµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓĞµÄ¡°¹ØĞÄ¡±
--=========================================================
function Gemcompose_BeginCareObject( objCaredId )
	theNPC = DataPool : GetNPCIDByServerID( objCaredId )
	-- AxTrace( 0, 1, "theNPC0: " .. theNPC )
	if theNPC == -1 then
		PushDebugMessage("Chßa phát hi®n NPC")
		this : Hide()
		return
	end

	this : CareObject( theNPC, 1, "Gemcompose" )
end

--=========================================================
--Í£Ö¹¶ÔÄ³NPCµÄ¹ØĞÄ
--=========================================================
function Gemcompose_StopCareObject()
	this : CareObject( theNPC, 0, "Gemcompose" )
	theNPC = -1
end

function Gemcompose_IsBind( ItemID )

	if(GetItemBindStatus(ItemID, 0) == 1) then

		return 1;

	else

		return 0;

	end

end

function Gemcompose_Help_Clicked()
	Helper:GotoHelper("*Gemcompose")
end

function Gemcompose_Frame_On_ResetPos()
  Gemcompose_Frame:SetProperty("UnifiedPosition", g_Gemcompose_Frame_UnifiedPosition);
end

--- ÅĞ¶ÏÊÇ·ñÊÇÀñ½ğ±¦Ê¯¡£ÕâÀïÊ¹ÓÃÁË±È½Ïµ°ÌÛµÄÅĞ¶Ï·½·¨£¬¾ÍÊÇÃû×ÖÀïÃæÊÇ·ñÓĞ"¡¤Í¨"
function Gemcompose_IsLiJinGem( bagIdx )
    if bagIdx == nil or bagIdx == -1 then
        return 1
    end

    local specStr = " -Thông"
    local itemName = PlayerPackage:GetBagItemName( bagIdx )
    if itemName == nil then
        return 1
    end

    local sPos, ePos = string.find( itemName, specStr )
    if sPos == nil or ePos == nil then
        return 0
    end

    return 1
end

--TAB½çÃæÇĞ»»£¬½çÃæÃû×ÖÌ«¿ÓÁË
function Gemcompose_ChangeTabIndex( nIndex )
	if nIndex == nil then
		return
	end
	local nUI = 0
	if 1 == nIndex then
		return
	elseif 2 == nIndex then
		nUI = 112236
	elseif 3 == nIndex then
		nUI = 112237
	elseif 4 == nIndex then
		nUI = 201210120
	elseif 5 == nIndex then
		nUI = 201210121
	elseif 6 == nIndex then
		nUI = 201408140
	else
		return
	end
	if nUI ~= 0 then
		Variable:SetVariable("GemUnionPos", Gemcompose_Frame:GetProperty("UnifiedPosition"), 1)
		Variable:SetVariable("GemNPCObjId", tostring(npcObjId), 1)
		PushEvent("UI_COMMAND", nUI)
		Gemcompose_Close()
	end
end

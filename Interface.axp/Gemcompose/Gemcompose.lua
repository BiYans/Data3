--/* modified by cuiyinjie 开放4级三精合成功能 */
local STUFF_SLOTS = {}										-- 物品槽
local ITEM_IN_SLOTS = {}									-- 物品槽中的物品背包位置
local Current = 0											-- 界面的当前状态 1：宝石合成 2：材料合成 3: 寒玉合成
local Type = -1												-- 当前合成的材料类型
local Grade = -1											-- 当前合成的材料档次
local theNPC = -1											-- 功能 NPC
local MATERIAL_COUNT = 5									-- 放合成材料的槽的数量
local SLOT_COUNT = 6										-- 所有能放东西的槽的数量
local SPECIAL_MATERIAL_SLOT = 6								-- 放特殊材料的格子号
local MAX_OBJ_DISTANCE = 3.0

local LaskPack = {}

local curSuccRate = 0;
local RuleTable = {
	{
		msgDiffTypeErr = "B鋙 th誧h c鵱g lo読 m緄 c� th� h䅟 th鄋h.",
		msgDiffGradeErr = "Ch� 疬㧟 h䅟 th鄋h b鋙 th誧h ngang c",
		msgLackMoney = "Ti玭 kh鬾g 瘘 #{_EXCHG%d}. ",
		msgLackStuff = "V ph h䅟 th鄋h m瞚 l ph鋓 l緉 h絥 2.",
		msgSlotEmpty = "H銀 穑t B鋙 Th誧h c h䅟 th鄋h v鄌.",         -- add  by zchw
		maxGrade = 9,
		msgGradeLimited = "B鋙 th誧h cao nh l� c 9, kh鬾g th� h䅟 th鄋h n鎍.",
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
		msgDiffTypeErr = "Nguy阯 li畊 c鵱g lo読 m緄 疬㧟 h䅟 th鄋h.",
		msgDiffGradeErr = "Nguy阯 li畊 c鵱g c m緄 疬㧟 h䅟 th鄋h.",
		msgLackMoney = "Ti玭 kh鬾g 瘘 #{_EXCHG%d}. ",
		msgLackStuff = "V ph h䅟 th鄋h m瞚 l ph鋓 l緉 h絥 2.",
		msgSlotEmpty = "H銀 疬a nguy阯 li畊 c h䅟 th鄋h v鄌.",				-- add by zchw
		maxGrade = 5,	-- 物品表里的等级，3级材料为4级，所以边界为5级 mark by cuiyinjie maxGrade add 1
		msgGradeLimited = "T痠 餫 穑t v鄌 nguy阯 li畊 c 3, nguy阯 li畊 c黙 c醕 h� kh鬾g th� ti猵 t鴆 h䅟 th鄋h.", --等级加1级
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
		msgDiffTypeErr = "C ph鋓 s� d鴑g Huy玭 Thi阯 H鄋 Ng鱟 瓞 h䅟 th鄋h.",
		msgDiffGradeErr = "C ph鋓 s� d鴑g c鵱g m祎 lo読 Huy玭 Thi阯 H鄋 Ng鱟 瓞 h䅟 th鄋h.",
		msgLackMoney = "Ti玭 kh鬾g 瘘 #{_EXCHG%d}. ",
		msgLackStuff = "V ph h䅟 th鄋h m瞚 l ph鋓 l緉 h絥 2.",
		msgSlotEmpty = "H銀 疬a Huy玭 Thi阯 H鄋 Ng鱟 c h䅟 th鄋h v鄌.",
		maxGrade = 2,
		msgGradeLimited = "C ph鋓 nh v鄌 c鵱g m祎 lo読 Huy玭 Thi阯 H鄋 Ng鱟, Huy玭 Thi阯 H鄋 Ng鱟 c黙 bg h鎢 kh鬾g th� ti猵 t鴆 h䅟 th鄋h.",
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

-- 注册事件
function Gemcompose_PreLoad()
	this:RegisterEvent("UI_COMMAND")						-- 激活界面事件

	this:RegisterEvent("UPDATE_COMPOSE_GEM")				-- 刷新宝石合成界面
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")				-- 背包中物品改变需要判断……
	this:RegisterEvent("OBJECT_CARED_EVENT")				-- 关注实施合成的 NPC
	this:RegisterEvent("RESUME_ENCHASE_GEM")				-- 合成完毕
	this:RegisterEvent("CLOSE_SYNTHESIZE_ENCHASE")			-- 关闭本界面
	-- this:RegisterEvent("TOGLE_SKILL_BOOK")				-- 打开门派技能界面是否需要关闭此界面
	-- this:RegisterEvent("TOGLE_COMMONSKILL_PAGE")			-- 打开普通技能界面是否需要关闭？
	-- this:RegisterEvent("CLOSE_SKILL_BOOK")				-- 关闭门派技能界面
	-- this:RegisterEvent("DISABLE_ENCHASE_ALL_GEM")		-- 所有合成相关的物品需要锁定
	-- this:RegisterEvent("UPDATE_COMPOSE_ITEM")			-- 物品合成界面打开，此界面是否需要关闭？
	-- this:RegisterEvent("OPEN_COMPOSE_ITEM")				-- 物品合成界面打开，此界面是否需要关闭？
	this:RegisterEvent("UNIT_MONEY");
	this:RegisterEvent("MONEYJZ_CHANGE")		--交子普及 Vega
	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	
end

-- 界面载入
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

-- 监控各种事件
function Gemcompose_OnEvent( event )
	if event == "UI_COMMAND" and tonumber( arg0 ) == 23 then	-- 宝石合成
		Gemcompose_Clear();			-- add by zchw
		if this : IsVisible() and Current ~= 1 then				-- 如果界面开着，则关掉
			Gemcompose_Close()
		end
		Gemcompose_SuccessValue : SetText("#cFF0000T� l� th鄋h c鬾g");
		Current = 1
		Gemcompose_DragTitle : SetText("#gFF0FA0H䅟 th鄋h b鋙 th誧h")
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

		--如果和NPC的距离大于一定距离或者被删除，自动关闭
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

-- 点击合成按钮
function Gemcompose_OK_Clicked()
	-- 根据当前所处的界面进行检查
	local Notify = 0;
	local CurrentRule = RuleTable[Current]
	if not CurrentRule then
		return
	end

	--判断电话密保和二级密码保护2012.6.8-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then			
		return
	end
	-- 判断是否为安全时间2012.6.8-LIUBO
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZYXT_120528_16}")
		return
	end
	
	--检查绑定状态
	--下面这一段是材料绑定提示，张宁写的有bug，全部注掉，采用新的逻辑
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
				--检查有没有绑定的物品
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

			-- 检查是否都是同种材料
			if Gemcompose_ItemInterface( ITEM_IN_SLOTS[i] ) ~= Current then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			if Type ~= Gemcompose_GetItemType( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			-- 检查材料是否等级相同
			if not CurrentRule[Grade] or Grade ~= Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffGradeErr )
				return
			end

			-- 检查材料是否是最高等级
			if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) >= RuleTable[Current].maxGrade then
				PushDebugMessage( CurrentRule.msgGradeLimited )
				return
			end
			--合成8，9级宝石功能关闭；放开8级宝石。[LiChengjie]
			if Current == 1 then
				if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) > 7 then
					PushDebugMessage( "#{BSHC_090313_1}" )
					return
				end
			end

			--- 礼金宝石合成功能关闭   --add by YGQ 通宝宝石合成开放 TT149838
			--if Gemcompose_IsLiJinGem( ITEM_IN_SLOTS[i] ) == 1 then
			--	PushDebugMessage( "#{LJSD_120508_41}" )
			--	return
			--end
		end
	end

	-- 检查身上的金钱是否足够
	local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < CurrentRule[Grade].MoneyCost then
		PushDebugMessage( string.format( CurrentRule.msgLackMoney, CurrentRule[Grade].MoneyCost ) )
		return
	end

	-- 检查材料数量是否足够
	if not CurrentRule[Grade].CountTable[materialCount] then
		PushDebugMessage( CurrentRule.msgLackStuff )
		return
	end

	-- 如果是宝石合成界面，则如果没有放入特殊材料将给出界面提示
	if Current == 1 then
		if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
--			local dialogStr = "如果不使用#{_ITEM" .. CurrentRule[Grade].SpecialStuff ..
--				"}进行合成的话，合成的成功率最高只有75％，您是否确定继续合成？"
--			LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
--				ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
--				ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6], 0, dialogStr )
			PushDebugMessage( "H䅟 th鄋h b鋙 th誧h c 穑t b鋙 th誧h h䅟 th鄋h ph�." )
			return
		end
	end

	LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
		ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
		ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6],(curSuccRate.."%") )
end

-- 点击取消或者关闭按钮
function Gemcompose_Cancel_Clicked()
	Gemcompose_Close()
	Gemcompose_StopCareObject()
end

-- 关闭界面
function Gemcompose_Close()
	this : Hide()
	Gemcompose_Clear()
end

-- 清空界面元素
function Gemcompose_Clear()
	Current = 0
	Type = -1
	Grade = -1
	Gemcompose_SuccessValue : SetText("#cFF0000T� l� th鄋h c鬾g")
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

-- 判断某个背包格子中的物品是否宝石
function Gemcompose_IsGem( bagPos )
	if PlayerPackage : IsGem( bagPos ) == 1 then
		return 1
	else
		return 0
	end
end

-- 判断某个背包格子中的物品是否材料
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

-- 得到某个背包格子中的物品的类型
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

-- 得到某个背包格子中的物品的等级
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

-- 得到当前界面应该匹配的特殊材料号
-- 如果不是宝石界面则返回 -1
-- 如果是宝石界面但是还没有放任何宝石则返回 -1
function Gemcompose_GetSpecialMaterial()
	local CurrentRule = RuleTable[Current]
	if CurrentRule then
		if CurrentRule[Grade] then
			return CurrentRule[Grade].SpecialStuff
		end
	end

	return -1
end

-- 判断某个背包格子中的物品属于那个界面，匹配 Current，没有匹配的用 0
-- 界面的当前状态 1：宝石合成 2：材料合成
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

-- 刷新合成界面上的物品
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

	if not this : IsVisible() then					-- 界面未打开
		return
	end

	-- 验证物品有效性
	local bagItem = EnumAction( bagPos, "packageitem" )
	if bagItem : GetID() == 0 then
		return
	end

	--是否是双属性宝石
	local bDoubleGem = DoubleGem: IsDoubleGem(bagPos)
	if bDoubleGem > 0 then
		PushDebugMessage("#{BSZK_121012_43}")
		return
	end
	--分期付款宝石
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( bagPos )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_55}")
		return
	end

	-- AxTrace( 0, 1, "Gemcompose_ItemInterface( bagPos )=".. Gemcompose_ItemInterface( bagPos ) )
	-- 找到 bagPos 的物品类型，来判断是否符合当前界面，否则没有任何提示
	if Gemcompose_ItemInterface( bagPos ) ~= Current then
		if Current == 1 then
			--没有放入宝石的时候，特殊材料需求返回-1；其他情况也需要提示材料不足
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

	-- 如果 bagPos 是当前界面需要的物品，找到该物品应该处在的格子范围
	-- 如果是宝石或者材料
	if Gemcompose_IsGem( bagPos ) == 1 or Gemcompose_IsMaterial( bagPos ) == 1 or PlayerPackage:GetItemTableIndex(bagPos) == 20310110 then
		-- AxTrace( 0, 1, "it's a main material." )
		-- 判断一下是否类型相同，不相同给出提示
		if Type ~= -1 then
			if Type ~= Gemcompose_GetItemType( bagPos ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end
		end

		-- 判断一下是否档次相同，如果不相同给出提示
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
				--一共5个格子，因为4个宝石用于合成，如果已经放了4个，剩余的格子数目也就小于2
				if nleftSpace < 2 then
					PushDebugMessage("#{BSQHB_120830_05}")
					return
				end
			end
		end

		if slot == 0 then						-- 自动寻找空格
			-- 从 1 ~ MATERIAL_COUNT 之间找一个空着的格子，如果没有空格子了，则返回
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
			-- 判断 bagPos 是否应该处在这个格子，格子不对则直接返回
			if slot < 1 or slot > MATERIAL_COUNT then
				return
			end
		end
	-- 如果是特殊材料
	elseif PlayerPackage : GetItemTableIndex( bagPos ) == Gemcompose_GetSpecialMaterial() then
		-- AxTrace( 0, 1, "it's a special material." )
		if slot == 0 then						-- 自动寻找空格
			-- 看看第 SPECIAL_MATERIAL_SLOT 个格子是否空着的格子，如果不是，则返回
			if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
				slot = SPECIAL_MATERIAL_SLOT
			else
				return
			end
		else
			-- 判断 bagPos 是否应该处在这个格子，格子不对则直接返回
			if slot ~= SPECIAL_MATERIAL_SLOT then
				if Current == 1 then
					PushDebugMessage( "#{BSQHB_120830_09}" )--请放入宝石合成符框
				else
					PushDebugMessage( "H銀 穑t v鄌 � nguy阯 li畊 穑c th�." )
				end
				return
			end
		end
	end

	-- AxTrace( 0, 1, "ITEM_IN_SLOTS[slot]=".. ITEM_IN_SLOTS[slot] )
	-- 把物品放到格子上
	-- 如果原来的格子有物品，则移除原来的物品
	if ITEM_IN_SLOTS[slot] ~= -1 then
		Gemcompose_Remove( slot )
	end

	-- 将本物品放到物品格，并锁定所在的背包格
	STUFF_SLOTS[slot] : SetActionItem( bagItem : GetID() )
	ITEM_IN_SLOTS[slot] = bagPos
	LifeAbility : Lock_Packet_Item( bagPos, 1 )

	if Type == -1 then
		Type = Gemcompose_GetItemType( bagPos )
	end

	if Grade == -1 then
		Grade = Gemcompose_GetItemGrade( bagPos )
	end

	-- 更新界面的成功率显示
	Gemcompose_RecalcSuccOdds()

	-- 如果物品不是特殊材料，并且当前的类型和档次都是 -1，则根据该物品进行相应设置，并据此显示金钱消耗
	if PlayerPackage : GetItemTableIndex( bagPos ) ~= Gemcompose_GetSpecialMaterial() then
		Gemcompose_RecalcCost()
	end
end

-- 移除一个材料
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

		if materialCount == 0 then					-- 没有材料了则移除特殊材料
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

-- 重新计算成功率
function Gemcompose_RecalcSuccOdds()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_SuccessValue : SetText("#cFF0000T� l� th鄋h c鬾g")
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
	local str = "#cFF0000T� l� th鄋h c鬾g: "

	if not currentRule.CountTable[materialCount] then
		curSuccRate = 0;
		str = str .. "Kh鬾g th� h䅟 th鄋h"
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

-- 重新计算金钱消耗
function Gemcompose_RecalcCost()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )
		return
	end

	Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( RuleTable[Current][Grade].MoneyCost ) )
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function Gemcompose_BeginCareObject( objCaredId )
	theNPC = DataPool : GetNPCIDByServerID( objCaredId )
	-- AxTrace( 0, 1, "theNPC0: " .. theNPC )
	if theNPC == -1 then
		PushDebugMessage("Ch遖 ph醫 hi畁 NPC")
		this : Hide()
		return
	end

	this : CareObject( theNPC, 1, "Gemcompose" )
end

--=========================================================
--停止对某NPC的关心
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

--- 判断是否是礼金宝石。这里使用了比较蛋疼的判断方法，就是名字里面是否有"·通"
function Gemcompose_IsLiJinGem( bagIdx )
    if bagIdx == nil or bagIdx == -1 then
        return 1
    end

    local specStr = " -Th鬾g"
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

--TAB界面切换，界面名字太坑了
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

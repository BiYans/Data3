--/* modified by cuiyinjie ����4�������ϳɹ��� */
local STUFF_SLOTS = {}										-- ��Ʒ��
local ITEM_IN_SLOTS = {}									-- ��Ʒ���е���Ʒ����λ��
local Current = 0											-- ����ĵ�ǰ״̬ 1����ʯ�ϳ� 2�����Ϻϳ� 3: ����ϳ�
local Type = -1												-- ��ǰ�ϳɵĲ�������
local Grade = -1											-- ��ǰ�ϳɵĲ��ϵ���
local theNPC = -1											-- ���� NPC
local MATERIAL_COUNT = 5									-- �źϳɲ��ϵĲ۵�����
local SLOT_COUNT = 6										-- �����ܷŶ����Ĳ۵�����
local SPECIAL_MATERIAL_SLOT = 6								-- ��������ϵĸ��Ӻ�
local MAX_OBJ_DISTANCE = 3.0

local LaskPack = {}

local curSuccRate = 0;
local RuleTable = {
	{
		msgDiffTypeErr = "B�o th�ch c�ng lo�i m�i c� th� h�p th�nh.",
		msgDiffGradeErr = "Ch� ���c h�p th�nh b�o th�ch ngang c�p",
		msgLackMoney = "Ti�n kh�ng �� #{_EXCHG%d}. ",
		msgLackStuff = "V�t ph�m h�p th�nh m�i l�n ph�i l�n h�n 2.",
		msgSlotEmpty = "H�y �t B�o Th�ch c�n h�p th�nh v�o.",         -- add  by zchw
		maxGrade = 9,
		msgGradeLimited = "B�o th�ch cao nh�t l� c�p 9, kh�ng th� h�p th�nh n�a.",
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
		msgDiffTypeErr = "Nguy�n li�u c�ng lo�i m�i ���c h�p th�nh.",
		msgDiffGradeErr = "Nguy�n li�u c�ng c�p m�i ���c h�p th�nh.",
		msgLackMoney = "Ti�n kh�ng �� #{_EXCHG%d}. ",
		msgLackStuff = "V�t ph�m h�p th�nh m�i l�n ph�i l�n h�n 2.",
		msgSlotEmpty = "H�y ��a nguy�n li�u c�n h�p th�nh v�o.",				-- add by zchw
		maxGrade = 5,	-- ��Ʒ����ĵȼ���3������Ϊ4�������Ա߽�Ϊ5�� mark by cuiyinjie maxGrade add 1
		msgGradeLimited = "T�i �a �t v�o nguy�n li�u c�p 3, nguy�n li�u c�a c�c h� kh�ng th� ti�p t�c h�p th�nh.", --�ȼ���1��
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
		msgDiffTypeErr = "C�n ph�i s� d�ng Huy�n Thi�n H�n Ng�c � h�p th�nh.",
		msgDiffGradeErr = "C�n ph�i s� d�ng c�ng m�t lo�i Huy�n Thi�n H�n Ng�c � h�p th�nh.",
		msgLackMoney = "Ti�n kh�ng �� #{_EXCHG%d}. ",
		msgLackStuff = "V�t ph�m h�p th�nh m�i l�n ph�i l�n h�n 2.",
		msgSlotEmpty = "H�y ��a Huy�n Thi�n H�n Ng�c c�n h�p th�nh v�o.",
		maxGrade = 2,
		msgGradeLimited = "C�n ph�i nh�p v�o c�ng m�t lo�i Huy�n Thi�n H�n Ng�c, Huy�n Thi�n H�n Ng�c c�a b�ng h�u kh�ng th� ti�p t�c h�p th�nh.",
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

-- ע���¼�
function Gemcompose_PreLoad()
	this:RegisterEvent("UI_COMMAND")						-- ��������¼�

	this:RegisterEvent("UPDATE_COMPOSE_GEM")				-- ˢ�±�ʯ�ϳɽ���
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")				-- ��������Ʒ�ı���Ҫ�жϡ���
	this:RegisterEvent("OBJECT_CARED_EVENT")				-- ��עʵʩ�ϳɵ� NPC
	this:RegisterEvent("RESUME_ENCHASE_GEM")				-- �ϳ����
	this:RegisterEvent("CLOSE_SYNTHESIZE_ENCHASE")			-- �رձ�����
	-- this:RegisterEvent("TOGLE_SKILL_BOOK")				-- �����ɼ��ܽ����Ƿ���Ҫ�رմ˽���
	-- this:RegisterEvent("TOGLE_COMMONSKILL_PAGE")			-- ����ͨ���ܽ����Ƿ���Ҫ�رգ�
	-- this:RegisterEvent("CLOSE_SKILL_BOOK")				-- �ر����ɼ��ܽ���
	-- this:RegisterEvent("DISABLE_ENCHASE_ALL_GEM")		-- ���кϳ���ص���Ʒ��Ҫ����
	-- this:RegisterEvent("UPDATE_COMPOSE_ITEM")			-- ��Ʒ�ϳɽ���򿪣��˽����Ƿ���Ҫ�رգ�
	-- this:RegisterEvent("OPEN_COMPOSE_ITEM")				-- ��Ʒ�ϳɽ���򿪣��˽����Ƿ���Ҫ�رգ�
	this:RegisterEvent("UNIT_MONEY");
	this:RegisterEvent("MONEYJZ_CHANGE")		--�����ռ� Vega
	
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	
end

-- ��������
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

-- ��ظ����¼�
function Gemcompose_OnEvent( event )
	if event == "UI_COMMAND" and tonumber( arg0 ) == 23 then	-- ��ʯ�ϳ�
		Gemcompose_Clear();			-- add by zchw
		if this : IsVisible() and Current ~= 1 then				-- ������濪�ţ���ص�
			Gemcompose_Close()
		end
		Gemcompose_SuccessValue : SetText("#cFF0000T� l� th�nh c�ng");
		Current = 1
		Gemcompose_DragTitle : SetText("#gFF0FA0H�p th�nh b�o th�ch")
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

		--�����NPC�ľ������һ��������߱�ɾ�����Զ��ر�
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

-- ����ϳɰ�ť
function Gemcompose_OK_Clicked()
	-- ���ݵ�ǰ�����Ľ�����м��
	local Notify = 0;
	local CurrentRule = RuleTable[Current]
	if not CurrentRule then
		return
	end

	--�жϵ绰�ܱ��Ͷ������뱣��2012.6.8-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then			
		return
	end
	-- �ж��Ƿ�Ϊ��ȫʱ��2012.6.8-LIUBO
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{ZYXT_120528_16}")
		return
	end
	
	--����״̬
	--������һ���ǲ��ϰ���ʾ������д����bug��ȫ��ע���������µ��߼�
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
				--�����û�а󶨵���Ʒ
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

			-- ����Ƿ���ͬ�ֲ���
			if Gemcompose_ItemInterface( ITEM_IN_SLOTS[i] ) ~= Current then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			if Type ~= Gemcompose_GetItemType( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end

			-- �������Ƿ�ȼ���ͬ
			if not CurrentRule[Grade] or Grade ~= Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) then
				PushDebugMessage( CurrentRule.msgDiffGradeErr )
				return
			end

			-- �������Ƿ�����ߵȼ�
			if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) >= RuleTable[Current].maxGrade then
				PushDebugMessage( CurrentRule.msgGradeLimited )
				return
			end
			--�ϳ�8��9����ʯ���ܹرգ��ſ�8����ʯ��[LiChengjie]
			if Current == 1 then
				if Gemcompose_GetItemGrade( ITEM_IN_SLOTS[i] ) > 7 then
					PushDebugMessage( "#{BSHC_090313_1}" )
					return
				end
			end

			--- ���ʯ�ϳɹ��ܹر�   --add by YGQ ͨ����ʯ�ϳɿ��� TT149838
			--if Gemcompose_IsLiJinGem( ITEM_IN_SLOTS[i] ) == 1 then
			--	PushDebugMessage( "#{LJSD_120508_41}" )
			--	return
			--end
		end
	end

	-- ������ϵĽ�Ǯ�Ƿ��㹻
	local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < CurrentRule[Grade].MoneyCost then
		PushDebugMessage( string.format( CurrentRule.msgLackMoney, CurrentRule[Grade].MoneyCost ) )
		return
	end

	-- �����������Ƿ��㹻
	if not CurrentRule[Grade].CountTable[materialCount] then
		PushDebugMessage( CurrentRule.msgLackStuff )
		return
	end

	-- ����Ǳ�ʯ�ϳɽ��棬�����û�з���������Ͻ�����������ʾ
	if Current == 1 then
		if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
--			local dialogStr = "�����ʹ��#{_ITEM" .. CurrentRule[Grade].SpecialStuff ..
--				"}���кϳɵĻ����ϳɵĳɹ������ֻ��75�������Ƿ�ȷ�������ϳɣ�"
--			LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
--				ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
--				ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6], 0, dialogStr )
			PushDebugMessage( "H�p th�nh b�o th�ch c�n �t b�o th�ch h�p th�nh ph�." )
			return
		end
	end

	LifeAbility : Do_Combine( ITEM_IN_SLOTS[1], ITEM_IN_SLOTS[2],
		ITEM_IN_SLOTS[3], ITEM_IN_SLOTS[4],
		ITEM_IN_SLOTS[5], ITEM_IN_SLOTS[6],(curSuccRate.."%") )
end

-- ���ȡ�����߹رհ�ť
function Gemcompose_Cancel_Clicked()
	Gemcompose_Close()
	Gemcompose_StopCareObject()
end

-- �رս���
function Gemcompose_Close()
	this : Hide()
	Gemcompose_Clear()
end

-- ��ս���Ԫ��
function Gemcompose_Clear()
	Current = 0
	Type = -1
	Grade = -1
	Gemcompose_SuccessValue : SetText("#cFF0000T� l� th�nh c�ng")
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

-- �ж�ĳ�����������е���Ʒ�Ƿ�ʯ
function Gemcompose_IsGem( bagPos )
	if PlayerPackage : IsGem( bagPos ) == 1 then
		return 1
	else
		return 0
	end
end

-- �ж�ĳ�����������е���Ʒ�Ƿ����
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

-- �õ�ĳ�����������е���Ʒ������
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

-- �õ�ĳ�����������е���Ʒ�ĵȼ�
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

-- �õ���ǰ����Ӧ��ƥ���������Ϻ�
-- ������Ǳ�ʯ�����򷵻� -1
-- ����Ǳ�ʯ���浫�ǻ�û�з��κα�ʯ�򷵻� -1
function Gemcompose_GetSpecialMaterial()
	local CurrentRule = RuleTable[Current]
	if CurrentRule then
		if CurrentRule[Grade] then
			return CurrentRule[Grade].SpecialStuff
		end
	end

	return -1
end

-- �ж�ĳ�����������е���Ʒ�����Ǹ����棬ƥ�� Current��û��ƥ����� 0
-- ����ĵ�ǰ״̬ 1����ʯ�ϳ� 2�����Ϻϳ�
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

-- ˢ�ºϳɽ����ϵ���Ʒ
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

	if not this : IsVisible() then					-- ����δ��
		return
	end

	-- ��֤��Ʒ��Ч��
	local bagItem = EnumAction( bagPos, "packageitem" )
	if bagItem : GetID() == 0 then
		return
	end

	--�Ƿ���˫���Ա�ʯ
	local bDoubleGem = DoubleGem: IsDoubleGem(bagPos)
	if bDoubleGem > 0 then
		PushDebugMessage("#{BSZK_121012_43}")
		return
	end
	--���ڸ��ʯ
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( bagPos )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_55}")
		return
	end

	-- AxTrace( 0, 1, "Gemcompose_ItemInterface( bagPos )=".. Gemcompose_ItemInterface( bagPos ) )
	-- �ҵ� bagPos ����Ʒ���ͣ����ж��Ƿ���ϵ�ǰ���棬����û���κ���ʾ
	if Gemcompose_ItemInterface( bagPos ) ~= Current then
		if Current == 1 then
			--û�з��뱦ʯ��ʱ������������󷵻�-1���������Ҳ��Ҫ��ʾ���ϲ���
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

	-- ��� bagPos �ǵ�ǰ������Ҫ����Ʒ���ҵ�����ƷӦ�ô��ڵĸ��ӷ�Χ
	-- ����Ǳ�ʯ���߲���
	if Gemcompose_IsGem( bagPos ) == 1 or Gemcompose_IsMaterial( bagPos ) == 1 or PlayerPackage:GetItemTableIndex(bagPos) == 20310110 then
		-- AxTrace( 0, 1, "it's a main material." )
		-- �ж�һ���Ƿ�������ͬ������ͬ������ʾ
		if Type ~= -1 then
			if Type ~= Gemcompose_GetItemType( bagPos ) then
				PushDebugMessage( CurrentRule.msgDiffTypeErr )
				return
			end
		end

		-- �ж�һ���Ƿ񵵴���ͬ���������ͬ������ʾ
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
				--һ��5�����ӣ���Ϊ4����ʯ���ںϳɣ�����Ѿ�����4����ʣ��ĸ�����ĿҲ��С��2
				if nleftSpace < 2 then
					PushDebugMessage("#{BSQHB_120830_05}")
					return
				end
			end
		end

		if slot == 0 then						-- �Զ�Ѱ�ҿո�
			-- �� 1 ~ MATERIAL_COUNT ֮����һ�����ŵĸ��ӣ����û�пո����ˣ��򷵻�
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
			-- �ж� bagPos �Ƿ�Ӧ�ô���������ӣ����Ӳ�����ֱ�ӷ���
			if slot < 1 or slot > MATERIAL_COUNT then
				return
			end
		end
	-- ������������
	elseif PlayerPackage : GetItemTableIndex( bagPos ) == Gemcompose_GetSpecialMaterial() then
		-- AxTrace( 0, 1, "it's a special material." )
		if slot == 0 then						-- �Զ�Ѱ�ҿո�
			-- ������ SPECIAL_MATERIAL_SLOT �������Ƿ���ŵĸ��ӣ�������ǣ��򷵻�
			if ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] and ITEM_IN_SLOTS[SPECIAL_MATERIAL_SLOT] == -1 then
				slot = SPECIAL_MATERIAL_SLOT
			else
				return
			end
		else
			-- �ж� bagPos �Ƿ�Ӧ�ô���������ӣ����Ӳ�����ֱ�ӷ���
			if slot ~= SPECIAL_MATERIAL_SLOT then
				if Current == 1 then
					PushDebugMessage( "#{BSQHB_120830_09}" )--����뱦ʯ�ϳɷ���
				else
					PushDebugMessage( "H�y �t v�o � nguy�n li�u �c th�." )
				end
				return
			end
		end
	end

	-- AxTrace( 0, 1, "ITEM_IN_SLOTS[slot]=".. ITEM_IN_SLOTS[slot] )
	-- ����Ʒ�ŵ�������
	-- ���ԭ���ĸ�������Ʒ�����Ƴ�ԭ������Ʒ
	if ITEM_IN_SLOTS[slot] ~= -1 then
		Gemcompose_Remove( slot )
	end

	-- ������Ʒ�ŵ���Ʒ�񣬲��������ڵı�����
	STUFF_SLOTS[slot] : SetActionItem( bagItem : GetID() )
	ITEM_IN_SLOTS[slot] = bagPos
	LifeAbility : Lock_Packet_Item( bagPos, 1 )

	if Type == -1 then
		Type = Gemcompose_GetItemType( bagPos )
	end

	if Grade == -1 then
		Grade = Gemcompose_GetItemGrade( bagPos )
	end

	-- ���½���ĳɹ�����ʾ
	Gemcompose_RecalcSuccOdds()

	-- �����Ʒ����������ϣ����ҵ�ǰ�����ͺ͵��ζ��� -1������ݸ���Ʒ������Ӧ���ã����ݴ���ʾ��Ǯ����
	if PlayerPackage : GetItemTableIndex( bagPos ) ~= Gemcompose_GetSpecialMaterial() then
		Gemcompose_RecalcCost()
	end
end

-- �Ƴ�һ������
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

		if materialCount == 0 then					-- û�в��������Ƴ��������
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

-- ���¼���ɹ���
function Gemcompose_RecalcSuccOdds()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_SuccessValue : SetText("#cFF0000T� l� th�nh c�ng")
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
	local str = "#cFF0000T� l� th�nh c�ng: "

	if not currentRule.CountTable[materialCount] then
		curSuccRate = 0;
		str = str .. "Kh�ng th� h�p th�nh"
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

-- ���¼����Ǯ����
function Gemcompose_RecalcCost()
	if not RuleTable[Current] or not RuleTable[Current][Grade] then
		Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )
		return
	end

	Gemcompose_NeedMoney : SetProperty( "MoneyNumber", tostring( RuleTable[Current][Grade].MoneyCost ) )
end

--=========================================================
--��ʼ����NPC��
--�ڿ�ʼ����֮ǰ��Ҫ��ȷ����������ǲ����Ѿ��С����ġ���NPC��
--����еĻ�����ȡ���Ѿ��еġ����ġ�
--=========================================================
function Gemcompose_BeginCareObject( objCaredId )
	theNPC = DataPool : GetNPCIDByServerID( objCaredId )
	-- AxTrace( 0, 1, "theNPC0: " .. theNPC )
	if theNPC == -1 then
		PushDebugMessage("Ch�a ph�t hi�n NPC")
		this : Hide()
		return
	end

	this : CareObject( theNPC, 1, "Gemcompose" )
end

--=========================================================
--ֹͣ��ĳNPC�Ĺ���
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

--- �ж��Ƿ������ʯ������ʹ���˱Ƚϵ��۵��жϷ������������������Ƿ���"��ͨ"
function Gemcompose_IsLiJinGem( bagIdx )
    if bagIdx == nil or bagIdx == -1 then
        return 1
    end

    local specStr = " -Th�ng"
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

--TAB�����л�����������̫����
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

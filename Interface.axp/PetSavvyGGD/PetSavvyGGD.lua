-- PetSavvyGGD.lua
-- 珍兽提升悟性（用根骨丹）

local mainPet = { idx = -1, guid = { high = -1, low = -1 } }
local assisPet = { idx = -1, guid = { high = -1, low =-1 } }

local theNPC = -1													-- 功能 NPC
local MAX_OBJ_DISTANCE = 3.0

local currentChoose = -1

local moneyCosts = {													-- 索引是珍兽的当前悟性值
	[0] = 100,
	[1] = 110,
	[2] = 121,
	[3] = 133,
	[4] = 146,
	[5] = 161,
	[6] = 177,
	[7] = 194,
	[8] = 214,
	[9] = 235,
	[10] = 25937,
	[11] = 28531,
	[12] = 31384,
	[13] = 34523,
	[14] = 37975,
}

local WX_10 = 0
local WX_15 = 1
local UI_TYPE = 0

function PetSavvyGGD_PreLoad()
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "REPLY_MISSION_PET" )				-- 玩家从列表选定一只珍兽
	this : RegisterEvent( "UPDATE_PET_PAGE" )					-- 玩家身上的珍兽数据发生变化
	this : RegisterEvent( "DELETE_PET" )							-- 玩家身上减少一只珍兽
	this : RegisterEvent( "OBJECT_CARED_EVENT" )			-- 关心 NPC 的存在和范围
	this : RegisterEvent( "UNIT_MONEY" );
	this : RegisterEvent( "MONEYJZ_CHANGE" )					--交子普及 Vega
	this : RegisterEvent( "OPEN_EXCHANGE_FRAME" );		--打开交易界面
end

function PetSavvyGGD_OnLoad()
	PetSavvyGGD_Clear()
end


function PetSavvyGGD_OK_Clicked()
	-- 首先判定玩家是否放入需要提升的珍兽，如果没有放入NPC将会弹出对话并返回：
	if mainPet.idx == -1 then
	-- 请放入您要提升悟性等级的珍兽。
		ShowSystemTipInfo( "M秈 c醕 h� nh y陁 c c n鈔g cao nh th裞 th� qu� c黙 b課." )
		return
	end

	-- 判定玩家的金钱是否足够，如果不够将会弹出对话。
	local savvy = Pet : GetSavvy( mainPet.idx )
	local cost = moneyCosts[savvy]
	if not cost then
		cost = 0
	end

	-- 您的金钱不足，请确认
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ");	--交子普及 Vega
	if selfMoney < cost then
		ShowSystemTipInfo( "Ng鈔 l唼ng c黙 c醕 h� kh鬾g 瘘, m秈 x醕 nh." )
		return
	end

	--检查根骨丹
	local nSavvyNeed = savvy+1;
	local nItemIdGenGuDan = 0;
	local nItemIdGenGuDanBind = 0; --绑定的根骨丹
	local msgTemp;

	if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
		msgTemp = "Th";
		nItemIdGenGuDan = 30502000;
		nItemIdGenGuDanBind = 30504038;
	elseif nSavvyNeed >= 4 and nSavvyNeed <= 6 then
		msgTemp = "Trung"
		nItemIdGenGuDan = 30502001;
	elseif nSavvyNeed >= 7 and nSavvyNeed <= 10 then
		msgTemp = "Cao"
		nItemIdGenGuDan = 30502002;
	elseif nSavvyNeed >= 11 and nSavvyNeed <= 15 then
		msgTemp = "Si陁"
		nItemIdGenGuDan = 30502004;
	end

	local bExist = IsItemExist( nItemIdGenGuDan );
	if(bExist <= 0 and nItemIdGenGuDanBind ~= 0) then
		bExist = IsItemExist( nItemIdGenGuDanBind );
	end

	if bExist <= 0 then
		local msg = "N鈔g ng� t韓h 皙n "..nSavvyNeed.."C "..msgTemp.." c c錸 c痶 餫n. ";
		PetSavvyGGD_GGD : SetText( msg );
		SetNotifyTip( msg );
		return;
	end

	-- 发送 UI_Command 进行合成
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "PetSavvy" )
		Set_XSCRIPT_ScriptID( 800106 )
		Set_XSCRIPT_Parameter( 0, mainPet.guid.high )
		Set_XSCRIPT_Parameter( 1, mainPet.guid.low )
		Set_XSCRIPT_ParamCount( 2 )
	Send_XSCRIPT()

end

-- 关闭、取消
function PetSavvyGGD_Cancel_Clicked()
	this : Hide()
end

-- 选择珍兽
function PetSavvyGGD_SelectPet( petIdx )
	if -1 == petIdx then
		return
	end

	local petName = Pet : GetPetList_Appoint( petIdx )
	local guidH, guidL = Pet : GetGUID( petIdx )


	-- 如果原来已经选择了一个被提升的宠
	-- 则清空原来的数据
	PetSavvyGGD_RemoveMainPet()

	local savvy = Pet : GetSavvy( petIdx )
	local nGen = Pet:GetType(petIdx) ;

	if UI_TYPE == WX_10 then
		if savvy <=9 then
			-- 将珍兽名字填到文本框中
			PetSavvyGGD_Pet : SetText( petName )
			-- 给珍兽上锁，设置珍兽已经提交到3号界面容器
			Pet : SetPetLocation( petIdx, 3 )
			-- 更新珍兽列表界面
			--Pet:UpdatePetList()
		else
			PetSavvyGGD_Pet : SetText( "" )
			PetSavvyGGD_GGD : SetText( "" )
			PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", 0 )
			PetSavvyGGD_Text2 : SetText( "Kh鬾g c� c醕h n鄌 th錸g c" )
			PetSavvyGGD_OK:Disable();
			return
		end
	end

	if UI_TYPE == WX_15 then

		PetSavvyGGD_Pet : SetText( "" )
		PetSavvyGGD_GGD : SetText( "" )
		PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", 0 )
		PetSavvyGGD_Text2 : SetText( "" )
		PetSavvyGGD_OK:Disable();

		--幻化珍兽
		if nGen >= 100 then
			if savvy < 15 then
				if savvy >= 10 then
					-- 将珍兽名字填到文本框中
					PetSavvyGGD_Pet : SetText( petName )
					-- 给珍兽上锁，设置珍兽已经提交到3号界面容器
					Pet : SetPetLocation( petIdx, 3 )
					-- 更新珍兽列表界面
					--Pet:UpdatePetList()
				else
					SetNotifyTip("#{RXZS_090804_26}")	--悟性≥10的珍兽才能使用超级根骨丹提升悟性。
					return
				end
			else
				--幻化珍兽悟性大于14就不能再提升了....
				SetNotifyTip("#{RXZS_090804_27}")	--你的珍兽悟性已提升到15，不能再向上提升了。
				return
			end
		else
			--非幻化珍兽
			SetNotifyTip("#{RXZS_090804_25}")	--只有幻化后，且悟性≥10的珍兽才能使用超级根骨丹提升悟性。
			return
		end
	end

	-- 记录该宠的位置号、GUID
	mainPet.idx = petIdx
	mainPet.guid.high = guidH
	mainPet.guid.low = guidL

	--更新金钱和几率显示
	PetSavvyGGD_CalcSuccOdds()
	PetSavvyGGD_CalcCost()
	--检查 跟骨 丹
	local nSavvyNeed = savvy+1;
	local nItemIdGenGuDan = 0;
	local msgTemp;

	if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
		msgTemp = "Th";
	elseif nSavvyNeed >= 4 and nSavvyNeed <= 6 then
		msgTemp = "Trung"
	elseif nSavvyNeed >= 7 and nSavvyNeed <= 10 then
		msgTemp = "Cao"
	elseif nSavvyNeed >= 11 and nSavvyNeed <= 15 then
		msgTemp = "Si陁"
	end

	local bExist = IsItemExist( nItemIdGenGuDan );

	if bExist <= 0 then
		local msg = "N鈔g ng� t韓h 皙n "..nSavvyNeed.."C "..msgTemp.." c c錸 c痶 餫n. ";
		PetSavvyGGD_GGD : SetText( msg );
		return;
	end

end

function PetSavvyGGD_OnEvent(event)

	--PushDebugMessage("PetSavvyGGD : "..event);

	if event == "UI_COMMAND" and tonumber( arg0 ) == 19820425 then	-- 打开界面
		if this : IsVisible() then									-- 如果界面开着，则不处理
			return
		end
		UI_TYPE = WX_10
		PetSavvyGGD_Text:SetText("#{INTERFACE_XML_1030}")

		this : Show()
		PetSavvyGGD_Pet : SetText( "" )
		PetSavvyGGD_Text2 : SetText( "" )
		PetSavvyGGD_NeedMoney:SetProperty("MoneyNumber", tostring(0));
		local npcObjId = Get_XParam_INT( 0 )
		BeginCareObject( npcObjId )
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		PetSavvyGGD_OK:Disable();
		return
	end

	if event == "UI_COMMAND" and tonumber(arg0) == 20090812 then
		if this : IsVisible() then									-- 如果界面开着，则不处理
			return
		end
		UI_TYPE = WX_15
		PetSavvyGGD_Text:SetText("#{RXZS_XML_32}")

		this : Show()
		PetSavvyGGD_Pet : SetText( "" )
		PetSavvyGGD_Text2 : SetText( "" )
		PetSavvyGGD_NeedMoney:SetProperty("MoneyNumber", tostring(0));
		local npcObjId = Get_XParam_INT( 0 )
		BeginCareObject( npcObjId )
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		PetSavvyGGD_OK:Disable();
		return

	end

	-- 玩家选了一只珍兽
	if ( event == "REPLY_MISSION_PET" and this:IsVisible() )then
		PetSavvyGGD_GGD : SetText( "" );
		PetSavvyGGD_SelectPet( tonumber( arg0 ) )

		PetSavvyGGD_SelfMoney_Text:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- 玩家身上的珍兽数据发生变化，包括珍兽出战、休息、增加一只珍兽
	if event == "UPDATE_PET_PAGE" and this : IsVisible() then
		PetSavvyGGD_UpdateSelected()
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- 玩家身上减少一只珍兽
	if event == "DELETE_PET" and this : IsVisible() then
		PetSavvyGGD_UpdateSelected()
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- 关心 NPC 的存在和范围
	if event == "OBJECT_CARED_EVENT" and this : IsVisible() then
		Pet : ShowPetList( 0 )
		if tonumber( arg0 ) ~= theNPC then
			return
		end

		--如果和NPC的距离大于一定距离或者被删除，自动关闭
		if arg1 == "distance" and tonumber( arg2 ) > MAX_OBJ_DISTANCE or arg1 == "destroy" then
			PetSavvyGGD_Cancel_Clicked()
		end
		return
	end

	if (event == "UNIT_MONEY" and this:IsVisible()) then
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
	end

	if (event == "MONEYJZ_CHANGE" and this:IsVisible()) then
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
	end

	-- 打开交易界面的同时关闭该界面，但是需要刷新一下珍兽列表
	if (event == "OPEN_EXCHANGE_FRAME" and this:IsVisible()) then
		StopCareObject()
		PetSavvyGGD_Clear()
		Pet : ShowPetList( 0 )
		Pet : ShowPetList( 1 )
		this:Hide()
	end

end

function PetSavvyGGD_Choose_Clicked( type )

	-- 关一下再开，清空数据
	Pet : ShowPetList( 0 )
	Pet : ShowPetList( 1 )
end


function PetSavvyGGD_Close()
	Pet : ShowPetList( 0 )
	StopCareObject()
	PetSavvyGGD_Clear()
end

function PetSavvyGGD_RemoveMainPet()
	if mainPet.idx ~= -1 then
		Pet : SetPetLocation( mainPet.idx, -1 )
		-- 更新珍兽列表界面
		--Pet:UpdatePetList()
	end

	mainPet.idx = -1
	mainPet.guid.high = -1
	mainPet.guid.low = -1
end

function PetSavvyGGD_Clear()
	PetSavvyGGD_RemoveMainPet()

	PetSavvyGGD_GGD : SetText( "" );
	PetSavvyGGD_Pet : SetText( "" );
	PetSavvyGGD_Text2 : SetText( "#cFF0000T� l� th鄋h c鬾g" )
	PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )

	PetSavvyGGD_OK : Disable()

	currentChoose = -1
end

-- 计算成功率
function PetSavvyGGD_CalcSuccOdds()
	if mainPet.idx == -1 then
		PetSavvyGGD_Text2 : SetText( "#cFF0000T� l� th鄋h c鬾g" )
		PetSavvyGGD_OK : Disable()
		return
	end

	succOdds = {													-- 索引是珍兽的当前悟性值
		[0] = 1000,
		[1] = 850,
		[2] = 750,
		[3] = 600,
		[4] = 200,
		[5] = 310,
		[6] = 310,
		[7] = 30,
		[8] = 70,
		[9] = 100,
		[10] = 30,
		[11] = 30,
		[12] = 30,
		[13] = 30,
		[14] = 30,

	}

	local savvy = Pet : GetSavvy( mainPet.idx )
	local str = "#cFF0000"
	local odds = succOdds[savvy]
	if not odds then
		str = "Kh鬾g c� c醕h n鄌 th錸g c"
		PetSavvyGGD_OK : Disable()
	else
		str = str .. math.floor( odds / 10 ) .. "%"
		PetSavvyGGD_OK : Enable()
	end

	PetSavvyGGD_Text2 : SetText( str )
end

-- 计算金钱消耗
function PetSavvyGGD_CalcCost()
	if mainPet.idx == -1 then
		PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )
		return
	end

	local savvy = Pet : GetSavvy( mainPet.idx )
	local cost = moneyCosts[savvy]
	if not cost then
		cost = 0
	end

	PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", tostring( cost ) )
end


function PetSavvyGGD_UpdateSelected()

	-- 判断被选中的珍兽是否还在背包里
	if mainPet.idx ~= -1 then
		local newIdx = Pet : GetPetIndexByGUID( mainPet.guid.high, mainPet.guid.low )

		-- 如果不在则删掉
		if newIdx == -1 then
			mainPet.idx = -1
			mainPet.guid.high = -1
			mainPet.guid.low = -1
			PetSavvyGGD_Pet : SetText( "" )
			PetSavvyGGD_Text2 : SetText( "#cFF0000T� l� th鄋h c鬾g" )
			PetSavvyGGD_OK : Disable()
		-- 否则判断珍兽的位置是否发生变化
		elseif newIdx ~= mainPet.idx then
			-- 如果发生变化则对位置进行更新
			mainPet.idx = newIdx
		end
	end

	PetSavvyGGD_SelectPet( mainPet.idx );

end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function BeginCareObject( objCaredId )
	theNPC = DataPool : GetNPCIDByServerID( objCaredId )
	if theNPC == -1 then
		PushDebugMessage("Ch遖 ph醫 hi畁 NPC")
		this : Hide()
		return
	end

	this : CareObject( theNPC, 1, "PetSavvyGGD" )
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function StopCareObject()
	this : CareObject( theNPC, 0, "PetSavvyGGD" )
	Pet : ShowPetList( 0 )
	theNPC = -1
end

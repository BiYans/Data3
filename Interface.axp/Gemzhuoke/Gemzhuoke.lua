--*********************
--减抗双属性石头合成界面
--写的太太太恶心了，待整理
--TODO 需要多少钱，什么时候显示，显示有问题
--*********************

local MAX_OBJ_DISTANCE = 3.0;
local ObjCaredIDID = -1

local g_Gemzhuoke_Frame_UnifiedPosition;

local Gemzhuoke_MainABT = "";
local Gemzhuoke_MainID = -1;
local Gemzhuoke_MainPos = -1;

local Gemzhuoke_AssistABT = {};
local Gemzhuoke_AssistID = {-1, -1, -1, -1};
local Gemzhuoke_AssistPos = {-1, -1, -1, -1};

local Gemzhuoke_MaterABT = ""
local Gemzhuoke_MaterID = -1;
local Gemzhuoke_MaterPos = -1;

local Gemzhuoke_ProductABT = ""
local Gemzhuoke_ProductID = -1--无实物

local g_NeedMoney = 50000; --5J

local g_TipsKinds={
"Thu T竛h Ho鄋g Tinh Th誧h","Thu T竛h Lam Tinh Th誧h","Thu T竛h H皀g Tinh Th誧h","Thu T竛h L鴆 Tinh Th誧h",
"Thu T竛h Ho鄋g Tinh Th誧h-Th鬾g B鋙","Thu T竛h Lam Tinh Th誧h-Th鬾g B鋙","Thu T竛h H皀g Tinh Th誧h-Th鬾g B鋙","Thu T竛h L鴆 Tinh Th誧h-Th鬾g B鋙"--暂时不用字典，待确认
}
local g_ZhuoKeFu={38000446, 38000445}--不绑定，绑定
local g_ShowBind = 0;


function Gemzhuoke_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("UPDATE_DOUBLEGEM_ZHUOKE");
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")				-- 背包中物品改变需要判断…
	this:RegisterEvent("RESUME_ENCHASE_GEM")

	this:RegisterEvent("UNIT_MONEY");
	this:RegisterEvent("MONEYJZ_CHANGE")		--交子普及 Vega
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end


function Gemzhuoke_OnLoad()
	Gemzhuoke_MainABT = Gemzhuoke_Object;
	Gemzhuoke_AssistABT =	{
		Gemzhuoke_Object2, Gemzhuoke_Object3, Gemzhuoke_Object4, Gemzhuoke_Object5,
	}
	Gemzhuoke_MaterABT = Gemzhuoke_Object6;
	Gemzhuoke_ProductABT = Gemzhuoke_Object7;
	g_Gemzhuoke_Frame_UnifiedPosition=Gemzhuoke_Frame:GetProperty("UnifiedPosition");
end


function Gemzhuoke_OnEvent( event )
	if ( event=="UI_COMMAND" and tonumber(arg0) == 201210120 ) then
	
		local npcObjId = tonumber(Variable:GetVariable("GemNPCObjId"));
		Variable:SetVariable("GemNPCObjId", "", 1)
		if(npcObjId == nil) then
			npcObjId = Get_XParam_INT( 0 )
		end
		
		ObjCaredID = DataPool : GetNPCIDByServerID(npcObjId);
		if ObjCaredID == -1 then
				PushDebugMessage("Error!");
				return;
		end
		ObjCaredIDID = npcObjId
		Gemzhuoke_BeginCareObject()
		Gemzhuoke_Clear(1)
		Gemzhuoke_ShowMoneyInfo()
		g_ShowBind=0
		local GemUnionPos = Variable:GetVariable("GemUnionPos");
		if(GemUnionPos ~= nil) then
		  Gemzhuoke_Frame:SetProperty("UnifiedPosition", GemUnionPos);
		end
		Gemzhuoke_FenYe4:SetCheck(1)
		this:Show();
	elseif (event=="UPDATE_DOUBLEGEM_ZHUOKE") and this : IsVisible() then
		if arg0 == nil or arg1 == nil or arg2==nil then
			return
		end
		--arg0 是UI的第几个位置
		--arg1 是背包的格子
		local moveType=tostring(arg0)
		local pos_packet = tonumber(arg1)
		local dg_dest = tonumber(arg2)
		g_ShowBind=0

		Gemzhuoke_Update(moveType, pos_packet,dg_dest);
		g_ShowBind=0
	elseif (event=="PACKAGE_ITEM_CHANGED") and this : IsVisible() then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end
		local pos=tonumber(arg0)
		if ( Gemzhuoke_MainPos == pos ) then
			Gemzhuoke_Resume_RBClick(0)
		end

		if ( Gemzhuoke_MaterPos == pos ) then
			Gemzhuoke_Resume_RBClick(5)
		end

		for i=1, table.getn(Gemzhuoke_AssistPos) do
			if (Gemzhuoke_AssistPos[i]==pos) then
				Gemzhuoke_Resume_RBClick(i)
				return
			end
		end
		g_ShowBind=0
	elseif (event=="RESUME_ENCHASE_GEM") and this : IsVisible() then
		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end
		local pos=tonumber(arg0)-120
		Gemzhuoke_Resume_RBClick(pos)
		g_ShowBind=0
	elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then

		if(tonumber(arg0) ~= ObjCaredID) then
			return;
		end

		--如果和NPC的距离大于一定距离或者被删除，自动关闭
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			Gemzhuoke_OnHiden()
		end
	elseif ( event == "UNIT_MONEY" or event =="MONEYJZ_CHANGE") and this:IsVisible() then
		Gemzhuoke_ShowMoneyInfo()
	elseif (event == "ADJEST_UI_POS" )  then
		Gemzhuoke_Frame_On_ResetPos()
		
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		Gemzhuoke_Frame_On_ResetPos()
	end
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function Gemzhuoke_BeginCareObject()
	this:CareObject(ObjCaredID, 1, "Gemzhuoke");
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function Gemzhuoke_StopCareObject()
	this:CareObject(ObjCaredID, 0, "Gemzhuoke");
end

--=========================================================
--重置界面
--=========================================================
function Gemzhuoke_Clear(all)

	if (Gemzhuoke_MainPos ~= -1) then
		LifeAbility : Lock_Packet_Item(Gemzhuoke_MainPos,0);
		Gemzhuoke_MainPos = -1;
		Gemzhuoke_MainID = -1;
	end
	Gemzhuoke_MainABT:SetActionItem(-1);
	for i=1,4 do
		if (Gemzhuoke_AssistPos[i] ~= -1) then
			LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[i],0);
			Gemzhuoke_AssistPos[i] = -1;
			Gemzhuoke_AssistID[i] = -1;
		end
	end
	if all==1 then
		if (Gemzhuoke_MaterPos ~= -1) then
			LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos,0);
			Gemzhuoke_MaterPos = -1;
			Gemzhuoke_MaterID = -1;
		end
		Gemzhuoke_MaterABT : SetActionItem(-1);
	end

	for i=1, 4 do
		Gemzhuoke_AssistABT[i] : SetActionItem(-1);
	end
	Gemzhuoke_ProductABT : SetActionItem(-1);
	Gemzhuoke_ProductID=-1
	--Gemzhuoke_ProductABT :Hide();

	--Gemzhuoke_DemandMoney : SetProperty("MoneyNumber", "")
	Gemzhuoke_SelfMoney: SetProperty("MoneyNumber", Player:GetData("MONEY"))
	Gemzhuoke_SelfJiaozi: SetProperty("MoneyNumber", Player:GetData("MONEY_JZ"))

	Gemzhuoke_OK:Disable();
	g_ShowBind=0
end

--=========================================================
--更新界面
--=========================================================
function Gemzhuoke_Update( moveType, pos_packet, dg_dest )

	local theAction = EnumAction(pos_packet, "packageitem");
	if (theAction:GetID() == 0) then
		return
	end

	--宝石槽位
	if moveType == "rbclick1" then
		--锁逻辑在代码中进行了判断
		--必须是宝石....
		local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
		if Item_Class ~= 5 then
--			PushDebugMessage("需要放入宝石TODO")--wy等字典 等表述
			return
		end
		local nIsBPGem = BudgetPlanGem:IsBudgetPlanGem(pos_packet)
		if nIsBPGem > 0 then
			PushDebugMessage("#{FQBS_140508_61}")
			return
		end

		local GemLevel = PlayerPackage : GetItemSubTableIndex(pos_packet,1)--等级
		local GemType = PlayerPackage : GetItemSubTableIndex(pos_packet,2)
		local GemIndex = PlayerPackage : GetItemSubTableIndex(pos_packet,3)--小index
		local GemCarryID=PlayerPackage : GetItemTableIndex( pos_packet )
		--胜利宝石流程 减抗性石头
		if GemType==21 then
			-- 通宝宝石暂时无法琢刻   --add by YGQ 开放通宝宝石琢刻 TT149839
			--if MaterialCompound_IsLiJinGem(pos_packet) == 1 then
			--	PushDebugMessage( "#{BSZK_121012_15}" )--通宝宝石暂时无法琢刻
			--	return
			--end
			--玩家点击的胜利宝石是否是一个尚未琢刻的3级或3级以上的胜利宝石
			if GemLevel<3 or GemIndex>100 then
				PushDebugMessage( "#{BSZK_121012_16}" )--仅可对3级或3级以上的减抗宝石进行琢刻
				return
			end

			--重置界面....
			Gemzhuoke_Clear(0);
			--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
			if Gemzhuoke_MainPos~= -1 then--有石头
				LifeAbility : Lock_Packet_Item(Gemzhuoke_MainPos,0);
			end
			Gemzhuoke_MainPos = pos_packet;
			LifeAbility : Lock_Packet_Item(Gemzhuoke_MainPos,1);
			Gemzhuoke_MainABT:SetActionItem(theAction:GetID());

			Gemzhuoke_MainID = PlayerPackage : GetItemTableIndex( pos_packet )

		--智慧宝石流程 属性攻击石头
		elseif GemType==2 then
			-- 通宝宝石暂时无法琢刻   --add by YGQ 开放通宝宝石琢刻 TT149839
			--if MaterialCompound_IsLiJinGem(pos_packet) == 1 then
			--	PushDebugMessage( "#{BSZK_121012_15}" )--通宝宝石暂时无法琢刻
			--	return
			--end
			--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
			if Gemzhuoke_MainID==-1 then
				PushDebugMessage( "#{BSZK_121012_18}" )--请先放入一颗将要进行琢刻的3级或3级以上的减抗宝石
				return
			end

			local GemMainLevel = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,1)--等级
			--local GemMainType = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,2)--类别
			local GemMainIndex = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,3)--小index索引
			--2号位置宝石
			local assistGemCount=Gemzhuoke_GetAssistGemCount()
			--0个宝石
			if assistGemCount==0 then
				--主宝石名字
				if GemMainIndex<1 or GemMainIndex>8 then
					return
				end
				if GemLevel>GemMainLevel then
					local gemName = LifeAbility : Get_GemName( Gemzhuoke_MainPos )
					--BSZK_121012_19	%s0只可琢刻%s1级和%s2级以下的%s3。
					local szShow=ScriptGlobal_Format( "#{BSZK_121012_19}", gemName, GemMainLevel, GemMainLevel, g_TipsKinds[GemMainIndex])
					PushDebugMessage( szShow)
					return
				end

				--是否可以合成
				local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, GemCarryID)
				if nAssistGemCount<0 then
					local gemName = LifeAbility : Get_GemName( Gemzhuoke_MainPos )
					--BSZK_121012_19	%s0只可琢刻%s1级和%s2级以下的%s3。
					local szShow=ScriptGlobal_Format( "#{BSZK_121012_19}", gemName, GemMainLevel, GemMainLevel, g_TipsKinds[GemMainIndex])
					PushDebugMessage( szShow)
					return
				end

				--可以合成了，那就放进去蒙红吧
				Gemzhuoke_AssistPos[1] = pos_packet;
				LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[1],1);
				Gemzhuoke_AssistABT[1]:SetActionItem(theAction:GetID());

				Gemzhuoke_AssistID[1] = GemCarryID

			else
				--其他情况
				--宝石数量是否足够 文档特例7级了，我也特例吧
				local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, GemCarryID)
				if nAssistGemCount<0 then
					PushDebugMessage( "#{BSZK_121012_20}")--仅可放入与已放入的纯净晶石相同的宝石
					return
				end

				local nGemCount, nGemID=Gemzhuoke_GetAssistGemCount()
				--异常
				if nGemID==-1 then
					return
				end
				--宝石类型是否匹配
				if nGemID~=GemCarryID then
					PushDebugMessage( "#{BSZK_121012_20}")--仅可放入与已放入的纯净晶石相同的宝石
					return
				end

				if nGemCount>=nAssistGemCount and nAssistGemCount==3 then
					PushDebugMessage( "#{BSZK_121012_21}")--参与琢刻的纯净宝石等级为7级时，只需3颗即可进行琢刻
					return
				elseif nGemCount>=nAssistGemCount then
					PushDebugMessage( "#{BSZK_121012_22}")--您已放入足够的纯净晶石
					return
				end

				--放入
				local nFirstEmptyIdx=Gemzhuoke_GetFirstEmptyAssistGemIdx()
				if nFirstEmptyIdx<=0 then
					return
				end
				--可以放入了，那就放进去蒙红吧
				Gemzhuoke_AssistPos[nFirstEmptyIdx] = pos_packet;
				LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[nFirstEmptyIdx],1);
				Gemzhuoke_AssistABT[nFirstEmptyIdx]:SetActionItem(theAction:GetID());

				Gemzhuoke_AssistID[nFirstEmptyIdx] = GemCarryID
			end

		--其他宝石
		else
			PushDebugMessage( "#{BSZK_121012_23}" )--该物品不可进行琢刻
			return
		end

		Gemzhuoke_LightZhuoKeBTN()

	elseif moveType == "rbclick2" then
		--非宝石类逻辑
		local itemID=PlayerPackage:GetItemTableIndex( pos_packet )
		--不是需求的物品....
		if itemID~=g_ZhuoKeFu[1] and itemID~=g_ZhuoKeFu[2] then
			PushDebugMessage( "#{BSZK_121012_23}" )--该物品不可进行琢刻
			return
		end
--		--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
--		if Gemzhuoke_MainID==-1 then
--			PushDebugMessage( "#{BSZK_121012_18}" )--请先放入一颗将要进行琢刻的3级或3级以上的减抗宝石
--			return
--		end

		--更换ActionButton....
		if Gemzhuoke_MaterPos ~= -1 then
			LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos, 0);
		end
		Gemzhuoke_MaterPos = pos_packet;
		LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos,1);
		Gemzhuoke_MaterABT:SetActionItem(theAction:GetID());
		Gemzhuoke_MaterID=itemID

		Gemzhuoke_LightZhuoKeBTN()

	elseif moveType == "drag1" then
		--宝石拖拽
		if dg_dest==0 then
			--锁逻辑在代码中进行了判断
			--必须是宝石....
			local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
			if Item_Class ~= 5 then
--				PushDebugMessage("需要放入宝石TODO")--wy等字典 等表述
				return
			end
			local GemLevel = PlayerPackage : GetItemSubTableIndex(pos_packet,1)--等级
			local GemType = PlayerPackage : GetItemSubTableIndex(pos_packet,2)
			local GemIndex = PlayerPackage : GetItemSubTableIndex(pos_packet,3)--小index
			local GemCarryID=PlayerPackage : GetItemTableIndex( pos_packet )
			--胜利宝石流程 减抗性石头
			if GemType==21 then
				-- 通宝宝石暂时无法琢刻			--add by YGQ 开放通宝宝石琢刻 TT149839
				--if MaterialCompound_IsLiJinGem(pos_packet) == 1 then
				--	PushDebugMessage( "#{BSZK_121012_15}" )--通宝宝石暂时无法琢刻
				--	return
				--end
				--玩家点击的胜利宝石是否是一个尚未琢刻的3级或3级以上的胜利宝石
				if GemLevel<3 or GemIndex>100 then
					PushDebugMessage( "#{BSZK_121012_16}" )--仅可对3级或3级以上的减抗宝石进行琢刻
					return
				end
				--重置界面....
				Gemzhuoke_Clear(0);
				--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
				if Gemzhuoke_MainPos~= -1 then--有石头
					LifeAbility : Lock_Packet_Item(Gemzhuoke_MainPos,0);
				end
				Gemzhuoke_MainPos = pos_packet;
				LifeAbility : Lock_Packet_Item(Gemzhuoke_MainPos,1);
				Gemzhuoke_MainABT:SetActionItem(theAction:GetID());

				Gemzhuoke_MainID = PlayerPackage : GetItemTableIndex( pos_packet )
			else
				PushDebugMessage( "#{BSZK_121012_16}" )--仅可对3级或3级以上的减抗宝石进行琢刻
				return
			end
		elseif dg_dest>=1 and dg_dest<=4 then
			--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
			if Gemzhuoke_MainID==-1 then
				PushDebugMessage( "#{BSZK_121012_18}" )--请先放入一颗将要进行琢刻的3级或3级以上的减抗宝石
				return
			end

			-- 通宝宝石暂时无法琢刻		--add by YGQ 开放通宝宝石琢刻 TT149839
			--if MaterialCompound_IsLiJinGem(pos_packet) == 1 then
			--	PushDebugMessage( "#{BSZK_121012_15}" )--通宝宝石暂时无法琢刻
			--	return
			--end
			local GemLevel = PlayerPackage : GetItemSubTableIndex(pos_packet,1)--等级
			local GemType = PlayerPackage : GetItemSubTableIndex(pos_packet,2)
			local GemIndex = PlayerPackage : GetItemSubTableIndex(pos_packet,3)--小index
			local GemCarryID=PlayerPackage : GetItemTableIndex( pos_packet )

			local GemMainLevel = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,1)--等级
			--local GemMainType = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,2)--类别
			local GemMainIndex = PlayerPackage : GetItemSubTableIndex(Gemzhuoke_MainPos,3)--小index索引
			--2号位置宝石
			local assistGemCount=Gemzhuoke_GetAssistGemCount()
			if assistGemCount==0 then
				--主宝石名字
				if GemMainIndex<1 or GemMainIndex>8 then
					return
				end

				--是否为智慧类石头
				if GemType~=2 then
					local gemName = LifeAbility : Get_GemName( Gemzhuoke_MainPos )
					--BSZK_121012_19	%s0只可琢刻%s1级和%s2级以下的%s3。
					local szShow=ScriptGlobal_Format( "#{BSZK_121012_19}", gemName, GemMainLevel, GemMainLevel, g_TipsKinds[GemMainIndex])
					PushDebugMessage( szShow)
					return
				end

				if GemLevel>GemMainLevel then
					local gemName = LifeAbility : Get_GemName( Gemzhuoke_MainPos )
					--BSZK_121012_19	%s0只可琢刻%s1级和%s2级以下的%s3。
					local szShow=ScriptGlobal_Format( "#{BSZK_121012_19}", gemName, GemMainLevel, GemMainLevel, g_TipsKinds[GemMainIndex])
					PushDebugMessage( szShow)
					return
				end

				--是否可以合成
				local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, GemCarryID)
				if nAssistGemCount<0 then
					local gemName = LifeAbility : Get_GemName( Gemzhuoke_MainPos )
					--BSZK_121012_19	%s0只可琢刻%s1级和%s2级以下的%s3。
					local szShow=ScriptGlobal_Format( "#{BSZK_121012_19}", gemName, GemMainLevel, GemMainLevel, g_TipsKinds[GemMainIndex])
					PushDebugMessage( szShow)
					return
				end

				--可以合成了，那就放进去蒙红吧
				if Gemzhuoke_AssistPos[dg_dest]~= -1 then--有石头
					LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[dg_dest],0);
				end
				Gemzhuoke_AssistPos[dg_dest] = pos_packet;
				LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[dg_dest],1);
				Gemzhuoke_AssistABT[dg_dest]:SetActionItem(theAction:GetID());

				Gemzhuoke_AssistID[dg_dest] = GemCarryID
			else
				--其他情况
				--宝石数量是否足够 文档特例7级了，我也特例吧
				local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, GemCarryID)
				if nAssistGemCount<0 then
					PushDebugMessage( "#{BSZK_121012_20}")--仅可放入与已放入的纯净晶石相同的宝石
					return
				end

				local nGemCount, nGemID=Gemzhuoke_GetAssistGemCount()
				--异常
				if nGemID==-1 then
					return
				end
				--宝石类型是否匹配
				if nGemID~=GemCarryID then
					PushDebugMessage( "#{BSZK_121012_20}")--仅可放入与已放入的纯净晶石相同的宝石
					return
				end

				if nGemCount>=nAssistGemCount and nAssistGemCount==3 then
					PushDebugMessage( "#{BSZK_121012_21}")--参与琢刻的纯净宝石等级为7级时，只需3颗即可进行琢刻
					return
				elseif nGemCount>=nAssistGemCount then
					PushDebugMessage( "#{BSZK_121012_22}")--您已放入足够的纯净晶石
					return
				end

				--可以放入了，那就放进去蒙红吧
				if Gemzhuoke_AssistPos[dg_dest]~= -1 then--有石头
					LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[dg_dest],0);
				end
				Gemzhuoke_AssistPos[dg_dest] = pos_packet;
				LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[dg_dest],1);
				Gemzhuoke_AssistABT[dg_dest]:SetActionItem(theAction:GetID());

				Gemzhuoke_AssistID[dg_dest] = GemCarryID

				Gemzhuoke_LightZhuoKeBTN()
			end
		elseif dg_dest==5 then
			--宝石放入了符栏，不处理
		end
	elseif moveType == "drag2" then
		--非宝石拖拽
		if dg_dest==5 then
--			--玩家是否已经在1号位置放置了一个尚未琢刻的3级或3级以上的胜利宝石
--			if Gemzhuoke_MainID==-1 then
--				PushDebugMessage( "#{BSZK_121012_18}" )--请先放入一颗将要进行琢刻的3级或3级以上的减抗宝石
--				return
--			end
			local itemID=PlayerPackage:GetItemTableIndex( pos_packet )
			--不是需求的物品....
			if itemID~=g_ZhuoKeFu[1] and itemID~=g_ZhuoKeFu[2] then
				PushDebugMessage("#{BSZK_121012_24}")
				return
			end
		
			--更换ActionButton....
			if Gemzhuoke_MaterPos ~= -1 then
				LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos, 0);
			end
			Gemzhuoke_MaterPos = pos_packet;
			LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos,1);
			Gemzhuoke_MaterABT:SetActionItem(theAction:GetID());
			Gemzhuoke_MaterID=itemID
	
			Gemzhuoke_LightZhuoKeBTN()
		else
			--不处理
			PushDebugMessage("#{BSZK_121012_23}")--该物品不可进行琢刻
		end
	end

end

function Gemzhuoke_GetAssistGemCount()
	local tblNum= table.getn(Gemzhuoke_AssistID)
	local count=0
	local nGemID=0
	for i=1,tblNum do
		if Gemzhuoke_AssistID[i]~=-1 then
			count=count+1;
			nGemID=Gemzhuoke_AssistID[i]
		end
	end
	return count,nGemID
end

function Gemzhuoke_GetFirstEmptyAssistGemIdx()
	local tblNum= table.getn(Gemzhuoke_AssistID)
	for i=1,tblNum do
		if Gemzhuoke_AssistID[i]==-1 then
			return i
		end
	end
	return 0
end

function Gemzhuoke_OnShow()
end

function Gemzhuoke_OK_Clicked()
	if Gemzhuoke_MainPos == -1 then
		return
	end
	--检测
	local nGemCount, nGemID=Gemzhuoke_GetAssistGemCount()
	local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, nGemID)
	if nAssistGemCount<=0 or nGemCount<nAssistGemCount then
		return
	end

	--判断电话密保和二级密码保护2012.6.8-LIUBO
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then			
		return
	end
	-- 判断是否为安全时间2012.6.8-LIUBO
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{OR_PILFER_LOCK_FLAG}")
		return
	end
	--钱数
	-- 检查身上的金钱是否足够
	local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < g_NeedMoney then
		PushDebugMessage( "#{BSZK_121012_25}" )
		return
	end
	--绑定与否
	local Bind = Gemzhuoke_GetBindStatus()
	--弹出一个确认框
	if g_ShowBind == 0 and Bind == 1 then
		local gemName = DoubleGem : GetGemNamebyID( Gemzhuoke_ProductID )
		local szShow=ScriptGlobal_Format( "#{BSZK_121012_26}", gemName)
		 PushEvent( "BIND_DOUBLEGEM_ZHUOKE", szShow )
		g_ShowBind = 1;
		return;
	end

	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnDoubleGemzhuoke");
		Set_XSCRIPT_ScriptID(290205);
		Set_XSCRIPT_Parameter(0,Gemzhuoke_MainPos);
		Set_XSCRIPT_Parameter(1,Gemzhuoke_AssistPos[1]);
		Set_XSCRIPT_Parameter(2,Gemzhuoke_AssistPos[2]);
		Set_XSCRIPT_Parameter(3,Gemzhuoke_AssistPos[3]);
		Set_XSCRIPT_Parameter(4,Gemzhuoke_AssistPos[4]);
		Set_XSCRIPT_Parameter(5,Gemzhuoke_MaterPos);
		Set_XSCRIPT_ParamCount(6);
	Send_XSCRIPT();

--	Gemzhuoke_OnHiden()
end

function Gemzhuoke_GetBindStatus()
	local Bind = GetItemBindStatus(Gemzhuoke_MainPos)
	if Bind==1 then
		return 1
	end
	Bind = GetItemBindStatus(Gemzhuoke_MaterPos)
	if Bind==1 then
		return 1
	end
	local nAssistCount=table.getn(Gemzhuoke_AssistPos)
	for i=1, nAssistCount do
		if Gemzhuoke_AssistPos[i]~=-1 then
			Bind = GetItemBindStatus(Gemzhuoke_AssistPos[i])
			if Bind==1 then
				return 1
			end
		end
	end
	return 0
end

function Gemzhuoke_OnHiden()
	Gemzhuoke_Clear(1)
	Gemzhuoke_StopCareObject()
	this:Hide()
end

--- 判断是否是礼金宝石。这里使用了比较蛋疼的判断方法，就是名字里面是否有"·通"
--  确实挫
function Gemzhuoke_IsLiJinGem( bagIdx )
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

function Gemzhuoke_Resume_RBClick(nIdx)
	if nIdx==nil then
		return
	end
	if nIdx==0 then--主宝石
		Gemzhuoke_Clear(0)
	elseif nIdx>=1 and nIdx<=4 then--从宝石
		--副宝石 拿下来的时候只清空 副宝石和符
		if(Gemzhuoke_AssistPos[nIdx] ~= -1) then
			LifeAbility : Lock_Packet_Item(Gemzhuoke_AssistPos[nIdx],0);
		end
		Gemzhuoke_AssistABT[nIdx] : SetActionItem(-1);

		Gemzhuoke_ProductABT :SetActionItem(-1);
		Gemzhuoke_ProductID=-1

		--Gemzhuoke_ProductABT :Hide();
		--Gemzhuoke_DemandMoney : SetProperty("MoneyNumber", "")

		Gemzhuoke_AssistPos[nIdx] = -1;
		Gemzhuoke_AssistID[nIdx] = -1;

		Gemzhuoke_OK:Disable();
	elseif nIdx==5 then--琢刻符
		if(Gemzhuoke_MaterPos ~= -1) then
			LifeAbility : Lock_Packet_Item(Gemzhuoke_MaterPos,0);
			Gemzhuoke_MaterABT : SetActionItem(-1);
			Gemzhuoke_MaterPos	= -1;
			Gemzhuoke_MaterID = -1
		end
		Gemzhuoke_OK:Disable();
	end
end

function Gemzhuoke_LightZhuoKeBTN()
	if Gemzhuoke_MainID==-1 then
		return
	end

	local nGemCount, nGemID=Gemzhuoke_GetAssistGemCount()
	local nAssistGemCount, nProductID=DoubleGem:GetDoubleGemInfo(Gemzhuoke_MainID, nGemID)
	if nAssistGemCount<=0 then
		return
	end

	if nGemCount<nAssistGemCount then
		return
	end

	 --显示产出物
	-- Gemzhuoke_ProductABT :Show();
	if 	Gemzhuoke_ProductID==-1 then
		local ProductAction = DoubleGem:UpdateProductAction( nProductID)
		if ProductAction and ProductAction:GetID() ~= 0 then
			Gemzhuoke_ProductABT:SetActionItem(ProductAction:GetID());
			Gemzhuoke_ProductID=nProductID
		else
			Gemzhuoke_ProductABT:SetActionItem(-1);
			Gemzhuoke_ProductID=-1
		end
	end
	if Gemzhuoke_MaterID==-1 then
		return
	end
	--点亮琢刻按钮
	--钱够不？
--	Gemzhuoke_ShowMoneyInfo()
	Gemzhuoke_OK:Enable()

end

function Gemzhuoke_ShowMoneyInfo()
	--设置所需钱数....
	Gemzhuoke_DemandMoney : SetProperty("MoneyNumber", tostring(g_NeedMoney));
	Gemzhuoke_SelfMoney: SetProperty("MoneyNumber", Player:GetData("MONEY"))
	Gemzhuoke_SelfJiaozi: SetProperty("MoneyNumber", Player:GetData("MONEY_JZ"))
end

function Gemzhuoke_Frame_On_ResetPos()
	Gemzhuoke_Frame:SetProperty("UnifiedPosition", g_Gemzhuoke_Frame_UnifiedPosition);
end

--TAB界面切换
function Gemzhuoke_ChangeTabIndex( nIndex )
	local nUI = 0
	if 1 == nIndex then
		nUI = 23
	elseif 2 == nIndex then
		nUI = 112236
	elseif 3 == nIndex then
		nUI = 112237
	elseif 4 == nIndex then
		return 0
	elseif 5 == nIndex then
		nUI = 201210121
	elseif 6 == nIndex then
		nUI = 201408140
	end
	if nUI ~= 0 then
		Variable:SetVariable("GemUnionPos", Gemzhuoke_Frame:GetProperty("UnifiedPosition"), 1)
		Variable:SetVariable("GemNPCObjId", tostring(ObjCaredIDID), 1)
		PushEvent("UI_COMMAND", nUI)
		Gemzhuoke_OnHiden()
	end
end


local MAX_OBJ_DISTANCE = 3.0
local DRESS_POS = -1
local g_NeedMoney = 50000
local g_ObjCared = -1

--PreLoad
function DressPaint_PreLoad()
	this:RegisterEvent("UI_COMMAND")
	this:RegisterEvent("OBJECT_CARED_EVENT")
	this:RegisterEvent("UPDATE_DRESS_PAINT")
	this:RegisterEvent("RESUME_ENCHASE_GEM")
	this:RegisterEvent("PACKAGE_ITEM_CHANGED")
	this:RegisterEvent("UNIT_MONEY")
	this:RegisterEvent("MONEYJZ_CHANGE")
	this:RegisterEvent("DISABLE_DRESS_PAINT_TRACING")
	this:RegisterEvent("OPEN_STALL_SALE")
	this:RegisterEvent("PROGRESSBAR_SHOW")
end

--OnLoad
function DressPaint_OnLoad()

end

--OnEvent
function DressPaint_OnEvent(event)

	if event == "UI_COMMAND" and arg0 ~= nil and tonumber(arg0) == 0910281 then
		if this:IsVisible() then
			this:Hide()
		end
		DressPaint_Clear()
		DressPaint_OK:Disable()
		DressPaint_Show:Disable()
		this:Show()

		-- 关闭试衣间
		if (IsWindowShow("DressPaint_Fitting")) then
			--DressReplaceColor:RestoreDressPaintFitting()
			CloseWindow("DressPaint_Fitting", true)
		end

		local xx = Get_XParam_INT(0);
		local objCared = DataPool:GetNPCIDByServerID(xx);
		if objCared == -1 then
			--PushDebugMessage("server传过来的数据有问题。")		-- 策划说了，不给提示~~
			return;
		end
		BeginCareObject_DressPaint(objCared)

		DressPaint_DemandMoney:SetProperty("MoneyNumber", g_NeedMoney)
		local playerMoney = Player:GetData("MONEY")
		DressPaint_SelfMoney:SetProperty("MoneyNumber", playerMoney)
		local playerJZ = Player:GetData("MONEY_JZ")
		DressPaint_SelfJiaozi:SetProperty("MoneyNumber", playerJZ)

	-- 染色成功，启用“染色追踪”按钮
	elseif event == "UI_COMMAND" and arg0 ~= nil and tonumber(arg0) == 091109 then
		if this:IsVisible() then
			DressPaint_Show:Enable()
		end

	-- 染色追踪界面已打开，禁用“染色追踪”按钮
	elseif event == "DISABLE_DRESS_PAINT_TRACING" then
		if this:IsVisible() then
			DressPaint_Show:Disable()
		end

	--elseif event ==	"UPDATE_DRESS_PAINT" then
	elseif event == "UI_COMMAND" and arg0 ~= nil and tonumber(arg0) == 20170118 then
		if arg0~= nil and arg1 ~= nil then
			DressPaint_Update(tonumber(arg1), 1)
		end

	elseif event == "OBJECT_CARED_EVENT" then
		if(arg0 ~= nil and tonumber(arg0) ~= objCared) then
			return;
		end
		--如果和NPC的距离大于一定距离或者被删除，自动关闭
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			--取消关心
			this:Hide()
		end

	elseif event == "RESUME_ENCHASE_GEM" and this:IsVisible() then
		if(arg0~=nil and tonumber(arg0) == 96) then
			DressPaint_Resume_Equip()
		end

	elseif event == "PACKAGE_ITEM_CHANGED" and this:IsVisible() then

		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end

		if (DRESS_POS == tonumber(arg0)) then
			DressPaint_Update(tonumber(arg0), 1)
		end

	elseif (event == "UNIT_MONEY" and this:IsVisible()) then
		DressPaint_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));

	elseif (event == "MONEYJZ_CHANGE" and this:IsVisible()) then
		DressPaint_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));

	elseif (event == "OPEN_STALL_SALE" and this:IsVisible()) then
		--和摆摊界面互斥
		this:Hide()

	elseif (event == "PROGRESSBAR_SHOW" and this:IsVisible())	then
		--和进度条互斥
		this:Hide()

	end

end

function DressPaint_Update(Pos, isEquip)
	--DressPaint_Clear()

	if isEquip == 1 then
		local theAction = EnumAction(Pos, "packageitem")
		if theAction:GetID() ~= 0 then

			--if PlayerPackage:IsLock(Pos) == 1 then   --tt60972 策划改设计，加锁时装也能染色
				--PushDebugMessage("#{SZPR_091023_16}")
				--DressPaint_Clear()
				--return
			--end

			local EquipPoint = LifeAbility:Get_Equip_Point(Pos)
			if EquipPoint ~= 16 then
				PushDebugMessage("#{SZPR_091023_17}")
				--DressPaint_Clear()
				return
			end

			--判断是不是可染色时装
			local canPaint = 1;--DressReplaceColor:DressCanPaint(Pos)
			if canPaint ~= 1 then
				PushDebugMessage("#{SZPR_091023_18}")
				--DressPaint_Clear()
				return
			end

			DressPaint_Clear()

			DRESS_POS = Pos;
			LifeAbility:Lock_Packet_Item(DRESS_POS, 1)
			DressPaint_Object:SetActionItem(theAction:GetID())

			--启用确定按钮
			DressPaint_OK:Enable();
			return

		else
			--DressPaint_Clear()
			PushDebugMessage("#{SZPR_091023_17}")
			return
		end
	else
		PushDebugMessage("#{SZPR_091023_17}")
		--DressPaint_Clear()
		return
	end
end

function DressPaint_Resume_Equip()
	DressPaint_Clear()
end

function DressPaint_Clear()
	if(DRESS_POS ~= -1) then
		DressPaint_OK:Disable()										-- 禁用“确定”按钮
		DressPaint_Show:Disable()									-- 禁用“染色追踪”按钮
		DressPaint_Object:SetActionItem(-1)
		LifeAbility:Lock_Packet_Item(DRESS_POS, 0)
		DRESS_POS = -1
	end
end

function DressPaint_OnHiden()
	StopCareObject_DressPaint(objCared)
	DressPaint_Clear()

	-- 关闭试衣间
	if (IsWindowShow("DressPaint_Fitting")) then
		CloseWindow("DressPaint_Fitting", true)
		--DressReplaceColor:RestoreDressPaintFitting()
	end

	return
end

------------------------------------------------------
--
--	确定
--
function DressPaint_OK_Clicked()

	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if selfMoney < g_NeedMoney then
		--PushDebugMessage("#{RXZS_090804_11}")
		PushDebugMessage("#{no_money}") --金钱不足
		return
	end

	Clear_XSCRIPT()
	Set_XSCRIPT_Function_Name("OnDressPaint")
	Set_XSCRIPT_ScriptID(830001)
	Set_XSCRIPT_Parameter(0, DRESS_POS)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT()

end

------------------------------------------------------
--
--	打开试衣间
--
function DressPaint_Show_Clicked()

	if (IsWindowShow("DressPaint_Fitting")) then
		-- 先清空当前试衣间的数据
		--DressReplaceColor:RestoreDressPaintFitting();
	end
	--PushDebugMessage("变身");
	-- 打开试衣间，显示试衣效果
	DressReplaceColor:OpenDressPaintFitting( DRESS_POS )

end

------------------------------------------------------
--
--	关心NPC
--
function BeginCareObject_DressPaint(objCaredId)
	g_ObjCared = objCaredId
	this:CareObject(g_ObjCared, 1, "DressPaint")
end


function StopCareObject_DressPaint(objCaredId)
	this:CareObject(g_ObjCared, 0, "DressPaint")
	g_ObjCared = -1
end

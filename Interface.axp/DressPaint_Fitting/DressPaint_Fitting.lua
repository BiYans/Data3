-- 时装染色试衣间

local objCared = -1;
local MAX_OBJ_DISTANCE = 3.0

function DressPaint_Fitting_PreLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OPEN_DRESS_PAINT_FITTING");
	this:RegisterEvent("CLOSE_DRESS_PAINT_FITTING");
	this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("SEX_CHANGED");
	this:RegisterEvent("PROGRESSBAR_SHOW")
end

function DressPaint_Fitting_OnLoad()
end

function DressPaint_Fitting_OnHiden()
	SetDefaultMouse();

	-- 恢复试衣前的装备参数
	--DressReplaceColor:RestoreDressPaintFitting();

	-- 取消关心NPC
	this:CareObject(objCared, 0, "DressPaint_Fitting")
	objCared = -1

	this:Hide();
end

function DressPaint_Fitting_OnEvent(event)

	-- 离开游戏世界
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		DressPaint_Fitting_Close();
	end

	-- 染色成功，如果试衣间开着，就先关闭
	if event == "UI_COMMAND" and tonumber(arg0) == 091111 then
		if this:IsVisible() then
			DressPaint_Fitting_Close();
		end
	end

	-- 打开试衣间
	if(event == "OPEN_DRESS_PAINT_FITTING") then

		-- 试衣
		local nDressBagPos = tonumber(arg0)
		DressReplaceColor : FittingOnDress(nDressBagPos)
		this:Show();

		-- 设置使用哪个模型
		DressPaint_Fitting_FakeObject : SetFakeObject("");
		DressPaint_Fitting_FakeObject : SetFakeObject("Dress_Player");

		-- 开始关心NPC
		local npcID = Get_XParam_INT(0);
		local objCared = DataPool:GetNPCIDByServerID(npcID);
		if objCared == -1 then
			--PushDebugMessage("server传过来的数据有问题。")		-- 策划说了，不给提示~~
			return;
		end
		this:CareObject(objCared, 1, "DressPaint_Fitting");
	end

	-- 关闭试衣间
	if (event == "CLOSE_DRESS_PAINT_FITTING") then
		DressPaint_Fitting_Close();
	end

	-- 关心NPC
	if (event == "OBJECT_CARED_EVENT") then
		if(tonumber(arg0) ~= objCared) then
			return;
		end

		--如果和商人的距离大于一定距离或者被删除，自动关闭
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			DressPaint_Fitting_Close();
		end
	end

	-- 变性
	if event == "SEX_CHANGED" and  this:IsVisible() then
		-- 更新模型信息
		DressPaint_Fitting_FakeObject : Hide();
		DressPaint_Fitting_FakeObject : Show();
		DressPaint_Fitting_FakeObject : SetFakeObject("Dress_Player");
	end

	if (event == "PROGRESSBAR_SHOW" and this:IsVisible())	then
		--和进度条互斥
		DressPaint_Fitting_Close()
	end

end

----------------------------------------------------------------------------------
--
-- 关闭
--
function DressPaint_Fitting_Close()

	-- 恢复试衣前的装备参数
	--DressReplaceColor:RestoreDressPaintFitting()

	--取消关心
	this:CareObject(objCared, 0, "DressPaint_Fitting");
	objCared = -1

	this:Hide();
end

----------------------------------------------------------------------------------
--
-- 旋转人物头像模型（向左)
--
function DressPaint_Fitting_TurnLeft(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--向左旋转开始
		if(start == 1) then
			DressPaint_Fitting_FakeObject:RotateBegin(-0.3);
		--向左旋转结束
		else
			DressPaint_Fitting_FakeObject:RotateEnd();
		end
	end
end

----------------------------------------------------------------------------------
--
--旋转人物头像模型（向右)
--
function DressPaint_Fitting_TurnRight(start)
	local mouse_button = CEArg:GetValue("MouseButton");
	if(mouse_button == "LeftButton") then
		--向右旋转开始
		if(start == 1) then
			DressPaint_Fitting_FakeObject:RotateBegin(0.3);
		--向右旋转结束
		else
			DressPaint_Fitting_FakeObject:RotateEnd();
		end
	end
end

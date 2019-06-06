local g_Agname_Yueli_Frame_UnifiedPosition;

function Agname_Yueli_PreLoad()
	this:RegisterEvent("SHOW_YUELIATTR");
	-- 游戏窗口尺寸发生了变化
	this:RegisterEvent("ADJEST_UI_POS")
	-- 游戏分辨率发生了变化
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

function Agname_Yueli_OnLoad()
  g_Agname_Yueli_Frame_UnifiedPosition=Agname_Yueli_Frame:GetProperty("UnifiedPosition");
end

-- OnEvent
function Agname_Yueli_OnEvent(event)

	if(event == "SHOW_YUELIATTR") then
		if( this:IsVisible() ) then
			this:Hide();
		else
			Agname_Yueli_Open();
		end
	end
		-- 游戏窗口尺寸发生了变化
	if (event == "ADJEST_UI_POS" ) then
		Agname_Yueli_Frame_On_ResetPos()
	-- 游戏分辨率发生了变化
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		Agname_Yueli_Frame_On_ResetPos()
	end
end

function Agname_Yueli_Open()

   this:Show();

	Agname_Yueli_List:RemoveAllItem();

   --加入所有的附加属性，达到的为白色，非达到的为灰色
   local nNum = Player:GetYueliNum();
   local nValue = Player:GetCurAgYueLi();
   local i;
   for i=0, nNum-1 do
	 local bNeedShow = Player:IsNeedShowYueLiAttr(i);
	 if bNeedShow ~= 1 then
		continue ;
	 end
     local nPoint, effect = Player:GetYueliItem(i);

	 if nValue < nPoint then
		nPoint = "#caea17a" ..nPoint;
		effect = "#caea17a" ..effect;
	 end

	 Agname_Yueli_List:AddNewItem(nPoint, 0, i);
	 Agname_Yueli_List:AddNewItem(effect, 1, i);
   end

end

--================================================
-- 恢复界面的默认相对位置
--================================================
function Agname_Yueli_Frame_On_ResetPos()
  Agname_Yueli_Frame:SetProperty("UnifiedPosition", g_Yueli_Frame_UnifiedPosition);
end

local objCared = -1;
local MAX_OBJ_DISTANCE = 3.0;
local g_uicmd = 0;

function NewbieCardActivation_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("NewUserCard_Check_Result");
end

function NewbieCardActivation_OnLoad()
end

function NewbieCardActivation_OnEvent(event)
	if(event == "UI_COMMAND" and not this:IsVisible()) then
		if
		(tonumber(arg0) == 20161231 )
		then
			objCared = Get_XParam_INT(0);
			objCared = Target:GetServerId2ClientId(objCared);
			NewUserCard_SetText(tonumber(arg0));
			this:CareObject(objCared, 1, "NewUserCard");
			NewbieCardActivation_Input:SetProperty("DefaultEditBox", "True");
			this:Show();
			g_uicmd = tonumber(arg0);
		end
	elseif(event == "OBJECT_CARED_EVENT") then
		--AxTrace(0, 0, "arg0:"..arg0.." arg1:"..arg1.." arg2:"..arg2.." objCared:"..objCared);
		if(tonumber(arg0) ~= objCared) then
			return;
		end
		--如果和NPC的距离大于一定距离或者被删除，自动关闭
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			Guild_Create_Close();
		end

	elseif(event == "NewUserCard_Check_Result")then
		local result = tonumber(arg0)
		if(tonumber(arg0)== 0) then
			NewUserCard_Close();
			return;
		end
		if(tonumber(arg0)== 1 or tonumber(arg0)== 2) then
			NewbieCardActivation_Input:SetProperty("DefaultEditBox", "True");
			NewbieCardActivation_Input:SetSelected( 0, -1 );
			return;
		end
	end

end

function NewUserCard_Open_Click()
	local cardNum = NewbieCardActivation_Input:GetText();
	if (0 == string.len(cardNum)) then
		PushDebugMessage("#{CFK_081027_2}");
		return;
	end


	local firstbyte = string.byte(cardNum)
	--588卡
	-- if (g_uicmd == 2004 and (firstbyte ==83 or firstbyte == 84)) then --大写 S T
	-- 	PushDebugMessage("#{CFK_081027_1}");
	-- 	return;
	-- end
	-- if(g_uicmd == 2004 and firstbyte ~= 116 and firstbyte ~= 115 ) then     --588财富卡't','s''T','S'
	-- 	PushDebugMessage("#{CFK_081027_2}");
	-- 	return;
	-- end
	--
	-- --666卡 c
	-- if (g_uicmd == 20080819 and firstbyte == 67) then
	-- 	PushDebugMessage("#{CFK_081027_1}");
	-- 	return;
	-- end
	-- if (g_uicmd == 20080819 and firstbyte ~= 99) then
	-- 	PushDebugMessage("#{CFK_081027_2}");
	-- 	return;
	-- end
	--
	-- --龚彩云处排除财富卡
	-- if (firstbyte==83 or firstbyte==84 or firstbyte==115 or firstbyte==116) and g_uicmd~=2004 then
	--   PushDebugMessage("#{CFK_081027_2}");
	-- 	return;
	-- elseif (g_uicmd == 20090714 and firstbyte ~= 121) then			-- SNS卡 y
	-- 	PushDebugMessage("#{SNS_090713_5}");
	-- 	return;
	-- elseif g_uicmd == 20090819 or g_uicmd == 20090828 then
	-- 	if firstbyte ~= 122  then
	-- 		PushDebugMessage("#{SNS_090713_5}");
	-- 		return;
	-- 	end
	-- end
	-- if ( firstbyte==67 or firstbyte==99) and g_uicmd~=20080819 then
	--   PushDebugMessage("#{CFK_081027_2}");
	-- 	return;
	-- end
	-- if (g_uicmd == 20161231) then
	-- 	--body...
	-- end

	NewUserCard(cardNum);
end

function NewUserCard_Close()
	this:Hide();
	this:CareObject(objCared, 0, "NewUserCard");
	g_uicmd = 0;
end

function NewUserCard_SetText(uicmd)
	-- if uicmd == 2004 then
	-- 	NewbieCardActivation_DragTitle:SetText("#{INTERFACE_XML_73}");
	-- 	NewbieCardActivation_Text:SetText("#{INTERFACE_XML_536}");
	-- elseif uicmd == 20080819 then--666财富卡
	-- 	NewbieCardActivation_DragTitle:SetText("#{INTERFACE_XML_73}");
	-- 	NewbieCardActivation_Text:SetText("#{INTERFACE_XML_536}");
--	elseif uicmd == 2005 then
--		NewbieCardActivation_DragTitle:SetText("激活");
--		NewbieCardActivation_Text:SetText("请在下面的输入框内输入您获得的CD-Key");
	-- elseif uicmd == 2006 then
	-- 	NewbieCardActivation_DragTitle:SetText("#{CJ_20080321_01}");
	-- 	NewbieCardActivation_Text:SetText("#{CJ_20080321_02}");
--	elseif uicmd == 2007 then
--		NewbieCardActivation_DragTitle:SetText("激活");
--		NewbieCardActivation_Text:SetText("请在下面的输入框内输入您获得的CD-Key");
	-- elseif uicmd == 2008 then
	-- 	NewbieCardActivation_DragTitle:SetText("K韈h ho誸");
	-- 	NewbieCardActivation_Text:SetText("Xin h銀 nh CD-Key m� c醕 h� nh 疬㧟 v鄌 � d呔i 疴y");
--	elseif uicmd == 2007950 then
--		NewbieCardActivation_DragTitle:SetText("#{CB_XUBAO_LINGQU_2}");
--		NewbieCardActivation_Text:SetText("#{CB_XUBAO_LINGQU_3}");
  -- elseif uicmd == 20090714 then
	-- 	NewbieCardActivation_DragTitle:SetText("#{SNS_XML_05}");
	-- 	NewbieCardActivation_Text:SetText("#{SNS_XML_06}");
	-- elseif uicmd == 20090819 then
	-- 	NewbieCardActivation_DragTitle:SetText("#{FXHZ_xml_XX(01)}");
	-- 	NewbieCardActivation_Text:SetText("#{FXHZ_xml_XX(08)}");
	-- elseif uicmd == 20090828 then
	-- 	NewbieCardActivation_DragTitle:SetText("#{RXCFK_XML_2}");
	-- 	NewbieCardActivation_Text:SetText("#{RXCFK_XML_3}");
	-- end

	if (uicmd == 20161231) then
		NewbieCardActivation_DragTitle:SetText("#{INTERFACE_XML_73}");
		NewbieCardActivation_Text:SetText("#{CB_XUBAO_LINGQU_3}");
	end

	NewbieCardActivation_Input:SetText("");
end

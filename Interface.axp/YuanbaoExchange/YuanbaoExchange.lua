local objCared = -1;
local MAX_OBJ_DISTANCE = 3.0;
local Exchange_Rate = 1;
local g_Point = 0;
local g_Object = -1;

function YuanbaoExchange_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OBJECT_CARED_EVENT");
end

function YuanbaoExchange_OnLoad()

end

function YuanbaoExchange_OnEvent(event)

	if ( event == "UI_COMMAND" and tonumber(arg0) == 2001 ) then
			if this:IsVisible() then
				YuanbaoExchange_Close();
				return
			end
			g_Object = Get_XParam_INT(0);
			BeginCareObject_YuanbaoExchange(Target:GetServerId2ClientId(g_Object));
			YuanbaoExchange_Moral_Value:SetProperty("DefaultEditBox", "True");
			YuanbaoExchange_Moral_Value:SetSelected( 0, -1 );
			YuanbaoExchange_OnShown();
			this:Show();
			YuanbaoExchange_Count_Change();
			YuanbaoExchange_Max:Disable()
			YuanbaoExchange_OK : Disable()
	elseif ( event == "UI_COMMAND" and tonumber(arg0) == 2003 ) then
		if(this:IsVisible()) then
			YuanbaoExchange_Moral_Value:SetProperty("DefaultEditBox", "True");
			YuanbaoExchange_Moral_Value:SetSelected( 0, -1 );
			g_Point = Get_XParam_INT(0);
			YuanbaoExchange_Text1 : SetText("S¯ B€C t°n: "..g_Point)
			YuanbaoExchange_Max:Enable()
			YuanbaoExchange_OK:Enable()
			YuanbaoExchange_Moral_Value:Enable();
		end
	elseif ( event == "OBJECT_CARED_EVENT") then
		YuanbaoExchange_CareEventHandle(arg0,arg1,arg2);
	end

end

function YuanbaoExchange_OnShown()
	YuanbaoExchange_Clear();
	YuanbaoExchange_Update();
end

function YuanbaoExchange_Clear()
	YuanbaoExchange_Text1 : SetText("")
	YuanbaoExchange_Moral_Value : SetText("")
	YuanbaoExchange_Text3 : SetText("")
	g_Point = 0;
	Exchange_Rate = 1;
end

function YuanbaoExchange_Update()
	Exchange_Rate = Get_XParam_INT(1)/1000
	
	YuanbaoExchange_Text1 : SetText("#cff0000#bS¯ ði¬m dß ðang ðßþc tra, xin ðþi...")
	YuanbaoExchange_Text3 : SetText("Yêu c¥u chi phí là:  0")
	
end

function YuanbaoExchange_OK_Clicked()
	local str = YuanbaoExchange_Moral_Value : GetText();
	
	--AxTrace(0,0,"YuanbaoExchange_OK_Clicked 1 "..tostring(str));

	if str == nil or str == "" then
		YuanbaoExchange_Text3 : SetText("Yêu c¥u chi phí là:  0")
		PushDebugMessage("M¶i ði«n vào giá tr¸ ngân lßþng các hÕ ð±i")
		return
	end
	
	if tonumber(str) > 10000 then
		PushDebugMessage("M²i l¥n ð±i giá tr¸ ngân lßþng l¾n nh¤t là 10.000, m¶i ði«n vào chæ s¯ nhö h½n ho£c b¢ng 10.000!")
		return
	end
	if( tonumber(str) <= 0 ) then
		PushDebugMessage("S¯ lßþng nguyên bäo m²i l¥n ð±i ít nh¤t là 1 ði¬m, xin vui lòng nh§p con s¯ l¾n h½n ho£c b¢ng 1")
		return
	end
	
	--AxTrace(0,0,"YuanbaoExchange_OK_Clicked 2");
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("BuyYuanbao");
		Set_XSCRIPT_ScriptID(181000);
		Set_XSCRIPT_Parameter(0,tonumber(str));
		Set_XSCRIPT_ParamCount(1);
	Send_XSCRIPT();
	
	
	YuanbaoExchange_Close();
end

function YuanbaoExchange_Close()
	YuanbaoExchange_OnHiden();
	this:Hide()
end

function YuanbaoExchange_Cancel_Clicked()
	YuanbaoExchange_Close();
	return;
end

function YuanbaoExchange_OnHiden()
	StopCareObject_YuanbaoExchange(objCared)
	YuanbaoExchange_Clear()
	return
end

function YuanbaoExchange_CareEventHandle(careId, op, distance)
		if(nil == careId or nil == op or nil == distance) then
			return;
		end
		
		if(tonumber(careId) ~= g_clientNpcId) then
			return;
		end
		--Èç¹ûºÍNPCµÄ¾àÀë´óÓÚÒ»¶¨¾àÀë»òÕß±»É¾³ý£¬×Ô¶¯¹Ø±Õ
		if(op == "distance" and tonumber(distance)>MAX_OBJ_DISTANCE or op=="destroy") then
			YuanbaoExchange_Close();
		end
end

--=========================================================
--¿ªÊ¼¹ØÐÄNPC£¬
--ÔÚ¿ªÊ¼¹ØÐÄÖ®Ç°ÐèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓÐ¡°¹ØÐÄ¡±µÄNPC£¬
--Èç¹ûÓÐµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓÐµÄ¡°¹ØÐÄ¡±
--=========================================================
function BeginCareObject_YuanbaoExchange(objCaredId)

	g_Object = objCaredId;
	--AxTrace(0,0,"LUA___CareObject g_Object =" .. g_Object );
	this:CareObject(g_Object, 1, "YuanbaoExchange");

end

--=========================================================
--Í£Ö¹¶ÔÄ³NPCµÄ¹ØÐÄ
--=========================================================
function StopCareObject_YuanbaoExchange(objCaredId)
	this:CareObject(objCaredId, 0, "YuanbaoExchange");
	g_Object = -1;

end

function YuanbaoExchange_Count_Change()
	local str = YuanbaoExchange_Moral_Value : GetText();
	local strNumber = 0;	
	
	if ( str == nil ) then
		return;
	elseif( str == "" ) then
		strNumber = 1;
	else
		strNumber = tonumber( str );
	end
	str = tostring( strNumber );
	YuanbaoExchange_Moral_Value:SetTextOriginal( str );
	YuanbaoExchange_Text3 : SetText("Yêu c¥u chi phí là: "..tostring( Exchange_Rate * strNumber ) )
end

function YuanbaoExchange_Max_Clicked()
	local maxYuanBao = 9999;
	local point2YuanBao = g_Point/Exchange_Rate;
	if point2YuanBao < 0 then point2YuanBao = 0; end
	
	YuanbaoExchange_Moral_Value:SetProperty("ClearOffset", "True");
	if point2YuanBao > maxYuanBao then
		YuanbaoExchange_Moral_Value:SetText(tostring(maxYuanBao));
	else
		YuanbaoExchange_Moral_Value:SetText(tostring(point2YuanBao));
	end
	YuanbaoExchange_Moral_Value:SetProperty("CaratIndex", 1024);
end
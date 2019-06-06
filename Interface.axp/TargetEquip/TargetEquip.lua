local TargetEquip_CS = 0;
-- Êý¾Ý³ØÖÐ¶¨ÒåµÄ×°±¸Êý¾Ý.
--HEQUIP_WEAPON		=0,		//ÎäÆ÷	WEAPON
--HEQUIP_CAP			=1,		//Ã±×Ó	DEFENCE
--HEQUIP_ARMOR		=2,		//ÒÂ·þ	DEFENCE
--HEQUIP_CUFF			=3,		//ÊÖÌ×	DEFENCE
--HEQUIP_BOOT			=4,		//Ð¬	DEFENCE
--HEQUIP_SASH			=5,		//Ñü´ø	ADORN
--HEQUIP_RING			=6,		//½ä×Ó	ADORN
--HEQUIP_NECKLACE	=7,		//ÏîÁ´	ADORN
--HEQUIP_DARK		=8,		//Æï³Ë----ÒÑÐÞ¸ÄÎª°µÆ÷by houzhifang
--HEQUIP_BAG			=9,		//ÐÐÄÒ                            »¤·û
--HEQUIP_BOX			=10,	//Ïä¸ñ
--HEQUIP_RING_2		=11,	//µÚ¶þ¸ö½äÖ¸	ADORN
--HEQUIP_CHARM		=12,	//»¤·û	            ADORN
--HEQUIP_CHARM_2		=13,	//µÚ¶þ¸ö»¤·û	    ADORN
--HEQUIP_WRIST		=14,	//»¤Íó	DEFENCE
--HEQUIP_SHOULDER		=15,	//»¤¼ç	DEFENCE
--HEQUIP_DRESS		=16,	//Ê±×°


--------------------------------------------------------------------------------
-- ×°±¸°´Å¥Êý¾Ý¶¨Òå
--
local  g_WEAPON;		--ÎäÆ÷
local  g_ARMOR;			--ÒÂ·þ
local  g_CAP;			--Ã±×Ó
local  g_CUFF;			--»¤Íó
local  g_BOOT;			--Ð¬
local  g_RING;			--½ä×Ó
local  g_SASH;			--Ñü´ø
local  g_NECKLACE;		--ÏîÁ´
local  g_Dark;			--×øÆï---ÒÑÐÞ¸ÄÎª°µÆ÷
local  g_Charm;			-- »¤·û
local  g_Charm2;		-- »¤·û2
local  g_Shoulder;		-- »¤¼ç
local  g_Glove;			-- ÊÖÌ×
local  g_Ring2;			-- ½äÖ¸2
local  g_FashionDress;	-- Ê±×°

local g_Cur_Name = "";
local g_objCared = -1;
local MAX_OBJ_DISTANCE = 3.0;

local TARGETEQUIP_TAB_TEXT = {};

function TargetEquip_PreLoad()

	-- ´ò¿ª½çÃæ
	this:RegisterEvent("MAINTARGET_CHANGED");
	this:RegisterEvent("OTHERPLAYER_UPDATE_EQUIP");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("CLOSE_TARGET_EQUIP");
	this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("UI_COMMAND");

end

function TargetEquip_OnLoad()

	-- action buttion °´Å¥
	g_WEAPON		= TargetEquip_Equip11;		--ÎäÆ÷
	g_ARMOR			= TargetEquip_Equip12;		--ÒÂ·þ
	g_CAP			= TargetEquip_Equip1;		--Ã±×Ó
	g_CUFF			= TargetEquip_Equip8;		--»¤Íó
	g_BOOT			= TargetEquip_Equip4;		--Ð¬
	g_RING			= TargetEquip_Equip6;		--½ä×Ó
	g_SASH			= TargetEquip_Equip7;		--Ñü´ø
	g_NECKLACE		= TargetEquip_Equip13;		--ÏîÁ´
	g_Dark			= TargetEquip_Equip14;		--×øÆï
	g_Charm			= TargetEquip_Equip9;		-- »¤·û
	g_Charm2		= TargetEquip_Equip10;		-- »¤·û2
	g_Shoulder		= TargetEquip_Equip3;		-- »¤¼ç
	g_Glove			= TargetEquip_Equip2;		-- ÊÖÌ×
	g_Ring2			= TargetEquip_Equip5;		-- ½äÖ¸2
	g_FashionDress	= TargetEquip_Equip15;		-- Ê±×°

	TARGETEQUIP_TAB_TEXT = {
		[0] = "Ð°",
		"Nhân",
		"Blog",
		"Thú",
		"KÜ",
	};
end
function TargetEquip_SetTabColor(idx)

	local i = 0;
	local selColor = "#e010101#Y";
	local noselColor = "#e010101";
	local tab = {
								[0] = TargetEquip_SelfEquip,
								TargetEquip_TargetData,								
								TargetEquip_Blog,
								TargetEquip_Pet,
								TargetEquip_Ride,
							};
	
	while i < 5 do
		if(i == idx) then
			tab[i]:SetText(selColor..TARGETEQUIP_TAB_TEXT[i]);
		else
			tab[i]:SetText(noselColor..TARGETEQUIP_TAB_TEXT[i]);
		end
		i = i + 1;
	end
end

-- OnEvent
function TargetEquip_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 74130111 then
		TargetEquip_CS = Get_XParam_INT(0) --So Lan CS
		
		local New_strName = CachedTarget:GetData("NAME", 1);
		TargetEquip_PageHeader:SetText("#gFF0FA0" .. New_strName .." (CLHÐ: "..TargetEquip_CS..")");
	end
	
	if ( event == "MAINTARGET_CHANGED" and tonumber(arg0) == -1) then

		return;
	end

	if( "PLAYER_LEAVE_WORLD" == event) then
		this : Hide();
		return;
	end

	-- ×°±¸±ä»¯Ê±Ë¢ÐÂ×°±¸.
	if("OTHERPLAYER_UPDATE_EQUIP" == event) then

		if (not CachedTarget:IsPresent(1)) then
			return;
		end

		--if (not CachedTarget:CanGetTargetEquip()) then
		--	PushDebugMessage ("#{JSCK_90507_1}")				-- ¾àÀë¸ÃÍæ¼ÒÌ«Ô¶£¬ÎÞ·¨²é¿´×ÊÁÏ¡£
		--	return
		--end
		
		g_objCared = CachedTarget:GetData("NPCID", 1)
		if (type(g_objCared) ~="number") then
			PushDebugMessage ("#{JSCK_90507_1}")				-- ¾àÀë¸ÃÍæ¼ÒÌ«Ô¶£¬ÎÞ·¨²é¿´×ÊÁÏ¡£
			return
		end

		local otherUnionPos = Variable:GetVariable("OtherUnionPos");
		if(otherUnionPos ~= nil) then
			TargetEquip_Frame:SetProperty("UnifiedPosition", otherUnionPos);
		end
		TargetEquip_SetTabColor(0);
		TargetEquip_SelfEquip:SetCheck(1);
		TargetEquip_TargetData:SetCheck(0);

		TargetEquip_FakeObject:SetFakeObject("");
		CachedTarget:TargetEquip_ChangeModel();
		TargetEquip_FakeObject:SetFakeObject("Target");

		-- ¿ªÊ¼¹ØÐÄOBJ
		TargetEquip_BeginCareObject(g_objCared);
		TargetEquip_OnUpdateShow();
		TargetEquip_RefreshEquip();

		this:Show();
		return;
	end

	if( "CLOSE_TARGET_EQUIP" == event ) then

		TargetEquip_CloseUI();
		return;
	elseif (event == "OBJECT_CARED_EVENT") then
		if(tonumber(arg0) ~= g_objCared) then
			return;
		end

		--Èç¹ûºÍNPCµÄ¾àÀë´óÓÚÒ»¶¨¾àÀë»òÕß±»É¾³ý£¬×Ô¶¯¹Ø±Õ
		if( arg1=="destroy") then
			TargetEquip_CloseUI();
			return;
		end

	end

end

-- ¸üÐÂÖ÷½Ç»ù±¾ÐÅÏ¢
function TargetEquip_OnUpdateShow()
	local PlayerTarget = GetTargetPlayerGUID();
	if PlayerTarget ~= nil then
		Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("ReceiveXscript")
		Set_XSCRIPT_ScriptID(741303)
		Set_XSCRIPT_Parameter(0,100)
		Set_XSCRIPT_Parameter(1,PlayerTarget)
		Set_XSCRIPT_ParamCount(2)
		Send_XSCRIPT();
	end
	
	local nNumber = 0;
	local nMaxnumber = 0;
	local strName = "";

	-- µÃµ½Ãû×Ö
	strName = CachedTarget:GetData("NAME", 1);
	g_Cur_Name = strName;
	--TargetEquip_PageHeader:SetText("#gFF0FA0" .. strName .." (CLHÐ: "..TargetEquip_CS..")");

	-- µÃµ½³ÆºÅ
	strName = CachedTarget:GetData("TITLE", 1)
	TargetEquip_Agname:SetText( ""..strName );
	
	-- µÃµ½°ïÅÉ
	strName = CachedTarget:GetData("GUILD", 1)
	TargetEquip_Confraternity:SetText( ""..strName );
	
	-- µÃµ½µÈ¼¶
	nNumber = CachedTarget:GetData("LEVEL", 1);
	TargetEquip_Level:SetText("C¤p: " .. tostring( nNumber ));

	-- µÃµ½ÅäÅ¼ÐÅÏ¢
	local szConsort = SystemSetup:GetPrivateInfo("other","Consort");
	TargetEquip_Spouse:SetText(szConsort);

	-- ÃÅÅÉ
	local menpai = CachedTarget:GetData("MEMPAI",1);
	local strMenpai = "";

	-- µÃµ½ÃÅÅÉÃû³Æ.
	if(0 == menpai) then
		strMenpai = "Thiªu Lâm";

	elseif(1 == menpai) then
		strMenpai = "Minh Giáo";

	elseif(2 == menpai) then
		strMenpai = "Cái Bang";

	elseif(3 == menpai) then
		strMenpai = "Võ Ðang";

	elseif(4 == menpai) then
		strMenpai = "Nga My";

	elseif(5 == menpai) then
		strMenpai = "Tinh Túc";

	elseif(6 == menpai) then
		strMenpai = "Thiên Long";

	elseif(7 == menpai) then
		strMenpai = "Thiên S½n";

	elseif(8 == menpai) then
		strMenpai = "Tiêu Dao";

	elseif(9 == menpai) then
		strMenpai = "Không có";
	end

	-- ÉèÖÃÏÔÊ¾µÄÃÅÅÉ.
	TargetEquip_MenPai:SetText(strMenpai);

	-- ¸öÈËËµÃ÷
	local szLuck = SystemSetup:GetPrivateInfo("other","luck");
	TargetEquip_Message:SetText(szLuck);

end

-- Ë¢ÐÂ×°±¸
function TargetEquip_RefreshEquip()

	--  Çå¿Õ°´Å¥ÏÔÊ¾Í¼±ê
	g_WEAPON:SetActionItem(-1);			--ÎäÆ÷
	g_CAP:SetActionItem(-1);				--Ã±×Ó
	g_ARMOR:SetActionItem(-1);			--¿ø¼×
	g_CUFF:SetActionItem(-1);				--»¤Íó
	g_BOOT:SetActionItem(-1);				--Ð¬
	g_SASH:SetActionItem(-1);				--Ñü´ø
	g_RING:SetActionItem(-1);				--½ä×Ó
	g_NECKLACE:SetActionItem(-1);		--ÏîÁ´
	g_Dark:SetActionItem(-1);				--×øÆï
	g_Charm:SetActionItem(-1);			-- »¤·û
	g_Charm2:SetActionItem(-1);			-- »¤·û2
	g_Shoulder:SetActionItem(-1);		-- »¤¼ç
	g_Glove:SetActionItem(-1);			-- ÊÖÌ×
	g_Ring2:SetActionItem(-1);			-- ½äÖ¸2
	g_FashionDress:SetActionItem(-1);		-- Ê±×°

	local ActionWeapon 		= EnumAction(0, "targetequip");
	local ActionCap    		= EnumAction(1, "targetequip");
	local ActionArmor  		= EnumAction(2, "targetequip");
	local ActionGlove		= EnumAction(3, "targetequip");
	local ActionBoot   		= EnumAction(4, "targetequip");
	local ActionSash   		= EnumAction(5, "targetequip");
	local ActionRing    	= EnumAction(6, "targetequip");
	local ActionNecklace	= EnumAction(7, "targetequip");
	local ActionDark		= EnumAction(17, "targetequip");    --ÐÞ¸ÄÎª°µÆ÷  by houzhifang
	local ActionRing2		= EnumAction(11, "targetequip");
	local ActionCharm		= EnumAction(12, "targetequip");
	local ActionCharm2		= EnumAction(13, "targetequip");
	local ActionCuff  		= EnumAction(14, "targetequip");
	local ActionShoulder	= EnumAction(15, "targetequip");
	local ActionDress		= EnumAction(16, "targetequip");

	-- ÏÔÊ¾ÈËÉíÉÏµÄÎäÆ÷×°±¸
	g_WEAPON:SetActionItem(ActionWeapon:GetID());			--ÎäÆ÷
	g_CAP:SetActionItem(ActionCap:GetID());						--Ã±×Ó
	g_ARMOR:SetActionItem(ActionArmor:GetID());				--¿ø¼×
	g_CUFF:SetActionItem(ActionCuff:GetID());					--»¤Íó
	g_BOOT:SetActionItem(ActionBoot:GetID());					--Ð¬
	g_SASH:SetActionItem(ActionSash:GetID());					--Ñü´ø
	g_RING:SetActionItem(ActionRing:GetID());					--½ä×Ó
	g_NECKLACE:SetActionItem(ActionNecklace:GetID());	--ÏîÁ´
	g_Dark:SetActionItem(ActionDark:GetID());					--×øÆï
	g_Charm:SetActionItem(ActionCharm:GetID());				-- »¤·û
	g_Charm2:SetActionItem(ActionCharm2:GetID());			-- »¤·û2
	g_Shoulder:SetActionItem(ActionShoulder:GetID());	-- »¤¼ç
	g_Glove:SetActionItem(ActionGlove:GetID());				-- ÊÖÌ×
	g_Ring2:SetActionItem(ActionRing2:GetID());				-- ½äÖ¸2
	g_FashionDress:SetActionItem(ActionDress:GetID());-- Ê±×°

end

----------------------------------------------------------------------------------
--
-- Ðý×ªÍæ¼ÒÄ£ÐÍ£¨Ïò×ó)
--
function TargetEquip_Modle_TurnLeft(start)
	--Ïò×óÐý×ª¿ªÊ¼
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		TargetEquip_FakeObject:RotateBegin(-0.3);
	--Ïò×óÐý×ª½áÊø
	else
		TargetEquip_FakeObject:RotateEnd();
	end
end

----------------------------------------------------------------------------------
--
-- Ðý×ªÍæ¼ÒÄ£ÐÍ£¨ÏòÓÒ)
--
function TargetEquip_Modle_TurnRight(start)
	--ÏòÓÒÐý×ª¿ªÊ¼
	if(start == 1 and CEArg:GetValue("MouseButton")=="LeftButton") then
		TargetEquip_FakeObject:RotateBegin(0.3);
	--ÏòÓÒÐý×ª½áÊø
	else
		TargetEquip_FakeObject:RotateEnd();
	end
end

----------------------------------------------------------------------------------------
--
-- ¹Ø±Õ½çÃæ
--
function TargetEquip_CloseUI()

	this:Hide();

	-- È¡Ïû¹ØÐÄOBJ
	TargetEquip_StopCareObject(g_objCared);
	
	-- Çå¿ÕFakeModel´°¿Ú
	TargetEquip_FakeObject:SetFakeObject("");
	CachedTarget:TargetEquip_DestroyUIModel();
	
	-- Çå¿Õ½ÇÉ«ÐÅÏ¢ºÍ×°±¸Í¼±ê
	TargetEquip_ClearPlayerInfo();
	TargetEquip_ClearEquipItem();

end

----------------------------------------------------------------------------------------
--
-- Çå¿Õ×°±¸½çÃæÖÐµÄ½ÇÉ«ÐÅÏ¢
--
function TargetEquip_ClearPlayerInfo()
	
	TargetEquip_PageHeader:SetText("");
	TargetEquip_Agname:SetText("");
	TargetEquip_Confraternity:SetText("");
	TargetEquip_Level:SetText("C¤p: ");	
	TargetEquip_Spouse:SetText("");
	TargetEquip_MenPai:SetText("Phái:  ");
	TargetEquip_Message:SetText("");

end

----------------------------------------------------------------------------------------
--
--  Çå¿Õ×°±¸½çÃæÖÐµÄ×°±¸Í¼±ê
--
function TargetEquip_ClearEquipItem()

	--  Çå¿Õ°´Å¥ÏÔÊ¾Í¼±ê
	g_WEAPON:SetActionItem(-1);			--ÎäÆ÷
	g_CAP:SetActionItem(-1);				--Ã±×Ó
	g_ARMOR:SetActionItem(-1);			--¿ø¼×
	g_CUFF:SetActionItem(-1);				--»¤Íó
	g_BOOT:SetActionItem(-1);				--Ð¬
	g_SASH:SetActionItem(-1);				--Ñü´ø
	g_RING:SetActionItem(-1);				--½ä×Ó
	g_NECKLACE:SetActionItem(-1);		--ÏîÁ´
	g_Dark:SetActionItem(-1);			--×øÆï
	g_Charm:SetActionItem(-1);		-- »¤·û
	g_Charm2:SetActionItem(-1);		-- »¤·û2
	g_Shoulder:SetActionItem(-1);		-- »¤¼ç
	g_Glove:SetActionItem(-1);		-- ÊÖÌ×
	g_Ring2:SetActionItem(-1);		-- ½äÖ¸2
	g_FashionDress:SetActionItem(-1);		-- Ê±×°

end

----------------------------------------------------------------------------------------
--
-- ´ò¿ªÍæ¼ÒÐÅÏ¢½çÃæ
--
-- ×ÊÁÏ
--
function TargetEquip_TargetData_Down()
	Variable:SetVariable("OtherUnionPos", TargetEquip_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPrivatePage("other")
end
--
-- ²©¿Í
--
function TargetEquip_TargetBlog_Down()
	Variable:SetVariable("OtherUnionPos", TargetEquip_Frame:GetProperty("UnifiedPosition"), 1);

	local strCharName =  CachedTarget:GetData("NAME");
	local strAccount =  CachedTarget:GetData("ACCOUNTNAME")
	Blog:OpenBlogPage(strAccount,strCharName,false);
end
--
-- ÕäÊÞ
--
function TargetEquip_OtherPet_Down()
	Variable:SetVariable("OtherUnionPos", TargetEquip_Frame:GetProperty("UnifiedPosition"), 1);
	SystemSetup:OpenPetFrame("other");
end
--
-- Æï³Ë
--
function TargetEquip_OtherRide_Down()
	Variable:SetVariable("OtherUnionPos", TargetEquip_Frame:GetProperty("UnifiedPosition"), 1);
	--SystemSetup:OpenRidePage("other");
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("ReceiveXscript")
	Set_XSCRIPT_ScriptID(741303)
	Set_XSCRIPT_Parameter(0,202)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT();
end

--Îä»ê

function TargetEquip_TargetWuhun_Switch()
	Variable:SetVariable("OtherUnionPos", TargetEquip_Frame:GetProperty("UnifiedPosition"), 1);
	--SystemSetup:OpenRidePage("other");
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("ReceiveXscript")
	Set_XSCRIPT_ScriptID(741303)
	Set_XSCRIPT_Parameter(0,201)
	Set_XSCRIPT_ParamCount(1)
	Send_XSCRIPT();
end

----------------------------------------------------------------------------------------
--
-- ¡°Ë½ÁÄ¡±°´Å¥µÄÏìÓ¦º¯Êý
--
function Set_To_Private()

	CachedTarget:Set_To_Private(g_Cur_Name);

end

----------------------------------------------------------------------------------------
--
-- ¡°¼ÓÎªºÃÓÑ¡±°´Å¥µÄÏìÓ¦º¯Êý
--
function Set_To_Friend()

	DataPool:AddFriend( Friend:GetCurrentTeam(),g_Cur_Name );
	
end

--=========================================================
--¿ªÊ¼¹ØÐÄOBJ
--ÔÚ¿ªÊ¼¹ØÐÄÖ®Ç°ÐèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓÐ¡°¹ØÐÄ¡±µÄOBJ£¬
--Èç¹ûÓÐµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓÐµÄ¡°¹ØÐÄ¡±
--=========================================================
function TargetEquip_BeginCareObject(objCaredId)

	if (type(objCaredId) == "number") then
		g_objCared = objCaredId;
		this:CareObject(g_objCared, 1, "TargetEquip");
	else
		return;
	end

end

--=========================================================
--Í£Ö¹¶ÔÄ³OBJµÄ¹ØÐÄ
--=========================================================
function TargetEquip_StopCareObject(objCaredId)
	
	if (type(objCaredId) == "number") then
		this:CareObject(objCaredId, 0, "TargetEquip");
		g_objCared = -1;		
	else
		return;
	end

end
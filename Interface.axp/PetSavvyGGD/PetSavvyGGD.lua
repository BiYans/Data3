-- PetSavvyGGD.lua
-- ÕäÊŞÌáÉıÎòĞÔ£¨ÓÃ¸ù¹Çµ¤£©

local mainPet = { idx = -1, guid = { high = -1, low = -1 } }
local assisPet = { idx = -1, guid = { high = -1, low =-1 } }

local theNPC = -1													-- ¹¦ÄÜ NPC
local MAX_OBJ_DISTANCE = 3.0

local currentChoose = -1

local moneyCosts = {													-- Ë÷ÒıÊÇÕäÊŞµÄµ±Ç°ÎòĞÔÖµ
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
	this : RegisterEvent( "REPLY_MISSION_PET" )				-- Íæ¼Ò´ÓÁĞ±íÑ¡¶¨Ò»Ö»ÕäÊŞ
	this : RegisterEvent( "UPDATE_PET_PAGE" )					-- Íæ¼ÒÉíÉÏµÄÕäÊŞÊı¾İ·¢Éú±ä»¯
	this : RegisterEvent( "DELETE_PET" )							-- Íæ¼ÒÉíÉÏ¼õÉÙÒ»Ö»ÕäÊŞ
	this : RegisterEvent( "OBJECT_CARED_EVENT" )			-- ¹ØĞÄ NPC µÄ´æÔÚºÍ·¶Î§
	this : RegisterEvent( "UNIT_MONEY" );
	this : RegisterEvent( "MONEYJZ_CHANGE" )					--½»×ÓÆÕ¼° Vega
	this : RegisterEvent( "OPEN_EXCHANGE_FRAME" );		--´ò¿ª½»Ò×½çÃæ
end

function PetSavvyGGD_OnLoad()
	PetSavvyGGD_Clear()
end


function PetSavvyGGD_OK_Clicked()
	-- Ê×ÏÈÅĞ¶¨Íæ¼ÒÊÇ·ñ·ÅÈëĞèÒªÌáÉıµÄÕäÊŞ£¬Èç¹ûÃ»ÓĞ·ÅÈëNPC½«»áµ¯³ö¶Ô»°²¢·µ»Ø£º
	if mainPet.idx == -1 then
	-- Çë·ÅÈëÄúÒªÌáÉıÎòĞÔµÈ¼¶µÄÕäÊŞ¡£
		ShowSystemTipInfo( "M¶i các hÕ nh§p yêu c¥u c¥n nâng cao nh§n thÑc thú quı cüa bÕn." )
		return
	end

	-- ÅĞ¶¨Íæ¼ÒµÄ½ğÇ®ÊÇ·ñ×ã¹»£¬Èç¹û²»¹»½«»áµ¯³ö¶Ô»°¡£
	local savvy = Pet : GetSavvy( mainPet.idx )
	local cost = moneyCosts[savvy]
	if not cost then
		cost = 0
	end

	-- ÄúµÄ½ğÇ®²»×ã£¬ÇëÈ·ÈÏ
	local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ");	--½»×ÓÆÕ¼° Vega
	if selfMoney < cost then
		ShowSystemTipInfo( "Ngân lßşng cüa các hÕ không ğü, m¶i xác nh§n." )
		return
	end

	--¼ì²é¸ù¹Çµ¤
	local nSavvyNeed = savvy+1;
	local nItemIdGenGuDan = 0;
	local nItemIdGenGuDanBind = 0; --°ó¶¨µÄ¸ù¹Çµ¤
	local msgTemp;

	if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
		msgTemp = "Th¤p";
		nItemIdGenGuDan = 30502000;
		nItemIdGenGuDanBind = 30504038;
	elseif nSavvyNeed >= 4 and nSavvyNeed <= 6 then
		msgTemp = "Trung"
		nItemIdGenGuDan = 30502001;
	elseif nSavvyNeed >= 7 and nSavvyNeed <= 10 then
		msgTemp = "Cao"
		nItemIdGenGuDan = 30502002;
	elseif nSavvyNeed >= 11 and nSavvyNeed <= 15 then
		msgTemp = "Siêu"
		nItemIdGenGuDan = 30502004;
	end

	local bExist = IsItemExist( nItemIdGenGuDan );
	if(bExist <= 0 and nItemIdGenGuDanBind ~= 0) then
		bExist = IsItemExist( nItemIdGenGuDanBind );
	end

	if bExist <= 0 then
		local msg = "Nâng ngµ tính ğªn "..nSavvyNeed.."C¥n "..msgTemp.." c¤p cån c¯t ğan. ";
		PetSavvyGGD_GGD : SetText( msg );
		SetNotifyTip( msg );
		return;
	end

	-- ·¢ËÍ UI_Command ½øĞĞºÏ³É
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "PetSavvy" )
		Set_XSCRIPT_ScriptID( 800106 )
		Set_XSCRIPT_Parameter( 0, mainPet.guid.high )
		Set_XSCRIPT_Parameter( 1, mainPet.guid.low )
		Set_XSCRIPT_ParamCount( 2 )
	Send_XSCRIPT()

end

-- ¹Ø±Õ¡¢È¡Ïû
function PetSavvyGGD_Cancel_Clicked()
	this : Hide()
end

-- Ñ¡ÔñÕäÊŞ
function PetSavvyGGD_SelectPet( petIdx )
	if -1 == petIdx then
		return
	end

	local petName = Pet : GetPetList_Appoint( petIdx )
	local guidH, guidL = Pet : GetGUID( petIdx )


	-- Èç¹ûÔ­À´ÒÑ¾­Ñ¡ÔñÁËÒ»¸ö±»ÌáÉıµÄ³è
	-- ÔòÇå¿ÕÔ­À´µÄÊı¾İ
	PetSavvyGGD_RemoveMainPet()

	local savvy = Pet : GetSavvy( petIdx )
	local nGen = Pet:GetType(petIdx) ;

	if UI_TYPE == WX_10 then
		if savvy <=9 then
			-- ½«ÕäÊŞÃû×ÖÌîµ½ÎÄ±¾¿òÖĞ
			PetSavvyGGD_Pet : SetText( petName )
			-- ¸øÕäÊŞÉÏËø£¬ÉèÖÃÕäÊŞÒÑ¾­Ìá½»µ½3ºÅ½çÃæÈİÆ÷
			Pet : SetPetLocation( petIdx, 3 )
			-- ¸üĞÂÕäÊŞÁĞ±í½çÃæ
			--Pet:UpdatePetList()
		else
			PetSavvyGGD_Pet : SetText( "" )
			PetSavvyGGD_GGD : SetText( "" )
			PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", 0 )
			PetSavvyGGD_Text2 : SetText( "Không có cách nào thång c¤p" )
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

		--»Ã»¯ÕäÊŞ
		if nGen >= 100 then
			if savvy < 15 then
				if savvy >= 10 then
					-- ½«ÕäÊŞÃû×ÖÌîµ½ÎÄ±¾¿òÖĞ
					PetSavvyGGD_Pet : SetText( petName )
					-- ¸øÕäÊŞÉÏËø£¬ÉèÖÃÕäÊŞÒÑ¾­Ìá½»µ½3ºÅ½çÃæÈİÆ÷
					Pet : SetPetLocation( petIdx, 3 )
					-- ¸üĞÂÕäÊŞÁĞ±í½çÃæ
					--Pet:UpdatePetList()
				else
					SetNotifyTip("#{RXZS_090804_26}")	--ÎòĞÔ¡İ10µÄÕäÊŞ²ÅÄÜÊ¹ÓÃ³¬¼¶¸ù¹Çµ¤ÌáÉıÎòĞÔ¡£
					return
				end
			else
				--»Ã»¯ÕäÊŞÎòĞÔ´óÓÚ14¾Í²»ÄÜÔÙÌáÉıÁË....
				SetNotifyTip("#{RXZS_090804_27}")	--ÄãµÄÕäÊŞÎòĞÔÒÑÌáÉıµ½15£¬²»ÄÜÔÙÏòÉÏÌáÉıÁË¡£
				return
			end
		else
			--·Ç»Ã»¯ÕäÊŞ
			SetNotifyTip("#{RXZS_090804_25}")	--Ö»ÓĞ»Ã»¯ºó£¬ÇÒÎòĞÔ¡İ10µÄÕäÊŞ²ÅÄÜÊ¹ÓÃ³¬¼¶¸ù¹Çµ¤ÌáÉıÎòĞÔ¡£
			return
		end
	end

	-- ¼ÇÂ¼¸Ã³èµÄÎ»ÖÃºÅ¡¢GUID
	mainPet.idx = petIdx
	mainPet.guid.high = guidH
	mainPet.guid.low = guidL

	--¸üĞÂ½ğÇ®ºÍ¼¸ÂÊÏÔÊ¾
	PetSavvyGGD_CalcSuccOdds()
	PetSavvyGGD_CalcCost()
	--¼ì²é ¸ú¹Ç µ¤
	local nSavvyNeed = savvy+1;
	local nItemIdGenGuDan = 0;
	local msgTemp;

	if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
		msgTemp = "Th¤p";
	elseif nSavvyNeed >= 4 and nSavvyNeed <= 6 then
		msgTemp = "Trung"
	elseif nSavvyNeed >= 7 and nSavvyNeed <= 10 then
		msgTemp = "Cao"
	elseif nSavvyNeed >= 11 and nSavvyNeed <= 15 then
		msgTemp = "Siêu"
	end

	local bExist = IsItemExist( nItemIdGenGuDan );

	if bExist <= 0 then
		local msg = "Nâng ngµ tính ğªn "..nSavvyNeed.."C¥n "..msgTemp.." c¤p cån c¯t ğan. ";
		PetSavvyGGD_GGD : SetText( msg );
		return;
	end

end

function PetSavvyGGD_OnEvent(event)

	--PushDebugMessage("PetSavvyGGD : "..event);

	if event == "UI_COMMAND" and tonumber( arg0 ) == 19820425 then	-- ´ò¿ª½çÃæ
		if this : IsVisible() then									-- Èç¹û½çÃæ¿ª×Å£¬Ôò²»´¦Àí
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
		if this : IsVisible() then									-- Èç¹û½çÃæ¿ª×Å£¬Ôò²»´¦Àí
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

	-- Íæ¼ÒÑ¡ÁËÒ»Ö»ÕäÊŞ
	if ( event == "REPLY_MISSION_PET" and this:IsVisible() )then
		PetSavvyGGD_GGD : SetText( "" );
		PetSavvyGGD_SelectPet( tonumber( arg0 ) )

		PetSavvyGGD_SelfMoney_Text:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- Íæ¼ÒÉíÉÏµÄÕäÊŞÊı¾İ·¢Éú±ä»¯£¬°üÀ¨ÕäÊŞ³öÕ½¡¢ĞİÏ¢¡¢Ôö¼ÓÒ»Ö»ÕäÊŞ
	if event == "UPDATE_PET_PAGE" and this : IsVisible() then
		PetSavvyGGD_UpdateSelected()
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- Íæ¼ÒÉíÉÏ¼õÉÙÒ»Ö»ÕäÊŞ
	if event == "DELETE_PET" and this : IsVisible() then
		PetSavvyGGD_UpdateSelected()
		PetSavvyGGD_SelfMoney:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")));
		PetSavvyGGD_SelfJiaozi:SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")));
		return
	end

	-- ¹ØĞÄ NPC µÄ´æÔÚºÍ·¶Î§
	if event == "OBJECT_CARED_EVENT" and this : IsVisible() then
		Pet : ShowPetList( 0 )
		if tonumber( arg0 ) ~= theNPC then
			return
		end

		--Èç¹ûºÍNPCµÄ¾àÀë´óÓÚÒ»¶¨¾àÀë»òÕß±»É¾³ı£¬×Ô¶¯¹Ø±Õ
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

	-- ´ò¿ª½»Ò×½çÃæµÄÍ¬Ê±¹Ø±Õ¸Ã½çÃæ£¬µ«ÊÇĞèÒªË¢ĞÂÒ»ÏÂÕäÊŞÁĞ±í
	if (event == "OPEN_EXCHANGE_FRAME" and this:IsVisible()) then
		StopCareObject()
		PetSavvyGGD_Clear()
		Pet : ShowPetList( 0 )
		Pet : ShowPetList( 1 )
		this:Hide()
	end

end

function PetSavvyGGD_Choose_Clicked( type )

	-- ¹ØÒ»ÏÂÔÙ¿ª£¬Çå¿ÕÊı¾İ
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
		-- ¸üĞÂÕäÊŞÁĞ±í½çÃæ
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
	PetSavvyGGD_Text2 : SetText( "#cFF0000TÖ l® thành công" )
	PetSavvyGGD_NeedMoney : SetProperty( "MoneyNumber", tostring( 0 ) )

	PetSavvyGGD_OK : Disable()

	currentChoose = -1
end

-- ¼ÆËã³É¹¦ÂÊ
function PetSavvyGGD_CalcSuccOdds()
	if mainPet.idx == -1 then
		PetSavvyGGD_Text2 : SetText( "#cFF0000TÖ l® thành công" )
		PetSavvyGGD_OK : Disable()
		return
	end

	succOdds = {													-- Ë÷ÒıÊÇÕäÊŞµÄµ±Ç°ÎòĞÔÖµ
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
		str = "Không có cách nào thång c¤p"
		PetSavvyGGD_OK : Disable()
	else
		str = str .. math.floor( odds / 10 ) .. "%"
		PetSavvyGGD_OK : Enable()
	end

	PetSavvyGGD_Text2 : SetText( str )
end

-- ¼ÆËã½ğÇ®ÏûºÄ
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

	-- ÅĞ¶Ï±»Ñ¡ÖĞµÄÕäÊŞÊÇ·ñ»¹ÔÚ±³°üÀï
	if mainPet.idx ~= -1 then
		local newIdx = Pet : GetPetIndexByGUID( mainPet.guid.high, mainPet.guid.low )

		-- Èç¹û²»ÔÚÔòÉ¾µô
		if newIdx == -1 then
			mainPet.idx = -1
			mainPet.guid.high = -1
			mainPet.guid.low = -1
			PetSavvyGGD_Pet : SetText( "" )
			PetSavvyGGD_Text2 : SetText( "#cFF0000TÖ l® thành công" )
			PetSavvyGGD_OK : Disable()
		-- ·ñÔòÅĞ¶ÏÕäÊŞµÄÎ»ÖÃÊÇ·ñ·¢Éú±ä»¯
		elseif newIdx ~= mainPet.idx then
			-- Èç¹û·¢Éú±ä»¯Ôò¶ÔÎ»ÖÃ½øĞĞ¸üĞÂ
			mainPet.idx = newIdx
		end
	end

	PetSavvyGGD_SelectPet( mainPet.idx );

end

--=========================================================
--¿ªÊ¼¹ØĞÄNPC£¬
--ÔÚ¿ªÊ¼¹ØĞÄÖ®Ç°ĞèÒªÏÈÈ·¶¨Õâ¸ö½çÃæÊÇ²»ÊÇÒÑ¾­ÓĞ¡°¹ØĞÄ¡±µÄNPC£¬
--Èç¹ûÓĞµÄ»°£¬ÏÈÈ¡ÏûÒÑ¾­ÓĞµÄ¡°¹ØĞÄ¡±
--=========================================================
function BeginCareObject( objCaredId )
	theNPC = DataPool : GetNPCIDByServerID( objCaredId )
	if theNPC == -1 then
		PushDebugMessage("Chßa phát hi®n NPC")
		this : Hide()
		return
	end

	this : CareObject( theNPC, 1, "PetSavvyGGD" )
end

--=========================================================
--Í£Ö¹¶ÔÄ³NPCµÄ¹ØĞÄ
--=========================================================
function StopCareObject()
	this : CareObject( theNPC, 0, "PetSavvyGGD" )
	Pet : ShowPetList( 0 )
	theNPC = -1
end

--PetPropagateSingle.lua
--µ•»À’‰ ﬁ∑±÷≥ΩÁ√Ê(¡Ω∏ˆ’‰ ﬁ)
local firstPet  = { idx = -1, guid = { high = -1, low = -1 } }
local secondPet = { idx = -1, guid = { high = -1, low = -1 } }
local g_currentChoose = -1
local g_wastemoney 	= 20000
--µ•»À’‰ ﬁ∑±÷≥≤ƒ¡œ
local g_ItemPos 	= -1
--µ•»À’‰ ﬁ∑±÷≥≤ƒ¡œID ∞Æ–ƒ–°Œ—
local g_ItemTblID   = 30309794
--
local g_clientNpcId = -1
local g_serverNpcId = -1
--*************************************************
--
--*************************************************
function PetPropagateSingle_PreLoad()
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )
	this : RegisterEvent( "REPLY_MISSION_PET" )				-- ÕÊº“¥”¡–±Ì—°∂®“ª÷ª’‰ ﬁ
	this : RegisterEvent( "UPDATE_PET_PAGE" )				-- ÕÊº“…Ì…œµƒ’‰ ﬁ ˝æ›∑¢…˙±‰ªØ
	this : RegisterEvent( "DELETE_PET" )					-- ÕÊº“…Ì…œºı…Ÿ“ª÷ª’‰ ﬁ
	this : RegisterEvent( "OBJECT_CARED_EVENT" )			-- πÿ–ƒ NPC µƒ¥Ê‘⁄∫Õ∑∂Œß
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )				--Ωª◊”
	this : RegisterEvent( "PACKAGE_ITEM_CHANGED" )
	this : RegisterEvent( "UPDATE_PET_PROPAGASINGLE" )
end

function PetPropagateSingle_OnLoad()
end

--*************************************************
--
--*************************************************
function PetPropagateSingle_OnEvent(event)

	if ( event == "UI_COMMAND" ) then
		PetPropagateSingle_UICommand(arg0)

	elseif ( event == "UNIT_MONEY" )		then
		PetPropagateSingle_ShowMoney()

	elseif ( event == "MONEYJZ_CHANGE")		then
		PetPropagateSingle_ShowJZ()

	elseif ( event == "REPLY_MISSION_PET" ) then
		PetPropagateSingle_SelectPet(arg0)

	elseif ( event == "UPDATE_PET_PAGE" ) 	then
		PetPropagateSingle_UpdatePetSelected()

	elseif ( event == "DELETE_PET" ) 		then
		PetPropagateSingle_UpdatePetSelected()

	elseif ( event == "OBJECT_CARED_EVENT" )		then
		PetPropagateSingle_CareObj(arg0,arg1,arg2)

	elseif ( event == "PACKAGE_ITEM_CHANGED" ) 		then
		if ( arg0 ~= nil and -1 == tonumber(arg0)) 	then
			return
		end

		if tonumber(arg0) == g_ItemPos then
			PetPropagateSingle_Resume_Object()
		end

	elseif ( event == "UPDATE_PET_PROPAGASINGLE" ) 	then
		PetPropagateSingle_Update(arg0)

	end
end

--*************************************************
--µ•»À’‰ ﬁ∑±÷≥ΩÁ√ÊΩ” ‹√¸¡Ó
--*************************************************
function PetPropagateSingle_UICommand(arg0)
	local nOpt = tonumber(arg0)
	if (nOpt == 20091025) then
		PetPropagateSingle_Show()
	end
end

--*************************************************
--¥¶¿ÌÕÊº“»∑»œ“™◊ˆµƒ ¬«È
--*************************************************
function PetPropagateSingle_OK_Clicked()
	-- ∑¢ÀÕ UI_Command Ω¯––∫œ≥…
	local nName1 = PetPropagateSingle_PetName1 : GetText()
	local nName2 = PetPropagateSingle_PetName2 : GetText()
	if (firstPet.guid.high == -1 or firstPet.guid.low == -1	or secondPet.guid.high == -1 or secondPet.guid.low == -1) then
		PushDebugMessage("H„y ch˜n Tr‚n Th˙!")
		return
	end

	if (nName1 == nil or nName1 == "" or nName2 == nil or nName2 == "") then
		PushDebugMessage("H„y ch˜n Tr‚n Th˙!")
		return
	end

	if (g_ItemPos == -1) then
		PushDebugMessage("#{DRFZZC_091013_17}")
		return
	end

	local nItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
	if (nItemID ~= g_ItemTblID) then
		PushDebugMessage("#{DRFZZC_091013_17}")
		return
	end

	--Ω«Æ «∑Ò◊„πª
	local nHaveMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if (nHaveMoney < g_wastemoney) then
		PushDebugMessage("Ti´n khÙng ¸, khÙng th¨ ho‡n ∞ng.")
		return
	end

	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "OnSignalPetProcreateRegister" )
		Set_XSCRIPT_ScriptID( 800101 )
		Set_XSCRIPT_Parameter( 0, g_serverNpcId )
		Set_XSCRIPT_Parameter( 1, firstPet.guid.high )
		Set_XSCRIPT_Parameter( 2, firstPet.guid.low )
		Set_XSCRIPT_Parameter( 3, secondPet.guid.high )
		Set_XSCRIPT_Parameter( 4, secondPet.guid.low )
		Set_XSCRIPT_Parameter( 5, g_ItemPos )
		Set_XSCRIPT_ParamCount( 6 )
	Send_XSCRIPT()
end

--*************************************************
--µ„ª˜X∞¥≈•£¨“˛≤ÿ¥∞ø⁄°£
--*************************************************
function PetPropagateSingle_OnHidden()
	if (this : IsVisible() == 1) then
		return
	end

	if (g_clientNpcId ~= -1) then
		this : CareObject(g_clientNpcId, 0, "PetPropagateSingle")
	end

	PetPropagateSingle_Clear()
	Pet : ShowPetList( 0 )
	this : Hide()
end

--*************************************************
--µ„ª˜»°œ˚∞¥≈•£¨¥∞ø⁄“˛≤ÿ∫Ø ˝
--*************************************************
function PetPropagateSingle_Close_Window()
	if (this : IsVisible() == 1) then
		return
	end

	if (g_clientNpcId ~= -1) then
		this : CareObject(g_clientNpcId, 0, "PetPropagateSingle")
	end

	PetPropagateSingle_Clear()
	Pet : ShowPetList( 0 )
	this : Hide()
end

--*************************************************
--πÿ–ƒNPC
--*************************************************
function PetPropagateSingle_CareObj(careId, op, distance)
	if(nil == careId or nil == op or nil == distance) then
		return;
	end

	if(tonumber(careId) ~= g_clientNpcId) then
		return;
	end

	if(op == "distance" and tonumber(distance)>MAX_OBJ_DISTANCE or op=="destroy") then
		PetPropagateSingle_OnHidden()
	end
end

--*************************************************
--¥Úø™µ•»À’‰ ﬁ∑±÷≥ΩÁ√Ê
--*************************************************
function PetPropagateSingle_Show()
	if (this : IsVisible()) then									-- »Áπ˚ΩÁ√Êø™◊≈£¨‘Ú≤ª¥¶¿Ì
		return
	end

	--ΩÁ√Êµƒ÷˜»À
	g_serverNpcId = Get_XParam_INT(0)
	g_clientNpcId = Target : GetServerId2ClientId(g_serverNpcId)

	if (g_clientNpcId == -1) then
		return
	end

	this : CareObject(g_clientNpcId, 1, "PetPropagateSingle")

	--’‰ ﬁœ‘ æΩÁ√Ê
	PetPropagateSingle_Clear()
	Pet : ShowPetList( 0 )
	this : Show()

	local npcObjId = Get_XParam_INT( 0 )
	BeginCareObject( npcObjId )

	PetPropagateSingle_SelfJiaozi : SetProperty("MoneyNumber", tostring(Player:GetData("MONEY_JZ")))
	PetPropagateSingle_SelfMoney  : SetProperty("MoneyNumber", tostring(Player:GetData("MONEY")))
	PetPropagateSingle_PetList_Select1 : Enable()
	PetPropagateSingle_PetList_Select2 : Enable()
end


--*************************************************
--—°‘Ò’‰ ﬁ
--*************************************************
function PetPropagateSingle_SelectPet_Clicked(type)
	if (type == "first") then
		g_currentChoose = 1
		PetPropagateSingle_PetList_Select1 : Disable()
		PetPropagateSingle_PetList_Select2 : Enable()
	elseif (type == "second") then
		g_currentChoose = 2
		PetPropagateSingle_PetList_Select1 : Enable()
		PetPropagateSingle_PetList_Select2 : Disable()
	else
		return
	end
	-- πÿ“ªœ¬‘Ÿø™£¨«Âø’ ˝æ›
	Pet : ShowPetList( 0 )
	Pet : ShowPetList( 1 )
end

--***************************************************
--
--***************************************************
function PetPropagateSingle_SelectPet( arg0 )

	--≈–∂œµ•»À’‰ ﬁ∑±÷≥
	if (not (this : IsVisible())) then
		return
	end

	--’‰ ﬁÀ˜“˝
	local petIdx = tonumber(arg0)
	if (-1 == petIdx) then
		return
	end

	--≈–∂œ «∑Ò’‰ ﬁº”À¯
	if (PlayerPackage:IsPetLock(petIdx) == 1) then
		PushDebugMessage("#{DRFZZC_091013_09}")
		return
	end

	--≈–∂œ «∑Ò’‰ ﬁ≥ˆ’Ω
	if (Pet : GetIsFighting(petIdx) == 1) then
		PushDebugMessage("#{DRFZZC_091013_10}")
		return
	end

	--≈–∂œ «∑ÒŒ™’‰ ﬁ±¶±¶
	if (Pet : GetPetType(petIdx) ~= 0) then
		PushDebugMessage("#{DRFZZC_091013_11}")
		return
	end

	--≈–∂œ’‰ ﬁ «∑ÒŒ™ª√ªØ
	if (1 >= 100 ) then
	--if (Pet : GetGeneration(petIdx) >= 100 ) then
		PushDebugMessage("#{DRFZZC_091013_12}")
		return
	end

	--≈–∂œ’‰ ﬁ «∑ÒøÏ¿÷∂»Œ™100
	if (Pet : GetHappy(petIdx) ~= 100) then
		PushDebugMessage("#{DRFZZC_091013_13}")
		return
	end

	--≈–∂œ’‰ ﬁ «∑Ò¥©¡À◊∞±∏
	--if (Pet : IsPetHaveEquip(petIdx) == 1) then
	if (0 == 1) then
		PushDebugMessage("#{DRFZZC_091013_14}")
		return
	end

	--≈–∂œ’‰ ﬁ Ÿ√¸ «∑ÒŒ™1000
	if (Pet : GetNaturalLife(petIdx) < 1000) then
		PushDebugMessage("#{DRFZZC_091013_15}")
		return
	end

	local petName = Pet : GetPetList_Appoint( petIdx )
	local guidH, guidL = Pet : GetGUID( petIdx )

	if (g_currentChoose == 1) then
		--≈–∂œ «∑Òµ⁄“ª∏ˆ’‰ ﬁ∫Õµ⁄∂˛∏ˆ’‰ ﬁ «Õ¨“ª∏ˆ’‰ ﬁ
		if (secondPet.idx ~= -1 and secondPet.idx == petIdx) then
			ShowSystemTipInfo( "M∂i cho v‡o 2 con tr‚n th˙ kh·c nhau." )
			return
		end

		--»Áπ˚∆‰÷–”–’‰ ﬁ¡À£¨«Âø’
		PetPropagateSingle_RemoveFirstPet()

		firstPet.idx = petIdx
		firstPet.guid.high = guidH
		firstPet.guid.low  = guidL

		--ÃÓ–¥µ⁄“ª∏ˆ’‰ ﬁ√˚◊÷
		PetPropagateSingle_PetName1 : SetText( petName )
		Pet : SetPetLocation( petIdx , 2 )
		--Pet : UpdatePetList()

	elseif (g_currentChoose == 2) then
		--≈–∂œ «∑Òµ⁄“ª∏ˆ’‰ ﬁ∫Õµ⁄∂˛∏ˆ’‰ ﬁ «Õ¨“ª∏ˆ’‰ ﬁ
		if (firstPet.idx ~= -1 and firstPet.idx == petIdx) then
			ShowSystemTipInfo( "M∂i cho v‡o 2 con tr‚n th˙ kh·c nhau." )
			return
		end

		--»Áπ˚∆‰÷–”–’‰ ﬁ¡À£¨«Âø’
		PetPropagateSingle_RemoveSecondPet()

		secondPet.idx = petIdx
		secondPet.guid.high = guidH
		secondPet.guid.low  = guidL

		--ÃÓ–¥µ⁄∂˛∏ˆ’‰ ﬁµƒ√˚◊÷
		PetPropagateSingle_PetName2 : SetText( petName )
		Pet : SetPetLocation( petIdx , 2 )
		--Pet : UpdatePetList()
	end

	--œ‘ æœ˚∫ƒ∂‡…ŸΩ«Æ
	PetPropagateSingle_CalcCost()
end

--***************************************************
--«Âø’µ⁄“ª∏ˆ’‰ ﬁ
--***************************************************
function PetPropagateSingle_RemoveFirstPet()
	if (firstPet.idx ~= -1) then
		Pet : SetPetLocation( firstPet.idx, -1 )
		-- ∏¸–¬’‰ ﬁ¡–±ÌΩÁ√Ê
		--Pet : UpdatePetList()
	end

	firstPet.idx = -1
	firstPet.guid.high = -1
	firstPet.guid.low  = -1
	PetPropagateSingle_PetName1 : SetText( "" )
end


--***************************************************
--«Âø’µ⁄∂˛∏ˆ’‰ ﬁ
--***************************************************
function PetPropagateSingle_RemoveSecondPet()
	if (secondPet.idx ~= -1) then
		Pet : SetPetLocation( secondPet.idx, -1 )
		-- ∏¸–¬’‰ ﬁ¡–±ÌΩÁ√Ê
		--Pet : UpdatePetList()
	end

	secondPet.idx = -1
	secondPet.guid.high = -1
	secondPet.guid.low  = -1
	PetPropagateSingle_PetName2 : SetText( "" )
end


--****************************************************
--º∆À„Ω«Æœ˚∫ƒ
--****************************************************
function PetPropagateSingle_CalcCost()
	PetPropagateSingle_Money : SetProperty( "MoneyNumber", tostring( g_wastemoney ) )
end


--****************************************************
--∏¸–¬ΩÁ√Ê
--****************************************************
function PetPropagateSingle_Update( pos_packet )
	if (pos_packet == nil) then
		return
	end

	local BagPos = tonumber( pos_packet )

	-- «∑Òº”À¯....
	if (PlayerPackage:IsLock(BagPos) == 1) then
		PushDebugMessage("#{Item_Locked}")
		return
	end

	--∏¸–¬µ•»À’‰ ﬁ∑±÷≥≤ƒ¡œΩÁ√Ê
	local ItemID = PlayerPackage : GetItemTableIndex( BagPos )
	if ( ItemID <= 0) then
		PushDebugMessage("#{GMActionSystem_Item_CantUseInPetSkillStudy}")
		return
	end

	--≤Èø¥ŒÔ∆∑ «∑Ò «°∞∞Æ–ƒ–°Œ—°±
	if ( ItemID ~= g_ItemTblID) then
		PushDebugMessage("#{DRFZZC_091013_17}")
		return
	end

	--’‰ ﬁŒÔ∆∑Œª÷√ «∑Ò∫œ∑®
	if (g_ItemPos ~= -1) then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end

	LifeAbility : Lock_Packet_Item( BagPos, 1 )
	g_ItemPos = BagPos

	--∏¸–¬’‰ ﬁªπÕØµƒ’‰ ﬁΩÁ√Ê
	local theAction = EnumAction( BagPos, "packageitem" )
	if (theAction : GetID() == 0) then
		return
	end

	PetPropagateSingle_Object : SetActionItem( theAction : GetID() )
	PetPropagateSingle_CalcCost()
end


--*************************************************
--
--*************************************************
function PetPropagateSingle_Resume_Object()
	PetPropagateSingle_ClearActionItem()
end

--*************************************************
--
--*************************************************
function PetPropagateSingle_Clear()
	PetPropagateSingle_ClearPetName()
	PetPropagateSingle_ClearActionItem()
	PetPropagateSingle_ClearMoney()
end

--*************************************************
--«Âø’¡Ω∏ˆ’‰ ﬁ√˚◊÷
--*************************************************
function PetPropagateSingle_ClearPetName()
	PetPropagateSingle_RemoveFirstPet()
	PetPropagateSingle_RemoveSecondPet()
end

--*************************************************
--«Âø’∑±÷≥ŒÔ∆∑
--*************************************************
function PetPropagateSingle_ClearActionItem()
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
		PetPropagateSingle_Object : SetActionItem( -1 )
		g_ItemPos = -1
	end
end

--*************************************************
--«Âø’Ω«Æ
--*************************************************
function PetPropagateSingle_ClearMoney()
	PetPropagateSingle_Money : SetProperty( "MoneyNumber", 0 )
	PetPropagateSingle_SelfJiaozi : SetProperty( "MoneyNumber", 0 )
	PetPropagateSingle_SelfMoney  : SetProperty( "MoneyNumber", 0 )
end

--*************************************************
--—°‘Ò’‰ ﬁ∏¸–¬
--*************************************************
function PetPropagateSingle_UpdatePetSelected()
	-- ≈–∂œ±ª—°÷–µƒ’‰ ﬁ «∑Òªπ‘⁄±≥∞¸¿Ô
	if (firstPet.idx ~= -1) then
		local newIdx = Pet : GetPetIndexByGUID( firstPet.guid.high, firstPet.guid.low )
		-- »Áπ˚≤ª‘⁄‘Ú…æµÙ
		if (newIdx == -1) then
			firstPet.idx = -1
			firstPet.guid.high = -1
			firstPet.guid.low  = -1
			PetPropagateSingle_PetName1 : SetText( "" )
		-- ∑Ò‘Ú≈–∂œ’‰ ﬁµƒŒª÷√ «∑Ò∑¢…˙±‰ªØ
		elseif (newIdx ~= firstPet.idx) then
			-- »Áπ˚∑¢…˙±‰ªØ‘Ú∂‘Œª÷√Ω¯––∏¸–¬
			firstPet.idx = newIdx
		end
	end

	-- ≈–∂œ±ª—°÷–µƒ’‰ ﬁ «∑Òªπ‘⁄±≥∞¸¿Ô
	if (secondPet.idx ~= -1) then
		local newIdx = Pet : GetPetIndexByGUID( secondPet.guid.high, secondPet.guid.low )
		-- »Áπ˚≤ª‘⁄‘Ú…æµÙ
		if (newIdx == -1) then
			secondPet.idx = -1
			secondPet.guid.high = -1
			secondPet.guid.low  = -1
			PetPropagateSingle_PetName2 : SetText( "" )
		-- ∑Ò‘Ú≈–∂œ’‰ ﬁµƒŒª÷√ «∑Ò∑¢…˙±‰ªØ
		elseif (newIdx ~= secondPet.idx) then
			-- »Áπ˚∑¢…˙±‰ªØ‘Ú∂‘Œª÷√Ω¯––∏¸–¬
			secondPet.idx = newIdx
		end
	end
end

--********************************************
--œ‘ æ◊‘…Ì”µ”–µƒΩ«Æ
--********************************************
function PetPropagateSingle_ShowMoney()
	PetPropagateSingle_SelfMoney : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY")) )
end

--********************************************
--œ‘ æ◊‘…Ì”µ”–µƒΩª◊”
--********************************************
function PetPropagateSingle_ShowJZ()
	PetPropagateSingle_SelfJiaozi : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY_JZ")) )
end

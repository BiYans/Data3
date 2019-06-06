
local g_uitype = 1
local g_serverScriptId = 311111
local g_serverNpcId = -1
local g_clientNpcId = -1
local g_ItemPos		= -1
local g_NeedMoney	= -1
local g_selidx		= -1
local g_ItemID		= -1
local g_Contrl		= false
local MAX_OBJ_DISTANCE = 3.0
local g_DefaultTxt = "M¶i các hÕ ğ¦y nhæng ğÕo cø c¥n dùng vào trong khung ğÕo cø trß¾c m£t."
local g_Model1IsEnabel = 0
local g_Model2IsEnabel = 0
--³¬¼¶ÕäÊŞ»¹Í¯ÌìÊé
local g_HuanTongCJTS = {30503016,30503017,30503018,30503019,30503020}
--ÄÜ¹»·ÅÈë½çÃæÖĞµÄÎïÆ· ¿ªÊ¼
local g_HuanTongMin1 = 30503011
local g_HuanTongMax1 = 30503020
local g_HuanTongMin2 = 30309100
local g_HuanTongMax2 = 30309500
--ÄÜ¹»·ÅÈë½çÃæÖĞµÄÎïÆ· ½áÊø
--¸÷¸öµÈ¼¶»¹Í¯µÄÕäÊŞËùĞèÒªµÄ½ğÇ®
local g_tbabaymoney  = {
							[5]		= 5000,
							[15]	= 6000,
							[20]	= 7000,
							[25]	= 7000,
							[35]	= 10000,
							[45]	= 15000,
							[55]	= 25000,
							[65]	= 40000,
							[75]	= 55000,
							[85]	= 70000,
							[95]	= 85000,
							[105]	= 100000,
						}
--****************************************
--×¢²áÏûÏ¢
--****************************************
function Pethuantong_PreLoad()
	this : RegisterEvent( "UNIT_MONEY" )
	this : RegisterEvent( "UI_COMMAND" )
	this : RegisterEvent( "DELETE_PET" )
	this : RegisterEvent( "MONEYJZ_CHANGE" )
	this : RegisterEvent( "UPDATE_PET_PAGE" )
	this : RegisterEvent( "REPLY_MISSION_PET" )
	this : RegisterEvent( "OBJECT_CARED_EVENT" )
	this : RegisterEvent( "PACKAGE_ITEM_CHANGED" )
	this : RegisterEvent( "UPDATE_PET_HUANTONG" )
	this : RegisterEvent( "NEW_DEBUGMESSAGE" )
end

--****************************************
--
--****************************************
function Pethuantong_OnLoad()
end

--****************************************
--´¥·¢ÊÂ¼şÏûÏ¢
--****************************************
function Pethuantong_OnEvent(event)
	if	   ( event == "UI_COMMAND" ) 		then
		Pethuantong_UiCommand(arg0, arg1)

	elseif ( event == "UNIT_MONEY" )		then
		Pethuantong_ShowMoney()

	elseif ( event == "DELETE_PET" and this:IsVisible() ) 		then
		Pethuantong_Hide()

	elseif ( event == "MONEYJZ_CHANGE")		then
		Pethuantong_ShowJZ()

	elseif ( event == "UPDATE_PET_PAGE" and this:IsVisible() ) 	then
		Pethuantong_Show()

	elseif ( event == "REPLY_MISSION_PET" and this:IsVisible() ) 	then
		Pethuantong_Selected(arg0)

	elseif ( event == "OBJECT_CARED_EVENT") then
		Pethuantong_CareObj(arg0,arg1,arg2)

	elseif ( event == "UPDATE_PET_HUANTONG" and this:IsVisible() ) then
		Pethuantong_Update(arg0)

	elseif ( event == "PACKAGE_ITEM_CHANGED") then
		if ( arg0 ~= nil and -1 == tonumber(arg0)) then
			return
		end

		if tonumber(arg0) == g_ItemPos then
			if (g_ItemID ~= -1) then
				local nextPos = PlayerPackage:GetItemTableIndex( g_ItemPos );--PlayerPackage : GetBagPosByItemIndex(g_ItemID)
				if nextPos >=0 then
					Pethuantong_Update(nextPos)
				else
					Pethuantong_Resume_Equip_Gem()
				end
			else
				Pethuantong_Resume_Equip_Gem()
			end
		end
	end
end

--*************************************************
--Ê¹ÓÃUICOMMAND
--*************************************************
function Pethuantong_UiCommand(...)
	local nOp = tonumber(arg0)
	if (nOp == 20090929) then
		Pethuantong_Open()
	elseif (this:IsVisible()) then
		if (nOp == 20170120) then
			Pethuantong_Update(arg1)
		elseif (nOp == 20170121) then
			Pethuantong_Selected(arg1)
		end

	end
end

--*************************************************
--ÏÔÊ¾ÕäÊŞ»¹Í¯½çÃæ
--*************************************************
function Pethuantong_Open()
	--Pethuantong_Clear()
	g_serverNpcId = Get_XParam_INT(0)
	g_clientNpcId = Target : GetServerId2ClientId(g_serverNpcId)
	if (g_clientNpcId == -1) then
		return
	end

	this : CareObject(g_clientNpcId, 1, "Pethuantong")

	Pethuantong_PetModel : SetFakeObject("")
	--Pethuantong_Mode1 : Disable()
	--Pethuantong_Mode2 : Disable()
	g_uitype = Get_XParam_INT(1)
	g_selidx = -1

	Pet : ShowPetList(0)
	Pet : ShowPetList(1)
	this : Show()
end

--*************************************************
--¹Ø±ÕÕäÊŞ»¹Í¯½çÃæ
--*************************************************
function Pethuantong_Hide()
	if (g_clientNpcId ~= -1) then
		this : CareObject(g_clientNpcId, 0, "Pethuantong")
	end

	this: Hide()
	Pet : ShowPetList(-1)
	Pethuantong_PetModel : SetFakeObject("")
	if (-1 ~= g_selidx) then
		Pet : SetPetLocation(g_selidx, -1)
	end
	g_selidx = -1
end

--*************************************************
--È·¶¨°´Å¥
--*************************************************
function Pethuantong_Do()
	--ÊÇ·ñÑ¡ÔñÕäÊŞ
	if (-1 == g_selidx) then
		PushDebugMessage("Ch÷n Thú")
		return
	end

	--ÊÇ·ñÑ¡Ôñ²ÄÁÏ
	if (-1 == g_ItemPos) then
		PushDebugMessage("C¥n có sách hoàn ğ°ng")
		return
	end

	--ÊÇ·ñ½ğÇ®×ã¹»
	local nHaveMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
	if (nHaveMoney < g_NeedMoney) then
		PushDebugMessage("Ti«n không ğü, không th¬ hoàn ğ°ng.")
		return
	end

	--
	local nItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
	g_ItemID = nItemID
	local bRet = 0
	for i=1,table.getn(g_HuanTongCJTS) do
		if (g_HuanTongCJTS[i] == nItemID) then
			bRet = 1
		end
	end

	if (bRet ~= 1) then
		Pet : SkillStudy_Do(2, g_selidx, g_ItemPos)
	else
		local bSelected1 = 0
		if (g_Model1IsEnabel == 1) then
			bSelected1 = Pethuantong_Mode1:GetCheck()
		end

		local bSelected2 = 0
		if (g_Model2IsEnabel == 1) then
			bSelected2 = Pethuantong_Mode2:GetCheck()
		end
    Pet : SkillStudy_Do(2, g_selidx, g_ItemPos) -- Server doesnt have New Huantong Script
		-- local hid,lid = Pet:GetGUID(g_selidx)
		-- Clear_XSCRIPT()
		-- 	Set_XSCRIPT_Function_Name("OnPropagate")
		-- 	Set_XSCRIPT_ScriptID(311111)
		-- 	Set_XSCRIPT_Parameter(0,g_serverNpcId)
		-- 	Set_XSCRIPT_Parameter(1,hid)
		-- 	Set_XSCRIPT_Parameter(2,lid)
		-- 	Set_XSCRIPT_Parameter(3,bSelected1)
		-- 	Set_XSCRIPT_Parameter(4,bSelected2)
		-- 	Set_XSCRIPT_Parameter(5,g_ItemPos)
		-- 	Set_XSCRIPT_ParamCount(6)
		-- Send_XSCRIPT();
		--Pethuantong_Clear()
		--PetPropagateCheck_Accept:Disable()
	end
	g_Contrl = true
end

--*************************************************
--¹ØĞÄNPC
--*************************************************
function Pethuantong_CareObj(careId, op, distance)
	if(nil == careId or nil == op or nil == distance) then
		return
	end

	if(tonumber(careId) ~= g_clientNpcId) then
		return
	end

	if(op == "distance" and tonumber(distance)>MAX_OBJ_DISTANCE or op=="destroy") then
		Pethuantong_Hide()
	end
end


--*************************************************
--Ñ¡Ôñ²»Í¬ÕäÊŞÊ±£¬ÉèÖÃ²»Í¬µÄÕäÊŞÄ£ĞÍ
--*************************************************
function Pethuantong_Selected(selidx)
	local nSeletedIndex = tonumber(selidx)
	if (this : IsVisible() == 0) then
		return
	end

	if (-1 == nSeletedIndex) then
		return
	end

	-- if Pet:IsPetHaveEquip(nSeletedIndex) == 1 then
	-- 	PushDebugMessage("#{ZSZB_090211_18}")
	-- 	return
	-- end

	if (g_selidx ~= -1) then
		Pet : SetPetLocation(g_selidx,-1)
	end

	g_selidx = tonumber(nSeletedIndex)
	Pethuantong_PetModel : SetFakeObject("")
	Pet : SetSkillStudyModel(g_selidx)
	Pethuantong_PetModel : SetFakeObject("My_PetStudySkill")
	Pet : SetPetLocation(g_selidx,5)

	if (g_ItemPos ~= -1) then
		local ItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
		local petlevel = Pet : GetTakeLevel(selidx)
		local nCostMoney = Pethuantong_GetHuanTongCostMoney(petlevel, ItemID)
		g_NeedMoney = nCostMoney
		Pethuantong_Money : SetProperty("MoneyNumber", tostring(g_NeedMoney))
		Pethuantong_DisableModel()
	else
		Pethuantong_Money : SetProperty("MoneyNumber", "")
	end

end

--*************************************************
--ÕäÊŞ»¹Í¯»¨·ÑµÄ½ğÇ®
--*************************************************
function Pethuantong_GetHuanTongCostMoney(petlevel, itemId)

	if(nil == petlevel or nil == itemId or -1 == itemId) then
		return 0
	end

	if(nil == g_tbabaymoney[petlevel]) then
		return 0
	end

	local costMoney = g_tbabaymoney[petlevel]
	--ÖÕ¼¶»¹Í¯¾íÖáÊÕ·Ñ½µÖÁ90%
	if 	   (itemId == 30503011 or
			itemId == 30503012) then
	--ÕäÊŞ»¹Í¯¾íÖá/¸ß¼¶ÕäÊŞ»¹Í¯¾íÖá
	elseif (itemId == 30503016 or
			itemId == 30503017 or
			itemId == 30503018 or
			itemId == 30503019 or
			itemId == 30503020) then

			costMoney = (costMoney * 90)/100
			if (costMoney <= 0) then
				costMoney = 1
			end
			Pethuantong_Mode1 : Enable()
			Pethuantong_Mode2 : Enable()
	else
	--ÀàËÆ »¹Í¯µ¤£ºÍÃ×Ó
			costMoney = costMoney/100
			if (costMoney <= 0) then
				costMoney = 1
			end
	end
	return costMoney
end


--*************************************************
--
--*************************************************
function Pethuantong_Show()
	if (this : IsVisible() == 0) then
		return
	end

	if (g_Contrl == false) then
		if(g_selidx ~= -1) then
			--if (Pet : GetIsFighting(g_selidx))then
			Pet : SetPetLocation(g_selidx,-1)
			--end
		end
		Pethuantong_PetModel : SetFakeObject( "" )
		g_selidx = -1
	end

	g_Contrl = false
end

--*************************************************
--ÏÔÊ¾½»×Ó
--*************************************************
function Pethuantong_ShowJZ()
	Pethuantong_SelfJiaozi : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY_JZ")) )
end

--*************************************************
--ÏÔÊ¾½ğÇ®
--*************************************************
function Pethuantong_ShowMoney()
	Pethuantong_SelfMoney : SetProperty( "MoneyNumber", tostring(Player:GetData("MONEY")) )
end

--*************************************************
--ÓÒ¼üµã»÷ActionButton
--*************************************************
function Pethuantong_Resume_Equip_Gem()
	Pethuantong_Clear()
end

--*************************************************
--Çå³ı½çÃæ
--*************************************************
function Pethuantong_Clear()
	if g_ItemPos ~= -1 then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
		Pethuantong_Object : SetActionItem( -1 )
		g_ItemPos = -1
		g_NeedMoney = -1
		Pethuantong_Money : SetProperty( "MoneyNumber", 0 )
	end
	--Pethuantong_Mode1 : SetCheck(0)
	--Pethuantong_Mode1 : Disable()
	Pethuantong_Mode1 : Enable()
	--Pethuantong_Mode2 : SetCheck(0)
	--Pethuantong_Mode2 : Disable()
	Pethuantong_Mode2 : Enable()
	g_ItemID = -1
end


--*************************************************
--¸üĞÂ½çÃæ
--*************************************************
function Pethuantong_Update( pos_packet )
	if (pos_packet == nil) then
		return
	end

	local BagPos = tonumber( pos_packet )
	--ÊÇ·ñ¼ÓËø....
	if (PlayerPackage:IsLock(BagPos) == 1) then
		PushDebugMessage("#{Item_Locked}")
		return
	end

	--¸üĞÂÕäÊŞ»¹Í¯²ÄÁÏ½çÃæ
	local ItemID = PlayerPackage : GetItemTableIndex( BagPos )
	if ( ItemID <= 0) then
		--PushDebugMessage("#{GMActionSystem_Item_CantUseInPetSkillStudy}")
		return
	end

	if ( (ItemID < g_HuanTongMin1 or ItemID > g_HuanTongMax1) and
		 (ItemID < g_HuanTongMin2 or ItemID > g_HuanTongMax2)) then
		PushDebugMessage("#{GMActionSystem_Item_CantUseInPetSkillStudy}")
		return
	end

	if (g_ItemPos ~= -1) then
		LifeAbility : Lock_Packet_Item( g_ItemPos, 0 )
	end

	LifeAbility : Lock_Packet_Item( BagPos, 1 )
	g_ItemPos = BagPos

	--¸üĞÂÕäÊŞ»¹Í¯µÄÕäÊŞ½çÃæ
	local theAction = EnumAction( BagPos, "packageitem" )
	if (theAction : GetID() == 0) then
		return
	end

	Pethuantong_Object : SetActionItem( theAction : GetID() )

	--¸üĞÂÕäÊŞ»¹Í¯ĞèÒª»¨·ÑµÄ½ğÇ®
	if (-1 ~= g_selidx) then
		local petlevel = Pet : GetTakeLevel(g_selidx)
		local nCostMoney = Pethuantong_GetHuanTongCostMoney(petlevel, ItemID)
		g_NeedMoney = nCostMoney
		Pethuantong_Money : SetProperty( "MoneyNumber", tostring(g_NeedMoney) )
		Pethuantong_DisableModel()
	end
end

--*************************************************
--¹Ø±Õ½çÃæ
--*************************************************
function Pethuantong_Frame_OnHiden()
	Pethuantong_Hide()
	Pethuantong_Clear()
end

--*************************************************
--Ïò×óĞı×ªÕäÊŞ
--*************************************************
function Pethuantong_Modle_TurnLeft(start)
	--Ïò×óĞı×ª¿ªÊ¼
	if(start == 1) then
		Pethuantong_PetModel : RotateBegin(-0.3)
	--Ïò×óĞı×ª½áÊø
	else
		Pethuantong_PetModel : RotateEnd()
	end
end

--*************************************************
--ÏòÓÒĞı×ªÕäÊŞ
--*************************************************
function Pethuantong_Modle_TurnRight(start)
	--ÏòÓÒĞı×ª¿ªÊ¼
	if(start == 1) then
		Pethuantong_PetModel : RotateBegin(0.3)
	--ÏòÓÒĞı×ª½áÊø
	else
		Pethuantong_PetModel : RotateEnd()
	end
end


--*************************************************
--Ñ¡Ïî Ëø¶¨×ÊÖÊ Ëø¶¨³É³¤ÂÊ
--*************************************************
function Pethuantong_Mode_Clicked(Index)

	if (Index ~= 1 and Index ~= 2) then
		return
	end

end


function Pethuantong_DisableModel()
	if (nil ~= g_selidx and g_selidx ~= -1 and nil ~= g_ItemPos and g_ItemPos ~= -1) then
		--Èç¹û²ÄÁÏÊÇ³¬¼¶ÕäÊŞ»¹Í¯ÌìÊé
		local ItemID = PlayerPackage : GetItemTableIndex( g_ItemPos )
		if (ItemID == 30503017 or ItemID == 30503018 or
			ItemID == 30503019 or ItemID == 30503020) then
			local pettype = -1;--Pet : GetPetType(g_selidx)
			local petgene = -1;--Pet : GetGeneration(g_selidx)
			if (pettype == 0 and petgene == 0) then
				Pethuantong_Mode1 : Enable()
				Pethuantong_Mode2 : Enable()
				g_Model1IsEnabel = 1
				g_Model2IsEnabel = 1
			else
				Pethuantong_Mode1 : SetCheck( 0 )
				Pethuantong_Mode2 : SetCheck( 0 )
				Pethuantong_Mode1 : Disable()
				Pethuantong_Mode2 : Disable()
				g_Model1IsEnabel = 0
				g_Model2IsEnabel = 0
			end
		else
			Pethuantong_Mode1 : SetCheck( 0 )
			Pethuantong_Mode2 : SetCheck( 0 )
			Pethuantong_Mode1 : Disable()
			Pethuantong_Mode2 : Disable()
			g_Model1IsEnabel = 0
			g_Model2IsEnabel = 0
		end
	else
		Pethuantong_Mode1 : Enable()
		Pethuantong_Mode2 : Enable()
	end
end

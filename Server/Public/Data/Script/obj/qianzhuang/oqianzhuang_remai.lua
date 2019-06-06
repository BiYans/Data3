--ÈÈÂôÔª±¦ NPC
--×¢Òâ±¾½Å±¾º¬ÓĞËæÉíÔª±¦Ïà¹Ø¹¦ÄÜ,Çëmµt ¶¨²ÎÕÕÏÖÓĞtoÕ ğµ Àı×Ó½øĞĞĞŞ¸Ä.

x181002_g_scriptId 	= 181002
x181002_g_buyrate 	= 0.5

x181002_g_shoptableindex=151
x181002_g_goodact		= 1		--ÈÈÂôÔª±¦ÉÌµê
x181002_g_YuanBaoIntro	= 18	--Ôª±¦½éÉÜ

--**********************************
--ÊÂ¼ş½»»¥Èë¿Ú
--**********************************
function x181002_OnDefaultEvent( sceneId, selfId, targetId )
	if targetId == -1 then
		x181002_OnEventRequest( sceneId, selfId, targetId, nil )
	else
		BeginEvent( sceneId )
			strText = "    Ğªn ğây mà xem, thß½ng ph¦m bán chÕy nh¤t, giá rë nh¤t. Khách quan, ngài mau ch÷n vài món ği, bäo ğäm ngài mua v« xong ğêm nay n¢m m½ cûng phäi cß¶i "
			AddText( sceneId, strText )
			AddNumText( sceneId, x181002_g_scriptId, "SØ Døng Phiªu Ğ±i Bäo ThÕch", 6, 7413)
			AddNumText( sceneId, x181002_g_scriptId, "Gi¾i thi®u Kim Nguyên Bäo", 11, x181002_g_YuanBaoIntro)
			if targetId < 0 then
				targetId = -1	--ÎªÁËÄÜÕı³£µ¯³öÑ¡Ïî
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--ÊÂ¼şÁĞ±íÑ¡ÖĞmµt Ïî
--**********************************
function x181002_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 7413 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ngß½i mu¯n ğ±i l¤y loÕi bäo thÕch nào?" )
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Äo Minh", 6, 74131)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch M¸ Lñc", 6, 74132)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Sinh M®nh", 6, 74133)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Huy«n Vi", 6, 74134)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Hy V÷ng", 6, 74135)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Th¡ng Lşi", 6, 74136)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Thiên C½", 6, 74137)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch Trí Tu®", 6, 74138)
			AddNumText( sceneId, x181002_g_scriptId, "Bäo ThÕch V§n M®nh", 6, 74139)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 74131 and GetNumText() <= 74139 then
		local key = GetNumText() - 74130
		local GemID = {}
			GemID[1] = {50304002}
			GemID[2] = {50312001,50312002,50312003,50312004}
			GemID[3] = {50311001,50311002}
			GemID[4] = {50303001}
			GemID[5] = {50301001,50301002}
			GemID[6] = {50321001,50321002,50321003,50321004}
			GemID[7] = {50314001}
			GemID[8] = {50302001,50302002,50302003,50302004}
			GemID[9] = {50313001,50313002,50313003,50313004,50313005,50313006}
			
		BeginEvent(sceneId)
			for i = 1, getn(GemID[key]) do
				AddRadioItemBonus( sceneId, GemID[key][i], 1 )
			end
		EndEvent( )
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x181002_g_scriptId,0)
	end

	if GetNumText() == x181002_g_goodact then
		x181002_NewDispatchShopItem( sceneId, selfId,targetId, x181002_g_shoptableindex )
	elseif GetNumText() == x181002_g_YuanBaoIntro	then
		BeginEvent( sceneId )
			AddText( sceneId, "#{INTRO_YUANBAO}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end


function x181002_OnMissionSubmit(sceneId,selfId,targetId,x181002_g_scriptId,ItemID)
	if LuaFnGetAvailableItemCount(sceneId,selfId,30900077) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"Ngß½i không có phiªu ğ±i bäo thÕch à?")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"Hãy s¡p xªp 1 ô tr¯ng trong túi nguyên li®u.")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	LuaFnDelAvailableItem(sceneId,selfId,30900077,1)
	local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
	LuaFnItemBind(sceneId,selfId,iPos)
	
	BeginEvent(sceneId)
		AddText(sceneId,"Chúc m×ng ngß½i ğã nh§n ğßşc #G"..GetItemName(sceneId,ItemID).."#W.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
end
--**********************************
--°´ĞèÀ´µ¯³öÉÌµê,·ÖÎªËæÉíÉÌµêºÍNPCÉÌµê
--**********************************
function x181002_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end

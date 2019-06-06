--ÐÂµÄÔª±¦ÉÌµê

x888902_g_scriptId = 888902
--Ôª±¦ÉÌµêÁÐ±í ÒªÓë¿Í»§¶Ë½çÃæ¶ÔÓ¦
x888902_g_shoplist = {}
x888902_g_shoplist[1]	= {301, 301, 301}				--´óÂô³¡
x888902_g_shoplist[2]	= {149, 150, 178, 193}			--±¦Ê¯ÉÌ³Ç,Ìí¼Ó"´óÀí±¦Ê¯Õ«--149",czf,2009.07.21
x888902_g_shoplist[3]	= {194, 135, 152, 195}			--ÕäÊÞÉÌ³Ç
x888902_g_shoplist[4]	= {136, 137, 144}				--ÄÏ±±ÔÓ»õ
x888902_g_shoplist[5]	= {120, 181, 145, 182, 134}			--ÐÎÏó¹ã³¡
x888902_g_shoplist[6]	= {190, 191, 192, 133}				--»¨ÎèÈË¼ä
x888902_g_shoplist[7]	= {146}						--Îä¹¦ÃØ¼®
x888902_g_shoplist[8]	= {156, 157, 158, 159, 160, 161, 162, 163}	--´òÔìÍ¼

--**********************************
-- ¼ì²é´ËËæÉíNPCµÄ¹¦ÄÜ
-- opÊÇÇëÇóÀà±ð£¬±ÈÈç1´ú±íÔª±¦Ïà¹ØµÄËæÉí²Ù×÷¡­¡­
--**********************************
function x888902_OpenYuanbaoShop( sceneId, selfId, targetId , shopA ,shopB )

	local bCheck = x888902_YuanbaoShopCheckOp(sceneId,selfId);	
	if bCheck > 0 then
		if shopA > 0 and shopA < 9 and x888902_g_shoplist[shopA][shopB] ~= nil then
			--PrintStr(x888902_g_shoplist[shopA][shopB])
			if targetId == -1 then
				DispatchYuanbaoShopItem( sceneId, selfId, x888902_g_shoplist[shopA][shopB])
			else
				DispatchNpcYuanbaoShopItem( sceneId, selfId, targetId , x888902_g_shoplist[shopA][shopB])
			end
		end
	end
end

function x888902_NewShop(sceneId,selfId,ShopID,SlotID)
	local NewShop = {}
		NewShop[0] = {32100024,1,999,32100026,1,999,32100027,1,999,32100028,1,999,32100029,1,999,32100030,1,999,32100031,1,999,32100032,1,999,32100033,1,999,32100034,1,999,32100035,1,999,32100036,1,999,32100037,1,999,32100038,1,999,32100039,1,999,32100040,1,999,32100041,1,999,32100042,1,999,32100043,1,999,32100044,1,999,32100045,1,999,32100046,1,999,32100047,1,999,32100048,1,999,32100049,1,999,32100050,1,999,32100051,1,999,32100052,1,999,32100062,1,999,32100063,1,999,32100064,1,999,32100077,1,999,32100084,1,999,32100087,1,999,32100092,1,999,32100093,1,999}
		NewShop[1] = {0,0,0}
		
	if ShopID == 0 then
		
		if SlotID*3 > getn(NewShop[ShopID]) then
			return
		end
		
		local ItemID = NewShop[ShopID][SlotID*3-2]
		local ItemNum = NewShop[ShopID][SlotID*3-1]
		local ItemPrice = NewShop[ShopID][SlotID*3]
		
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x888902_NotifyFailTips( sceneId, selfId, "Không ðü ô tr¯ng trong túi ÐÕo Cø." )
			return
		end
		
		if YuanBao(sceneId,selfId,-1,3,0) < ItemPrice then
			x888902_NotifyFailTips(sceneId,selfId,"Không ðü Nguyên Bäo.")
			return
		end
		
		YuanBao(sceneId,selfId,-1,2,ItemPrice)
		for i = 1, ItemNum do
			local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
		end
		
		x888902_NotifyFailTips( sceneId, selfId, "Các hÕ ðã mua "..ItemNum.." cái "..GetItemName(sceneId,ItemID)..".")
		return
	end
		
	if SlotID*3 > getn(NewShop[ShopID]) then
		return
	end
	
	local ItemID = NewShop[ShopID][SlotID*3-2]
	local ItemNum = NewShop[ShopID][SlotID*3-1]
	local ItemPrice = 2500*NewShop[ShopID][SlotID*3]
	
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x888902_NotifyFailTips( sceneId, selfId, "Không ðü ô tr¯ng trong túi ÐÕo Cø." )
		return
	end
	
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		x888902_NotifyFailTips( sceneId, selfId, "Không ðü ô tr¯ng trong túi Nguyên Li®u." )
		return
	end
	
	if CostMoney(sceneId,selfId,ItemPrice) == -1 then
		x888902_NotifyFailTips( sceneId, selfId, "Không ðü ngân lßþng!")
		return
	end
	
	for i = 1, ItemNum do
		local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
	end
	
	x888902_NotifyFailTips( sceneId, selfId, "Các hÕ ðã mua "..ItemNum.." cái "..GetItemName(sceneId,ItemID)..".")
	
	local Date = GetTodayDate()
	local Month = GetTodayMonth() + 1;
	local Year = GetTodayYear()
	
	local WriteLog = openfile("../Public/Data/Script/event/prize/NewShop_"..Date.."-"..Month.."-"..Year..".txt", "a+")
	if nil ~= WriteLog then
		local CharID = GetHumanGUID(sceneId,selfId)
		local Hour = GetHour()
		local Minute = GetMinute()
		
		if Hour <= 9 then
			Hour = "0"..Hour
		end
		
		if Minute <= 9 then
			Minute = "0"..Minute
		end
		
		ShopID = ShopID + 300;
		
		if ItemNum <= 9 then
			ItemNum = "0"..ItemNum
		end
		
		write(WriteLog,"Time: "..Hour..":"..Minute.." | Char: "..CharID.." | ShopID: "..ShopID.." | ItemID: "..ItemID.." | ItemNum: "..ItemNum.." | ItemPrice: "..ItemPrice)
		write(WriteLog,tostring("\n"))
		closefile(WriteLog)
	end
end

function x888902_YuanbaoShopCheckOp(sceneId,selfId)
	--µØ¸®
	if sceneId == 77 then 
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:Dß½ng thª khä døng.", 0);
		return 0
	end
	--×é¶Ó¸úËæ
	local selfHasTeamFlag = LuaFnHasTeam(sceneId, selfId);
	if selfHasTeamFlag and selfHasTeamFlag == 1 then
		local teamFollowFlag = IsTeamFollow(sceneId,selfId);
		local teamLeaderFlag = LuaFnIsTeamLeader(sceneId,selfId);
		if not teamLeaderFlag or not teamFollowFlag then
			return 0
		end
		if teamFollowFlag ~= 0 and teamLeaderFlag ~= 1 then
			return 0
		end
	end
	--Ë«ÈËÆï³Ë
	local selfHasDRideFlag = LuaFnGetDRideFlag(sceneId, selfId);
	if selfHasDRideFlag and selfHasDRideFlag == 1 then
		local selfIsDRideMountOwner = LuaFnIsDRideMountOwner(sceneId, selfId);
		if not selfIsDRideMountOwner or selfIsDRideMountOwner ~= 1 then
			--´¦ÓÚË«ÈËÆï³Ë×´Ì¬£¬ÇÒÊÇ±»¶¯µÄ£¬½»¸øÖ÷¶¯·½À´´¦Àí
			return 0
		end
	end
	--15¼¶ÒÔÉÏ
	local level = GetLevel(sceneId,selfId);
	if nil == level or level < 15 then
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:C¤p ðµ 15 m¾i có th¬ sØ døng.", 0);
		return 0
	else

		return 1
	end
	return 0
end

function x888902_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

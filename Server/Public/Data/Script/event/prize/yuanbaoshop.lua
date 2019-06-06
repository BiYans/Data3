--�µ�Ԫ���̵�

x888902_g_scriptId = 888902
--Ԫ���̵��б� Ҫ��ͻ��˽����Ӧ
x888902_g_shoplist = {}
x888902_g_shoplist[1]	= {301, 301, 301}				--������
x888902_g_shoplist[2]	= {149, 150, 178, 193}			--��ʯ�̳�,���"����ʯի--149",czf,2009.07.21
x888902_g_shoplist[3]	= {194, 135, 152, 195}			--�����̳�
x888902_g_shoplist[4]	= {136, 137, 144}				--�ϱ��ӻ�
x888902_g_shoplist[5]	= {120, 181, 145, 182, 134}			--����㳡
x888902_g_shoplist[6]	= {190, 191, 192, 133}				--�����˼�
x888902_g_shoplist[7]	= {146}						--�书�ؼ�
x888902_g_shoplist[8]	= {156, 157, 158, 159, 160, 161, 162, 163}	--����ͼ

--**********************************
-- ��������NPC�Ĺ���
-- op��������𣬱���1����Ԫ����ص������������
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
			x888902_NotifyFailTips( sceneId, selfId, "Kh�ng �� � tr�ng trong t�i ��o C�." )
			return
		end
		
		if YuanBao(sceneId,selfId,-1,3,0) < ItemPrice then
			x888902_NotifyFailTips(sceneId,selfId,"Kh�ng �� Nguy�n B�o.")
			return
		end
		
		YuanBao(sceneId,selfId,-1,2,ItemPrice)
		for i = 1, ItemNum do
			local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
		end
		
		x888902_NotifyFailTips( sceneId, selfId, "C�c h� �� mua "..ItemNum.." c�i "..GetItemName(sceneId,ItemID)..".")
		return
	end
		
	if SlotID*3 > getn(NewShop[ShopID]) then
		return
	end
	
	local ItemID = NewShop[ShopID][SlotID*3-2]
	local ItemNum = NewShop[ShopID][SlotID*3-1]
	local ItemPrice = 2500*NewShop[ShopID][SlotID*3]
	
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x888902_NotifyFailTips( sceneId, selfId, "Kh�ng �� � tr�ng trong t�i ��o C�." )
		return
	end
	
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		x888902_NotifyFailTips( sceneId, selfId, "Kh�ng �� � tr�ng trong t�i Nguy�n Li�u." )
		return
	end
	
	if CostMoney(sceneId,selfId,ItemPrice) == -1 then
		x888902_NotifyFailTips( sceneId, selfId, "Kh�ng �� ng�n l��ng!")
		return
	end
	
	for i = 1, ItemNum do
		local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
	end
	
	x888902_NotifyFailTips( sceneId, selfId, "C�c h� �� mua "..ItemNum.." c�i "..GetItemName(sceneId,ItemID)..".")
	
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
	--�ظ�
	if sceneId == 77 then 
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:D߽ng th� kh� d�ng.", 0);
		return 0
	end
	--��Ӹ���
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
	--˫�����
	local selfHasDRideFlag = LuaFnGetDRideFlag(sceneId, selfId);
	if selfHasDRideFlag and selfHasDRideFlag == 1 then
		local selfIsDRideMountOwner = LuaFnIsDRideMountOwner(sceneId, selfId);
		if not selfIsDRideMountOwner or selfIsDRideMountOwner ~= 1 then
			--����˫�����״̬�����Ǳ����ģ�����������������
			return 0
		end
	end
	--15������
	local level = GetLevel(sceneId,selfId);
	if nil == level or level < 15 then
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:C�p � 15 m�i c� th� s� d�ng.", 0);
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

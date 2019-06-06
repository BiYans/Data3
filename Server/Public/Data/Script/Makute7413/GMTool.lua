x741306_g_scriptId = 741306

function x741306_GMTool(sceneId,selfId,type,param1,param2,param3)
	local GMList = {1010000013}
	local CharID = GetHumanGUID(sceneId, selfId)
	local Checker = 0
	for i = 1, getn(GMList) do
		if CharID == GMList[i] then
			Checker = 1
			break
		end
	end
	
	if Checker == 0 then
		x741306_NotifyFailTips(sceneId,selfId,"ChÑc nång dành riêng cho GM!")
		return
	end

	if type == 0 then
		local targetId = LuaFnGuid2ObjId(sceneId, param1)
		
		local CharName = LuaFnGetName(sceneId,targetId)
		local CharLevel = LuaFnGetLevel(sceneId,targetId)
		local GuildID = GetHumanGuildID(sceneId,targetId)
		local GuildName = "Chßa có"
		local LeagueName = "Chßa có"
		if GuildID ~= -1 then
			GuildName = LuaFnGetGuildName(sceneId, targetId)
			local LeagueID = LuaFnGetHumanGuildLeagueID(sceneId, targetId)
			if LeagueID ~= -1 then
				LeagueName = LuaFnGetHumanGuildLeagueName(sceneId, targetId)
			end
		end
		
		local MenpaiID = LuaFnGetMenPai(sceneId,targetId)
		local CharMoney = GetMoney(sceneId,targetId)
		local BindMoney = GetMoneyJZ(sceneId,targetId)
		local CharKNB = YuanBao(sceneId,targetId,-1,3,0)
		local CharDT = ZengDian(sceneId,targetId,-1,3,0)
		
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
		
			UICommand_AddInt(sceneId,CharLevel)
			UICommand_AddInt(sceneId,MenpaiID)
			UICommand_AddInt(sceneId,CharMoney)
			UICommand_AddInt(sceneId,BindMoney)
			UICommand_AddInt(sceneId,CharKNB)
			UICommand_AddInt(sceneId,CharDT)
			
			UICommand_AddString(sceneId,"Makute7413")
			UICommand_AddString(sceneId,CharName)
			UICommand_AddString(sceneId,GuildName)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,7413)
	end
	
	if type == 1 then
		EraseItem(sceneId,selfId,param1)
		x741306_NotifyFailTips(sceneId,selfId,"Thao tác thành công!")
	end
	
	if type == 2 then
		SetPos(sceneId,selfId,param1,param2)
	end
	
	if type == 3 then
		x741306_NotifyFailTips(sceneId,selfId,"Thao tác thành công!")
		if param1 == sceneId then
			SetPos(sceneId,selfId,param2,param3)
		else
			NewWorld(sceneId,selfId,param1,param2,param3)
		end
	end
	
	if type == 4 then
		local ret = LuaFnIsJudgeApt( sceneId, selfId, param1 )
		if ret == -1 then
			x741306_NotifyFailTips(sceneId,selfId,"Không th¬ sØ døng v§t ph¦m này")
			return
		end
		
		if ret == 1 then
			--x741306_NotifyFailTips(sceneId,selfId,"V§t ph¦m này ðã giám ð¸nh ch¤t lßþng")
			--return
			local ret2 = LuaFnReSetItemApt( sceneId, selfId, param1 )
			
			if ret2 == 1 then
				x741306_NotifyFailTips(sceneId,selfId,"Giá ð¸nh lÕi tß ch¤t trang b¸ thành công")
				return
			elseif ret2 == 2 or ret2 == 3 then
				x741306_NotifyFailTips(sceneId,selfId,"Giá ð¸nh lÕi tß ch¤t trang b¸ thành công")
				return
			else
				x741306_NotifyFailTips(sceneId,selfId,"Không biªt l²i")
				return
			end
		end
		
		if ret == 2 then
			x741306_NotifyFailTips(sceneId,selfId,"V§t ph¦m này chßa giám ð¸nh, không th¬ tiªn hành giám ð¸nh ch¤t lßþng")
			return
		end
		
		if ret == 3 then
			x741306_NotifyFailTips(sceneId,selfId,"V§t ph¦m này không có tß ch¤t, không th¬ tiªn hành giám ð¸nh ch¤t lßþng")
			return
		end
		
		local ret = LuaFnJudgeApt( sceneId, selfId, param1 )
		
		if ret == 1 then
			x741306_NotifyFailTips(sceneId,selfId,"Giám ð¸nh tß ch¤t trang b¸ thành công")
			return
		else
			x741306_NotifyFailTips(sceneId,selfId,"Không biªt l²i")
			return
		end
	end
	
	if type == 5 then
		local ret, arg0 = LuaFnEquipEnhance( sceneId, selfId, param1, param1 )
		local text = "Cß¶ng hóa trang b¸ thành công";
		
		if ret == 0 then
			
		end
		
		if ret == -1 then
			text="ÐÆng c¤p Cß¶ng hóa cüa trang b¸ này ðã l¾n nh¤t"
		end
		
		if ret == -2 then
			text="Trang b¸ hi®n ðang b¸ khoá ho£c không th¬ cß¶ng hoá"
		end
	
		if ret == -3 then
			text="Cß¶ng hóa tinh hoa không th¬ dùng."
		end
	
		if ret == -4 then
			text="ÐÆng c¤p Cß¶ng hóa cüa trang b¸ này ðã l¾n nh¤t"
		end

		if ret == -5 then
			text="Cß¶ng hóa trang b¸ c¥n #{_EXCHG%d}, ngân lßþng trên ngß¶i các hÕ không ðü."
			text=format( text, arg0 )
		end

		if ret == -6 then
			text="Ðáng tiªc, cß¶ng hóa th¤t bÕi"
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 6 then
		local ret = LuaFnLockCheck( sceneId, selfId, param1, 0 )
		local text = "";
		if ret == 0 then
			text= "Kh¡c danh trang b¸ thành công!"
			LuaFnEquipLock( sceneId, selfId, param1 )
		end
		
		if ret == -1 then
			text="Thao tác b¸ l²i"
		end
		
		if ret == -2 then
			text="Trang b¸ này không th¬ kh¡c danh"
		end
		
		if ret == -3 then
			--text="Trang b¸ này ðã ðßþc kh¡c danh"
			local ret2 = LuaFnIsItemLocked( sceneId, selfId, param1 )
			if ret2 ~= 0 then
				text = "Trang b¸ này chßa t×ng kh¡c danh, không c¥n tr× bö kh¡c danh"
				x741306_NotifyFailTips(sceneId,selfId,text)
				return
			end
			
			local ret2 = LuaFnUnLockCheck( sceneId, selfId, param1, 0 )
			
			if ret2 == 0 then --³É¹¦ÁË
				LuaFnEquipUnLock( sceneId, selfId, param1 )
				text = "Tr× bö kh¡c danh thành công"
			end

			if ret2 == -1 then
				text="Thao tác b¸ l²i"
			end
			
			if ret2 == -2 then
				text="Trang b¸ này không th¬ sØ døng"
			end
			
			if ret2 == -3 then
				text="Trang b¸ này chßa t×ng kh¡c danh, không c¥n tr× bö kh¡c danh."
			end
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 7 then
		local ret = LuaFnFaileTimes( sceneId, selfId, param1, param1, 1 )
		local text = "SØa chæa thành công";
		
		if ret == -1 then
			text = "L²i không xác ð¸nh"
		end
		
		if ret == -2 then
			text = "Không dùng ðßþc trang b¸ này"
		end
		
		if ret == -3 then
			text = "Không th¬ sØ døng nhu§n v§t lµ"
		end

		if ret == -4 then
			text = "S¯ l¥n sØa chæa th¤t bÕi ðã th¤p nh¤t"
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 8 then		
		local ret = AddBagItemSlotFour( sceneId, selfId, param1 )
		if ret == -1 then
			x741306_NotifyFailTips( sceneId, selfId, "Ðøc l² trang b¸ th¤t bÕi" )
		elseif ret == -2 then
			x741306_NotifyFailTips( sceneId, selfId, "Sai l¥m nghiêm tr÷ng" )
		elseif ret == -3 then
			x741306_NotifyFailTips( sceneId, selfId, "#{XQC_20080509_06}" )
		elseif ret == -4 then
			x741306_NotifyFailTips( sceneId, selfId, "#{XQC_20080509_04}" ) 
		elseif ret == 1 then
			x741306_NotifyFailTips( sceneId, selfId, "Ðøc l² thành công." ) 
		end
	end
	
	if type == 9 then
		local GemNum = GetGemEmbededCount(sceneId,selfId,param1)
		if GemNum == 4 then
			x741306_NotifyFailTips(sceneId,selfId,"Trang b¸ ðã khäm 4 bäo thÕch, không th¬ khäm thêm.")
			return
		end
		
		local SlotNum = GetBagGemCount(sceneId, selfId, param1)
		if GemNum >= SlotNum then
			x741306_NotifyFailTips(sceneId,selfId,"C¥n ðøc thêm l² ð¬ tß½ng khäm bäo thÕch!")
			return
		end
		
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			x741306_NotifyFailTips(sceneId,selfId,"C¥n 1 ô tr¯ng trong túi Nguyên Li®u.")
			return
		end
		
		local NewGem = TryRecieveItem(sceneId,selfId,param2+50000000,1)
		if NewGem == -1 then
			x741306_NotifyFailTips(sceneId,selfId,"Sai sót GemID, vui lòng liên h® Makute7413")
			return
		end

		GemEnchasing(sceneId,selfId,NewGem,param1)
		x741306_NotifyFailTips(sceneId,selfId,"Thao tác thành công!")
	end
	
	if type == 10 then
		x741306_NotifyFailTips(sceneId,selfId,type)
	end
end

function x741306_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
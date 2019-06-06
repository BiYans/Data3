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
		x741306_NotifyFailTips(sceneId,selfId,"Ch�c n�ng d�nh ri�ng cho GM!")
		return
	end

	if type == 0 then
		local targetId = LuaFnGuid2ObjId(sceneId, param1)
		
		local CharName = LuaFnGetName(sceneId,targetId)
		local CharLevel = LuaFnGetLevel(sceneId,targetId)
		local GuildID = GetHumanGuildID(sceneId,targetId)
		local GuildName = "Ch�a c�"
		local LeagueName = "Ch�a c�"
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
		x741306_NotifyFailTips(sceneId,selfId,"Thao t�c th�nh c�ng!")
	end
	
	if type == 2 then
		SetPos(sceneId,selfId,param1,param2)
	end
	
	if type == 3 then
		x741306_NotifyFailTips(sceneId,selfId,"Thao t�c th�nh c�ng!")
		if param1 == sceneId then
			SetPos(sceneId,selfId,param2,param3)
		else
			NewWorld(sceneId,selfId,param1,param2,param3)
		end
	end
	
	if type == 4 then
		local ret = LuaFnIsJudgeApt( sceneId, selfId, param1 )
		if ret == -1 then
			x741306_NotifyFailTips(sceneId,selfId,"Kh�ng th� s� d�ng v�t ph�m n�y")
			return
		end
		
		if ret == 1 then
			--x741306_NotifyFailTips(sceneId,selfId,"V�t ph�m n�y �� gi�m �nh ch�t l��ng")
			--return
			local ret2 = LuaFnReSetItemApt( sceneId, selfId, param1 )
			
			if ret2 == 1 then
				x741306_NotifyFailTips(sceneId,selfId,"Gi� �nh l�i t� ch�t trang b� th�nh c�ng")
				return
			elseif ret2 == 2 or ret2 == 3 then
				x741306_NotifyFailTips(sceneId,selfId,"Gi� �nh l�i t� ch�t trang b� th�nh c�ng")
				return
			else
				x741306_NotifyFailTips(sceneId,selfId,"Kh�ng bi�t l�i")
				return
			end
		end
		
		if ret == 2 then
			x741306_NotifyFailTips(sceneId,selfId,"V�t ph�m n�y ch�a gi�m �nh, kh�ng th� ti�n h�nh gi�m �nh ch�t l��ng")
			return
		end
		
		if ret == 3 then
			x741306_NotifyFailTips(sceneId,selfId,"V�t ph�m n�y kh�ng c� t� ch�t, kh�ng th� ti�n h�nh gi�m �nh ch�t l��ng")
			return
		end
		
		local ret = LuaFnJudgeApt( sceneId, selfId, param1 )
		
		if ret == 1 then
			x741306_NotifyFailTips(sceneId,selfId,"Gi�m �nh t� ch�t trang b� th�nh c�ng")
			return
		else
			x741306_NotifyFailTips(sceneId,selfId,"Kh�ng bi�t l�i")
			return
		end
	end
	
	if type == 5 then
		local ret, arg0 = LuaFnEquipEnhance( sceneId, selfId, param1, param1 )
		local text = "C߶ng h�a trang b� th�nh c�ng";
		
		if ret == 0 then
			
		end
		
		if ret == -1 then
			text="��ng c�p C߶ng h�a c�a trang b� n�y �� l�n nh�t"
		end
		
		if ret == -2 then
			text="Trang b� hi�n �ang b� kho� ho�c kh�ng th� c߶ng ho�"
		end
	
		if ret == -3 then
			text="C߶ng h�a tinh hoa kh�ng th� d�ng."
		end
	
		if ret == -4 then
			text="��ng c�p C߶ng h�a c�a trang b� n�y �� l�n nh�t"
		end

		if ret == -5 then
			text="C߶ng h�a trang b� c�n #{_EXCHG%d}, ng�n l��ng tr�n ng߶i c�c h� kh�ng ��."
			text=format( text, arg0 )
		end

		if ret == -6 then
			text="��ng ti�c, c߶ng h�a th�t b�i"
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 6 then
		local ret = LuaFnLockCheck( sceneId, selfId, param1, 0 )
		local text = "";
		if ret == 0 then
			text= "Kh�c danh trang b� th�nh c�ng!"
			LuaFnEquipLock( sceneId, selfId, param1 )
		end
		
		if ret == -1 then
			text="Thao t�c b� l�i"
		end
		
		if ret == -2 then
			text="Trang b� n�y kh�ng th� kh�c danh"
		end
		
		if ret == -3 then
			--text="Trang b� n�y �� ���c kh�c danh"
			local ret2 = LuaFnIsItemLocked( sceneId, selfId, param1 )
			if ret2 ~= 0 then
				text = "Trang b� n�y ch�a t�ng kh�c danh, kh�ng c�n tr� b� kh�c danh"
				x741306_NotifyFailTips(sceneId,selfId,text)
				return
			end
			
			local ret2 = LuaFnUnLockCheck( sceneId, selfId, param1, 0 )
			
			if ret2 == 0 then --�ɹ���
				LuaFnEquipUnLock( sceneId, selfId, param1 )
				text = "Tr� b� kh�c danh th�nh c�ng"
			end

			if ret2 == -1 then
				text="Thao t�c b� l�i"
			end
			
			if ret2 == -2 then
				text="Trang b� n�y kh�ng th� s� d�ng"
			end
			
			if ret2 == -3 then
				text="Trang b� n�y ch�a t�ng kh�c danh, kh�ng c�n tr� b� kh�c danh."
			end
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 7 then
		local ret = LuaFnFaileTimes( sceneId, selfId, param1, param1, 1 )
		local text = "S�a ch�a th�nh c�ng";
		
		if ret == -1 then
			text = "L�i kh�ng x�c �nh"
		end
		
		if ret == -2 then
			text = "Kh�ng d�ng ���c trang b� n�y"
		end
		
		if ret == -3 then
			text = "Kh�ng th� s� d�ng nhu�n v�t l�"
		end

		if ret == -4 then
			text = "S� l�n s�a ch�a th�t b�i �� th�p nh�t"
		end
		
		x741306_NotifyFailTips(sceneId,selfId,text)
	end
	
	if type == 8 then		
		local ret = AddBagItemSlotFour( sceneId, selfId, param1 )
		if ret == -1 then
			x741306_NotifyFailTips( sceneId, selfId, "��c l� trang b� th�t b�i" )
		elseif ret == -2 then
			x741306_NotifyFailTips( sceneId, selfId, "Sai l�m nghi�m tr�ng" )
		elseif ret == -3 then
			x741306_NotifyFailTips( sceneId, selfId, "#{XQC_20080509_06}" )
		elseif ret == -4 then
			x741306_NotifyFailTips( sceneId, selfId, "#{XQC_20080509_04}" ) 
		elseif ret == 1 then
			x741306_NotifyFailTips( sceneId, selfId, "��c l� th�nh c�ng." ) 
		end
	end
	
	if type == 9 then
		local GemNum = GetGemEmbededCount(sceneId,selfId,param1)
		if GemNum == 4 then
			x741306_NotifyFailTips(sceneId,selfId,"Trang b� �� kh�m 4 b�o th�ch, kh�ng th� kh�m th�m.")
			return
		end
		
		local SlotNum = GetBagGemCount(sceneId, selfId, param1)
		if GemNum >= SlotNum then
			x741306_NotifyFailTips(sceneId,selfId,"C�n ��c th�m l� � t߽ng kh�m b�o th�ch!")
			return
		end
		
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			x741306_NotifyFailTips(sceneId,selfId,"C�n 1 � tr�ng trong t�i Nguy�n Li�u.")
			return
		end
		
		local NewGem = TryRecieveItem(sceneId,selfId,param2+50000000,1)
		if NewGem == -1 then
			x741306_NotifyFailTips(sceneId,selfId,"Sai s�t GemID, vui l�ng li�n h� Makute7413")
			return
		end

		GemEnchasing(sceneId,selfId,NewGem,param1)
		x741306_NotifyFailTips(sceneId,selfId,"Thao t�c th�nh c�ng!")
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
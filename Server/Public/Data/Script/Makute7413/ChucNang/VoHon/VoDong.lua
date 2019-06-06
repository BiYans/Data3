
x880203_g_scriptId = 880203

--**********************************
--
--**********************************
function x880203_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Võ Ð°ng")
		AddNumText( sceneId, x880203_g_scriptId, "Xoá Thuµc Tính M· Rµng", 6, 1 )
		AddNumText( sceneId, x880203_g_scriptId, "Hþp Thành Nhu§n H°n ThÕch", 6, 2 )
		AddNumText( sceneId, x880203_g_scriptId, "Hþp Thành H°n Bång Châu", 6, 3 )
		AddNumText( sceneId, x880203_g_scriptId, "Thay Ð±i C¥m Tinh", 6, 4 )
		AddNumText( sceneId, x880203_g_scriptId, "T¦y TÖ L® Trß·ng Thành", 6, 5 )
		AddNumText( sceneId, x880203_g_scriptId, "T¦y KÛ Nång Lînh Ngµ Võ H°n", 6, 6 )
		AddNumText( sceneId, x880203_g_scriptId, "R¶i ði", 8, 0 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--
--**********************************
function x880203_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	--GM--
	if key == 7 then
		local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,0)
		if ItemID < 10308001 or ItemID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"Not Wuhun Here")
		else
			CallScriptFunction(741302,"SetWuhunAuthor",sceneId,selfId,0,5,"040")
			x741302_NotifyFailTips(sceneId,selfId,"Wuhun Level Up To 40")
		end
	end
	
	if key == 8 then
		local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,0)
		if ItemID < 10308001 or ItemID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"Not Wuhun Here")
		else
			CallScriptFunction(741302,"SetWuhunAuthor",sceneId,selfId,0,5,"070")
			x741302_NotifyFailTips(sceneId,selfId,"Wuhun Level Up To 70")
		end
	end
	
	if key == 9 then
		local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,0)
		if ItemID < 10308001 or ItemID > 10308004 then
			x741302_NotifyFailTips(sceneId,selfId,"Not Wuhun Here")
		else
			CallScriptFunction(741302,"SetWuhunAuthor",sceneId,selfId,0,5,"090")
			x741302_NotifyFailTips(sceneId,selfId,"Wuhun Level Up To 90")
		end
	end
	
	if key == 10 then
		local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,0)
		if ItemID == 0 then
			x741302_NotifyFailTips(sceneId,selfId,"Not Item Here")
		else
			LuaFnItemBind(sceneId,selfId,0)
			x741302_NotifyFailTips(sceneId,selfId,"Item is BINDED")
		end
	end
	
	if key == 11 then
		local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,30)
		if ItemID == 0 then
			x741302_NotifyFailTips(sceneId,selfId,"Not Item Here")
		else
			LuaFnItemBind(sceneId,selfId,30)
			x741302_NotifyFailTips(sceneId,selfId,"Item is BINDED")
		end
	end
	--GM--
	
	if key == 0 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
	
	if key == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090727 )
	end
	
	if key == 2 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090824 )
	end
	
	if key == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"H°n Bång Châu")
			AddNumText( sceneId, x880203_g_scriptId, "Hþp thành H°n Bång Châu (C¤p 2)", 6, 31 )
			AddNumText( sceneId, x880203_g_scriptId, "Hþp thành H°n Bång Châu (C¤p 3)", 6, 32 )
			AddNumText( sceneId, x880203_g_scriptId, "Hþp thành H°n Bång Châu (C¤p 4)", 6, 33 )
			AddNumText( sceneId, x880203_g_scriptId, "Hþp thành H°n Bång Châu (C¤p 5)", 6, 34 )
			AddNumText( sceneId, x880203_g_scriptId, "R¶i ði", 8, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key >= 31 and key <= 34 then
		local HBC = {}
			HBC[1] = {20310117,20310161}
			HBC[2] = {20310118,20310162}
			HBC[3] = {20310119,20310163}
			HBC[4] = {20310120,20310164}
			HBC[5] = {20310121,20310165}
		
		local Select = key - 30;
		local HBC1 = LuaFnGetAvailableItemCount(sceneId,selfId,HBC[Select][1])
		local HBC2 = LuaFnGetAvailableItemCount(sceneId,selfId,HBC[Select][2])
		
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 2 then
			x880203_ShowMsg( sceneId, selfId, "Hãy s¡p xªp lÕi 2 ô tr¯ng trong túi Nguyên Li®u")
			return
		end
		
		if HBC1 >= 5 then
			LuaFnDelAvailableItem(sceneId,selfId,HBC[Select][1],5)
			TryRecieveItem(sceneId,selfId,HBC[Select+1][1],1)
		end
		
		if HBC2 >= 5 then
			LuaFnDelAvailableItem(sceneId,selfId,HBC[Select][2],5)
			TryRecieveItem(sceneId,selfId,HBC[Select+1][2],1)
		end
		
		if HBC1 >= 5 or HBC2 >= 5 then
			BeginEvent(sceneId)
				AddText(sceneId,"Hþp thành H°n Bång Châu, vui lòng xem lÕi tay näi.")
				AddNumText( sceneId, x880203_g_scriptId, "R¶i ði", 8, 0 )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			BeginEvent(sceneId)
				AddText(sceneId,"Không th¬ hþp thành H°n Bång Châu.")
				AddNumText( sceneId, x880203_g_scriptId, "R¶i ði", 8, 0 )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end
	
	if key == 4 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 10 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090721 )
	end
	
	if key == 5 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 9 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090721 )
	end
	
	if key == 6 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 2 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090722 )
	end
end

--**********************************
--
--**********************************
function x880203_OnMissionSubmit(sceneId,selfId,targetId,x880203_g_scriptId,ItemID)

end

--**********************************
--
--**********************************
function x880203_ShowMsg( sceneId, selfId, strMsg)
	BeginEvent( sceneId )
		AddText( sceneId, strMsg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end

x880202_g_scriptId = 880202

--**********************************
--
--**********************************
function x880202_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"Vô Nhai TØ")
		AddNumText( sceneId, x880202_g_scriptId, "Tång Ðµ Hþp Thành", 6, 1 )
		AddNumText( sceneId, x880202_g_scriptId, "M· Rµng Khung Thuµc Tính", 6, 2 )
		AddNumText( sceneId, x880202_g_scriptId, "H÷c Thuµc Tính M· Rµng", 6, 3 )
		AddNumText( sceneId, x880202_g_scriptId, "Tång C¤p Thuµc Tính M· Rµng", 6, 4 )
		AddNumText( sceneId, x880202_g_scriptId, "KÛ Nång Lînh Ngµ Võ H°n", 6, 5 )
		--AddNumText( sceneId, x880202_g_scriptId, "T¦y KÛ Nång Lînh Ngµ Võ H°n", 6, 6 )
		AddNumText( sceneId, x880202_g_scriptId, "Thång C¤p KÛ Nång Lînh Ngµ Võ H°n", 6, 7 )
		AddNumText( sceneId, x880202_g_scriptId, "R¶i ði", 8, 0 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--
--**********************************
function x880202_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	
	if key == 0 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
	
	if key == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 2 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090721 )
	end
	
	if key == 2 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 4 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090721 )
	end
	
	if key == 3 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 1 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090721 )
	end
	
	if key == 4 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			--UICommand_AddInt( sceneId, 1 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090720 )
	end

	if key == 5 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 1 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090722 )
	end
	
	if key == 6 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 2 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090722 )
	end
	
	if key == 7 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			--UICommand_AddInt( sceneId, 2 )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090723 )
	end
end


--**********************************
--
--**********************************
function x880202_ShowMsg( sceneId, selfId, strMsg)
	BeginEvent( sceneId )
		AddText( sceneId, strMsg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
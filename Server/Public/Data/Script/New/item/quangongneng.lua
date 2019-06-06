x210531_g_ScriptId = 210531

function x210531_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "Luy®n h°n th¥n khí có th¬ giúp th¥n binh cüa các hÕ biªn ð±i khôn lß¶ng, chï s¯ tång cao, sÑc chiªn ð¤u vßþt b§t" )
		AddNumText( sceneId, x210531_g_ScriptId, "Luy®n H°n Th¥n Khí", 6, 1 )
		AddNumText( sceneId, x210531_g_ScriptId, "Luy®n H°n Th¥n Khí 102", 6, 3 )
		AddNumText( sceneId, x210531_g_ScriptId, "Tr÷ng T¦y Th¥n Khí 6 Sao", 6, 4 )
		AddNumText( sceneId, x210531_g_ScriptId, "Hþp Thành Th¥n Binh Phù", 6, 2 )
		AddNumText( sceneId, x210531_g_ScriptId, "Ta chï ði ngang qua ðây", 8, 9 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--ÊÂ¼þÁÐ±íÑ¡ÖÐÒ»Ïî
--**********************************
function x210531_OnEventRequest( sceneId, selfId, targetId, eventId)
	local key = GetNumText()
	
	if key == 4 then
		BeginEvent(sceneId)
			AddText( sceneId, "Nªu các hÕ không hài lòng v¾i thuµc tính cüa th¥n binh thì ta có th¬ giúp các hÕ t¦y lÕi thuµc tính." )
			AddText( sceneId, "#GTh¥n khí 86 tiêu hao 1 cái Th¥n Binh Phù C¤p 1." )
			AddText( sceneId, "#GTh¥n khí 96 tiêu hao 1 cái Th¥n Binh Phù C¤p 2." )
			AddText( sceneId, "#GTh¥n khí 102 tiêu hao 1 cái Th¥n Binh Phù C¤p 3." )
			AddNumText( sceneId, x210531_g_ScriptId, "Tiªn Hành Tr÷ng T¦y", 6, 41 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta chï ði ngang qua ðây", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 41 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,3)
			--UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 3 then
		BeginEvent(sceneId)
			AddText( sceneId, "Th¥n khí 102 sau khi luy®n h°n s¨ thång c¤p lên 6 sao và không thay ð±i c¤p ðµ." )
			AddText( sceneId, "#GC¥n tiêu hao 5 Th¥n Binh Phù C¤p 3." )
			AddNumText( sceneId, x210531_g_ScriptId, "Tiªn Hành Luy®n H°n", 6, 31 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta chï ði ngang qua ðây", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 31 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,2)
			--UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 2 then
		BeginEvent(sceneId)
			AddText( sceneId, "Ð¬ hþp thành Th¥n Binh Phù 2 c¥n 5 cái Th¥n Binh Phù 1." )
			AddText( sceneId, "Ð¬ hþp thành Th¥n Binh Phù 3 c¥n 5 cái Th¥n Binh Phù 2." )
			AddNumText( sceneId, x210531_g_ScriptId, "Hþp Thành Th¥n Binh Phù 2", 6, 20 )
			AddNumText( sceneId, x210531_g_ScriptId, "Hþp Thành Th¥n Binh Phù 3", 6, 21 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end	

	if key == 20 then
		local TBP1 = LuaFnGetAvailableItemCount(sceneId,selfId,30505816)
		if TBP1 < 5 then
			x210531_NotifyFailTips( sceneId, selfId, "Ngß½i vçn chßa có ðü 5 cái Th¥n Binh Phù 1" )
			return
		end
		
		local FreeDC = LuaFnGetPropertyBagSpace(sceneId,selfId)
		if FreeDC < 1 then
			x210531_NotifyFailTips( sceneId, selfId, "C¥n 1 ô tr¯ng trong ÐÕo Cø" )
			return
		end

		LuaFnDelAvailableItem(sceneId,selfId,30505816,5)
		local NewItemPos = TryRecieveItem(sceneId,selfId,30505817,1)
		x210531_NotifyFailTips( sceneId, selfId, "Chúc m×ng ngß½i ðã hþp thành Th¥n Binh Phù C¤p 2." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent(sceneId)
			AddText( sceneId, "Ðã hþp thành Th¥n Binh Phù C¤p 2, ngß½i có mu¯n tiªp tøc?" )
			AddNumText( sceneId, x210531_g_ScriptId, "Tiªp tøc", 6, 20 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if key == 21 then
		local TBP2 = LuaFnGetAvailableItemCount(sceneId,selfId,30505817)
		if TBP2 < 5 then
			x210531_NotifyFailTips( sceneId, selfId, "Ngß½i vçn chßa có ðü 5 cái Th¥n Binh Phù 2" )
			return
		end

		local FreeDC = LuaFnGetPropertyBagSpace(sceneId,selfId)
		if FreeDC < 1 then
			x210531_NotifyFailTips( sceneId, selfId, "C¥n 1 ô tr¯ng trong ÐÕo Cø" )
			return
		end

		LuaFnDelAvailableItem(sceneId,selfId,30505817,5)
		local NewItemPos = TryRecieveItem(sceneId,selfId,30505908,1)
		x210531_NotifyFailTips( sceneId, selfId, "Chúc m×ng ngß½i ðã hþp thành Th¥n Binh Phù C¤p 3." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent(sceneId)
			AddText( sceneId, "Ðã hþp thành Th¥n Binh Phù C¤p 3, ngß½i có mu¯n tiªp tøc?" )
			AddNumText( sceneId, x210531_g_ScriptId, "Tiªp tøc", 6, 21 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if key == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "Sau khi luy®n h°n, th¥n khí s¨ mang c¤p ðµ 86/96. Ngß½i hãy lña ch÷n th§t kÛ!" )
			AddNumText( sceneId, x210531_g_ScriptId, "Thiªu Lâm - D¸ch Thiên Phá Tà Trßþng", 6, 10 )
			AddNumText( sceneId, x210531_g_ScriptId, "Minh Giáo - Xích Di­m CØu Vån Ðao", 6, 11 )
			AddNumText( sceneId, x210531_g_ScriptId, "Cái Bang - Träm ¿u ÐoÕn S¥u Thß½ng", 6, 12 )
			AddNumText( sceneId, x210531_g_ScriptId, "Võ Ðang - VÕn Nh§n Long Uyên Kiªm", 6, 13 )
			AddNumText( sceneId, x210531_g_ScriptId, "Nga My - Hàm Quang Lµng Änh Kiªm", 6, 14 )
			AddNumText( sceneId, x210531_g_ScriptId, "Tinh Túc - Chuy¬n H°n Di®t Phách Câu", 6, 15 )
			AddNumText( sceneId, x210531_g_ScriptId, "Thiên Long - Thiên Tinh Di®u Dß½ng Hoàn", 6, 16 )
			AddNumText( sceneId, x210531_g_ScriptId, "Thiên S½n - Toái Tình Vø Änh Hoàn", 6, 17 )
			AddNumText( sceneId, x210531_g_ScriptId, "Tiêu Dao - Lôi Minh Ly Höa Phiªn", 6, 18 )
			AddNumText( sceneId, x210531_g_ScriptId, "Mµ Dung - Tinh Di Vô Ngân Kiªm", 6, 19 )
			AddNumText( sceneId, x210531_g_ScriptId, "Ta chï ði ngang qua ðây", 8, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if key == 10 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 11 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 12 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,2)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 13 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,3)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 14 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,4)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 15 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,5)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 16 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,6)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 17 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,7)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 18 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,8)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 19 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,9)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if key == 9 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
end
--**********************************
-- ¶Ô»°´°¿ÚÐÅÏ¢ÌáÊ¾
--**********************************
function x210531_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- ÆÁÄ»ÖÐ¼äÐÅÏ¢ÌáÊ¾
--**********************************
function x210531_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

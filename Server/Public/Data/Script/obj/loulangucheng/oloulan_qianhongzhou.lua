x001154_g_ScriptId = 001154
--**********************************
--ÊÂ¼þ½»»¥Èë¿Ú
--**********************************
function x001154_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#W— giæa hoang mÕc, th¤y ngß¶i ðó ðang chª luy®n mµt loÕi Ám khí th¥n kÏ#Y Bång Phách Th¥n Châm#W. Do tÕi hÕ kh¦n c¥u, næ hi®p ðó ðã truy«n thø cách thÑc chª luy®n cho tÕi hÕ." )
		AddNumText( sceneId, x001154_g_ScriptId, "#GÐúc thành Bång Phách Th¥n Châm", 6, 1 )
		AddNumText( sceneId, x001154_g_ScriptId, "R¶i khöi", 9, 9 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--ÊÂ¼þÁÐ±íÑ¡ÖÐmµt Ïî
--**********************************
function x001154_OnEventRequest( sceneId, selfId, targetId, eventId)
	
	if GetNumText() == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "Các hÕ có xác nh§n dùng 20 #GHàn Bång Tinh ThÕch #Wð¬ ðúc thành #GB¢ng Phách Th¥n Châm#W?" )
			AddText( sceneId, "Các hÕ có th¬ t¦y lÕi ðÆng c¤p cüa #GBång Phách Th¥n Châm #Wð¬ ðÕt ðßþc chï s¯ t¯i ßu nh¤t." )
			AddNumText( sceneId, x001154_g_ScriptId, "#GTa ð°ng ý", 6, 11 )
			AddNumText( sceneId, x001154_g_ScriptId, "HuÖ", 9, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if GetNumText() == 11 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if GetNumText() == 9 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
end
--**********************************
-- ¶Ô»°´°¿ÚÐÅÏ¢ÌáÊ¾
--**********************************
function x001154_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- ÆÁÄ»ÖÐ¼äÐÅÏ¢ÌáÊ¾
--**********************************
function x001154_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

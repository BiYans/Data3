--ÓñÏªNPC
--ÂÜ²·
--ÆÕÍ¨

--**********************************
--ÊÂ¼þ½»»¥Èë¿Ú
--**********************************
function x027003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Xin chào. #rTa là La B¯c. #rCha ta là T¯ Mçu La, #rM© ta là C± L² LÕp. #rMuµi ta là Y Na. #r...")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

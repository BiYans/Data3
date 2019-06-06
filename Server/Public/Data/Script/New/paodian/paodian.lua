--ÔÚÏßÅÝµã


--½Å±¾ºÅ
x898989_g_scriptId = 898989

--**********************************
-- OnTime
--**********************************
function x898989_OnSceneTimer(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		x898989_DoHanYuLogic( sceneId, nHumanId )
	end
end

--**********************************
-- ¹Ò»ú¼Ó¾­ÑéÂß¼­
--**********************************
function x898989_DoHanYuLogic( sceneId, selfId )

	local CurLevel = LuaFnGetLevel( sceneId, selfId )
	if CurLevel >= 90 then
		CallScriptFunction((400900),"TransferFunc",sceneId,selfId,151,45,35)
		BeginEvent(sceneId)
			AddText(sceneId,"#r       #YCänh cáo hành vi can thi®p nµi dung trò ch½i!#r")
			AddText(sceneId,"Các hÕ ðã có c¤p ðµ l¾n h½n 90, ð« ngh¸ không tham gia Phó Cänh cüa tân thü.")
		EndEvent(senceId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
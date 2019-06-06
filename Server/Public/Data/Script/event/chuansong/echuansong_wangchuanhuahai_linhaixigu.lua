
x400987_g_ScriptId = 400987


x400987_left 	=215.0000
x400987_right	=219.0000

x400987_top  	=38.0000
x400987_bottom	=42.0000

--Íæ¼Ò½øÈëmµt cái area Ê±´¥·¢
function x400987_OnEnterArea( sceneId, selfId )

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400987_g_ScriptId);
		UICommand_AddString(sceneId, "GotoLHKC");
		UICommand_AddString(sceneId, "#cfff263Lâm Häi Khê C¯c cho phép tuyên chiªn, #Gkhông sát khí#cfff263, có th¬ xäy ra #GPK#cfff263. Chú ý bäo tr÷ng.#r    #cfff263 Trong khu vñc này #Gchü ðµng t¤n công#cfff263 ngß¶i ch½i khác#G không b¸ tr×ng phÕt#cfff263.#r    #cfff263Có mu¯n vào không?");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)

	-- CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 432,90,86)
end

--Íæ¼ÒTÕi mµt cái area ´ôÁËmµt ¶ÎÊ±¼äÃ»×ßÔò¶¨Ê±´¥·¢
function x400987_OnTimer( sceneId, selfId )
	-- ºÁ giây,¿´TÕi Cái này  area Í£Áô¶à¾ÃÁË
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5 giâyºóÈÔÎ´´«ËÍ
	if StandingTime >= 5000 then
		x400987_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--Íæ¼ÒÀë¿ªmµt cái area Ê±´¥·¢
function x400987_OnLeaveArea( sceneId, selfId )
end

--**********************************
--ÈÎÎñÈë¿Úº¯Êý
--**********************************
function x400987_GotoLHKC( sceneId, selfId, targetId )	-- ði¬m»÷¸ÃÈÎÎñºóÖ´ÐÐ´Ë½Å±¾
	
	-- ¼ì²éÍæ¼ÒÐúng²»Ðúng»¹TÕi Cái này ·¶Î§ÄÚ
	if sceneId ~= 467 then
		--Ngß½i ðã không · khu vñc v§n chuy¬n.
		BeginEvent(sceneId)
			AddText(sceneId,"Ngß½i ðã không · khu vñc v§n chuy¬n.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400987_left or
			targetX > x400987_right or
			targetZ < x400987_top  or
			targetZ > x400987_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"Ngß½i ðã không · khu vñc v§n chuy¬n.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 465,42,225)
end

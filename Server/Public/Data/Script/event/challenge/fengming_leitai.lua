-- ÀŞÌ¨toÕ ğµ ÊÂ¼şÇøÓò½Å±¾

x806021_g_ScriptId = 806021
x806021_g_ChallengeScriptId = 806022

-- Íæ¼Ò½øÈëÀŞÌ¨Ê±ÉèÖÃ
function x806021_OnEnterArea( sceneId, selfId )
	SetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT, x806021_g_ChallengeScriptId )
	ResetChallengeData( sceneId, selfId )
end

-- Íæ¼ÒÍ£ÁôTÕi ÀŞÌ¨¶¨Ê±´¥·¢
function x806021_OnTimer( sceneId, selfId )
	return
end

-- Íæ¼ÒÀë¿ªÀŞÌ¨Ê±´¥·¢
function x806021_OnLeaveArea( sceneId, selfId )
	SetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT, 0 )
	ResetChallengeData( sceneId, selfId )
end

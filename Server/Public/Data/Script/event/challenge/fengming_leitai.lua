-- ��̨to� � �¼�����ű�

x806021_g_ScriptId = 806021
x806021_g_ChallengeScriptId = 806022

-- ��ҽ�����̨ʱ����
function x806021_OnEnterArea( sceneId, selfId )
	SetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT, x806021_g_ChallengeScriptId )
	ResetChallengeData( sceneId, selfId )
end

-- ���ͣ��T�i ��̨��ʱ����
function x806021_OnTimer( sceneId, selfId )
	return
end

-- ����뿪��̨ʱ����
function x806021_OnLeaveArea( sceneId, selfId )
	SetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT, 0 )
	ResetChallengeData( sceneId, selfId )
end

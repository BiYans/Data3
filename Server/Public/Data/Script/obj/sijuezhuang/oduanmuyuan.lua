--��翷帱��....
--��ľԪ�Ի��ű�....

--kich ban goc hao
x893074_g_ScriptId	= 893074

--�����߼�kich ban goc hao....
x893074_g_FuBenScriptId = 893063

--**********************************
--����....
--**********************************
function x893074_OnDie( sceneId, selfId, killerId )

	--�����û��Khi�u chi�n ������ˮ�����Khi�u chi�n ����ˮ....
	if 2 ~= CallScriptFunction( x893074_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" )	then
		CallScriptFunction( x893074_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "PangQi", 1 )
	end
	-- zchw ȫ�򹫸�
	local	playerName	= GetName( sceneId, killerId )
	
	--ɱ��������ǳ�����.�����˵�����....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	--�������������.�ӳ�������....
	local leaderID = GetTeamLeader( sceneId, playerID )
	if leaderID ~= -1 then
		playerName = GetName( sceneId, leaderID )
	end
	
	if playerName ~= nil then
		str = format("#{SJZ_8812_04}#{_INFOUSR%s}#{SJZ_8812_05}", playerName); --��ƽ��
		AddGlobalCountNews( sceneId, str )
	end
end

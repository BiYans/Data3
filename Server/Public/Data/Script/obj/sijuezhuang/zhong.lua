--��翷帱��....
--�����ǶԻ��ű�....

--kich ban goc hao
x893081_g_ScriptId = 893081

--�����߼�kich ban goc hao....
x893081_g_FuBenScriptId = 893063

--����buff��....
x893081_g_BUFF = { 10264, 10265, 10266 }



--**********************************
--������ں���....
--**********************************
function x893081_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "T� tuy�t trong �i�n c� r�t nhi�u h� v�, nh�ng ch� mu�n nghe �n trong �i�n t� tuy�t ti�ng chu�ng. s� r�i �i" )

		--�жϵ�ǰ�Ƿ����Khi�u chi�n ˫��....	
		--if 1 == CallScriptFunction( x893081_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "ShuangZi" ) then
			AddNumText( sceneId, x893081_g_ScriptId, "G� chu�ng", 10, 1 )
		--end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893081_OnEventRequest( sceneId, selfId, targetId, eventId )

	--�ǲ��Ƕӳ�....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		BeginEvent(sceneId)
			AddText( sceneId, "#{PMF_20080521_07}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--�жϵ�ǰ�Ƿ����Khi�u chi�n ˫��....	
	--if 1 ~= CallScriptFunction( x893081_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "ShuangZi" ) then
		--return
	--end

	--������ںͱ��BOSSChi�n �u �򷵻�....
	local ret, msg = CallScriptFunction( x893081_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--������翷��ʱ���������Լ�....
	CallScriptFunction( x893081_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893081_g_ScriptId, -1 ,-1 )
	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)

end

--**********************************
--��翷��ʱ����OnTimer....
--**********************************
function x893081_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		MonsterTalk(sceneId, -1, "", "#{SJZ_100129_31}" )
		CallScriptFunction( x893081_g_FuBenScriptId, "DeleteBOSS", sceneId, "Zhong_NPC" )
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
	--ɾ������״̬....
	  local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	  for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x893064_Buff_A, 0 )
			LuaFnCancelSpecificImpact(sceneId,nHumanId,22211)
		end
	  end
		return
	end

	if 2 == step then

		--��ʾChi�n �u b�t �u....
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "Ng߽i c� th� �i�m ��nh Phan Tinh Tinh t�t th� ti�n h�nh khi�u chi�n BOSS M�n m�c" )
		--ɾ��NPC....
		CallScriptFunction( x893081_g_FuBenScriptId, "DeleteBOSS", sceneId, "Panqinqin_NPC" )

		return
	end

	if 1 == step then
		--���ÿ���Khi�u chi�n BOSS M�n m�c....
		CallScriptFunction( x893081_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "MinMo", 1 )
		--ɾ�����й���....
	  local nCount = GetMonsterCount(sceneId)
	  for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 14112 or MosDataID == 14118 then
			LuaFnDeleteMonster(sceneId, nObjId)
		end
	  end

		return
	end
end


-- 402254
-- Ľ�ݸ�

x402254_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9998
}

-- �����Կ�ʼ�����Ŀ���
x402254_g_bWangyuyanSpeak = 24
x402254_g_DuanAndWangFlag = 29

--**********************************
-- �Լ�����
--**********************************
function x402254_OnDie( sceneId, selfId, killerId )

	LuaFnNpcChat(sceneId, selfId, 0, "C�c ng߽i h�y ch� ��, ng�y n�y n�m sau ta s� t�m c�c ng߽i lo m� s�ng h�t nh�ng ng�y c�n l�i �i ha..ha..ha..")

	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)

	-- ֹͣ����
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 0)
	
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_DuanAndWangFlag, 0)
	
	-- ɾ���������̵���
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "V߽ng Ng� Y�n")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "�o�n D�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ba Thi�n Th�ch")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph�m Hoa")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ch� V�n L�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "C� Яc Th�nh")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph� T� Quy")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Chu �an Th�n")
	
	x402254_TipAllHuman( sceneId, "M� Dung Ph�c �� b� ��nh b�i, th�o ph�t Y�n T� � th�nh c�ng, theo l�i n�y tr� l�i Th�i H�" )
	
	--LuaFnDeleteMonster(sceneId, selfId)
	
	-- �����繫��
--#w���ӳ�����#P��#{_BOSS0}������ȴ��ʹ������������Ұ�ש��ʹ���ӡ����ƹ�����ʯ�ҡ����������ã����ڽ�#{_BOSS0}��ô�ܣ���Ķ��ӣ�һ�ٹ����������롣
--#w���ӳ�����#P���������#{_BOSS0}��ս���գ�����������ѧ�����У���ʱ�书���ǣ�#{_BOSS0}�ֵв�����ֻ����Ķ��ӣ����������ݡ�
--#w���ӳ�����#P�����������ǲ�����˳��ᢣ���ʹ����������������ȳ²ֵ���ʮ����֮�󣬴��#{_BOSS0}ֻ��ʹ�õ���ʮ�߼���֮زز�ˡ�
	
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
		--������˶����ȡ�ӳ���ID....
	local nLeaderId = GetTeamLeader(sceneId, playerID)
	if nLeaderId < 1   then
		nLeaderId = playerID
	end
	local str = ""
	local ran = random(3)
	if ran == 1  then
		str = format("#W#{_INFOUSR%s}#P c�ng  #{_BOSS0} quy�t chi�n �c li�t trong y�n t� �, #{_BOSS0} th�y m�nh s�c y�u kh�ng �ch l�i �i th�, quay �u b� ch�y.", GetName(sceneId,nLeaderId))
	elseif ran == 2  then
		str = format("#W#{_INFOUSR%s}#P ch� huy �i ng� c�ng #{_BOSS0} ��nh nhau k�ch li�t n�a ng�y, b�ng nhi�n l�nh ng� ch�n l� v� h�c, nh�t th�i v� c�ng t�ng v�t, #{_BOSS0} ��nh kh�ng l�i, ��nh tung m�nh b� ch�y kh�i Y�n T� �.", GetName(sceneId,nLeaderId))
	else
		str = format("#W#{_INFOUSR%s}#P t�i Y�n T� � �i�u binh khi�n t߾ng, b�y m�u ngh� k�, s� d�ng li�u man thi�n qu� h�i, �m � tr�n th߽ng ��ng ba m߽i s�u k� chi h�u, ��nh cho #{_BOSS0} ch� ph�i s� d�ng � tam th�p th�t k� b� tr�n m�t d�ng.", GetName(sceneId,nLeaderId))
	end
	
	BroadMsgByChatPipe(sceneId, nLeaderId, str, 4)
	
	
end

--**********************************
-- ����
--**********************************
function x402254_OnHeartBeat(sceneId, selfId, nTick)

	-- ��Ľ�ݸ�Ѫ������50%��ʱ���� ������ ������ͬʱ������
	if(1==LuaFnIsCharacterLiving(sceneId, selfId)) then
		if(1==MonsterAI_GetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat)) then
			--PrintNum(1)
			-- ��� Ľ�ݸ� Ѫ���ڶ��٣�����ô����
			if LuaFnGetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak) == 0  then
				if GetHp(sceneId, selfId)*2 <= GetMaxHp(sceneId, selfId) then
					LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 1)
				end
			end
		else
			--PrintNum(2)
		end
	end

--	if(1==LuaFnIsCharacterLiving(sceneId, selfId)) then
--		if(1==MonsterAI_GetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat)) then
--			--Countdown TimerPrepare
--			local TimePrepare = MonsterAI_GetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare)
--			if(0<TimePrepare) then
--				TimePrepare = TimePrepare - nTick;
--				MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, TimePrepare)
--			else
--				local TimeInterval = MonsterAI_GetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval)
--				if(0<TimeInterval) then
--					--Countdown TimerInterval
--					TimeInterval = TimeInterval - nTick;
--					MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, TimeInterval)
--				else
--					MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, x402254_TBL.SkillInterval)
--					local nTarget = LuaFnGetTargetObjID(sceneId, selfId)
--					if(-1~=nTarget) then
--						local posX, posZ = GetWorldPos(sceneId,nTarget)
--						local fDir = 0.0
--						LuaFnUnitUseSkill(sceneId, selfId, x402254_TBL.BossSkill, nTarget, posX, posZ, fDir)			
--						LuaFnNpcChat(sceneId, selfId, 0, "����������ϵ�����ɣ�")
--					end
--				end
--			end
--		end
--	end
end

--**********************************
-- ��ʼ��
--**********************************
function x402254_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)
end

--**********************************
-- ɱ�����
--**********************************
function x402254_OnKillCharacter(sceneId, selfId, targetId)
--	if(-1~=targetId) then
--		local szTarget = GetName(sceneId, targetId)
--		LuaFnNpcChat(sceneId, selfId, 0, szTarget .. "�������������ʮ��������үүҲֻ����·һ����")
--	end
end

--**********************************
-- ����ս��
--**********************************
function x402254_OnEnterCombat(sceneId, selfId, enmeyId)
	if(0<x402254_TBL.BossBuff) then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x402254_TBL.BossBuff, 0)
	end
	
	-- ����ս��״̬��
	LuaFnNpcChat(sceneId, selfId, 0, "B�n v� danh ti�u t�t, ai d�m ph� h�ng ��i k� ph�c qu�c c�a ta th� h�m nay l� ng�y gi� c�a c�c ng߽i, n�i ��y s� l� m� ch�n c�a c�c ng߽i!")
	
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, x402254_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 1)
	
	CallScriptFunction((200060), "Paopao",sceneId, "�o�n D�", "Y�n T� �", "V߽ng c� n߽ng, c� xem n�i n�y binh m� nguy hi�m, hay l� ta che ch� ng߽i �i tr߾c ���c kh�ng?")
	CallScriptFunction((200060), "Paopao",sceneId, "V߽ng Ng� Y�n", "Y�n T� �", "Bi�u ca kh�ng �i, ta c�ng s� kh�ng �i, ta mu�n � l�i gi�p bi�u ca.")

end

--**********************************
-- ����ս��
--**********************************
function x402254_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)

	-- ɾ���������̵���
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "V߽ng Ng� Y�n")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "�o�n D�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ba Thi�n Th�ch")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph�m Hoa")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ch� V�n L�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "C� Яc Th�nh")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph� T� Quy")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Chu �an Th�n")

	-- �����ڳ�����������ЩNpc
	CallScriptFunction((401040), "CreateMonster_11",sceneId)

	-- ֹͣ����
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 0)
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_DuanAndWangFlag, 0)
end

--**********************************
--��ʾ���и��������
--**********************************
function x402254_TipAllHuman( sceneId, Str )
	-- ��ó�����ͷ��������
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	
	-- û���˵ĳ�����ʲô������
	if nHumanNum < 1 then
		return
	end
	
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		BeginEvent(sceneId)
			AddText(sceneId, Str)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId, PlayerId)
	end
end

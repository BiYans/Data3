--002939

-- �ľ�ׯ����
-- ����С����ʱ����

--************************************************************************
--MisDescBegin
--�ű���
x002939_g_ScriptId = 002939
x002939_g_Name = "��ݼݼ"


--MisDescEnd
--************************************************************************
x002939_TIME_2000_01_03_ = 946828868

x002939_g_SceneData_1 = 8   -- ��¼����ˢ�ֵ��ڼ���

x002939_g_SceneData_3 = 9	-- 
x002939_g_SceneData_4 = 10	-- 
x002939_g_SceneData_5 = 11	-- 
x002939_g_SceneData_6 = 12	-- 

--x002939_g_SceneData_7 = 13	-- ��ҵȼ�

x002939_g_SD_Monster_1 	 = 14			-- ��δʹ��
x002939_g_SD_Monster_1_T = 15			-- ��δʹ��


--x002939_g_SD_Monster_2 	 = 16
--x002939_g_SD_Monster_2_T = 17
--x002939_g_SD_Monster_3 	 = 18
--x002939_g_SD_Monster_3_T = 19

--x002939_g_KillMonsCount_Qincheng = 20
--x002939_g_KillMonsCount_Qinjia 	 = 21
--x002939_g_KillMonsCount_Lama		 = 22

-- �رո�����ʱ���¼
x002939_g_CloseTime = 25

-- ����ʧ�ܵı��
x002939_g_MissionLost = 26

-- ����ϵͳ��ʾ��ʱ��
x002939_g_SystemTipsTime = 28

--��������
x002939_g_CopySceneName = "�ľ�ׯ"
x002939_g_CopySceneType = FUBEN_DAZHAN_SJZ	--�������ͣ�������ScriptGlobal.lua����
x002939_g_CopySceneMap = "sijuezhuang.nav"
x002939_g_LimitMembers = 1				--���Խ���������С��������
x002939_g_TickTime = 1						--�ص��ű���ʱ��ʱ�䣨��λ����/�Σ�
x002939_g_DayTime = 3						--һ���ڿ��Խ��븱���Ĵ���
x002939_g_LimitTotalHoldTime = 360--�������Դ���ʱ�䣨��λ��������,�����ʱ�䵽�ˣ������񽫻�ʧ��
x002939_g_LimitTimeSuccess = 500	--����ʱ�����ƣ���λ���������������ʱ�䵽�ˣ��������
x002939_g_CloseTick = 3						--�����ر�ǰ����ʱ����λ��������
x002939_g_NoUserTime = 300				--������û���˺���Լ��������ʱ�䣨��λ���룩
x002939_g_DeadTrans = 0						--����ת��ģʽ��0�������󻹿��Լ����ڸ�����1��������ǿ���Ƴ�����
x002939_g_Fuben_X = 100						--���븱����λ��X
x002939_g_Fuben_Z = 111						--���븱����λ��Z
x002939_g_Back_X = 197							--Դ����λ��X
x002939_g_Back_Z = 214						--Դ����λ��Z
x002939_g_Back_SceneId = 1				--Դ����Id

--**********************************
--������ں���
--**********************************
function x002939_OnDefaultEvent( sceneId, selfId, targetId )
	
	if GetNumText() == 1   then
		BeginEvent(sceneId)
			--AddText(sceneId,"#{yanziwu_info}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetName(sceneId, targetId) ~= x002939_g_Name  then
		return
	end

	-- ������ҵ������������͵���ͬ�ĸ���
	-- 2���������ǲ��������
	if GetTeamSize(sceneId,selfId) < 1  then
		BeginEvent(sceneId)
			AddText(sceneId,"#B��ս�ľ�ׯ");
			AddText(sceneId,"  ��ս�����쳣������3���ҿɲ��������ǽ��롣");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	-- 3���������ǲ��Ƕӳ�
	if GetTeamLeader(sceneId,selfId) ~= selfId    then
		BeginEvent(sceneId)
			AddText(sceneId,"#B��ս�ľ�ׯ");
			AddText(sceneId,"  ������Ƕӳ����С�");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	-- 4������ǲ����˶���λ��
	if GetTeamSize(sceneId,selfId) ~= GetNearTeamCount(sceneId,selfId)  then
		BeginEvent(sceneId)
			AddText(sceneId,"#B��ս�ľ�ׯ");
			AddText(sceneId,"  ���ж�Ա���ڸ�����");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--5����������ͷ��ÿ������ǲ��Ƕ���60����
	local nPlayerNum = GetNearTeamCount(sceneId,selfId)

	for i=0, nPlayerNum-1  do
		local nPlayerId = GetNearTeamMember(sceneId,selfId, i)
		
		if GetLevel(sceneId,nPlayerId) < 60  then
			BeginEvent(sceneId)
				AddText(sceneId,"#B��ս�ľ�ׯ");
				AddText(sceneId,"  ��ս�����쳣������60���ҿɲ��������ǽ��롣");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			
			return
		end
	end

	-- ÿ��ֻ��3��
	--MD_SJZ_TIMES		=	242  -- ÿ������ľ�ׯ�Ĵ���
	--MD_PRE_SJZ_TIME	=	243  -- ��һ��ȥ�ľ�ׯ��ʱ��

	local strName = {}
	strName[1] = ""
	strName[2] = ""
	strName[3] = ""
	strName[4] = ""
	strName[5] = ""
	strName[6] = ""

	local nPlayerNum = GetNearTeamCount(sceneId,selfId)
	local bOk = 1
	for i=0, nPlayerNum-1  do
		local nPlayerId = GetNearTeamMember(sceneId,selfId, i)
		
		local nTimes = GetMissionData(sceneId,nPlayerId, MD_SJZ_TIMES) 
		local nPreTime = GetMissionData(sceneId,nPlayerId, MD_PRE_SJZ_TIME)
		local nCurTime = LuaFnGetCurrentTime()
		if (nCurTime - nPreTime  >= 3600*24)  or
			 (floor((nCurTime-x002939_TIME_2000_01_03_)/(3600*24)) ~= floor((nPreTime-x002939_TIME_2000_01_03_)/(3600*24)))   then
			nTimes = 0
			nPreTime = nCurTime
			SetMissionData(sceneId, nPlayerId, MD_SJZ_TIMES, nTimes)
			SetMissionData(sceneId, nPlayerId, MD_PRE_SJZ_TIME, nPreTime)
		end
		
		if nTimes >= x002939_g_DayTime then
			bOk = 0
			strName[i+1] = GetName(sceneId, nPlayerId)
		end
		
	end
	local nCount = 0

	if bOk == 0  then
		local szAllName = ""
		for i=1, 6  do
			if strName[i] ~= ""  then
				if nCount == 0  then
					szAllName = strName[i]
				else
					szAllName = szAllName .. "��" .. strName[i]
				end
				nCount = nCount+1
			end
		end
		BeginEvent(sceneId)
			AddText(sceneId,"#B��ս�ľ�ׯ");
			AddText(sceneId,"  ��Ķ�����" .. szAllName .. "�����Ѿ��μӹ�3����ս�ľ�ׯս�ۡ�");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	
	end
	
	-- ���еļ��ͨ����
	x002939_MakeCopyScene(sceneId, selfId)
	
end

--**********************************
--�о��¼�
--**********************************
function x002939_OnEnumerate( sceneId, selfId, targetId )
	-- �����������һ�������ж�
	if GetName(sceneId, targetId) == x002939_g_Name  then
		AddNumText( sceneId, x002939_g_ScriptId, "��ս�ľ�ׯ",10 ,-1  )
		AddNumText( sceneId, x002939_g_ScriptId, "������ս�ľ�ׯ",8 ,1  )
	end
end

--**********************************
--����������
--**********************************
function x002939_CheckAccept( sceneId, selfId )
	
end

--**********************************
--ѯ������Ƿ�Ҫ���븱��
--**********************************
function x002939_AskEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--����
--**********************************
function x002939_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--���ͬ����븱��
--**********************************
function x002939_AcceptEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--��������
--**********************************
function x002939_MakeCopyScene( sceneId, selfId )
	
	-- ʹ�ö�Ա�ĵȼ����������ĵȼ�
	local param0 = 4;
	local param1 = 3;

	--���ս��
	local mylevel = 0;

	--��ʱ����
	local memId;
	local tempMemlevel = 0;
	local level0 = 0;
	local level1 = 0;
	local i;
	
	local nearmembercount = GetNearTeamCount(sceneId,selfId)
	for	i = 0, nearmembercount - 1 do
		memId = GetNearTeamMember(sceneId, selfId, i);
		tempMemlevel = GetLevel(sceneId, memId);
		level0 = level0 + (tempMemlevel ^ param0);
		level1 = level1 + (tempMemlevel ^ param1);
	end
	
	if level1 == 0 then
		mylevel = 0
	else
		mylevel = level0/level1;
	end
	
	if nearmembercount == -1  then  --û�ж���
		mylevel = GetLevel(sceneId, selfId)
	end
	
	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "sijuezhuang.nav"); --��ͼ�Ǳ���ѡȡ�ģ����ұ�����Config/SceneInfo.ini�����ú�
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x002939_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x002939_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x002939_g_CopySceneType);--���ø������ݣ����ｫ0����������������Ϊ999�����ڱ�ʾ������999(�����Զ���)
	LuaFnSetCopySceneData_Param(sceneId, 1, x002939_g_ScriptId);--��1����������Ϊ���������¼��ű���
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);		--���ö�ʱ�����ô���
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);	--���ø�����ڳ�����, ��ʼ��
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);		--���ø����رձ�־, 0���ţ�1�ر�
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);		--�����뿪����ʱ����
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --��������
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;	--ɱ��Boss������
	
	-- �����õ��ı������
	for i=8, 31 do
		LuaFnSetCopySceneData_Param(sceneId, i, 0)
	end
	
	local iniLevel;
	if mylevel < 10 then
		iniLevel = 1;
	elseif mylevel < 100 then
		iniLevel = floor(mylevel/10);
	else
		iniLevel = 10;
	end

	-- ʹ�õ�13λ����¼����ʵ�ʵĵȼ�
	LuaFnSetCopySceneData_Param(sceneId, x002939_g_SceneData_7, mylevel)
	
	--���ó����еĸ���Npc������
	LuaFnSetSceneLoad_Area( sceneId, "sijuezhuang_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "sijuezhuang_monster.ini" )

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --��ʼ����ɺ���ô�����������
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"�ľ�ׯ�����Ѿ��������ˣ�");
		else
			AddText(sceneId,"�ľ�ׯ�����Ѿ��������ˣ�");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--�����¼�
--**********************************
function x002939_OnCopySceneReady( sceneId, destsceneId )

	--���븱���Ĺ���
	-- 1���������ļ�û����ӣ��ʹ����������Լ����븱��
	-- 2, �������ж��飬������Ҳ��Ƕӳ����ʹ����Լ����븱��
	-- 3���������ж��飬�����������Ƕӳ����ʹ����Լ��͸�������һ���ȥ

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId) --���ø�����ڳ�����
	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid)
	
	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- �����޷�ִ���߼���״̬
		return
	end
	
	-- �������ǲ����ж���
	if LuaFnHasTeam( sceneId, leaderObjId ) == 0  then   -- û�ж���
		x002939_GotoScene(sceneId, leaderObjId, destsceneId)
	else
		if IsCaptain(sceneId, leaderObjId) == 0  then
			x002939_GotoScene(sceneId, leaderObjId, destsceneId)
		else
			local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
			local mems = {}
			for	i=0,nearteammembercount-1 do
				mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
				x002939_GotoScene(sceneId, mems[i], destsceneId)
			end
		end
	end

end

function x002939_GotoScene(sceneId, ObjId, destsceneId)
	NewWorld( sceneId, ObjId, destsceneId, x002939_g_Fuben_X, x002939_g_Fuben_Z) ;
end


--**********************************
--����ҽ��븱���¼�
--**********************************
function x002939_OnPlayerEnter( sceneId, selfId )
	-- 3,���������¼�
	
	-- ������ҵ���ӪΪ 109
	SetUnitCampID(sceneId, selfId, selfId, 109)
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%10", -1, "0", sceneId, x002939_g_Fuben_X, x002939_g_Fuben_Z )
	
	local nTimes = GetMissionData(sceneId,selfId, MD_SJZ_TIMES) 
	local nPreTime = GetMissionData(sceneId,selfId, MD_PRE_SJZ_TIME)
	local nCurTime = LuaFnGetCurrentTime()
	
	SetMissionData(sceneId, selfId, MD_SJZ_TIMES, nTimes+1) 
	SetMissionData(sceneId, selfId, MD_PRE_SJZ_TIME, nCurTime)
	
end

--**********************************
--������ڸ����������¼�
--**********************************
function x002939_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--����
--**********************************
function x002939_OnAbandon( sceneId, selfId )
	
end

--**********************************
--����
--**********************************
function x002939_OnContinue( sceneId, selfId, targetId )
	
end	

--**********************************
--����Ƿ�����ύ
--**********************************
function x002939_CheckSubmit( sceneId, selfId, selectRadioId )
	
end

--**********************************
--�ύ
--**********************************
function x002939_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--ɱ����������
--**********************************
function x002939_OnDie( sceneId, objId, killerId )
	
end

--**********************************
--��ʾ���и��������
--**********************************
function x002939_TipAllHuman( sceneId, Str )
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

--**********************************
--ɱ����������
--**********************************
function x002939_OnKillObject( sceneId, selfId, objdataId, objId )
	
end

--**********************************
--���������¼�
--**********************************
function x002939_OnEnterZone( sceneId, selfId, zoneId )
	
end

--**********************************
--���߸ı�
--**********************************
function x002939_OnItemChanged( sceneId, selfId, itemdataId )
	
end


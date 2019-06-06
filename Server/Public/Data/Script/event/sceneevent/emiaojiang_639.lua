-- �´�������
-- 212115

--MisDescBegin
--�ű���
x212115_g_ScriptId = 212115

--�����
x212115_g_MissionId = 639
--ǰ�������
x212115_g_PreMissionId = 638

--�������
x212115_g_MissionKind = 40

--����ȼ�
x212115_g_MissionLevel = 98

--�Ƿ��Ǿ�Ӣ����
x212115_g_IfMissionElite = 0

--���漸���Ƕ�̬��ʾ�����ݣ������������б��ж�̬��ʾ�������**********************
--�����Ƿ��Ѿ����
x212115_g_IsMissionOkFail = 0		--�����ĵ�0λ

--�����Ƕ�̬**************************************************************

--������Ҫ�õ�����Ʒ
--x212115_g_DemandItem={{id=40002112,num=1}}		--������1λ

--�����ı�����
x212115_g_MissionName="D�ng c�m x�ng v�o H�n Ng�c Th�p"
x212115_g_MissionInfo="#{Mis_H_Miaojiang_1050003}"
x212115_g_MissionTarget="  H� t�ng A V� #{_INFOAIM182,264,29, A V�} t�i ch�n H�n Ng�c Th�p, t�m ng߶i tr�ng th�p A H�i Nam #{_INFOAIM92,266,29, A H�i Nam}. "
x212115_g_MissionComplete="  Kh�ng sao, ma l�c c�a H�n Ng�c Th�p v�nh vi�n kh�ng nh� c�c ng߽i t߷ng. H�y �i �i, l� ph�m nh�n. C�c ng߽i kh�ng th� v�o ���c H�n Ng�c Th�p. #r#r�, k� ph�m nh�n kia, v�o b�ng c�ch n�o th�? Mau ra ngay"

--����
x212115_g_MoneyBonus=16000
x212115_g_Exp = 30000
--x212115_g_ItemBonus={{id=10122010,num=1}}

x212115_g_Custom	= { {id="�� h� t�ng A V�",num=1} }

x212115_g_RadioItemBonus={{id=10413081 ,num=1},{id=10411086,num=1},{id=10412078,num=1}}

--MisDescEnd

-- ������ʱ����Index
x212115_g_ScneneTimerIndex = -1
x212115_g_Step = 0
x212115_g_StartTime = 0
x212115_g_PlayerNum = 0
x212115_g_PlayerId= {0,0,0,0,0,0}

--**********************************
--������ں���
--**********************************
function x212115_OnDefaultEvent( sceneId, selfId, targetId )
	
	if GetName(sceneId, targetId) == "Linh h�n c�a A V�"  then
		--�����������ʱ��ʾ����Ϣ
		BeginEvent(sceneId)
			AddText(sceneId,"Ta c�n ph�i n�i ch�t...");
			AddNumText(sceneId, x212115_g_ScriptId, x212115_g_MissionName, 2, 999);
		EndEvent(sceneId)
		DispatchMissionInfo(sceneId,selfId,targetId,x212115_g_ScriptId,x212115_g_MissionId)
		return
	end
	
	--����ѽӴ�����
	if IsMissionHaveDone( sceneId, selfId, x212115_g_MissionId ) > 0 then
		return 
	elseif IsHaveMission(sceneId,selfId,x212115_g_MissionId) > 0 then
--		if GetName(sceneId,targetId) == x212115_g_Name then
			--���ͽ�����ǰ��������Ϣ
			BeginEvent(sceneId)
				AddText(sceneId,x212115_g_MissionName);
			EndEvent(sceneId)
    		done = x212115_CheckSubmit( sceneId, selfId );
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x212115_g_ScriptId,x212115_g_MissionId,done)
--		end
	--���������������
	elseif x212115_CheckAccept( sceneId, selfId ) then
	
		--�����������ʱ��ʾ����Ϣ
		BeginEvent(sceneId)
			AddText(sceneId,x212115_g_MissionName);
			AddText(sceneId,x212115_g_MissionInfo);
			AddText(sceneId,"#{M_MUBIAO}");
			AddText(sceneId,x212115_g_MissionTarget);
			AddMoneyBonus( sceneId, x212115_g_MoneyBonus )
			for i, item in x212115_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
		EndEvent(sceneId)
		DispatchMissionInfo(sceneId,selfId,targetId,x212115_g_ScriptId,x212115_g_MissionId)

	end
end

--**********************************
--�о��¼�
--**********************************
function x212115_OnEventRequest( sceneId, selfId, targetId )
	
	if GetNumText() == 999 then
		-- ��ʼ���͵�����
		x212115_g_Step = 3
	end
	
end

--**********************************
--�о��¼�
--**********************************
function x212115_OnEnumerate( sceneId, selfId, targetId )
	
	if IsMissionHaveDone( sceneId, selfId, x212115_g_MissionId ) > 0 then
		return 

	elseif IsHaveMission(sceneId,selfId,x212115_g_MissionId) > 0 then
		if GetName(sceneId, targetId) == "A H�i Nam"  then
			AddNumText(sceneId, x212115_g_ScriptId,x212115_g_MissionName, 2, -1)
		end

	--���������������
	elseif x212115_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x212115_g_MissionName then
			AddNumText(sceneId, x212115_g_ScriptId, x212115_g_MissionName, 1, -1);
		end
	end

end

--**********************************
--��ⴥ������
--**********************************
function x212115_CheckAccept( sceneId, selfId )
	--��Ҫ60�����ܽ�
	if GetLevel( sceneId, selfId ) < x212115_g_MissionLevel then
		return 0
	end
	
	-- ǰ������
	if IsMissionHaveDone( sceneId, selfId, x212115_g_PreMissionId ) < 1 then
		return 0
	end
	
	return 1
end

--**********************************
--����
--**********************************
function x212115_OnAccept( sceneId, selfId )

	-- �������ǲ����Ѿ���ɹ��������
	if IsMissionHaveDone(sceneId, selfId, x212115_g_MissionId) > 0   then
		return
	end
	
	if x212115_CheckAccept(sceneId, selfId)  <= 0   then
		return
	end
	
	if x212115_g_Step > 1  then
		BeginEvent(sceneId)
			strText = "#YHi�n kh�ng th� nh�n nhi�m v� n�y#W"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
	-- �����ǰ 
	if x212115_g_Step == 0  then
		-- ������ȼ��������
		local ret = AddMission( sceneId,selfId, x212115_g_MissionId, x212115_g_ScriptId, 0, 0, 0 )
		-- ��Ҫ��������ǲ����ܹ����ܵ��������
		if ret <= 0      then
			Msg2Player(  sceneId, selfId,"#YNh�t k� nhi�m v� c�a c�c h� �� �y" , MSG2PLAYER_PARA )
			return
		end
		-- ��Ϣ֪ͨ�ͻ���
		Msg2Player(  sceneId, selfId,"#YTi�p nh�n#W ".. x212115_g_MissionName, MSG2PLAYER_PARA )
	
		BeginEvent(sceneId)
			strText = "#YTi�p nh�n#W ".. x212115_g_MissionName
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		-- �������;���  213
		-- ��ⳡ�����ǲ��������������
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		for ii=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			if GetName(sceneId, nMonsterId)  == "Linh h�n c�a A V�"  then
				bHaveMonster = 1
			end
		end
		
		-- ��������ˣ�����������ȥ�����ű�
		if bHaveMonster == 0   then
			local nNpcId = LuaFnCreateMonster(sceneId, 213, 185, 263, 6, 0, 212115)
			SetCharacterName(sceneId, nNpcId, "Linh h�n c�a A V�")
			
			-- ����Сʱʱ����10����
			SetCharacterDieTime(sceneId, nNpcId, 600000)
		end
		
		-- �������Ҽӵ���������б���

		-- ����һ��������ʱ��
		x212115_g_ScneneTimerIndex = SetTimer(sceneId, selfId, 212115, "OnScneneTimer", 1)
		SetMissionByIndex(sceneId,selfId,misIndex,3,x212115_g_ScneneTimerIndex)
		
		x212115_g_Step = 1
		
		--��ǰʱ��
		x212115_g_StartTime = LuaFnGetCurrentTime()
	end
	
	-- ���뵽������͵����
	if x212115_g_Step == 2  then
		if x212115_g_PlayerNum > 5  then
			--������
			return
		end
		
		-- ������ȼ��������
		local ret = AddMission( sceneId,selfId, x212115_g_MissionId, x212115_g_ScriptId, 0, 0, 0 )
		-- ��Ҫ��������ǲ����ܹ����ܵ��������
		if ret <= 0      then
			Msg2Player(  sceneId, selfId,"#YNh�t k� nhi�m v� c�a c�c h� �� �y" , MSG2PLAYER_PARA )
			return
		end
		-- ��Ϣ֪ͨ�ͻ���
		Msg2Player(  sceneId, selfId,"#YTi�p nh�n#W ".. x212115_g_MissionName, MSG2PLAYER_PARA )

		BeginEvent(sceneId)
			strText = "#YTi�p nh�n#W ".. x212115_g_MissionName
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
end

--**********************************
--������ʱ��
--**********************************
function x212115_OnScneneTimer(sceneId, selfId)

	if LuaFnIsObjValid(sceneId,selfId)~=1 then
		return
	end
	
	x212115_g_PlayerNum = 1
	x212115_g_PlayerId[1] = selfId
	
	local misIndex = GetMissionIndexByID(sceneId, selfId, x212115_g_MissionId)
	if not misIndex or misIndex<0 or misIndex>5000 then
		return
	end
	
	local nStep=GetMissionParam(sceneId, selfId, misIndex, 2)
	
	if nStep==100 then
		x212115_g_ScneneTimerIndex=GetMissionParam(sceneId,selfId,misIndex,3)
		StopTimer(sceneId, x212115_g_ScneneTimerIndex)
		return
	end
	
	if nStep==0 then
		SetMissionByIndex(sceneId,selfId,misIndex,2,1)
	end
	
	local bHavePlayer = 0
	if LuaFnIsCanDoScriptLogic(sceneId, selfId) == 0   then
		for i=1, x212115_g_PlayerNum  do
			if LuaFnIsCanDoScriptLogic(sceneId, x212115_g_PlayerId[i]) == 1   then
				bHavePlayer = 1
				selfId = x212115_g_PlayerId[i]
				break
			end
		end
		
		if bHavePlayer == 0    then
			-- ��ʱ��ֹͣ��������е�ȫ�ֱ���
			x212115_CloseTimer(sceneId, x212115_g_ScneneTimerIndex)
		end
	end	
	
	-- �ȴ�5�����2
	if nStep == 1   then
		-- ֪ͨ�Լ������������ҽ��������
		local nMonsterNum = GetMonsterCount(sceneId)
		local jj = 0
		local nAyuId = 0
		local bHaveMonster = 0
		for jj=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,jj)
			if GetName(sceneId, nMonsterId)  == "A V�"  then
				nAyuId = nMonsterId
				bHaveMonster = 1
			end
		end

		local nTeamCount = GetNearTeamCount(sceneId, selfId)
		for i=0, nTeamCount-1 do
			local PlayerId = GetNearTeamMember(sceneId, selfId, i)
			if PlayerId ~= selfId    then
				CallScriptFunction((212115), "OnDefaultEvent", sceneId, PlayerId, nAyuId )
			end
		end
		
		--x212115_g_Step = 2
		SetMissionByIndex(sceneId,selfId,misIndex,2,2)
	end
	
	-- ��ʼ�ȴ���������һ�����������
	if nStep == 2   then
		if LuaFnGetCurrentTime() - x212115_g_StartTime >= 10   then
			--x212115_g_Step = 3
			SetMissionByIndex(sceneId,selfId,misIndex,2,3)
		end
		
	end
	
	-- ����ҵ���˿�ʼ����
	if nStep == 3   then

		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		local nAyuId = 0
		for ii=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			if GetName(sceneId, nMonsterId)  == "Linh h�n c�a A V�"  then
				bHaveMonster = 1
				nAyuId = nMonsterId
			end
		end
		
		if bHaveMonster == 1  then
			SetPatrolId(sceneId, nAyuId, 0)
			--x212115_g_Step = 4
			SetMissionByIndex(sceneId,selfId,misIndex,2,4)
		end
		
	end
	
	-- ���͹���
	if nStep == 4   then
		local nMonsterNum = GetMonsterCount(sceneId)
		local ii = 0
		local bHaveMonster = 0
		local nAyuId = 0
		for ii=0, nMonsterNum-1   do
			local nMonsterId = GetMonsterObjID(sceneId,ii)
			if GetName(sceneId, nMonsterId)  == "Linh h�n c�a A V�"  then
				bHaveMonster = 1
				nAyuId = nMonsterId
			end
		end
		
		if bHaveMonster == 0   then
			-- �رռ�ʱ��
			x212115_CloseTimer(sceneId, x212115_g_ScneneTimerIndex)
			return
		end
		
		-- ���Ayu �����֮��ľ���
		local targetX, targetZ = GetWorldPos(sceneId, nAyuId)
		
		-- ��������ҵľ����Ѿ��뿪�ĳ���������Ҳ��ڻ��Ͷ���10���ڣ�������ʧ��
		for i=1, x212115_g_PlayerNum  do
			if x212115_g_PlayerId[i] ~= 0  then
				if LuaFnIsCanDoScriptLogic(sceneId, x212115_g_PlayerId[i]) == 0   then
					-- ���б���ɾ��������
					x212115_g_PlayerId[i] = 0
					local nPlayerX, nPlayerZ = GetWorldPos(sceneId, x212115_g_PlayerId[i])
					local distance1 = floor(sqrt((targetX-nPlayerX)*(targetX-nPlayerX)+(targetZ-nPlayerZ)*(targetZ-nPlayerZ)))
					
					if distance1 > 10    then
						--��ʾ����������ʧ��
						BeginEvent(sceneId)
							strText = "#YH� t�ng A V� th�t b�i!#W"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x212115_g_PlayerId[i])
						
						x212115_g_PlayerId[i] = 0
					end
				end
			end
		end
		
		local x, z = GetLastPatrolPoint(sceneId, 0)
		local distance = floor(sqrt((targetX-x)*(targetX-x)+(targetZ-z)*(targetZ-z)))
		
		-- �����յ�
		if distance<=1  then

			for i=1, x212115_g_PlayerNum  do
				if x212115_g_PlayerId[i]~=0   then
					-- �������ǲ������������
					if IsHaveMission(sceneId,x212115_g_PlayerId[i],x212115_g_MissionId) > 0 then
						local misIndex = GetMissionIndexByID(sceneId, x212115_g_PlayerId[i], x212115_g_MissionId)
						SetMissionByIndex(sceneId,x212115_g_PlayerId[i],misIndex,0,1)
						SetMissionByIndex(sceneId,x212115_g_PlayerId[i],misIndex,1,1)
						
						BeginEvent(sceneId)
							strText = "#YH� t�ng A V�: 1/1#W"
							AddText(sceneId,strText);
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,x212115_g_PlayerId[i])
					end
				end
			end
			-- ɾ�������ģ��
			LuaFnDeleteMonster(sceneId, nAyuId)
			--x212115_g_Step = 5
			SetMissionByIndex(sceneId,selfId,misIndex,2,5)
			
			-- �رռ�ʱ��
			x212115_CloseTimer(sceneId, x212115_g_ScneneTimerIndex)
		end
	end
	
end

--**********************************
--�رռ�ʱ��
--**********************************
function x212115_CloseTimer( sceneId, TimerIndex )
	StopTimer(sceneId, TimerIndex)
	x212115_g_ScneneTimerIndex = -1
	x212115_g_Step = 0
	x212115_g_StartTime = 0
	x212115_g_PlayerNum = 0
	x212115_g_PlayerId[1]= 0
	x212115_g_PlayerId[2]= 0
	x212115_g_PlayerId[3]= 0
	x212115_g_PlayerId[4]= 0
	x212115_g_PlayerId[5]= 0
	x212115_g_PlayerId[6]= 0
end


--**********************************
--����
--**********************************
function x212115_OnAbandon( sceneId, selfId )
	--ɾ����������б��ж�Ӧ������
	DelMission( sceneId, selfId, x212115_g_MissionId )
end

--**********************************
--�Ѿ����������ٸ�������ʾ
--**********************************
function x212115_OnContinue( sceneId, selfId, targetId )
	--�ύ����ʱ��˵����Ϣ
	BeginEvent(sceneId)
		AddText(sceneId,x212115_g_MissionName)
		AddText(sceneId,x212115_g_MissionComplete)
		AddMoneyBonus( sceneId, x212115_g_MoneyBonus )
		for i, item in x212115_g_RadioItemBonus do
			AddRadioItemBonus( sceneId, item.id, item.num )
		end
	EndEvent(sceneId)
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x212115_g_ScriptId,x212115_g_MissionId)
end

--**********************************
--����Ƿ�����ύ
--**********************************
function x212115_CheckSubmit( sceneId, selfId )
	--��������ǿ������еı���ǲ��Ǳ���Ϊ1��
	local misIndex = GetMissionIndexByID(sceneId,selfId,x212115_g_MissionId)			--�õ���������к�
	
	if GetMissionParam(sceneId, selfId, misIndex, 0) > 0  then
		return 1
	end
	return 0
end

--**********************************
--�ύ����ɣ�
--**********************************
function x212115_OnSubmit( sceneId, selfId,targetId,selectRadioID )
	-- ��ȫ�Լ��
	-- 1���������ǲ������������
	if IsHaveMission(sceneId,selfId,x212115_g_MissionId) <= 0 then
		return
	end
	-- 2���������
	if x212115_CheckSubmit( sceneId, selfId )  <= 0  then
		return
	end
	
	BeginAddItem(sceneId)
		for i, item in x212115_g_RadioItemBonus do
			if item.id == selectRadioID then
				AddItem( sceneId,item.id, item.num )
			end
		end
	local ret = EndAddItem(sceneId,selfId)
	--����������
	if ret > 0 then		
		AddExp(sceneId,selfId,x212115_g_Exp)
		AddMoney(sceneId,selfId,x212115_g_MoneyBonus );

		DelMission( sceneId, selfId, x212115_g_MissionId )
		MissionCom( sceneId, selfId, x212115_g_MissionId )
		AddItemListToHuman(sceneId,selfId)

	else
	--������û�мӳɹ�
		BeginEvent(sceneId)
			strText = "Nhi�m v� th�t b�i!"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--ɱ����������
--**********************************
function x212115_OnKillObject( sceneId, selfId, objdataId ,objId )
	
end

--**********************************
--���������¼�
--**********************************
function x212115_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--���߸ı�
--**********************************
function x212115_OnItemChanged( sceneId, selfId, itemdataId )
	
end

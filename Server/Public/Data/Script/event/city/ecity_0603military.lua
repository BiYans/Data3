
-- ��������,�ͽ��鱨
--MisDescBegin
-- �ű���
x600033_g_ScriptId = 600033

--�����
x600033_g_MissionId = 1109

--M�c ti�u nhi�m v�npc
x600033_g_Name = "V� ��i Uy"

--�������
x600033_g_MissionKind = 50

--��ng c�p nhi�m v� 
x600033_g_MissionLevel = 10000

--��ng����ngTinhӢ����
x600033_g_IfMissionElite = 0

--���漸����ng��̬��ʾto� � ����,����T�i �����б��ж�̬��ʾ�������
x600033_g_IsMissionOkFail = 0							-- Nhi�m v� ho�n th�nh���

--������ng��̬**************************************************************

--���������m�t λ�����洢��� �i�m��to� � �ű���
--�����ı�����
x600033_g_MissionName = "Chuy�n giao t�nh b�o"
x600033_g_MissionInfo = ""													--��������
x600033_g_MissionTarget = "    T�nh b�o quan tr�ng n�y, c�n c�c h� c�p t�c truy�n �n %n, kh�n c�p kh�n c�p. "	--M�c ti�u nhi�m v�
x600033_g_ContinueInfo = "    Nhi�m v� c�a c�c h� v�n ch�a ho�n th�nh �?"				--δHo�n t�t nhi�m v�to� � npc�Ի�
x600033_g_MissionComplete = "    L�m t�t l�m, r�t t�t r�t t�t. "			--Ho�n t�t nhi�m v�npc˵��to� � ��

x600033_g_MissionRound = 79

-- ͨ��Th�nh ph� ����ű�
x600033_g_CityMissionScript = 600001
x600033_g_MilitaryScript = 600030

x600033_g_StrForePart=7

--MisDescEnd

--**********************************
--������ں���
--**********************************
function x600033_OnDefaultEvent( sceneId, selfId, targetId )	-- �i�m���������ִ�д˽ű�
	
	if IsHaveMission( sceneId, selfId, x600033_g_MissionId ) > 0 then
		--  ��t ���c��ǰѡ��to� � Npcto� � T�n
		local szCurNpc = GetName(sceneId,targetId)
		
		-- �����м�¼to� � Npcto� � T�n
		local misIndex = GetMissionIndexByID(sceneId,selfId,x600033_g_MissionId)
		local nNpcId = GetMissionParam(sceneId, selfId, misIndex, 7)
		
		local szNpcName = ""
		if nNpcId > 0  then
			_,szNpcName = GetNpcInfoByNpcId(sceneId,nNpcId)
			
			if szCurNpc == szNpcName   then  -- �Ҷ�����
				BeginEvent( sceneId )
					AddText( sceneId, "#YChuy�n giao t�nh b�o#W" )
					AddText( sceneId, "  Ъn k�p th�i qu�, ta s� s�p �t h�nh �ng ngay ��y" )
				EndEvent()
				DispatchEventList( sceneId, selfId, targetId )
				
				-- ����Nhi�m v� ho�n th�nh���
				SetMissionByIndex(sceneId, selfId, misIndex, 0, 1)
				
				-- T�i ����ɾ���鱨
				DelItem(sceneId, selfId, 40004255, 1)
				
				return
			end
		end
	end
	
	if GetName( sceneId, targetId ) ~= x600033_g_Name then		--�жϸ�npc��ng����ng��Ӧ����to� � npc
		return
	end

	--����ѽӴ�����
	if IsHaveMission( sceneId, selfId, x600033_g_MissionId ) > 0 then
		--������������to� � ��Ϣ
		BeginEvent( sceneId )
			AddText( sceneId, x600033_g_MissionName )
			AddText( sceneId, x600033_g_ContinueInfo )
		EndEvent()
		local bDone = x600033_CheckSubmit( sceneId, selfId )
		DispatchMissionDemandInfo( sceneId, selfId, targetId, x600033_g_ScriptId, x600033_g_MissionId, bDone )
	--Th�a m�n�����������
	elseif x600033_CheckAccept( sceneId, selfId ) > 0 then
		local nTemp = CallScriptFunction( x600033_g_CityMissionScript, "CanDoMisToDay", sceneId, selfId )
		if nTemp == 1   then
			x600033_OnAccept( sceneId, selfId, targetId )
		end
	end
	
end

--**********************************
--�о��¼�
--**********************************
function x600033_OnEnumerate( sceneId, selfId, targetId )

	if GetName( sceneId, targetId ) ~= x600033_g_Name then		--�жϸ�npc��ng����ng��Ӧ����to� � npc
		return
	end

   --����ѽӴ�����
	if IsHaveMission( sceneId, selfId, x600033_g_MissionId ) > 0 then
		AddNumText( sceneId, x600033_g_ScriptId, x600033_g_MissionName, 2 )
	end
	
end

--**********************************
--Ti�p th�
--**********************************
function x600033_OnAccept( sceneId, selfId, targetId )
	
	if GetName( sceneId, targetId ) ~= x600033_g_Name then		--�жϸ�npc��ng����ng��Ӧ����to� � npc
		return
	end
	
	-- �ж���ҵ�c�p,Ȼ����ݵ�c�pѡ��ʹ�ñ���to� � ��m�t ��
	local nLevel = GetLevel(sceneId, selfId)
	local nNpcId = 0
	local szNpcName = ""
	local szScene = ""
	local nScene = 0
	local nPosX = 0
	local nPosZ = 0
	local szNpcDesc =""
	local nSex = 0

	if nLevel >= 40 and nLevel <=54   then
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(26)
	elseif nLevel >= 55 and nLevel <= 69   then
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(27)
	elseif nLevel >= 70 and nLevel <= 84   then
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(28)
	elseif nLevel >= 85 and nLevel <= 99   then			--modi:lby20071126Ϊ�˱���m�t �����
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(29)
		
	elseif nLevel >= 100 and nLevel <= 114   then
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(253)
	elseif nLevel >= 115 and nLevel <= 150   then
		nNpcId,szNpcName,szScene,nScene,nPosX,nPosZ,szNpcDesc,nSex 
				= GetOneMissionNpc(254)	
				
	end
	
	--������������б�
	AddMission( sceneId, selfId, x600033_g_MissionId, x600033_g_ScriptId, 0, 0, 0 )	-- kill��area��item
	if IsHaveMission( sceneId, selfId, x600033_g_MissionId ) <= 0 then
		return
	end

	-- ����C�i n�y ����C�n ��עNPC
	SetMissionEvent( sceneId,selfId, x600033_g_MissionId, 4)
	
	-- ��¼�����ѡ��to� � NpcId
	local misIndex = GetMissionIndexByID(sceneId,selfId,x600033_g_MissionId)
	
	SetMissionByIndex(sceneId, selfId, misIndex, 7, nNpcId)

	CallScriptFunction( x600033_g_MilitaryScript, "OnAccept", sceneId, selfId, targetId, x600033_g_ScriptId )

	-- ������������to� � ������Ʒ
	BeginAddItem( sceneId )
		AddItem( sceneId, 40004255, 1 )
	local ret = EndAddItem( sceneId, selfId )
	if ret <= 0 then 
		return
	end
	AddItemListToHuman(sceneId,selfId)
	
	--��ʾ���ݸ�������Ѿ�Ti�p th�������
	BeginEvent( sceneId )
	local missionInfo = "#r#rC�c h� mau chuy�n giao b�n t�nh b�o n�y cho ".. szScene.. szNpcName
		AddText( sceneId, "    C�c h� �� nh�n nhi�m v�: " .. x600033_g_MissionName )
		AddText( sceneId, missionInfo )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--���Ti�p th�����
--**********************************
function x600033_CheckAccept( sceneId, selfId )
	local ret = CallScriptFunction( x600033_g_MilitaryScript, "CheckAccept", sceneId, selfId )
	return ret
end

--**********************************
--�����ng������ύ
--**********************************
function x600033_CheckSubmit( sceneId, selfId )
	local misIndex = GetMissionIndexByID( sceneId, selfId, x600033_g_MissionId )
	if  GetMissionParam(sceneId, selfId, misIndex, 0) >0  then
		return 1
	end 
	return 0
end

--**********************************
--��������
--**********************************
function x600033_OnAbandon( sceneId, selfId )

	--ɾ����������б��ж�Ӧto� � ����
	CallScriptFunction( x600033_g_MilitaryScript, "OnAbandon", sceneId, selfId )
	
	-- ɾ���������
	DelItem(sceneId, selfId, 40004255, 1)
end

--**********************************
--ɱ����������
--**********************************
function x600033_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--����
--**********************************
function x600033_OnContinue( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, x600033_g_MissionName )
		AddText( sceneId, x600033_g_MissionComplete )
	EndEvent( )
	DispatchMissionContinueInfo( sceneId, selfId, targetId, x600033_g_ScriptId, x600033_g_MissionId )
end

--**********************************
--�ύ
--**********************************
function x600033_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if GetName( sceneId, targetId ) ~= x600033_g_Name then		--�жϸ�npc��ng����ng��Ӧ����to� � npc
		return
	end
	
	if x600033_CheckSubmit( sceneId, selfId ) == 1 then
		CallScriptFunction( x600033_g_MilitaryScript, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
		-- ɾ��������Ʒ
		-- DelItem(sceneId, selfId, 40004255, 1)
	end
end

--**********************************
-- 
--**********************************
function x600033_OnLockedTarget( sceneId, selfId, targetId, missionIndex )

	--  ��t ���c��ǰѡ��to� � Npcto� � T�n
	local szCurNpc = GetName(sceneId,targetId)
	
	-- �����м�¼to� � Npcto� � T�n
	local misIndex = GetMissionIndexByID(sceneId,selfId,x600033_g_MissionId)
	local nNpcId = GetMissionParam(sceneId, selfId, misIndex, 7)
	
	local szNpcName = ""
	_,szNpcName = GetNpcInfoByNpcId(sceneId,nNpcId)
	
	if szCurNpc == szNpcName   then  -- �Ҷ�����
		TAddNumText(sceneId, x600033_g_ScriptId, x600033_g_MissionName, 2, -1,x600033_g_ScriptId);
		TDispatchEventList(sceneId, selfId, targetId)
		return 1
	end
	return 0
end

--**********************************
-- x600033_OnEventRequest
--**********************************
function x600033_OnEventRequest( sceneId, selfId, targetId, eventId )
	--PrintStr("x600033_OnEventRequest")
end

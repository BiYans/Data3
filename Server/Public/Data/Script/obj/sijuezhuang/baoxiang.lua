-- 893082 ����
-- .buff�ı���

x893082_g_scriptId = 893082


--��ӵ�е��¼�ID�б���ID����ʵ��
x893082_g_LimitiBuffCollectionID = 75;

--�߼�����2����50%������� 1 ��
x893082_g_LootItem_3 = {
30004005,20502006,20501006,20500007,
}

--15����ʯ��100%������� 1 ��
x893082_g_LootItem_2 = {
20310117,30700243,20310117,
}

x893082_g_LootItem_5 = {
10156101,20310122,20310140,
}

--�ƾñң�30%������� 1 ��
x893082_g_LootItem_1 = {
30700218,30700219,30700220,30700221,
}

--�ռ����20%������� 1 ��
x893082_g_LootItem_4 = {
30505816, 30505817, 30004005,
}
--�޵�buff
x893082_g_BuffId_1 = 54

--��������buff
x893082_g_BuffId_2 = 8046

--��ɢ�����е�BUFF��Ч��
x893082_g_BuffId_3 = 8055	--�������𣨿�����ɢ��


--��������BuffID
x893082_g_BuffId_4 = 8056	--�������𣨿������ߣ�

--Code Check Only
--QUALITY_CREATE_BY_BOSS =nil

--**********************************
--�¼��б�
--**********************************
function x893082_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--���⽻��:�����ж�
--**********************************
function x893082_OnActivateConditionCheck( sceneId, selfId, activatorId )
	-- �������ϵ�buff
	local bOk = x893082_IsCanOpenBox( sceneId,activatorId )
	
	if bOk == 0  then
    BeginEvent(sceneId)
      AddText(sceneId,"Ng߽i hi�n t�i kh�ng th� m� b�o t߽ng");
    EndEvent(sceneId)
    DispatchMissionTips(sceneId,activatorId,selfId)
	end
	-- ��ɢ�����е�BUFF�������������Buff
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, activatorId, x893082_g_BuffId_3, 0);
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, activatorId, x893082_g_BuffId_4, 0);

	if bOk == 1  then
		local str = "#G[T� tuy�t trang]#W" .. GetName(sceneId, activatorId) .."#P"
		CallScriptFunction((200060), "Duibai",sceneId, "", "", str)
	end
	
	return bOk
end

--**********************************
-- ��⵱ǰ������ϵ�buff���ܲ��ܿ�������
--**********************************
function x893082_IsCanOpenBox( sceneId,activatorId )
		return 1
end

--**********************************
--���⽻��:���ĺͿ۳�����
--**********************************
function x893082_OnActivateDeplete( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--���⽻��:������ɹ���Ч����
--**********************************
function x893082_OnActivateEffectOnce( sceneId, selfId, activatorId )
	
	-- selfId == ����Id
	-- activatorId == ������Id
	
	local x
	local z
	
	x,z = GetWorldPos(sceneId, selfId)
	
	local nCount = GetMonsterCount(sceneId)
	local bDelOk = 0
	for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 14156 then
		--if GetName(sceneId, nObjId) == "��ɫ����"  then
			bDelOk = 1
			LuaFnDeleteMonster(sceneId, nObjId)
		end
	end
	
	-- �������ɹ������һ�������
	local nItemCount = 2
	local nItemId_1
	local nItemId_2
	local nItemId_3
	local nItemId_4
	local nItemId_5
	local nItemId_6

	if random(1000) <= 900  then
		nItemCount = 3
		nItemId_1 = x893082_g_LootItem_1[random( getn(x893082_g_LootItem_1))]
	end

	if random(1000) <= 50  then
		nItemCount = 4
	       nItemId_3 = x893082_g_LootItem_3[random( getn(x893082_g_LootItem_3) )]
	end	
	if random(1000) <= 150  then
		nItemCount = 5
	       nItemId_6 = x893082_g_LootItem_4[random( getn(x893082_g_LootItem_4) )]
	end

	nItemId_2 = x893082_g_LootItem_2[random( getn(x893082_g_LootItem_2) )]
	nItemId_4 = x893082_g_LootItem_2[random( getn(x893082_g_LootItem_2) )]
	nItemId_5 = x893082_g_LootItem_5[random( getn(x893082_g_LootItem_5) )]
	
	
	if bDelOk == 1  then
		local nBoxId = DropBoxEnterScene(	x,z,sceneId )
		if nBoxId > -1  then
			if nItemCount == 3  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,4,
								nItemId_1,nItemId_2,nItemId_4,nItemId_5)
			elseif nItemCount == 2  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,3,
								nItemId_2,nItemId_4,nItemId_5)
			elseif nItemCount == 4  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,4,
								nItemId_2,nItemId_3,nItemId_4,nItemId_5)

			elseif nItemCount == 5  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,5,
								nItemId_2,nItemId_3,nItemId_4,nItemId_5,nItemId_6)
			end
			
			-- ���������󶨸��ƶ����
			SetItemBoxOwner(sceneId, nBoxId, LuaFnGetGUID(sceneId,activatorId))
			
			-- ����ϵͳ����
			local nCurHour = GetHour()
			if nCurHour==0 or nCurHour==2 or nCurHour==4 or
				 nCurHour==6 or nCurHour==8 or nCurHour==10 or
				 nCurHour==12 or nCurHour==14 or nCurHour==16 or
				 nCurHour==18 or nCurHour==20 or nCurHour==22  then
				
					nCurHour = nCurHour + 2
			else
					nCurHour = nCurHour + 1
			
			end
			
			if nCurHour >= 2 and nCurHour < 10  then
				nCurHour = 10
			end
			
			if nCurHour == 24  then
				nCurHour = 0
			end
			
			--#P [����]�ھ����󺰣�����Ӣ���ǣ�ǿ���AAA�Ѿ��������������ı��䣡����XXX������Phong thi�n thai������������֮λ�ɣ�
			local str = format("#{SJZ_100129_109}",GetName(sceneId,activatorId))
	BroadMsgByChatPipe(sceneId, selfId, str, 4)
			
		end
	end
	
	return 1
end

--**********************************
--���⽻��:������ÿʱ������Ч����
--**********************************
function x893082_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--���⽻��:������ʼʱ�����⴦��
--**********************************
function x893082_OnActivateActionStart( sceneId, selfId, activatorId )
	--PrintNum(777)
	return 1
end

--**********************************
--���⽻��:��������ʱ�����⴦��
--**********************************
function x893082_OnActivateCancel( sceneId, selfId, activatorId )
	local str = "#G[Phong thi�n thai]#W" .. GetName(sceneId,activatorId) .. "#Pm� ra b�o t߽ng c� g�ng s� th�nh l�i b�i"
	CallScriptFunction((200060), "Duibai",sceneId, "", "", str)
	return 0
end

--**********************************
--���⽻��:�����ж�ʱ�����⴦��
--**********************************
function x893082_OnActivateInterrupt( sceneId, selfId, activatorId )
	
	return 0
end

function x893082_OnActivateInterrupt( sceneId, selfId, activatorId )

end

function x893082_DealExp(sceneId, activatorId)

	local nPlayerCamp = GetUnitCampID(sceneId, activatorId, activatorId)

	-- ���������ͬʱ������Exp
	local nHumanIdList = {}
	
	for i=1, 10  do
		nHumanIdList[i] = -1
	end
	
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local j=1
	for i=0, nHumanCount-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if GetUnitCampID(sceneId, nHumanId, nHumanId) == nPlayerCamp   then
			nHumanIdList[j] = nHumanId
			j = j+1
		end
	end
	
	j = j-1
	
	for i=1, j  do
		if nHumanIdList[i] ~= -1  then
			AddExp(sceneId, nHumanIdList[i], floor(10000000/j))
		end
	end
	
	for i=0, nHumanCount-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if GetUnitCampID(sceneId, nHumanId, nHumanId) ~= nPlayerCamp   then
			AddExp(sceneId, nHumanId, floor(10000000/(nHumanCount-j)))
		end
	end
	
end

--���飬
--�Ϳ����������ͬ��Ӫ����ƽ�� 10 ��
--�ڳ��ĳ���Щ���������ƽ�� 10 ��

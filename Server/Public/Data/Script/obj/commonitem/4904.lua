--ע�⣺

--��Ʒ���ܵ��߼�ֻ��ʹ�û������ܺͽű���ʵ��


--�ű�:

--�����ǽű�����:


--4904.lua
------------------------------------------------------------------------------------------
--һ����Ʒ��Ĭ�Ͻű�

--�ű���
x334904_g_scriptId = 334904 --��ʱд���,�����õ�ʱ��һ��Ҫ��.

--��Ҫ�ĵȼ�
x334904_g_levelRequire = 1
--AE��Χ�뾶
x334904_g_radiusAE = 3.0
--AE��Ŀ���ϵ���
x334904_g_standFlag = 1 -- 2:���ѣ� 1���Ѿ��� -1���о�
--AEӰ����Ŀ����
x334904_g_effectCount = 4 -- -1:������
--Ч����ID
x334904_g_Impact1 = 4904 --��ʱд���
x334904_g_Impact2 = -1 --����

--**********************************
--�¼��������
--**********************************
function x334904_OnDefaultEvent( sceneId, selfId, bagIndex )
-- ����Ҫ����ӿڣ���Ҫ�����պ���
end

--**********************************
--�����Ʒ��ʹ�ù����Ƿ������ڼ��ܣ�
--ϵͳ����ִ�п�ʼʱ�����������ķ���ֵ���������ʧ������Ժ�������Ƽ��ܵ�ִ�С�
--����1���������Ƶ���Ʒ�����Լ������Ƽ��ܵ�ִ�У�����0�����Ժ���Ĳ�����
--**********************************
function x334904_IsSkillLikeScript( sceneId, selfId)
	return 1; --����ű���Ҫ����֧��
end

--**********************************
--ֱ��ȡ��Ч����
--ϵͳ��ֱ�ӵ�������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1���Ѿ�ȡ����ӦЧ��������ִ�к�������������0��û�м�⵽���Ч��������ִ�С�
--**********************************
function x334904_CancelImpacts( sceneId, selfId )
	return 0; --����Ҫ����ӿڣ���Ҫ�����պ���,����ʼ�շ���0��
end

--**********************************
--���������ڣ�
--ϵͳ���ڼ��ܼ���ʱ����������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1���������ͨ�������Լ���ִ�У�����0���������ʧ�ܣ��жϺ���ִ�С�
--**********************************
function x334904_OnConditionCheck( sceneId, selfId )
	--У��ʹ�õ���Ʒ
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if(0<=targetId) then
		-- Ŀ��������Ѿ��ļ��
		if LuaFnIsFriend(sceneId, targetId, selfId) ~= 1 then
			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
			return 0;
		end
		
		if LuaFnIsFriend(sceneId, selfId, targetId ) ~= 1 then
			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
			return 0;
		end
		
    local SelfSex = LuaFnGetSex(sceneId, selfId)
    local TargetSex = LuaFnGetSex(sceneId, targetId)                
    if( SelfSex == TargetSex ) then
      LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
      
      return 0;                                            
    end 
       
		-- Ŀ������ǵо��ļ��
--		if(1~=LuaFnUnitIsEnemy(sceneId, selfId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- Ŀ������Ƕ��ѵļ��
--		if(1~=LuaFnUnitIsPartner(sceneId, selfId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- Ŀ�꼶��ļ��
--		if(g_LevelRequire<=LuaFnGetLevel(sceneId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
--		if(g_LevelRequire>=LuaFnGetLevel(sceneId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end

	end
	
	return 1; --����Ҫ�κ�����������ʼ�շ���1��
end

--**********************************
--���ļ�⼰������ڣ�
--ϵͳ���ڼ������ĵ�ʱ����������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1�����Ĵ���ͨ�������Լ���ִ�У�����0�����ļ��ʧ�ܣ��жϺ���ִ�С�
--ע�⣺�ⲻ�⸺�����ĵļ��Ҳ�������ĵ�ִ�С�
--**********************************
function x334904_OnDeplete( sceneId, selfId )
	local	bagId			= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	local	itmId			= GetItemTableIndexByIndex( sceneId, selfId, bagId )
	
	if(LuaFnDepletingUsedItem(sceneId, selfId)) then
		local targetId	= LuaFnGetTargetObjID( sceneId, selfId )
		local	namSelf		= GetName( sceneId, selfId )
		local	namTarget	= GetName( sceneId, targetId )
		if itmId > 0 then
			local	namItem		= GetItemName( sceneId, itmId )
			local	str	= format( "#B#{_INFOUSR"..namSelf.."}#cff0000 ��ch th�n �em #W["..namItem.."]#cff0000 mang �n #B#{_INFOUSR"..namTarget.."}#cff0000, �m �u�i nh�n #B#{_INFOUSR"..namTarget.."}#cff0000." )
			AddGlobalCountNews( sceneId, str )
		end
		return 1;
	end
	return 0;
end

--**********************************
--ֻ��ִ��һ����ڣ�
--������˲�����ܻ���������ɺ��������ӿڣ������������Ҹ��������������ʱ�򣩣�������
--����Ҳ����������ɺ��������ӿڣ����ܵ�һ��ʼ�����ĳɹ�ִ��֮�󣩡�
--����1�������ɹ�������0������ʧ�ܡ�
--ע�������Ǽ�����Чһ�ε����
--**********************************
function x334904_OnActivateOnce( sceneId, selfId )
	if(-1~=x334904_g_Impact1) then
		--���Լ���Ч��
--		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x334904_g_Impact1, 0);
		--��Ŀ���Ч��
		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
		if(0<=targetId) then
			if LuaFnIsFriend(sceneId, targetId, selfId) > 0 then
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x334904_g_Impact1, 0);
				
				BeginEvent(sceneId)
			    AddText(sceneId, "е h�u h�o gi�a ng߽i v� �i ph߽ng �� t�ng l�n 80");
			  EndEvent(sceneId)
			  DispatchMissionTips(sceneId,selfId)
			end
		end
		--�Լ���ΧAE
--		local posX,posZ = LuaFnGetUnitPosition(sceneId, selfId)
--		LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334904_g_radiusAE, x334904_g_standFlag, x334904_g_levelRequire, x334904_g_effectCount, x334904_g_Impact1, 0)
		--ָ���ص���ΧAE
--		local posX,posZ = LuaFnGetTargetPosition(sceneId, selfId)
--		LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334904_g_radiusAE, x334904_g_standFlag, x334904_g_levelRequire, x334904_g_effectCount, x334904_g_Impact1, 0)
		--Ŀ�������ΧAE
--		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
--		if(0<=targetId) then
--			local posX,posZ = LuaFnGetUnitPosition(sceneId, targetId)
--			LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334904_g_radiusAE, x334904_g_standFlag, x334904_g_levelRequire, x334904_g_effectCount, x334904_g_Impact1, 0)
--		end
		

	end
	return 1;
end

--**********************************
--��������������ڣ�
--�������ܻ���ÿ����������ʱ��������ӿڡ�
--���أ�1�����´�������0���ж�������
--ע�������Ǽ�����Чһ�ε����
--**********************************
function x334904_OnActivateEachTick( sceneId, selfId)
	return 1; --���������Խű�, ֻ�����պ���.
end
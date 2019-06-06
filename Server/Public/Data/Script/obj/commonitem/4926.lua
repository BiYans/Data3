--ע�⣺

--��Ʒ���ܵ��߼�ֻ��ʹ�û������ܺͽű���ʵ��

--�ű�:

--�����ǽű�����:


--4926.lua
------------------------------------------------------------------------------------------
--һ����Ʒ��Ĭ�Ͻű�

--�ű���
x334926_g_scriptId = 334926 --��ʱд���,�����õ�ʱ��һ��Ҫ��.

--��Ҫ�ĵȼ�

--**********************************
--�¼��������
--**********************************
function x334926_OnDefaultEvent( sceneId, selfId, bagIndex )
-- ����Ҫ����ӿڣ���Ҫ�����պ���

	if sceneId and selfId and bagIndex then
		local selfGUID = LuaFnGetGUID(sceneId, selfId);
		local targetGUID = GetBagItemParam(sceneId, selfId, bagIndex, 0, 2);
		if selfGUID and targetGUID then
			BeginEvent(sceneId);
				if selfGUID == targetGUID then
					AddText(sceneId, "��y l� ng߽i t� m�nh c� thi�p m�i. B�ng n�y c� th� tham gia h�n l� c�a ng߽i. Mau �em chia cho c�c b�ng h�u.");
				else
					local ret, targetName = LuaFnGetItemCreator(sceneId, selfId, bagIndex);
					if ret and targetName and ret == 1 then
						AddText(sceneId, "��y l�"..targetName.."g�i �i cho ng�i thi�p m�i. C� th� d�ng thi�p n�y �n #GL?c Duong [177,94] #Wch� tham gia h�n l�. C� th� � h�n l� s� nh�n ���c qu�.");
					else
						AddText(sceneId, "Kh�ng bi�t nh�n v�t n�o g�i cho ng�i thi�p m�i. B�ng n�y c� th� tham gia h�n l�, nh� r� sau khi h�n l� k�t th�c c� th� d�ng thi�p �i qu�.");
					end
				end
			EndEvent(sceneId);
			DispatchEventList(sceneId, selfId, selfId);
		end
	end
end

--**********************************
--�����Ʒ��ʹ�ù����Ƿ������ڼ��ܣ�
--ϵͳ����ִ�п�ʼʱ�����������ķ���ֵ���������ʧ������Ժ�������Ƽ��ܵ�ִ�С�
--����1���������Ƶ���Ʒ�����Լ������Ƽ��ܵ�ִ�У�����0�����Ժ���Ĳ�����
--**********************************
function x334926_IsSkillLikeScript( sceneId, selfId)
	return 0; --����ű���Ҫ����֧��
end

--**********************************
--ֱ��ȡ��Ч����
--ϵͳ��ֱ�ӵ�������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1���Ѿ�ȡ����ӦЧ��������ִ�к�������������0��û�м�⵽���Ч��������ִ�С�
--**********************************
function x334926_CancelImpacts( sceneId, selfId )
	return 0; --����Ҫ����ӿڣ���Ҫ�����պ���,����ʼ�շ���0��
end

--**********************************
--���������ڣ�
--ϵͳ���ڼ��ܼ���ʱ����������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1���������ͨ�������Լ���ִ�У�����0���������ʧ�ܣ��жϺ���ִ�С�
--**********************************
function x334926_OnConditionCheck( sceneId, selfId )
	return 1; --����Ҫ�κ�����������ʼ�շ���1��
end

--**********************************
--���ļ�⼰������ڣ�
--ϵͳ���ڼ������ĵ�ʱ����������ӿڣ���������������ķ���ֵȷ���Ժ�������Ƿ�ִ�С�
--����1�����Ĵ���ͨ�������Լ���ִ�У�����0�����ļ��ʧ�ܣ��жϺ���ִ�С�
--ע�⣺�ⲻ�⸺�����ĵļ��Ҳ�������ĵ�ִ�С�
--**********************************
function x334926_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
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
function x334926_OnActivateOnce( sceneId, selfId )
	return 1;
end

--**********************************
--��������������ڣ�
--�������ܻ���ÿ����������ʱ��������ӿڡ�
--���أ�1�����´�������0���ж�������
--ע�������Ǽ�����Чһ�ε����
--**********************************
function x334926_OnActivateEachTick( sceneId, selfId)
	return 1; --���������Խű�, ֻ�����պ���.
end
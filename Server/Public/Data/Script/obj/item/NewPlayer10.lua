--ע��: 

--��Ʒ����to� � �߼�ֻ��ʹ�û������ܺͽű���ʵ��

--�ű�:

--������ng�ű�����:

------------------------------------------------------------------------------------------
--�������10c�pto� � Ĭ�Ͻű�
--��ƷID: 30008055

--�ű���
x300079_g_scriptId = 300079--��ʱдC�i n�y ,������to� � ʱ��m�t ��Ҫ��.

--C�n to� � ��c�p
x300079_g_MinLevel = 10
x300079_g_Maxlevel = 20

--������Ʒ�б�
x300079_Gift ={30008056,10124141}


--**********************************
--�¼��������
--**********************************
function x300079_OnDefaultEvent( sceneId, selfId, bagIndex )
-- ��C�n C�i n�y �ӿ�,��Ҫ�����պ���
end

--**********************************
--C�i n�y ��Ʒto� � ʹ�ù�����ng�������ڼ���: 
--H� th�ng��T�i ִ�п�ʼʱ���C�i n�y ����to� � Tr� v�ֵ,���Tr� v�th�t b�i����Ժ���to� � ���Ƽ���to� � ִ��.
--Tr� v�1: ��������to� � ��Ʒ,���Լ������Ƽ���to� � ִ�У�Tr� v�0: ���Ժ���to� � ����.
--**********************************
function x300079_IsSkillLikeScript( sceneId, selfId)
	return 1; --C�i n�y �ű�C�n ����֧��
end

--**********************************
--ֱ��Hu� b�Ч��: 
--H� th�ng��ֱ�ӵ���C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: �Ѿ�Hu� b���ӦЧ��,����ִ�к���������Tr� v�0: û�м�⵽���Ч��,����ִ��.
--**********************************
function x300079_CancelImpacts( sceneId, selfId )
	return 0; --��C�n C�i n�y �ӿ�,��Ҫ�����պ���,����ʼ��Tr� v�0.
end

--**********************************
--����������: 
--H� th�ng��T�i ���ܼ��to� � ʱ�� �i�m����C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: �������ͨ��,���Լ���ִ�У�Tr� v�0: �������th�t b�i,�жϺ���ִ��.
--**********************************
function x300079_OnConditionCheck( sceneId, selfId )
	
	--У��ʹ��to� � ��Ʒ
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	
	--��ng��ʹ�ù��õ���
	local bHave = GetMissionFlag(sceneId, selfId, MF_NEWPLAYER10_USED)
	if bHave == 1 then      --�Ѿ��μӹ���
		x300079_MsgBox(sceneId, selfId, "#{XRLB_81203_3}")
		return 0
	end
	
	--��c�p����
	local CurLevel = LuaFnGetLevel( sceneId, selfId )
	if CurLevel>=x300079_g_Maxlevel then
		x300079_MsgBox(sceneId, selfId, "#{XRLB_81203_4}")
		return 0
	end

	local FreeSpace = LuaFnGetPropertyBagSpace( sceneId, selfId )
	if( FreeSpace < 1 ) then
	   local strNotice = "#{XRLB_81203_5}1#{XRLB_81203_6}"
		 x300079_MsgBox( sceneId, selfId, strNotice)
	   return 0
	end
	
	return 1; --��C�n �κ�����,����ʼ��Tr� v�1.
end

--**********************************
--���ļ�⼰�������: 
--H� th�ng��T�i ��������to� � ʱ�� �i�m����C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: ���Ĵ���ͨ��,���Լ���ִ�У�Tr� v�0: ���ļ��th�t b�i,�жϺ���ִ��.
--ע��: �ⲻ�⸺������to� � ���Ҳ��������to� � ִ��.
--**********************************
function x300079_OnDeplete( sceneId, selfId )
	
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		local guid = LuaFnObjId2Guid(sceneId, selfId);
		
		if guid ~= nil then
			--local LogInfo = format("0X%08X,", guid);
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_TSLB10, guid);
		end
		
		return 1;
	end
	return 0;
end

--**********************************
--ֻ��ִ��m�t �����: 
--������˲�����ܻ�T�i ������ɺ����C�i n�y �ӿ�(�����������Ҹ���������Th�a m�nto� � ʱ��),������
--����Ҳ��T�i ������ɺ����C�i n�y �ӿ�(����to� � m�t ��ʼ,���ĳɹ�ִ��֮��).
--Tr� v�1: �����ɹ���Tr� v�0: ����th�t b�i.
--ע: ������ng������Чm�t ��to� � ���
--**********************************
function x300079_OnActivateOnce( sceneId, selfId )
	BeginAddItem( sceneId )
	for i, v in x300079_Gift do
			AddItem( sceneId, v, 1 )
	end
	local ret = EndAddItem( sceneId, selfId )
	if ret <= 0 then 
		return 
	end

	--Ϊ��������������(20c�p)��ʱװ: ��������
	AddItemListToHuman(sceneId,selfId)
	SetMissionFlag(sceneId, selfId, MF_NEWPLAYER10_USED, 1)
	x300079_MsgBox( sceneId, selfId, "#{XRLB_81203_7}#{_ITEM30008055}#{XRLB_81203_8}")
	return 1;
end

--**********************************
--���������������: 
--�������ܻ�T�i ÿ����������ʱ����C�i n�y �ӿ�.
--Tr� v�: 1�����´�������0: �ж�����.
--ע: ������ng������Чm�t ��to� � ���
--**********************************
function x300079_OnActivateEachTick( sceneId, selfId)
	return 1; --����ng�����Խű�, ֻ�����պ���.
end

--**********************************
--��Ŀ��Ϣ��ʾ
--**********************************
function x300079_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
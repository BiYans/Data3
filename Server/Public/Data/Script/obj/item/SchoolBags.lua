--ע��: 

--��Ʒ����to� � �߼�ֻ��ʹ�û������ܺͽű���ʵ��

--�ű�:

--������ng�ű�����:

------------------------------------------------------------------------------------------
--У�����to� � Ĭ�Ͻű�

--�ű���
x889034_g_scriptId = 889034

x009034_SchoolBags = {{ID = 30504059, BagsSpaces =3,FailNotify ="#{TSJH_090224_12}",SucessNotify ="#{TSJH_090224_13}"},
											{ID = 30504060, BagsSpaces =5,FailNotify ="#{TSJH_090224_14}",SucessNotify ="#{TSJH_090224_15}"},
											{ID = 30504061, BagsSpaces =4,FailNotify ="#{TSJH_090224_16}",SucessNotify ="#{TSJH_090224_17}"},
											{ID = 30504062, BagsSpaces =4,FailNotify ="#{TSJH_090224_18}",SucessNotify ="#{TSJH_090224_19}"},
											{ID = 30504063, BagsSpaces =2,FailNotify ="#{TSJH_090224_20}",SucessNotify ="#{TSJH_090224_22}"},
											{ID = 30504064, BagsSpaces =4,FailNotify ="#{TSJH_090224_23}",SucessNotify ="#{TSJH_090224_24}"},
											{ID = 30504065, BagsSpaces =5,FailNotify ="#{TSJH_090224_25}",SucessNotify ="#{TSJH_090224_26}"},
									}


--������Ʒ�б�
x889034_Gift ={}
x889034_Gift[1] ={30504060,10124141,10141805,30308035}
x889034_Gift[2] ={30504061,30505215,30504068,30309748,30504066,30504067}
x889034_Gift[3] ={30504062,31000005,30008027,30607000,30504055}
x889034_Gift[4] ={30504063,30008027,30504038,30504038,30505217,30504056}
x889034_Gift[5] ={30504064,30008044,20307002,20109004,20109004,20109004,30504057}
x889034_Gift[6] ={30509500,31000001,30504040,30504041,30504058}
x889034_Gift[7] ={30509500,30008044,30504040,30504041,30505076,10124141}
--**********************************
--�¼��������
--**********************************
function x889034_OnDefaultEvent( sceneId, selfId, bagIndex )
-- ��C�n C�i n�y �ӿ�,��Ҫ�����պ���
end

--**********************************
--C�i n�y ��Ʒto� � ʹ�ù�����ng�������ڼ���: 
--H� th�ng��T�i ִ�п�ʼʱ���C�i n�y ����to� � Tr� v�ֵ,���Tr� v�th�t b�i����Ժ���to� � ���Ƽ���to� � ִ��.
--Tr� v�1: ��������to� � ��Ʒ,���Լ������Ƽ���to� � ִ�У�Tr� v�0: ���Ժ���to� � ����.
--**********************************
function x889034_IsSkillLikeScript( sceneId, selfId)
	return 1; --C�i n�y �ű�C�n ����֧��
end

--**********************************
--ֱ��Hu� b�Ч��: 
--H� th�ng��ֱ�ӵ���C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: �Ѿ�Hu� b���ӦЧ��,����ִ�к���������Tr� v�0: û�м�⵽���Ч��,����ִ��.
--**********************************
function x889034_CancelImpacts( sceneId, selfId )
	return 0; --��C�n C�i n�y �ӿ�,��Ҫ�����պ���,����ʼ��Tr� v�0.
end

--**********************************
--����������: 
--H� th�ng��T�i ���ܼ��to� � ʱ�� �i�m����C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: �������ͨ��,���Լ���ִ�У�Tr� v�0: �������th�t b�i,�жϺ���ִ��.
--**********************************
function x889034_OnConditionCheck( sceneId, selfId )
	
	--У��ʹ��to� � ��Ʒ
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	-- ��t ���c��ƷID
	local Item = LuaFnGetItemIndexOfUsedItem(sceneId, selfId)
	local iIndex = -1
	for i=1,getn(x009034_SchoolBags) do
		if (x009034_SchoolBags[i].ID == Item) then
			iIndex = i
		end
	end
	
	if (iIndex ==-1) then
		return 0
	end

	--��ⱳ���ռ���ng���㹻
	local FreeSpace = LuaFnGetPropertyBagSpace( sceneId, selfId )
	if( FreeSpace < x009034_SchoolBags[iIndex].BagsSpaces ) then
	   local strNotice = x009034_SchoolBags[iIndex].FailNotify
		 x889034_MsgBox( sceneId, selfId, strNotice)
	   return 0
	end
	
	--40c�p����в�����to� � ��Ʒ
	if (iIndex ==5 ) then
		FreeSpace = LuaFnGetMaterialBagSpace( sceneId, selfId )
	if( FreeSpace < 4 ) then
	   local strNotice = "#{TSJH_090224_21}"
		 x889034_MsgBox( sceneId, selfId, strNotice)
	   return 0
	end
	end
	
	return 1; --��C�n �κ�����,����ʼ��Tr� v�1.
end

--**********************************
--���ļ�⼰�������: 
--H� th�ng��T�i ��������to� � ʱ�� �i�m����C�i n�y �ӿ�,������C�i n�y ����to� � Tr� v�ֵX�c nh�n�Ժ�to� � ������ng��ִ��.
--Tr� v�1: ���Ĵ���ͨ��,���Լ���ִ�У�Tr� v�0: ���ļ��th�t b�i,�жϺ���ִ��.
--ע��: �ⲻ�⸺������to� � ���Ҳ��������to� � ִ��.
--**********************************
function x889034_OnDeplete( sceneId, selfId )
	
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
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
function x889034_OnActivateOnce( sceneId, selfId )

	-- ��t ���c��ƷID
	local Item = LuaFnGetItemIndexOfUsedItem(sceneId, selfId)
	local iIndex = -1
	for i=1,getn(x009034_SchoolBags) do
		if (x009034_SchoolBags[i].ID == Item) then
			iIndex = i
		end
	end
	
	if (iIndex ==-1) then
		return 0
	end
	
		--�����ÿc�i���to� � ����
	BeginAddItem( sceneId )
	for i, v in x889034_Gift[iIndex] do
			local bagpos01 = TryRecieveItem( sceneId, selfId, v, 9 )								-- �Ų��¾�û����
			LuaFnItemBind( sceneId, selfId, bagpos01 )
	end
	x889034_MsgBox( sceneId, selfId, x009034_SchoolBags[iIndex].SucessNotify)
	
	AuditUseSChoolBags(sceneId, selfId,iIndex,LuaFnGetSex(sceneId,selfId))
	return 1;
end

--**********************************
--���������������: 
--�������ܻ�T�i ÿ����������ʱ����C�i n�y �ӿ�.
--Tr� v�: 1�����´�������0: �ж�����.
--ע: ������ng������Чm�t ��to� � ���
--**********************************
function x889034_OnActivateEachTick( sceneId, selfId)
	return 1; --����ng�����Խű�, ֻ�����պ���.
end

--**********************************
--��Ŀ��Ϣ��ʾ
--**********************************
function x889034_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
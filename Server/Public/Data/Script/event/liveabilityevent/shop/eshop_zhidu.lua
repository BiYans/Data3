--�̵�
--�����̵�
--Tinh T�c �ƶ�

--�ű���
x701610_g_ScriptId = 701610

--�̵��
x701610_g_shoptableindex=56

--�̵�����
x701610_g_ShopName = "Mua ph߽ng th�c ch� �c"

--**********************************
--������ں���
--**********************************
function x701610_OnDefaultEvent( sceneId, selfId, targetId )	-- �i�m���������ִ�д˽ű�
	DispatchShopItem( sceneId, selfId,targetId, x701610_g_shoptableindex )
end

--**********************************
--�о��¼�
--**********************************
function x701610_OnEnumerate( sceneId, selfId, targetId )
	--�ж���ng����ng���ɵ���
	if GetMenPai(sceneId,selfId) == MP_XINGSU then
		AddNumText(sceneId,x701610_g_ScriptId,x701610_g_ShopName,7,-1)
    end
	return
end

--**********************************
--���Ti�p th�����
--**********************************
function x701610_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti�p th�
--**********************************
function x701610_OnAccept( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x701610_OnAbandon( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x701610_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--�����ng������ύ
--**********************************
function x701610_CheckSubmit( sceneId, selfId )
end

--**********************************
--�ύ
--**********************************
function x701610_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--ɱ����������
--**********************************
function x701610_OnKillObject( sceneId, selfId, objdataId,objId)
end

--**********************************
--���������¼�
--**********************************
function x701610_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--���߸ı�
--**********************************
function x701610_OnItemChanged( sceneId, selfId, itemdataId )
end

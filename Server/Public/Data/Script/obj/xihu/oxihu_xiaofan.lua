-- ����NPC
-- С��

x050201_g_scriptId = 050201

x050201_g_shoptableindex = 166	--��ʱ

--**********************************
--�¼��������
--**********************************
function x050201_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    V� ��i Hi�p n�y, �n ��y mua ch�n L�c Чu Thang � gi�i kh�t n�o! Ti�m L�c Чu Thang c�a ta n�i ti�ng g�n xa ��!" )
		AddNumText( sceneId, x050201_g_scriptId, "Mua L�c Чu Thang", 7, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x050201_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		DispatchShopItem( sceneId, selfId, targetId, x050201_g_shoptableindex )
	end
end
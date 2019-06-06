--����Ԫ�� NPC
--ע�Ȿ�ű���������Ԫ����ع���,��m�t ����������to� � ���ӽ����޸�.

x181002_g_scriptId 	= 181002
x181002_g_buyrate 	= 0.5

x181002_g_shoptableindex=151
x181002_g_goodact		= 1		--����Ԫ���̵�
x181002_g_YuanBaoIntro	= 18	--Ԫ������

--**********************************
--�¼��������
--**********************************
function x181002_OnDefaultEvent( sceneId, selfId, targetId )
	if targetId == -1 then
		x181002_OnEventRequest( sceneId, selfId, targetId, nil )
	else
		BeginEvent( sceneId )
			strText = "    Ъn ��y m� xem, th߽ng ph�m b�n ch�y nh�t, gi� r� nh�t. Kh�ch quan, ng�i mau ch�n v�i m�n �i, b�o ��m ng�i mua v� xong ��m nay n�m m� c�ng ph�i c߶i "
			AddText( sceneId, strText )
			AddNumText( sceneId, x181002_g_scriptId, "S� D�ng Phi�u бi B�o Th�ch", 6, 7413)
			AddNumText( sceneId, x181002_g_scriptId, "Gi�i thi�u Kim Nguy�n B�o", 11, x181002_g_YuanBaoIntro)
			if targetId < 0 then
				targetId = -1	--Ϊ������������ѡ��
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x181002_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 7413 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ng߽i mu�n �i l�y lo�i b�o th�ch n�o?" )
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch �o Minh", 6, 74131)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch M� L�c", 6, 74132)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Sinh M�nh", 6, 74133)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Huy�n Vi", 6, 74134)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Hy V�ng", 6, 74135)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Th�ng L�i", 6, 74136)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Thi�n C�", 6, 74137)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch Tr� Tu�", 6, 74138)
			AddNumText( sceneId, x181002_g_scriptId, "B�o Th�ch V�n M�nh", 6, 74139)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 74131 and GetNumText() <= 74139 then
		local key = GetNumText() - 74130
		local GemID = {}
			GemID[1] = {50304002}
			GemID[2] = {50312001,50312002,50312003,50312004}
			GemID[3] = {50311001,50311002}
			GemID[4] = {50303001}
			GemID[5] = {50301001,50301002}
			GemID[6] = {50321001,50321002,50321003,50321004}
			GemID[7] = {50314001}
			GemID[8] = {50302001,50302002,50302003,50302004}
			GemID[9] = {50313001,50313002,50313003,50313004,50313005,50313006}
			
		BeginEvent(sceneId)
			for i = 1, getn(GemID[key]) do
				AddRadioItemBonus( sceneId, GemID[key][i], 1 )
			end
		EndEvent( )
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x181002_g_scriptId,0)
	end

	if GetNumText() == x181002_g_goodact then
		x181002_NewDispatchShopItem( sceneId, selfId,targetId, x181002_g_shoptableindex )
	elseif GetNumText() == x181002_g_YuanBaoIntro	then
		BeginEvent( sceneId )
			AddText( sceneId, "#{INTRO_YUANBAO}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end


function x181002_OnMissionSubmit(sceneId,selfId,targetId,x181002_g_scriptId,ItemID)
	if LuaFnGetAvailableItemCount(sceneId,selfId,30900077) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"Ng߽i kh�ng c� phi�u �i b�o th�ch �?")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"H�y s�p x�p 1 � tr�ng trong t�i nguy�n li�u.")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	LuaFnDelAvailableItem(sceneId,selfId,30900077,1)
	local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
	LuaFnItemBind(sceneId,selfId,iPos)
	
	BeginEvent(sceneId)
		AddText(sceneId,"Ch�c m�ng ng߽i �� nh�n ���c #G"..GetItemName(sceneId,ItemID).."#W.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
end
--**********************************
--�����������̵�,��Ϊ�����̵��NPC�̵�
--**********************************
function x181002_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end

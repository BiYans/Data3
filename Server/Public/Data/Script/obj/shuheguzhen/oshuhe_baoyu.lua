--Th�c H� C� Tr�nNPC
--�Ƶ��ϰ�
--��ͨ

x001187_g_scriptId = 001187
x001187_g_shoptableindex = 25

x001187_g_MsgInfo = { "#{SHGZ_0612_09}",
											"#{SHGZ_0620_25}",
											"#{SHGZ_0620_26}",
											"#{SHGZ_0620_27}",
										}

--**********************************
--�¼��������
--**********************************
function x001187_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)

--**********************************
--NPC�Ի�
--**********************************
		local msgidx = random(getn(x001187_g_MsgInfo))
		AddText(sceneId, x001187_g_MsgInfo[msgidx])
		AddNumText( sceneId, x001187_g_scriptId, "Ng߽i mu�n mua g� n�o?", 7, 28 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x001187_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 28 then
		DispatchShopItem( sceneId, selfId, targetId, x001187_g_shoptableindex )
		return 0
	end
end

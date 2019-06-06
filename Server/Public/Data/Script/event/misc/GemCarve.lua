--��ʯ����

--�ű���
x800117_g_ScriptId	= 800117
x800117_g_BINDED = 1              -- �Ѿ���
			

function x800117_OnGemCarve( sceneId, selfId, GemItemPos, NeedItemPos,TargetID )

	if (TargetID == nil ) then
		return
	end 
	if (TargetID == -1) then
		return
	end
	if GemItemPos == -1 or NeedItemPos == -1 then
		return
	end

	local GemItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, GemItemPos )
	local NeedItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, NeedItemPos )

	-- ��t ���c��ʯ����to� � ��Ϣ....
	local ProductID, NeedID, NeedMoney = LuaFnGetGemCarveInfo( GemItemID )
	if  -1 == ProductID then
		return
	end

	--�����ng����������Ʒ....
	if NeedID ~= NeedItemID then
		return
	end
	
	--����Ǯ��ng���㹻....
	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)  --�����ռ� Vega
	if PlayerMoney < NeedMoney then
		return
	end

	local ProductNeedBind = 0    -- ����to� � �±�ʯ��ng��C�n �� 0��ng��C�n ��״̬,1��ngC�n ��
	--���ݱ�ʯ��ng��󶨺ͱ�ʯ��������ng���,����ժ����to� � ��ʯ��ng���
	if (LuaFnGetItemBindStatus(sceneId,selfId,GemItemPos) == x800117_g_BINDED or LuaFnGetItemBindStatus(sceneId,selfId,NeedItemPos) == x800117_g_BINDED) then
	  ProductNeedBind = 1
	end	

	local NeedItemInfo = GetBagItemTransfer( sceneId, selfId, NeedItemPos )

	--�۳���ʯ��������Ʒ....
	ret = LuaFnIsItemAvailable( sceneId, selfId, GemItemPos )
	if ret ~= 1 then
		x800117_NotifyTip( sceneId, selfId, "Lo�i b�o th�ch n�y kh�ng th� t�o h�nh ���c" )
		return
	end
	ret = LuaFnIsItemAvailable( sceneId, selfId, NeedItemPos )
	if ret ~= 1 then
		x800117_NotifyTip( sceneId, selfId, "V�t ph�m kh�ng th� s� d�ng" )
		return
	end

	LuaFnEraseItem( sceneId, selfId, GemItemPos )
	LuaFnEraseItem( sceneId, selfId, NeedItemPos )

	--��Ǯ....
	ret = LuaFnCostMoneyWithPriority( sceneId, selfId, NeedMoney )    --�����ռ� Vega
	if ret < 0 then
		x800117_NotifyTip( sceneId, selfId, "Kh�ng �� Ng�n L��ng" )
		return
	end

	--����ҵ�����to� � ��ʯ....���ü�ⱳ����ng���еط�....û�ط�ǰ��Ҳdel���ط���....
	local BagIndex = TryRecieveItem( sceneId, selfId, ProductID, QUALITY_MUST_BE_CHANGE )
	if BagIndex == -1 then
		x800117_NotifyTip( sceneId, selfId, "T�i �eo thi�u kh�ng gian" )
	end
	
	--���ݱ�ʯ��ng��󶨺ͱ�ʯ��������ng���,����ժ����to� � ��ʯ��ng���
	if (ProductNeedBind == 1) then
	  local	bindidx	=	LuaFnItemBind(sceneId, selfId,BagIndex)
	  if bindidx ~= 1 then
		  local bindmsg = "V�t ph�m �� ���c c� �nh"														
		  BeginEvent( sceneId )
		    AddText( sceneId, bindmsg )
		  EndEvent( sceneId )
		  DispatchMissionTips( sceneId, selfId )
	  end
	end	

	--ͳ��....
	LuaFnAuditGemCarve( sceneId, selfId, GemItemID)

	--��Ŀ��ʾ��ҵ����ɹ�....
	x800117_NotifyTip( sceneId, selfId, "#{_ITEM"..GemItemID.."} t�o h�nh th�nh c�ng, tr� th�nh #{_ITEM"..ProductID.."}" )

	--����....
	local Name = GetName(sceneId, selfId)
	local SceneName = GetSceneName(sceneId)
	local NPCName   = GetName(sceneId,TargetID)
	local GemItemInfo = GetBagItemTransfer( sceneId, selfId, BagIndex )
	local gemQual = GetItemQuality( ProductID )
	--local strText = format("#{_INFOUSR%s}#I��%s#R������#I��ʹ��#{_INFOMSG%s}#I������һ��#{_INFOMSG%s}#I��������һʱ������졣", Name, SceneName,NeedItemInfo, GemItemInfo )
	local strText = format("#{_INFOUSR%s}#I S� d�ng t�i #G%s#R%s#I s� d�ng ch�c n�ng t�o h�nh c�a #{_INFOMSG%s}#I t�o ra m�t vi�n #{_INFOMSG%s}#I ph�t quang s�ng ch�i...", Name, SceneName,NPCName,NeedItemInfo, GemItemInfo, SceneName)
	
	--����Tinh��,ֻ����3c�p����to� � ��ʯ��������
	if (gemQual > 3) then
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end

	-- �����ɹ���Ч....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);

end

--**********************************
--��Ŀ��ʾ
--**********************************
function x800117_NotifyTip( sceneId, selfId, Msg )

	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )

end

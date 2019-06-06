

x335135_g_scriptId = 335135

x335135_g_CompleteValue = 5			
x335135_g_MaxUseCount = 1				
x335135_g_MaxCompleteValue = {25,50,75,100,100,100,100}
x335135_g_ShenCaiTable = {							{sjid=30505700,sfid=30505800,lrid=30505900},
													{sjid=30505701,sfid=30505801,lrid=30505901},
													{sjid=30505702,sfid=30505802,lrid=30505902},
													{sjid=30505703,sfid=30505803,lrid=30505903},
													{sjid=30505704,sfid=30505804,lrid=30505904},
													{sjid=30505705,sfid=30505805,lrid=30505905},
													{sjid=30505706,sfid=30505806,lrid=30505906},}		
x335135_g_ShenCaiIndex = 0

x335135_g_Impact_LevelUP = 47

x335135_g_Impact_Complete = 48

x335135_g_XinMang7JiInfo = "T�n M�ng Th�n Ph� C�p 7"

--******************************************************************************

function x335135_OnDefaultEvent( sceneId, selfId, bagIndex )
end

--**********************************
--**********************************
function x335135_IsSkillLikeScript( sceneId, selfId)
	return 1	
end
--**********************************
function x335135_OnConditionCheck( sceneId, selfId )
	
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	local nIndex = LuaFnGetBagIndexOfUsedItem( sceneId, selfId )	
	
	local Item01 = LuaFnGetItemTableIndexByIndex(sceneId, selfId, nIndex)
		
	for i=1, 7 do			
		if Item01 == x335135_g_ShenCaiTable[i].sfid then
			x335135_g_ShenCaiIndex = i
			break
		end
	end
			
	if Item01 < 30505800 or Item01 > 30505806 then			
		local strNotice = "Ch� c� th� d�ng t�n m�ng th�n ph� h�p th�nh" 
		x335135_ShowMsg( sceneId, selfId, strNotice)
	  return 0
	end
	local ItemCount = LuaFnGetAvailableItemCount( sceneId, selfId, x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid )
	if ItemCount < 1 then
		local strNotice = "Ng߽i c�n ".."#{_ITEM"..(x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid).."}" -- ��ȱto� � ���
		x335135_ShowMsg( sceneId, selfId, strNotice)
	  return 0
	end
	
	local bagbegin = GetBasicBagStartPos(sceneId, selfId)
	local bagend   = GetBasicBagEndPos(sceneId, selfId)
	local ItemEX
	local sjbagpos = -1
	for i=bagbegin, bagend do
		if LuaFnIsItemAvailable( sceneId, selfId, i ) == 1 then
			ItemEX = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)			
			if ItemEX == x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid then
				sjbagpos = i
				break
			end		
		end
	end
		

	if sjbagpos == -1 then
		local strNotice = "Ng߽i c�n ".."#{_ITEM"..(x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid).."}" -- ��ȱto� � ���
		x335135_ShowMsg( sceneId, selfId, strNotice)
	  return 0
	end
	
	
	local CheckParam = GetBagItemParam( sceneId, selfId, sjbagpos, 8, 2 )   
	
	
	if CheckParam < x335135_g_MaxCompleteValue[x335135_g_ShenCaiIndex] and CheckParam + x335135_g_CompleteValue >= x335135_g_MaxCompleteValue[x335135_g_ShenCaiIndex] then		-- �������ȴﵽ100ʱ��ng���пռ�
		local FreeSpace = LuaFnGetPropertyBagSpace( sceneId, selfId )
		if( FreeSpace < 1 ) then
	     local strNotice = "� ��o c� kh�ng c� kh�ng gian, c�n s�a sang l�i."
		   x335135_ShowMsg( sceneId, selfId, strNotice)
	     return 0
		end
	end
	
	
	if Item01 == 30505806 then
		x335135_g_XinMang7JiInfo = GetBagItemTransfer( sceneId, selfId, nIndex )
	end
	
	
	return 1;
end

--**********************************
function x335135_OnDeplete( sceneId, selfId )
	if(0 < LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1
	end
	return 0
end

--**********************************
--**********************************
function x335135_OnActivateOnce( sceneId, selfId )
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end

	local nIndex = LuaFnGetBagIndexOfUsedItem( sceneId, selfId )	
	local Item001 = LuaFnGetItemTableIndexByIndex(sceneId, selfId, nIndex)
	for i=1, 7 do				--for i=1, 6 do
		if Item001 == x335135_g_ShenCaiTable[i].sfid then
			x335135_g_ShenCaiIndex = i
			break
		end
	end

	local ItemCount = LuaFnGetAvailableItemCount( sceneId, selfId, x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid )
	
	if ItemCount < 1 then
		local strNotice = "Ng߽i c�n ".."#{_ITEM"..(x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid).."}" 
		x335135_ShowMsg( sceneId, selfId, strNotice)
		return 0
	end
	
	local Item01 = x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sfid
	
	local bagbegin = GetBasicBagStartPos(sceneId, selfId)
	local bagend   = GetBasicBagEndPos(sceneId, selfId)
	local ItemEX
	local sjbagpos = -1
	for i = bagbegin, bagend do
		if LuaFnIsItemAvailable( sceneId, selfId, i ) == 1 then
			ItemEX = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)			
			if ItemEX == x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid then
				sjbagpos = i
				break
			end		
		end
	end
	
	if sjbagpos == -1 then
		local strNotice = "Ng߽i c�n ".."#{_ITEM"..(x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid).."}" -- ��ȱto� � ���
		x335135_ShowMsg( sceneId, selfId, strNotice)
	  return 0
	end
	
	local CompleteValue = GetBagItemParam( sceneId, selfId, sjbagpos, 8, 2 )

	if 0 == 0 then		
		LuaFnDelAvailableItem(sceneId,selfId,Item001,1)
		
		LuaFnAuditShenCai(sceneId, selfId, Item01)
		
		CompleteValue = CompleteValue + x335135_g_CompleteValue

		
		SetBagItemParam( sceneId, selfId, sjbagpos, 8, 2, CompleteValue ) --������ɶ�
		
		if Item01 == 30505806 then
			local playername = GetName(sceneId, selfId)	
			local strText = format("#G#{_INFOUSR%s}#{DQSJ_20080512_12} "..x335135_g_XinMang7JiInfo.."#{DQSJ_20080512_13}", playername)						
			BroadMsgByChatPipe(sceneId,selfId, strText, 4)
		end
		
		local CheckParam = GetBagItemParam( sceneId, selfId, sjbagpos, 8, 2 )   
			
		if CheckParam ~= CompleteValue then
		    return 0
		end		
		
		local strNotice = "C�a ng߽i ".."#{_ITEM"..(x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].sjid).."}".." �y �� gia t�ng 1 r�i" -- ��ȱto� � ���
		x335135_ShowMsg( sceneId, selfId, strNotice)
		
		LuaFnRefreshItemInfo( sceneId, selfId, sjbagpos )	--ˢ�±�����Ϣ
		
		if CompleteValue >= x335135_g_MaxCompleteValue[x335135_g_ShenCaiIndex] then		-- �������ȴﵽ100ʱ
					
			local EraseRet = EraseItem( sceneId, selfId, sjbagpos )
			
			if EraseRet < 0 then      --���ɾ��th�t b�i,����������κ�Ч��			  
				return 0
			end

			BeginAddItem( sceneId )
			AddItem( sceneId, x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].lrid, 1 )
			ret = EndAddItem( sceneId, selfId )
											
			if ret > 0 then
				
				local equip = TryRecieveItem( sceneId, selfId, x335135_g_ShenCaiTable[x335135_g_ShenCaiIndex].lrid, QUALITY_MUST_BE_CHANGE )	-- �Ų��¾�û����							
				local equipinfo = GetBagItemTransfer( sceneId, selfId, equip )

				local playername = GetName(sceneId, selfId)	
				local strText = format("#YCh�c m�ng #{_INFOUSR%s}#Y sau bao nhi�u v�t v� �� c� ���c #G#{_INFOMSG%s}", playername,equipinfo)						
				BroadMsgByChatPipe(sceneId,selfId, strText, 4)

			else
				BeginEvent(sceneId)
				strText = "� ��o c� ho�c nguy�n li�u kh�ng �� kh�ng gian, th�nh s�a sang l�i sau l�i �n l�nh."
				AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return 0
			end		
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 48, 0 )
		else
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 47, 0 )
		end
		
	else
		local strMsg = "H�p th�nh th�t b�i"
		x335135_ShowMsg( sceneId, selfId, strMsg)
		return 0
	end
  
	return 1
end

--**********************************
function x335135_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
function x335135_CancelImpacts( sceneId, selfId )
	return 0		
end

function x335135_ShowMsg( sceneId, selfId, strMsg)
	BeginEvent( sceneId )
		AddText( sceneId, strMsg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end

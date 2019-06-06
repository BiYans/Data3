--=======================--
-- L߽ng ��o s�
-- Author: Dark.Hades
--=======================--

x001091_g_scriptId = 001091


function x001091_OnDefaultEvent( sceneId, selfId, targetId )

     
	BeginEvent(sceneId)
    AddText(sceneId, "#{SQXY_09061_12}")
	AddText(sceneId, "Sau khi t߾i n߾c cho #YC�y ߾c nguy�n#W v� nh�n ���c �� s� #GH�a nguy�n qu� #Wy�u c�u, ta c� th� ��p �ng nhi�u nguy�n v�ng c�a c�c h�.")
    AddNumText(sceneId, x001091_g_scriptId, "#{SQXY_09061_5}", 6, 11)
    AddNumText(sceneId, x001091_g_scriptId, "#{SQXY_09061_6}", 11, 1)
	EndEvent(sceneId)
	DispatchEventList( sceneId, selfId, targetId )
end
function x001091_UpdateEventList( sceneId, selfId,targetId )
     
end
function x001091_OnEventRequest( sceneId, selfId, targetId, eventId )
   
	local key = GetNumText();
    
	if key == 1 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{SQXY_09061_10}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end

	if key == 11 then
		BeginEvent(sceneId)
			AddText(sceneId, "D�ng h�a nguy�n qu� � �i l�y ph�n th߷ng mong mu�n.")
			AddRadioItemBonus( sceneId, 30900006, 1 )
			AddRadioItemBonus( sceneId, 50313004, 2 )
		EndEvent(sceneId)
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x001091_g_scriptId,1)
	end
end
function x001091_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti�p th�
--**********************************
function x001091_OnAccept( sceneId, selfId )

end

--**********************************
--����
--**********************************
function x001091_OnAbandon( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x001091_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--�����ng������ύ
--**********************************
function x001091_CheckSubmit( sceneId, selfId )
	
end

function x001091_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	if selectRadioId == 30900006 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,20502010) < 7 then
			BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i kh�ng c� �� H�a Nguy�n Qu�." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "H�y s�p x�p 1 � ��o C�." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,20502010,7)
		local pos = TryRecieveItem(sceneId,selfId,30900006,1)
		LuaFnItemBind(sceneId,selfId,pos)
		x001091_NotifyFailTips( sceneId, selfId, "Nh�n th߷ng th�nh c�ng." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if selectRadioId == 50313004 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,20502010) < 20 then
			BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i kh�ng c� �� H�a Nguy�n Qu�." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "H�y s�p x�p 1 � Nguy�n Li�u." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,20502010,20)
		local pos = TryRecieveItem(sceneId,selfId,50313004,1)
		LuaFnItemBind(sceneId,selfId,pos)
		x001091_NotifyFailTips( sceneId, selfId, "Nh�n th߷ng th�nh c�ng." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		local playername = GetName(sceneId,selfId)
		local equipinfo = GetBagItemTransfer( sceneId, selfId, pos )
		local strText = format("#{_INFOUSR%s} #Gt�i T� Ch�u - L߽ng ��o S� (186,182) d�ng 20 qu� #WH�a Nguy�n Th� #G� ��i l�y #G#{_INFOMSG%s}.", playername,equipinfo)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end
end


function x001091_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

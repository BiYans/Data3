--=======================--
-- Lß½ng ðÕo sî
-- Author: Dark.Hades
--=======================--

x001091_g_scriptId = 001091


function x001091_OnDefaultEvent( sceneId, selfId, targetId )

     
	BeginEvent(sceneId)
    AddText(sceneId, "#{SQXY_09061_12}")
	AddText(sceneId, "Sau khi tß¾i nß¾c cho #YCây ß¾c nguy®n#W và nh§n ðßþc ðü s¯ #GHÑa nguy®n quä #Wyêu c¥u, ta có th¬ ðáp Ñng nhi«u nguy®n v÷ng cüa các hÕ.")
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
			AddText(sceneId, "Dùng hÑa nguy®n quä ð¬ ð±i l¤y ph¥n thß·ng mong mu¯n.")
			AddRadioItemBonus( sceneId, 30900006, 1 )
			AddRadioItemBonus( sceneId, 50313004, 2 )
		EndEvent(sceneId)
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x001091_g_scriptId,1)
	end
end
function x001091_CheckAccept( sceneId, selfId )
end

--**********************************
--Tiªp thø
--**********************************
function x001091_OnAccept( sceneId, selfId )

end

--**********************************
--·ÅÆú
--**********************************
function x001091_OnAbandon( sceneId, selfId )
end

--**********************************
--¼ÌÐø
--**********************************
function x001091_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--¼ì²âÐúng·ñ¿ÉÒÔÌá½»
--**********************************
function x001091_CheckSubmit( sceneId, selfId )
	
end

function x001091_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	if selectRadioId == 30900006 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,20502010) < 7 then
			BeginEvent(sceneId)
			AddText( sceneId, "Ngß½i không có ðü HÑa Nguy®n Quä." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "Hãy s¡p xªp 1 ô ÐÕo Cø." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,20502010,7)
		local pos = TryRecieveItem(sceneId,selfId,30900006,1)
		LuaFnItemBind(sceneId,selfId,pos)
		x001091_NotifyFailTips( sceneId, selfId, "Nh§n thß·ng thành công." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
	end
	
	if selectRadioId == 50313004 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,20502010) < 20 then
			BeginEvent(sceneId)
			AddText( sceneId, "Ngß½i không có ðü HÑa Nguy®n Quä." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "Hãy s¡p xªp 1 ô Nguyên Li®u." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,20502010,20)
		local pos = TryRecieveItem(sceneId,selfId,50313004,1)
		LuaFnItemBind(sceneId,selfId,pos)
		x001091_NotifyFailTips( sceneId, selfId, "Nh§n thß·ng thành công." )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		local playername = GetName(sceneId,selfId)
		local equipinfo = GetBagItemTransfer( sceneId, selfId, pos )
		local strText = format("#{_INFOUSR%s} #GtÕi Tô Châu - Lß½ng ÐÕo Sî (186,182) dùng 20 quä #WHÑa Nguy®n Thø #Gð¬ ðôi l¤y #G#{_INFOMSG%s}.", playername,equipinfo)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end
end


function x001091_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

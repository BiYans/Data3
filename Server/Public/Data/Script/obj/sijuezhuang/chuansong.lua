-- 899994
-- ¸ßÌ«¹« ·ËÕ¯´«ËÍÈË

--kich ban goc hao
x899994_g_scriptId = 899994

--ËùÓµÓÐµÄÊÂ¼þIDÁÐ±í
x899994_g_eventList={893063}

--**********************************
--ÊÂ¼þÁÐ±í
--**********************************
function x899994_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"   Cüa ta nghîa phø phan xí v¯n là kì ngh® thª gia ð® tØ, trong cûng có tuy®t thª kì ngh® bí bäo. Nhßng l¤y c¥m kÏ thß h÷a n²i tiªng giang h° tÑ tuy®t trang lÕi dùng các loÕi hi¬m ác thü ðoÕn ðem bí bäo cß¾p ði, còn nghî phan gia di®t môn. Ta nghîa phø nhân r½i xu¯ng vách núi ðen có th¬ ðào thoát, nhßng r½i vào 2 chân tàn phª, ta v¯n ð¸nh ðem bí bào ðoÕt lÕi này tâm nguy®n, b¤t ð¡c dî lñc b¤t tòng tâm, lúc này kh¦n c¥u chß v¸ ðÕi hi®p trþ ta ðoÕt lÕi bí bào, làm cho ti¬u næ tØ có th¬ tçn phân hiªu tâm")
	AddText(sceneId,"   Chú ý h® th¯ng nhi®m vø khó xin c¦n tr÷ng")

	AddNumText( sceneId, x899994_g_scriptId, "V« tÑ tuy®t trang",0 ,2  )
	
	for i, eventId in x899994_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--Su kien lan nhau cua vao
--**********************************
function x899994_OnDefaultEvent( sceneId, selfId,targetId )
	x899994_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x899994_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 2 then
	BeginEvent(sceneId)
	    AddText(sceneId,"TÑ tuy®t trang hoàn mÛ quan phß½ng phø bän, chü yªu r½i xu¯ng nguyên li®u thång c¤p võ h°n, m²i ngày 3 lßþt, cu¯i cùng thành công ðánh chªt chung cñc BOSS sau không có ngß¶i khä ðÕt ðßþc mµt cái tÑ tuy®t bäo tß½ng. #r#Y chú ý: BOSS kÛ nång hoàn mÛ cùng quan phß½ng gi¯ng nhau, c¦n thân")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
		return
	end

	for i, findId in x899994_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--½ÓÊÜ´ËNPCµÄÈÎÎñ
--**********************************
function x899994_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--¾Ü¾ø´ËNPCµÄÈÎÎñ
--**********************************
function x899994_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--¾Ü¾øÖ®ºó£¬Òª·µ»ØNPCµÄÊÂ¼þÁÐ±í
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			x899994_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--¼ÌÐø£¨ÒÑ¾­½ÓÁËÈÎÎñ£©
--**********************************
function x899994_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--Ìá½»ÒÑ×öÍêµÄÈÎÎñ
--**********************************
function x899994_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--ËÀÍöÊÂ¼þ
--**********************************
function x899994_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- ¶Ô»°´°¿ÚÐÅÏ¢ÌáÊ¾
--**********************************
function x899994_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

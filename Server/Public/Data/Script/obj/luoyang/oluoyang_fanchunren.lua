--LÕc Dß½ngNPC
--·¶´¿ÈÊ
--½¨Á¢°ï»á
--½Å±¾ºÅ
x000030_g_scriptId = 000030

--ËùÓµÓÐtoÕ ðµ ÊÂ¼þIDÁÐ±í
x000030_g_eventList={600000}

--**********************************
--ÊÂ¼þ½»»¥Èë¿Ú
--**********************************
function x000030_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Mu¯n sáng l§p bang hµi thì ðªn tìm tÕi hÕ nhé!")
		AddNumText( sceneId, x000030_g_scriptId, "#GThoát ly Tâm Hoài C¯ Chü", 6, 7413 )
		AddNumText( sceneId, x000030_g_scriptId, "Gi¾i thi®u bang hµi và lãnh ð¸a", 11, 10 )
	
		AddNumText(sceneId,x000030_g_scriptId,"Xem danh møc bang hµi",6,2)	
		if IsShutout( sceneId, selfId, ONOFF_T_GUILD ) == 0 then
			AddNumText(sceneId,x000030_g_scriptId,"Sáng l§p bang hµi",6,1)
		end
		AddNumText(sceneId,x000030_g_scriptId,"Quän lý thông tin hµi viên",6,3)
		AddNumText(sceneId,x000030_g_scriptId,"Xem thông tin bang hµi",6,4)
		if(GetHumanGuildID(sceneId, selfId) ~= -1) then
			if IsShutout( sceneId, selfId, ONOFF_T_CITY ) == 0 then
				AddNumText(sceneId,x000030_g_scriptId,"Ðång ký thành ph¯",6,5)
			end
			if(CityGetSelfCityID(sceneId, selfId) ~= -1) then
				AddNumText(sceneId,x000030_g_scriptId,"Vào thành ph¯ cüa b±n bang",9,6)
			end
		end
		AddNumText(sceneId,x000030_g_scriptId,"Liên quan ðµ ph°n vinh cüa bang phái",11,11)
		AddNumText(sceneId,x000030_g_scriptId,"Gi¾i thi®u Ð°ng Minh",11,12)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000030_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 7413 then
		BeginEvent(sceneId)	
			AddText( sceneId, "Ta có th¬ giúp ngß½i giäi tr× trÕng thái #GTâm Hoài C¯ Chü#W, chi phí s¨ không d­ ch¸u ðâu nhé!" )
			AddText( sceneId, "Chi phí giäi tr× trÕng thái thoát ly bang hµi là #G20.000 KNB#W." )
			AddNumText(sceneId,x000030_g_scriptId,"Ta ð°ng ý",6,74131)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if GetNumText() == 74131 then
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,59) == 0 then
			BeginEvent(sceneId)	
				AddText( sceneId, "Ngß½i không mang trÕng thái #GTâm Hoài C¯ Chü#W." )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if YuanBao(sceneId,selfId,targetId,3,0) < 20000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ngß½i không có ðü s¯ KNB ð¬ giäi tr× trÕng thái." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		YuanBao(sceneId,selfId,targetId,2,20000)
		LuaFnCancelSpecificImpact(sceneId,selfId,59)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent( sceneId )
			AddText( sceneId, "Ðã giäi tr× trÕng thái #GTâm Hoài C¯ Chü#W, ngß½i hãy ðång nh§p lÕi trò ch½i ð¬ hoàn t¤t quá trình." )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() == 10 then
		BeginEvent(sceneId)	
				
			AddText( sceneId, "#{function_help_069}" )
							
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 11 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{Guild_Boom_Help}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end
	if GetNumText() == 12 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{TM_20080331_07}".."#{TM_20080320_02}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end
	local sel = GetNumText();
	for i, eventId in x000030_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId, sel)
	end
end

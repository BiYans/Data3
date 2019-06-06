--L�c D߽ngNPC
--������
--�������
--�ű���
x000030_g_scriptId = 000030

--��ӵ��to� � �¼�ID�б�
x000030_g_eventList={600000}

--**********************************
--�¼��������
--**********************************
function x000030_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Mu�n s�ng l�p bang h�i th� �n t�m t�i h� nh�!")
		AddNumText( sceneId, x000030_g_scriptId, "#GTho�t ly T�m Ho�i C� Ch�", 6, 7413 )
		AddNumText( sceneId, x000030_g_scriptId, "Gi�i thi�u bang h�i v� l�nh �a", 11, 10 )
	
		AddNumText(sceneId,x000030_g_scriptId,"Xem danh m�c bang h�i",6,2)	
		if IsShutout( sceneId, selfId, ONOFF_T_GUILD ) == 0 then
			AddNumText(sceneId,x000030_g_scriptId,"S�ng l�p bang h�i",6,1)
		end
		AddNumText(sceneId,x000030_g_scriptId,"Qu�n l� th�ng tin h�i vi�n",6,3)
		AddNumText(sceneId,x000030_g_scriptId,"Xem th�ng tin bang h�i",6,4)
		if(GetHumanGuildID(sceneId, selfId) ~= -1) then
			if IsShutout( sceneId, selfId, ONOFF_T_CITY ) == 0 then
				AddNumText(sceneId,x000030_g_scriptId,"��ng k� th�nh ph�",6,5)
			end
			if(CityGetSelfCityID(sceneId, selfId) ~= -1) then
				AddNumText(sceneId,x000030_g_scriptId,"V�o th�nh ph� c�a b�n bang",9,6)
			end
		end
		AddNumText(sceneId,x000030_g_scriptId,"Li�n quan � ph�n vinh c�a bang ph�i",11,11)
		AddNumText(sceneId,x000030_g_scriptId,"Gi�i thi�u аng Minh",11,12)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000030_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 7413 then
		BeginEvent(sceneId)	
			AddText( sceneId, "Ta c� th� gi�p ng߽i gi�i tr� tr�ng th�i #GT�m Ho�i C� Ch�#W, chi ph� s� kh�ng d� ch�u ��u nh�!" )
			AddText( sceneId, "Chi ph� gi�i tr� tr�ng th�i tho�t ly bang h�i l� #G20.000 KNB#W." )
			AddNumText(sceneId,x000030_g_scriptId,"Ta �ng �",6,74131)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if GetNumText() == 74131 then
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,59) == 0 then
			BeginEvent(sceneId)	
				AddText( sceneId, "Ng߽i kh�ng mang tr�ng th�i #GT�m Ho�i C� Ch�#W." )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if YuanBao(sceneId,selfId,targetId,3,0) < 20000 then
			BeginEvent( sceneId )
				AddText( sceneId, "Ng߽i kh�ng c� �� s� KNB � gi�i tr� tr�ng th�i." )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		YuanBao(sceneId,selfId,targetId,2,20000)
		LuaFnCancelSpecificImpact(sceneId,selfId,59)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
		BeginEvent( sceneId )
			AddText( sceneId, "�� gi�i tr� tr�ng th�i #GT�m Ho�i C� Ch�#W, ng߽i h�y ��ng nh�p l�i tr� ch�i � ho�n t�t qu� tr�nh." )
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

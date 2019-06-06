--������UI 30,31,103

x600000_g_ScriptId = 600000;
x600000_g_Yinpiao = 40002000

function x600000_OnEnumerate( sceneId, selfId, targetId, sel )
	if( sel == 1 ) then
		GuildCreate(sceneId, selfId, targetId);
	elseif( sel == 2 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId) --����Th�nh ph� ��������
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 103)
		--���ÿͻ��˼�¼NPC��Ϣ����ʾ����
		CityApply(sceneId, selfId)
		GuildList(sceneId, selfId, targetId);
	elseif( sel == 3 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 30)
	elseif( sel == 4 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 31)
	elseif( sel == 5 )then
		local ret = CheckPlayerCanApplyCity(sceneId, selfId);
		if ret==1 then 
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId) --����Th�nh ph� ��������
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 101)
			--���ÿͻ��˼�¼NPC��Ϣ����ʾ����
			CityApply(sceneId, selfId)
		elseif ret==-1 then
			BeginEvent(sceneId)
				AddText(sceneId,"Bang h�i �� c� th�nh th�!")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	elseif( sel == 6 ) then
		--��ng��T�i ����
		local haveImpact = LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113)
		if haveImpact == 1 then
				BeginEvent(sceneId)
					strText = "Xin l�i, c�c h� hi�n gi� � trong tr�ng th�i v�n chuy�n."
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
		end
		-- ������������ng����ng�С���Ʊ��C�i n�y ����,�оͲ���ʹ������to� � ����
		if GetItemCount(sceneId, selfId, x600000_g_Yinpiao)>=1  then
			BeginEvent( sceneId )
				AddText( sceneId, "  Tr�n ng߶i c�c h� c� ng�n phi�u, �ang ch�y tr�n n�! Ta kh�ng th� gi�p c�c h�" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		CityMoveTo(sceneId, selfId)
	end
	
end
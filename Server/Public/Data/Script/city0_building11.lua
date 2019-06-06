--����NPC
--�Ƶ�

x805018_g_scriptId=805018
x805018_g_BuildingID13 = 2

--**********************************
--�¼��������
--**********************************
function x805018_OnDefaultEvent( sceneId, selfId,targetId )

	local guildid 		= GetHumanGuildID(sceneId,selfId)
	local cityguildid = GetCityGuildID(sceneId, selfId, sceneId)
	local strText
	
	if(guildid ~= cityguildid) then
		BeginEvent(sceneId)
			strText = "Kh�ng ph�i l� ng߶i c�a ta, kh�ng ti�p r��u th�t."
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	BeginEvent(sceneId)
		strText = "Ta l� ch� ti�m r��u, h�a kh� sinh t�i, m�i ng߶i �u l� ng߶i quen, c� vi�c g� li�n quan �n n�u n߾ng ��ng ng�i �n t�m ta."
		AddText(sceneId,strText);
		AddNumText(sceneId,x805018_g_scriptId,"Th�c �n m�n n�u n߾ng",7,6)
		AddNumText(sceneId,x805018_g_scriptId,"Gi�i thi�u ti�m r��u",11,7)
		--life ����������������Ӧ�����ѡ��
		CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "AddCityLifeAbilityOpt",sceneId, selfId, x805018_g_scriptId,x805018_g_BuildingID13,8)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--�¼��б�ѡ��һ��
--**********************************
function x805018_OnEventRequest( sceneId, selfId, targetId, eventId )
	--����������������Ӧ�����ѡ��
	if eventId ~= x805018_g_scriptId then
		CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnDefaultEvent",sceneId, selfId, targetId, eventId, x805018_g_scriptId, x805018_g_BuildingID13 )
		return
	end
	
	if GetNumText() == 1 then
		CityBuildingChange(sceneId, selfId, x805018_g_BuildingID13, 0)
	elseif GetNumText() == 2 then
		CityBuildingChange(sceneId, selfId, x805018_g_BuildingID13, 1)
	elseif GetNumText() == 3 then
		CityBuildingChange(sceneId, selfId, x805018_g_BuildingID13, 2)
	elseif GetNumText() == 4 then
		CityBuildingChange(sceneId, selfId, x805018_g_BuildingID13, 3)
	elseif GetNumText() == 5 then
		CityBuildingChange(sceneId, selfId, x805018_g_BuildingID13, 4)
	elseif GetNumText() == 6 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId) --���ó����̵����
			UICommand_AddInt(sceneId,x805018_g_BuildingID13)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 104)
	elseif GetNumText() == 7 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{City_Intro_JiuSi}" )		
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 8 then
		BeginEvent(sceneId)
		--life ����������������Ӧ�����ѡ��
		CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnEnumerate",sceneId, selfId, targetId, x805018_g_BuildingID13 )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
	end
end
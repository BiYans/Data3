--ľ����

--�ű���
x002010_g_scriptId = 002010

--��ӵ��to� � �¼�ID�б�
x002010_g_eventList={200099,200100}
--x002010_g_eventList={201402,201501,201812,201911}
x002010_g_lifeeventList={713506,713565,713605}

x002010_g_RSMissionId = 101
x002010_g_ActivateMissionId = 8			-- ��������
x002010_g_SongXinScriptId = 006668		-- ����
x002010_g_ShaGuaiScriptId = 006666		-- ɱ��
x002010_g_XunWuScriptId = 006667		-- Ѱ��

x002010_g_RoundStorytelling = {
		[0] = { misIndex = { 1038036 }, script = x002010_g_XunWuScriptId },
		[1] = { misIndex = { 1038037 }, script = x002010_g_XunWuScriptId },
		[2] = { misIndex = { 1038038 }, script = x002010_g_XunWuScriptId },
		[3] = { misIndex = { 1038039 }, script = x002010_g_XunWuScriptId },
		[4] = { misIndex = { 1038040 }, script = x002010_g_XunWuScriptId }}

x002010_g_ShaGuaiMissionList = {
		[0] = { misIndex = { 1038020, 1038021 }, script = x002010_g_XunWuScriptId },
		[1] = { misIndex = { 1038022, 1038023 }, script = x002010_g_XunWuScriptId },
		[2] = { misIndex = { 1038024, 1038025 }, script = x002010_g_XunWuScriptId },
		[3] = { misIndex = { 1038026, 1038027 }, script = x002010_g_XunWuScriptId },
		[4] = { misIndex = { 1038028, 1038029 }, script = x002010_g_XunWuScriptId },
		[5] = { misIndex = { 1038030, 1038031 }, script = x002010_g_XunWuScriptId },
		[6] = { misIndex = { 1038032, 1038033 }, script = x002010_g_XunWuScriptId },
		[7] = { misIndex = { 1038034, 1038035 }, script = x002010_g_XunWuScriptId }}

x002010_g_SongXinMissionList = {
		[0] = { misIndex = { 1010243 }, script = x002010_g_SongXinScriptId },
		[1] = { misIndex = { 1010244 }, script = x002010_g_SongXinScriptId },
		[2] = { misIndex = { 1010245 }, script = x002010_g_SongXinScriptId },
		[3] = { misIndex = { 1010246 }, script = x002010_g_SongXinScriptId },
		[4] = { misIndex = { 1010247 }, script = x002010_g_SongXinScriptId },
		[5] = { misIndex = { 1010248 }, script = x002010_g_SongXinScriptId },
		[6] = { misIndex = { 1010249 }, script = x002010_g_SongXinScriptId },
		[7] = { misIndex = { 1010250 }, script = x002010_g_SongXinScriptId }}

x002010_g_awardItems = {
	[1] = { odds = 50, itemIdxs = { [30] = 10410004, [40] = 10410005, [50] = 10410006, [60] = 10410007, [70] = 10410008, [80] = 10410009, [90] = 10410010, [100] = 10410011 } },
	[2] = { odds = 50, itemIdxs = { [30] = 10410012, [40] = 10410013, [50] = 10410014, [60] = 10410015, [70] = 10410016, [80] = 10410017, [90] = 10410018, [100] = 10410019 } },
	[3] = { odds = 50, itemIdxs = { [30] = 10410020, [40] = 10410021, [50] = 10410022, [60] = 10410023, [70] = 10410024, [80] = 10410025, [90] = 10410026, [100] = 10410027 } },
	[4] = { odds = 50, itemIdxs = { [30] = 10410028, [40] = 10410029, [50] = 10410030, [60] = 10410031, [70] = 10410032, [80] = 10410033, [90] = 10410034, [100] = 10410035 } }}

--С���ö������ݱ�....��50��ʱC�n ����С���ö���....
x002010_g_awardItemsNew = {

	[1] = { odds = 50, itemIdxs = { [30] = 10410082, [40] = 10410083, [50] = 10410084, [60] = 10410085, [70] = 10410086, [80] = 10410087, [90] = 10410088, [100] = 10410089 } },
	[2] = { odds = 50, itemIdxs = { [30] = 10410090, [40] = 10410091, [50] = 10410092, [60] = 10410093, [70] = 10410094, [80] = 10410095, [90] = 10410096, [100] = 10410097 } },

}

--**********************************
--�¼��б�
--**********************************
function x002010_UpdateEventList( sceneId, selfId, targetId )
  local PlayerName = GetName( sceneId, selfId )
	local PlayerSex = GetSex( sceneId, selfId )
	if PlayerSex == 0 then
		PlayerSex = " c� n߽ng"
	else
		PlayerSex = " c�c h�"
	end

	BeginEvent( sceneId )
		AddText( sceneId, "  " .. PlayerName .. PlayerSex .. ", th�t h�m m� c�c h� ���c nh� ng�a th�n bay kh�p n�i, ta � ��i L� ��i m�i, th�y sao m� ch�n ng�n qu�." )

		local missionIndex = GetScriptIDByMissionID( sceneId, selfId, x002010_g_RSMissionId )
		if missionIndex ~= -1 then
			local missionName = TGetMissionName( missionIndex )
			if missionName ~= "Nhi�m v� M�c Uy�n Thanh" and IsMissionHaveDone( sceneId, selfId, x002010_g_ActivateMissionId ) > 0 then
				AddNumText( sceneId, x002010_g_scriptId, "Nhi�m v� M�c Uy�n Thanh", 3, 1 )
			end
		elseif IsMissionHaveDone( sceneId, selfId, x002010_g_ActivateMissionId ) > 0 then
			AddNumText( sceneId, x002010_g_scriptId, "#GNhi�m v� MUT - List 1", 3, 74131 )
			AddNumText( sceneId, x002010_g_scriptId, "#GNhi�m v� MUT - List 2", 3, 74132 )
			AddNumText( sceneId, x002010_g_scriptId, "#GNhi�m v� MUT - List 3", 3, 74133 )
			AddNumText( sceneId, x002010_g_scriptId, "#GNhi�m v� MUT - List 4", 3, 74134 )

			--AddNumText( sceneId, x002010_g_scriptId, "Nhi�m v� M�c Uy�n Thanh", 3, 1 )
		end
				
		for _, eventId in x002010_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
		end
	
		for i, eventId in x002010_g_lifeeventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
		--zchw
		AddNumText(sceneId, x002010_g_scriptId, "#{TED_90305_1}", 11, 2);
				
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��������
--**********************************
function x002010_OnDefaultEvent( sceneId, selfId, targetId )
	x002010_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--�¼��б�ѡ��m�t ��
--**********************************
function x002010_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 74131 then
		BeginEvent( sceneId )
			AddText( sceneId, "List Q 1" )
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038036", 3, 741311);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038037", 3, 741312);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038038", 3, 741313);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038039", 3, 741314);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038040", 3, 741315);
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 741311 and GetNumText() <= 741315 then
		local misid = GetNumText() - 741310 + 1038035;
		CallScriptFunction( x002010_g_XunWuScriptId, "OnDefaultEvent", sceneId, selfId, targetId, misid )
	end
	
	if GetNumText() == 74132 then
		BeginEvent( sceneId )
			AddText( sceneId, "List Q 2" )
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038020", 3, 741321);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038022", 3, 741322);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038024", 3, 741323);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038026", 3, 741324);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038028", 3, 741325);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038030", 3, 741326);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038032", 3, 741327);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038034", 3, 741328);
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 741321 and GetNumText() <= 741328 then
		local misid = (GetNumText() - 741321)*2 + 1038020;
		CallScriptFunction( x002010_g_XunWuScriptId, "OnDefaultEvent", sceneId, selfId, targetId, misid )
	end
	
	if GetNumText() == 74133 then
		BeginEvent( sceneId )
			AddText( sceneId, "List Q 3" )
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038021", 3, 741331);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038023", 3, 741332);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038025", 3, 741333);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038027", 3, 741334);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038029", 3, 741335);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038031", 3, 741336);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038033", 3, 741337);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1038035", 3, 741338);
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 741331 and GetNumText() <= 741338 then
		local misid = (GetNumText() - 741331)*2 + 1038021;
		CallScriptFunction( x002010_g_XunWuScriptId, "OnDefaultEvent", sceneId, selfId, targetId, misid )
	end
	
	if GetNumText() == 74134 then
		BeginEvent( sceneId )
			AddText( sceneId, "List Q 4" )
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010243", 3, 741343);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010244", 3, 741344);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010245", 3, 741345);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010246", 3, 741346);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010247", 3, 741347);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010248", 3, 741348);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010249", 3, 741349);
			AddNumText(sceneId, x002010_g_scriptId, "Nhi�m v� MUT - 1010250", 3, 741350);
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 741343 and GetNumText() <= 741350 then
		local misid = GetNumText() - 741340 + 1010240;
		CallScriptFunction( x002010_g_SongXinScriptId, "OnDefaultEvent", sceneId, selfId, targetId, misid )
	end
	
	for _, findId in x002010_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
	
	for i, findId in x002010_g_lifeeventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002010_g_scriptId )
			return
		end
	end

	local num = GetNumText()
	if num == 1 then										-- ľ��������
		if IsHaveMission( sceneId, selfId, x002010_g_RSMissionId ) > 0 then
			x002010_NotifyFailBox( sceneId, selfId, targetId, "   �, c�c h� c� nhi�m v� ch�a ho�n th�nh, ��i ho�n th�nh xong l�i �n t�m t�i h�." )
			return
		end
		
		-- �����ng��Th�a m�n���񼤻�����
		if IsMissionHaveDone( sceneId, selfId, x002010_g_ActivateMissionId ) <= 0 then
			return 0
		end
		
		--���½���to� � ľ����������ng����ng����50����
		--begin modified by zhangguoxin 090208
		local nDayCount = GetMissionData(sceneId, selfId, MD_JQXH_MUWANQING_LIMITI)
		local nCount = 		floor(nDayCount/100000)
		local nTime = 		mod(nDayCount,100000)
		--local nDayTime = 	floor(nTime/100)	--��m�t �ν�����to� � ʱ��(����)
		local nDayTime = 	nTime								--��m�t �ν�����to� � ʱ��(����)
		
		--local CurTime = GetHourTime()				--��ǰʱ��
		local CurTime = GetDayTime()					--��ǰʱ��
		--local CurDaytime = floor(CurTime/100)	--��ǰʱ��(��)
		local CurDaytime = CurTime							--��ǰʱ��(��)
		--end modified by zhangguoxin 090208

		if nDayTime == CurDaytime  then -- ����
			if nCount >= 50  then
				BeginEvent( sceneId )
					AddText( sceneId, "  H�m nay c�c h� �� g�p qu� nhi�u chuy�n phi�n ph�c r�i, th�t xin l�i, ng�y mai m�i l�m phi�n c�c h� n�a v�y!" )
				EndEvent( sceneId )
				DispatchEventList( sceneId, selfId, targetId )
				return
			end
			
		else		-- ��to� � m�t ��
			SetMissionData(sceneId, selfId, MD_JQXH_MUWANQING_LIMITI, 0)
		end

		local mission = x002010_g_RoundStorytelling[0];
		local relation = GetMissionData(sceneId, selfId, MD_RELATION_MUWANQING)
		local playerlevel = GetLevel( sceneId, selfId )
		
		-- ��c�p���޴���
		if playerlevel >= 100 then
			playerlevel = 90
		end
		
		playerlevel = floor( playerlevel / 10 ) * 10
		local randtype = random(100)
		if randtype <= 60 then
			if playerlevel == 20 then
				mission = x002010_g_SongXinMissionList[0];
			elseif playerlevel == 30 then
				mission = x002010_g_SongXinMissionList[1];
			elseif playerlevel == 40 then
				mission = x002010_g_SongXinMissionList[2];
			elseif playerlevel == 50 then
				mission = x002010_g_SongXinMissionList[3];
			elseif playerlevel == 60 then
				mission = x002010_g_SongXinMissionList[4];
			elseif playerlevel == 70 then
				mission = x002010_g_SongXinMissionList[5];
			elseif playerlevel == 80 then
				mission = x002010_g_SongXinMissionList[6];
			elseif playerlevel == 90 then
				mission = x002010_g_SongXinMissionList[7];
			end
		elseif randtype <= 90 then
			if playerlevel == 20 then
				mission = x002010_g_ShaGuaiMissionList[0];
			elseif playerlevel == 30 then
				mission = x002010_g_ShaGuaiMissionList[1];
			elseif playerlevel == 40 then
				mission = x002010_g_ShaGuaiMissionList[2];
			elseif playerlevel == 50 then
				mission = x002010_g_ShaGuaiMissionList[3];
			elseif playerlevel == 60 then
				mission = x002010_g_ShaGuaiMissionList[4];
			elseif playerlevel == 70 then
				mission = x002010_g_ShaGuaiMissionList[5];
			elseif playerlevel == 80 then
				mission = x002010_g_ShaGuaiMissionList[6];
			elseif playerlevel == 90 then
				mission = x002010_g_ShaGuaiMissionList[7];
			end
		elseif randtype <= 100 then
			if relation <= 999 then
				mission = x002010_g_RoundStorytelling[0];
			elseif relation <= 1999 then
				mission = x002010_g_RoundStorytelling[1];
			elseif relation <= 3999 then
				mission = x002010_g_RoundStorytelling[2];
			elseif relation <= 6499 then
				mission = x002010_g_RoundStorytelling[3];
			elseif relation <= 9999 then
				mission = x002010_g_RoundStorytelling[4];
			end
		end
				
		CallScriptFunction( mission.script, "OnDefaultEvent", sceneId, selfId, targetId, mission.misIndex[ random( getn(mission.misIndex) ) ] )		
		
		return
		
	elseif num == 2 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{MWQ_227_1}");
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
			
	end
end

--**********************************
--Ti�p th���NPCto� � ����
--**********************************
function x002010_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for _, findId in x002010_g_eventList do
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
--�ܾ���NPCto� � ����
--**********************************
function x002010_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--�ܾ�֮��,ҪTr� v�NPCto� � �¼��б�
	for _, findId in x002010_g_eventList do
		if missionScriptId == findId then
			x002010_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--����(�Ѿ���������)
--**********************************
function x002010_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for _, findId in x002010_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--�ύ������to� � ����
--**********************************
function x002010_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for _, findId in x002010_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--�����¼�
--**********************************
function x002010_OnDie( sceneId, selfId, killerId )
end

--**********************************
--ѭ�������ύto� � �¼�
--��ȫ,Ҫ��ʱע��
--��ֻ��Ѱ��,ɱ��,��������֧��
--**********************************
function x002010_OnModEvent_Submit(sceneId, selfId, targetId, missionIndex)
	
	local mdLocation, _, _ = TGetRelationShipAwardInfo( missionIndex );
	if not mdLocation or mdLocation ~= MD_RELATION_MUWANQING then
		return 0;
	end
	
	local value = GetMissionData( sceneId, selfId, mdLocation);
	if not value or value < 1000 then
		x002010_NotifyMessage(sceneId, selfId, targetId);
		return 0;
	end
	
	local count = GetMissionData(sceneId, selfId, MD_MUWANQING_TUERDUO_COUNT);
	if not count then
		return 0;
	end
	
	count = count + 1;
	SetMissionData(sceneId, selfId, MD_MUWANQING_TUERDUO_COUNT, count);
	
	local testValue = 50;
	local hit = 0;
	for i = 0, 16 do
		if testValue == count then
			hit = 1;
			break;
		end
		testValue = testValue * 2;
	end

	if hit ~= 1 then
		x002010_NotifyMessage(sceneId, selfId,targetId)
		return 0;
	end

	--�����ng��50��(��m�t �θ�)....�������m�t c�iС���ö���....���������ͨ�ö���....
	if count == 50 then
		x002010_GiveSmallRabbitEar( sceneId, selfId )
	else
		x002010_GiveRabbitEar( sceneId, selfId )
	end

	return 1;
end

--**********************************
-- �Ի�������Ϣ��ʾ
--**********************************
function x002010_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

function x002010_NotifyMessage(sceneId, selfId,targetId )		
		local nDayCount = GetMissionData(sceneId, selfId, MD_JQXH_MUWANQING_LIMITI)
		local nCount = 		floor(nDayCount/100000)
		--���ÿ���10�η���������Ϣ
		if(nCount == 10 or nCount == 20 or nCount == 30 or nCount == 40 )	then
				local msg = format("#B[%s]: #W#{_INFOUSR%s} #{MWQ_090217_07}", GetSceneName(sceneId), GetName(sceneId, selfId))
				LuaFnNpcChat(sceneId, targetId, 1, msg)		
		end
end

--**********************************
-- ����ͨ�ö���....
--**********************************
function x002010_GiveRabbitEar( sceneId, selfId )

	local totalOdds = 0;
	local item;
	for _, item in x002010_g_awardItems do
		totalOdds = totalOdds  + item.odds;
	end
	
	if totalOdds < 1 then
		return 0;
	end

	local selItem;
	local randValue = random(1, totalOdds);
	randValue = randValue - 1;
	for _, item in x002010_g_awardItems do
		if item.odds >= randValue then
			selItem = item;
			break;
		end
		randValue = randValue - item.odds;
	end
	
	if not selItem then
		return 0;
	end
	
	local level = GetLevel(sceneId, selfId);
	if not level then
		return 0;
	end
	if level >= 110 then
		level = 100
	end
	
	local idx = floor(level / 10);
	idx = idx * 10;
	
	local itemIdx = selItem.itemIdxs[idx];
	if not itemIdx then
		return 0;
	end
	
	local itemAddPos;
	BeginAddItem(sceneId);
		itemAddPos = AddItem(sceneId, itemIdx, 1);
	ret = EndAddItem(sceneId, selfId);
	if ret and ret > 0 then
		AddItemListToHuman(sceneId, selfId);
		local str = format("%d", itemIdx);
		local myGuid = LuaFnObjId2Guid(sceneId, selfId);
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_MWQ_TUERDUO, myGuid, str);
		local selfName = GetName(sceneId, selfId);
		local itemTransfer;
		if itemAddPos then
			itemTransfer = GetItemTransfer(sceneId, selfId, itemAddPos);
		end

		if itemTransfer and selfName then
			local msg = format("#{MWQ_227_3}#W#{_INFOUSR%s}#{MWQ_227_4}#{_INFOMSG%s}#{MWQ_227_5}", selfName, itemTransfer);
			BroadMsgByChatPipe(sceneId, selfId, msg, 4);
		end
	end

end

--**********************************
-- ��С���ö���....
--**********************************
function x002010_GiveSmallRabbitEar( sceneId, selfId )

	local totalOdds = 0;
	local item;
	for _, item in x002010_g_awardItemsNew do
		totalOdds = totalOdds  + item.odds;
	end
	
	if totalOdds < 1 then
		return 0;
	end

	local selItem;
	local randValue = random(1, totalOdds);
	randValue = randValue - 1;
	for _, item in x002010_g_awardItemsNew do
		if item.odds >= randValue then
			selItem = item;
			break;
		end
		randValue = randValue - item.odds;
	end
	
	if not selItem then
		return 0;
	end
	
	local level = GetLevel(sceneId, selfId);
	if not level then
		return 0;
	end
	if level >= 110 then
		level = 100
	end
	
	local idx = floor(level / 10);
	idx = idx * 10;
	
	local itemIdx = selItem.itemIdxs[idx];
	if not itemIdx then
		return 0;
	end
	
	local itemAddPos;
	BeginAddItem(sceneId);
		itemAddPos = AddItem(sceneId, itemIdx, 1);
	ret = EndAddItem(sceneId, selfId);
	if ret and ret > 0 then
		AddItemListToHuman(sceneId, selfId);
		local str = format("%d", itemIdx);
		local myGuid = LuaFnObjId2Guid(sceneId, selfId);
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_MWQ_TUERDUO, myGuid, str);
		local selfName = GetName(sceneId, selfId);
		local itemTransfer;
		if itemAddPos then
			itemTransfer = GetItemTransfer(sceneId, selfId, itemAddPos);
		end

		if itemTransfer and selfName then
			local msg = format("#{MWQ_227_3}#W#{_INFOUSR%s}#{MWQ_227_6}#{_INFOMSG%s}#{MWQ_227_7}", selfName, itemTransfer);
			BroadMsgByChatPipe(sceneId, selfId, msg, 4);
		end
	end

end

--**********************************
--�ύ��Ʒ
--**********************************
function x002010_OnMissionCheck( sceneId, selfId, targetId, scriptId, index1, index2, index3, indexpet, missionIndex )
	
	for i, eventId in x002010_g_XunWuScriptId do
		
		if eventId == scriptId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, targetId, scriptId, index1, index2, index3, indexpet, missionIndex )
			return 1
		end
	end
		
end

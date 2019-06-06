-- mod_event
-- ���������to� � m�t Щͨ�����ݴ�������

x006672_g_MaxRelationship = 9999

x006672_g_MinRelationship = 0

x006672_g_MenpaiMission = 800
x006672_g_MenpaiMission_1 = 810

-- 30~50c�p�����ʧ����_Nhi�m v� s� m�n
x006672_g_MissionLimitList	=	{StartIdx = 1018729, EndIdx = 1018818}
x006672_g_AcceptMissionSceneId = {9, 11, 10, 12, 15, 16, 13, 17, 14}

--**********************************
-- �о��¼�
--**********************************
function x006672_DoEnumerate( sceneId, selfId, targetId, missionIndex )
	
	local missionId = TGetMissionIdByIndex( missionIndex )

	-- ��������ɹ�C�i n�y �����Ҹ�������ngѭ������
	if IsMissionHaveDone( sceneId, selfId, missionId ) > 0
	 and TIsMissionRoundable( missionIndex ) ~= 1 then
		return
	end

	local missionName = TGetMissionName( missionIndex )

	-- �ж����to� � ������ng����ng��Ti�p th�C�i n�y ����,���������ʾ,�����Ͳ���ʾ
	local PrevMis = { -1, -1, -1 }
	local nLevel = 0
	nLevel, PrevMis[1], PrevMis[2], PrevMis[3] = TGetCheckInfo( missionIndex )

	if nLevel > GetLevel( sceneId, selfId ) then
		return
	end

	if PrevMis[1] == x006672_g_MenpaiMission then
		if PrevMis[2] ~= LuaFnGetMenPai(sceneId, selfId)  then
			return
		end
		
	elseif PrevMis[1] == x006672_g_MenpaiMission_1 then
		local bOk = 0
		for i=801, 809   do
			if IsMissionHaveDone( sceneId, selfId, i ) >= 0 then
				bOk = 1
			end
		end
		if bOk == 0  then
			return
		end
		
	else
		for i = 1, getn( PrevMis ) do
			if PrevMis[i] > 0 then
				if IsMissionHaveDone( sceneId, selfId, PrevMis[i] ) <= 0 then
					return
				end
			end
		end
	end

	-- �Ѿ�����������
	if IsHaveMission( sceneId, selfId, missionId ) > 0 then
		local completeNpcScene, completeNpcName = TGetCompleteNpcInfo( missionIndex )
		if GetName( sceneId, targetId ) == completeNpcName then
			-- ��ng��Ϊѭ������
			if TIsMissionRoundable( missionIndex ) == 1 then
				TAddNumText( sceneId, missionIndex, missionName, 4, -1 )
			else
				TAddNumText( sceneId, missionIndex, missionName, 2, -1 )
			end
			TDispatchEventList( sceneId, selfId, targetId )
		end
	else
		local acceptNpcScene, acceptNpcName = TGetAcceptNpcInfo( missionIndex )
		if GetName( sceneId, targetId ) == acceptNpcName then
			-- ��ng��Ϊѭ������
			if TIsMissionRoundable( missionIndex ) == 1 then
				TAddNumText( sceneId, missionIndex, missionName, 3, -1 )
			else
				TAddNumText( sceneId, missionIndex, missionName, 1, -1 )
			end
			TDispatchEventList( sceneId, selfId, targetId )
		end
	end
end

--**********************************
-- ���Ti�p th�����
--**********************************
function x006672_CheckAccept( sceneId, selfId, missionIndex )
	
	local nLevel = LuaFnGetLevel( sceneId, selfId )
	local PrevMis = { -1, -1, -1 }
	local limitLevel = 0
	limitLevel, PrevMis[1], PrevMis[2], PrevMis[3] = TGetCheckInfo( missionIndex )

	if nLevel < limitLevel then
		x006672_NotifyFailBox( sceneId, selfId, -1, "    Kinh nghi�m giang h� c�a c�c h�, s� kh�ng chi�n th�ng ���c, ��i" .. limitLevel .. "Sau khi th�ng c�p t�i t�m ta" )
		return 0
	end
	
	if missionIndex >= x006672_g_MissionLimitList.StartIdx and missionIndex <= x006672_g_MissionLimitList.EndIdx then
		local nMenpai = LuaFnGetMenPai(sceneId, selfId)
		
		if nMenpai < 0 or nMenpai > 8 then
			x006672_NotifyFailBox( sceneId, selfId, -1, "#{YD_20080421_222}" )
			return 0
		elseif x006672_g_AcceptMissionSceneId[nMenpai+1] ~= sceneId then
			x006672_NotifyFailBox( sceneId, selfId, -1, "#{YD_20080421_223}" )
			return 0
		end
	end
	
	if PrevMis[1] == x006672_g_MenpaiMission then
		if PrevMis[2] == LuaFnGetMenPai(sceneId, selfId)  then
			return 1
		end
		return 0
	end
	
	if PrevMis[1] == x006672_g_MenpaiMission_1 then
		local bOk = 0
		for i=801, 809   do
			if IsMissionHaveDone( sceneId, selfId, i ) >= 0 then
				bOk = 1
			end
		end
		if bOk == 1  then
			return 1
		end
		return 0
	end

	for i = 1, getn( PrevMis ) do
		if PrevMis[i] > 0 then
			if IsMissionHaveDone( sceneId, selfId, PrevMis[i] ) <= 0 then
				return 0
			end
		end
	end

	local mdLocation, value, prompt = TGetLimitedTimeInfo( missionIndex )
	if mdLocation ~= -1 and value > 0 then
		local ApprovedTime = GetMissionData( sceneId, selfId, mdLocation )
		if ApprovedTime > LuaFnGetCurrentTime( ) then
			x006672_NotifyFailBox( sceneId, selfId, -1, prompt )
			return 0
		end
	end

	return 1
end

--**********************************
-- ȡ �i�mm�t c�i��̬to� � �Ի���ʽ���ַ���
-- missionIndex: ����T�i �������to� � ���
-- duologueContent: �Ի�����,�����ng�̶��Ի�,��ֱ��Tr� v�
--**********************************
function x006672_GetRandomDuologue( sceneId, missionIndex, duologueContent )
	
	-- ����Ի�C�n ����ѡ��m�t ����
	local duologueList = {}
	-- �����ѡ����ȡ����,���� duologueList ����
	gsub( duologueContent, "(%d+)", function(n) tinsert( %duologueList, tonumber(n) ) end )

	-- print( duologueList )

	if getn( duologueList ) < 1 then
		return ""
	end

	-- ����to� � �ӿڶ�����to� � ����,ȡ��ĳ��Ի�
	duologueContent = TGetDuologue( sceneId, duologueList[random( getn(duologueList) )] )

	-- print( duologueContent )

	if type( duologueContent ) ~= "string" then
		return ""
	end

	return duologueContent
end

--**********************************
-- ��ʽ��m�t c�i��̬to� � �Ի���ʽ���ַ���
-- ��ʽ����to� � ģʽ
--	%R: ���to� � ��ν( c�c h�,��Ů)
--	%n: NPC to� � T�n
--	%l: NPC to� � λ���Լ�����
--	%g: NPC to� � �Ա�(��,��)
--	%i: ������Ʒto� � T�n
--**********************************
function x006672_FormatDuologue( sceneId, selfId, duologueContent, npcId, itemIndex, itemList )
	
	if not duologueContent or type( duologueContent ) ~= "string" then
		return ""
	end

	-- �ԶԻ����б����滻
	if strfind( duologueContent, "%R", 1, 1 ) then
		local PlayerGender = GetSex( sceneId, selfId )
		local rank

		if PlayerGender == 0 then
			rank = "N� hi�p"
		else
			rank = " c�c h�"
		end

		duologueContent = gsub( duologueContent, "%%R", rank )
	end

	-- ����� NPC
	if npcId and npcId ~= -1 then
		local nNpcId, strNpcName, strNpcScene, nPosX, nPosZ, strNPCDesc, nScene, nGender, nLevel, nType
			= GetNpcInfoByNpcId(sceneId, npcId )

		local strGender = {}
		strGender[0] = " N�ng "
		strGender[1] = " H�n "

		-- �ԶԻ����б����滻
		-- if strfind( duologueContent, "%l", 1, 1 ) then
		--	duologueContent = gsub( duologueContent, "%%l", "" )
		-- end

		if strfind( duologueContent, "%n", 1, 1 ) then
			local newLocation
			if nPosX > 0 and nPosZ > 0 then
				newLocation = strNpcScene .. strNpcName ..  "(" .. nPosX .. ", " .. nPosZ .. ")"
			else
				newLocation = strNpcScene .. strNpcName
			end

			duologueContent = gsub( duologueContent, "%%n", newLocation )
		end

		if strfind( duologueContent, "%g", 1, 1 ) then
			duologueContent = gsub( duologueContent, "%%g", strGender[nGender] )
		end
	end

	if itemIndex and itemIndex ~= -1 and itemList == "" then
		local nitemId, strItemName, strItemDesc = GetItemInfoByItemId( itemIndex )

		if strfind( duologueContent, "%i", 1, 1 ) then
			duologueContent = gsub( duologueContent, "%%i", strItemName )
		end
	end
	
	if itemList ~= "" then
		
		if strfind( duologueContent, "%i", 1, 1 ) then
			duologueContent = gsub( duologueContent, "%%i", itemList )
		end
		-- PrintStr("duologueContent ="..duologueContent)
	end

	return duologueContent
end

--**********************************
-- ��ʾ������
--**********************************
function x006672_DisplayBonus( sceneId, missionIndex, selfId )
	
	local itemCt
	local a = { { id = -1, ct = 0 }, { id = -1, ct = 0 }, { id = -1, ct = 0 }, { id = -1, ct = 0 }, { id = -1, ct = 0 } }
	itemCt, a[1].id, a[1].ct, a[2].id, a[2].ct, a[3].id, a[3].ct, a[4].id, a[4].ct, a[5].id, a[5].ct = TGetAwardItem( missionIndex )

	for i = 1, itemCt do
		if a[i].id > 0 then
			AddItemBonus( sceneId, a[i].id, a[i].ct )
		end
	end

	itemCt, a[1].id, a[1].ct, a[2].id, a[2].ct, a[3].id, a[3].ct, a[4].id, a[4].ct, a[5].id, a[5].ct = TGetRadioItem( missionIndex )

	for i = 1, itemCt do
		if a[i].id > 0 then
			AddRadioItemBonus( sceneId, a[i].id, a[i].ct )
		end
	end

	itemCt, a[1].id, a[1].ct, a[2].id, a[2].ct, a[3].id, a[3].ct = TGetHideItem( missionIndex )

	for i = 1, itemCt do
		if a[i].id > 0 then
			AddRandItemBonus( sceneId, a[i].id, a[i].ct )
		end
	end

	local awardMoney = TGetAwardMoney( missionIndex )
	
	if (missionIndex >= 1010243 and missionIndex <= 1010250) or
		 (missionIndex >= 1010402 and missionIndex <= 1010409) or
		 (missionIndex >= 1018000 and missionIndex <= 1018033) or
		 (missionIndex >= 1018050 and missionIndex <= 1018084) or
		 (missionIndex >= 1018100 and missionIndex <= 1018155) or
		 (missionIndex >= 1018200 and missionIndex <= 1018235) or
		 (missionIndex >= 1018300 and missionIndex <= 1018311) or
		 (missionIndex >= 1018350 and missionIndex <= 1018352) or
		 (missionIndex >= 1018360 and missionIndex <= 1018367) or
		 (missionIndex >= 1018400 and missionIndex <= 1018455) or
		 (missionIndex >= 1018500 and missionIndex <= 1018504) or
		 (missionIndex >= 1018530 and missionIndex <= 1018541) or
		 (missionIndex >= 1018560 and missionIndex <= 1018566) or
		 (missionIndex >= 1038000 and missionIndex <= 1038040) or
		 (missionIndex >= 1038110 and missionIndex <= 1038114) or
		 (missionIndex >= 1039000 and missionIndex <= 1039011) or
		 (missionIndex >= 1039020 and missionIndex <= 1039024) or
		 (missionIndex >= 1039100 and missionIndex <= 1039104) or
		 (missionIndex >= 1038100 and missionIndex <= 1038104) or
		 (missionIndex >= 1039110 and missionIndex <= 1039126) or
		 (missionIndex >= 1039200 and missionIndex <= 1039211) or
		 (missionIndex >= 1039250 and missionIndex <= 1039259) or
		 (missionIndex >= 1039300 and missionIndex <= 1039312) or
		 (missionIndex >= 1039350 and missionIndex <= 1039357) or
		 (missionIndex >= 1039400 and missionIndex <= 1039412) or
		 (missionIndex >= 1039450 and missionIndex <= 1039462) or
		 (missionIndex >= 1039500 and missionIndex <= 1039511) or
		 (missionIndex >= 1039550 and missionIndex <= 1039554) or
		 (missionIndex >= 1039600 and missionIndex <= 1039612) or
		 (missionIndex >= 1009000 and missionIndex <= 1009027) or
		 (missionIndex >= 1009100 and missionIndex <= 1009103) then
		
		-- ʹ������Լ�to� � ��c�p������ �i�m��to� � ����
		awardMoney = GetLevel(sceneId, selfId) * 18 -101
	end
	
	AddMoneyBonus( sceneId, awardMoney )
end

--**********************************
-- ������ϵֵ
--**********************************
function x006672_RewardRelationShip( sceneId, selfId, missionIndex, targetId )
	
	local mdLocation, value, prompt = TGetRelationShipAwardInfo( missionIndex )
	if mdLocation == -1 or value < 1 then
		return
	end

	local szNpcName = ""
	
	local nLimitiIndex = -1
	
	if mdLocation == MD_RELATION_MUWANQING 				then
		szNpcName = "M�c Uy�n Thanh "
		nLimitiIndex = MD_JQXH_MUWANQING_LIMITI
	elseif mdLocation == MD_RELATION_ZHONGLING  	then
		szNpcName = "Chung Linh "
		nLimitiIndex = MD_JQXH_ZHONGLING_LIMITI
	elseif mdLocation == MD_RELATION_DUANYANQING  then
		szNpcName = "�o�n Di�n Kh�nh "
		nLimitiIndex = MD_JQXH_DUANYANQING_LIMITI
	elseif mdLocation == MD_RELATION_DUANYU  			then
		szNpcName = "�o�n D�"
		nLimitiIndex = MD_JQXH_DUANYU_LIMITI
	elseif mdLocation == MD_RELATION_AZHU			    then
		szNpcName = "A Ch�u"
		nLimitiIndex = MD_JQXH_AZHU_LIMITI
	elseif mdLocation == MD_RELATION_ABI				  then
		szNpcName = "A B�ch "
		nLimitiIndex = MD_JQXH_ABI_LIMITI
	elseif mdLocation == MD_RELATION_WANGYUYAN	  then
		szNpcName = "V߽ng Ng� Y�n"
		nLimitiIndex = MD_JQXH_WANGYUYAN_LIMITI
	elseif mdLocation == MD_RELATION_XIAOFENG	    then
		szNpcName = "Ti�u Phong"
		nLimitiIndex = MD_JQXH_XIAOFENG_LIMITI
	elseif mdLocation == MD_RELATION_AZI				  then
		szNpcName = "A T� "
		nLimitiIndex = MD_JQXH_AZI_LIMITI
	elseif mdLocation == MD_RELATION_MURONGFU	    then
		szNpcName = "M� Dung Ph�c "
		nLimitiIndex = MD_JQXH_MURONGFU_LIMITI
	elseif mdLocation == MD_RELATION_XUZHU			  then
		szNpcName = "H� Tr�c"
		nLimitiIndex = MD_JQXH_XUZHU_LIMITI
	elseif mdLocation == MD_RELATION_JIUMOZHI	    then
		szNpcName = "C�u Ma Tr�"
		nLimitiIndex = MD_JQXH_JIUMOZHI_LIMITI
	elseif mdLocation == MD_RELATION_YINCHUAN	    then
		szNpcName = "Ng�n Xuy�n C�ng Ch�a"
		nLimitiIndex = MD_JQXH_YINCHUAN_LIMITI
	end
	
	-- ��¼��C�i n�y Npc����Ho�n t�t nhi�m v�to� � ����
	if nLimitiIndex >= MD_JQXH_MUWANQING_LIMITI and 
			nLimitiIndex <= MD_JQXH_YINCHUAN_LIMITI  then
		--begin modified by zhangguoxin 090207
		local nDayCount = GetMissionData(sceneId, selfId, nLimitiIndex)
		local nCount = 		floor(nDayCount/100000)
		local nTime = 		mod(nDayCount,100000)
		--local nDayTime = 	floor(nTime/100)	--��m�t �ν�����to� � ʱ��(����)
		nDayTime = 	nTime											--��m�t �ν�����to� � ʱ��(����)
		
		local CurTime = GetDayTime()						--��ǰʱ��
		local CurDaytime = CurTime					--��ǰʱ��
		--local CurDaytime = floor(CurTime/100)	--��ǰʱ��(��)
		--end modified by zhangguoxin 090207
		if nDayTime == CurDaytime  then
			nCount = nCount + 1
		else
			nCount = 1
		end
		
		local nNewDayCount = nCount*100000 + CurTime	
		SetMissionData(sceneId, selfId, nLimitiIndex, nNewDayCount)
	end

	local oldValue = GetMissionData( sceneId, selfId, mdLocation )
	value = value + oldValue
	if value > x006672_g_MaxRelationship then
		value = x006672_g_MaxRelationship
	else
		BeginEvent(sceneId)
			local strText = prompt
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		-- �����Һ�Npc�ﵽm�t c�i��to� � ��ϵ,������
		if value == 1000  then
			BeginEvent(sceneId)
				local strText = "C�c h� v�#G" .. szNpcName .. "#W Quan h� �� ph�t tri�n �n m�c#Yk�t giao qu�n t�#W."
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			-- ���ʼ�֪ͨ���
			LuaFnSendSystemMail(sceneId, GetName(sceneId,selfId), strText)
			
		elseif value == 2000  then
			BeginEvent(sceneId)
				local strText = "C�c h� v�#G" .. szNpcName .. "#W Quan h� �� ph�t tri�n �n m�c#Y k�t giao th�n thi�t#W."
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			-- ���ʼ�֪ͨ���
			LuaFnSendSystemMail(sceneId, GetName(sceneId,selfId), strText)
			
		elseif value == 4000  then
			BeginEvent(sceneId)
				local strText = "C�c h� v�#G" .. szNpcName .. "#W Quan h� �� ph�t tri�n �n m�c#Y b�t b�i chi giao#W."
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			-- ���ʼ�֪ͨ���
			LuaFnSendSystemMail(sceneId, GetName(sceneId,selfId), strText)
			
		elseif value == 6500  then
			BeginEvent(sceneId)
				local strText = "C�c h� v�#G" .. szNpcName .. "#WQuan h� �� ph�t tri�n �n m�c#Yb�ng h�u v�o sinh ra t�#W."
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			-- ���ʼ�֪ͨ���
			LuaFnSendSystemMail(sceneId, GetName(sceneId,selfId), strText)
			
			-- ��H� th�ng����
			local szPlayer = GetName(sceneId, selfId)

			if GetName(sceneId,targetId) == "M�c Uy�n Thanh "    then
				local szBroad = "@*;SrvMsg;" .. "juqing_xunhuan_system_muwanqing" ..";"..szPlayer..";"..szPlayer
				BroadMsgByChatPipe(sceneId, selfId, szBroad, 4)
				
			elseif GetName(sceneId,targetId) == "Gia Lu�t ��i Th�ch "    then
				local szBroad = "@*;SrvMsg;" .. "juqing_xunhuan_system_xiaofeng" ..";"..szPlayer..";"..szPlayer
				BroadMsgByChatPipe(sceneId, selfId, szBroad, 4)
				
			end
		end
	end

	SetMissionData( sceneId, selfId, mdLocation, value )
	---ľ�����ϵֵͳ�� dengxx
		if mdLocation == MD_RELATION_MUWANQING then
		   AuditRelationPoint(sceneId,selfId,value,"MD_RELATION_MUWANQING")
		end
	
	-- hongyu ,�ż���,T�i ������+Kinh nghi�m�ͽ�Ǯ����
	-- ����to� � ��Ǯ��Kinh nghi�mֵ,ֻ���Լ�to� � ��c�p�й�
	-- ��c�p������ng���ڵ���20,С�ڵ���PlayerMaxLevel
	-- ��ʽ  Kinh nghi�m= ��c�p*80 - 326
	-- 			 ��Ǯ= ��c�p*18 - 101
	local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local nLevel = GetLevel(sceneId, selfId)
	
	if nLevel>=20 and nLevel<=PlayerMaxLevel   then
		local nExp = nLevel*80 - 326
		local nMoney = nLevel*18 - 101
		
		local missionId = TGetMissionIdByIndex( missionIndex )
		AddMoney( sceneId, selfId, nMoney, missionId, missionIndex )
		AddExp(sceneId, selfId, nExp)
	end
	
	-- ����ͳ��
	local missionName = TGetMissionName( missionIndex )
	LuaFnAuditQuest( sceneId, selfId, missionName)
	
	if value > oldValue then
		Msg2Player( sceneId, selfId, prompt, MSG2PLAYER_PARA )
	end
end

--**********************************
-- �ͷ���ϵֵ
--**********************************
function x006672_PunishRelationShip( sceneId, selfId, missionIndex )
	
	local mdLocation, value, prompt = TGetRelationShipPunishInfo( missionIndex )
	if mdLocation == -1 or value < 1 then
		return
	end

	local oldValue = GetMissionData( sceneId, selfId, mdLocation )
	value = oldValue - value
	if value < x006672_g_MinRelationship then
		value = x006672_g_MinRelationship
	end

	SetMissionData( sceneId, selfId, mdLocation, value )
	---ľ�����ϵֵͳ�� dengxx
		if mdLocation == MD_RELATION_MUWANQING then
		   AuditRelationPoint(sceneId,selfId,value,"MD_RELATION_MUWANQING")
		end

	if value < oldValue then
		Msg2Player( sceneId, selfId, prompt, MSG2PLAYER_PARA )
	end
end

--**********************************
-- �ͷ�,���ƽ�����ʱ��
--**********************************
function x006672_AcceptTimeLimit( sceneId, selfId, missionIndex )
	
	local mdLocation, value, prompt = TGetLimitedTimeInfo( missionIndex )
	if mdLocation == -1 or value < 1 then
		return
	end
	
	-- 20 ����Ӧ�ò��ᳬ�� 2 ^ 31
	SetMissionData( sceneId, selfId, mdLocation, LuaFnGetCurrentTime( ) + value )
end

--**********************************
-- �Ի�������Ϣ��ʾ
--**********************************
function x006672_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
x741303_g_scriptId = 741303

function x741303_PlayerLoginGame(sceneId,selfId)
	BeginEvent( sceneId )
		AddText( sceneId, "Ch�o m�ng "..GetName(sceneId,selfId).." �n v�i th� gi�i #GThi�n Long B�t B�#W!")
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end

function x741303_ReceiveXscript(sceneId,selfId,XScript,param1)
	if XScript == 100 then
		x741303_TargetPlayerGUID(sceneId,selfId,param1)
	end
	
	if XScript == 201 then
		x741303_OpenTargetWuhun(sceneId,selfId)
	end
	
	if XScript == 202 then
		x741303_OpenOtherRide(sceneId,selfId)
	end
	
	if XScript == 203 then
		x741303_BossList(sceneId,selfId,param1)
	end
	
	if XScript == 204 then
		x741303_BossDetail(sceneId,selfId,value)
	end
end

--100
function x741303_TargetPlayerGUID(sceneId,selfId,GUID)
	local TargetPlayer = LuaFnGuid2ObjId(sceneId, GUID)
	SetMissionData(sceneId,selfId,TARGETPLAYER,TargetPlayer)
end

--201
function x741303_OpenTargetWuhun(sceneId,selfId)
	local VoHon_Author = "";
	local targetId = GetMissionData(sceneId,selfId,TARGETPLAYER)
	
	local ItemID = LuaFnGetItemTableIndexByIndex( sceneId, targetId, 108 );
	if ItemID >= 10308001 and ItemID <= 10308004 then
		local Author, szAuthor = LuaFnGetItemCreator(sceneId, targetId, 108);
		if szAuthor then
			VoHon_Author = szAuthor;
		else
			VoHon_Author = "*---0010000050010---------------------------------------0";
		end
	else
		VoHon_Author = "NoWuhun";
	end
	
	BeginUICommand(sceneId)
		UICommand_AddString(sceneId,VoHon_Author)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,20111213)
end

--202
function x741303_OpenOtherRide(sceneId,selfId)
	local targetId = GetMissionData(sceneId,selfId,TARGETPLAYER)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,GetMissionData(sceneId,targetId,CHARRIDER[1]))
		UICommand_AddInt(sceneId,GetMissionData(sceneId,targetId,CHARRIDER[2]))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,74130202)
end

--203
function x741303_BossList(sceneId,selfId,param1)
	local BossList = {}
	BossList[1] = {"M�c D�ng B�"}
	BossList[2] = {"C�ng H�n �nh T��ng"}
	BossList[3] = {"Th�n X� Nga"}
	BossList[4] = {"B�ng Ph�ch Ng�n N�m"}
	BossList[5] = {"B�ch Minh Kh�i"}
	BossList[6] = {"huy�n K�ch Kim Cang"}
	BossList[7] = {"M�ng C� Chu C�p"}
	BossList[8] = {"Qu� Ki�m"}
	BossList[9] = {"Nham Ma"}
	BossList[10] = {"еc Tri Ty Th� V߽ng"}
	BossList[11] = {"Xu�n Th�p Tam N߽ng"}
	BossList[12] = {"Ph�c иa Ma"}
	BossList[13] = {"Minh T߾ng"}
	BossList[14] = {"B�ch Ъ �m �nh"}
	BossList[15] = {"Huy�t �m Cu�ng �ao"}
	BossList[16] = {"X�ch Ti�u Ho� H�n"}
	BossList[17] = {"M�c D�ng B�"}
	BossList[18] = {"C�ng H�n �nh T��ng"}
	BossList[19] = {"Th�n X� Nga"}
	BossList[20] = {"B�ng Ph�ch Ng�n N�m"}
	BossList[21] = {"B�ch Minh Kh�i"}
	BossList[22] = {"huy�n K�ch Kim Cang"}
	BossList[23] = {"M�ng C� Chu C�p"}
	BossList[24] = {"Qu� Ki�m"}
	BossList[25] = {"Nham Ma"}
	BossList[26] = {"еc Tri Ty Th� V߽ng"}
	BossList[27] = {"Xu�n Th�p Tam N߽ng"}
	BossList[28] = {"Ph�c иa Ma"}
	BossList[29] = {"Minh T߾ng"}
	BossList[30] = {"B�ch Ъ �m �nh"}
	BossList[31] = {"Huy�t �m Cu�ng �ao"}
	BossList[32] = {"X�ch Ti�u Ho� H�n"}
	BossList[33] = {"X�ch Ti�u Ho� H�n"}
	BossList[34] = {"X�ch Ti�u Ho� H�n"}
	BossList[35] = {"X�ch Ti�u Ho� H�n"}
	BossList[36] = {"X�ch Ti�u Ho� H�n"}
	BossList[37] = {"X�ch Ti�u Ho� H�n"}
	BossList[38] = {"X�ch Ti�u Ho� H�n"}
	BossList[39] = {"X�ch Ti�u Ho� H�n"}
	BossList[40] = {"X�ch Ti�u Ho� H�n"}
	BossList[41] = {"X�ch Ti�u Ho� H�n"}
	BossList[42] = {"X�ch Ti�u Ho� H�n"}
	BossList[43] = {"X�ch Ti�u Ho� H�n"}
	BossList[44] = {"X�ch Ti�u Ho� H�n"}
	BossList[45] = {"X�ch Ti�u Ho� H�n"}
	
	if param1 == 0 then
		value = 1;
	else
		value = param1;
	end
	local Start = value * 15 - 14;
	local End = value * 15
	BeginUICommand(sceneId)
		for i = Start, End do
			UICommand_AddString(sceneId,BossList[i][1])
		end
	EndUICommand(sceneId)
	if param1 == 0 then
		DispatchUICommand(sceneId,selfId,1001001)
	else
		DispatchUICommand(sceneId,selfId,1001002)
	end
end

--204
function x741303_BossDetail(sceneId,selfId,value)

	BeginUICommand(sceneId)
		UICommand_AddString(sceneId,"String 1")
		UICommand_AddString(sceneId,"String 2")
		UICommand_AddString(sceneId,"String 3")
		UICommand_AddString(sceneId,"String 4")
		UICommand_AddString(sceneId,"String 5")
		UICommand_AddString(sceneId,"String 6")
		UICommand_AddString(sceneId,"String 7")
		UICommand_AddString(sceneId,"String 8")
		UICommand_AddString(sceneId,"String 9")
		UICommand_AddString(sceneId,"String 10")
		UICommand_AddString(sceneId,"String 11")
		UICommand_AddString(sceneId,"String 12")
		UICommand_AddString(sceneId,"String 13")
		UICommand_AddString(sceneId,"String 14")
		UICommand_AddString(sceneId,"String 15")
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,1001003)
end

function x741303_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
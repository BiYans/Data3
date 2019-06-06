x741303_g_scriptId = 741303

function x741303_PlayerLoginGame(sceneId,selfId)
	BeginEvent( sceneId )
		AddText( sceneId, "Chào m×ng "..GetName(sceneId,selfId).." ðªn v¾i thª gi¾i #GThiên Long Bát Bµ#W!")
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
	BossList[1] = {"Mµc Dûng Bá"}
	BossList[2] = {"Công H°n Änh Tßþng"}
	BossList[3] = {"Th¥n Xí Nga"}
	BossList[4] = {"Bång Phách Ngàn Nåm"}
	BossList[5] = {"BÕch Minh Kh·i"}
	BossList[6] = {"huy«n Kích Kim Cang"}
	BossList[7] = {"Mãng C± Chu Cáp"}
	BossList[8] = {"QuÖ Kiªm"}
	BossList[9] = {"Nham Ma"}
	BossList[10] = {"Ðµc Tri Ty Thù Vß½ng"}
	BossList[11] = {"Xuân Th§p Tam Nß½ng"}
	BossList[12] = {"Phøc Ð¸a Ma"}
	BossList[13] = {"Minh Tß¾ng"}
	BossList[14] = {"BÕch Ðª Âm Änh"}
	BossList[15] = {"Huyªt †m Cu°ng Ðao"}
	BossList[16] = {"Xích Tiêu Hoä H°n"}
	BossList[17] = {"Mµc Dûng Bá"}
	BossList[18] = {"Công H°n Änh Tßþng"}
	BossList[19] = {"Th¥n Xí Nga"}
	BossList[20] = {"Bång Phách Ngàn Nåm"}
	BossList[21] = {"BÕch Minh Kh·i"}
	BossList[22] = {"huy«n Kích Kim Cang"}
	BossList[23] = {"Mãng C± Chu Cáp"}
	BossList[24] = {"QuÖ Kiªm"}
	BossList[25] = {"Nham Ma"}
	BossList[26] = {"Ðµc Tri Ty Thù Vß½ng"}
	BossList[27] = {"Xuân Th§p Tam Nß½ng"}
	BossList[28] = {"Phøc Ð¸a Ma"}
	BossList[29] = {"Minh Tß¾ng"}
	BossList[30] = {"BÕch Ðª Âm Änh"}
	BossList[31] = {"Huyªt †m Cu°ng Ðao"}
	BossList[32] = {"Xích Tiêu Hoä H°n"}
	BossList[33] = {"Xích Tiêu Hoä H°n"}
	BossList[34] = {"Xích Tiêu Hoä H°n"}
	BossList[35] = {"Xích Tiêu Hoä H°n"}
	BossList[36] = {"Xích Tiêu Hoä H°n"}
	BossList[37] = {"Xích Tiêu Hoä H°n"}
	BossList[38] = {"Xích Tiêu Hoä H°n"}
	BossList[39] = {"Xích Tiêu Hoä H°n"}
	BossList[40] = {"Xích Tiêu Hoä H°n"}
	BossList[41] = {"Xích Tiêu Hoä H°n"}
	BossList[42] = {"Xích Tiêu Hoä H°n"}
	BossList[43] = {"Xích Tiêu Hoä H°n"}
	BossList[44] = {"Xích Tiêu Hoä H°n"}
	BossList[45] = {"Xích Tiêu Hoä H°n"}
	
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
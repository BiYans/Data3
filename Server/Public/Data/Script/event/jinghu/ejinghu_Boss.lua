-- 005116
-- ¾µºşBOSS

x005116_g_PreTimeHour_1 = 0
x005116_g_PreTimeHour_2 = 0
x005116_g_PreTimeHour_3 = 0

x005116_g_Boss ={
								{x=141,z=96,	b1=885,b2=887,b3=889,n1="B¡c Häi H²n Giang Ti¬u Long",n2="B¡c Häi xu¤t ğµng Ti¬u Giao",n3="B¡c Häi phiên giang Ti¬u Th§n"},
								{x=250,z=98,	b1=885,b2=887,b3=889,n1="Ğông Häi H²n Giang Ti¬u Long",n2="Ğông Häi xu¤t ğµng Ti¬u Giao",n3="Ğông Häi phiên giang Ti¬u Th§n"},
								
								{x=206,z=253,	b1=885,b2=887,b3=889,n1="Nam Häi H²n Giang Ti¬u Long",n2="Nam Häi xu¤t ğµng Ti¬u Giao",n3="Nam Häi phiên giang Ti¬u Th§n"},
								{x=101,z=256,	b1=885,b2=887,b3=889,n1="Tây Häi H²n Giang Ti¬u Long",n2="Tây Häi xu¤t ğµng Ti¬u Giao",n3="Tây Häi phiên giang Ti¬u Th§n"},
								
								{x=139,z=133,	b1=884,b2=886,b3=888,n1="H²n Giang Long",n2="Xu¤t Ğµng Giao",n3="Phiên Giang Th§n"}}

-- Ê¹ÓÃÒ»Ğ©±¾³¡¾°Î¨Ò»µÄÈ«¾Ö±äÁ¿À´±£´æÊı¾İ

-- ÕâÀïµÄ¼ÆÊ±Æ÷ÔÚµÚÒ»Íæ¼Ò½øÈë±¾³¡¾°ºó×Ô¼ºÆô¶¯£¬ÓÀ²»¹Ø±Õ¡£
function x005116_OnSceneTimer(sceneId)

	local nHour = GetQuarterTime()
	
	local nQuarter = mod(nHour,100);

	if nQuarter > 16 and nQuarter < 40 then
		return
	end

	if GetMinute() == 45 then
		if nHour == x005116_g_PreTimeHour_1 then
			return
		end

		x005116_g_PreTimeHour_1 = nHour
		
		if x005116_IsHaveMonster( sceneId, "B¡c Häi H²n Giang Ti¬u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 1, 10 )
		end
		if x005116_IsHaveMonster( sceneId, "Ğông Häi H²n Giang Ti¬u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 2, 11 )
		end
	end

	
	if GetMinute() == 50 then
		if nHour == x005116_g_PreTimeHour_2  then
			return
		end

		x005116_g_PreTimeHour_2 = nHour
		
		if x005116_IsHaveMonster( sceneId, "Nam Häi H²n Giang Ti¬u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 3, 12 )
		end
		if x005116_IsHaveMonster( sceneId, "Tây Häi H²n Giang Ti¬u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 4, 13 )
		end
	end
	

	if GetMinute() == 55 then
		if nHour == x005116_g_PreTimeHour_3 then
			return
		end
		
		x005116_g_PreTimeHour_3 = nHour
		
		if x005116_IsHaveMonster( sceneId, "H²n Giang Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 5, 14 )
		end
	end
end

function x005116_IsHaveMonster( sceneId, MonsterName )
	local nMonsterNum = GetMonsterCount(sceneId)
	local bHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, nMonsterId) == MonsterName then
			bHaveMonster = 1
		end
	end
	return bHaveMonster
end

function x005116_UpDateMonster( sceneId, nIndex, nGroupId )

	local nMonsterNum = GetMonsterCount(sceneId)
	local bHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, nMonsterId) == x005116_g_Boss[nIndex].n1 then
			LuaFnDeleteMonster(sceneId, nMonsterId)
		end
		
		if GetName(sceneId, nMonsterId) == x005116_g_Boss[nIndex].n2 then
			LuaFnDeleteMonster(sceneId, nMonsterId)
		end
		
		if GetName(sceneId, nMonsterId) == x005116_g_Boss[nIndex].n3 then
			LuaFnDeleteMonster(sceneId, nMonsterId)
		end
	end
	
	local nMonId
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b1, x005116_g_Boss[nIndex].x, x005116_g_Boss[nIndex].z, 19, 197, 005117)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n1)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H²n Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b2, x005116_g_Boss[nIndex].x+2, x005116_g_Boss[nIndex].z, 19, 198, 005118)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n2)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H²n Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b3, x005116_g_Boss[nIndex].x-2, x005116_g_Boss[nIndex].z, 19, 199, 005119)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n3)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H²n Giang Long")
	
	if nIndex == 5 then		
		local str = "H²n Giang Long thüy t£c T¥m Dß½ng Giang ğang tung hoành th¯ng lînh thuµc hÕ xu¤t hi®n · Kính H°! Xin các v¸ anh hùng hãy nhanh chóng ği tiêu di®t!"
		BroadMsgByChatPipe(sceneId, -1, str, 4)
	end
end


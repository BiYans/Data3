-- 005116
-- ����BOSS

x005116_g_PreTimeHour_1 = 0
x005116_g_PreTimeHour_2 = 0
x005116_g_PreTimeHour_3 = 0

x005116_g_Boss ={
								{x=141,z=96,	b1=885,b2=887,b3=889,n1="B�c H�i H�n Giang Ti�u Long",n2="B�c H�i xu�t �ng Ti�u Giao",n3="B�c H�i phi�n giang Ti�u Th�n"},
								{x=250,z=98,	b1=885,b2=887,b3=889,n1="��ng H�i H�n Giang Ti�u Long",n2="��ng H�i xu�t �ng Ti�u Giao",n3="��ng H�i phi�n giang Ti�u Th�n"},
								
								{x=206,z=253,	b1=885,b2=887,b3=889,n1="Nam H�i H�n Giang Ti�u Long",n2="Nam H�i xu�t �ng Ti�u Giao",n3="Nam H�i phi�n giang Ti�u Th�n"},
								{x=101,z=256,	b1=885,b2=887,b3=889,n1="T�y H�i H�n Giang Ti�u Long",n2="T�y H�i xu�t �ng Ti�u Giao",n3="T�y H�i phi�n giang Ti�u Th�n"},
								
								{x=139,z=133,	b1=884,b2=886,b3=888,n1="H�n Giang Long",n2="Xu�t еng Giao",n3="Phi�n Giang Th�n"}}

-- ʹ��һЩ������Ψһ��ȫ�ֱ�������������

-- ����ļ�ʱ���ڵ�һ��ҽ��뱾�������Լ������������رա�
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
		
		if x005116_IsHaveMonster( sceneId, "B�c H�i H�n Giang Ti�u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 1, 10 )
		end
		if x005116_IsHaveMonster( sceneId, "��ng H�i H�n Giang Ti�u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 2, 11 )
		end
	end

	
	if GetMinute() == 50 then
		if nHour == x005116_g_PreTimeHour_2  then
			return
		end

		x005116_g_PreTimeHour_2 = nHour
		
		if x005116_IsHaveMonster( sceneId, "Nam H�i H�n Giang Ti�u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 3, 12 )
		end
		if x005116_IsHaveMonster( sceneId, "T�y H�i H�n Giang Ti�u Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 4, 13 )
		end
	end
	

	if GetMinute() == 55 then
		if nHour == x005116_g_PreTimeHour_3 then
			return
		end
		
		x005116_g_PreTimeHour_3 = nHour
		
		if x005116_IsHaveMonster( sceneId, "H�n Giang Long" ) == 0 then
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
	SetCharacterTitle(sceneId, nMonId, "H�n Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b2, x005116_g_Boss[nIndex].x+2, x005116_g_Boss[nIndex].z, 19, 198, 005118)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n2)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H�n Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b3, x005116_g_Boss[nIndex].x-2, x005116_g_Boss[nIndex].z, 19, 199, 005119)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n3)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H�n Giang Long")
	
	if nIndex == 5 then		
		local str = "H�n Giang Long th�y t�c T�m D߽ng Giang �ang tung ho�nh th�ng l�nh thu�c h� xu�t hi�n � K�nh H�! Xin c�c v� anh h�ng h�y nhanh ch�ng �i ti�u di�t!"
		BroadMsgByChatPipe(sceneId, -1, str, 4)
	end
end


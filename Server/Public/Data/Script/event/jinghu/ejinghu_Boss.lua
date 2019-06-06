-- 005116
-- 镜湖BOSS

x005116_g_PreTimeHour_1 = 0
x005116_g_PreTimeHour_2 = 0
x005116_g_PreTimeHour_3 = 0

x005116_g_Boss ={
								{x=141,z=96,	b1=885,b2=887,b3=889,n1="B H鋓 H瞡 Giang Ti瑄 Long",n2="B H鋓 xu 鸬ng Ti瑄 Giao",n3="B H鋓 phi阯 giang Ti瑄 Th"},
								{x=250,z=98,	b1=885,b2=887,b3=889,n1="恤ng H鋓 H瞡 Giang Ti瑄 Long",n2="恤ng H鋓 xu 鸬ng Ti瑄 Giao",n3="恤ng H鋓 phi阯 giang Ti瑄 Th"},
								
								{x=206,z=253,	b1=885,b2=887,b3=889,n1="Nam H鋓 H瞡 Giang Ti瑄 Long",n2="Nam H鋓 xu 鸬ng Ti瑄 Giao",n3="Nam H鋓 phi阯 giang Ti瑄 Th"},
								{x=101,z=256,	b1=885,b2=887,b3=889,n1="T鈟 H鋓 H瞡 Giang Ti瑄 Long",n2="T鈟 H鋓 xu 鸬ng Ti瑄 Giao",n3="T鈟 H鋓 phi阯 giang Ti瑄 Th"},
								
								{x=139,z=133,	b1=884,b2=886,b3=888,n1="H瞡 Giang Long",n2="Xu 械ng Giao",n3="Phi阯 Giang Th"}}

-- 使用一些本场景唯一的全局变量来保存数据

-- 这里的计时器在第一玩家进入本场景后自己启动，永不关闭。
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
		
		if x005116_IsHaveMonster( sceneId, "B H鋓 H瞡 Giang Ti瑄 Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 1, 10 )
		end
		if x005116_IsHaveMonster( sceneId, "恤ng H鋓 H瞡 Giang Ti瑄 Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 2, 11 )
		end
	end

	
	if GetMinute() == 50 then
		if nHour == x005116_g_PreTimeHour_2  then
			return
		end

		x005116_g_PreTimeHour_2 = nHour
		
		if x005116_IsHaveMonster( sceneId, "Nam H鋓 H瞡 Giang Ti瑄 Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 3, 12 )
		end
		if x005116_IsHaveMonster( sceneId, "T鈟 H鋓 H瞡 Giang Ti瑄 Long" ) == 0 then
			x005116_UpDateMonster( sceneId, 4, 13 )
		end
	end
	

	if GetMinute() == 55 then
		if nHour == x005116_g_PreTimeHour_3 then
			return
		end
		
		x005116_g_PreTimeHour_3 = nHour
		
		if x005116_IsHaveMonster( sceneId, "H瞡 Giang Long" ) == 0 then
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
	SetCharacterTitle(sceneId, nMonId, "H瞡 Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b2, x005116_g_Boss[nIndex].x+2, x005116_g_Boss[nIndex].z, 19, 198, 005118)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n2)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H瞡 Giang Long")
	
	nMonId = LuaFnCreateMonster(sceneId, x005116_g_Boss[nIndex].b3, x005116_g_Boss[nIndex].x-2, x005116_g_Boss[nIndex].z, 19, 199, 005119)
	SetCharacterName(sceneId, nMonId, x005116_g_Boss[nIndex].n3)
	SetMonsterGroupID(sceneId, nMonId, nGroupId)
	SetCharacterTitle(sceneId, nMonId, "H瞡 Giang Long")
	
	if nIndex == 5 then		
		local str = "H瞡 Giang Long th鼀 t T D呓ng Giang 餫ng tung ho鄋h th痭g l頽h thu礳 h� xu hi畁 � K韓h H�! Xin c醕 v� anh h鵱g h銀 nhanh ch髇g 餴 ti陁 di畉!"
		BroadMsgByChatPipe(sceneId, -1, str, 4)
	end
end


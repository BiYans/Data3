--装备改变外形
--脚本号
x809264_g_ScriptId = 809264

--装备改变外形UI 1010

--**********************************
--列举事件
--**********************************
function x809264_OnEnumerate( sceneId, selfId, targetId )

end


--**********************************
--装备改变外形
--**********************************
function x809264_ChangeVisual( sceneId, selfId, nItemIndex1, nItemIndex2, nVisualIndex)
	local text="Thay 鸨i ngo読 h靚h th鄋h c鬾g"

	local ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex1 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin 穑t v鄌 trang b� c� th� bi猲 h靚h");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex2 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin 穑t v鄌 ph� bi猲 h靚h");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	sy_index = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nItemIndex2 )
	if sy_index ~= 30900004 then
		--变形符
		BeginEvent(sceneId)
		AddText(sceneId,"Thay 鸨i ngo読 h靚h trang b� c ph� bi猲 h靚h");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	money = GetMoney( sceneId, selfId )
	need_money = 50000;
	if money < need_money then
		text="Ngo読 h靚h trang b� l鄊 m課h c #{_MONEY%d}, ng鈔 l唼ng tr阯 ng叨i c醕 h� kh鬾g 瘘"
		text=format( text, need_money )
		BeginEvent(sceneId)
		AddText(sceneId,text);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local ItemNUM = 0;
	local j = 0;
	local ItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nItemIndex1 )
	if ItemID >= 10310001 and ItemID <= 10310060 then
		for i = 10310001, ItemID do
			j = j + 1;
			if j == 3 then
				j = 1;
				ItemNUM = ItemNUM + 1;
			end
		end
		
		if ItemNUM > 20 then
			ItemNUM = ItemNUM - 20;
		end
		if ItemNUM > 10 then
			ItemNUM = ItemNUM - 10;
		end
	end
	
	if ItemID >= 10310061 and ItemID <= 10310180 then
		for i = 10310061, ItemID do
			j = j + 1;
			if j == 4 then
				j = 1;
				ItemNUM = ItemNUM + 1;
			end
		end
		
		if ItemNUM > 30 then
			ItemNUM = ItemNUM - 30;
		end
		if ItemNUM > 20 then
			ItemNUM = ItemNUM - 20;
		end
		if ItemNUM > 10 then
			ItemNUM = ItemNUM - 10;
		end
	end
	
	if nVisualIndex == ItemNUM then
		BeginEvent(sceneId)
		AddText(sceneId,"Trang b� 餫ng gi� ngo読 h靚h n鄖.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local CHLevel = LuaFnIsMarkOrEnhance(sceneId, selfId, nItemIndex1, 2)
	
	if nVisualIndex > ItemNUM then
		for i = 1, nVisualIndex - ItemNUM do
			LuaFnEquipLevelUp(sceneId,selfId,nItemIndex1,nItemIndex1)
		end
	end
	
	if nVisualIndex < ItemNUM then
		for i = 1, 10 - (ItemNUM - nVisualIndex) do
			LuaFnEquipLevelUp(sceneId,selfId,nItemIndex1,nItemIndex1)
		end
	end
	
	local CHLevelAgain = LuaFnIsMarkOrEnhance(sceneId, selfId, nItemIndex1, 2)
	if CHLevel > 0 and CHLevel > CHLevelAgain then
		while CHLevel > CHLevelAgain do
			LuaFnEquipEnhance( sceneId, selfId, nItemIndex1, nItemIndex1)
			CHLevelAgain = LuaFnIsMarkOrEnhance(sceneId, selfId, nItemIndex1, 2)
		end
	end
	
	ret, arg0 = LuaFnChangeVisual( sceneId, selfId, nItemIndex1, nItemIndex2, nVisualIndex )

	if ret == 0 then
		LuaFnCostMoney( sceneId, selfId, need_money )
		LuaFnEraseItem( sceneId, selfId, nItemIndex2 )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	end
	
	if ret == -1 then
		text="Trang b� n鄖 kh鬾g th� bi猲 h靚h"
	end

	if ret == -2 then
		text="Kh鬾g d鵱g 疬㧟 trang b� n鄖"
	end
	
	if ret == -3 then
		text="Kh鬾g d鵱g 疬㧟 ph� bi猲 h靚h"
	end

	if ret == -4 then
		text="Kh鬾g th� thay 鸨i ngo読 h靚h t呓ng 鸢ng"
	end

	if ret == -5 then
		text="Kh鬾g t皀 t読 ngo読 h靚h 疸 thay 鸨i"
	end

	BeginEvent(sceneId)
	AddText(sceneId,text)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

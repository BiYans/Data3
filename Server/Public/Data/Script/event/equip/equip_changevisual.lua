--×°±¸¸Ä±äÍâÐÎ
--½Å±¾ºÅ
x809264_g_ScriptId = 809264

--×°±¸¸Ä±äÍâÐÎUI 1010

--**********************************
--ÁÐ¾ÙÊÂ¼þ
--**********************************
function x809264_OnEnumerate( sceneId, selfId, targetId )

end


--**********************************
--×°±¸¸Ä±äÍâÐÎ
--**********************************
function x809264_ChangeVisual( sceneId, selfId, nItemIndex1, nItemIndex2, nVisualIndex)
	local text="Thay ð±i ngoÕi hình thành công"

	local ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex1 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin ð£t vào trang b¸ có th¬ biªn hình");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex2 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin ð£t vào phù biªn hình");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	sy_index = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nItemIndex2 )
	if sy_index ~= 30900004 then
		--±äÐÎ·û
		BeginEvent(sceneId)
		AddText(sceneId,"Thay ð±i ngoÕi hình trang b¸ c¥n phù biªn hình");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	money = GetMoney( sceneId, selfId )
	need_money = 50000;
	if money < need_money then
		text="NgoÕi hình trang b¸ làm mÕnh c¥n #{_MONEY%d}, ngân lßþng trên ngß¶i các hÕ không ðü"
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
		AddText(sceneId,"Trang b¸ ðang giæ ngoÕi hình này.")
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
		text="Trang b¸ này không th¬ biªn hình"
	end

	if ret == -2 then
		text="Không dùng ðßþc trang b¸ này"
	end
	
	if ret == -3 then
		text="Không dùng ðßþc phù biªn hình"
	end

	if ret == -4 then
		text="Không th¬ thay ð±i ngoÕi hình tß½ng ð°ng"
	end

	if ret == -5 then
		text="Không t°n tÕi ngoÕi hình ðã thay ð±i"
	end

	BeginEvent(sceneId)
	AddText(sceneId,text)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

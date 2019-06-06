--װ���ı�����
--�ű���
x809264_g_ScriptId = 809264

--װ���ı�����UI 1010

--**********************************
--�о��¼�
--**********************************
function x809264_OnEnumerate( sceneId, selfId, targetId )

end


--**********************************
--װ���ı�����
--**********************************
function x809264_ChangeVisual( sceneId, selfId, nItemIndex1, nItemIndex2, nVisualIndex)
	local text="Thay �i ngo�i h�nh th�nh c�ng"

	local ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex1 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin �t v�o trang b� c� th� bi�n h�nh");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	ret = LuaFnIsItemAvailable( sceneId, selfId, nItemIndex2 )
	if ret ~= 1 then
		BeginEvent(sceneId)
		AddText(sceneId,"Xin �t v�o ph� bi�n h�nh");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	sy_index = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nItemIndex2 )
	if sy_index ~= 30900004 then
		--���η�
		BeginEvent(sceneId)
		AddText(sceneId,"Thay �i ngo�i h�nh trang b� c�n ph� bi�n h�nh");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	money = GetMoney( sceneId, selfId )
	need_money = 50000;
	if money < need_money then
		text="Ngo�i h�nh trang b� l�m m�nh c�n #{_MONEY%d}, ng�n l��ng tr�n ng߶i c�c h� kh�ng ��"
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
		AddText(sceneId,"Trang b� �ang gi� ngo�i h�nh n�y.")
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
		text="Trang b� n�y kh�ng th� bi�n h�nh"
	end

	if ret == -2 then
		text="Kh�ng d�ng ���c trang b� n�y"
	end
	
	if ret == -3 then
		text="Kh�ng d�ng ���c ph� bi�n h�nh"
	end

	if ret == -4 then
		text="Kh�ng th� thay �i ngo�i h�nh t߽ng �ng"
	end

	if ret == -5 then
		text="Kh�ng t�n t�i ngo�i h�nh �� thay �i"
	end

	BeginEvent(sceneId)
	AddText(sceneId,text)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

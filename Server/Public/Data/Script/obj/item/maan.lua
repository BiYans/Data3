--300044
-- V:\策划文档\策划文祎o� 鸬 柯冀峁筡2 设计文档\2.1 游戏单位设计\特别物品\人民币物品——马鞍.docx
-- 
-- 

--脚本号
x300044_g_scriptId = 300044
x300044_g_ItemId = 30008006
x300044_g_ItemId01 = 30505215
x300044_g_BuffId = 56

--**********************************
--事件交互入口
--**********************************
function x300044_OnDefaultEvent( sceneId, selfId, nBagIndex )
	--1,检测玩家身上喧ng不喧ng有BUFF
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x300044_g_BuffId) == 1   then
		BeginEvent(sceneId)
			AddText(sceneId,"Ch� c� th� 瘙i sau khi hi畊 qu� mau ch髇g m, m緄 c� th� s� d鴑g.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 
		
	end
	
	local nCurCount = GetBagItemParam(sceneId, selfId, nBagIndex, 4, 2)
	SetBagItemParam(sceneId, selfId, nBagIndex, 8, 2, 5)
	-- 安全检测
	if LuaFnGetItemTableIndexByIndex(sceneId, selfId, nBagIndex) ~= x300044_g_ItemId
		 and LuaFnGetItemTableIndexByIndex(sceneId, selfId, nBagIndex) ~= x300044_g_ItemId01 then
		BeginEvent(sceneId)
			AddText(sceneId,"V ph kh鬾g th� s� d鴑g")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local ret = 1
	if nCurCount >= 4  then
		-- 判断下C醝 n鄖 物品to� 鸬 ID喧ng不喧ng正确先
		ret = EraseItem(sceneId, selfId, nBagIndex)
	else
		SetBagItemParam(sceneId, selfId, nBagIndex, 4, 2, nCurCount+1)
	end

	if ret == 1   then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x300044_g_BuffId, 100 )
		BeginEvent(sceneId)
			AddText(sceneId,"C醕 h� 疸 nh 疬㧟 hi畊 qu� gia t痗 c黙 y阯 ng馻.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
	else
		BeginEvent(sceneId)
			AddText(sceneId,"V ph kh鬾g th� s� d鴑g.")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
	end
	
	LuaFnRefreshItemInfo(sceneId, selfId, nBagIndex)
	
end

function x300044_IsSkillLikeScript( sceneId, selfId)
	return 0
end

--材料加工技能学习

--脚本号
x713538_g_ScriptId = 713538

--学习界面要说to� 鸬 话
x713538_g_MessageStudy = "N猽 c醕 h� 鹫t 皙n c %d 鸢ng th秈 ch竨 b� ra #{_MONEY%d} l� c� th� h鱟 k� n錸g gia c鬾g nguy阯 li畊. C醕 h� quy猼 鸶nh h鱟 kh鬾g ?"

--技能编号
x713538_g_AbilityID = ABILITY_CAILIAOHECHENG

--技能名称
x713538_g_AbilityName = "Gia c鬾g nguy阯 li畊"

--学习本技能to� 鸬 等c限制
x713538_g_LimitLevel = 10

--要让玩家学会to� 鸬 配方列表
x713538_g_PeiFangID = { 399, 400, 401, 402, 403, 404, 405, 406, 407 }


--**********************************
--任务入口函数
--**********************************
function x713538_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--玩家技能to� 鸬 等c
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x713538_g_AbilityID)

	--任务判断

	--判断喧ng否已经学会了材料加工,如果学会了,则提示已经学会了
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"C醕 h� 疸 h鱟 疬㧟"..x713538_g_AbilityName.." k� n錸g");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	
	--如果 餴琺击to� 鸬 喧ng“K� n錸g h鱟 t”(即参数=0)
	if ButtomNum == 0 then
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x713538_g_AbilityID, 1);
		if ret and ret == 1 then
			BeginEvent(sceneId)
			local addText = format(x713538_g_MessageStudy, x713538_g_LimitLevel, demandMoney);
			AddText(sceneId, addText)
			--X醕 nh学习按钮
					AddNumText(sceneId,x713538_g_ScriptId,"T読 h� x醕 鸶nh mu痭 h鱟", 6, 2)
			--Hu� b鲅鞍磁�
					AddNumText(sceneId,x713538_g_ScriptId,"T読 h� ch� mu痭 coi", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif ButtomNum == 2 then			--如果 餴琺击to� 鸬 喧ng“我X醕 nh要学习”
	--检查玩家喧ng否有足够to� 鸬 现金
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x713538_g_AbilityID, 1);
		if ret and ret == 1 then
			if GetMoney(sceneId,selfId) < demandMoney then			
				BeginEvent(sceneId)
					local addText2 = format( "Xin l瞚! S� ti玭 c醕 h� mang theo kh鬾g 瘘, xin h銀 mang theo#{_MONEY%d} r癷 h銀 皙n 疴y h鱟.", demandMoney )
					AddText( sceneId, addText2 );
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--检查玩家等c喧ng否达到要求
			if GetLevel(sceneId,selfId) < x713538_g_LimitLevel then
				BeginEvent(sceneId)
					AddText(sceneId,"衅ng c c黙 ng呓i kh鬾g 瘘");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--删除金钱
			CostMoney(sceneId, selfId, demandMoney)
			--技能蘈inh�1
			SetHumanAbilityLevel(sceneId,selfId,x713538_g_AbilityID,1)
			--让玩家学会所有9c醝配方
			x713538_AddAllPeiFang( sceneId, selfId )
			--T読 npc聊天窗口通知玩家已经学会了
			BeginEvent(sceneId)
				AddText(sceneId,"C醕 h� 疸 h鱟 疬㧟 "..x713538_g_AbilityName.." k� n錸g")
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
		end
	else --如果 餴琺击“我只喧ng来看看”
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--列举事件
--**********************************
function x713538_OnEnumerate( sceneId, selfId, targetId )

		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x713538_g_AbilityID, 1);
		if ret and ret == 1 then
			AddNumText(sceneId,x713538_g_ScriptId,"H鱟 "..x713538_g_AbilityName.." k� n錸g", 12, 0)
		end
		return

end

--**********************************
--检测Ti猵 th跫�
--**********************************
function x713538_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti猵 th�
--**********************************
function x713538_OnAccept( sceneId, selfId, x713538_g_AbilityID )
end


function x713538_AddAllPeiFang( sceneId, selfId )

	for i, pfID in x713538_g_PeiFangID do
	
		if IsPrescrLearned( sceneId, selfId, pfID ) == 0 then
			SetPrescription( sceneId, selfId, pfID, 1 )
		end

	end

end

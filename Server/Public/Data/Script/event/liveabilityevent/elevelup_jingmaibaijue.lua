--经脉百决技能升c

--脚本号
x713592_g_ScriptId = 713592

--此npc可以升到to� 鸬 最高等c
x713592_g_nMaxLevel = 100

--**********************************
--任务入口函数
--**********************************
function x713592_OnDefaultEvent( sceneId, selfId, targetId )
	--玩家技能to� 鸬 等c
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_JINGMAIBAIJUE)
	--玩家经脉百决技能to� 鸬 熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_JINGMAIBAIJUE)
	--任务判断

	--判断喧ng否喧ng姓i L傻茏�,不喧ng姓i L傻茏硬荒苎�
		if GetMenPai(sceneId,selfId) ~= MP_DALI then
			BeginEvent(sceneId)
        		AddText(sceneId,"Ng呓i kh鬾g ph鋓 l� 甬 t� b眓 bang, ta kh鬾g th� d誽 ng呓i");
        	EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--如果还没有学会该生活技能
	if AbilityLevel < 1	then
		BeginEvent(sceneId)
			strText = "Ng呓i v鏽 ch遖 h鱟 k� n錸g Kinh m誧h b醕h quy猼"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果生活技能等c已经超出该npc所能教to� 鸬 范围
	if AbilityLevel >= x713592_g_nMaxLevel then
		BeginEvent(sceneId)
			--[ QUFEI 2007-07-17 15:29 修改 ]
			strText = "Tr呔c m k� n錸g n鄖 ch� c� th� h鱟 皙n c 100"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		--DispatchAbilityInfo(sceneId, selfId, targetId,x713592_g_ScriptId, ABILITY_JINGMAIBAIJUE, LEVELUP_ABILITY_ASSISTANT[AbilityLevel+1].Money, LEVELUP_ABILITY_ASSISTANT[AbilityLevel+1].HumanExp, LEVELUP_ABILITY_ASSISTANT[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY_ASSISTANT[AbilityLevel+1].HumanLevelLimit)
		local tempScriptId = x713592_g_ScriptId;
		local tempAbilityId = ABILITY_JINGMAIBAIJUE;
		local tempAbilityLevel = AbilityLevel + 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			DispatchAbilityInfo(sceneId, selfId, targetId,tempScriptId, tempAbilityId, demandMoney, demandExp, limitAbilityExpShow, limitLevel);
		end
	end
end

--**********************************
--列举事件
--**********************************
function x713592_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等c则不显示选项
		if 1 then
			AddNumText(sceneId,x713592_g_ScriptId,"Ng呓i v鏽 ch遖 h鱟 k� n錸g Kinh m誧h b醕h quy猼", 12, 1)
		end
		return
end

--**********************************
--检测Ti猵 th跫�
--**********************************
function x713592_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti猵 th�
--**********************************
function x713592_OnAccept( sceneId, selfId, ABILITY_JINGMAIBAIJUE )
end

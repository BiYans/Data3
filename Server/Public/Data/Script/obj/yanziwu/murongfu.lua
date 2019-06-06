-- 402254
-- 慕容复

x402254_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9998
}

-- 王语言开始点名的开关
x402254_g_bWangyuyanSpeak = 24
x402254_g_DuanAndWangFlag = 29

--**********************************
-- 自己死亡
--**********************************
function x402254_OnDie( sceneId, selfId, killerId )

	LuaFnNpcChat(sceneId, selfId, 0, "C醕 ng呓i h銀 ch� 痼, ng鄖 n鄖 n錷 sau ta s� t靘 c醕 ng呓i lo m� s痭g h猼 nh鎛g ng鄖 c騨 l読 餴 ha..ha..ha..")

	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)

	-- 停止点名
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 0)
	
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_DuanAndWangFlag, 0)
	
	-- 删除段誉语嫣等人
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "V呓ng Ng� Y阯")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "衞鄋 D�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ba Thi阯 Th誧h")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph誱 Hoa")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ch� V課 L�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "C� 携c Th鄋h")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph� T� Quy")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Chu 衋n Th")
	
	x402254_TipAllHuman( sceneId, "M� Dung Ph鴆 疸 b� 疳nh b読, th鋙 ph誸 Y猲 T� � th鄋h c鬾g, theo l痠 n鄖 tr� l読 Th醝 H�" )
	
	--LuaFnDeleteMonster(sceneId, selfId)
	
	-- 发世界公告
--#w【队长名】#P与#{_BOSS0}单挑，却暗使队友在其身后砸板砖、使绊子、敲闷棍、洒石灰……无所不用，终于将#{_BOSS0}打得大败，落荒而逃，一举攻下了燕子坞。
--#w【队长名】#P率领队友与#{_BOSS0}酣战半日，忽而领悟到武学的真谛，顿时武功暴涨，#{_BOSS0}抵敌不过，只得落荒而逃，燕子坞遂陷。
--#w【队长名】#P在燕子坞调兵遣将，运筹帷幄，在使用了瞒天过海，暗度陈仓等三十六计之后，打得#{_BOSS0}只得使用第三十七计逃之夭夭了。
	
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
		--如果组了队则获取队长的ID....
	local nLeaderId = GetTeamLeader(sceneId, playerID)
	if nLeaderId < 1   then
		nLeaderId = playerID
	end
	local str = ""
	local ran = random(3)
	if ran == 1  then
		str = format("#W#{_INFOUSR%s}#P c鵱g  #{_BOSS0} quy猼 chi猲 醕 li畉 trong y猲 t� �, #{_BOSS0} th m靚h s裞 y猽 kh鬾g 鸶ch l読 鸠i th�, quay 馥u b� ch誽.", GetName(sceneId,nLeaderId))
	elseif ran == 2  then
		str = format("#W#{_INFOUSR%s}#P ch� huy 鸬i ng� c鵱g #{_BOSS0} 疳nh nhau k竎h li畉 n鎍 ng鄖, b瞡g nhi阯 l頽h ng� ch鈔 l� v� h鱟, nh th秈 v� c鬾g t錸g v鱰, #{_BOSS0} 疳nh kh鬾g l読, 疣nh tung m靚h b� ch誽 kh鰅 Y猲 T� �.", GetName(sceneId,nLeaderId))
	else
		str = format("#W#{_INFOUSR%s}#P t読 Y猲 T� � 餴玼 binh khi琻 t呔ng, b鄖 m遳 ngh� k�, s� d鴑g li璾 man thi阯 qu� h鋓, 醡 鸬 tr th呓ng 鹌ng ba m呓i s醬 k� chi h, 疳nh cho #{_BOSS0} ch� ph鋓 s� d鴑g 甬 tam th th k� b� tr痭 m d課g.", GetName(sceneId,nLeaderId))
	end
	
	BroadMsgByChatPipe(sceneId, nLeaderId, str, 4)
	
	
end

--**********************************
-- 心跳
--**********************************
function x402254_OnHeartBeat(sceneId, selfId, nTick)

	-- 当慕容复血量掉到50%的时候，让 王语嫣 点名，同时段誉佯攻
	if(1==LuaFnIsCharacterLiving(sceneId, selfId)) then
		if(1==MonsterAI_GetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat)) then
			--PrintNum(1)
			-- 如果 慕容复 血少于多少，就怎么样子
			if LuaFnGetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak) == 0  then
				if GetHp(sceneId, selfId)*2 <= GetMaxHp(sceneId, selfId) then
					LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 1)
				end
			end
		else
			--PrintNum(2)
		end
	end

--	if(1==LuaFnIsCharacterLiving(sceneId, selfId)) then
--		if(1==MonsterAI_GetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat)) then
--			--Countdown TimerPrepare
--			local TimePrepare = MonsterAI_GetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare)
--			if(0<TimePrepare) then
--				TimePrepare = TimePrepare - nTick;
--				MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, TimePrepare)
--			else
--				local TimeInterval = MonsterAI_GetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval)
--				if(0<TimeInterval) then
--					--Countdown TimerInterval
--					TimeInterval = TimeInterval - nTick;
--					MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, TimeInterval)
--				else
--					MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, x402254_TBL.SkillInterval)
--					local nTarget = LuaFnGetTargetObjID(sceneId, selfId)
--					if(-1~=nTarget) then
--						local posX, posZ = GetWorldPos(sceneId,nTarget)
--						local fDir = 0.0
--						LuaFnUnitUseSkill(sceneId, selfId, x402254_TBL.BossSkill, nTarget, posX, posZ, fDir)			
--						LuaFnNpcChat(sceneId, selfId, 0, "尝尝浔阳江上的烈焰吧！")
--					end
--				end
--			end
--		end
--	end
end

--**********************************
-- 初始化
--**********************************
function x402254_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)
end

--**********************************
-- 杀死玩家
--**********************************
function x402254_OnKillCharacter(sceneId, selfId, targetId)
--	if(-1~=targetId) then
--		local szTarget = GetName(sceneId, targetId)
--		LuaFnNpcChat(sceneId, selfId, 0, szTarget .. "，你就算再厉害十倍，遇上爷爷也只有死路一条！")
--	end
end

--**********************************
-- 进入战斗
--**********************************
function x402254_OnEnterCombat(sceneId, selfId, enmeyId)
	if(0<x402254_TBL.BossBuff) then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x402254_TBL.BossBuff, 0)
	end
	
	-- 进入战斗状态，
	LuaFnNpcChat(sceneId, selfId, 0, "B鱪 v� danh ti瑄 t痶, ai d醡 ph� h鰊g 鹫i k� ph鴆 qu痗 c黙 ta th� h鬽 nay l� ng鄖 gi� c黙 c醕 ng呓i, n絠 疴y s� l� m� ch鬾 c黙 c醕 ng呓i!")
	
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, x402254_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 1)
	
	CallScriptFunction((200060), "Paopao",sceneId, "衞鄋 D�", "Y猲 T� �", "V呓ng c� n呓ng, c� xem n絠 n鄖 binh m� nguy hi琺, hay l� ta che ch� ng呓i 餴 tr呔c 疬㧟 kh鬾g?")
	CallScriptFunction((200060), "Paopao",sceneId, "V呓ng Ng� Y阯", "Y猲 T� �", "Bi瑄 ca kh鬾g 餴, ta c鹡g s� kh鬾g 餴, ta mu痭 � l読 gi鷓 bi瑄 ca.")

end

--**********************************
-- 脱离战斗
--**********************************
function x402254_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x402254_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x402254_TBL.IDX_FlagCombat, 0)

	-- 删除段誉语嫣等人
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "V呓ng Ng� Y阯")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "衞鄋 D�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ba Thi阯 Th誧h")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph誱 Hoa")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ch� V課 L�")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "C� 携c Th鄋h")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Ph� T� Quy")
	CallScriptFunction((401040), "ClearMonsterByName",sceneId, "Chu 衋n Th")

	-- 从新在场景中生成这些Npc
	CallScriptFunction((401040), "CreateMonster_11",sceneId)

	-- 停止点名
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_bWangyuyanSpeak, 0)
	LuaFnSetCopySceneData_Param(sceneId, x402254_g_DuanAndWangFlag, 0)
end

--**********************************
--提示所有副本内玩家
--**********************************
function x402254_TipAllHuman( sceneId, Str )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		BeginEvent(sceneId)
			AddText(sceneId, Str)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId, PlayerId)
	end
end

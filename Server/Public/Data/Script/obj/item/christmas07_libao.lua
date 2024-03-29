--07圣诞元旦活动
--圣诞守夜活动
--礼包使用脚本


--脚本号
x300065_g_scriptId = 300065

--礼品概率表....
x300065_g_GiftTbl = {

	{ itemId=10124134, odds=10   },
	{ itemId=10141090, odds=10   },

	{ itemId=30509039, odds=20000},
	{ itemId=30505146, odds=10000},

	{ itemId=10141100, odds=4990 },
	{ itemId=10141101, odds=4990 },

	{ itemId=30501125, odds=15000},
	{ itemId=30501126, odds=15000},
	{ itemId=30501127, odds=15000},

	{ itemId=-999,     odds=15000},

}

--圣诞帽表....
x300065_g_HatTbl = {

	10410098,
	10410099,
	10410100,
	10410101,
	10410102,
	10410103,
	10410104,
	10410105,
	10410106,
	10410107

}

--特效表....
x300065_g_ImpactTbl = {

	[30505150] = 10483,
	[30505153] = 10484,
	[30505152] = 10485,
	[30505151] = 10486

}

--**********************************
--事件交互入口
--**********************************
function x300065_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不C C醝 n鄖 接口,但要保留空函数
end

--**********************************
--C醝 n鄖 物品to� 鸬 使用过程喧ng否类似于技能: 
--H� th痭g会T読 执行开始时检测C醝 n鄖 函数to� 鸬 Tr� v�,如果Tr� v玹h b読则忽略后面to� 鸬 类似技能to� 鸬 执行.
--Tr� v�1: 技能类似to� 鸬 物品,可以继续类似技能to� 鸬 执行；Tr� v�0: 忽略后面to� 鸬 操作.
--**********************************
function x300065_IsSkillLikeScript( sceneId, selfId)
	return 1; --C醝 n鄖 脚本C 动作支持
end

--**********************************
--直接Hu� b鲂Ч�: 
--H� th痭g会直接调用C醝 n鄖 接口,并根据C醝 n鄖 函数to� 鸬 Tr� v礨醕 nh以后to� 鸬 流程喧ng否执行.
--Tr� v�1: 已经Hu� b龆杂πЧ�,不再执行后续操作；Tr� v�0: 没有检测到相关效果,继续执行.
--**********************************
function x300065_CancelImpacts( sceneId, selfId )
	return 0; --不C C醝 n鄖 接口,但要保留空函数,并且始终Tr� v�0.
end

--**********************************
--条件检测入口: 
--H� th痭g会T読 技能检测to� 鸬 时间 餴琺调用C醝 n鄖 接口,并根据C醝 n鄖 函数to� 鸬 Tr� v礨醕 nh以后to� 鸬 流程喧ng否执行.
--Tr� v�1: 条件检测通过,可以继续执行；Tr� v�0: 条件检测th b読,中断后续执行.
--**********************************
function x300065_OnConditionCheck( sceneId, selfId )
	return 1; --不C 任何条件,并且始终Tr� v�1.
end

--**********************************
--消耗检测及处理入口: 
--H� th痭g会T読 技能消耗to� 鸬 时间 餴琺调用C醝 n鄖 接口,并根据C醝 n鄖 函数to� 鸬 Tr� v礨醕 nh以后to� 鸬 流程喧ng否执行.
--Tr� v�1: 消耗处理通过,可以继续执行；Tr� v�0: 消耗检测th b読,中断后续执行.
--注意: 这不光负责消耗to� 鸬 检测也负责消耗to� 鸬 执行.
--**********************************
function x300065_OnDeplete( sceneId, selfId )

	local bagpos = LuaFnGetBagIndexOfUsedItem(sceneId, selfId)
	local itemId = LuaFnGetItemTableIndexByIndex(sceneId, selfId, bagpos)
	local impactId = x300065_g_ImpactTbl[itemId]

	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		if impactId then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, impactId, 0)
		end
		return 1;
	end

	return 0;

end

--**********************************
--只会执行m祎 次入口: 
--聚气和瞬发技能会T読 消耗完成后调用C醝 n鄖 接口(聚气结束并且各种条件都Th鯽 m鉵to� 鸬 时候),而引导
--技能也会T読 消耗完成后调用C醝 n鄖 接口(技能to� 鸬 m祎 开始,消耗成功执行之后).
--Tr� v�1: 处理成功；Tr� v�0: 处理th b読.
--注: 这里喧ng技能生效m祎 次to� 鸬 入口
--**********************************
function x300065_OnActivateOnce( sceneId, selfId )

	--给Kinh nghi甿....( 0.1*x*x + 6*x + 20 ) *15 *5....
	--7.5*x*x + 450*x +1500
	local Level = GetLevel(sceneId,selfId)
	local exp = 7.5 * Level * Level + 450 * Level +1500
	LuaFnAddExp( sceneId, selfId, floor(exp))

	--给礼品....
	local GiftId = 0
	local randValue = random(100000);
	randValue = randValue - 1;

	for _, item in x300065_g_GiftTbl do
		if item.odds >= randValue then
			GiftId = item.itemId
			break;
		end
		randValue = randValue - item.odds;
	end

	if GiftId == 0 then
		return 1
	end

	--如果给to� 鸬 喧ng圣诞帽....则自适应等c....强制绑定....
	if GiftId == -999 then

		local hatId = 1

		if Level < 10 then
			hatId = 1
		elseif Level < 100 then
			hatId = floor( Level/10 ) + 1
		else
			hatId = 10
		end

		GiftId = x300065_g_HatTbl[hatId]
		local BagPos = TryRecieveItem( sceneId, selfId, GiftId, QUALITY_MUST_BE_CHANGE )
		if -1 ~= BagPos then
			LuaFnItemBind( sceneId, selfId, BagPos)
		end
		
		--日志统计
		local guid = LuaFnObjId2Guid(sceneId, selfId)
		local log = format("itemId=%d", GiftId)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_SNOW, guid, log)

	elseif GiftId == 30509039 or GiftId == 10124134 or GiftId == 10141090 then
	--烟花 服装 坐骑C 绑定....
	
		local BagIndex = TryRecieveItem( sceneId, selfId, GiftId, QUALITY_MUST_BE_CHANGE )
		if BagIndex ~= -1 then
			LuaFnItemBind( sceneId, selfId, BagIndex)
		end

	else
	--其它则直接给....

		TryRecieveItem( sceneId, selfId, GiftId, QUALITY_MUST_BE_CHANGE )

	end

	--发Ch鷆 m譶g邮件....
	if GiftId ~= 0 then
		LuaFnSendSystemMail(sceneId, GetName(sceneId, selfId), "    Ch鷆 m譶g ng鄆 鹫t 疬㧟 l� v Noel #Y#{_ITEM" ..GiftId.. "}#W.#r    [Thi阯 Long b醫 b礭 ch鷆 ng鄆 Noel vui v�. Nguy畁 ng鄆 c鵱g [Thi阯 Long b醫 b礭 c鵱g nhau kh鰁 m課h tr叻ng th鄋h, cho nhau c鵱g n� l馽, h呔ng 皙n t痶 皓p, t呓ng lai r馽 r�.")
	end


	return 1;

end

--**********************************
--引导心跳处理入口: 
--引导技能会T読 每次心跳结束时调用C醝 n鄖 接口.
--Tr� v�: 1继续下次心跳；0: 中断引导.
--注: 这里喧ng技能生效m祎 次to� 鸬 入口
--**********************************
function x300065_OnActivateEachTick( sceneId, selfId)
	return 1; --不喧ng引导性脚本, 只保留空函数.
end

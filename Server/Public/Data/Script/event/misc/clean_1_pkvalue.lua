--洗杀气

--脚本号
x800110_g_scriptId = 800110

x800110_g_ModScript = 800112

function x800110_OnDefaultEvent( sceneId, selfId, targetId )

	--  餴琺到当前杀气值
	local pk_value = LuaFnGetHumanPKValue(sceneId, selfId);
	if pk_value then
	else
		return 0;
	end

	-- 判断喧ng否有杀气
	if pk_value < 1 then
		x800110_NotifyFail(sceneId, selfId, "C醕 h� kh鬾g c� s醫 kh�",targetId)
--		Msg2Player(sceneId, selfId, "C醕 h� kh鬾g c� s醫 kh�", MSG2PLAYER_PARA);
		return 0;
	end

	-- 检查喧ng否有足够to� 鸬 善恶值和金钱来扣除1 餴琺杀气
	if CallScriptFunction( x800110_g_ModScript, "CheckCost", sceneId, selfId, targetId ,1 ) ~= 1 then
		return 0
	end

	-- 根据1 餴琺杀气值来扣除善恶值和金币
	CallScriptFunction( x800110_g_ModScript, "PayForClean", sceneId, selfId, 1 )
	
	-- 扣除1 餴琺杀气值
	LuaFnSetHumanPKValue(sceneId, selfId, pk_value - 1)
	LuaFnAuditGoodbadDecPKValue( sceneId, selfId, 1 ); --记录用善恶值减少杀气to� 鸬 统计信息....
	
	x800110_NotifyFail( sceneId, selfId, "C醕 h� gi鋓 tr� th鄋h c鬾g 1 餴琺 s醫 kh�." ,targetId)
--	x800110_NotifyFailTips(sceneId, selfId, "C醕 h� gi鋓 tr� th鄋h c鬾g 1 餴琺 s醫 kh�.");
	
	-- [ QUFEI 2007-11-09 15:36 UPDATE BugID 27611 ]		
	local LogInfo	= format( "[ChangePKValue]:ClearPKValue sceneId=%d, GUID=%0X, PKValueBgn=%d, PKValueEnd=%d",
			sceneId,
			LuaFnObjId2Guid( sceneId, selfId ),			
			pk_value,
			LuaFnGetHumanPKValue(sceneId, selfId) )
	WriteCheckLog( sceneId, selfId, LogInfo )

end

-- ************************
-- NPC对话窗口中调用to� 鸬 函数
-- ************************
function x800110_OnEnumerate( sceneId, selfId,targetId )

	AddNumText(sceneId, x800110_g_scriptId, "Tr� 1 餴琺 s醫 kh�", 6, x800110_g_scriptId)

end


--**********************************
-- 屏幕中间信息提示
--**********************************
function x800110_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--对话框提示
function x800110_NotifyFail( sceneId, selfId, Tip ,targetId)
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,targetId)
end

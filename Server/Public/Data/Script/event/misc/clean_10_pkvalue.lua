--洗杀气

--脚本号
x800111_g_scriptId = 800111

x800111_g_ModScript = 800112


function x800111_OnDefaultEvent( sceneId, selfId, targetId )

	--  餴琺到当前杀气值
	pk_value = LuaFnGetHumanPKValue(sceneId, selfId);
	if pk_value then
	else
		return 0;
	end

	-- 判断喧ng否有10 餴琺杀气
	if pk_value < 10 then
		x800111_NotifyFail(sceneId, selfId, "S醫 kh� c黙 c醕 h� kh鬾g 瘘 10 餴琺",targetId)
--		Msg2Player(sceneId, selfId, "S醫 kh� c黙 c醕 h� kh鬾g 瘘 10 餴琺", MSG2PLAYER_PARA);
		return 0;
	end

	-- 检查喧ng否有足够to� 鸬 善恶值和金钱来扣除10 餴琺杀气
	if CallScriptFunction( x800111_g_ModScript, "CheckCost", sceneId, selfId, targetId ,10 ) ~= 1 then
		return 0
	end

	-- 根据10 餴琺杀气值来扣除善恶值和金币
	CallScriptFunction( x800111_g_ModScript, "PayForClean", sceneId, selfId, 10 )
	
	-- 扣除10 餴琺杀气值
	LuaFnSetHumanPKValue(sceneId, selfId, pk_value - 10)
	LuaFnAuditGoodbadDecPKValue( sceneId, selfId, 10 ); --记录用善恶值减少杀气to� 鸬 统计信息....

	x800111_NotifyFail( sceneId, selfId,"C醕 h� gi鋓 tr� th鄋h c鬾g 10 餴琺 s醫 kh�." ,targetId)
--	x800111_NotifyFailTips(sceneId, selfId, "C醕 h� gi鋓 tr� th鄋h c鬾g 10 餴琺 s醫 kh�.");

	-- [ QUFEI 2007-11-09 15:36 UPDATE BugID 27611 ]		
	local LogInfo	= format( "[ChangePKValue]:ClearPKValue sceneId=%d, GUID=%0X, PKValueBgn=%d, PKValueEnd=%d",
			sceneId,
			LuaFnObjId2Guid( sceneId, selfId ),			
			pk_value,
			LuaFnGetHumanPKValue(sceneId, selfId) )
	WriteCheckLog( sceneId, selfId, LogInfo )

	return 1;

end


-- ************************
-- NPC对话窗口中调用to� 鸬 函数
-- ************************
function x800111_OnEnumerate( sceneId, selfId,targetId )

	AddNumText(sceneId, x800111_g_scriptId, "Tr� 10 餴琺 s醫 kh�", 6, x800111_g_scriptId)

end


--**********************************
-- 屏幕中间信息提示
--**********************************
function x800111_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--对话框提示
function x800111_NotifyFail( sceneId, selfId, Tip, targetId)
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,targetId)
end

-- L誧 D呓ng
--钱庄
--问路脚本
x500003_g_scriptId = 500003

-- 问路类型 type: 1 为二c菜单, 2 为直接问路
x500003_g_Signpost = {
	{ type=2, name="Ti甿 c 鸢", x=95, y=152, tip="H� Sinh T鄆 ", desc="詎g ch� ti甿 c 鸢 H� Sinh T鄆 (95, 152) trong ti甿 c 鸢 � 疬秐g l緉 ph韆 T鈟. 刵 ph韒 TAB, tr阯 b鋘 鸢 c� k� hi畊 nh nh醳", eventId=-1 },
	{ type=2, name="Ti玭 trang", x=80, y=152, tip="D呓ng Hy B靚h ", desc="V課 kim ti玭 trang l鉶 b鋘 D呓ng Hy B靚h (80, 152) � Ti玭 Trang trong 疬秐g l緉 ph韆 T鈟, n� b礳 c黙 鬾g c� th� gi鷓 c醕 h� c gi� v ph鏼 v� ng鈔 l唼ng. 刵 ph韒 TAB, tr阯 b鋘 鸢 c� k� hi畊 nh nh醳", eventId=-1 },
	{ type=2, name="Kim Nguy阯 B鋙 Th呓ng", x=206, y=172, tip="Kim L鴆 Gia ", desc="Kim Nguy阯 B鋙 Th呓ng Nh鈔 Kim L鴆 Gia (206, 172) � 恤ng Th�. 刵 ph韒 TAB, tr阯 b鋘 鸢 c� k� hi畊 nh nh醳", eventId=-1 },
}

--**********************************
--列举事件
--**********************************
function x500003_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500003_g_Signpost do
		AddNumText(sceneId, x500003_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500003_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500003_g_Signpost[GetNumText()]

	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. ": ")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	end

end

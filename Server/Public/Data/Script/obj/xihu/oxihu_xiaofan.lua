-- 中秋NPC
-- 小贩

x050201_g_scriptId = 050201

x050201_g_shoptableindex = 166	--暂时

--**********************************
--事件交互入口
--**********************************
function x050201_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    V� 姓i Hi畃 n鄖, 皙n 疴y mua ch閚 L鴆 效u Thang 瓞 gi鋓 kh醫 n鄌! Ti甿 L鴆 效u Thang c黙 ta n眎 ti猲g g xa 痼!" )
		AddNumText( sceneId, x050201_g_scriptId, "Mua L鴆 效u Thang", 7, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x050201_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		DispatchShopItem( sceneId, selfId, targetId, x050201_g_shoptableindex )
	end
end

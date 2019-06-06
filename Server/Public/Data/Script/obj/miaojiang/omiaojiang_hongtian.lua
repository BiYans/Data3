--苗疆NPC
--洪天
--野外宝石贩子

x029006_g_scriptId = 029006
x029006_g_shoptableindex = 109

--**********************************
--事件交互入口
--**********************************
function x029006_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "Xem h鄋g th� 疬㧟, nh遪g 鹱ng h騨g m� t叻ng t緄 vi甤 th錷 d� lai l竎h B鋙 Th誧h � ch� ta. M huynh 甬 ta ch� c� con 疬秐g sinh nhai n鄖 th鬷" )
		AddNumText( sceneId, x029006_g_scriptId, "Xem ng呓i c� h鄋g g� t痶", 7, 0 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x029006_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		if(GetLevel(sceneId, selfId) < 30 ) then
			BeginEvent( sceneId )
			AddText( sceneId, "#{BSSR_20080131_01}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		DispatchShopItem( sceneId, selfId, targetId, x029006_g_shoptableindex )
	end
end

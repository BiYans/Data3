--姓i L齆PC
--小钗
--服装店

x002055_g_scriptId = 002055
x002055_g_shoptableindex = 3

--**********************************
--事件交互入口
--**********************************
function x002055_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    Trong ti甿 b醤 r nhi玼 th呓ng ph, hoan ngh阯h t緄 mua!" )
		AddNumText( sceneId, x002055_g_scriptId, "Ng呓i mu痭 mua g� n鄌?", 7, 0 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x002055_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		DispatchShopItem( sceneId, selfId, targetId, x002055_g_shoptableindex )
	end
end

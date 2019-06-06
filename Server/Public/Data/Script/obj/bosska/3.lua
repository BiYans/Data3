--890003紫银碎片兑换
x890003_g_ScriptId = 890003
x890003_g_itemId = 39901008
x890003_g_MonsterId = 39703


--**********************************
--事件列表
--**********************************
function x890003_UpdateEventList( sceneId, selfId,targetId )		 
	if sceneId ~= 458 then
		BeginEvent(sceneId)
			AddText(sceneId,"此场景不可召唤，请到洛阳“副本传送人”处传送到专用地图！")
		EndEvent( )
		DispatchMissionTips(sceneId,selfId)
		return 0;
	end

	local level = GetLevel( sceneId, selfId )
	if not level or level < 21 then
		BeginEvent( sceneId )
			AddText( sceneId, "等级不足121级无法使用" )
		EndEvent( )
		DispatchMissionTips( sceneId, selfId )
		return 0
	end

	  if LuaFnDelAvailableItem(sceneId, selfId, x890003_g_itemId, 1) == 0 then
		BeginEvent(sceneId)
			 AddText( sceneId, "您必须拥有1个boss卡片我才可以为您召唤,请检查物品是否上锁！" )
		   EndEvent(sceneId)
		   DispatchMissionTips( sceneId, selfId )
		   return
		 end
	
		local posX, posZ;
		posX, posZ = LuaFnGetWorldPos(sceneId, selfId);
		nObjID = LuaFnCreateMonster(sceneId, x890003_g_MonsterId, posX, posZ, 1, 253, 0);
		if nObjID and nObjID ~= -1 then
		--	SetCharacterDieTime(sceneId, nObjID, 600000);
			SetCharacterTitle(sceneId, nObjID, "春三十娘");
		--	LuaFnSetMonsterExp(sceneId, nObjID, 0);
		--	LuaFnDisableMonsterDropBox(sceneId, nObjID);
		end
            local  nam= LuaFnGetName( sceneId, selfId )
		  local strText = format ("#b#cff00f0恭喜玩家★★#c00ff00"..nam.."#b#cff00f0★★成功使用BOSS卡片召唤出春三十娘,本服BOSS卡片召唤BOSS消灭后可爆出赠点以及石头宝箱,手工材料制作等高级道具!#Y", nam)						
		      BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		
		   return
end
--**********************************
--事件交互入口
--**********************************
function x890003_OnDefaultEvent( sceneId, selfId,targetId )
	x890003_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x890003_OnEventRequest( sceneId, selfId, targetId, eventId )
end
--×¢Òâ: 

--ÎïÆ·¼¼ÄÜto?ğµ Âß¼­Ö»ÄÜÊ¹ÓÃ»ù´¡¼¼ÄÜºÍ½Å±¾À´ÊµÏÖ


--½Å±¾:

--ÒÔÏÂĞúng½Å±¾ÑùÀı:


--4915.lua
------------------------------------------------------------------------------------------
--mµt °ãÎïÆ·to?ğµ Ä¬ÈÏ½Å±¾

--½Å±¾ºÅ
x334915_g_scriptId = 334915 --ÁÙÊ±Ğ´Cái này ,ÕæÕıÓÃto?ğµ Ê±ºòmµt ¶¨Òª¸Ä.

--C¥n to?ğµ µÈc¤p
x334915_g_levelRequire = 1
--AE·¶Î§°ë¾¶
x334915_g_radiusAE = 3.0
--AEto?ğµ Ä¿±ê¹ØÏµ±ê¼Ç
x334915_g_standFlag = 1 -- 2:¶ÓÓÑ, 1: ÓÑ¾ü, -1: µĞ¾ü
--AEÓ°ÏìÊıÄ¿ÏŞÖÆ
x334915_g_effectCount = 4 -- -1:²»ÏŞÖÆ
--Ğ§¹ûto?ğµ ID
x334915_g_Impact1 = 4915 --ÁÙÊ±Ğ´Cái này 
x334915_g_Impact2 = -1 --²»ÓÃ

--**********************************
--ÊÂ¼ş½»»¥Èë¿Ú
--**********************************
function x334915_OnDefaultEvent( sceneId, selfId, bagIndex )
-- ²»C¥n Cái này ½Ó¿Ú,µ«Òª±£Áô¿Õº¯Êı
end

--**********************************
--Cái này ÎïÆ·to?ğµ Ê¹ÓÃ¹ı³ÌĞúng·ñÀàËÆÓÚ¼¼ÄÜ: 
--H?th¯ng»áTÕi Ö´ĞĞ¿ªÊ¼Ê±¼ì²âCái này º¯Êıto?ğµ Tr?v«Ö?Èç¹ûTr?v«th¤t bÕiÔòºöÂÔºóÃæto?ğµ ÀàËÆ¼¼ÄÜto?ğµ Ö´ĞĞ.
--Tr?v?: ¼¼ÄÜÀàËÆto?ğµ ÎïÆ·,¿ÉÒÔ¼ÌĞøÀàËÆ¼¼ÄÜto?ğµ Ö´ĞĞ£»Tr?v?: ºöÂÔºóÃæto?ğµ ²Ù×÷.
--**********************************
function x334915_IsSkillLikeScript( sceneId, selfId)
	return 1; --Cái này ½Å±¾C¥n ¶¯×÷Ö§³Ö
end

--**********************************
--Ö±½ÓHu?böĞ§¹? 
--H?th¯ng»áÖ±½Óµ÷ÓÃCái này ½Ó¿Ú,²¢¸ù¾İCái này º¯Êıto?ğµ Tr?v«ÖµXác nh§nÒÔºóto?ğµ Á÷³ÌĞúng·ñÖ´ĞĞ.
--Tr?v?: ÒÑ¾­Hu?bö¶ÔÓ¦Ğ§¹?²»ÔÙÖ´ĞĞºóĞø²Ù×÷£»Tr?v?: Ã»ÓĞ¼ì²âµ½Ïà¹ØĞ§¹û,¼ÌĞøÖ´ĞĞ.
--**********************************
function x334915_CancelImpacts( sceneId, selfId )
	return 0; --²»C¥n Cái này ½Ó¿Ú,µ«Òª±£Áô¿Õº¯Êı,²¢ÇÒÊ¼ÖÕTr?v?.
end

--**********************************
--Ìõ¼ş¼ì²âÈë¿Ú: 
--H?th¯ng»áTÕi ¼¼ÄÜ¼ì²âto?ğµ Ê±¼ä ği¬mµ÷ÓÃCái này ½Ó¿Ú,²¢¸ù¾İCái này º¯Êıto?ğµ Tr?v«ÖµXác nh§nÒÔºóto?ğµ Á÷³ÌĞúng·ñÖ´ĞĞ.
--Tr?v?: Ìõ¼ş¼ì²âÍ¨¹ı,¿ÉÒÔ¼ÌĞøÖ´ĞĞ£»Tr?v?: Ìõ¼ş¼ì²âth¤t bÕi,ÖĞ¶ÏºóĞøÖ´ĞĞ.
--**********************************
function x334915_OnConditionCheck( sceneId, selfId )
	--Ğ£ÑéÊ¹ÓÃto?ğµ ÎïÆ·
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if(0<=targetId) then
		-- Ä¿±ê±ØĞëĞúngÓÑ¾üto?ğµ ¼ì²â
		if LuaFnIsFriend(sceneId, targetId, selfId) ~= 1 then
			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
			return 0;
		end
		
		if LuaFnIsFriend(sceneId, selfId, targetId ) ~= 1 then
			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
			return 0;
		end
		
    local SelfSex = LuaFnGetSex(sceneId, selfId)
    local TargetSex = LuaFnGetSex(sceneId, targetId)                

       
		-- Ä¿±ê±ØĞëĞúngµĞ¾üto?ğµ ¼ì²â
--		if(1~=LuaFnUnitIsEnemy(sceneId, selfId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- Ä¿±ê±ØĞëĞúng¶ÓÓÑto?ğµ ¼ì²â
--		if(1~=LuaFnUnitIsPartner(sceneId, selfId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- Ä¿±êc¤p±ğto?ğµ ¼ì²â
--		if(g_LevelRequire<=LuaFnGetLevel(sceneId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
--		if(g_LevelRequire>=LuaFnGetLevel(sceneId, targetId)) then
--			LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end

	end
	
	return 1; --²»C¥n ÈÎºÎÌõ¼ş,²¢ÇÒÊ¼ÖÕTr?v?.
end

--**********************************
--ÏûºÄ¼ì²â¼°´¦ÀíÈë¿Ú: 
--H?th¯ng»áTÕi ¼¼ÄÜÏûºÄto?ğµ Ê±¼ä ği¬mµ÷ÓÃCái này ½Ó¿Ú,²¢¸ù¾İCái này º¯Êıto?ğµ Tr?v«ÖµXác nh§nÒÔºóto?ğµ Á÷³ÌĞúng·ñÖ´ĞĞ.
--Tr?v?: ÏûºÄ´¦ÀíÍ¨¹ı,¿ÉÒÔ¼ÌĞøÖ´ĞĞ£»Tr?v?: ÏûºÄ¼ì²âth¤t bÕi,ÖĞ¶ÏºóĞøÖ´ĞĞ.
--×¢Òâ: Õâ²»¹â¸ºÔğÏûºÄto?ğµ ¼ì²âÒ²¸ºÔğÏûºÄto?ğµ Ö´ĞĞ.
--**********************************
function x334915_OnDeplete( sceneId, selfId )
	if(LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--Ö»»áÖ´ĞĞmµt ´ÎÈë¿Ú: 
--¾ÛÆøºÍË²·¢¼¼ÄÜ»áTÕi ÏûºÄÍê³Éºóµ÷ÓÃCái này ½Ó¿Ú(¾ÛÆø½áÊø²¢ÇÒ¸÷ÖÖÌõ¼ş¶¼Thöa mãnto?ğµ Ê±ºò),¶øÒıµ¼
--¼¼ÄÜÒ²»áTÕi ÏûºÄÍê³Éºóµ÷ÓÃCái này ½Ó¿Ú(¼¼ÄÜto?ğµ mµt ¿ªÊ¼,ÏûºÄ³É¹¦Ö´ĞĞÖ®ºó).
--Tr?v?: ´¦Àí³É¹¦£»Tr?v?: ´¦Àíth¤t bÕi.
--×¢: ÕâÀïĞúng¼¼ÄÜÉúĞ§mµt ´Îto?ğµ Èë¿Ú
--**********************************
function x334915_OnActivateOnce( sceneId, selfId )
	if(-1~=x334915_g_Impact1) then
		--¸ø×Ô¼º¼ÓĞ§¹û
--		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x334915_g_Impact1, 0);
		--¸øÄ¿±ê¼ÓĞ§¹û
		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
		if(0<=targetId) then
			if LuaFnIsFriend(sceneId, targetId, selfId) > 0 then
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x334915_g_Impact1, 0);
				
				BeginEvent(sceneId)
			    AddText(sceneId, "Ğµ hão hæu tång 5 ği¬m.");
			  EndEvent(sceneId)
			  DispatchMissionTips(sceneId,selfId)
			  
			  local	namSelf		= GetName( sceneId, selfId )
			  local	namTarget	= GetName( sceneId, targetId )
				local	str	= format( "#B#{_INFOUSR"..namSelf.."}#cffffff tñ tay ğem #W[1 Ğóa Hoa H°ng]#cffffff trao cho #B#{_INFOUSR"..namTarget.."}#cffffff n¾i dài tình nghîa v¾i #B#{_INFOUSR"..namTarget.."}#cffffff." )
			  --AddGlobalCountNews( sceneId, str )
			  
			end
		end
		--×Ô¼ºÖÜÎ§AE
--		local posX,posZ = LuaFnGetUnitPosition(sceneId, selfId)
--		LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334915_g_radiusAE, x334915_g_standFlag, x334915_g_levelRequire, x334915_g_effectCount, x334915_g_Impact1, 0)
		--Ö¸¶¨µØ ği¬mÖÜÎ§AE
--		local posX,posZ = LuaFnGetTargetPosition(sceneId, selfId)
--		LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334915_g_radiusAE, x334915_g_standFlag, x334915_g_levelRequire, x334915_g_effectCount, x334915_g_Impact1, 0)
		--Ä¿±êcáiÌåÖÜÎ§AE
--		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
--		if(0<=targetId) then
--			local posX,posZ = LuaFnGetUnitPosition(sceneId, targetId)
--			LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x334915_g_radiusAE, x334915_g_standFlag, x334915_g_levelRequire, x334915_g_effectCount, x334915_g_Impact1, 0)
--		end
		

	end
	return 1;
end

--**********************************
--Òıµ¼ĞÄÌø´¦ÀíÈë¿Ú: 
--Òıµ¼¼¼ÄÜ»áTÕi Ã¿´ÎĞÄÌø½áÊøÊ±µ÷ÓÃCái này ½Ó¿Ú.
--Tr?v? 1¼ÌĞøÏÂ´ÎĞÄÌø£»0: ÖĞ¶ÏÒıµ¼.
--×¢: ÕâÀïĞúng¼¼ÄÜÉúĞ§mµt ´Îto?ğµ Èë¿Ú
--**********************************
function x334915_OnActivateEachTick( sceneId, selfId)
	return 1; --²»ĞúngÒıµ¼ĞÔ½Å±¾, Ö»±£Áô¿Õº¯Êı.
end

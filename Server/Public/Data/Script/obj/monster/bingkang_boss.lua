--企鹅王BOSS刷新公告

--脚本编号
x502003_g_ScriptId	= 502003

--**********************************
--Monster Timer
--**********************************
function x502003_OnCharacterTimer( sceneId, objId, dataId, uTime )
	--全球公告
	local	nam_mob	= GetName( sceneId, objId )
	if nam_mob ~= nil then
		str	= format( "#cff99ccCh� nh鈔 th s� c黙 #GNg鈔 Ngai Tuy猼 Nguy阯 l� X� Nga V呓ng #cff99ccv� 鹫i 疸 vung quy玭 tr唼ng xu hi畁 t読 l鉵h th� c黙 n� r癷!", nam_mob )
		AddGlobalCountNews( sceneId, str )
	end

	--Hu� b鍪敝�
	SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--死亡事件
--**********************************
function x502003_OnDie( sceneId, objId, killerId )

end

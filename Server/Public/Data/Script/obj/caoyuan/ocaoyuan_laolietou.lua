--ÀÏÁÒÍ·

--½Å±¾ºÅ
x020009_g_scriptId = 020009

--**********************************
--ÊÂ¼þÁÐ±í
--**********************************
function x020009_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = " cô nß½ng "
		else
			PlayerSex = " ðÕi hi®p"
		end
		AddText(sceneId,"  "..PlayerSex.."#{OBJ_caoyuan_0009}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

-- �콱NPC

x893080_g_scriptId = 893080
x893080_g_FuBenScriptId = 893063

--**********************************
--Su kien lan nhau cua vao
--**********************************
function x893080_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"    T� tuy�t trang b�n trong h� vi�n gi�o �u phi th߶ng l�i h�i, kh�ng c� Thi�n s�n l� r�t kh� x�ng qua ��, ch� c�n xao vang �i di�n �i�m ��i chung kh� �em n�y �� gi�o �u �i �i")
		--AddNumText( sceneId, x893080_g_scriptId, "#c00ff00��Ҫ����", 6, 200)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893080_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 200 then

		if GetMenPai(sceneId,selfId) ~= MP_SHAOLIN and GetMenPai(sceneId,selfId) ~= MP_MINGJIAO and GetMenPai(sceneId,selfId) ~= MP_GAIBANG and GetMenPai(sceneId,selfId) ~= MP_TIANSHAN then
			BeginEvent(sceneId)
	   			AddText( sceneId,"Ng߽i kh�ng ph�i c�n chi�n m�n ph�i, kh�ng th� th�y ���c phan tinh tinh �n th�n hi�u qu�")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else 
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 22211, 0 )
			BeginEvent(sceneId)
	   			AddText( sceneId, "Ta �� mu�n th�nh c�ng cho ng߽i s� d�ng �n th�n ph�n m�t, ch� � ph�i thu h�i tr�n th�, n�u kh�ng kh�ng c� �n th�n hi�u qu�" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end

	end
end

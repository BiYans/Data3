--��翷帱��....
--����ԶԻ��ű�....

--kich ban goc hao
x893070_g_ScriptId = 893070

--�����߼�kich ban goc hao....
x893070_g_FuBenScriptId = 893063

--**********************************
--������ں���....
--**********************************
function x893070_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText(sceneId,"  Ti�n ph߽ng ch�nh l� T� tuy�t trang. Ch�ng ta ph�i �i v�o � ch� s�u trong t�i n�ng t�m ���c b� b�o. Хu ti�n l� ph�i th�ng qua T� tuy�t �i�n")
		AddText(sceneId,"  T� tuy�t trong �i�n c� r�t nhi�u h� v�, nh�ng ch� mu�n nghe �n trong �i�n t� tuy�t ti�ng chu�ng, s� r�i �i. Ta c� th� l�m cho c�n chi�n m�n ph�i l�n v�o xao chung, n�u kh�ng c�ng ch� c� th� x�ng v�o")

		--�жϵ�ǰ�Ƿ����Khi�u chi�n ....	
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		AddText(sceneId,"   Trong �i�n h� v� �� mu�n thanh l�, ta �i �em t� tuy�t chi th� sinh m�n m�c ��a t�i, m�i ng߶i mau b�t gi� h�n, � cho ta �p h�i h�n b� b�o b�o t�n �a ph߽ng. H�n phi th߶ng th�ch b�ch [�em ti�n r��u]. M�i l�n s� tuy�t k� th�i �i�m �u �� ng�m x߾ng v�a l�t. M�i ng߶i ch� c�n ch� � n� tr�nh h�n ph�t ra �em ti�n m�i r��u k�nh, tho�i m�i b�t gi� h�n kh�ng l� v�n �")
		    AddNumText( sceneId, x893070_g_ScriptId, "Khi�u chi�n BOSS M�n M�c", 10, 1 )
		end
		--�жϵ�ǰ�Ƿ�Khi�u chi�n ���֮����....	
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893070_g_ScriptId, "Truy�n t�ng ti�p theo", 10, 2 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893070_OnEventRequest( sceneId, selfId, targetId, eventId )

   if GetNumText() == 1 then

	--������ڼ���BOSS�򷵻�....
	if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
		return
	end

	--�ǲ��Ƕӳ�....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		BeginEvent(sceneId)
			AddText( sceneId, "#{PMF_20080521_07}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--������ںͱ��BOSSChi�n �u �򷵻�....
	local ret, msg = CallScriptFunction( x893070_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--�жϵ�ǰ�Ƿ����Khi�u chi�n ɣ����....	
	if 1 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i �� mu�n khi�u chi�n ta" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--������翷��ʱ���������Լ�....
	CallScriptFunction( x893070_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893070_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 101, 52)

  end

end

--**********************************
--��翷��ʱ����OnTimer....
--**********************************
function x893070_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 5 gi�y b�t �u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 4 gi�y b�t �u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 3 gi�y b�t �u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 2 gi�y b�t �u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 1 gi�y b�t �u" )
		return
	end

	if 2 == step then
		--��ʾChi�n �u b�t �u....
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u b�t �u" )
		--ɾ��NPC....
		--CallScriptFunction( x893070_g_FuBenScriptId, "DeleteBOSS", sceneId, "MinMo_NPC" )
		return
	end

	if 1 == step then
		--����BOSS....
		CallScriptFunction( x893070_g_FuBenScriptId, "CreateBOSS", sceneId, "MinMo_BOSS", -1, -1 )
		return
	end

end

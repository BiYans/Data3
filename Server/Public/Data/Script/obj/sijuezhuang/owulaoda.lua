--��翷帱��....
--���ϴ�Ի��ű�....

--kich ban goc hao
x893072_g_ScriptId = 893072

--�����߼�kich ban goc hao....
x893072_g_FuBenScriptId = 893063

--ս�����ϴ�Ի�kich ban goc hao....
x893072_g_LossScriptId = 893075

--**********************************
--������ں���....
--**********************************
function x893072_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)

		AddText( sceneId, "    N�i n�y ch�nh l� t�n v�n ch� t�y v�n c�c. Theo ta�i�u tra tin, t�n v�n c� ch�c �nh di�u h�ng c�ng m�u v�ng d� �i�u hai ��i tuy�t k�. #rCh�c �nh di�u h�ng s� l� ng߽i th߽ng t�n ch�nh �i ng� c�a minh" )
		AddText( sceneId, "    M�u v�ng v� �i�u c�n l�i l� d�a v�o h�i �m phi�n c߶ng h�a t�n v�n c�ng l�c, nghe n�i c� �em nh�n k�ch b� m�t m�ng uy l�c #rc�c ng߽i chu�n b� t�t li�n cho ta bi�t, ta c�i n�y �i d�n t�n v�n �i ra" )

		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "Khi�u chi�n BOSS T�n V�n", 10, 1 )
		end

		--�жϵ�ǰ�Ƿ����Khi�u chi�n ����ˮ....	
		if 0 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "Truy�n t�ng ti�p theo", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893072_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then

	--������ڼ���BOSS�򷵻�....
	if 1 == CallScriptFunction( x893072_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893072_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--�жϵ�ǰ�Ƿ����Khi�u chi�n ���ϴ�....	
		if 1 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
			BeginEvent(sceneId)
				AddText( sceneId, "#{PMF_20080521_11}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--������翷��ʱ���������Լ�....
		CallScriptFunction( x893072_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893072_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 28, 57)
  end

end

--**********************************
--��翷��ʱ����OnTimer....
--**********************************
function x893072_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 5 gi�y b�t �u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 4 gi�y b�t �u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 3 gi�y b�t �u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 2 gi�y b�t �u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 1 gi�y b�t �u" )
		return
	end

	if 2 == step then
		--��ʾChi�n �u b�t �u....
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u b�t �u" )
		--ɾ��NPC....
		--CallScriptFunction( x893072_g_FuBenScriptId, "DeleteBOSS", sceneId, "TaoQin_NPC" )
		return
	end

	if 1 == step then
		--����BOSS....
		CallScriptFunction( x893072_g_FuBenScriptId, "CreateBOSS", sceneId, "TaoQin_BOSS", -1, -1 )
		return
	end

end

--��翷帱��....
--ɣ�����Ի��ű�....

--kich ban goc hao
x893071_g_ScriptId = 893071

--�����߼�kich ban goc hao....
x893071_g_FuBenScriptId = 893063

--**********************************
--������ں���....
--**********************************
function x893071_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "   N�i n�y ch�nh l� ��o thanh ch� b�n long c�c. Giang h� �n ��i ��o thanh hai m�t nh�n b�nh hi�m ngh�o, �� mu�n kh�ng th� nh�n v�t. Nh�ng c�ng phu v�n r�t l�i h�i l� t� tuy�t trang trung t�i c߶ng. #r��o thanh ch�n nu�i t� ch�ch m�c h� c�ng m߶i ch�ch thanh �ng, ch�ng n� �i v�i ��o thanh r�t m�c trung th�nh v� t�n t�m. N�u trong chi�n �u xu�t hi�n trong l�i n�i, nh�t �nh ph�i ti�n lui" )
		AddText( sceneId, "   M�t kh�c h�n c�n c� h�ng nh�t tuy�t k� --tam phong l�u v�n. S� xu�t �n sau, ��o thanh h�i  nh� qu� th�n b�nh th߶ng, xu�t qu� nh�p th�n. Nghe n�i, k� n�ng n�y c� v�a v� tr�n, h�o h�o l�i d�ng c� th� �em tam phong l�u v�n c�p ph� #r c�c ng߽i chu�n b� t�t li�n cho ta bi�t, ta c�i n�y �i d�n ��o thanh �i ra" )
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "Khi�u chi�n BOSS ��o Thanh", 10, 1 )
		end
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "Truy�n t�ng ti�p theo", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x893071_OnEventRequest( sceneId, selfId, targetId, eventId )
   if GetNumText() == 1 then
	--������ڼ���BOSS�򷵻�....
	if 1 == CallScriptFunction( x893071_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893071_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--�жϵ�ǰ�Ƿ����Khi�u chi�n ɣ����....	
	if 1 ~= CallScriptFunction( x893071_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "Ng߽i �� mu�n khi�u chi�n ta" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--������翷��ʱ���������Լ�....
	CallScriptFunction( x893071_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893071_g_ScriptId, -1, -1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 73, 91)
  end

end

--**********************************
--��翷��ʱ����OnTimer....
--**********************************
function x893071_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 5 gi�y b�t �u" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 4 gi�y b�t �u" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 3 gi�y b�t �u" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 2 gi�y b�t �u" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u 1 gi�y b�t �u" )
		return
	end

	if 2 == step then
		--��ʾChi�n �u b�t �u....
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "Chi�n �u b�t �u" )
		--ɾ��NPC....
		--CallScriptFunction( x893071_g_FuBenScriptId, "DeleteBOSS", sceneId, "QinYun_NPC" )
		return
	end

	if 1 == step then
		--����BOSS....
		CallScriptFunction( x893071_g_FuBenScriptId, "CreateBOSS", sceneId, "QinYun_BOSS", -1, -1 )
		return
	end

end

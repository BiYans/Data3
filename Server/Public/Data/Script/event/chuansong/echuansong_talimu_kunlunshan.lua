--��ҽ���m�t c�i area ʱ����
function x400939_OnEnterArea( sceneId, selfId )
	BeginEvent(sceneId)
		AddText(sceneId,"  This map hasn't opened...")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,-1)
	--CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 433,110,20)
end

--���T�i m�t c�i area ����m�t ��ʱ��û����ʱ����
function x400939_OnTimer( sceneId, selfId )
	-- �� gi�y,��T�i C�i n�y  area ͣ�������
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5 gi�y����δ����
	if StandingTime >= 5000 then
		x400939_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--����뿪m�t c�i area ʱ����
function x400939_OnLeaveArea( sceneId, selfId )
end
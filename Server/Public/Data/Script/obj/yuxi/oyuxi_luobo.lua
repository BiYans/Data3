--��ϪNPC
--�ܲ�
--��ͨ

--**********************************
--�¼��������
--**********************************
function x027003_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Xin ch�o. #rTa l� La B�c. #rCha ta l� T� M�u La, #rM� ta l� C� L� L�p. #rMu�i ta l� Y Na. #r...")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

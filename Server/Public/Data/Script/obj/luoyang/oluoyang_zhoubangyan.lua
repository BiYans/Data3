--L誧 D呓ngNPC
--周邦彦
--普通

--**********************************
--事件交互入口
--**********************************
function x000013_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Nghe 鸢n ti瑄 th� S� S� 疸 b� 疬a v鄌 trong 衞an v呓ng ph�, th馽 kh鬾g d醡 tin 痼 l� s� th馽")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

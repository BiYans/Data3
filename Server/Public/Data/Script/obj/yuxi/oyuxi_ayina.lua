--玉溪NPC
--阿依娜
--普通

--**********************************
--事件交互入口
--**********************************
function x027006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  Kh鬾g bi猼 t緄 bao gi� m� m緄 tha th� cho cha? N猽 hai ng叨i c鵱g s痭g b阯 nhau nh� tr呔c th� t痶 qu�. Ng鄖 n鄌 ta c鹡g s� 疬㧟 g La B痗 Ca Ca r癷, hay bi猼 m! Kh鬾g bi猼 m ng鄖 nay La B痗 Ca Ca b g� m� kh鬾g t緄 ch絠 v緄 ta.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

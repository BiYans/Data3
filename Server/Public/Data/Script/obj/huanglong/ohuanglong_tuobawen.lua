--黄龙NPC
--拓跋文
--普通

--**********************************
--事件交互入口
--**********************************
function x023001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  H鬽 痼 T竎h Nhan 餴 v鄌 r譶g ph韆 b, c�  l鄊 g� t鬷 皤u nh靚 th c�... Nh遪g m�, n猽 t鬷 餰m chuy畁 n鄖 n骾 cho M� Dung tr叻ng l鉶, 鬾g  nh 鸶nh gi猼 ch猼 T竎h Nhan... T鬷 ph鋓 l鄊 sao 疴y..")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

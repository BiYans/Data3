--Thi阯 Long寺NPC
--本名
--普通

x013035_g_scriptId = 013035

--**********************************
--事件交互入口
--**********************************
function x013035_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"L鉶 t錸g g 疴y 疸 nh靚 th 疬㧟 huy玭 c� c黙 H鄋 Ng鱟 Th醦, h猼 nh鏽 h猼 qu�, kh鬾g danh kh鬾g t呔ng, ng呓i c� mu痭 khi陁 chi猲 v緄 vua b� nh靚 trong truy玭 thuy猼 c黙 Ma 鹫o kh鬾g?")
		AddNumText(sceneId,x013035_g_scriptId,"衖 鹫i chi猲 Kh痠 L鹹",10,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x013035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<91  then	
			BeginEvent( sceneId )
			local strText = "衅ng c th� ch� 疴y ch遖 t緄 c 91, b呔c v鄌 鸬ng e rg s� v� c鵱g nguy hi琺 痼"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 143,95,134)
		end
	end
end

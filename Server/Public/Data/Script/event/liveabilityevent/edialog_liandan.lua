--对话事件 npc白颖明

--脚本号
x713618_g_ScriptId = 713512

--对话内容
x713618_g_dialog = {"#{event_liveabilityevent_0021}",
			"C鈛 n骾 th� hai",
			"Ch� c huynh h鱟 k� n錸g tr皀g tr鱰 l� c� th� tr皀g ngay. T nhi阯, 鹌ng c c黙 huynh c鄋g cao, ch黱g lo読 c鈟 疬㧟 tr皀g c鄋g nhi玼",
			"Ch� c h鱟 疬㧟 k� n錸g tr皀g tr鱰, t緄 m祎 m鋘h ru祅g ch遖 tr皀g tr鱰, h鰅 ng叨i coi ru祅g, r癷 l馻 ch鱪 gi痭g c鈟 tr皀g l� 疬㧟",
			"#{event_liveabilityevent_0022}"}
x713618_g_button = {"羞㧟 r癷, 疬㧟 r癷, n骾 g� th馽 t� 餴",
			"T読 h� l鄊 th� n鄌 瓞 tr皀g tr鱰 疬㧟?",
			"Sau 痼 th� sao?",
			"Thu ho誧h ra sao?",
			}

--**********************************
--任务入口函数
--**********************************
function x713618_OnDefaultEvent( sceneId, selfId, targetId, MessageNum )	--MessageNum喧ng对话编号,用于调用不同对话
		BeginEvent(sceneId)
			AddText(sceneId, x713618_g_dialog[MessageNum])
			if MessageNum ~= 5 then
				AddNumText(sceneId,MessageNum, x713618_g_button[MessageNum],11,-1)
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--列举事件
--**********************************
function x713618_OnEnumerate( sceneId, selfId, targetId )
		AddNumText(sceneId,x713618_g_ScriptId,"T読 h� mu痭 t靘 hi瑄 tr皀g tr鱰",11,-1)
end

--**********************************
--检测Ti猵 th跫�
--**********************************
function x713618_CheckAccept( sceneId, selfId )
end

--**********************************
--Ti猵 th�
--**********************************
function x713618_OnAccept( sceneId, selfId, AbilityId )
end

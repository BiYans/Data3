-- 899994
-- 高太公 匪寨传送人

--kich ban goc hao
x899994_g_scriptId = 899994

--所拥有的事件ID列表
x899994_g_eventList={893063}

--**********************************
--事件列表
--**********************************
function x899994_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"   C黙 ta ngh頰 ph� phan x� v痭 l� k� ngh� th� gia 甬 t�, trong c鹡g c� tuy畉 th� k� ngh� b� b鋙. Nh遪g l c k� th� h鱝 n瞚 ti猲g giang h� t� tuy畉 trang l読 d鵱g c醕 lo読 hi琺 醕 th� 餺課 餰m b� b鋙 c呔p 餴, c騨 ngh� phan gia di畉 m鬾. Ta ngh頰 ph� nh鈔 r絠 xu痭g v醕h n鷌 餰n c� th� 疣o tho醫, nh遪g r絠 v鄌 2 ch鈔 t鄋 ph�, ta v痭 鸶nh 餰m b� b鄌 餺誸 l読 n鄖 t鈓 nguy畁, b 稹c d� l馽 b t騨g t鈓, l鷆 n鄖 kh c ch� v� 鹫i hi畃 tr� ta 餺誸 l読 b� b鄌, l鄊 cho ti瑄 n� t� c� th� t鏽 ph鈔 hi猽 t鈓")
	AddText(sceneId,"   Ch� � h� th痭g nhi甿 v� kh� xin c tr鱪g")

	AddNumText( sceneId, x899994_g_scriptId, "V� t� tuy畉 trang",0 ,2  )
	
	for i, eventId in x899994_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--Su kien lan nhau cua vao
--**********************************
function x899994_OnDefaultEvent( sceneId, selfId,targetId )
	x899994_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--Su kien liet biet lua chon hang nhat
--**********************************
function x899994_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 2 then
	BeginEvent(sceneId)
	    AddText(sceneId,"T� tuy畉 trang ho鄋 m� quan ph呓ng ph� b鋘, ch� y猽 r絠 xu痭g nguy阯 li畊 th錸g c v� h皀, m瞚 ng鄖 3 l唼t, cu痠 c鵱g th鄋h c鬾g 疳nh ch猼 chung c馽 BOSS sau kh鬾g c� ng叨i kh� 鹫t 疬㧟 m祎 c醝 t� tuy畉 b鋙 t呓ng. #r#Y ch� �: BOSS k� n錸g ho鄋 m� c鵱g quan ph呓ng gi痭g nhau, c th鈔")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
		return
	end

	for i, findId in x899994_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x899994_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x899994_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			x899994_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x899994_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x899994_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x899994_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x899994_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x899994_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

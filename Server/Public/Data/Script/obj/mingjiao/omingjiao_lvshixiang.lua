--Minh Gi醥NPC
--吕师襄
--普通

x011006_g_scriptId = 009002
x011006_g_eventList={222900,808004}
--**********************************
--事件交互入口
--**********************************
function x011006_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  T豼 gia l� Minh Gi醥 H鎢 s� L� S� T呓ng, n猽 mu痭 gia nh Minh Gi醥, h銀 t緄 T豼 gia! mu痭 u痭g r唼u, c鹡g t緄 t靘 t豼 gia!")
		local mp = GetMenPai(sceneId, selfId)
		local nMenpaiPoint = GetHumanMenpaiPoint(sceneId, selfId)
		if mp == 9 then 
			AddNumText(sceneId, x011006_g_scriptId, "Gia nh m鬾 ph醝",6,0)
		end
		AddNumText(sceneId, x011006_g_scriptId, "Gi緄 thi畊 m鬾 ph醝",8,1)
		AddNumText(sceneId, x011006_g_scriptId, "H鱟 K� n錸g c黙 m鬾 ph醝?",8,6)		--指路到技能学习人
		for i, eventId in x011006_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x011006_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText()==0	then

		x011006_g_MenPai = GetMenPai(sceneId, selfId)
		if x011006_g_MenPai == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "Tr� n鄖 c鹡g 瘗a 疬㧟 sao? N猽 l鄊 t豼 gia b馽 t裞, tr� c黙 ng呓i 1000 餴琺 c痭g hi猲 h銀 c騨 韙")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if x011006_g_MenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"G� n鄖 hay g緈 nh�! ng呓i 疸 l� ng叨i c黙 m鬾 ph醝 kh醕, c騨 t緄 t靘 Minh Gi醥 ta l鄊 g�?")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{MenpaiInfo_001}")
			AddNumText(sceneId, x011006_g_scriptId, "Ta mu痭 b醝 nh Minh Gi醥",6,3)
			AddNumText(sceneId, x011006_g_scriptId, "T読 h� ch遖 mu痭 b醝 s�",8,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		 
		return
	end
	
	if GetNumText()==4	then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	
	if GetNumText()==3	then
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"  H銀 s x猵 l読 tay n鋓, c 2 v� tr� tr痭g, ta s� th叻ng cho ng呓i!")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif GetLevel( sceneId, selfId ) < 10 then
			BeginEvent(sceneId)
				AddText(sceneId,"Gi醥 h礽 Minh Gi醥 ta, ch� thu nh ng叨i t� c 10 tr� l阯")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x011006_g_MenPai = GetMenPai(sceneId, selfId)
			if x011006_g_MenPai == 1 then
				BeginEvent(sceneId)
					AddText(sceneId, "Tr� n鄖 c鹡g 瘗a 疬㧟 sao? N猽 l鄊 t豼 gia b馽 t裞, tr� c黙 ng呓i 1000 餴琺 c痭g hi猲 h銀 c騨 韙")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			--Tr� v滴�9表示无门派
			elseif x011006_g_MenPai==9	then
				LuaFnJoinMenpai(sceneId, selfId, targetId, 1)

				-- 设置初始to� 鸬 Npc关系值
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- 把相关to� 鸬 心法设置为10c别  7,10,11
				LuaFnSetXinFaLevel(sceneId,selfId,7,10)
				LuaFnSetXinFaLevel(sceneId,selfId,10,10)
				LuaFnSetXinFaLevel(sceneId,selfId,11,10)

				BeginEvent(sceneId)
	  				AddText(sceneId,"C醕 h� 疸 gia nh Minh Gi醥!");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,selfId)
	  			
	  			if TryRecieveItem( sceneId, selfId, 10124001, 1 ) >= 0 then
					str		= "#YC醕 h� 疸 nh 疬㧟"..GetItemName( sceneId, 10124001 ).."."
					x011006_MsgBox( sceneId, selfId, str )				
				end
				
				
				--给玩家发信,告诉他到哪里打怪,怎样赚钱
				LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LevelMail_menpai_2}" )
				--LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{OBJ_mingjiao_0001}" )
				
				--门派奖励召集令
				for i=1, 20 do
					TryRecieveItem( sceneId, selfId, 30501001, 1 )
				end
				x011006_MsgBox( sceneId, selfId, "L 疬㧟 20 t Chi陁 t l畁h c黙 m鬾 ph醝" )

				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnMsg2Player( sceneId, selfId,"C醕 h� 疸 gia nh Minh Gi醥!",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 161, 0)
					CallScriptFunction( 222900, "OnDefaultEvent",sceneId, selfId, targetId )
				else
					LuaFnMsg2Player( sceneId, selfId,"C醕 h� 疸 gia nh Minh Gi醥!",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 161, 0)
					CallScriptFunction( 222900, "OnDefaultEvent",sceneId, selfId, targetId )
				end
			else
				BeginEvent(sceneId)
					AddText(sceneId,"G� n鄖 hay g緈 nh�! ng呓i 疸 l� ng叨i c黙 m鬾 ph醝 kh醕, c騨 t緄 t靘 Minh Gi醥 ta l鄊 g�?")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif	GetNumText()==1	then
		BeginEvent(sceneId)
			AddText(sceneId, "#{OBJ_mingjiao_0002}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		for i, findId in x011006_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_MINGJIAO )
				return
			end
		end
	end
	--指路
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "B鄋g V課 Xu鈔 [108,59] c� th� d誽 ng呓i k� n錸g chi猲 黏u c黙 ph醝 ta, 鬾g � ngay b阯 c課h ta")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 108, 59, "B鄋g V課 Xu鈔" )
		return
	end
end

--**********************************
--Ti猵 th薔PCto� 鸬 任务
--**********************************
function x011006_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x011006_g_eventList do
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
--拒绝此NPCto� 鸬 任务
--**********************************
function x011006_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后,要Tr� v玁PCto� 鸬 事件列表
--for i, findId in x011006_g_eventList do
--	if missionScriptId == findId then
--		UpdateEventList( sceneId, selfId, targetId )
--		return
--	end
--end
end

--**********************************
--继续(已经接了任务)
--**********************************
function x011006_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x011006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完to� 鸬 任务
--**********************************
function x011006_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x011006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x011006_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x011006_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

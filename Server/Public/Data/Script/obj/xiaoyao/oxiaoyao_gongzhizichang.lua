--Ti陁 DaoNPC
--公治子长
--普通

x014035_g_scriptId = 014035

--**********************************
--事件交互入口
--**********************************
function x014035_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"G 疴y trong l鷆 v� � ta 疸 t靘 疬㧟 X鋙 t唼ng K� th� n鄖, l鄊 theo trong s醕h, qu� nhi阯 疸 t誳 ra Thi阯 C� Kh鬷 L瞚. T韓h n錸g c黙 ch鷑g phi th叨ng, d叨ng nh� c� th� suy ngh�, c� mu痭 th� ki猲 th裞 kh鬾g?")
		AddNumText(sceneId,x014035_g_scriptId,"衖 th� ki猲 th裞 Thi阯 C� Kh鬷 L瞚",10,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x014035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<81  then	
			BeginEvent( sceneId )
			local strText = "凶ng coi th叨ng k� ngh� C鬾g D� T� Tr叻ng c黙 ta, 鹌ng c ch遖 鹫t 皙n c 81, ta s� kh鬾g 瓞 cho ng呓i nh靚 th Thi阯 C� Kh鬷 L瞚 疴u."
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 144,51,129)
		end
	end
end

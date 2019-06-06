x001154_g_ScriptId = 001154
--**********************************
--事件交互入口
--**********************************
function x001154_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#W� gi鎍 hoang m誧, th ng叨i 痼 餫ng ch� luy畁 m祎 lo読 羗 kh� th k�#Y B錸g Ph醕h Th Ch鈓#W. Do t読 h� kh c, n� hi畃 痼 疸 truy玭 th� c醕h th裞 ch� luy畁 cho t読 h�." )
		AddNumText( sceneId, x001154_g_ScriptId, "#G喧c th鄋h B錸g Ph醕h Th Ch鈓", 6, 1 )
		AddNumText( sceneId, x001154_g_ScriptId, "R秈 kh鰅", 9, 9 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中m祎 项
--**********************************
function x001154_OnEventRequest( sceneId, selfId, targetId, eventId)
	
	if GetNumText() == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "C醕 h� c� x醕 nh d鵱g 20 #GH鄋 B錸g Tinh Th誧h #W瓞 瘊c th鄋h #GBg Ph醕h Th Ch鈓#W?" )
			AddText( sceneId, "C醕 h� c� th� t l読 鹌ng c c黙 #GB錸g Ph醕h Th Ch鈓 #W瓞 鹫t 疬㧟 ch� s� t痠 遳 nh." )
			AddNumText( sceneId, x001154_g_ScriptId, "#GTa 鸢ng �", 6, 11 )
			AddNumText( sceneId, x001154_g_ScriptId, "Hu�", 9, 9 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if GetNumText() == 11 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,19831114)
	end
	
	if GetNumText() == 9 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x001154_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x001154_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

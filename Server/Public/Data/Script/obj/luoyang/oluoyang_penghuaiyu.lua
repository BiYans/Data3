--L誧 D呓ngNPC
--彭怀玉
--普通

x000110_g_scriptId = 000110

--**********************************
--事件交互入口
--**********************************
function x000110_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )

		AddText( sceneId, "    Ng呓i c� th� 餰m m vi阯 B鋙 Th誧h gi痭g nhau h䅟 th鄋h 1 vi阯 B鋙 Th誧h cao h絥 1 c, 餰m nguy阯 li畊 c黙 m vi阯 c th h䅟 th鄋h 1 nguy阯 li畊 cao h絥 1 c, c鹡g c� th� khoan l� kh鋗 B鋙 Th誧h l阯 trang b�, c鹡g c� th� g� b� B鋙 Th誧h" )
		AddNumText( sceneId, x000110_g_scriptId, "Gi緄 thi畊 t韓h n錸g B鋙 Th誧h", 11, 0 )
		AddNumText( sceneId, x000110_g_scriptId, "Gi緄 thi畊 v� k猼 h䅟 nguy阯 li畊", 11, 20 ) -- add by cuiyinjie 20081021
		AddNumText( sceneId, x000110_g_scriptId, "B鋙 Th誧h H䅟 Th鄋h", 6, 1 )
		AddNumText( sceneId, x000110_g_scriptId, "Trang b� khoan", 6, 2 )
		AddNumText( sceneId, x000110_g_scriptId, "Th醥 g� B鋙 Th誧h", 6, 3 )
		AddNumText( sceneId, x000110_g_scriptId, "Nguy阯 li畊 h䅟 th鄋h", 6, 4 )
		AddNumText( sceneId, x000110_g_scriptId, "Kh鋗 B鋙 Th誧h", 6, 5 )
		AddNumText( sceneId, x000110_g_scriptId, "衖陁 Tr醕", 6, 6 )
		AddNumText( sceneId, x000110_g_scriptId, "B鋙 Th誧h Dung Luy畁", 6, 7 )

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中m祎 项
--**********************************
function x000110_OnEventRequest( sceneId, selfId, targetId, eventId )

		---------------------------介绍-------------------------------------------------
		if GetNumText() == 0 then
			BeginEvent(sceneId)	
			
				AddText(sceneId,"#{function_help_054}#r")
			
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 trang b� khoan",11,8);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 h䅟 th鄋h B鋙 Th誧h",11,9);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 kh鋗 B鋙 Th誧h",11,10);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 th醥 g� B鋙 Th誧h",11,11);
--				AddNumText(sceneId, x000110_g_scriptId,"装备修理介绍",11,12);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 餴陁 tr醕 B鋙 Th誧h",11,13);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 v� B鋙 Th誧h Dung Luy畁",11,14);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 v� Thg L㱮 B鋙 Th誧h",11,15);

			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		-- addstart 2008-10-21 add by cuiyinjie
		if GetNumText() == 20 then  -- add by cuiyinjie 材料合成介绍
			BeginEvent(sceneId)			
				AddText(sceneId,"#{SJSJ_081021_001}#r")
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 v� thao t醕 Tinh Thi猼",11,21);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 v� thao t醕 B� Ng鈔",11,22);
				AddNumText(sceneId, x000110_g_scriptId,"Gi緄 thi畊 v� thao t醕 Mi阯 B�",11,23);
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if GetNumText() == 21 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_004}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 22 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_005}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 23 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_006}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		-- addend 2008-10-21 
		
		if GetNumText() == 8 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_039}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 9 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_040}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 10 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_041}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 11 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_042}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 12 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_043}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 13 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{INTERFACE_XML_GemCarve_6}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 14 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{JKBS_081021_022}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if GetNumText() == 15 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{JKBS_081021_023}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end


		--------------------------------------------------------------------------
		if GetNumText() == 1 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 23 )
			return
		end

		if GetNumText() == 2 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 25 )
			return
		end

		if GetNumText() == 3 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 27 )
			return
		end

		if GetNumText() == 4 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 19810424 )
			return
		end

		if GetNumText() == 5 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 19830424 )
			return
		end

		if GetNumText() == 6 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 112236 )
			return
		end

		if GetNumText() == 7 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 112237 )
			return
		end

end

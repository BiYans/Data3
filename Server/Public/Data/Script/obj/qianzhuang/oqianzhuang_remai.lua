--热卖元宝 NPC
--注意本脚本含有随身元宝相关功能,请m祎 定参照现有to� 鸬 例子进行修改.

x181002_g_scriptId 	= 181002
x181002_g_buyrate 	= 0.5

x181002_g_shoptableindex=151
x181002_g_goodact		= 1		--热卖元宝商店
x181002_g_YuanBaoIntro	= 18	--元宝介绍

--**********************************
--事件交互入口
--**********************************
function x181002_OnDefaultEvent( sceneId, selfId, targetId )
	if targetId == -1 then
		x181002_OnEventRequest( sceneId, selfId, targetId, nil )
	else
		BeginEvent( sceneId )
			strText = "    歇n 疴y m� xem, th呓ng ph b醤 ch誽 nh, gi� r� nh. Kh醕h quan, ng鄆 mau ch鱪 v鄆 m髇 餴, b鋙 痄m ng鄆 mua v� xong 痍m nay n m� c鹡g ph鋓 c叨i "
			AddText( sceneId, strText )
			AddNumText( sceneId, x181002_g_scriptId, "S� D鴑g Phi猽 斜i B鋙 Th誧h", 6, 7413)
			AddNumText( sceneId, x181002_g_scriptId, "Gi緄 thi畊 Kim Nguy阯 B鋙", 11, x181002_g_YuanBaoIntro)
			if targetId < 0 then
				targetId = -1	--为了能正常弹出选项
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--事件列表选中m祎 项
--**********************************
function x181002_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 7413 then
		BeginEvent( sceneId )
			AddText( sceneId, "Ng呓i mu痭 鸨i l lo読 b鋙 th誧h n鄌?" )
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h 膐 Minh", 6, 74131)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h M� L馽", 6, 74132)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Sinh M畁h", 6, 74133)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Huy玭 Vi", 6, 74134)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Hy V鱪g", 6, 74135)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Thg L㱮", 6, 74136)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Thi阯 C�", 6, 74137)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h Tr� Tu�", 6, 74138)
			AddNumText( sceneId, x181002_g_scriptId, "B鋙 Th誧h V M畁h", 6, 74139)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	
	if GetNumText() >= 74131 and GetNumText() <= 74139 then
		local key = GetNumText() - 74130
		local GemID = {}
			GemID[1] = {50304002}
			GemID[2] = {50312001,50312002,50312003,50312004}
			GemID[3] = {50311001,50311002}
			GemID[4] = {50303001}
			GemID[5] = {50301001,50301002}
			GemID[6] = {50321001,50321002,50321003,50321004}
			GemID[7] = {50314001}
			GemID[8] = {50302001,50302002,50302003,50302004}
			GemID[9] = {50313001,50313002,50313003,50313004,50313005,50313006}
			
		BeginEvent(sceneId)
			for i = 1, getn(GemID[key]) do
				AddRadioItemBonus( sceneId, GemID[key][i], 1 )
			end
		EndEvent( )
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x181002_g_scriptId,0)
	end

	if GetNumText() == x181002_g_goodact then
		x181002_NewDispatchShopItem( sceneId, selfId,targetId, x181002_g_shoptableindex )
	elseif GetNumText() == x181002_g_YuanBaoIntro	then
		BeginEvent( sceneId )
			AddText( sceneId, "#{INTRO_YUANBAO}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end


function x181002_OnMissionSubmit(sceneId,selfId,targetId,x181002_g_scriptId,ItemID)
	if LuaFnGetAvailableItemCount(sceneId,selfId,30900077) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"Ng呓i kh鬾g c� phi猽 鸨i b鋙 th誧h �?")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"H銀 s x猵 1 � tr痭g trong t鷌 nguy阯 li畊.")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	LuaFnDelAvailableItem(sceneId,selfId,30900077,1)
	local iPos = TryRecieveItem(sceneId,selfId,ItemID,1)
	LuaFnItemBind(sceneId,selfId,iPos)
	
	BeginEvent(sceneId)
		AddText(sceneId,"Ch鷆 m譶g ng呓i 疸 nh 疬㧟 #G"..GetItemName(sceneId,ItemID).."#W.")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,148,0)
end
--**********************************
--按需来弹出商店,分为随身商店和NPC商店
--**********************************
function x181002_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end

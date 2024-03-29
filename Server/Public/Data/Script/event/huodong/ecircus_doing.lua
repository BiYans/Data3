--马戏团活动

--脚本号
x808005_g_ScriptId			= 808005
x808005_g_ScriptId_Ctrl	= 808006	--回调脚本

x808005_g_PrizeBase			= 8000		-- 鹫t 疬㧟大奖to� 鸬 几率基数
x808005_g_PrizeMoney		= 1000		--金钱奖励
x808005_g_Prize0				= 10141041--坐骑
x808005_g_Prize1				= 30308024--骑术
x808005_g_RoundMax			= 50			--m祎 天中可以L頽h to� 鸬 最大环数

--操作集
x808005_g_Key	=
{
	["chg"]			= 100,		--提交珍兽,秏祎 唤崩�
	["inf"]			= 101,		--关于
}

--字串集
x808005_g_Str	=
{
	--不包含转义字符to� 鸬 字串
	["inf2"]		= "  #Wngo鄆 ra ch� c 疬a ra tr鈔 th� b鋙 b鋙 l� 疬㧟, c騨 th裞 錸 Nhu� T� s� tu� ch鱪 m祎 th� trong th裞 錸 ch� 鸶nh c醕 h� mang theo tr阯 ng叨i .",
	["ful"]			= "  Th ng読 qu�, h鬽 nay 瓞 c醕 h� t靘 th裞 錸 v� tr鈔 th� nhi玼 th� n鄖, b阯 t読 h� g nh� 疸 瘘. Hoan ngh阯h l sau 皙n t靘 t読 h�.",
	["bty1"]		= "  #W餫 t� c醕 h� cung c th裞 錸 cho tr鈔 th�, 疴y l� m祎 ch鷗 l騨g th鄋h c黙 t読 h�, xin c醕 h� nh l.",
	["bty2"]		= "  #W餫 t� c醕 h� 疸 l鄊 nhi玼 chuy畁 v� t読 h�. � 疴y c� m祎 con voi v� m祎 quy琻 s醕h d誽 c醕 h� c醕h c咿i voi, xin tg c醕 h�. Voi n呔c ch鷑g t鬷 r qu�, xin c醕 h� h銀 ch錷 s骳 n� t� t�. #r #GTr呔c khi c咿i voi nh thi猼 ph鋓 h鱟 ph呓ng ph醦 c咿i#W.",

	--包含转义字符to� 鸬 字串
	["inf1"]		= "  #WTh� 2 v� th� 6 h鄋g tu 餰m th裞 錸 v� tr鈔 th� b鋙 b鋙 皙n t靘 Nhu� T�. M瞚 l giao tr鈔 th� b鋙 b鋙 Nhu� T� c鹡g l m祎 lo読 trong c醕 th裞 錸 c醕 h� mang theo. M瞚 l giao m祎 Tr鈔 th� v� m祎 lo読 th裞 錸 s� nh 疬㧟 #{_MONEY"..x808005_g_PrizeMoney.."}, ngo鄆 ra c� x醕 su nh 鸶nh s� nh 疬㧟 Voi#G 2 ng叨i c咿i #W.",
	["inf_pet"]	= "  #WTr鈔 th� b鋙 b鋙 Nhu� T� thu mua c�: #r#G%s#W.",
	["inf_itm"]	= "  #WNgo鄆 ra h銀 nh�, khi mang tr鈔 th� b鋙 b鋙 皙n nh� mang theo m祎 lo読 th裞 錸 b k�, n猽 kh鬾g Nhu� T� s� t� ch痠 nh tr鈔 th� b鋙 b鋙. #r#WTh裞 錸 Nhu� T� c c�: #r#G%s#W.",
	["ned_pet"]	= "  #Wt読 h� ch� c nh鎛g tr鈔 th� b鋙 b鋙 sau: #r#G%s#W.",
	["ned_itm"]	= "  #WTr鈔 th� c醕 h� 疬a cho t読 h� l� 瘊ng r癷, nh遪g t読 h� c騨 c m祎 lo読 th裞 錸 b k� sau: #r#G%s#W.",
	["msg_bty"]	= "#R#{_INFOUSR%s} mang tr鈔 th� b鋙 b鋙 v� th裞 錸 皙n cho s� gi� 餺鄋 xi猚 瓞 鬾g ta xem, l鄊 ph th叻ng, 疬a cho 鬾g ta #{_INFOUSR%s} m祎 #{_INFOMSG%s} v� m祎 quy琻 s醕h k� n錸g c咿i th�.",
}

--珍兽集
x808005_g_Pet	=
{
	[1]	= { id = 3099, name = "T韈h D竎h B鋙 B鋙 " },
	[2]	= { id = 3129, name = "Ng誧 Ng� B鋙 B鋙 " },
	[3]	= { id = 3109, name = "Bi琻 B裞 B鋙 B鋙 " },
	[4]	= { id = 3119, name = "羞秐g Lang B鋙 B鋙 " },
	[5]	= { id = 3139, name = "Mi陁 啸u 縩g B鋙 B鋙 " },
	[6]	= { id = 3149, name = "Ch皀 B鋙 B鋙 " },
	[7]	= { id = 3159, name = "H� B鋙 B鋙 " },
	[8]	= { id = 3169, name = "D� Tr� B鋙 B鋙 " },
}

--物品集
x808005_g_Itm	=
{
	[1]	= { id = 30101064, name = "H課h Nh鈔 T�" },
	[2]	= { id = 30101054, name = "B醤h khoai" },
	[3]	= { id = 30101065, name = "Thanh Minh Ba" },
	[4]	= { id = 30101055, name = "Nhu M� Cao" },
	[5]	= { id = 30101066, name = "Ba Ti陁 Ham Ph課" },
	[6]	= { id = 30101056, name = "H呓ng C� Th醝 Bao" },
	[7]	= { id = 30101084, name = "Quan Thang Bao" },
	[8]	= { id = 30101074, name = "Ki陁 Ch Ng� Phi猲" },
	[9]	= { id = 30101085, name = "L誴 Thi陁 H呓ng Loa" },
	[10]= { id = 30101075, name = "M� Ngh頰 Th唼ng Th�" },
	[11]= { id = 30101086, name = "Ph Ch遪g 羛 Nh鴆" },
	[12]= { id = 30101076, name = "B醫 Tr鈔 Thu鏽 K� Thang" },
}

--**********************************
--任务入口函数
--**********************************
function x808005_OnDefaultEvent( sceneId, selfId, targetId )

	--选择按钮
	local	key	= GetNumText()

	--提交珍兽和食物
	if key == x808005_g_Key["chg"] then
		if CallScriptFunction( x808005_g_ScriptId_Ctrl, "IsActivityDoing", sceneId ) == 1 then
			--打开珍兽界面
			str_1	= format( "  #WT読 h� ch� c nh鎛g tr鈔 th� b鋙 b鋙 sau: #r #G%s#W.", x808005_MyGetBuyList( 0 ) )
			str_2	= format( "  #Wv� nh鎛g th裞 錸 sau: #r #G%s#W.", x808005_MyGetBuyList( 1 ) )
			BeginEvent( sceneId )
				AddText( sceneId, str_1 )
				AddText( sceneId, str_2 )
			EndEvent( sceneId )
			DispatchMissionDemandInfo( sceneId, selfId, targetId, x808005_g_ScriptId, -1, 2 )
		else
			x808005_MyNotifyTip( sceneId, selfId, "B鈟 gi� kh鬾g ph鋓 l� th秈 gian ho誸 鸬ng!" )
		end

	--关于
	elseif key == x808005_g_Key["inf"] then
		str_1	= format( x808005_g_Str["inf_pet"], x808005_MyGetBuyList( 0 ) )
		str_2	= format( x808005_g_Str["inf_itm"], x808005_MyGetBuyList( 1 ) )
		BeginEvent( sceneId )
			AddText( sceneId, x808005_g_Str["inf1"] )
			if str_1 ~= nil then
				AddText( sceneId, str_1 )
			end
			if str_2 ~= nil then
				AddText( sceneId, str_2 )
			end
			AddText( sceneId, x808005_g_Str["inf2"] )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end

end

--**********************************
--列举事件
--**********************************
function x808005_OnEnumerate( sceneId, selfId, targetId )

	if CallScriptFunction( x808005_g_ScriptId_Ctrl, "IsActivityDoing", sceneId ) == 1 then
		AddNumText( sceneId, x808005_g_ScriptId, "� ch� t読 h� c� tr鈔 th� b鋙 b鋙 c醕 h� c.", 6, x808005_g_Key["chg"] )
	end
	AddNumText( sceneId, x808005_g_ScriptId, "C醕 ho誸 鸬ng c黙 餺鄋 xi猚", 11, x808005_g_Key["inf"] )

end

--**********************************
--活动奖励
--**********************************
function x808005_MyOnBounty( sceneId, selfId, targetId, indexitm, indexpet )

	local	num_chg	= 0
	local	num_bty	= 0
	
	--当天to� 鸬 环数控制
	--100000to� 鸬 倍数喧ng当前完成to� 鸬 环数,小于100000to� 鸬 数喧ng时间
	--begin modified by zhangguoxin 090207
	local iDayCount	= GetMissionData( sceneId, selfId, MD_CIRCUS_DAYCOUNT )
	if iDayCount == nil or iDayCount < 0 then
		iDayCount			= 0
	end
	local iTime			= iDayCount - floor( iDayCount/100000 ) * 100000
	--local iDayTime	= floor( iTime/100 )									--上m祎 次交或放弃任务to� 鸬 时间(天数)
	local iDayTime	= iTime																	--上m祎 次交或放弃任务to� 鸬 时间(天数)
	--local iQuaTime	= iTime - floor( iTime/100 ) * 100			--上m祎 次交或放弃任务to� 鸬 时间(刻)
	local iDayHuan	= floor( iDayCount/100000 )							--当天内完成to� 鸬 S� l nhi甿 v� 
	--local CurTime		= GetHourTime()													--当前时间
	--local CurDaytime= floor( CurTime/100 )									--当前时间(天)
	local CurDaytime = GetDayTime()														--当前时间(天)
	--local CurQuaTime = CurTime - floor( CurTime/100 ) * 100	--当前时间(刻)
	
	--上次Ho鄋 t nhi甿 v鷑g同m祎 天内
	if CurDaytime == iDayTime then
		iDayHuan			= iDayHuan + 1
		--iQuarterTime	= CurQuaTime
	--上次Ho鄋 t nhi甿 v籘読 同m祎 天,重置
	else
		iDayTime			= CurDaytime
		iQuarterTime	= 0
		iDayHuan			= 0
	end
	if iDayHuan > x808005_g_RoundMax then
		x808005_MyMsgBox( sceneId, selfId, targetId, x808005_g_Str["ful"] )
		return 0
	else
		--iDayCount			= iDayHuan * 100000 + iDayTime * 100 + iQuarterTime
		iDayCount			= iDayHuan * 100000 + iDayTime;
	end
	--end modified by zhangguoxin 090207
	
	--要T読 保证珍兽、物品提交都正确to� 鸬 情形下,再进行逐m祎 删除
	if indexpet < 0 or indexpet >= 255 or LuaFnIsPetAvailable( sceneId, selfId, indexpet ) ~= 1 then
		x808005_MyNotifyTip( sceneId, selfId, "V� hi畊 tr鈔 th�!" )
		return 0
	end
	if indexitm < 0 or indexitm >= 255 or LuaFnIsItemAvailable( sceneId, selfId, indexitm ) ~= 1 then
		x808005_MyNotifyTip( sceneId, selfId, "V� hi畊 th裞 錸!" )
		return 0
	end
	--检查喧ng否喧ng所需珍兽
	local	pet_id		= LuaFnGetPet_DataID( sceneId, selfId, indexpet )
	local	pet_ret		= 0
	local	pet_unt
	for i = 1, getn( x808005_g_Pet ) do
		pet_unt				= x808005_g_Pet[ i ]
		if pet_id == pet_unt.id then
			pet_ret			= 1
			break
		end
	end
	if pet_ret ~= 1 then
		str	= format( x808005_g_Str["ned_pet"], x808005_MyGetBuyList( 0 ) )
		x808005_MyMsgBox( sceneId, selfId, targetId, str )
		return 0
	end
	--检查喧ng否喧ng所需物品
	local	itm_id		= LuaFnGetItemTableIndexByIndex( sceneId, selfId, indexitm )
	local	itm_ret		= 0
	local	itm_unt
	for i = 1, getn( x808005_g_Itm ) do
		itm_unt				= x808005_g_Itm[ i ]
		if itm_id == itm_unt.id then
			itm_ret			= 1
			break
		end
	end
	if itm_ret ~= 1 then
		str	= format( x808005_g_Str["ned_itm"], x808005_MyGetBuyList( 1 ) )
		x808005_MyMsgBox( sceneId, selfId, targetId, str )
		return 0
	end

	--珍兽提交
	if LuaFnDeletePet( sceneId, selfId, indexpet, 1 ) > 0 then
		x808005_MyNotifyTip( sceneId, selfId, "C醕 h� 疬a m祎 con "..pet_unt.name.."." )
	else
		return 0
	end
	--物品提交
	if HaveItemInBag( sceneId, selfId, itm_id ) > 0 and
		LuaFnGetAvailableItemCount( sceneId, selfId, itm_id ) >= 1 and
		DelItem( sceneId, selfId, itm_id, 1 ) > 0 then
		x808005_MyNotifyTip( sceneId, selfId, "C醕 h� 疬a m祎 lo読 "..itm_unt.name.."." )
	else
		return 0
	end

	if pet_ret == 1 and itm_ret == 1 then
		--成功秏祎 籱祎 次,计数无上限
		num_chg			= CallScriptFunction( x808005_g_ScriptId_Ctrl, "OnSuccChange", sceneId )
		--钱奖励
		AddMoney( sceneId, selfId, x808005_g_PrizeMoney )
		--成功送出
		x808005_MyMsgBox( sceneId, selfId, targetId, x808005_g_Str["bty1"] )
		--成功送出后设置环数
		SetMissionData( sceneId, selfId, MD_CIRCUS_DAYCOUNT, iDayCount )
		--Add Log
		LogInfo			= format( "[CIRCUS]: x808005_MyOnBounty( sceneId=%d, GUID=%0X ), pet=%d, itm=%d, num_chg=%d, num_bty=%d, PRIZE_MONEY(%d)",
			sceneId,
			LuaFnObjId2Guid( sceneId, selfId ),
			pet_id, itm_id, num_chg, num_bty, x808005_g_PrizeMoney )
		MissionLog( sceneId, LogInfo )
	else
		return 0
	end

	--大象几率奖励
	if random( x808005_g_PrizeBase ) == 1 and LuaFnGetPropertyBagSpace( sceneId, selfId ) >= 2 then
		--成功大奖m祎 次,计数无上限
		num_bty			= CallScriptFunction( x808005_g_ScriptId_Ctrl, "OnSuccPrize", sceneId )
		if num_bty > 0 then
			local	idBag0	= LuaFnTryRecieveItem( sceneId, selfId, x808005_g_Prize0, 1 )	--坐骑
			local	idBag1	= LuaFnTryRecieveItem( sceneId, selfId, x808005_g_Prize1, 1 )	--骑术
			local	szTran
			if idBag0 >= 0 and idBag1 >= 0 then
				szTran			= GetBagItemTransfer( sceneId, selfId, idBag0 )
				--成功送出
				x808005_MyMsgBox( sceneId, selfId, targetId, x808005_g_Str["bty2"] )
				if szTran ~= nil then
					str				= format( x808005_g_Str["msg_bty"], GetName( sceneId, selfId ), GetName( sceneId, selfId ), szTran )
					x808005_MyGlobalNews( sceneId, str )
				end
				--Add Log
				LogInfo			= format( "[CIRCUS]: x808005_MyOnBounty( sceneId=%d, GUID=%0X ), pet=%d, itm=%d, num_chg=%d, num_bty=%d, PRIZE_ITEM(%d,%d)",
					sceneId,
					LuaFnObjId2Guid( sceneId, selfId ),
					pet_id, itm_id, num_chg, num_bty, x808005_g_Prize0, x808005_g_Prize1 )
				MissionLog( sceneId, LogInfo )
			end
		end
	end
	return 1

end

--**********************************
--玩家提交珍兽后to� 鸬 回调函数
--**********************************
function x808005_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )

	if indexpet >= 255 then
		--索引值Tr� v�255表示空,没提交珍兽
		x808005_MyNotifyTip( sceneId, selfId, "H銀 k閛 tr鈔 th� v鄌 trong c豠 s�!" )
	elseif index1 < 0 or index1 >= 255 then
		x808005_MyNotifyTip( sceneId, selfId, "H銀 k閛 th裞 錸 v鄌 � v ph 馥u ti阯!" )
	else
		x808005_MyOnBounty( sceneId, selfId, npcid, index1, indexpet )
	end

end

--**********************************
--获取收购列表
--**********************************
function x808005_MyGetBuyList( type )

	local	str	= ""
	local	lst
	if type == 0 then
		lst			= x808005_g_Pet
	else
		lst			= x808005_g_Itm
	end

	for i = 1, getn( lst ) do
		if i ~= 1 then
			str		= str..", "
		end
		str		= str..lst[i].name
	end
	return str

end

--**********************************
--对话框提示
--**********************************
function x808005_MyMsgBox( sceneId, selfId, targetId, str )

	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--醒目提示
--**********************************
function x808005_MyNotifyTip( sceneId, selfId, str )

	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )

end

--**********************************
--全球公告
--**********************************
function x808005_MyGlobalNews( sceneId, str )

	if str == nil then
		return
	end
	AddGlobalCountNews( sceneId, str )

end

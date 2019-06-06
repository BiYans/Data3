x741304_g_scriptId = 741304

--**********************************--
--*        On Default Event        *--
--**********************************--
function x741304_OnDefaultEvent(sceneId,selfId,bagIndex)

	--********************--
	--********************--

end
--**********************************--
--*      Is Skill Like Script      *--
--**********************************--
function x741304_IsSkillLikeScript(sceneId,selfId)
	--********************--
	return 1
	--********************--
end
--**********************************--
--*         Cancel Impacts         *--
--**********************************--
function x741304_CancelImpacts(sceneId,selfId)
	--********************--
	return 0
	--********************--
end
--**********************************--
--*       On Condition Check       *--
--**********************************--
function x741304_OnConditionCheck(sceneId,selfId)
	--********************--
	if LuaFnVerifyUsedItem(sceneId,selfId) ~= 1 then
		return 0
	end
	--********************--
	local nIndex = LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	local ItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nIndex)
	
	local Menpai_Rider = {32100000, 32100009, 32100018, 32100019, 32100002, 32100011, 32100005, 32100014, 32100006, 32100015, 32100008, 32100017, 32100010, 32100001, 32100003, 32100012, 32100004, 32100013}
	local Menpai_ID = {0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8}
	for i = 1, getn(Menpai_Rider) do
		if ItemID == Menpai_Rider[i] then
			if GetMenPai(sceneId, selfId) ~= Menpai_ID[i] then
				x741304_NotifyFailTips(sceneId,selfId,"Không th¬ mang kÜ thu§t cüa môn phái khác!")
				return 0
			end
			break;
		end
	end
	--********************--
	local Rider1Data = GetMissionData(sceneId,selfId,CHARRIDER[1])
	local Rider2Data = GetMissionData(sceneId,selfId,CHARRIDER[2])
	
	local RiderUsing = floor(Rider1Data/1000000);
	local Rider1 = mod(floor(Rider1Data/1000),1000);
	local Rider2 = mod(Rider1Data,1000);
	local Rider3 = floor(Rider2Data/1000000);
	local Rider4 = mod(floor(Rider2Data/1000),1000);
	local Rider5 = mod(Rider2Data,1000);
	
	local RiderUsed = mod(ItemID,1000) + 1;
	
	if RiderUsed == Rider1 or RiderUsed == Rider2 or RiderUsed == Rider3 or RiderUsed == Rider4 or RiderUsed == Rider5 then
		x741304_NotifyFailTips(sceneId,selfId,"KÜ thu§t này ðã có trên ngß¶i r°i.")
		return 0
	end
	
	if Rider1 == 0 then
		Rider1 = RiderUsed;
		RiderUsing = 1;
	elseif Rider2 == 0 then
		Rider2 = RiderUsed;
		RiderUsing = 2;
	elseif Rider3 == 0 then
		Rider3 = RiderUsed;
		RiderUsing = 3;
	elseif Rider4 == 0 then
		Rider4 = RiderUsed;
		RiderUsing = 4;
	elseif Rider5 == 0 then
		Rider5 = RiderUsed;
		RiderUsing = 5;
	else
		x741304_NotifyFailTips(sceneId,selfId,"Không th¬ mang theo quá nhi«u thú cßÞi.")
		return 0
	end
	
	Rider1Data = RiderUsing*1000000 + Rider1*1000 + Rider2;
	Rider2Data = Rider3*1000000 + Rider4*1000 + Rider5;
	
	SetMissionData(sceneId,selfId,CHARRIDER[1],Rider1Data)
	SetMissionData(sceneId,selfId,CHARRIDER[2],Rider2Data)
	
	--x741304_NotifyFailTips(sceneId,selfId,Rider1Data)
	--x741304_NotifyFailTips(sceneId,selfId,Rider2Data)
	--********************--
	return 1
	--********************--
end
--**********************************--
--*           On Deplete           *--
--**********************************--
function x741304_OnDeplete(sceneId,selfId)
	--********************--
	if LuaFnDepletingUsedItem(sceneId,selfId) > 0 then
		return 1
	end
	--********************--
	return 0
	--********************--
end
--**********************************--
--*        On Activate Once        *--
--**********************************--
function x741304_OnActivateOnce(sceneId,selfId)
	--********************--	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,74130200)
	--********************--
	return 1
	--********************--
end
--**********************************--
--*        On Default Event        *--
--**********************************--
function x741304_OnActivateEachTick(sceneId,selfId)
	--********************--
	return 1
	--********************--
end

function x741304_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x741304_UnMount(sceneId,selfId,Select)
	if Select >= 1 and Select <= 5 then --UnMount--
		local Rider1Data = GetMissionData(sceneId,selfId,CHARRIDER[1])
		local Rider2Data = GetMissionData(sceneId,selfId,CHARRIDER[2])
		
		local RiderUsing = 0;
		local Rider1 = mod(floor(Rider1Data/1000),1000);
		local Rider2 = mod(Rider1Data,1000);
		local Rider3 = floor(Rider2Data/1000000);
		local Rider4 = mod(floor(Rider2Data/1000),1000);
		local Rider5 = mod(Rider2Data,1000);
		
		local RiderUnMount = -1;
		if Select == 1 then
			if Rider1 ~= 0 then
				RiderUnMount = Rider1 - 1;
				Rider1 = 0;
			end
		end
		if Select == 2 then
			if Rider2 ~= 0 then
				RiderUnMount = Rider2 - 1;
				Rider2 = 0;
			end
		end
		if Select == 3 then
			if Rider3 ~= 0 then
				RiderUnMount = Rider3 - 1;
				Rider3 = 0;
			end
		end
		if Select == 4 then
			if Rider4 ~= 0 then
				RiderUnMount = Rider4 - 1;
				Rider4 = 0;
			end
		end
		if Select == 5 then
			if Rider5 ~= 0 then
				RiderUnMount = Rider5 - 1;
				Rider5 = 0;
			end
		end
		
		if RiderUnMount == -1 then
			return
		end
		
		if LuaFnGetPropertyBagSpace(sceneId,selfId) <= 0 then
			x741304_NotifyFailTips(sceneId,selfId,"Không ðü ch² tr¯ng trên tay näi!")
			return
		end
		
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,5100+RiderUnMount) ~= 0 then
			LuaFnCancelSpecificImpact(sceneId,selfId,5100+RiderUnMount)
		end
		
		local NewMount = TryRecieveItem(sceneId,selfId,32100000+RiderUnMount,1)
		LuaFnItemBind(sceneId,selfId,NewMount)
		
		if Rider5 ~= 0 then
			RiderUsing = 5
		end
		if Rider4 ~= 0 then
			RiderUsing = 4
		end
		if Rider3 ~= 0 then
			RiderUsing = 3
		end
		if Rider2 ~= 0 then
			RiderUsing = 2
		end
		if Rider1 ~= 0 then
			RiderUsing = 1
		end
		
		Rider1Data = RiderUsing*1000000 + Rider1*1000 + Rider2;
		Rider2Data = Rider3*1000000 + Rider4*1000 + Rider5;
		SetMissionData(sceneId,selfId,CHARRIDER[1],Rider1Data)
		SetMissionData(sceneId,selfId,CHARRIDER[2],Rider2Data)
		
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,74130200)
	end
	if Select >= 6 and Select <= 10 then --SetMount--
		local Selection = Select - 5;
		local Rider1Data = GetMissionData(sceneId,selfId,CHARRIDER[1])
		local Rider1 = mod(floor(Rider1Data/1000),1000);
		local Rider2 = mod(Rider1Data,1000);
		Rider1Data = Selection*1000000 + Rider1*1000 + Rider2;
		
		SetMissionData(sceneId,selfId,CHARRIDER[1],Rider1Data)
		
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,74130201)
	end
end

function x741304_OnImpactFadeOut( sceneId, selfId )
	
	local Rider1Data = GetMissionData(sceneId,selfId,CHARRIDER[1])
	local Rider2Data = GetMissionData(sceneId,selfId,CHARRIDER[2])
	
	local RiderUsing = floor(Rider1Data/1000000);
	local Rider1 = mod(floor(Rider1Data/1000),1000);
	local Rider2 = mod(Rider1Data,1000);
	local Rider3 = floor(Rider2Data/1000000);
	local Rider4 = mod(floor(Rider2Data/1000),1000);
	local Rider5 = mod(Rider2Data,1000);

	if Rider1 == 0 and Rider2 == 0 and Rider3 == 0 and Rider4 == 0 and Rider5 == 0 then
		x741304_NotifyFailTips(sceneId,selfId,"Không có kÜ thu§t trên ngß¶i.")
		return
	end
	
	local MountID = 0;
	
	if RiderUsing == 1 then
		MountID = Rider1;
	end
	
	if RiderUsing == 2 then
		MountID = Rider2;
	end
	
	if RiderUsing == 3 then
		MountID = Rider3;
	end
	
	if RiderUsing == 4 then
		MountID = Rider4;
	end
	
	if RiderUsing == 5 then
		MountID = Rider5;
	end
	
	if MountID == 0 then
		x741304_NotifyFailTips(sceneId,selfId,"Vui lòng lña ch÷n kÜ thu§t mu¯n sØ døng.")
		return
	end
	
	local MountImpact = 5099 + MountID;
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,MountImpact,0)
end
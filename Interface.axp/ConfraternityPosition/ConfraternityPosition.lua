local GUILD_POSITION_SIZE = 10; --×î¶à¿ÉÓÃÖ°Î»Êý

function ConfraternityPosition_PreLoad()
	this:RegisterEvent("GUILD_SHOW_APPOINTPOS");
	this:RegisterEvent("GUILD_FORCE_CLOSE");
end

function ConfraternityPosition_OnLoad()
end

function ConfraternityPosition_OnEvent(event)
	if(event == "GUILD_SHOW_APPOINTPOS") then
		ConfraternityPosition_PositionList:ClearListBox();
		local i = 0;
		while i < GUILD_POSITION_SIZE do
			local szMsg = Guild:GetMyGuildInfo("Appoint", i);
			--AxTrace(0,0,"Guild Position:"..tostring(i).." pos:"..tostring(szMsg));
			if(nil ~= szMsg and "" ~= szMsg) then
				ConfraternityPosition_PositionList:AddItem(szMsg,i);
			else
				break;
			end
			i = i + 1;
		end
		
		if(nil ~= Guild:GetMyGuildInfo("Appoint", 0)) then
			ConfraternityPosition_PositionList:SetItemSelectByItemID(0);
		end
		this:Show();
	elseif(event == "GUILD_FORCE_CLOSE") then
		this:Hide();
	end
end

function Guild_Position_Confirm()
	local selidx = ConfraternityPosition_PositionList:GetFirstSelectItem();
	-- add by zchw 
	local szMsg = Guild:GetMyGuildInfo("Appoint", selidx);
	if szMsg == "Thß½ng nhân " then
		local Num = Guild:GetMemberBak();
		local szLvl = Guild:GetMembersInfo(Num, "Level");	
		if szLvl < 40 then
			PushDebugMessage("Bang Chúng dß¾i c¤p 40 không th¬ ðßþc nh§n chÑc là Thß½ng Nhân !");
			return;
		end
	-- end
	end	
	if(-1 ~= selidx) then
		--µ÷ÓÃÈÎÃü½Ó¿Ú
		Guild:AdjustMemberAuth(selidx);
	end
	this:Hide();
end
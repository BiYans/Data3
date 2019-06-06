local g_TabMsgData = {};


function NewMsgBallHistory_PreLoad()
	this:RegisterEvent("TOGGLE_MSGHISTORY");
	this:RegisterEvent("OPEN_MSGHISTORY");

end


function NewMsgBallHistory_OnLoad()
	NewMsgBallHistory_MsgList:AddColumn( "Th秈 gian", 0, 0.3 );
	NewMsgBallHistory_MsgList:AddColumn( "Ti陁 皤", 1, 0.7 );

	NewMsgBallHistory_MsgList:SetProperty( "ColumnsSizable", "False" );
	NewMsgBallHistory_MsgList:SetProperty( "ColumnsAdjust", "True" );
	NewMsgBallHistory_MsgList:SetProperty( "ColumnsMovable", "False" );
end

function NewMsgBallHistory_OnEvent(event)
	if event == "TOGGLE_MSGHISTORY" then
		if( this:IsVisible() ) then
			this:Hide();
		else
			NewMsgBallHistory_Show();
		end
	elseif event == "OPEN_MSGHISTORY" then
		NewMsgBallHistory_Show();
	end
end

--显示界面
function NewMsgBallHistory_Show()
	
	NewMsgBallHistory_PersonInfo:Disable();
	NewMsgBallHistory_GuildInfo:Disable();
	NewMsgBallHistory_MsgList:RemoveAllItem();
	NewMsgBallHistory_Desc:ClearAllElement();
	g_TabMsgData = {}
	
	local msgCount = DataPool:GetMsgNum();
	local k = 1;
	
	if msgCount > 0 then
		for i = msgCount , 1 , -1 do
			local nTime , nTitle		= DataPool:GetMsgTimeTitle(i-1);
			local nPlayerName , nGuildId	= DataPool:GetMsgPlayerGuild(i-1);
			local nMsgDesc			= DataPool:GetMsgDetail(i-1);
			local nMsgType			= DataPool:GetMsgType(i-1);
			g_TabMsgData[k] = {}
			g_TabMsgData[k].m_Time		= nTime;
			g_TabMsgData[k].m_Title		= nTitle;
			g_TabMsgData[k].m_PlayerName	= nPlayerName;
			g_TabMsgData[k].m_GuildId	= nGuildId;
			g_TabMsgData[k].m_Desc		= nMsgDesc;
			g_TabMsgData[k].m_Type		= nMsgType;
			k = k + 1
		end
	end

	local nTabListCount = table.getn( g_TabMsgData );
	
	for i=1, nTabListCount do
		if g_TabMsgData[i].m_Type == 0 then
			NewMsgBallHistory_MsgList:AddNewItem( "#cff0000"..g_TabMsgData[i].m_Time, 0, i-1 );
			NewMsgBallHistory_MsgList:AddNewItem( "#cff0000"..g_TabMsgData[i].m_Title, 1, i-1 );
		else
			NewMsgBallHistory_MsgList:AddNewItem( g_TabMsgData[i].m_Time, 0, i-1 );
			NewMsgBallHistory_MsgList:AddNewItem( g_TabMsgData[i].m_Title, 1, i-1 );
		end

	end

	NewMsgBallHistory_MsgList:SetSelectItem(0);
	
	this:Show();
end

--改变选中项
function NewMsgBallHistory_OnSelectionChanged()
	
	local nSelected = NewMsgBallHistory_MsgList:GetSelectItem();
	local nTabListCount = table.getn( g_TabMsgData );

	if nSelected < 0 or nSelected >= nTabListCount then
		return
	end
	local nTabListCount = table.getn( g_TabMsgData );

	NewMsgBallHistory_Desc:ClearAllElement();
	NewMsgBallHistory_Desc:AddTextElement(g_TabMsgData[nSelected + 1].m_Desc);

	NewMsgBallHistory_PersonInfo:Enable()
	NewMsgBallHistory_GuildInfo:Enable()
	
	if g_TabMsgData[nSelected + 1].m_PlayerName == "" then
		NewMsgBallHistory_PersonInfo:Disable()
	end

	if g_TabMsgData[nSelected + 1].m_GuildId < 0 then
		NewMsgBallHistory_GuildInfo:Disable()
	end
end


--查看玩家资料
function NewMsgBallHistory_PersonInfo_Clicked()
	local nSelected = NewMsgBallHistory_MsgList:GetSelectItem();
	local szName = g_TabMsgData[nSelected + 1].m_PlayerName

	if(nil ~= szName) then
		if( Friend:IsPlayerIsFriend( szName ) == 1 ) then	
			local nGroup,nIndex;
			nGroup,nIndex = DataPool:GetFriendByName( szName );
			DataPool:ShowFriendInfo( szName );
		else
			DataPool:ShowChatInfo( szName );
		end
	end
end

--查看帮会信息
function NewMsgBallHistory_GuildInfo_Clicked()
	local nSelected = NewMsgBallHistory_MsgList:GetSelectItem();
	local GuildID	= g_TabMsgData[nSelected + 1].m_GuildId
	
	if(nil ~= GuildID) then
		Guild:AskAnyGuildDetailInfo(tonumber(GuildID))
	end
end

--关闭
function NewMsgBallHistory_Quit_Clicked()
	this:Hide();
end

--Help
function NewMsgBallHistory_OnHelp()
	Helper:GotoHelper("*NewMsgBallHistory" );
end
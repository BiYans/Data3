-- 界面的默认位置
local g_UnifiedXPosition;
local g_UnifiedYPosition;

local g_IsTeamOutLine = {}
local g_TeamOutLineStr = {}
local g_GroupID = -1

local g_imgStatus = {}

function Friend_IMGroupInvite_PreLoad()
	this:RegisterEvent("OPEN_IMGROUP_INVITE")
	-- 游戏窗口尺寸发生了变化
	this:RegisterEvent("ADJEST_UI_POS")

	-- 游戏分辨率发生了变化
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end


function Friend_IMGroupInvite_OnLoad()
	-- 保存界面的默认相对位置
	g_UnifiedXPosition	= Friend_IMGroupInvite_Frame:GetProperty("UnifiedXPosition");
	g_UnifiedYPosition	= Friend_IMGroupInvite_Frame:GetProperty("UnifiedYPosition");
	
	
	g_IsTeamOutLine = {0,0,0,0}
	g_TeamOutLineStr = {
							"#{LTQH_XML_79}"	,
							"#{LTQH_XML_80}"	,
							"#{LTQH_XML_81}" 	,
							"#{LTQH_XML_82}"	,
						}
	g_imgStatus = {
			[0] = { [0] = "#-27" ,[1] = "#-29" ,[2] = "#-30"} ,
			[1] = { [0] = "#-23" ,[1] = "#-25" ,[2] = "#-26"} ,
		}
end


function Friend_IMGroupInvite_OnEvent(event)
	if ( event == "OPEN_IMGROUP_INVITE" ) then
		g_GroupID = tonumber(arg0)
		Friend_IMGroupInvite_Show()
	elseif( event == "ADJEST_UI_POS" ) then
		Friend_IMGroupInvite_ResetPos()
	elseif( event == "VIEW_RESOLUTION_CHANGED" ) then
		Friend_IMGroupInvite_ResetPos()
	end
end


function Friend_IMGroupInvite_Hide()
	this:Hide()
end
function Friend_IMGroupInvite_Show()
	Friend_IMGroupInvite_FriendList:ClearListBox()
	Friend_IMGroupInvite_InvitedList:ClearListBox()
	local strGroupName = ""
	for i = 0 , 3 do
		strGroupName = DataPool:GetGroupingName(i)
		if strGroupName ~= "" then
			g_TeamOutLineStr[i+1] = strGroupName
		end
	end
	Friend_IMGroupInvite_FriendList_Update()
	this:Show()
end

function Friend_IMGroupInvite_FriendList_Update()
	Friend_IMGroupInvite_FriendList:ClearListBox()
--一4组好友 ，不包括黑名单、仇人、临时好友
	for i = 1 , 4 do
		local strOutlineName = ""
		if g_IsTeamOutLine[i] == 1 then
			strOutlineName = "#gFE7E82- " .. g_TeamOutLineStr[i]
		else
			strOutlineName = "#gFE7E82+ " .. g_TeamOutLineStr[i]
		end
		
		if( strOutlineName ~= "" or strOutlineName ~= 0 ) then
			local iStart = i*10000;
			local friendnumber = DataPool:GetFriendNumber( tonumber( i ) );
			if friendnumber < 1 then 
				strOutlineName = "#gFE7E82- " .. g_TeamOutLineStr[i]
			end
			Friend_IMGroupInvite_FriendList:AddItem( strOutlineName, iStart )
			if( 1 == g_IsTeamOutLine[ i ] ) then
				local index=0;
				while index < friendnumber  do
					local name = DataPool:GetFriend( i, index, "NAME" );
					local friendship = DataPool:GetFriend( i, index, "FRIENDSHIP" );
					local relationtype = DataPool:GetFriend( i, index, "RELATION_TYPE" );
				
					local namecolor = "#cC4B299";

					local IMst = DataPool:GetFriend( i, index, "IM_STATUS" );
					local Sex = DataPool:GetFriend( i, index, "SEX" );
					local playerIcon = "    "	
					
					if( DataPool:GetFriend( i, index, "ONLINE" ) ) then
						if( nChannel == 6 ) then
							namecolor="#cFF0000";	
						else
							if( relationtype == 7 or relationtype == 8) then
								namecolor = "#cFF6600";	
							elseif( relationtype == 3 ) then
								namecolor = "#cF246F0";		
							elseif( relationtype == 2 ) then
								namecolor = "#c007EFF";		
							elseif( friendship >= 10 ) then 
									namecolor = "#c00FF00";		
							elseif( friendship >= 1 ) then	
									namecolor = "#c00C800";		
							elseif( friendship == 0 ) then	
									namecolor = "#cFFFFFF";		
							end
						end
						if tonumber(IMst) >= 0 and tonumber(IMst) <=2  and tonumber(Sex) >=0 and tonumber(Sex) <= 1 then
							playerIcon = g_imgStatus[Sex][IMst]
						end
						Friend_IMGroupInvite_FriendList:AddItem("  "..playerIcon..namecolor..name , iStart + index + 1)
					else
						if( nChannel == 6 ) then
							namecolor="#cc7b299";
						end
						Friend_IMGroupInvite_FriendList:AddItem("  "..playerIcon..namecolor..name , iStart + index + 1)
					end
					index = index + 1;
				end
			end
		end
	end
end

function Friend_IMGroupInvite_FriendList_SelectChanged()
	local nSelIndex = Friend_IMGroupInvite_FriendList:GetFirstSelectItem();
	local iMod = math.mod( nSelIndex, 10000 )
	local iFloor = math.floor( nSelIndex / 10000 );
	if( 0 == iMod ) then
		if( 0 == g_IsTeamOutLine[ iFloor ] ) then
			g_IsTeamOutLine[ iFloor ] = 1
		else
			g_IsTeamOutLine[ iFloor ] = 0
		end
		Friend_IMGroupInvite_FriendList_Update()
		return
	end	
end


function Friend_IMGroupInvite_Add_One()
	local index = Friend_IMGroupInvite_FriendList:GetFirstSelectItem();
	if index < 0 then
		return
	end
	local iMod = math.mod( index, 10000 )
	local iFloor = math.floor( index / 10000 );

	local name = DataPool:GetFriend( iFloor, iMod - 1, "NAME" );
	
	local isHave = Friend_IMGroupInvite_InvitedList:GetItemNumByItemId(index)
	if isHave == -1 then
		Friend_IMGroupInvite_InvitedList:AddItem(name ,	index );	
	end

end


function Friend_IMGroupInvite_Del_One()
	local itemID = Friend_IMGroupInvite_InvitedList:GetFirstSelectItem();
	if itemID < 0 then
		return
	end
	local index = Friend_IMGroupInvite_InvitedList:GetItemNumByItemId(itemID)
	if index >= 0 then
		Friend_IMGroupInvite_InvitedList:DelItem(index);
	end
		
end


function Friend_IMGroupInvite_Invite()
	local num = Friend_IMGroupInvite_InvitedList:GetItemNumber()
	if num < 1 then
		return
	end

	for i = 1 , num  do
		local str , itemID = Friend_IMGroupInvite_InvitedList:GetItem(i)
		
		local iMod = math.mod( itemID, 10000 )
		local iFloor = math.floor( itemID / 10000 );

		DataPool:InviteFriendJoinGroup(iFloor, iMod - 1 , g_GroupID);
	end
	
	Friend_IMGroupInvite_Hide()
end


function Friend_IMGroupInvite_FriendList_DClicked()
	local index = Friend_IMGroupInvite_FriendList:GetFirstSelectItem();
	if index < 0 then
		return
	end
	local iMod = math.mod( index, 10000 )
	local iFloor = math.floor( index / 10000 );

	local name = DataPool:GetFriend( iFloor, iMod - 1, "NAME" );
	
	local isHave = Friend_IMGroupInvite_InvitedList:GetItemNumByItemId(index)
	if isHave == -1 then
		Friend_IMGroupInvite_InvitedList:AddItem(name ,	index );	
	end
end

function Friend_IMGroupInvite_InvitedList_DClicked()
	local itemID = Friend_IMGroupInvite_InvitedList:GetFirstSelectItem();
	if itemID < 0 then
		return
	end
	local index = Friend_IMGroupInvite_InvitedList:GetItemNumByItemId(itemID)
	if index >= 0 then
		Friend_IMGroupInvite_InvitedList:DelItem(index);
	end
end

function Friend_IMGroupInvite_ResetPos()
	Friend_IMGroupInvite_Frame:SetProperty("UnifiedXPosition", g_UnifiedXPosition);
	Friend_IMGroupInvite_Frame:SetProperty("UnifiedYPosition", g_UnifiedYPosition);
end
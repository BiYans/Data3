
local  g_TeamOutLineStr = {}

local  g_Name = ""
function Friend_IMGrouping_PreLoad()
	this:RegisterEvent("OPEN_ADDFRIEND_GROUPING");

end

function Friend_IMGrouping_OnLoad()
	g_TeamOutLineStr = {
							{str = "#{LTQH_XML_79}"	, nIndex = 1},
							{str = "#{LTQH_XML_80}"	, nIndex = 2},
							{str = "#{LTQH_XML_81}" , nIndex = 3},
							{str = "#{LTQH_XML_82}"	, nIndex = 4},
							{str = "临时好友"		, nIndex = 8},
						}

end

function Friend_IMGrouping_OnEvent(event)
	if event == "OPEN_ADDFRIEND_GROUPING" then
		g_Name = tostring(arg0)
		Friend_IMGrouping_Show()
	
	end
end



function Friend_IMGrouping_Show()
	Friend_IMGrouping_Select:ResetList()
	local strGroupName = ""
	for i = 0 , 3 do
		strGroupName = DataPool:GetGroupingName(i)
		if strGroupName ~= "" then
			Friend_IMGrouping_Select:AddTextItem(strGroupName  , i + 1);
		else
			Friend_IMGrouping_Select:AddTextItem(g_TeamOutLineStr[i+1].str  , g_TeamOutLineStr[i+1].nIndex);
		end
	end
	
	Friend_IMGrouping_Select:AddTextItem(g_TeamOutLineStr[5].str  , g_TeamOutLineStr[5].nIndex);
	
	Friend_IMGrouping_Select:SetCurrentSelect(0)
	Friend_IMGrouping_Text:SetText("  #cFFF263你已经确定将#G"..tostring(g_Name).."#cFFF263加为好友，请选择其分组")
	this:Show();

end


function Friend_IMGrouping_Hide()
	g_Name = ""
	this:Hide()
end

function Friend_IMGrouping_OK_Clicked()
	local str , nIndex = Friend_IMGrouping_Select:GetCurrentSelect()
	if g_Name ~= "" then
		DataPool:AddFriend(tonumber(nIndex) , g_Name) ;
	end
	Friend_IMGrouping_Hide();	
end
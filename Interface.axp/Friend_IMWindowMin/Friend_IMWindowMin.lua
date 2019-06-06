
local g_MinWinFrame = {}

function Friend_IMWindowMin_PreLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UPDATE_MIN_WINDOW");

end


function Friend_IMWindowMin_OnLoad()
	g_MinWinFrame = {
		{ctrl = Friend_IMWindowMin_IM1, flash = Friend_IMWindowMin_Flash1 ,bShow = 0 , sName = "" , bGroup = 0 },
		{ctrl = Friend_IMWindowMin_IM2, flash = Friend_IMWindowMin_Flash2 ,bShow = 0 , sName = "" , bGroup = 0 },
		{ctrl = Friend_IMWindowMin_IM3, flash = Friend_IMWindowMin_Flash3 ,bShow = 0 , sName = "" , bGroup = 0 },
		{ctrl = Friend_IMWindowMin_IM4, flash = Friend_IMWindowMin_Flash4 ,bShow = 0 , sName = "" , bGroup = 0 },
		{ctrl = Friend_IMWindowMin_IM5, flash = Friend_IMWindowMin_Flash5 ,bShow = 0 , sName = "" , bGroup = 0 },
	}

end

function Friend_IMWindowMin_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:Show();
		Friend_IMWindowMin_Update()
	elseif ( event == "UPDATE_MIN_WINDOW" ) then
		Friend_IMWindowMin_Update()
		
	end
end

function Friend_IMWindowMin_Update()
		for i = 0 , 4 do
			local isShow  , szName , isGroup ,isShine= DataPool:GetMinWindowInfo(i)
			--PushDebugMessage(tostring(i).." : "..szName.." : "..tostring(isShow))
			if 	isShow > 0 then
				g_MinWinFrame[i+1].bShow = isShow
				g_MinWinFrame[i+1].sName = szName
				g_MinWinFrame[i+1].bGroup = isGroup
				g_MinWinFrame[i+1].ctrl:Show()
				g_MinWinFrame[i+1].ctrl:SetText(tostring(szName))	
				if isShine == 1 then
					g_MinWinFrame[i+1].flash:Show()
				else
					g_MinWinFrame[i+1].flash:Hide()
				end
			else
				g_MinWinFrame[i+1].bShow = 0
				g_MinWinFrame[i+1].sName = ""
				g_MinWinFrame[i+1].bGroup = 0	
				g_MinWinFrame[i+1].ctrl:Hide()	
				g_MinWinFrame[i+1].flash:Hide()				
			end
		end
end

function Friend_IMWindowMin_Pop(index)
	DataPool:PopMinWindow(g_MinWinFrame[index].bGroup , g_MinWinFrame[index].sName)
end
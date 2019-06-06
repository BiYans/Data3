
local g_nSaveOrGetMoney;

local SAVE_MONEY				= 1;
local GET_MONEY					= 2;
local EXCHANGE_MONEY 		= 3;
local STALLSALE_PRICE		= 4;
local STALLSALE_REPRICE	= 5;
local PS_PRICE_ITEM		  = 6;
local PS_IMMITBASE			= 7;
local PS_IMMIT					= 8;
local PS_DRAW						= 9;
local STALL_PET_UP			= 10;
local STALL_PRICE_PET		= 11;
local PS_PRICE_PET			= 12;
local PS_TRANSFER				= 13;
local SAFEBOX_GET_MONEY = 14;
local SAFEBOX_SAVE_MONEY= 15;

--–ﬁ∏ƒÃØŒªŒÔ∆∑º€∏Ò–Ë“™µƒ
local nStallItemID = -1;
local nStallItemIndex = -1;

--===============================================
-- OnLoad()
--===============================================
function InputMoney_PreLoad()
	this:RegisterEvent("TOGLE_INPUT_MONEY");
	
	this:RegisterEvent("BEING_MONEY");
	this:RegisterEvent("CLOSE_INPUT_MONEY");
	
end

function InputMoney_OnLoad()
	
end

--===============================================
-- OnEvent
--===============================================
function InputMoney_OnEvent(event)

	if(event == "TOGLE_INPUT_MONEY") then
		if(arg0~="price")then
			StallSale:UnlockSelItem();
		end
		if (arg0 == "get") then
			this:TogleShow();
			
			
			g_nSaveOrGetMoney = GET_MONEY;
			InputMoney_Title:SetText("#gFF0FA0R˙t ti´n");
			InputMoney_Accept_Button:SetText("DuyÆt");
			
		elseif (arg0 == "save") then
			this:TogleShow();
			
			g_nSaveOrGetMoney = SAVE_MONEY;
			InputMoney_Title:SetText("#gFF0FA0Gÿi ti´n");
			InputMoney_Accept_Button:SetText("DuyÆt");
			
		elseif (arg0 == "exch") then
			this:TogleShow();
		
			g_nSaveOrGetMoney = EXCHANGE_MONEY;
			InputMoney_Title:SetText("#gFF0FA0Nhßp v‡o ng‚n lﬂ˛ng giao d∏ch");
			InputMoney_Accept_Button:SetText("DuyÆt");
			
		elseif (arg0 == "get_safebox") then
			this:TogleShow();
		
			g_nSaveOrGetMoney = SAFEBOX_GET_MONEY;
			InputMoney_Title:SetText("#gFF0FA0 –i´n v‡o sØ lﬂ˛ng ti´n v‡ng c•n r˙t");
			InputMoney_Accept_Button:SetText("DuyÆt");
		
		elseif (arg0 == "save_safebox") then
			this:TogleShow();
		
			g_nSaveOrGetMoney = SAFEBOX_SAVE_MONEY;
			InputMoney_Title:SetText("#gFF0FA0 –i´n v‡o sØ lﬂ˛ng ti´n v‡ng c•n c§t");
			InputMoney_Accept_Button:SetText("DuyÆt");
		
		elseif (arg0 == "price") then
			this:Show();
			
			g_nSaveOrGetMoney = STALLSALE_PRICE;
			InputMoney_Title:SetText("#gFF0FA0Gi· thﬂΩng ph¶m");
			InputMoney_Accept_Button:SetText("LÍn gi·");
			
		elseif (arg0 == "reprice") then
			this:TogleShow();
			
			g_nSaveOrGetMoney = STALLSALE_REPRICE;
			InputMoney_Title:SetText("#gFF0FA0Thay ±i b·o gi·");
			InputMoney_Accept_Button:SetText("–±i");
			
		--ÕÊº“…ÃµÍ…œº‹(ŒÔ∆∑)
		elseif (arg0 == "ps_upitem" ) then
			this:Show();
			g_nSaveOrGetMoney = PS_PRICE_ITEM;
			InputMoney_Title:SetText("#gFF0FA0Gi· thﬂΩng ph¶m");
			InputMoney_Accept_Button:SetText("LÍn gi·");
			
		elseif (arg0 == "ps_uppet" ) then
			this:Show();
			g_nSaveOrGetMoney = PS_PRICE_PET;
			InputMoney_Title:SetText("#gFF0FA0Gi· Tr‚n th˙");
			InputMoney_Accept_Button:SetText("LÍn gi·");
		
--		--ÕÊº“…ÃµÍ≥Â»Î±æΩ
--		elseif (arg0 == "immitbase") then
--			this:Show();
--			g_nSaveOrGetMoney = PS_IMMITBASE;
--			InputMoney_Title:SetText("#gFF0FA0≥‰»Î±æΩ");
--			InputMoney_Accept_Button:SetText("»∑∂®");
--		
--		--ÕÊº“…ÃµÍ≥Â»Î
--		elseif (arg0 == "immit") then
--			this:Show();
--			g_nSaveOrGetMoney = PS_IMMIT;
--			InputMoney_Title:SetText("#gFF0FA0≥‰»Î");
--			InputMoney_Accept_Button:SetText("»∑∂®");
--		
--		--ÕÊº“…ÃµÍ»°≥ˆ
--		elseif (arg0 == "draw") then
--			this:Show();
--			g_nSaveOrGetMoney = PS_DRAW;
--			InputMoney_Title:SetText("#gFF0FA0÷ß»°");
--			InputMoney_Accept_Button:SetText("»∑∂®");
			
		elseif (arg0 == "st_pet") then
			this:Show();
			g_nSaveOrGetMoney = STALL_PET_UP;
			InputMoney_Title:SetText("#gFF0FA0Gi· Tr‚n th˙");
			InputMoney_Accept_Button:SetText("LÍn gi·");
		
		elseif (arg0 == "petrepice") then
			this:Show();
			g_nSaveOrGetMoney = STALL_PRICE_PET;
			InputMoney_Title:SetText("#gFF0FA0Gi· Tr‚n th˙");
			InputMoney_Accept_Button:SetText("DuyÆt");
			
		elseif (arg0 == "transfershop") then
			this:Show();
			g_nSaveOrGetMoney = PS_TRANSFER;
			InputMoney_Title:SetText("#gFF0FA0–∏nh gi· h‡ng");
			InputMoney_Accept_Button:SetText("DuyÆt");
			
		end
		
		InputMoney_Gold:SetText("");
		InputMoney_Silver:SetText("");
		InputMoney_CopperCoin:SetText("");
		InputMoney_Accept_Button:Disable();
		
		if (g_nSaveOrGetMoney == GET_MONEY) then
			local nMoney,nGold,nSilver,nCopper = Bank:GetBankMoney();
			if nGold>99999 then nGold = 99999; nSilver = 99; nCopper = 99; end
			if (nGold == 0) then 
				if (nSilver == 0) then
					InputMoney_Gold:SetText(tostring(nGold));
					InputMoney_Silver:SetText(tostring(nSilver));
					InputMoney_CopperCoin:SetText(tostring(nCopper));
					InputMoney_CopperCoin:SetSelected(0,-1);
					InputMoney_CopperCoin:SetProperty("DefaultEditBox", "True");
				else
					InputMoney_Gold:SetText(tostring(nGold));
					InputMoney_Silver:SetText(tostring(nSilver));
					InputMoney_Silver:SetSelected(0,-1);
					InputMoney_Silver:SetProperty("DefaultEditBox", "True");
					InputMoney_CopperCoin:SetText("0");
				end
			else
				InputMoney_Gold:SetText(tostring(nGold));
				InputMoney_Gold:SetSelected(0,-1);
				InputMoney_Gold:SetProperty("DefaultEditBox", "True");
				InputMoney_Silver:SetText("0");
				InputMoney_CopperCoin:SetText("0");
			end
			
		elseif (g_nSaveOrGetMoney == SAVE_MONEY) then
			local nGold,nSilver,nCopper = Bank:GetBagMoney();
			if nGold>99999 then nGold = 99999; nSilver = 99; nCopper = 99; end
			if (nGold == 0) then 
				if (nSilver == 0) then
					InputMoney_Gold:SetText(tostring(nGold));
					InputMoney_Silver:SetText(tostring(nSilver));
					InputMoney_CopperCoin:SetText(tostring(nCopper));
					InputMoney_CopperCoin:SetSelected(0,-1);
					InputMoney_CopperCoin:SetProperty("DefaultEditBox", "True");
				else
					InputMoney_Gold:SetText(tostring(nGold));
					InputMoney_Silver:SetText(tostring(nSilver));
					InputMoney_Silver:SetSelected(0,-1);
					InputMoney_Silver:SetProperty("DefaultEditBox", "True");
					InputMoney_CopperCoin:SetText("0");
				end
			else
				InputMoney_Gold:SetText(tostring(nGold));
				InputMoney_Gold:SetSelected(0,-1);
				InputMoney_Gold:SetProperty("DefaultEditBox", "True");
				InputMoney_Silver:SetText("0");
				InputMoney_CopperCoin:SetText("0");
			end

			
			
			
		end

		
		if( (this:IsVisible() == true) and (g_nSaveOrGetMoney ~= GET_MONEY) and (g_nSaveOrGetMoney ~= SAVE_MONEY) )  then 
			InputMoney_Gold:SetProperty("DefaultEditBox", "True");
			
			--»∑∂®’‚∏ˆ¥∞ø⁄µƒ∑≈÷√Œª÷√
			--local nPosX ;
			--local nPosY ;
			--nPosX,nPosY = GetCurMousePos();
			--AxTrace(0,0,"nPosX =" .. tostring(nPosX) "   nPosY =" .. tostring(nPosY));
			--InputMoney_Frame:AutoMousePosition(nPosX, nPosY);

		end
		
	elseif( event == "CLOSE_INPUT_MONEY")	 then
		this:Hide();
	
	end
	
end


--===============================================
--  ‰»ÎΩ«Æ∫Û»∑∂®
--===============================================
function InputMoneyAccept_Clicked()

	local szGold = InputMoney_Gold:GetText();
	local szSilver = InputMoney_Silver:GetText();
	local szCopperCoin = InputMoney_CopperCoin:GetText();
	
	--‘⁄≥Ã–Ú¿ÔÕ∑‘ŸºÏ≤‚ ‰»Î◊÷∑˚µƒ”––ß–‘∫Õ ˝÷µ
	local bAvailability,nMoney = Bank:GetInputMoney(szGold,szSilver,szCopperCoin);
	
	--??? ≤√¥«Èøˆœ¬ ß∞‹–Ë“™‘Ÿ∂®
	if(bAvailability == true) then
		
		if( g_nSaveOrGetMoney == SAVE_MONEY ) then
			--÷¥––¥Ê«Æ≤Ÿ◊˜
			Bank:SaveMoneyToBank(nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == GET_MONEY ) then
			--÷¥––»°«Æ≤Ÿ◊˜
			Bank:GetMoneyFromBank(nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == EXCHANGE_MONEY ) then
			--÷¥––Exchang÷–µƒΩ«Æµƒ ‰»Î
			Exchange:GetMoneyFromInput(nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == SAFEBOX_GET_MONEY ) then
			--÷¥––±£œ’œ‰÷–µƒΩ«Æµƒ ‰»Î
			SafeBox("realgetmoney", nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == SAFEBOX_SAVE_MONEY ) then
			--÷¥––±£œ’œ‰÷–µƒΩ«Æµƒ ‰»Î
			SafeBox("realsavemoney", nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == STALLSALE_PRICE ) then
			--÷¥––StallSale÷–µƒ…Ã∆∑±Íº€(Ã·Ωª…Ã∆∑º€∏Ò)
			StallSale:ReferItemPrice(nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == STALLSALE_REPRICE ) then
			--÷¥––StallSale÷–µƒ…Ã∆∑∏¸∏ƒº€∏Ò

			--¥”»´æ÷±‰¡ø÷–»°≥ˆ ˝æ›
			nStallItemID		= GetGlobalInteger("StallSale_ItemID");
			nStallItemIndex = GetGlobalInteger("StallSale_Item");

			StallSale:ItemReprice(nMoney,nStallItemID,nStallItemIndex);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == PS_PRICE_ITEM ) then
			--÷¥––ÕÊº“…ÃµÍµƒº€∏Ò ‰»Î(ŒÔ∆∑)
			if nMoney < 10000 * 10000 then		-- ≥¨π˝£®ªÚµ»”⁄£©1WΩ∏¯”Ë–—ƒøÃ· æ£¨ hjj 09/08/11 #53038	
				PlayerShop:UpStall("item",nMoney);
				if nMoney >=50 then             -- µÕ”⁄50Õ≠ ±≤ªπÿ±’±Íº€øÚ  fsy 09/10/10 #57798
					this:Hide();
				end
			else
				PushDebugMessage("#{WJSD_090810_01}");
			end
			
--		elseif( g_nSaveOrGetMoney == PS_IMMITBASE ) then
--			--≥‰»Î±æΩ
--			PlayerShop:DealMoney("immitbase",nMoney);
--			this:Hide();
--		
--		elseif( g_nSaveOrGetMoney == PS_IMMIT ) then
--			--≥‰»Î
--			PlayerShop:DealMoney("immit",nMoney);
--			this:Hide();
--		
--		elseif( g_nSaveOrGetMoney == PS_DRAW ) then
--			--÷ß»°
--			PlayerShop:DealMoney("draw",nMoney);
--			this:Hide();
			
		elseif( g_nSaveOrGetMoney == STALL_PET_UP ) then
			--’‰ ﬁ…œº‹
			StallSale:PetUpStall(nMoney);
			this:Hide();
			
		elseif( g_nSaveOrGetMoney == STALL_PRICE_PET ) then
			StallSale:PetReprice(nMoney);
			this:Hide();
		
		elseif( g_nSaveOrGetMoney == PS_PRICE_PET ) then
			--÷¥––ÕÊº“…ÃµÍµƒº€∏Ò ‰»Î(’‰ ﬁ)
			if nMoney < 10000 * 10000 then		-- ≥¨π˝£®ªÚµ»”⁄£©1WΩ∏¯”Ë–—ƒøÃ· æ£¨ hjj 09/08/11 #53038	
				PlayerShop:UpStall("pet",nMoney);
				if nMoney >=50 then             -- µÕ”⁄50Õ≠ ±≤ªπÿ±’±Íº€øÚ  fsy 09/10/10 #57798
					this:Hide();
				end
			else
				PushDebugMessage("#{WJSD_090810_01}");
			end
			
		elseif( g_nSaveOrGetMoney == PS_TRANSFER )  then
			--≥ˆº€≈ÃµÍ
			-- add by zchw
			if (tonumber(nMoney) > 100000000) then
				InputMoney_Gold:SetText("");
				InputMoney_Silver:SetText("");
				InputMoney_CopperCoin:SetText("");
				PushDebugMessage("Gi· c‰ thﬂΩng i™m b‡y b·n khÙng ﬂ˛c qu· 10000 v‡ng, xin h„y nhßp l’i.");
				return;
			end
			PlayerShop:Transfer("info", "sale", nMoney);
			this:Hide();
			
		end
		
	end
end


--===============================================
-- »°œ˚
--===============================================
function InputMoneyRefuse_Clicked()
	StallSale:UnlockSelItem();
	this:Hide();
	InputMoney_CopperCoin:SetProperty("DefaultEditBox", "False");
	InputMoney_Gold:SetProperty("DefaultEditBox", "False");
	InputMoney_Silver:SetProperty("DefaultEditBox", "False");
end


--===============================================
--  ‰»Î∏ƒ±‰
--===============================================
function InputMoney_ChangeMoney()
	
	local szGold = InputMoney_Gold:GetText();
	local szSilver = InputMoney_Silver:GetText();
	local szCopperCoin = InputMoney_CopperCoin:GetText();
	
	if(szGold=="" and szSilver=="" and szCopperCoin=="")then
		InputMoney_Accept_Button:Disable();
	else
		InputMoney_Accept_Button:Enable();
	end

end

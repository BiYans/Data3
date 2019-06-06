-- ******************************************
--
-- 电话密保号码的显示界面
--
-- ******************************************

-- 保存LoginServer.txt文件中密保电话的数目
local MiBaoDhCount = 0
-- 保存LoginServer.txt文件中密保电话分区的数目
local GroupNum = 0

-- 界面显示的密保电话号码数目
local MiBaoPhoneCount = 6
-- 用于界面显示密保电话号码的控件数组
local MiBaoTextCtrl = {};
-- LoginServer.txt文件中全部密保电话索引的数组，但实际只从[0,GroupNum-1]中选出6组，每组1个。
local MiBaoGroupAndIndex = {};
-- 用于界面显示的6个密保电话号码数组
local PasswdProctectTels = {};

local g_LastLockTime = 0;

function TelMibaoTishi_PreLoad()
	this:RegisterEvent("OPEN_DIANHUAMIBO_TIPS");
	this:RegisterEvent("OPEN_WINDOW");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("CLEANUP_TIME_TICK");
end

function TelMibaoTishi_OnLoad()
	-- 初始化6个电话密保控件
	MiBaoTextCtrl = {	TelMibaoTishi_Text2;
										TelMibaoTishi_Text3;
										TelMibaoTishi_Text4;
										TelMibaoTishi_Text5;
										TelMibaoTishi_Text6;
										TelMibaoTishi_Text7;
									}
	
	-- 设置密保电话数组索引和电话号码初始值
	TelMibaoTishi_ResetIndexAndTel();
end

function TelMibaoTishi_OnEvent( event )
	if ( event == "OPEN_DIANHUAMIBO_TIPS" ) then
		if( this:IsVisible() ) then
			TelMibaoTishi_Close();
		else
			TelMibaoTishi_Open();
		end
	elseif (event == "OPEN_WINDOW") then		
		if( arg0 == "TelMibaoTishi") then
			TelMibaoTishi_Open();
		end
	elseif(event == "PLAYER_LEAVE_WORLD" and this:IsVisible()) then
		TelMibaoTishi_Close();
	elseif (event == "CLEANUP_TIME_TICK") then
		g_LastLockTime = 0;
	end
end

function TelMibaoTishi_Close()
	TelMibaoTishi_ResetIndexAndTel();
	TelMibaoTishi_Watch:SetProperty("Timer",0);
	this:Hide();
end

function TelMibaoTishi_Open() 	
-- 冷却时间
--PushDebugMessage("hhh");
		local nNowTickCount = Exchange:GetTickCount();		
		if(g_LastLockTime >0 and (nNowTickCount - g_LastLockTime) < 120*1000) then
			PushDebugMessage("#{DHMB_90417_7}");
			return;
		end
	TelMibaoTishi_Watch:SetProperty("Timer",3);
	TelMibaoTishi_Verify:Disable();
			
	CloseWindow("ErjimimaShezhi", true)
	CloseWindow("ErjimimaXiugai", true)
	CloseWindow("ErjimimaJiesuo", true)
	CloseWindow("Fangdao", true)
	CloseWindow("SafeTime", true);
	CloseWindow("DianhuaMibao", true)
	
	-- 得到全部密保电话的数目
	MiBaoDhCount = GameProduceLogin:GetPasswdTelCount();
	
	-- 判断是否在LoginServer.txt里定义了电话密保号码。
	if (MiBaoDhCount > 0) then		
		TelMibaoTishi_InitDlg();
		TelMibaoTishi_SetRandomTelNum();				-- 设置随机显示的电话密保号码	
		this:Show();
	else		
		OpenWindow("TelMiBaoErrMsg");						-- 打开电话密保的错误提示界面
		this:Hide();
	end
end

function TelMibaoTishi_InitDlg()	
	TelMibaoTishi_ResetIndexAndTel();
end

function TelMibaoTishi_Frame_OnHiden()
	TelMibaoTishi_ResetIndexAndTel();
	this:Hide();
end

-- 验证
function TelMibaoTishi_OnVerify()
	local nNowTickCount = Exchange:GetTickCount();	
	g_LastLockTime = nNowTickCount;	
	AskPhoneMibaoStatus();
	this:Hide();
end

-- 取消
function TelMibaoTishi_OnCancel()
	TelMibaoTishi_ResetIndexAndTel();
	this:Hide();
end

-- 设置密保电话数组索引和电话号码初始值
function TelMibaoTishi_ResetIndexAndTel()
	-- 设置下面将要得到的密保电话字符串的初值
	for i=1,MiBaoPhoneCount do
		PasswdProctectTels[i] = ""
	end
	
	-- 初始化密保电话分组索引和具体索引
	for i=1,MiBaoPhoneCount do
		MiBaoGroupAndIndex[i]={}
		MiBaoGroupAndIndex[i].group = -1
		MiBaoGroupAndIndex[i].index = -1
	end
end

-- 设置随机显示的电话密保号码
function TelMibaoTishi_SetRandomTelNum()
	-- 设置密保电话数组索引和电话号码初始值
	TelMibaoTishi_ResetIndexAndTel();
	
	-- 得到电话区号分区的数目
	GroupNum = GameProduceLogin:GetPasswdTelLDCodeGroupCount();

	-- 如果LoginServer.txt文件中配置了密保电话（如果没有配置密保，在调用该函数前已经做过了判断，所以不用考虑这种情况。）
	if( MiBaoDhCount > 0 ) then
		-- 如果全部密保电话的数目大于等于6个，则从不同的分区中选取随机号码来显示
		if( MiBaoDhCount >= MiBaoPhoneCount) then			
			-- 如果分区数目大于等于6组，则随机取6个分区，每个分区取任意一个电话号码来显示
			if (GroupNum >= MiBaoPhoneCount) then
				-- 初始化全部分区都没有被选中
				local bGroupExist = {};
				for i = 0, GroupNum-1 do
					bGroupExist[i] = 0
				end			

				for i = 1, MiBaoPhoneCount do
					-- 在[0,GroupNum-1]之间取一个随机数，作为当前的密保电话分区索引，如果选到了已经用过的，则重新选择，直到找到一个还未被选中过的分区。
					local iTmpGroupIdx = math.random(0,GroupNum-1);
					while (1 == bGroupExist[iTmpGroupIdx]) do
						iTmpGroupIdx = math.random(0,GroupNum-1)
					end
					MiBaoGroupAndIndex[i].group = iTmpGroupIdx;
					bGroupExist[iTmpGroupIdx] = 1;

					-- 得到当前分区中电话号码的数量（不存在电话号码数目为0的分区）
					local iGroupSize = GameProduceLogin:GetPasswdTelCountByLDCodeGroupIndex(iTmpGroupIdx);
							
					-- 在分区中取一个随机号码
					local iTmpIdx = math.random(0, iGroupSize-1);
					MiBaoGroupAndIndex[i].index = iTmpIdx;
				end
  			
			-- 如果分区数目少于6组
			else
				-- 得到每个分区中电话号码的数目
				local iGroupSize = {};
				for i = 0, GroupNum-1 do
					iGroupSize[i] = GameProduceLogin:GetPasswdTelCountByLDCodeGroupIndex(i);
				end
				
				-- 初始化每个分区是否还有电话号码可以取的标记
				local bGroupFull = {};
				for i = 0, GroupNum-1 do
					bGroupFull[i] = 0;				
				end
				
				-- 初始化每个分区每个分区中已经取得的号码数目
				local bGetGroupTel = {};
				for i = 0, GroupNum-1 do
					iGetGroupTel[i] = 0;				
				end
				
				local iGetCount = 0
				local iTmpGroupIdx = -1
				-- 循环从每个分区中取随机号码，最后一个分区取完了，再从第1个分区开始取，依次类推。
				-- 如果某个分区只有1个电话号码，下此再循环到该分区，则跳过这个分区从下一分区继续取号码。
				while (iGetCount < MiBaoPhoneCount) do
				--while (iGetCount < 5) do
					-- 取得循环中当前的分区号码						
					if (iGetCount >= GroupNum) then
						iTmpGroupIdx = math.mod(iGetCount, GroupNum);
					else
						iTmpGroupIdx = iGetCount;
					end
					
					-- 如果当前的分区已无号码可以取，则取下一个分区，直到找到一个可以取出号码的分区。
					while (1 == bGroupFull[iTmpGroupIdx])	do
						iTmpGroupIdx = iTmpGroupIdx + 1
						
						if (iTmpGroupIdx >= GroupNum) then
							iTmpGroupIdx = math.mod(iTmpGroupIdx, GroupNum)
						end					
					end
          
					-- 在分区中取一个没有使用过的随机号码
					local iTmpIdx = math.random(0,iGroupSize[iTmpGroupIdx]-1);
					local bExitIdx = 0;
					for j = 1, iGetCount do
						if (MiBaoGroupAndIndex[j].group == iTmpGroupIdx) and (MiBaoGroupAndIndex[j].index == iTmpIdx) then
							bExitIdx = 1
							break
						end
					end
    	    
					if ( 1 ~= bExitIdx ) then
						iGetCount = iGetCount + 1
						-- 记录本次取得的分区索引及分区中的号码索引
						MiBaoGroupAndIndex[iGetCount].group = iTmpGroupIdx
						MiBaoGroupAndIndex[iGetCount].index = iTmpIdx
						
						-- 记录又从当前分区中取出了一个号码
						iGetGroupTel[iTmpGroupIdx] = iGetGroupTel[iTmpGroupIdx] + 1
						
						-- 记录当前分区是否已经没有号码可以取出
						if (iGetGroupTel[iTmpGroupIdx] == iGroupSize[iTmpGroupIdx]) then
							bGroupFull[iTmpGroupIdx] = 1
						end
					end
				end
			end
			
			--for i = 1,MiBaoPhoneCount do
			--	PushDebugMessage ("group["..i.."] = "..MiBaoGroupAndIndex[i].group..", index["..i.."] = "..MiBaoGroupAndIndex[i].index);
			--end
			
			-- 根据索引从全部密保电话中得到具体的号码并显示
			local strTel = ""
			for num = 1,MiBaoPhoneCount do				
				strTel = GameProduceLogin:GetPasswdTelByGroupIndexAndIndex(MiBaoGroupAndIndex[num].group, MiBaoGroupAndIndex[num].index);
				PasswdProctectTels[num] = strTel;
				MiBaoTextCtrl[num] : SetText(PasswdProctectTels[num])
			end

		-- 全部密保电话的数目不足6个，顺次显示全部密保电话号码	
		else
			-- 根据索引从全部密保电话中得到具体的号码并显示
			for i=1, MiBaoDhCount do
				local strTel = GameProduceLogin:GetPasswdTelByIndex(i-1);
				PasswdProctectTels[i] = strTel
				MiBaoTextCtrl[i] : SetText(PasswdProctectTels[i])	
			end
		end
	end
	
	return
end

function TelMibaoTishi_TimeReach()
	TelMibaoTishi_Verify:Enable();
end
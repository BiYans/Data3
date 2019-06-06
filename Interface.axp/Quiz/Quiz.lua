local Current = -1;
local Question = 0;
local Question_Sequence = 0;
local Quiz_Buttons = {}
local Button_Answer = {}
local objCared = -1;
local MAX_OBJ_DISTANCE = 3.0;
local g_Object = -1;

--当前界面是哪个界面....
-- 1 = 钱龙新手任务答题界面....
-- 2 = 2007圣诞元旦--新手抽奖答题界面....
-- 3 = 2007圣诞元旦--倒计时答题....
-- 4 = 2007元宵节--灯谜答题界面....
local g_UIType = 0

local g_UIServerScript = { 311100, 050021, 050029, 050042, 808093, 250042 }


function Quiz_PreLoad()
	this:RegisterEvent("UI_COMMAND");	
	this:RegisterEvent("OBJECT_CARED_EVENT");
end

function Quiz_OnLoad()
	Quiz_Buttons[1] = Quiz_Button_1;
	Quiz_Buttons[2] = Quiz_Button_2;
	Quiz_Buttons[3] = Quiz_Button_3;
end

function Quiz_OnEvent(event)
	if ( event == "UI_COMMAND" ) then
		if tonumber(arg0) == 2 then
			g_UIType = 1
		elseif tonumber(arg0) == 20071224 then
			g_UIType = 2
		elseif tonumber(arg0) == 271261215 then
			g_UIType = 3
		elseif tonumber(arg0) == 20080221 then
			g_UIType = 4
		elseif tonumber(arg0) == 20080419 then
			g_UIType = 5
		elseif tonumber(arg0) == 20090627 then
			g_UIType = 6
		else
			return
		end
		Quiz_OnShown();

	elseif (event == "OBJECT_CARED_EVENT") then

		if(tonumber(arg0) ~= objCared) then
			return;
		end
		--如果和NPC的距离大于一定距离或者被删除，自动关闭
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
			Quiz_Cancel_Clicked()
		end

	end
end

function Quiz_OnShown()

	Quiz_StopWatch : Hide()
	local UI_ID = Get_XParam_INT(0);

	if UI_ID == 1 then

			Quiz_Text : SetText( Get_XParam_STR(1) );
			Quiz_Button_1 : Show();
			Quiz_Button_1 : SetText("B 馥u tr� l秈")
			Quiz_Button_2 : Hide();
			Quiz_Button_3 : Hide();
			Quiz_Pageheader : SetText( Get_XParam_STR(0) );
			
			local xx = Get_XParam_INT(1);
			objCared = DataPool : GetNPCIDByServerID(xx);
			if objCared == -1 then
					PushDebugMessage("V 皤 s� li畊 m醳 ch�, ai s豠 k竎h b鋘 m醳 ch� a!");
					return;
			end
			BeginCareObject_Quiz(objCared)

			Current = UI_ID;
			this:Show();

	elseif UI_ID == 2 then

			Question = Get_XParam_INT(2)
			Question_Sequence = Get_XParam_INT(1)
			if Question_Sequence == 1 then
				str = "";
			else
				str = "Ch鷆 m譶g c醕 h� 疸 tr� l秈 ch韓h x醕!#rM秈 ti猵 t鴆 tr� l秈...#r";
			end
			if(Variable:GetVariable("System_CodePage") == "1258") then
				Quiz_Text : SetText(str .. "C鈛 " .. "Th� " .. Question_Sequence .. Get_XParam_STR(0) .. "#rT c� 疳p 醤 tr阯 ch� c� m祎 c鈛 l� ch韓h x醕, h銀 suy ngh� k� tr呔c khi ch鱪");
			else
				Quiz_Text : SetText(str .. "Th� " .. Question_Sequence .."蝎: #r" .. Get_XParam_STR(0) .. "#rT c� 疳p 醤 tr阯 ch� c� m祎 c鈛 l� ch韓h x醕, h銀 suy ngh� k� tr呔c khi ch鱪");
			end
		
			Quiz_StopWatch : SetProperty("Timer","30");
			Quiz_StopWatch : Show();
		
			for i=1,3 do
				local str_temp = Get_XParam_STR(i);
				local answer_position = Get_XParam_INT(2+i)
				if  str_temp~= "#" and str_temp~="" then
					Quiz_Buttons[answer_position+1] : Show();
					Quiz_Buttons[answer_position+1] : SetText(str_temp)
					Button_Answer[answer_position+1] = i;
				else
					Quiz_Buttons[answer_position+1] : Hide();
				end
			end
			Current = UI_ID;
			this:Show();

	elseif UI_ID == 3 then

			Quiz_Text : SetText( Get_XParam_STR(0) );
			Question_Sequence = 0;
			Quiz_Button_1 : Show();
			Quiz_Button_1 : SetText("B 馥u ki琺 tra");
			Quiz_Button_2 : Hide();
			Quiz_Button_3 : Hide();
			Current = UI_ID;
			this:Show();

	elseif UI_ID == 4 then

			Quiz_Text : SetText( Get_XParam_STR(0) );
			Quiz_Button_2 : SetText("T誱 bi畉")
			Quiz_Button_2 : Show();
			Quiz_Button_1 : Hide();
			Quiz_Button_3 : Hide();
			Current = UI_ID;
			this:Show();

	end

end

function Quiz_Button_Clicked(nAnswerNumber)

	if nAnswerNumber == 1 and Current == 1 then
		Question_Sequence = 0
		Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("AskQuestion");
				Set_XSCRIPT_ScriptID(g_UIServerScript[g_UIType]);
				Set_XSCRIPT_Parameter(0,Question_Sequence+1);
				Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
		return
	end

	if nAnswerNumber == 1 and Current == 3 then
		Question_Sequence = 0
		Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("AskQuestion");
				Set_XSCRIPT_ScriptID(g_UIServerScript[g_UIType]);
				Set_XSCRIPT_Parameter(0,Question_Sequence+1);
				Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
		return
	end

	if nAnswerNumber == 2 and Current == 4 then
		Quiz_Cancel_Clicked();
		return;
	end

	if nAnswerNumber > 0 and nAnswerNumber < 4 and Question > 0 then
		Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("AnswerQuestion");
				Set_XSCRIPT_ScriptID(g_UIServerScript[g_UIType]);
				Set_XSCRIPT_Parameter(0,Question);
				Set_XSCRIPT_Parameter(1,Button_Answer[nAnswerNumber]);
				Set_XSCRIPT_Parameter(2,Question_Sequence);
				Set_XSCRIPT_ParamCount(3);
		Send_XSCRIPT();
		return
	end
	
end

function Quiz_Cancel_Clicked()
	StopCareObject_Quiz(objCared)
	this:Hide();
end

--=========================================================
--开始关心NPC，
--在开始关心之前需要先确定这个界面是不是已经有“关心”的NPC，
--如果有的话，先取消已经有的“关心”
--=========================================================
function BeginCareObject_Quiz(objCaredId)
	g_Object = objCaredId;
	this:CareObject(g_Object, 1, "Quiz");
end

--=========================================================
--停止对某NPC的关心
--=========================================================
function StopCareObject_Quiz(objCaredId)
	this:CareObject(objCaredId, 0, "Quiz");
	g_Object = -1;

end

--记时到0后
function Quiz_OverTime()
	Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("OnOverTime");
			Set_XSCRIPT_ScriptID(g_UIServerScript[g_UIType]);
			Set_XSCRIPT_ParamCount(0);
	Send_XSCRIPT();
end
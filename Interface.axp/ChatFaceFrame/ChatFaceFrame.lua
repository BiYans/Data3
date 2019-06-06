local g_AllAnimate = {};
local g_AllNewAnimate = {};
local g_AllPageTab = {}
local g_curPage = 1
function ChatFaceFrame_PreLoad()
	this:RegisterEvent("CHAT_FACEMOTION_SELECT");
	this:RegisterEvent("CHAT_ADJUST_MOVE_CTL");
end

function ChatFaceFrame_OnLoad()
	g_AllAnimate = {
		Face_1, Face_2, Face_3, Face_4, Face_5, Face_6, Face_7, Face_8, Face_9, Face_10,
		Face_11,Face_12,Face_13,Face_14,Face_15,Face_16,Face_17,Face_18,Face_19,Face_20,
		Face_21,Face_22,Face_23,Face_24,Face_25,Face_26,Face_27,Face_28,Face_29,Face_30,
		Face_31,Face_32,Face_33,Face_34,Face_35,Face_36,Face_37,Face_38,Face_39,Face_40,
		Face_41,Face_42,Face_43,Face_44,Face_45,Face_46,Face_47,Face_48,Face_49,Face_50,
		Face_51,Face_52,Face_53,Face_54,Face_55,Face_56,Face_57,Face_58,Face_59,Face_60,
		Face_61,Face_62,Face_63,Face_64,Face_65,Face_66,Face_67,Face_68,Face_69,Face_70,
		Face_71,Face_72,Face_73,Face_74,Face_75,Face_76,Face_77,Face_78,Face_79,Face_80,
		Face_81,Face_82,Face_83,Face_84,Face_85,Face_86,Face_87,Face_88,Face_89,Face_90,
		Face_91,Face_92,Face_93,Face_94,Face_95,Face_96,Face_97,Face_98,Face_99,Face_100
	};
	g_AllNewAnimate = {
    	Face_101, Face_102, Face_103, Face_104, Face_105, Face_106, Face_107, Face_108, Face_109, Face_110,
		Face_111, Face_112, Face_113, Face_114, Face_115, Face_116, Face_117, Face_118, Face_119, Face_120,
		Face_121, Face_122, Face_123, Face_124, Face_125, Face_126, Face_127, Face_128, Face_129, Face_130,
		Face_131, Face_132, Face_133, Face_134, Face_135, Face_136
	};
	g_AllNewAnimate1 = {
		Face_201, Face_202, Face_203, Face_204, Face_205, Face_206, Face_207, Face_208, Face_209, Face_210,
		Face_211, Face_212, Face_213, Face_214, Face_215, Face_216, Face_217, Face_218, Face_219, Face_220,
		Face_221, Face_222, Face_223, Face_224, Face_225, Face_226, Face_227, Face_228, Face_229, Face_230,
		Face_231, Face_232, Face_233, Face_234, Face_235, Face_236
	};
	g_AllNewAnimate2 = {
		Face_301, Face_302, Face_303, Face_304, Face_305, Face_306, Face_307, Face_308, Face_309, Face_310,
		Face_311, Face_312, Face_313, Face_314, Face_315, Face_316, Face_317, Face_318, Face_319, Face_320,
		Face_321, Face_322, Face_323, Face_324, Face_325, Face_326, Face_327, Face_328, Face_329, Face_330,
		Face_331, Face_332, Face_333, Face_334, Face_335, Face_336
	};
	g_AllNewAnimate3 = {
		Face_401, Face_402, Face_403, Face_404, Face_405, Face_406, Face_407, Face_408, Face_409, Face_410,
		Face_411, Face_412, Face_413, Face_414, Face_415, Face_416, Face_417, Face_418, Face_419, Face_420,
		Face_421, Face_422, Face_423, Face_424, Face_425, Face_426, Face_427, Face_428, Face_429, Face_430,
		Face_431, Face_432, Face_433, Face_434, Face_435, Face_436
	};
	g_AllNewAnimate4 = {
		Face_484, Face_485, Face_486, Face_487, Face_488, Face_489, Face_490, Face_491, Face_492, Face_493,
		Face_494, Face_495, Face_496, Face_497, Face_498, Face_499, Face_500, Face_501, Face_502, Face_503,
		Face_504, Face_505, Face_506, Face_507, Face_508, Face_509, Face_510, Face_511, Face_512, Face_513
	};
	g_AllPageTab = {
		Face_Frame_Index1,
		Face_Frame_Index2,
		Face_Frame_Index3,
		Face_Frame_Index4
	}

	for i = 1, table.getn(g_AllAnimate) do
		g_AllAnimate[i]:SetToolTip("##"..tostring(i));
	end

	for i = 1, table.getn(g_AllNewAnimate) do
		g_AllNewAnimate[i]:SetToolTip("##"..tostring(100+i));
	end

	for i = 1, table.getn(g_AllNewAnimate1) do
		g_AllNewAnimate1[i]:SetToolTip("##"..tostring(200+i));
	end

	for i = 1, table.getn(g_AllNewAnimate2) do
		g_AllNewAnimate2[i]:SetToolTip("##"..tostring(300+i));
	end

	for i = 1, table.getn(g_AllNewAnimate3) do
		g_AllNewAnimate3[i]:SetToolTip("##"..tostring(400+i));
	end
end

function ChatFaceFrame_OnEvent( event )
	if( event == "CHAT_FACEMOTION_SELECT" and arg0 == "select") then
		if(this:IsVisible() or this:ClickHide())then
			this:Hide();
		else
			Chat_FaceFrame_Show()
		end
	elseif (event == "CHAT_ADJUST_MOVE_CTL" and this:IsVisible()) then
		Chat_FaceFrame_AdjustMoveCtl();
	end
end

function Chat_FaceFrame_SelectMotion(nIndex)

	if(1 > nIndex) then
		return;
	end

	if g_curPage == 1 then
		local strResult = "#" .. tostring(nIndex);
		Talk:SelectFaceMotion("sucess", strResult);
	else
		local strResult = " #" .. tostring(nIndex);
		Talk:SelectFaceMotion("sucess", strResult);
	end
end

function Chat_FaceFrame_AdjustMoveCtl()
	this:Hide();
end

function Chat_FaceFrame_ChangePosition(pos1,pos2)


	if(tonumber(pos1)~=0) then
		Face_Frame:SetProperty("UnifiedXPosition", "{0.0,"..pos1.."}");
	end;
	if(tonumber(pos2)~=0) then
		Face_Frame:SetProperty("UnifiedYPosition", "{0.0,"..pos2.."}");
	end;
end

function Chat_FaceFrame_Show()
	this:Show();
	Chat_FaceFrame_ChangePosition(arg1,arg2);



	if g_curPage <= 1 or g_curPage > 5  then
		g_curPage = 1
		Face_Frame_Index0:SetCheck(1)

	else
	   	g_AllPageTab[g_curPage - 1]:SetCheck(1)

	end

	Chat_FaceFrame_Page_Switch(g_curPage)

end

function Chat_FaceFrame_Page_Switch(pageNum)

	if pageNum == 1 then
		for i = 1, table.getn(g_AllAnimate) do
			g_AllAnimate[i]:Show();
		end

		for i = 1, table.getn(g_AllNewAnimate) do
			g_AllNewAnimate[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate1) do
			g_AllNewAnimate1[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate2) do
			g_AllNewAnimate2[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate3) do
			g_AllNewAnimate3[i]:Hide();
		end
		Face_Frame_Time:Hide()
		Face_Frame_Setdown:Hide();
		Face_Frame_Line2:Hide();
	elseif pageNum == 2 then
		for i = 1, table.getn(g_AllAnimate) do
			g_AllAnimate[i]:Hide();
		end

		for i = 1, table.getn(g_AllNewAnimate) do
			g_AllNewAnimate[i]:Show();
		end
		for i = 1, table.getn(g_AllNewAnimate1) do
			g_AllNewAnimate1[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate2) do
			g_AllNewAnimate2[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate3) do
			g_AllNewAnimate3[i]:Hide();
		end
	elseif pageNum == 3 then
		for i = 1, table.getn(g_AllAnimate) do
			g_AllAnimate[i]:Hide();
		end

		for i = 1, table.getn(g_AllNewAnimate) do
			g_AllNewAnimate[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate1) do
			g_AllNewAnimate1[i]:Show();
		end
		for i = 1, table.getn(g_AllNewAnimate2) do
			g_AllNewAnimate2[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate3) do
			g_AllNewAnimate3[i]:Hide();
		end
	elseif pageNum == 4 then
		for i = 1, table.getn(g_AllAnimate) do
			g_AllAnimate[i]:Hide();
		end

		for i = 1, table.getn(g_AllNewAnimate) do
			g_AllNewAnimate[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate1) do
			g_AllNewAnimate1[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate2) do
			g_AllNewAnimate2[i]:Show();
		end
		for i = 1, table.getn(g_AllNewAnimate3) do
			g_AllNewAnimate3[i]:Hide();
		end
	elseif pageNum == 5 then
		for i = 1, table.getn(g_AllAnimate) do
			g_AllAnimate[i]:Hide();
		end

		for i = 1, table.getn(g_AllNewAnimate) do
			g_AllNewAnimate[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate1) do
			g_AllNewAnimate1[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate2) do
			g_AllNewAnimate2[i]:Hide();
		end
		for i = 1, table.getn(g_AllNewAnimate3) do
			g_AllNewAnimate3[i]:Show();
		end
	end

	g_curPage = pageNum
end

function Face_Frame_Setdown_Click()
	if g_curPage == 1 then
		return
	end

	if tonumber(DataPool:GetLeftProtectTime()) > 0 then
		PushDebugMessage("#{BQB_091026_1}")
		return
	end


	--二级密码 电话密保检查
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then
		return
	end

	DataPool:UnInstallRMBFace(g_curPage - 2 ,  0)
end

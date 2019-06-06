--LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, XXXX)--Kiem tra Impact tren nguoi nhan vat--
--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, XXXX, 0)--Them Impact len nhan vat--
--LuaFnCancelSpecificImpact(sceneId, selfId, XXXX)--Huy bo Impact tren nguoi nhan vat--

x741301_g_scriptId = 741301

function x741301_AddFirstPoint(sceneId, selfId)
	LuaFnWashPoints(sceneId,selfId)
	local RemainPoint = GetPlayerRemainPoints(sceneId, selfId)
	SetPlayerRemainPoints(sceneId, selfId, RemainPoint + 5)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId, selfId, 74130100)
	
	SetMissionData(sceneId,selfId,POINTCHAR_CUONGLUC,0)
	SetMissionData(sceneId,selfId,POINTCHAR_NOILUC,0)
	SetMissionData(sceneId,selfId,POINTCHAR_THELUC,0)
	SetMissionData(sceneId,selfId,POINTCHAR_TRILUC,0)
	SetMissionData(sceneId,selfId,POINTCHAR_THANPHAP,0)
end

function x741301_ReloadPoint(sceneId, selfId)	
	local CuongLuc = 7777; --Level 10--
	local NoiLuc = 7777; --Level 10--
	local TheLuc = 7777; --Level 10--
	local TriLuc = 7777; --Level 10--
	local ThanPhap = 7777; --Level 10--
	local BangCong = 7777; --Max: 9999--
	local HoaCong = 7777; --Max: 9999--
	local HuyenCong = 7777; --Max: 9999--
	local DocCong = 7777; --Max: 9999--
	local KhangBang = 0; --Max: 4096--
	local KhangHoa = 0; --Max: 4096--
	local KhangHuyen = 0; --Max: 4096--
	local KhangDoc = 0; --Max: 4096--
	local GKBang = 0; --Max: 4096--
	local GKHoa = 0; --Max: 4096--
	local GKHuyen = 0; --Max: 4096--
	local GKDoc = 0; --Max: 4096--
	local GKBangAm = 0; --Max: 99--
	local GKHoaAm = 0; --Max: 99--
	local GKHuyenAm = 0; --Max: 99--
	local GKDocAm = 0; --Max: 99--
	local SinhLuc = 0; --Max: 51199--
	local SinhKhi = 0; --Max: 25599--
	local NgoaiCong = 0; --Max: 25599--
	local NoiCong = 0; --Max: 25599--
	local NgoaiThu = 0; --Max: 25599--
	local NoiThu = 0; --Max: 25599--
	local ChinhXac = 0; --Max: 25599--
	local NeTranh = 0; --Max: 25599--
	local HoiCong = 0; --Max: 99--
	local HoiThu = 0; --Max: 99--
	local Hp_Max = 0; --Max 99%--
	
	--VoHon Process--
	local Item108 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 108 ); --VoHon--
	local Item108_Author = "";
	if Item108 >= 10308001 and Item108 <= 10308004 then
		local Author, szAuthor = LuaFnGetItemCreator(sceneId,selfId,108);
		if szAuthor then
			Item108_Author = szAuthor;
		else
			Item108_Author = "*---0010000050010---------------------------------------0";
		end
		
		local VoHon_Property = {}
			VoHon_Property[1] = {3, 2, 2, 2, 2, 3, 2, 2, 2, 2, 3, 2, 3, 3, 3, 5, 2, 3, 3, 3, 5, 2, 3, 3, 3}
			VoHon_Property[2] = {3, 2, 3, 2, 2, 5, 2, 5, 2, 2, 5, 2, 5, 3, 3, 6, 2, 6, 3, 3, 6, 2, 6, 3, 3}
			VoHon_Property[3] = {5, 2, 3, 3, 3, 6, 2, 5, 5, 5, 6, 2, 5, 5, 5, 8, 2, 6, 6, 6, 8, 2, 6, 6, 6}
			VoHon_Property[4] = {6, 2, 6, 3, 3, 6, 2, 6, 5, 5, 8, 2, 8, 5, 5, 8, 2, 8, 6, 6, 9, 2, 9, 6, 6}
			VoHon_Property[5] = {8, 2, 6, 6, 6, 9, 2, 6, 6, 6, 11, 3, 8, 8, 8, 12, 3, 8, 8, 8, 14, 3, 9, 9, 9}
			VoHon_Property[6] = {9, 2, 8, 6, 6, 11, 2, 9, 6, 6, 12, 3, 9, 8, 8, 14, 3, 11, 8, 8, 15, 3, 12, 9, 9}
			VoHon_Property[7] = {11, 2, 8, 6, 6, 12, 2, 9, 6, 6, 14, 3, 9, 8, 8, 15, 3, 11, 8, 8, 17, 3, 12, 9, 9}
			VoHon_Property[8] = {11, 2, 9, 8, 8, 12, 2, 11, 9, 9, 15, 3, 12, 9, 9, 17, 3, 14, 11, 11, 18, 3, 15, 12, 12}
			VoHon_Property[9] = {12, 2, 9, 8, 8, 14, 2, 11, 9, 9, 15, 3, 12, 9, 9, 18, 3, 14, 11, 11, 20, 3, 15, 12, 12}
			VoHon_Property[10] = {15, 3, 11, 9, 9, 17, 3, 12, 11, 11, 20, 3, 15, 12, 12, 21, 5, 17, 14, 14, 24, 5, 18, 15, 15}
			VoHon_Property[11] = {15, 3, 11, 9, 9, 18, 3, 12, 11, 11, 21, 3, 15, 12, 12, 23, 5, 17, 14, 14, 26, 5, 18, 15, 15}
			VoHon_Property[12] = {17, 3, 12, 9, 9, 20, 3, 15, 11, 11, 21, 3, 17, 12, 12, 24, 5, 20, 14, 14, 27, 5, 21, 15, 15}
			VoHon_Property[13] = {17, 3, 12, 11, 11, 20, 3, 15, 12, 12, 23, 3, 17, 15, 15, 26, 5, 20, 17, 17, 29, 5, 21, 18, 18}
			VoHon_Property[14] = {18, 3, 15, 11, 11, 21, 3, 17, 12, 12, 24, 3, 20, 15, 15, 27, 5, 21, 17, 17, 30, 5, 24, 18, 18}
			VoHon_Property[15] = {21, 3, 15, 12, 12, 24, 5, 17, 15, 15, 27, 5, 20, 17, 17, 32, 6, 21, 20, 20, 35, 6, 24, 21, 21}
			VoHon_Property[16] = {21, 3, 17, 12, 12, 26, 5, 20, 15, 15, 29, 5, 21, 17, 17, 33, 6, 24, 20, 20, 36, 6, 27, 21, 21}
			VoHon_Property[17] = {23, 3, 17, 12, 12, 27, 5, 20, 15, 15, 30, 5, 21, 17, 17, 35, 6, 24, 20, 20, 38, 6, 27, 21, 21}
			VoHon_Property[18] = {24, 3, 18, 15, 15, 27, 5, 21, 17, 17, 32, 5, 24, 20, 20, 35, 6, 27, 21, 21, 39, 6, 30, 24, 24}
			VoHon_Property[19] = {24, 3, 18, 15, 15, 29, 5, 21, 17, 17, 33, 5, 24, 20, 20, 36, 6, 27, 21, 21, 41, 6, 30, 24, 24}
			VoHon_Property[20] = {27, 5, 20, 17, 17, 32, 6, 23, 20, 20, 36, 6, 27, 21, 21, 41, 8, 30, 24, 24, 45, 8, 33, 27, 27}
			VoHon_Property[21] = {29, 5, 20, 17, 17, 33, 6, 23, 20, 20, 38, 6, 27, 21, 21, 42, 8, 30, 24, 24, 47, 8, 33, 27, 27}
			VoHon_Property[22] = {29, 5, 21, 17, 17, 33, 6, 26, 20, 20, 39, 6, 29, 21, 21, 44, 8, 33, 24, 24, 48, 8, 36, 27, 27}
			VoHon_Property[23] = {30, 5, 21, 18, 18, 35, 6, 26, 21, 21, 39, 6, 29, 24, 24, 45, 8, 33, 27, 27, 50, 8, 36, 30, 30}
			VoHon_Property[24] = {30, 5, 24, 18, 18, 36, 6, 27, 21, 21, 41, 6, 32, 24, 24, 47, 8, 35, 27, 27, 51, 8, 39, 30, 30}
			VoHon_Property[25] = {33, 6, 24, 20, 20, 39, 6, 27, 23, 23, 45, 8, 32, 27, 27, 50, 8, 35, 30, 30, 56, 9, 39, 33, 33}
			VoHon_Property[26] = {35, 6, 26, 20, 20, 41, 6, 30, 23, 23, 45, 8, 33, 27, 27, 51, 8, 38, 30, 30, 57, 9, 42, 33, 33}
			VoHon_Property[27] = {35, 6, 26, 20, 20, 41, 6, 30, 23, 23, 47, 8, 33, 27, 27, 53, 8, 38, 30, 30, 59, 9, 42, 33, 33}
			VoHon_Property[28] = {36, 6, 27, 21, 21, 42, 6, 32, 26, 26, 48, 8, 36, 29, 29, 54, 8, 41, 33, 33, 60, 9, 45, 36, 36}
			VoHon_Property[29] = {38, 6, 27, 21, 21, 44, 6, 32, 26, 26, 50, 8, 36, 29, 29, 56, 8, 41, 33, 33, 62, 9, 45, 36, 36}
			VoHon_Property[30] = {39, 6, 29, 24, 24, 47, 8, 33, 27, 27, 53, 9, 39, 32, 32, 60, 9, 44, 35, 35, 66, 11, 48, 39, 39}
			VoHon_Property[31] = {41, 6, 29, 24, 24, 48, 8, 33, 27, 27, 54, 9, 39, 32, 32, 62, 9, 44, 35, 35, 68, 11, 48, 39, 39}
			VoHon_Property[32] = {42, 6, 30, 24, 24, 48, 8, 36, 27, 27, 56, 9, 41, 32, 32, 62, 9, 47, 35, 35, 69, 11, 51, 39, 39}
			VoHon_Property[33] = {42, 6, 30, 26, 26, 50, 8, 36, 30, 30, 57, 9, 41, 33, 33, 63, 9, 47, 38, 38, 71, 11, 51, 42, 42}
			VoHon_Property[34] = {44, 6, 33, 26, 26, 51, 8, 38, 30, 30, 57, 9, 44, 33, 33, 65, 9, 48, 38, 38, 72, 11, 54, 42, 42}
			VoHon_Property[35] = {47, 8, 33, 27, 27, 54, 9, 38, 32, 32, 62, 9, 44, 36, 36, 69, 11, 48, 41, 41, 77, 12, 54, 45, 45}
			VoHon_Property[36] = {47, 8, 35, 27, 27, 54, 9, 41, 32, 32, 63, 9, 45, 36, 36, 71, 11, 51, 41, 41, 78, 12, 57, 45, 45}
			VoHon_Property[37] = {48, 8, 35, 27, 27, 56, 9, 41, 32, 32, 63, 9, 45, 36, 36, 72, 11, 51, 41, 41, 80, 12, 57, 45, 45}
			VoHon_Property[38] = {48, 8, 36, 29, 29, 57, 9, 42, 33, 33, 65, 9, 48, 39, 39, 74, 11, 54, 44, 44, 81, 12, 60, 48, 48}
			VoHon_Property[39] = {50, 8, 36, 29, 29, 59, 9, 42, 33, 33, 66, 9, 48, 39, 39, 75, 11, 54, 44, 44, 83, 12, 60, 48, 48}
			VoHon_Property[40] = {53, 8, 38, 30, 30, 62, 9, 44, 36, 36, 69, 11, 51, 41, 41, 78, 12, 57, 47, 47, 87, 14, 63, 51, 51}
			VoHon_Property[41] = {53, 8, 38, 30, 30, 62, 9, 44, 36, 36, 71, 11, 51, 41, 41, 80, 12, 57, 47, 47, 89, 14, 63, 51, 51}
			VoHon_Property[42] = {54, 8, 39, 30, 30, 63, 9, 47, 36, 36, 72, 11, 53, 41, 41, 81, 12, 60, 47, 47, 90, 14, 66, 51, 51}
			VoHon_Property[43] = {56, 8, 39, 33, 33, 65, 9, 47, 38, 38, 74, 11, 53, 44, 44, 83, 12, 60, 48, 48, 92, 14, 66, 54, 54}
			VoHon_Property[44] = {56, 8, 42, 33, 33, 65, 9, 48, 38, 38, 75, 11, 56, 44, 44, 84, 12, 62, 48, 48, 93, 14, 69, 54, 54}
			VoHon_Property[45] = {59, 9, 42, 35, 35, 69, 11, 48, 41, 41, 78, 12, 56, 45, 45, 89, 14, 62, 51, 51, 98, 15, 69, 57, 57}
			VoHon_Property[46] = {60, 9, 44, 35, 35, 69, 11, 51, 41, 41, 80, 12, 57, 45, 45, 89, 14, 65, 51, 51, 99, 15, 72, 57, 57}
			VoHon_Property[47] = {60, 9, 44, 35, 35, 71, 11, 51, 41, 41, 81, 12, 57, 45, 45, 90, 14, 65, 51, 51, 101, 15, 72, 57, 57}
			VoHon_Property[48] = {62, 9, 45, 36, 36, 72, 11, 53, 42, 42, 81, 12, 60, 48, 48, 92, 14, 68, 54, 54, 102, 15, 75, 60, 60}
			VoHon_Property[49] = {62, 9, 45, 36, 36, 72, 11, 53, 42, 42, 83, 12, 60, 48, 48, 93, 14, 68, 54, 54, 104, 15, 75, 60, 60}
			VoHon_Property[50] = {65, 11, 47, 38, 38, 75, 12, 54, 44, 44, 87, 14, 63, 51, 51, 98, 15, 71, 57, 57, 108, 17, 78, 63, 63}
			VoHon_Property[51] = {66, 11, 47, 38, 38, 77, 12, 54, 44, 44, 87, 14, 63, 51, 51, 99, 15, 71, 57, 57, 110, 17, 78, 63, 63}
			VoHon_Property[52] = {66, 11, 48, 38, 38, 78, 12, 57, 44, 44, 89, 14, 65, 51, 51, 101, 15, 74, 57, 57, 111, 17, 81, 63, 63}
			VoHon_Property[53] = {68, 11, 48, 39, 39, 80, 12, 57, 47, 47, 90, 14, 65, 53, 53, 102, 15, 74, 60, 60, 113, 17, 81, 66, 66}
			VoHon_Property[54] = {69, 11, 51, 39, 39, 80, 12, 59, 47, 47, 92, 14, 68, 53, 53, 102, 15, 75, 60, 60, 114, 17, 84, 66, 66}
			VoHon_Property[55] = {71, 11, 51, 42, 42, 83, 12, 59, 48, 48, 95, 15, 68, 56, 56, 107, 17, 75, 62, 62, 119, 18, 84, 69, 69}
			VoHon_Property[56] = {72, 11, 53, 42, 42, 84, 12, 62, 48, 48, 96, 15, 69, 56, 56, 108, 17, 78, 62, 62, 120, 18, 87, 69, 69}
			VoHon_Property[57] = {74, 11, 53, 42, 42, 86, 12, 62, 48, 48, 98, 15, 69, 56, 56, 110, 17, 78, 62, 62, 122, 18, 87, 69, 69}
			VoHon_Property[58] = {74, 11, 54, 44, 44, 86, 12, 63, 51, 51, 99, 15, 72, 57, 57, 111, 17, 81, 65, 65, 123, 18, 90, 72, 72}
			VoHon_Property[59] = {75, 11, 54, 44, 44, 87, 12, 63, 51, 51, 99, 15, 72, 57, 57, 113, 17, 81, 65, 65, 125, 18, 90, 72, 72}
			VoHon_Property[60] = {78, 12, 56, 45, 45, 90, 14, 65, 53, 53, 104, 15, 75, 60, 60, 116, 18, 84, 68, 68, 129, 20, 93, 75, 75}
			VoHon_Property[61] = {78, 12, 56, 45, 45, 92, 14, 65, 53, 53, 105, 15, 75, 60, 60, 117, 18, 84, 68, 68, 131, 20, 93, 75, 75}
			VoHon_Property[62] = {80, 12, 57, 45, 45, 93, 14, 68, 53, 53, 105, 15, 77, 60, 60, 119, 18, 87, 68, 68, 132, 20, 96, 75, 75}
			VoHon_Property[63] = {80, 12, 57, 47, 47, 93, 14, 68, 54, 54, 107, 15, 77, 63, 63, 120, 18, 87, 71, 71, 134, 20, 96, 78, 78}
			VoHon_Property[64] = {81, 12, 60, 47, 47, 95, 14, 69, 54, 54, 108, 15, 80, 63, 63, 122, 18, 89, 71, 71, 135, 20, 99, 78, 78}
			VoHon_Property[65] = {84, 12, 60, 48, 48, 98, 15, 69, 57, 57, 111, 17, 80, 65, 65, 126, 20, 89, 74, 74, 140, 21, 99, 81, 81}
			VoHon_Property[66] = {84, 12, 62, 48, 48, 99, 15, 72, 57, 57, 113, 17, 81, 65, 65, 128, 20, 92, 74, 74, 141, 21, 102, 81, 81}
			VoHon_Property[67] = {86, 12, 62, 48, 48, 101, 15, 72, 57, 57, 114, 17, 81, 65, 65, 129, 20, 92, 74, 74, 143, 21, 102, 81, 81}
			VoHon_Property[68] = {87, 12, 63, 51, 51, 101, 15, 74, 59, 59, 116, 17, 84, 68, 68, 129, 20, 95, 75, 75, 144, 21, 105, 84, 84}
			VoHon_Property[69] = {87, 12, 63, 51, 51, 102, 15, 74, 59, 59, 117, 17, 84, 68, 68, 131, 20, 95, 75, 75, 146, 21, 105, 84, 84}
			VoHon_Property[70] = {90, 14, 65, 53, 53, 105, 17, 75, 62, 62, 120, 18, 87, 69, 69, 135, 21, 98, 78, 78, 150, 23, 108, 87, 87}
			VoHon_Property[71] = {92, 14, 65, 53, 53, 107, 17, 75, 62, 62, 122, 18, 87, 69, 69, 137, 21, 98, 78, 78, 152, 23, 108, 87, 87}
			VoHon_Property[72] = {92, 14, 66, 53, 53, 107, 17, 78, 62, 62, 123, 18, 89, 69, 69, 138, 21, 101, 78, 78, 153, 23, 111, 87, 87}
			VoHon_Property[73] = {93, 14, 66, 54, 54, 108, 17, 78, 63, 63, 123, 18, 89, 72, 72, 140, 21, 101, 81, 81, 155, 23, 111, 90, 90}
			VoHon_Property[74] = {93, 14, 69, 54, 54, 110, 17, 80, 63, 63, 125, 18, 92, 72, 72, 141, 21, 102, 81, 81, 156, 23, 114, 90, 90}
			VoHon_Property[75] = {96, 15, 69, 56, 56, 113, 17, 80, 65, 65, 129, 20, 92, 75, 75, 144, 21, 102, 84, 84, 161, 24, 114, 93, 93}
			VoHon_Property[76] = {98, 15, 71, 56, 56, 114, 17, 83, 65, 65, 129, 20, 93, 75, 75, 146, 21, 105, 84, 84, 162, 24, 117, 93, 93}
			VoHon_Property[77] = {98, 15, 71, 56, 56, 114, 17, 83, 65, 65, 131, 20, 93, 75, 75, 147, 21, 105, 84, 84, 164, 24, 117, 93, 93}
			VoHon_Property[78] = {99, 15, 72, 57, 57, 116, 17, 84, 68, 68, 132, 20, 96, 77, 77, 149, 21, 108, 87, 87, 165, 24, 120, 96, 96}
			VoHon_Property[79] = {101, 15, 72, 57, 57, 117, 17, 84, 68, 68, 134, 20, 96, 77, 77, 150, 21, 108, 87, 87, 167, 24, 120, 96, 96}
			VoHon_Property[80] = {102, 15, 74, 60, 60, 120, 18, 86, 69, 69, 137, 21, 99, 80, 80, 155, 23, 111, 89, 89, 171, 26, 123, 99, 99}
			VoHon_Property[81] = {104, 15, 74, 60, 60, 122, 18, 86, 69, 69, 138, 21, 99, 80, 80, 156, 23, 111, 89, 89, 173, 26, 123, 99, 99}
			VoHon_Property[82] = {105, 15, 75, 60, 60, 122, 18, 89, 69, 69, 140, 21, 101, 80, 80, 156, 23, 114, 89, 89, 174, 26, 126, 99, 99}
			VoHon_Property[83] = {105, 15, 75, 62, 62, 123, 18, 89, 72, 72, 141, 21, 101, 81, 81, 158, 23, 114, 92, 92, 176, 26, 126, 102, 102}
			VoHon_Property[84] = {107, 15, 78, 62, 62, 125, 18, 90, 72, 72, 141, 21, 104, 81, 81, 159, 23, 116, 92, 92, 177, 26, 129, 102, 102}
			VoHon_Property[85] = {110, 17, 78, 63, 63, 128, 20, 90, 74, 74, 146, 21, 104, 84, 84, 164, 24, 116, 95, 95, 182, 27, 129, 105, 105}
			VoHon_Property[86] = {110, 17, 80, 63, 63, 128, 20, 93, 74, 74, 147, 21, 105, 84, 84, 165, 24, 119, 95, 95, 183, 27, 132, 105, 105}
			VoHon_Property[87] = {111, 17, 80, 63, 63, 129, 20, 93, 74, 74, 147, 21, 105, 84, 84, 167, 24, 119, 95, 95, 185, 27, 132, 105, 105}
			VoHon_Property[88] = {111, 17, 81, 65, 65, 131, 20, 95, 75, 75, 149, 21, 108, 87, 87, 168, 24, 122, 98, 98, 186, 27, 135, 108, 108}
			VoHon_Property[89] = {113, 17, 81, 65, 65, 132, 20, 95, 75, 75, 150, 21, 108, 87, 87, 170, 24, 122, 98, 98, 188, 27, 135, 108, 108}
			VoHon_Property[90] = {116, 17, 83, 66, 66, 135, 20, 96, 78, 78, 153, 23, 111, 89, 89, 173, 26, 125, 101, 101, 192, 29, 138, 111, 111}
			VoHon_Property[91] = {116, 17, 83, 66, 66, 135, 20, 96, 78, 78, 155, 23, 111, 89, 89, 174, 26, 125, 101, 101, 194, 29, 138, 111, 111}
			VoHon_Property[92] = {117, 17, 84, 66, 66, 137, 20, 99, 78, 78, 156, 23, 113, 89, 89, 176, 26, 128, 101, 101, 195, 29, 141, 111, 111}
			VoHon_Property[93] = {119, 17, 84, 69, 69, 138, 20, 99, 80, 80, 158, 23, 113, 92, 92, 177, 26, 128, 102, 102, 197, 29, 141, 114, 114}
			VoHon_Property[94] = {119, 17, 87, 69, 69, 138, 20, 101, 80, 80, 159, 23, 116, 92, 92, 179, 26, 129, 102, 102, 198, 29, 144, 114, 114}
			VoHon_Property[95] = {122, 18, 87, 71, 71, 143, 21, 101, 83, 83, 162, 24, 116, 93, 93, 183, 27, 129, 105, 105, 203, 30, 144, 117, 117}
			VoHon_Property[96] = {123, 18, 89, 71, 71, 143, 21, 104, 83, 83, 164, 24, 117, 93, 93, 183, 27, 132, 105, 105, 204, 30, 147, 117, 117}
			VoHon_Property[97] = {123, 18, 89, 71, 71, 144, 21, 104, 83, 83, 165, 24, 117, 93, 93, 185, 27, 132, 105, 105, 206, 30, 147, 117, 117}
			VoHon_Property[98] = {125, 18, 90, 72, 72, 146, 21, 105, 84, 84, 165, 24, 120, 96, 96, 186, 27, 135, 108, 108, 207, 30, 150, 120, 120}
			VoHon_Property[99] = {125, 18, 90, 72, 72, 146, 21, 105, 84, 84, 167, 24, 120, 96, 96, 188, 27, 135, 108, 108, 209, 30, 150, 120, 120}
			VoHon_Property[100] = {128, 20, 92, 74, 74, 149, 23, 107, 86, 86, 171, 26, 123, 99, 99, 192, 29, 138, 111, 111, 213, 32, 153, 123, 123}
			VoHon_Property[101] = {129, 20, 92, 74, 74, 150, 23, 107, 86, 86, 171, 26, 123, 99, 99, 194, 29, 138, 111, 111, 215, 32, 153, 123, 123}
			VoHon_Property[102] = {129, 20, 93, 74, 74, 152, 23, 110, 86, 86, 173, 26, 125, 99, 99, 195, 29, 141, 111, 111, 216, 32, 156, 123, 123}
			VoHon_Property[103] = {131, 20, 93, 75, 75, 153, 23, 110, 89, 89, 174, 26, 125, 101, 101, 197, 29, 141, 114, 114, 218, 32, 156, 126, 126}
			VoHon_Property[104] = {132, 20, 96, 75, 75, 153, 23, 111, 89, 89, 176, 26, 128, 101, 101, 197, 29, 143, 114, 114, 219, 32, 159, 126, 126}
			VoHon_Property[105] = {134, 20, 96, 78, 78, 156, 23, 111, 90, 90, 179, 27, 128, 104, 104, 201, 30, 143, 116, 116, 224, 33, 159, 129, 129}
			VoHon_Property[106] = {135, 20, 98, 78, 78, 158, 23, 114, 90, 90, 180, 27, 129, 104, 104, 203, 30, 146, 116, 116, 225, 33, 162, 129, 129}
			VoHon_Property[107] = {137, 20, 98, 78, 78, 159, 23, 114, 90, 90, 182, 27, 129, 104, 104, 204, 30, 146, 116, 116, 227, 33, 162, 129, 129}
			VoHon_Property[108] = {137, 20, 99, 80, 80, 159, 23, 116, 93, 93, 183, 27, 132, 105, 105, 206, 30, 149, 119, 119, 228, 33, 165, 132, 132}
			VoHon_Property[109] = {138, 20, 99, 80, 80, 161, 23, 116, 93, 93, 183, 27, 132, 105, 105, 207, 30, 149, 119, 119, 230, 33, 165, 132, 132}
			VoHon_Property[110] = {141, 21, 101, 81, 81, 164, 24, 117, 95, 95, 188, 27, 135, 108, 108, 210, 32, 152, 122, 122, 234, 35, 168, 135, 135}
			VoHon_Property[111] = {141, 21, 101, 81, 81, 165, 24, 117, 95, 95, 189, 27, 135, 108, 108, 212, 32, 152, 122, 122, 236, 35, 168, 135, 135}
			VoHon_Property[112] = {143, 21, 102, 81, 81, 167, 24, 120, 95, 95, 189, 27, 137, 108, 108, 213, 32, 155, 122, 122, 237, 35, 171, 135, 135}
			VoHon_Property[113] = {143, 21, 102, 83, 83, 167, 24, 120, 96, 96, 191, 27, 137, 111, 111, 215, 32, 155, 125, 125, 239, 35, 171, 138, 138}
			VoHon_Property[114] = {144, 21, 105, 83, 83, 168, 24, 122, 96, 96, 192, 27, 140, 111, 111, 216, 32, 156, 125, 125, 240, 35, 174, 138, 138}
			VoHon_Property[115] = {147, 21, 105, 84, 84, 171, 26, 122, 99, 99, 195, 29, 140, 113, 113, 221, 33, 156, 128, 128, 245, 36, 174, 141, 141}
			VoHon_Property[116] = {147, 21, 107, 84, 84, 173, 26, 125, 99, 99, 197, 29, 141, 113, 113, 222, 33, 159, 128, 128, 246, 36, 177, 141, 141}
			VoHon_Property[117] = {149, 21, 107, 84, 84, 174, 26, 125, 99, 99, 198, 29, 141, 113, 113, 224, 33, 159, 128, 128, 248, 36, 177, 141, 141}
			VoHon_Property[118] = {150, 21, 108, 87, 87, 174, 26, 126, 101, 101, 200, 29, 144, 116, 116, 224, 33, 162, 129, 129, 249, 36, 180, 144, 144}
			VoHon_Property[119] = {150, 21, 108, 87, 87, 176, 26, 126, 101, 101, 201, 29, 144, 116, 116, 225, 33, 162, 129, 129, 251, 36, 180, 144, 144}
			VoHon_Property[120] = {153, 23, 110, 89, 89, 179, 27, 128, 104, 104, 204, 30, 147, 117, 117, 230, 35, 165, 132, 132, 255, 38, 183, 147, 147}
		
		local VoHon_Level = tonumber(strsub(Item108_Author,5,7));
		local VoHon_Base = tonumber(strsub(Item108_Author,13,13)) - 5;
		local VoHon_Magic = tonumber(strsub(Item108_Author,57,57));

		if Item108 == 10308001 or Item108 == 10308003 then
			local Magic_Impact = 14951 + VoHon_Magic;
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Magic_Impact) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Magic_Impact, 0)
			end
			CuongLuc = CuongLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 1];
			NoiLuc = NoiLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 2];
		end
		if Item108 == 10308002 or Item108 == 10308004 then
			local Magic_Impact = 14956 + VoHon_Magic;
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Magic_Impact) == 0 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Magic_Impact, 0)
			end
			CuongLuc = CuongLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 2];
			NoiLuc = NoiLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 1];
		end 
		TheLuc = TheLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 3];
		TriLuc = TriLuc + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 4];
		ThanPhap = ThanPhap + VoHon_Property[VoHon_Level][VoHon_Base * 5 + 5];
		
		if strsub(Item108_Author,18,47) ~= "------------------------------" then
			local VoHon_OptionAttr = {}
				VoHon_OptionAttr[1] = {18, 21, 24, 27, 30}
				VoHon_OptionAttr[2] = {25, 29, 33, 37, 41}
				VoHon_OptionAttr[3] = {38, 44, 50, 57, 63}
				VoHon_OptionAttr[4] = {56, 65, 74, 84, 93}
				VoHon_OptionAttr[5] = {79, 92, 105, 118, 131}
				VoHon_OptionAttr[6] = {104, 122, 139, 157, 174}
				VoHon_OptionAttr[7] = {134, 156, 178, 201, 223}
				VoHon_OptionAttr[8] = {166, 194, 222, 249, 277}
				VoHon_OptionAttr[9] = {202, 235, 269, 302, 336}
				VoHon_OptionAttr[10] = {240, 280, 320, 360, 400}
				VoHon_OptionAttr[11] = {18, 21, 24, 27, 30}
				VoHon_OptionAttr[12] = {25, 29, 33, 37, 41}
				VoHon_OptionAttr[13] = {38, 44, 50, 57, 63}
				VoHon_OptionAttr[14] = {56, 65, 74, 84, 93}
				VoHon_OptionAttr[15] = {79, 92, 105, 118, 131}
				VoHon_OptionAttr[16] = {104, 122, 139, 157, 174}
				VoHon_OptionAttr[17] = {134, 156, 178, 201, 223}
				VoHon_OptionAttr[18] = {166, 194, 222, 249, 277}
				VoHon_OptionAttr[19] = {202, 235, 269, 302, 336}
				VoHon_OptionAttr[20] = {240, 280, 320, 360, 400}
				VoHon_OptionAttr[21] = {18, 21, 24, 27, 30}
				VoHon_OptionAttr[22] = {25, 29, 33, 37, 41}
				VoHon_OptionAttr[23] = {38, 44, 50, 57, 63}
				VoHon_OptionAttr[24] = {56, 65, 74, 84, 93}
				VoHon_OptionAttr[25] = {79, 92, 105, 118, 131}
				VoHon_OptionAttr[26] = {104, 122, 139, 157, 174}
				VoHon_OptionAttr[27] = {134, 156, 178, 201, 223}
				VoHon_OptionAttr[28] = {166, 194, 222, 249, 277}
				VoHon_OptionAttr[29] = {202, 235, 269, 302, 336}
				VoHon_OptionAttr[30] = {240, 280, 320, 360, 400}
				VoHon_OptionAttr[31] = {18, 21, 24, 27, 30}
				VoHon_OptionAttr[32] = {25, 29, 33, 37, 41}
				VoHon_OptionAttr[33] = {38, 44, 50, 57, 63}
				VoHon_OptionAttr[34] = {56, 65, 74, 84, 93}
				VoHon_OptionAttr[35] = {79, 92, 105, 118, 131}
				VoHon_OptionAttr[36] = {104, 122, 139, 157, 174}
				VoHon_OptionAttr[37] = {134, 156, 178, 201, 223}
				VoHon_OptionAttr[38] = {166, 194, 222, 249, 277}
				VoHon_OptionAttr[39] = {202, 235, 269, 302, 336}
				VoHon_OptionAttr[40] = {240, 280, 320, 360, 400}
				VoHon_OptionAttr[41] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[42] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[43] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[44] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[45] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[46] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[47] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[48] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[49] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[50] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[51] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[52] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[53] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[54] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[55] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[56] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[57] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[58] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[59] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[60] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[61] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[62] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[63] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[64] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[65] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[66] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[67] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[68] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[69] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[70] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[71] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[72] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[73] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[74] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[75] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[76] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[77] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[78] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[79] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[80] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[81] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[82] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[83] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[84] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[85] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[86] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[87] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[88] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[89] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[90] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[91] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[92] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[93] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[94] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[95] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[96] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[97] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[98] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[99] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[100] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[101] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[102] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[103] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[104] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[105] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[106] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[107] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[108] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[109] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[110] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[111] = {5, 6, 6, 7, 8}
				VoHon_OptionAttr[112] = {7, 8, 9, 10, 11}
				VoHon_OptionAttr[113] = {10, 11, 13, 14, 16}
				VoHon_OptionAttr[114] = {14, 17, 19, 22, 24}
				VoHon_OptionAttr[115] = {20, 23, 26, 30, 33}
				VoHon_OptionAttr[116] = {26, 31, 35, 40, 44}
				VoHon_OptionAttr[117] = {34, 39, 45, 50, 56}
				VoHon_OptionAttr[118] = {42, 49, 56, 63, 70}
				VoHon_OptionAttr[119] = {50, 59, 67, 76, 84}
				VoHon_OptionAttr[120] = {60, 70, 80, 90, 100}
				VoHon_OptionAttr[121] = {1, 1, 2, 2, 2}
				VoHon_OptionAttr[122] = {2, 2, 2, 3, 3}
				VoHon_OptionAttr[123] = {2, 3, 3, 4, 4}
				VoHon_OptionAttr[124] = {3, 4, 4, 5, 5}
				VoHon_OptionAttr[125] = {4, 5, 6, 6, 7}
				VoHon_OptionAttr[126] = {5, 6, 7, 8, 9}
				VoHon_OptionAttr[127] = {7, 8, 10, 11, 12}
				VoHon_OptionAttr[128] = {8, 10, 11, 13, 14}
				VoHon_OptionAttr[129] = {10, 12, 14, 15, 17}
				VoHon_OptionAttr[130] = {12, 14, 16, 18, 20}
				VoHon_OptionAttr[131] = {1, 1, 2, 2, 2}
				VoHon_OptionAttr[132] = {2, 2, 2, 3, 3}
				VoHon_OptionAttr[133] = {2, 3, 3, 4, 4}
				VoHon_OptionAttr[134] = {3, 4, 4, 5, 5}
				VoHon_OptionAttr[135] = {4, 5, 6, 6, 7}
				VoHon_OptionAttr[136] = {5, 6, 7, 8, 9}
				VoHon_OptionAttr[137] = {7, 8, 10, 11, 12}
				VoHon_OptionAttr[138] = {8, 10, 11, 13, 14}
				VoHon_OptionAttr[139] = {10, 12, 14, 15, 17}
				VoHon_OptionAttr[140] = {12, 14, 16, 18, 20}
				VoHon_OptionAttr[141] = {1, 1, 2, 2, 2}
				VoHon_OptionAttr[142] = {2, 2, 2, 3, 3}
				VoHon_OptionAttr[143] = {2, 3, 3, 4, 4}
				VoHon_OptionAttr[144] = {3, 4, 4, 5, 5}
				VoHon_OptionAttr[145] = {4, 5, 6, 6, 7}
				VoHon_OptionAttr[146] = {5, 6, 7, 8, 9}
				VoHon_OptionAttr[147] = {7, 8, 10, 11, 12}
				VoHon_OptionAttr[148] = {8, 10, 11, 13, 14}
				VoHon_OptionAttr[149] = {10, 12, 14, 15, 17}
				VoHon_OptionAttr[150] = {12, 14, 16, 18, 20}
				VoHon_OptionAttr[151] = {1, 1, 2, 2, 2}
				VoHon_OptionAttr[152] = {2, 2, 2, 3, 3}
				VoHon_OptionAttr[153] = {2, 3, 3, 4, 4}
				VoHon_OptionAttr[154] = {3, 4, 4, 5, 5}
				VoHon_OptionAttr[155] = {4, 5, 6, 6, 7}
				VoHon_OptionAttr[156] = {5, 6, 7, 8, 9}
				VoHon_OptionAttr[157] = {7, 8, 10, 11, 12}
				VoHon_OptionAttr[158] = {8, 10, 11, 13, 14}
				VoHon_OptionAttr[159] = {10, 12, 14, 15, 17}
				VoHon_OptionAttr[160] = {12, 14, 16, 18, 20}
			
			local VoHon_OpP1 = {18,21,24,27,30,33,36,39,42,45}
			local VoHon_OpP2 = {20,23,26,29,32,35,38,41,44,47}
			
			for i = 1, 10 do
				local VoHon_Option = strsub(Item108_Author,VoHon_OpP1[i],VoHon_OpP2[i]);
				if VoHon_Option ~= "---" then
					VoHon_Option = tonumber(VoHon_Option);
					if VoHon_Option >= 1 and VoHon_Option <= 10 then
						BangCong = BangCong + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 11 and VoHon_Option <= 20 then
						HoaCong = HoaCong + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 21 and VoHon_Option <= 30 then
						HuyenCong = HuyenCong + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 31 and VoHon_Option <= 40 then
						DocCong = DocCong + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					
					if VoHon_Option >= 41 and VoHon_Option <= 50 then
						KhangBang = KhangBang + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 51 and VoHon_Option <= 60 then
						KhangHoa = KhangHoa + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 61 and VoHon_Option <= 70 then
						KhangHuyen = KhangHuyen + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 71 and VoHon_Option <= 80 then
						KhangDoc = KhangDoc + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					
					if VoHon_Option >= 81 and VoHon_Option <= 90 then
						GKBang = GKBang + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 91 and VoHon_Option <= 100 then
						GKHoa = GKHoa + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 101 and VoHon_Option <= 110 then
						GKHuyen = GKHuyen + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 111 and VoHon_Option <= 120 then
						GKDoc = GKDoc + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					
					if VoHon_Option >= 121 and VoHon_Option <= 130 then
						GKBangAm = GKBangAm + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 131 and VoHon_Option <= 140 then
						GKHoaAm = GKHoaAm + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 141 and VoHon_Option <= 150 then
						GKHuyenAm = GKHuyenAm + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
					if VoHon_Option >= 151 and VoHon_Option <= 160 then
						GKDocAm = GKDocAm + VoHon_OptionAttr[VoHon_Option][VoHon_Base + 1]
					end
				end
			end
		end
		
		if strsub(Item108_Author,48,56) ~= "---------" then
			local VoHon_Skill1 = strsub(Item108_Author,48,50);
			if VoHon_Skill1 ~= "---" then
				VoHon_Skill1 = tonumber(VoHon_Skill1) + 1360;
				if HaveSkill(sceneId,selfId,VoHon_Skill1) == -1 then
					AddSkill(sceneId,selfId,VoHon_Skill1)
				end
			else
				for i = 1361, 1384 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
			
			local VoHon_Skill2 = strsub(Item108_Author,51,53);
			if VoHon_Skill2 ~= "---" then
				VoHon_Skill2 = tonumber(VoHon_Skill2) + 1384;
				if HaveSkill(sceneId,selfId,VoHon_Skill2) == -1 then
					AddSkill(sceneId,selfId,VoHon_Skill2)
				end
			else
				for i = 1385, 1516 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
			
			local VoHon_Skill3 = strsub(Item108_Author,54,56);
			if VoHon_Skill3 ~= "---" then
				VoHon_Skill3 = tonumber(VoHon_Skill3) + 1516;
				if HaveSkill(sceneId,selfId,VoHon_Skill3) == -1 then
					AddSkill(sceneId,selfId,VoHon_Skill3)
				end
			else
				for i = 1517, 1600 do
					if HaveSkill(sceneId,selfId,i) == 1 then
						DelSkill(sceneId,selfId,i)
					end
				end
			end
		else
			for i = 1361, 1600 do
				if HaveSkill(sceneId,selfId,i) == 1 then
					DelSkill(sceneId,selfId,i)
				end
			end
		end
	else
		Item108_Author = "NoWuhun";
		for i = 1361, 1600 do
			if HaveSkill(sceneId,selfId,i) == 1 then
				DelSkill(sceneId,selfId,i)
			end
		end
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 14950, 0) --Cancel Model Wuhun--
	end
	
	--Add Point With t_Function--
	local CuongLucMD = GetMissionData(sceneId,selfId,POINTCHAR_CUONGLUC)
	if CuongLuc ~= CuongLucMD then
		local nCuongLuc = CuongLucMD - CuongLuc;
		local RemainPoint = GetPlayerRemainPoints(sceneId,selfId)
		LuaFnWashSomePoints(sceneId, selfId, 0, nCuongLuc)
		SetPlayerRemainPoints(sceneId,selfId,RemainPoint)
		SetMissionData(sceneId,selfId,POINTCHAR_CUONGLUC,CuongLuc)
	end
	local NoiLucMD = GetMissionData(sceneId,selfId,POINTCHAR_NOILUC)
	if NoiLuc ~= NoiLucMD then
		local nNoiLuc = NoiLucMD - NoiLuc;
		local RemainPoint = GetPlayerRemainPoints(sceneId,selfId)
		LuaFnWashSomePoints(sceneId, selfId, 1, nNoiLuc)
		SetPlayerRemainPoints(sceneId,selfId,RemainPoint)
		SetMissionData(sceneId,selfId,POINTCHAR_NOILUC,NoiLuc)
	end
	local TheLucMD = GetMissionData(sceneId,selfId,POINTCHAR_THELUC)
	if TheLuc ~= TheLucMD then
		local nTheLuc = TheLucMD - TheLuc;
		local RemainPoint = GetPlayerRemainPoints(sceneId,selfId)
		LuaFnWashSomePoints(sceneId, selfId, 2, nTheLuc)
		SetPlayerRemainPoints(sceneId,selfId,RemainPoint)
		SetMissionData(sceneId,selfId,POINTCHAR_THELUC,TheLuc)
	end
	local TriLucMD = GetMissionData(sceneId,selfId,POINTCHAR_TRILUC)
	if TriLuc ~= TriLucMD then
		local nTriLuc = TriLucMD - TriLuc;
		local RemainPoint = GetPlayerRemainPoints(sceneId,selfId)
		LuaFnWashSomePoints(sceneId, selfId, 3, nTriLuc)
		SetPlayerRemainPoints(sceneId,selfId,RemainPoint)
		SetMissionData(sceneId,selfId,POINTCHAR_TRILUC,TriLuc)
	end
	local ThanPhapMD = GetMissionData(sceneId,selfId,POINTCHAR_THANPHAP)
	if ThanPhap ~= ThanPhapMD then
		local nThanPhap = ThanPhapMD - ThanPhap;
		local RemainPoint = GetPlayerRemainPoints(sceneId,selfId)
		LuaFnWashSomePoints(sceneId, selfId, 4, nThanPhap)
		SetPlayerRemainPoints(sceneId,selfId,RemainPoint)
		SetMissionData(sceneId,selfId,POINTCHAR_THANPHAP,ThanPhap)
	end

	--Add Point With Impact--
	if BangCong ~= 0 then
		local BangCongX = mod(BangCong,100);
		local BangCongY = floor(BangCong/100);
		local ImpactX = BangCongX + 10500;
		local ImpactY = BangCongY + 10600;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10500, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10600, 0)
	end
	if HoaCong ~= 0 then
		local HoaCongX = mod(HoaCong,100);
		local HoaCongY = floor(HoaCong/100);
		local ImpactX = HoaCongX + 10700;
		local ImpactY = HoaCongY + 10800;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10700, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10800, 0)
	end
	if HuyenCong ~= 0 then
		local HuyenCongX = mod(HuyenCong,100);
		local HuyenCongY = floor(HuyenCong/100);
		local ImpactX = HuyenCongX + 10900;
		local ImpactY = HuyenCongY + 11000;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10900, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11000, 0)
	end
	if DocCong ~= 0 then
		local DocCongX = mod(DocCong,100);
		local DocCongY = floor(DocCong/100);
		local ImpactX = DocCongX + 11100;
		local ImpactY = DocCongY + 11200;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11100, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11200, 0)
	end

	if KhangBang ~= 0 then
		local KhangBangX = mod(KhangBang,100);
		local KhangBangY = floor(KhangBang/100);
		local ImpactX = KhangBangX + 11300;
		local ImpactY = KhangBangY + 11400;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11300, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11400, 0)
	end
	if KhangHoa ~= 0 then
		local KhangHoaX = mod(KhangHoa,100);
		local KhangHoaY = floor(KhangHoa/100);
		local ImpactX = KhangHoaX + 11450;
		local ImpactY = KhangHoaY + 11550;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11450, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11550, 0)
	end
	if KhangHuyen ~= 0 then
		local KhangHuyenX = mod(KhangHuyen,100);
		local KhangHuyenY = floor(KhangHuyen/100);
		local ImpactX = KhangHuyenX + 11600;
		local ImpactY = KhangHuyenY + 11700;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11600, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11700, 0)
	end
	if KhangDoc ~= 0 then
		local KhangDocX = mod(KhangDoc,100);
		local KhangDocY = floor(KhangDoc/100);
		local ImpactX = KhangDocX + 11750;
		local ImpactY = KhangDocY + 11850;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11750, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11850, 0)
	end
	
	if GKBang ~= 0 then
		local GKBangX = mod(GKBang,100);
		local GKBangY = floor(GKBang/100);
		local ImpactX = GKBangX + 11900;
		local ImpactY = GKBangY + 12000;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 11900, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12000, 0)
	end
	if GKHoa ~= 0 then
		local GKHoaX = mod(GKHoa,100);
		local GKHoaY = floor(GKHoa/100);
		local ImpactX = GKHoaX + 12050;
		local ImpactY = GKHoaY + 12150;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12050, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12150, 0)
	end
	if GKHuyen ~= 0 then
		local GKHuyenX = mod(GKHuyen,100);
		local GKHuyenY = floor(GKHuyen/100);
		local ImpactX = GKHuyenX + 12200;
		local ImpactY = GKHuyenY + 12300;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12200, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12300, 0)
	end
	if GKDoc ~= 0 then
		local GKDocX = mod(GKDoc,100);
		local GKDocY = floor(GKDoc/100);
		local ImpactX = GKDocX + 12350;
		local ImpactY = GKDocY + 12450;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactX) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactX, 0)
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactY) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, ImpactY, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12350, 0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12450, 0)
	end
	
	if GKBangAm ~= 0 then
		local GKABang = GKBangAm + 13700;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GKABang) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GKABang, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13700, 0)
	end
	
	if GKHoaAm ~= 0 then
		local GKAHoa = GKHoaAm + 13900;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GKAHoa) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GKAHoa, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13900, 0)
	end
	
	if GKHuyenAm ~= 0 then
		local GKAHuyen = GKHuyenAm + 14100;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GKAHuyen) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GKAHuyen, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 14100, 0)
	end
	
	if GKDocAm ~= 0 then
		local GKADoc = GKDocAm + 14300;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GKADoc) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GKADoc, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 14300, 0)
	end
	
	if HoiCong ~= 0 then
		local HC = HoiCong + 13400;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, HC) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, HC, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13400, 0)
	end
	if HoiThu ~= 0 then
		local HT = HoiThu + 13500;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, HT) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, HT, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13500, 0)
	end
	if Hp_Max ~= 0 then
		local GHMau = Hp_Max + 13600;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GHMau) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, GHMau, 0)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13600, 0)
	end
	
	--Add Point With Impact and Xinfa--
	if SinhLuc ~= 0 then
		local SinhLucX = mod(SinhLuc,200);
		local SinhLucY = floor(SinhLuc/200);
		local Impact = SinhLucX + 12500;
		local Xinfa = SinhLucY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 101) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 101, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12500, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 101, 0)
	end
	
	if SinhKhi ~= 0 then
		local SinhKhiX = mod(SinhKhi,100);
		local SinhKhiY = floor(SinhKhi/100);
		local Impact = SinhKhiX + 12700;
		local Xinfa = SinhKhiY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 102) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 102, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12700, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 102, 0)
	end
	
	if NgoaiCong ~= 0 then
		local NgoaiCongX = mod(NgoaiCong,100);
		local NgoaiCongY = floor(NgoaiCong/100);
		local Impact = NgoaiCongX + 12800;
		local Xinfa = NgoaiCongY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 103) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 103, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12800, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 103, 0)
	end
	
	if NoiCong ~= 0 then
		local NoiCongX = mod(NoiCong,100);
		local NoiCongY = floor(NoiCong/100);
		local Impact = NoiCongX + 12900;
		local Xinfa = NoiCongY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 104) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 104, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 12900, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 104, 0)
	end
	
	if NgoaiThu ~= 0 then
		local NgoaiThuX = mod(NgoaiThu,100);
		local NgoaiThuY = floor(NgoaiThu/100);
		local Impact = NgoaiThuX + 13000;
		local Xinfa = NgoaiThuY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 105) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 105, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13000, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 105, 0)
	end
	
	if NoiThu ~= 0 then
		local NoiThuX = mod(NoiThu,100);
		local NoiThuY = floor(NoiThu/100);
		local Impact = NoiThuX + 13100;
		local Xinfa = NoiThuY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 106) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 106, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13100, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 106, 0)
	end
	
	if ChinhXac ~= 0 then
		local ChinhXacX = mod(ChinhXac,100);
		local ChinhXacY = floor(ChinhXac/100);
		local Impact = ChinhXacX + 13200;
		local Xinfa = ChinhXacY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 107) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 107, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13200, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 107, 0)
	end
	
	if NeTranh ~= 0 then
		local NeTranhX = mod(NeTranh,100);
		local NeTranhY = floor(NeTranh/100);
		local Impact = NeTranhX + 13300;
		local Xinfa = NeTranhY;
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, Impact) == 0 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, Impact, 0)
		end
		if LuaFnGetXinFaLevel(sceneId, selfId, 108) ~= Xinfa then
			LuaFnSetXinFaLevel(sceneId, selfId, 108, Xinfa)
		end
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 13300, 0)
		LuaFnSetXinFaLevel(sceneId, selfId, 108, 0)
	end
	
	
	--Process UI Command--
	if GKBangAm < 10 then
		GKBangAm = "0"..GKBangAm;
	end
	if GKHoaAm < 10 then
		GKHoaAm = "0"..GKHoaAm;
	end
	if GKHuyenAm < 10 then
		GKHuyenAm = "0"..GKHuyenAm;
	end
	if GKDocAm < 10 then
		GKDocAm = "0"..GKDocAm;
	end
	BeginUICommand(sceneId)
		UICommand_AddString(sceneId,"*"..GKBangAm.."*"..GKHoaAm.."*"..GKHuyenAm.."*"..GKDocAm.."*")
		UICommand_AddString(sceneId,Item108_Author)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,74130101)
end

function x741301_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
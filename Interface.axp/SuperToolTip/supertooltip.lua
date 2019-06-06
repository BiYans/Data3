local CU_MONEY			= 1	-- Ç®
local CU_GOODBAD		= 2	-- ÉÆ¶ñÖµ
local CU_MORALPOINT	= 3	-- Ê¦µÂµã
local CU_TICKET			= 4 -- ¹ÙÆ±Ç®
local CU_YUANBAO		= 5	-- Ôª±¦
local CU_ZENGDIAN		= 6 -- Ôùµã
local CU_MENPAI_POINT	= 7 -- Ê¦ÃÅ¹±Ï×¶È
local CU_MONEYJZ		= 8 -- ½»×Ó
local CU_BIND_YUANBAO	= 9 -- °ó¶¨Ôª±¦

local Ride_Icon = {"RideHeader1_13", "RideHeader1_14", "RideHeader2_3", "RideHeader2_4", "RideHeader1_7", "RideHeader1_8", "RideHeader2_2", "RideHeader2_1", "RideHeader1_16", "RideHeader1_15", "RideHeader1_3", "RideHeader1_4", "RideHeader1_2", "RideHeader1_1", "RideHeader1_9", "RideHeader1_10", "RideHeader1_5", "RideHeader1_6"}
local Ride_Menpai = {0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8}
local Menpai_Str = {"Thiªu Lâm", "Minh Giáo", "Cái Bang", "Võ Ðang", "Nga My", "Tinh Túc", "Thiên Long", "Thiên S½n", "Tiêu Dao"}

local VoHon = {}
local VoHon_Exp = {}
	VoHon_Exp[1] = {1500}
	VoHon_Exp[2] = {1510}
	VoHon_Exp[3] = {1540}
	VoHon_Exp[4] = {1580}
	VoHon_Exp[5] = {1640}
	VoHon_Exp[6] = {1710}
	VoHon_Exp[7] = {1800}
	VoHon_Exp[8] = {1890}
	VoHon_Exp[9] = {2000}
	VoHon_Exp[10] = {2120}
	VoHon_Exp[11] = {2250}
	VoHon_Exp[12] = {2390}
	VoHon_Exp[13] = {2540}
	VoHon_Exp[14] = {2700}
	VoHon_Exp[15] = {2870}
	VoHon_Exp[16] = {3060}
	VoHon_Exp[17] = {3250}
	VoHon_Exp[18] = {3450}
	VoHon_Exp[19] = {3660}
	VoHon_Exp[20] = {3880}
	VoHon_Exp[21] = {4120}
	VoHon_Exp[22] = {4360}
	VoHon_Exp[23] = {4610}
	VoHon_Exp[24] = {4870}
	VoHon_Exp[25] = {5130}
	VoHon_Exp[26] = {5410}
	VoHon_Exp[27] = {5700}
	VoHon_Exp[28] = {5990}
	VoHon_Exp[29] = {6300}
	VoHon_Exp[30] = {6610}
	VoHon_Exp[31] = {6930}
	VoHon_Exp[32] = {7260}
	VoHon_Exp[33] = {7600}
	VoHon_Exp[34] = {7950}
	VoHon_Exp[35] = {8310}
	VoHon_Exp[36] = {8670}
	VoHon_Exp[37] = {9040}
	VoHon_Exp[38] = {9430}
	VoHon_Exp[39] = {9820}
	VoHon_Exp[40] = {10210}
	VoHon_Exp[41] = {10620}
	VoHon_Exp[42] = {11040}
	VoHon_Exp[43] = {11460}
	VoHon_Exp[44] = {11890}
	VoHon_Exp[45] = {12330}
	VoHon_Exp[46] = {12780}
	VoHon_Exp[47] = {13230}
	VoHon_Exp[48] = {13690}
	VoHon_Exp[49] = {14170}
	VoHon_Exp[50] = {14640}
	VoHon_Exp[51] = {15130}
	VoHon_Exp[52] = {15630}
	VoHon_Exp[53] = {16130}
	VoHon_Exp[54] = {16640}
	VoHon_Exp[55] = {17160}
	VoHon_Exp[56] = {17680}
	VoHon_Exp[57] = {18220}
	VoHon_Exp[58] = {18760}
	VoHon_Exp[59] = {19310}
	VoHon_Exp[60] = {19860}
	VoHon_Exp[61] = {20430}
	VoHon_Exp[62] = {21000}
	VoHon_Exp[63] = {21580}
	VoHon_Exp[64] = {22170}
	VoHon_Exp[65] = {22760}
	VoHon_Exp[66] = {23360}
	VoHon_Exp[67] = {23970}
	VoHon_Exp[68] = {24590}
	VoHon_Exp[69] = {25210}
	VoHon_Exp[70] = {25840}
	VoHon_Exp[71] = {26480}
	VoHon_Exp[72] = {27130}
	VoHon_Exp[73] = {27780}
	VoHon_Exp[74] = {28440}
	VoHon_Exp[75] = {29110}
	VoHon_Exp[76] = {29790}
	VoHon_Exp[77] = {30470}
	VoHon_Exp[78] = {31160}
	VoHon_Exp[79] = {31860}
	VoHon_Exp[80] = {32560}
	VoHon_Exp[81] = {33270}
	VoHon_Exp[82] = {33990}
	VoHon_Exp[83] = {34720}
	VoHon_Exp[84] = {35450}
	VoHon_Exp[85] = {36190}
	VoHon_Exp[86] = {36940}
	VoHon_Exp[87] = {37690}
	VoHon_Exp[88] = {38450}
	VoHon_Exp[89] = {39220}
	VoHon_Exp[90] = {40000}
	VoHon_Exp[91] = {40780}
	VoHon_Exp[92] = {41570}
	VoHon_Exp[93] = {42360}
	VoHon_Exp[94] = {43170}
	VoHon_Exp[95] = {43980}
	VoHon_Exp[96] = {44790}
	VoHon_Exp[97] = {45620}
	VoHon_Exp[98] = {46450}
	VoHon_Exp[99] = {47280}
	VoHon_Exp[100] = {48130}
	VoHon_Exp[101] = {48980}
	VoHon_Exp[102] = {49840}
	VoHon_Exp[103] = {50700}
	VoHon_Exp[104] = {51580}
	VoHon_Exp[105] = {52450}
	VoHon_Exp[106] = {53340}
	VoHon_Exp[107] = {54230}
	VoHon_Exp[108] = {55130}
	VoHon_Exp[109] = {56040}
	VoHon_Exp[110] = {56950}
	VoHon_Exp[111] = {57870}
	VoHon_Exp[112] = {58790}
	VoHon_Exp[113] = {59730}
	VoHon_Exp[114] = {60660}
	VoHon_Exp[115] = {61610}
	VoHon_Exp[116] = {62560}
	VoHon_Exp[117] = {63520}
	VoHon_Exp[118] = {64490}
	VoHon_Exp[119] = {65460}
	VoHon_Exp[120] = {66440}

local VoHon_Base = {"S½ c¤p", "Xu¤t s¡c", "Ki®t xu¤t", "Trác vi®t", "Toàn mÛ"}

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

local VoHon_Option = {}
	VoHon_Option[1] = {"Bång công (C¤p 1) +", 18, 21, 24, 27, 30}
	VoHon_Option[2] = {"Bång công (C¤p 2) +", 25, 29, 33, 37, 41}
	VoHon_Option[3] = {"Bång công (C¤p 3) +", 38, 44, 50, 57, 63}
	VoHon_Option[4] = {"Bång công (C¤p 4) +", 56, 65, 74, 84, 93}
	VoHon_Option[5] = {"Bång công (C¤p 5) +", 79, 92, 105, 118, 131}
	VoHon_Option[6] = {"Bång công (C¤p 6) +", 104, 122, 139, 157, 174}
	VoHon_Option[7] = {"Bång công (C¤p 7) +", 134, 156, 178, 201, 223}
	VoHon_Option[8] = {"Bång công (C¤p 8) +", 166, 194, 222, 249, 277}
	VoHon_Option[9] = {"Bång công (C¤p 9) +", 202, 235, 269, 302, 336}
	VoHon_Option[10] = {"Bång công (C¤p 10) +", 240, 280, 320, 360, 400}
	VoHon_Option[11] = {"Höa công (C¤p 1) +", 18, 21, 24, 27, 30}
	VoHon_Option[12] = {"Höa công (C¤p 2) +", 25, 29, 33, 37, 41}
	VoHon_Option[13] = {"Höa công (C¤p 3) +", 38, 44, 50, 57, 63}
	VoHon_Option[14] = {"Höa công (C¤p 4) +", 56, 65, 74, 84, 93}
	VoHon_Option[15] = {"Höa công (C¤p 5) +", 79, 92, 105, 118, 131}
	VoHon_Option[16] = {"Höa công (C¤p 6) +", 104, 122, 139, 157, 174}
	VoHon_Option[17] = {"Höa công (C¤p 7) +", 134, 156, 178, 201, 223}
	VoHon_Option[18] = {"Höa công (C¤p 8) +", 166, 194, 222, 249, 277}
	VoHon_Option[19] = {"Höa công (C¤p 9) +", 202, 235, 269, 302, 336}
	VoHon_Option[20] = {"Höa công (C¤p 10) +", 240, 280, 320, 360, 400}
	VoHon_Option[21] = {"Huy«n công (C¤p 1) +", 18, 21, 24, 27, 30}
	VoHon_Option[22] = {"Huy«n công (C¤p 2) +", 25, 29, 33, 37, 41}
	VoHon_Option[23] = {"Huy«n công (C¤p 3) +", 38, 44, 50, 57, 63}
	VoHon_Option[24] = {"Huy«n công (C¤p 4) +", 56, 65, 74, 84, 93}
	VoHon_Option[25] = {"Huy«n công (C¤p 5) +", 79, 92, 105, 118, 131}
	VoHon_Option[26] = {"Huy«n công (C¤p 6) +", 104, 122, 139, 157, 174}
	VoHon_Option[27] = {"Huy«n công (C¤p 7) +", 134, 156, 178, 201, 223}
	VoHon_Option[28] = {"Huy«n công (C¤p 8) +", 166, 194, 222, 249, 277}
	VoHon_Option[29] = {"Huy«n công (C¤p 9) +", 202, 235, 269, 302, 336}
	VoHon_Option[30] = {"Huy«n công (C¤p 10) +", 240, 280, 320, 360, 400}
	VoHon_Option[31] = {"Ðµc công (C¤p 1) +", 18, 21, 24, 27, 30}
	VoHon_Option[32] = {"Ðµc công (C¤p 2) +", 25, 29, 33, 37, 41}
	VoHon_Option[33] = {"Ðµc công (C¤p 3) +", 38, 44, 50, 57, 63}
	VoHon_Option[34] = {"Ðµc công (C¤p 4) +", 56, 65, 74, 84, 93}
	VoHon_Option[35] = {"Ðµc công (C¤p 5) +", 79, 92, 105, 118, 131}
	VoHon_Option[36] = {"Ðµc công (C¤p 6) +", 104, 122, 139, 157, 174}
	VoHon_Option[37] = {"Ðµc công (C¤p 7) +", 134, 156, 178, 201, 223}
	VoHon_Option[38] = {"Ðµc công (C¤p 8) +", 166, 194, 222, 249, 277}
	VoHon_Option[39] = {"Ðµc công (C¤p 9) +", 202, 235, 269, 302, 336}
	VoHon_Option[40] = {"Ðµc công (C¤p 10) +", 240, 280, 320, 360, 400}
	VoHon_Option[41] = {"Kháng bång (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[42] = {"Kháng bång (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[43] = {"Kháng bång (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[44] = {"Kháng bång (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[45] = {"Kháng bång (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[46] = {"Kháng bång (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[47] = {"Kháng bång (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[48] = {"Kháng bång (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[49] = {"Kháng bång (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[50] = {"Kháng bång (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[51] = {"Kháng höa (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[52] = {"Kháng höa (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[53] = {"Kháng höa (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[54] = {"Kháng höa (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[55] = {"Kháng höa (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[56] = {"Kháng höa (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[57] = {"Kháng höa (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[58] = {"Kháng höa (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[59] = {"Kháng höa (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[60] = {"Kháng höa (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[61] = {"Kháng huy«n (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[62] = {"Kháng huy«n (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[63] = {"Kháng huy«n (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[64] = {"Kháng huy«n (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[65] = {"Kháng huy«n (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[66] = {"Kháng huy«n (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[67] = {"Kháng huy«n (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[68] = {"Kháng huy«n (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[69] = {"Kháng huy«n (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[70] = {"Kháng huy«n (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[71] = {"Kháng ðµc (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[72] = {"Kháng ðµc (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[73] = {"Kháng ðµc (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[74] = {"Kháng ðµc (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[75] = {"Kháng ðµc (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[76] = {"Kháng ðµc (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[77] = {"Kháng ðµc (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[78] = {"Kháng ðµc (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[79] = {"Kháng ðµc (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[80] = {"Kháng ðµc (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[81] = {"Xuyên kháng bång (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[82] = {"Xuyên kháng bång (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[83] = {"Xuyên kháng bång (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[84] = {"Xuyên kháng bång (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[85] = {"Xuyên kháng bång (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[86] = {"Xuyên kháng bång (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[87] = {"Xuyên kháng bång (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[88] = {"Xuyên kháng bång (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[89] = {"Xuyên kháng bång (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[90] = {"Xuyên kháng bång (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[91] = {"Xuyên kháng höa (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[92] = {"Xuyên kháng höa (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[93] = {"Xuyên kháng höa (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[94] = {"Xuyên kháng höa (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[95] = {"Xuyên kháng höa (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[96] = {"Xuyên kháng höa (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[97] = {"Xuyên kháng höa (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[98] = {"Xuyên kháng höa (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[99] = {"Xuyên kháng höa (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[100] = {"Xuyên kháng höa (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[101] = {"Xuyên kháng huy«n (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[102] = {"Xuyên kháng huy«n (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[103] = {"Xuyên kháng huy«n (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[104] = {"Xuyên kháng huy«n (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[105] = {"Xuyên kháng huy«n (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[106] = {"Xuyên kháng huy«n (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[107] = {"Xuyên kháng huy«n (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[108] = {"Xuyên kháng huy«n (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[109] = {"Xuyên kháng huy«n (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[110] = {"Xuyên kháng huy«n (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[111] = {"Xuyên kháng ðµc (C¤p 1) +", 5, 6, 6, 7, 8}
	VoHon_Option[112] = {"Xuyên kháng ðµc (C¤p 2) +", 7, 8, 9, 10, 11}
	VoHon_Option[113] = {"Xuyên kháng ðµc (C¤p 3) +", 10, 11, 13, 14, 16}
	VoHon_Option[114] = {"Xuyên kháng ðµc (C¤p 4) +", 14, 17, 19, 22, 24}
	VoHon_Option[115] = {"Xuyên kháng ðµc (C¤p 5) +", 20, 23, 26, 30, 33}
	VoHon_Option[116] = {"Xuyên kháng ðµc (C¤p 6) +", 26, 31, 35, 40, 44}
	VoHon_Option[117] = {"Xuyên kháng ðµc (C¤p 7) +", 34, 39, 45, 50, 56}
	VoHon_Option[118] = {"Xuyên kháng ðµc (C¤p 8) +", 42, 49, 56, 63, 70}
	VoHon_Option[119] = {"Xuyên kháng ðµc (C¤p 9) +", 50, 59, 67, 76, 84}
	VoHon_Option[120] = {"Xuyên kháng ðµc (C¤p 10) +", 60, 70, 80, 90, 100}
	VoHon_Option[121] = {"Giäm kháng bång ðªn âm (C¤p 1) +", 1, 1, 2, 2, 2}
	VoHon_Option[122] = {"Giäm kháng bång ðªn âm (C¤p 2) +", 2, 2, 2, 3, 3}
	VoHon_Option[123] = {"Giäm kháng bång ðªn âm (C¤p 3) +", 2, 3, 3, 4, 4}
	VoHon_Option[124] = {"Giäm kháng bång ðªn âm (C¤p 4) +", 3, 4, 4, 5, 5}
	VoHon_Option[125] = {"Giäm kháng bång ðªn âm (C¤p 5) +", 4, 5, 6, 6, 7}
	VoHon_Option[126] = {"Giäm kháng bång ðªn âm (C¤p 6) +", 5, 6, 7, 8, 9}
	VoHon_Option[127] = {"Giäm kháng bång ðªn âm (C¤p 7) +", 7, 8, 10, 11, 12}
	VoHon_Option[128] = {"Giäm kháng bång ðªn âm (C¤p 8) +", 8, 10, 11, 13, 14}
	VoHon_Option[129] = {"Giäm kháng bång ðªn âm (C¤p 9) +", 10, 12, 14, 15, 17}
	VoHon_Option[130] = {"Giäm kháng bång ðªn âm (C¤p 10) +", 12, 14, 16, 18, 20}
	VoHon_Option[131] = {"Giäm kháng höa ðªn âm (C¤p 1) +", 1, 1, 2, 2, 2}
	VoHon_Option[132] = {"Giäm kháng höa ðªn âm (C¤p 2) +", 2, 2, 2, 3, 3}
	VoHon_Option[133] = {"Giäm kháng höa ðªn âm (C¤p 3) +", 2, 3, 3, 4, 4}
	VoHon_Option[134] = {"Giäm kháng höa ðªn âm (C¤p 4) +", 3, 4, 4, 5, 5}
	VoHon_Option[135] = {"Giäm kháng höa ðªn âm (C¤p 5) +", 4, 5, 6, 6, 7}
	VoHon_Option[136] = {"Giäm kháng höa ðªn âm (C¤p 6) +", 5, 6, 7, 8, 9}
	VoHon_Option[137] = {"Giäm kháng höa ðªn âm (C¤p 7) +", 7, 8, 10, 11, 12}
	VoHon_Option[138] = {"Giäm kháng höa ðªn âm (C¤p 8) +", 8, 10, 11, 13, 14}
	VoHon_Option[139] = {"Giäm kháng höa ðªn âm (C¤p 9) +", 10, 12, 14, 15, 17}
	VoHon_Option[140] = {"Giäm kháng höa ðªn âm (C¤p 10) +", 12, 14, 16, 18, 20}
	VoHon_Option[141] = {"Giäm kháng huy«n ðªn âm (C¤p 1) +", 1, 1, 2, 2, 2}
	VoHon_Option[142] = {"Giäm kháng huy«n ðªn âm (C¤p 2) +", 2, 2, 2, 3, 3}
	VoHon_Option[143] = {"Giäm kháng huy«n ðªn âm (C¤p 3) +", 2, 3, 3, 4, 4}
	VoHon_Option[144] = {"Giäm kháng huy«n ðªn âm (C¤p 4) +", 3, 4, 4, 5, 5}
	VoHon_Option[145] = {"Giäm kháng huy«n ðªn âm (C¤p 5) +", 4, 5, 6, 6, 7}
	VoHon_Option[146] = {"Giäm kháng huy«n ðªn âm (C¤p 6) +", 5, 6, 7, 8, 9}
	VoHon_Option[147] = {"Giäm kháng huy«n ðªn âm (C¤p 7) +", 7, 8, 10, 11, 12}
	VoHon_Option[148] = {"Giäm kháng huy«n ðªn âm (C¤p 8) +", 8, 10, 11, 13, 14}
	VoHon_Option[149] = {"Giäm kháng huy«n ðªn âm (C¤p 9) +", 10, 12, 14, 15, 17}
	VoHon_Option[150] = {"Giäm kháng huy«n ðªn âm (C¤p 10) +", 12, 14, 16, 18, 20}
	VoHon_Option[151] = {"Giäm kháng ðµc ðªn âm (C¤p 1) +", 1, 1, 2, 2, 2}
	VoHon_Option[152] = {"Giäm kháng ðµc ðªn âm (C¤p 2) +", 2, 2, 2, 3, 3}
	VoHon_Option[153] = {"Giäm kháng ðµc ðªn âm (C¤p 3) +", 2, 3, 3, 4, 4}
	VoHon_Option[154] = {"Giäm kháng ðµc ðªn âm (C¤p 4) +", 3, 4, 4, 5, 5}
	VoHon_Option[155] = {"Giäm kháng ðµc ðªn âm (C¤p 5) +", 4, 5, 6, 6, 7}
	VoHon_Option[156] = {"Giäm kháng ðµc ðªn âm (C¤p 6) +", 5, 6, 7, 8, 9}
	VoHon_Option[157] = {"Giäm kháng ðµc ðªn âm (C¤p 7) +", 7, 8, 10, 11, 12}
	VoHon_Option[158] = {"Giäm kháng ðµc ðªn âm (C¤p 8) +", 8, 10, 11, 13, 14}
	VoHon_Option[159] = {"Giäm kháng ðµc ðªn âm (C¤p 9) +", 10, 12, 14, 15, 17}
	VoHon_Option[160] = {"Giäm kháng ðµc ðªn âm (C¤p 10) +", 12, 14, 16, 18, 20}

VoHon_Skill1 = {}
	VoHon_Skill1[1] = {"Thanh D§t Chi H°n (C¤p 1)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 70%"}
	VoHon_Skill1[2] = {"Thanh D§t Chi H°n (C¤p 2)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 80%"}
	VoHon_Skill1[3] = {"Thanh D§t Chi H°n (C¤p 3)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 90%"}
	VoHon_Skill1[4] = {"Thanh D§t Chi H°n (C¤p 4)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 100%"}
	VoHon_Skill1[5] = {"Thanh D§t Chi H°n (C¤p 5)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 110%"}
	VoHon_Skill1[6] = {"Thanh D§t Chi H°n (C¤p 6)", "Phiªn, Hoàn tång nµi ngoÕi công c½ bän 120%"}
	VoHon_Skill1[7] = {"Hàn Phong Chi H°n (C¤p 1)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 70%"}
	VoHon_Skill1[8] = {"Hàn Phong Chi H°n (C¤p 2)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 80%"}
	VoHon_Skill1[9] = {"Hàn Phong Chi H°n (C¤p 3)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 90%"}
	VoHon_Skill1[10] = {"Hàn Phong Chi H°n (C¤p 4)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 100%"}
	VoHon_Skill1[11] = {"Hàn Phong Chi H°n (C¤p 5)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 110%"}
	VoHon_Skill1[12] = {"Hàn Phong Chi H°n (C¤p 6)", "Ð½n ðoän, Song ðoän tång nµi ngoÕi công c½ bän 120%"}
	VoHon_Skill1[13] = {"Võ Dûng Chi H°n (C¤p 1)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 70%"}
	VoHon_Skill1[14] = {"Võ Dûng Chi H°n (C¤p 2)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 80%"}
	VoHon_Skill1[15] = {"Võ Dûng Chi H°n (C¤p 3)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 90%"}
	VoHon_Skill1[16] = {"Võ Dûng Chi H°n (C¤p 4)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 100%"}
	VoHon_Skill1[17] = {"Võ Dûng Chi H°n (C¤p 5)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 110%"}
	VoHon_Skill1[18] = {"Võ Dûng Chi H°n (C¤p 6)", "Ðao búa, Thß½ng b±ng tång nµi ngoÕi công c½ bän 120%"}
	VoHon_Skill1[19] = {"Ngñ Th¬ Chi H°n (C¤p 1)", "Phòng cø tång nµi ngoÕi thü c½ bän 70%"}
	VoHon_Skill1[20] = {"Ngñ Th¬ Chi H°n (C¤p 2)", "Phòng cø tång nµi ngoÕi thü c½ bän 80%"}
	VoHon_Skill1[21] = {"Ngñ Th¬ Chi H°n (C¤p 3)", "Phòng cø tång nµi ngoÕi thü c½ bän 90%"}
	VoHon_Skill1[22] = {"Ngñ Th¬ Chi H°n (C¤p 4)", "Phòng cø tång nµi ngoÕi thü c½ bän 100%"}
	VoHon_Skill1[23] = {"Ngñ Th¬ Chi H°n (C¤p 5)", "Phòng cø tång nµi ngoÕi thü c½ bän 110%"}
	VoHon_Skill1[24] = {"Ngñ Th¬ Chi H°n (C¤p 6)", "Phòng cø tång nµi ngoÕi thü c½ bän 120%"}

VoHon_Skill2 = {}
	VoHon_Skill2[1] = {"Du Thân Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Thân pháp 56 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[2] = {"Du Thân Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Thân pháp 63 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[3] = {"Du Thân Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Thân pháp 69 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[4] = {"Du Thân Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Thân pháp 76 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[5] = {"Du Thân Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Thân pháp 82 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[6] = {"Du Thân Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Thân pháp 89 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[7] = {"Thßþng Vû Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 34 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[8] = {"Thßþng Vû Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 39 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[9] = {"Thßþng Vû Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 44 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[10] = {"Thßþng Vû Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 49 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[11] = {"Thßþng Vû Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 54 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[12] = {"Thßþng Vû Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång t¤t cä thuµc tính cüa bän thân 59 ði¬m, Thân pháp gia tång mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[13] = {"PhÕp Lñc Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 113 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[14] = {"PhÕp Lñc Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 126 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[15] = {"PhÕp Lñc Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 139 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[16] = {"PhÕp Lñc Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 152 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[17] = {"PhÕp Lñc Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 165 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[18] = {"PhÕp Lñc Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Cß¶ng Lñc cüa møc tiêu 178 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[19] = {"Di®t Linh Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 113 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[20] = {"Di®t Linh Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 126 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[21] = {"Di®t Linh Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 139 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[22] = {"Di®t Linh Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 152 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[23] = {"Di®t Linh Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 165 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[24] = {"Di®t Linh Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Nµi Lñc cüa møc tiêu 178 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[25] = {"Phá Th¬ Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 113 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[26] = {"Phá Th¬ Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 126 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[27] = {"Phá Th¬ Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 139 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[28] = {"Phá Th¬ Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 152 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[29] = {"Phá Th¬ Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 165 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[30] = {"Phá Th¬ Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Th¬ Lñc cüa møc tiêu 178 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[31] = {"LoÕn Ð¸nh Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 113 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[32] = {"LoÕn Ð¸nh Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 126 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[33] = {"LoÕn Ð¸nh Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 139 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[34] = {"LoÕn Ð¸nh Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 152 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[35] = {"LoÕn Ð¸nh Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 165 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[36] = {"LoÕn Ð¸nh Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Trí Lñc cüa møc tiêu 178 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[37] = {"Tr÷ng Thân Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 56 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[38] = {"Tr÷ng Thân Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 63 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[39] = {"Tr÷ng Thân Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 69 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[40] = {"Tr÷ng Thân Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 76 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[41] = {"Tr÷ng Thân Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 82 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[42] = {"Tr÷ng Thân Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Thân Pháp cüa møc tiêu 89 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[43] = {"Tuy®t Tình Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 34 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[44] = {"Tuy®t Tình Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 39 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[45] = {"Tuy®t Tình Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 44 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[46] = {"Tuy®t Tình Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 49 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[47] = {"Tuy®t Tình Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 54 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[48] = {"Tuy®t Tình Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm T¤t cä thuµc tính cüa møc tiêu 59 ði¬m, Thân pháp gïam mµt nØa, duy trì 10 giây"}
	VoHon_Skill2[49] = {"L® Cß½ng Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång NgoÕi công 1256 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[50] = {"L® Cß½ng Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång NgoÕi công 1396 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[51] = {"L® Cß½ng Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång NgoÕi công 1552 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[52] = {"L® Cß½ng Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång NgoÕi công 1724 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[53] = {"L® Cß½ng Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång NgoÕi công 1916 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[54] = {"L® Cß½ng Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång NgoÕi công 2131 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[55] = {"Toàn Nhu Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Nµi công 1256 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[56] = {"Toàn Nhu Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Nµi công 1396 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[57] = {"Toàn Nhu Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Nµi công 1552 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[58] = {"Toàn Nhu Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Nµi công 1724 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[59] = {"Toàn Nhu Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Nµi công 1916 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[60] = {"Toàn Nhu Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Nµi công 2131 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[61] = {"Vû Nh§n Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång NgoÕi thü 1249 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[62] = {"Vû Nh§n Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång NgoÕi thü 1388 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[63] = {"Vû Nh§n Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång NgoÕi thü 1544 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[64] = {"Vû Nh§n Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång NgoÕi thü 1716 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[65] = {"Vû Nh§n Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång NgoÕi thü 1908 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[66] = {"Vû Nh§n Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång NgoÕi thü 2121 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[67] = {"Âm Miên Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Nµi thü 1249 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[68] = {"Âm Miên Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Nµi thü 1388 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[69] = {"Âm Miên Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Nµi thü 1544 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[70] = {"Âm Miên Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Nµi thü 1716 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[71] = {"Âm Miên Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Nµi thü 1908 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[72] = {"Âm Miên Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Nµi thü 2121 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[73] = {"Tinh Chu¦n Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Chính xác 1398 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[74] = {"Tinh Chu¦n Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Chính xác 1555 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[75] = {"Tinh Chu¦n Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Chính xác 1728 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[76] = {"Tinh Chu¦n Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Chính xác 1920 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[77] = {"Tinh Chu¦n Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Chính xác 2134 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[78] = {"Tinh Chu¦n Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Chính xác 2372 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[79] = {"Linh Sái Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Né tránh 464 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[80] = {"Linh Sái Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Né tránh 516 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[81] = {"Linh Sái Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Né tránh 574 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[82] = {"Linh Sái Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Né tránh 638 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[83] = {"Linh Sái Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Né tránh 710 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[84] = {"Linh Sái Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Né tránh 790 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[85] = {"ÐoÕn Cß½ng Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 1256 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[86] = {"ÐoÕn Cß½ng Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 1396 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[87] = {"ÐoÕn Cß½ng Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 1552 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[88] = {"ÐoÕn Cß½ng Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 1724 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[89] = {"ÐoÕn Cß½ng Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 1916 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[90] = {"ÐoÕn Cß½ng Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm NgoÕi công cüa møc tiêu 2131 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[91] = {"Li®t Nhu Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 1256 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[92] = {"Li®t Nhu Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 1396 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[93] = {"Li®t Nhu Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 1552 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[94] = {"Li®t Nhu Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 1724 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[95] = {"Li®t Nhu Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 1916 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[96] = {"Li®t Nhu Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Nµi công cüa møc tiêu 2131 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[97] = {"Äm Nh§n Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 1249 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[98] = {"Äm Nh§n Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 1388 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[99] = {"Äm Nh§n Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 1544 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[100] = {"Äm Nh§n Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 1716 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[101] = {"Äm Nh§n Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 1908 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[102] = {"Äm Nh§n Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm NgoÕi thü cüa møc tiêu 2121 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[103] = {"ThÑ Miên Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 1249 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[104] = {"ThÑ Miên Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 1388 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[105] = {"ThÑ Miên Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 1544 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[106] = {"ThÑ Miên Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 1716 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[107] = {"ThÑ Miên Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 1908 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[108] = {"ThÑ Miên Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Nµi thü cüa møc tiêu 2121 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[109] = {"Nhi­u Chu¦n Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 1398 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[110] = {"Nhi­u Chu¦n Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 1555 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[111] = {"Nhi­u Chu¦n Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 1728 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[112] = {"Nhi­u Chu¦n Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 1920 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[113] = {"Nhi­u Chu¦n Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 2134 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[114] = {"Nhi­u Chu¦n Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Chính xác cüa møc tiêu 2372 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[115] = {"Tuy®t Sái Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 464 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[116] = {"Tuy®t Sái Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 516 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[117] = {"Tuy®t Sái Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 574 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[118] = {"Tuy®t Sái Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 638 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[119] = {"Tuy®t Sái Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 710 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[120] = {"Tuy®t Sái Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Né tránh cüa møc tiêu 790 ði¬m, liên tøc 10 giây"}
	VoHon_Skill2[121] = {"Cß¶ng Kích Chi H°n (C¤p 1)", "Khi t¤n công có tï l® gia tång Sát thß½ng 187 Ði¬m"}
	VoHon_Skill2[122] = {"Cß¶ng Kích Chi H°n (C¤p 2)", "Khi t¤n công có tï l® gia tång Sát thß½ng 208 Ði¬m"}
	VoHon_Skill2[123] = {"Cß¶ng Kích Chi H°n (C¤p 3)", "Khi t¤n công có tï l® gia tång Sát thß½ng 232 Ði¬m"}
	VoHon_Skill2[124] = {"Cß¶ng Kích Chi H°n (C¤p 4)", "Khi t¤n công có tï l® gia tång Sát thß½ng 259 Ði¬m"}
	VoHon_Skill2[125] = {"Cß¶ng Kích Chi H°n (C¤p 5)", "Khi t¤n công có tï l® gia tång Sát thß½ng 288 Ði¬m"}
	VoHon_Skill2[126] = {"Cß¶ng Kích Chi H°n (C¤p 6)", "Khi t¤n công có tï l® gia tång Sát thß½ng 320 Ði¬m"}
	VoHon_Skill2[127] = {"Tuy®t Khí Chi H°n (C¤p 1)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 72 Ði¬m Khí"}
	VoHon_Skill2[128] = {"Tuy®t Khí Chi H°n (C¤p 2)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 81 Ði¬m Khí"}
	VoHon_Skill2[129] = {"Tuy®t Khí Chi H°n (C¤p 3)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 91 Ði¬m Khí"}
	VoHon_Skill2[130] = {"Tuy®t Khí Chi H°n (C¤p 4)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 102 Ði¬m Khí"}
	VoHon_Skill2[131] = {"Tuy®t Khí Chi H°n (C¤p 5)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 115 Ði¬m Khí"}
	VoHon_Skill2[132] = {"Tuy®t Khí Chi H°n (C¤p 6)", "Khi t¤n công có tï l® giäm Khí cüa møc tiêu 128 Ði¬m Khí"}

VoHon_Skill3 = {}
	VoHon_Skill3[1] = {"Di®t Thª Bát Phß½ng (C¤p 1)", "NgoÕi công tång 21858 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[2] = {"Di®t Thª Bát Phß½ng (C¤p 2)", "NgoÕi công tång 24820 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[3] = {"Di®t Thª Bát Phß½ng (C¤p 3)", "NgoÕi công tång 27778 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[4] = {"Di®t Thª Bát Phß½ng (C¤p 4)", "NgoÕi công tång 30739 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[5] = {"Di®t Thª Bát Phß½ng (C¤p 5)", "NgoÕi công tång 33702 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[6] = {"Di®t Thª Bát Phß½ng (C¤p 6)", "NgoÕi công tång 36664 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[7] = {"Tuy®t Cänh Tán Sát (C¤p 1)", "Nµi công tång 21858 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[8] = {"Tuy®t Cänh Tán Sát (C¤p 2)", "Nµi công tång 24820 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[9] = {"Tuy®t Cänh Tán Sát (C¤p 3)", "Nµi công tång 27778 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[10] = {"Tuy®t Cänh Tán Sát (C¤p 4)", "Nµi công tång 30739 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[11] = {"Tuy®t Cänh Tán Sát (C¤p 5)", "Nµi công tång 33702 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[12] = {"Tuy®t Cänh Tán Sát (C¤p 6)", "Nµi công tång 36664 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[13] = {"Bång Phong VÕn Lí (C¤p 1)", "Bång công tång 2128 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[14] = {"Bång Phong VÕn Lí (C¤p 2)", "Bång công tång 2415 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[15] = {"Bång Phong VÕn Lí (C¤p 3)", "Bång công tång 2703 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[16] = {"Bång Phong VÕn Lí (C¤p 4)", "Bång công tång 2992 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[17] = {"Bång Phong VÕn Lí (C¤p 5)", "Bång công tång 3280 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[18] = {"Bång Phong VÕn Lí (C¤p 6)", "Bång công tång 3567 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[19] = {"Thiên Höa Li®u Nguyên (C¤p 1)", "Höa công tång 2128 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[20] = {"Thiên Höa Li®u Nguyên (C¤p 2)", "Höa công tång 2415 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[21] = {"Thiên Höa Li®u Nguyên (C¤p 3)", "Höa công tång 2703 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[22] = {"Thiên Höa Li®u Nguyên (C¤p 4)", "Höa công tång 2992 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[23] = {"Thiên Höa Li®u Nguyên (C¤p 5)", "Höa công tång 3280 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[24] = {"Thiên Höa Li®u Nguyên (C¤p 6)", "Höa công tång 3567 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[25] = {"Cu°ng Lôi Thiên Hàng (C¤p 1)", "Huy«n công tång 2128 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[26] = {"Cu°ng Lôi Thiên Hàng (C¤p 2)", "Huy«n công tång 2415 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[27] = {"Cu°ng Lôi Thiên Hàng (C¤p 3)", "Huy«n công tång 2703 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[28] = {"Cu°ng Lôi Thiên Hàng (C¤p 4)", "Huy«n công tång 2992 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[29] = {"Cu°ng Lôi Thiên Hàng (C¤p 5)", "Huy«n công tång 3280 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[30] = {"Cu°ng Lôi Thiên Hàng (C¤p 6)", "Huy«n công tång 3567 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[31] = {"K¸ch Ðµc Ôn D¸ch (C¤p 1)", "Ðµc công tång 2128 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[32] = {"K¸ch Ðµc Ôn D¸ch (C¤p 2)", "Ðµc công tång 2415 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[33] = {"K¸ch Ðµc Ôn D¸ch (C¤p 3)", "Ðµc công tång 2703 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[34] = {"K¸ch Ðµc Ôn D¸ch (C¤p 4)", "Ðµc công tång 2992 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[35] = {"K¸ch Ðµc Ôn D¸ch (C¤p 5)", "Ðµc công tång 3280 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[36] = {"K¸ch Ðµc Ôn D¸ch (C¤p 6)", "Ðµc công tång 3567 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[37] = {"Nµ Ðào Liên Kích (C¤p 1)", "Gia tång sát thß½ng lên 2746 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[38] = {"Nµ Ðào Liên Kích (C¤p 2)", "Gia tång sát thß½ng lên 3118 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[39] = {"Nµ Ðào Liên Kích (C¤p 3)", "Gia tång sát thß½ng lên 3490 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[40] = {"Nµ Ðào Liên Kích (C¤p 4)", "Gia tång sát thß½ng lên 3862 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[41] = {"Nµ Ðào Liên Kích (C¤p 5)", "Gia tång sát thß½ng lên 3931 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[42] = {"Nµ Ðào Liên Kích (C¤p 6)", "Gia tång sát thß½ng lên 4000 ði¬m. T¤n công t¯i ða 3 møc tiêu"}
	VoHon_Skill3[43] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 1)", "NgoÕi công tång 21858 Ði¬m"}
	VoHon_Skill3[44] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 2)", "NgoÕi công tång 24820 Ði¬m"}
	VoHon_Skill3[45] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 3)", "NgoÕi công tång 27778 Ði¬m"}
	VoHon_Skill3[46] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 4)", "NgoÕi công tång 30739 Ði¬m"}
	VoHon_Skill3[47] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 5)", "NgoÕi công tång 33702 Ði¬m"}
	VoHon_Skill3[48] = {"Cß½ng Mãnh Tr÷ng Kích (C¤p 6)", "NgoÕi công tång 36664 Ði¬m"}
	VoHon_Skill3[49] = {"Nhu Xà Ðµt T§p (C¤p 1)", "Nµi công tång 21858 Ði¬m"}
	VoHon_Skill3[50] = {"Nhu Xà Ðµt T§p (C¤p 2)", "Nµi công tång 24820 Ði¬m"}
	VoHon_Skill3[51] = {"Nhu Xà Ðµt T§p (C¤p 3)", "Nµi công tång 27778 Ði¬m"}
	VoHon_Skill3[52] = {"Nhu Xà Ðµt T§p (C¤p 4)", "Nµi công tång 30739 Ði¬m"}
	VoHon_Skill3[53] = {"Nhu Xà Ðµt T§p (C¤p 5)", "Nµi công tång 33702 Ði¬m"}
	VoHon_Skill3[54] = {"Nhu Xà Ðµt T§p (C¤p 6)", "Nµi công tång 36664 Ði¬m"}
	VoHon_Skill3[55] = {"Hàn Bång Xuyên ThÑ (C¤p 1)", "Bång công tång 2128 Ði¬m"}
	VoHon_Skill3[56] = {"Hàn Bång Xuyên ThÑ (C¤p 2)", "Bång công tång 2415 Ði¬m"}
	VoHon_Skill3[57] = {"Hàn Bång Xuyên ThÑ (C¤p 3)", "Bång công tång 2703 Ði¬m"}
	VoHon_Skill3[58] = {"Hàn Bång Xuyên ThÑ (C¤p 4)", "Bång công tång 2992 Ði¬m"}
	VoHon_Skill3[59] = {"Hàn Bång Xuyên ThÑ (C¤p 5)", "Bång công tång 3280 Ði¬m"}
	VoHon_Skill3[60] = {"Hàn Bång Xuyên ThÑ (C¤p 6)", "Bång công tång 3567 Ði¬m"}
	VoHon_Skill3[61] = {"Li®t Di­m Chß¾c Thân (C¤p 1)", "Höa công tång 2128 Ði¬m"}
	VoHon_Skill3[62] = {"Li®t Di­m Chß¾c Thân (C¤p 2)", "Höa công tång 2415 Ði¬m"}
	VoHon_Skill3[63] = {"Li®t Di­m Chß¾c Thân (C¤p 3)", "Höa công tång 2703 Ði¬m"}
	VoHon_Skill3[64] = {"Li®t Di­m Chß¾c Thân (C¤p 4)", "Höa công tång 2992 Ði¬m"}
	VoHon_Skill3[65] = {"Li®t Di­m Chß¾c Thân (C¤p 5)", "Höa công tång 3280 Ði¬m"}
	VoHon_Skill3[66] = {"Li®t Di­m Chß¾c Thân (C¤p 6)", "Höa công tång 3567 Ði¬m"}
	VoHon_Skill3[67] = {"Thiên Lôi Oanh Ðính (C¤p 1)", "Huy«n công tång 2128 Ði¬m"}
	VoHon_Skill3[68] = {"Thiên Lôi Oanh Ðính (C¤p 2)", "Huy«n công tång 2415 Ði¬m"}
	VoHon_Skill3[69] = {"Thiên Lôi Oanh Ðính (C¤p 3)", "Huy«n công tång 2703 Ði¬m"}
	VoHon_Skill3[70] = {"Thiên Lôi Oanh Ðính (C¤p 4)", "Huy«n công tång 2992 Ði¬m"}
	VoHon_Skill3[71] = {"Thiên Lôi Oanh Ðính (C¤p 5)", "Huy«n công tång 3280 Ði¬m"}
	VoHon_Skill3[72] = {"Thiên Lôi Oanh Ðính (C¤p 6)", "Huy«n công tång 3567 Ði¬m"}
	VoHon_Skill3[73] = {"Vø Hü Thñc Ðµc (C¤p 1)", "Ðµc công tång 2128 Ði¬m"}
	VoHon_Skill3[74] = {"Vø Hü Thñc Ðµc (C¤p 2)", "Ðµc công tång 2415 Ði¬m"}
	VoHon_Skill3[75] = {"Vø Hü Thñc Ðµc (C¤p 3)", "Ðµc công tång 2703 Ði¬m"}
	VoHon_Skill3[76] = {"Vø Hü Thñc Ðµc (C¤p 4)", "Ðµc công tång 2992 Ði¬m"}
	VoHon_Skill3[77] = {"Vø Hü Thñc Ðµc (C¤p 5)", "Ðµc công tång 3280 Ði¬m"}
	VoHon_Skill3[78] = {"Vø Hü Thñc Ðµc (C¤p 6)", "Ðµc công tång 3567 Ði¬m"}
	VoHon_Skill3[79] = {"Lôi Ðình Mãnh Kích (C¤p 1)", "Gia tång sát thß½ng lên 2746 Ði¬m"}
	VoHon_Skill3[80] = {"Lôi Ðình Mãnh Kích (C¤p 2)", "Gia tång sát thß½ng lên 3118 Ði¬m"}
	VoHon_Skill3[81] = {"Lôi Ðình Mãnh Kích (C¤p 3)", "Gia tång sát thß½ng lên 3490 Ði¬m"}
	VoHon_Skill3[82] = {"Lôi Ðình Mãnh Kích (C¤p 4)", "Gia tång sát thß½ng lên 3862 Ði¬m"}
	VoHon_Skill3[83] = {"Lôi Ðình Mãnh Kích (C¤p 5)", "Gia tång sát thß½ng lên 3931 Ði¬m"}
	VoHon_Skill3[84] = {"Lôi Ðình Mãnh Kích (C¤p 6)", "Gia tång sát thß½ng lên 4000 Ði¬m"}

local VoHon_CamTinh = {"C¥m tinh: ðÆng c¤p hþp thành 5 có th¬ khai phong!","C¥m tinh: Phong, kh¡c chª ð¸a, b¸ höa kh¡c chª.","C¥m tinh: Th±, kh¡c chª thüy, b¸ phong kh¡c chª.","C¥m tinh: Thüy, kh¡c chª höa, b¸ ð¸a kh¡c chª.","C¥m tinh: Höa, kh¡c chª phong, b¸ thüy kh¡c chª."}

local g_pos1;
local g_pos2;
local g_PurpleColor = "#c9107e1";
local g_BlueColor   = "#c00ccff";
local g_YellowColor = "#cfeff95";
local g_GreenColor	= "#c5bc257";
local g_Stars;

local g_nUnlockingTimeNeeded = 259200;

function GlobalWuhunAuthor()
	
	if string.find(SuperTooltips:GetTypeDesc(), "Võ H°n") then
		if SuperTooltips:GetAuthorInfo() then
			return string.sub(SuperTooltips:GetAuthorInfo(),9,65);
		else
			return "No_Author";
		end
	else
		return "No_Author";
	end
end

function g_GetUnlockingStr ( nUnlockElapsedTime )
	if nUnlockElapsedTime >= 235930000 then
		nUnlockElapsedTime = nUnlockElapsedTime - 235930000;
	 --hd add fix hien thi thoi gian khoa 25/6/2014
	end
	local nLeftTime = g_nUnlockingTimeNeeded - nUnlockElapsedTime;
	local strLeftTime = "";

	if( nLeftTime <= 0 ) then
		strLeftTime = "Giäi khóa thành công! Xin ðång nh§p lÕi ho£c di chuy¬n sang vùng ð¤t khác m¾i có th¬ giäi khóa ðßþc";
	else
		nLeftTime = math.ceil( nLeftTime/3600 );
		if( nLeftTime >= 24 ) then
			strLeftTime = ""..math.floor(nLeftTime/24).." Ngày";
			nLeftTime = math.mod(nLeftTime,24);
		end
		if( nLeftTime > 0 ) then
			strLeftTime = strLeftTime.." "..nLeftTime.."  gi¶";
		end

		strLeftTime = strLeftTime.." sau chính thÑc giäi khóa";
	end

	return strLeftTime;
end

function SuperTooltip_PreLoad()
	this:RegisterEvent("SHOW_SUPERTOOLTIP");
	this:RegisterEvent("UPDATE_SUPERTOOLTIP");
	this:RegisterEvent("UNIT_MENPAI");
end

function SuperTooltip_OnLoad()
	SuperTooltip_StaticPart_Money:SetClippedByParent(0);
	SuperTooltip_StaticPart_Money_JiaoZi:SetClippedByParent(0);
	g_Stars={
				SuperTooltip_StaticPart_Star1,
				SuperTooltip_StaticPart_Star2,
				SuperTooltip_StaticPart_Star3,
				SuperTooltip_StaticPart_Star4,
				SuperTooltip_StaticPart_Star5,
				SuperTooltip_StaticPart_Star6,
				SuperTooltip_StaticPart_Star7,
				SuperTooltip_StaticPart_Star8,
				SuperTooltip_StaticPart_Star9,
		};
	for i=1,9 do
		g_Stars[i]:Hide();
	end;
	--AxTrace(0, 2, "LoadSuperTooltips");
end

function SuperTooltip_OnEvent(event)

--	SuperTooltip_StaticPart_Money:Hide();
	if(event == "SHOW_SUPERTOOLTIP") then
		if( arg0 == "1" and SuperTooltips:IsPresent()) then

			SuperTooltips:SendAskItemInfoMsg();
			if(SuperTooltip_Update()==1) then
				g_pos1, g_pos2 = _SuperTooltip_:PositionSelf(arg2, arg3, arg4, arg5);
				this:Show();
			end;
			return;
		else
			this:Hide();
			return;

		end
	end

	if(event == "UPDATE_SUPERTOOLTIP") then
		if(this:IsVisible() and SuperTooltips:IsPresent()) then
			SuperTooltip_Update();
			_SuperTooltip_:PositionSelf(0, 0, g_pos1, g_pos2);
			return;
		end;
	end

end

function SuperTooltip_Update()
		-- ÏÈÇå¿ÕÒÔÇ°ÏÔÊ¾µÄÎÄ×Ö
		SuperTooltip_ClearText();
		
		local SuperTooltip_Title = SuperTooltips:GetTitle()
		local IconName = SuperTooltips:GetIconName()
		local typeDesc = SuperTooltips:GetTypeDesc();

		local nGemHoleCounts = SuperTooltips:GetGemHoleCounts();
		local nMoney1, szMoneyDesc1 = SuperTooltips:GetMoney1();
		local nMoney2, szMoneyDesc2 = SuperTooltips:GetMoney2();
		local szPropertys = SuperTooltips:GetPropertys();
		local szAuthor = SuperTooltips:GetAuthorInfo();
		if typeDesc then
			--Vo Hon Process--
			if string.find(typeDesc, "Võ H°n") then
				VoHon.Is = 1;
				if string.find(SuperTooltip_Title, "Lßu Ly Di­m") then
					VoHon.Type = 1;
				end
				if string.find(SuperTooltip_Title, "Ngñ Dao Bàn") then
					VoHon.Type = 2;
				end
				if not szAuthor then
					VoHon.Level = 1;
					VoHon.Exp = "#cC8B88EKinh nghi®m: 0/1500";
					VoHon.TrThanh = "#r#cff6633Ði¬m trß·ng thành: 500 (S½ c¤p)";
					if VoHon.Type == 1 then
						VoHon.CuongLuc = "Cß¶ng lñc +3 (Cß¶ng lñc ban ð¥u: 3)";
						VoHon.NoiLuc = "Nµi lñc +2 (Nµi lñc ban ð¥u: 2)";
						VoHon.TheLuc = "Th¬ lñc +2 (Th¬ lñc ban ð¥u: 2)";
						VoHon.TriLuc = "Trí lñc +2 (Trí lñc ban ð¥u: 2)";
						VoHon.ThanPhap = "Thân pháp +2 (Thân pháp ban ð¥u: 2)";
					end
					if VoHon.Type == 2 then
						VoHon.CuongLuc = "Cß¶ng lñc +2 (Cß¶ng lñc ban ð¥u: 2)";
						VoHon.NoiLuc = "Nµi lñc +3 (Nµi lñc ban ð¥u: 3)";
						VoHon.TheLuc = "Th¬ lñc +2 (Th¬ lñc ban ð¥u: 2)";
						VoHon.TriLuc = "Trí lñc +2 (Trí lñc ban ð¥u: 2)";
						VoHon.ThanPhap = "Thân pháp +2 (Thân pháp ban ð¥u: 2)";
					end
					VoHon.BaseValue = "#r#cffcc00"..VoHon.CuongLuc.."#r"..VoHon.NoiLuc.."#r"..VoHon.TheLuc.."#r"..VoHon.TriLuc.."#r"..VoHon.ThanPhap;
					VoHon.HopThanh = "#r#cff6633ÐÆng c¤p hþp thành: 1";
					VoHon.SlotLevel = "#r#cff66ccS¯ khung thuµc tính m· rµng: 0";
					VoHon.OptionStr = "";
					VoHon.SkillStr = "";
					VoHon.CamTinh = "#r#c66ccff"..VoHon_CamTinh[1];
				else
					VoHon.Author = string.sub(szAuthor,9,65); --Del Color--

					VoHon.Level = tonumber(string.sub(VoHon.Author,5,7));
					VoHon.Exp = "#cC8B88EKinh nghi®m: "..tonumber(string.sub(VoHon.Author,8,12)).."/"..VoHon_Exp[VoHon.Level][1];
					VoHon.Base = tonumber(string.sub(VoHon.Author,13,13)) - 5;
					VoHon.TrThanh = "#r#cff6633Ði¬m trß·ng thành: "..string.sub(VoHon.Author,13,15).." ("..VoHon_Base[VoHon.Base+1]..")";
					if VoHon.Type == 1 then
						VoHon.CuongLuc = "Cß¶ng lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 1].." (Cß¶ng lñc ban ð¥u: "..VoHon_Property[VoHon.Level][1]..")";
						VoHon.NoiLuc = "Nµi lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 2].." (Nµi lñc ban ð¥u: "..VoHon_Property[VoHon.Level][2]..")";
						VoHon.TheLuc = "Th¬ lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 3].." (Th¬ lñc ban ð¥u: "..VoHon_Property[VoHon.Level][3]..")";
						VoHon.TriLuc = "Trí lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 4].." (Trí lñc ban ð¥u: "..VoHon_Property[VoHon.Level][4]..")";
						VoHon.ThanPhap = "Thân pháp +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 5].." (Thân pháp ban ð¥u: "..VoHon_Property[VoHon.Level][5]..")";
					end
					if VoHon.Type == 2 then
						VoHon.CuongLuc = "Cß¶ng lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 2].." (Cß¶ng lñc ban ð¥u: "..VoHon_Property[VoHon.Level][2]..")";
						VoHon.NoiLuc = "Nµi lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 1].." (Nµi lñc ban ð¥u: "..VoHon_Property[VoHon.Level][1]..")";
						VoHon.TheLuc = "Th¬ lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 3].." (Th¬ lñc ban ð¥u: "..VoHon_Property[VoHon.Level][3]..")";
						VoHon.TriLuc = "Trí lñc +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 4].." (Trí lñc ban ð¥u: "..VoHon_Property[VoHon.Level][4]..")";
						VoHon.ThanPhap = "Thân pháp +"..VoHon_Property[VoHon.Level][VoHon.Base * 5 + 5].." (Thân pháp ban ð¥u: "..VoHon_Property[VoHon.Level][5]..")";
					end
					VoHon.BaseValue = "#r#cffcc00"..VoHon.CuongLuc.."#r"..VoHon.NoiLuc.."#r"..VoHon.TheLuc.."#r"..VoHon.TriLuc.."#r"..VoHon.ThanPhap;
					VoHon.HopThanh = "#r#cff6633ÐÆng c¤p hþp thành: "..string.sub(VoHon.Author,16,16);
					VoHon.SlotLevel = "#r#cff66ccS¯ khung thuµc tính m· rµng: "..string.sub(VoHon.Author,17,17);
					
					VoHon.OptionStr = "";
					VoHon.Option = string.sub(VoHon.Author,18,20);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,21,23);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,24,26);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,27,29);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,30,32);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,33,35);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,36,38);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,39,41);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,42,44);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					VoHon.Option = string.sub(VoHon.Author,45,47);
					if VoHon.Option ~= "---" then
						VoHon.OptionStr = VoHon.OptionStr.."#r#Y"..VoHon_Option[tonumber(VoHon.Option)][1]..VoHon_Option[tonumber(VoHon.Option)][VoHon.Base+2];
					end
					
					VoHon.SkillStr = "";
					VoHon.Skill = string.sub(VoHon.Author,48,50);
					if VoHon.Skill ~= "---" then
						VoHon.SkillStr = "#r#cff6633KÛ nång võ h°n lînh ngµ: ";
						VoHon.Skill = tonumber(VoHon.Skill);
						VoHon.SkillStr = VoHon.SkillStr.."#r#c009933"..VoHon_Skill1[VoHon.Skill][1].."#r#ccccccc"..VoHon_Skill1[VoHon.Skill][2];
					end
					VoHon.Skill = string.sub(VoHon.Author,51,53);
					if VoHon.Skill ~= "---" then
						VoHon.Skill = tonumber(VoHon.Skill);
						VoHon.SkillStr = VoHon.SkillStr.."#r#c009933"..VoHon_Skill2[VoHon.Skill][1].."#r#ccccccc"..VoHon_Skill2[VoHon.Skill][2];
					end
					VoHon.Skill = string.sub(VoHon.Author,54,56);
					if VoHon.Skill ~= "---" then
						VoHon.Skill = tonumber(VoHon.Skill);
						VoHon.SkillStr = VoHon.SkillStr.."#r#c009933"..VoHon_Skill3[VoHon.Skill][1].."#r#ccccccc"..VoHon_Skill3[VoHon.Skill][2];
					end
					
					VoHon.CamTinh = "#r#c66ccff"..VoHon_CamTinh[tonumber(string.sub(VoHon.Author,57,57))+1];
				end
				VoHon.Property = VoHon.TrThanh..VoHon.BaseValue..VoHon.HopThanh..VoHon.SlotLevel..VoHon.OptionStr..VoHon.SkillStr..VoHon.CamTinh;
			elseif string.find(typeDesc,"WuhunSkill") then
				VoHon.IsSkill = 1;
			elseif string.find(typeDesc,"BindRide") then
				typeDesc = "#cffcc99KÜ Thu§t";
				szPropertys = "#cccffffÐã ðßþc c¯ ð¸nh #r";
				for i = 1, table.getn(Ride_Icon) do
					if IconName == Ride_Icon[i] then
						if Player:GetData("MEMPAI") ~= Ride_Menpai[i] then
							szPropertys = "#cFF0000C§n hÕn phái "..Menpai_Str[Ride_Menpai[i]+1].." sØ døng.#r"..szPropertys
						end
						break
					end
				end
			elseif string.find(typeDesc,"RideFull") then
				typeDesc = "#cffcc99KÜ Thu§t";
				if not szPropertys then
					szPropertys = "#cccffffKhi trang b¸ s¨ ðßþc c¯ ð¸nh #r";
				end
				for i = 1, table.getn(Ride_Icon) do
					if IconName == Ride_Icon[i] then
						if Player:GetData("MEMPAI") ~= Ride_Menpai[i] then
							szPropertys = "#cFF0000C§n hÕn phái "..Menpai_Str[Ride_Menpai[i]+1].." sØ døng.#r"..szPropertys
						end
						break
					end
				end
			end
		end
		
		local szExplain = SuperTooltips:GetExplain();
		local unLockingElapsedTime	= SuperTooltips:GetPUnlockElapsedTime();
		local IsProtectd	= SuperTooltips:GetDesc5();
		local nYuanbaotrade = SuperTooltips:GetYuanbaoTradeFlag();
		local nGoodsProtect = 0;--SuperTooltips:GetGoodsProtect_Goods();
		----------------------------------------------------------------------
		--ÏÔÊ¾¾²Ì¬Í·
		local toDisplay = "";
		
		if(SuperTooltip_Title~="" and IconName~="")then
			toDisplay = toDisplay .."SuperTooltip_PageHeader";
		end

		--Ê£Óà½âËøÊ±¼ä
		if( IsProtectd == "1" and unLockingElapsedTime ~= 0) then
			toDisplay = toDisplay .. ";SuperTooltip_UnlockingTimePart";
		end


		--¼ÓÉÏÀàÐÍÃèÊö
		if( typeDesc ~= nil and VoHon.IsSkill == 0) then
			toDisplay = toDisplay .. ";SuperTooltip_ShortDesc";
		end

		--Ôª±¦½»Ò×
		if (nYuanbaotrade == 1) then
			toDisplay = toDisplay .. ";SuperTooltip_StaticPart_Yuanbaojiaoyi";
			SuperTooltip_StaticPart_Yuanbaojiaoyi:SetText("#c00ff00 Giao d¸ch Nguyên Bäo");
		end

		--±¦Ê¯²¿·Ö
		if( type(nGemHoleCounts) == "number" and nGemHoleCounts>0 ) then
			toDisplay = toDisplay .. ";SuperTooltip_GemPart";
		end
		--½ðÇ®1
		if( nMoney1 ~= nil) then
			toDisplay = toDisplay .. ";SuperTooltip_MoneyPart";
		end

		--½ðÇ®2
		if(nMoney2 ~= nil) then
			toDisplay = toDisplay .. ";SuperTooltip_MoneyPart_2";
		end

		--¸ß¼¶±£»¤
		if nGoodsProtect == 1 then
			toDisplay = toDisplay .. ";SuperTooltip_Protect_Text";
		end

		--ÊôÐÔ
		if(szPropertys ~= nil) then
			toDisplay = toDisplay .. ";SuperTooltip_Property";
		end

		--×÷Õß
		if(szAuthor ~= nil) and (VoHon.Is ~= 1) then
			toDisplay = toDisplay .. ";SuperTooltip_Manufacturer_Frame";
		end

		--ÏêÏ¸½âÊÍ
		toDisplay = toDisplay .. ";SuperTooltip_Explain";

		--ÏÔÊ¾×é¼þÄÚÈÝ
		if(toDisplay=="") then
			this:Hide();
			return 0;
		end;
		AxTrace( 8,0,toDisplay );
		_SuperTooltip_:SetProperty("PageElements",  toDisplay);

		----------------------------------------------------------------------
		--ÏÔÊ¾ÐÂµÄÄÚÈÝ
		SuperTooltip_StaticPart_Title:SetText(SuperTooltip_Title);
		if string.find(SuperTooltip_Title, "Thú CßÞi: ") then
			SuperTooltip_StaticPart_Item1:SetText(string.gsub(SuperTooltips:GetDesc1()," v§t ph¦m",""))
		elseif VoHon.Type == 1 then
			SuperTooltip_StaticPart_Item1:SetText(SuperTooltips:GetDesc1());
			if VoHon.Level > Player:GetData("LEVEL") then
				SuperTooltip_StaticPart_Item2:SetText("#cff0000C¤p: "..VoHon.Level);
			else
				SuperTooltip_StaticPart_Item2:SetText("#cC8B88EC¤p: "..VoHon.Level);
			end
			SuperTooltip_StaticPart_Item3:SetText("#GLoÕi Cß¶ng Lñc");
			SuperTooltip_StaticPart_Item4:SetText(VoHon.Exp);
		elseif VoHon.Type == 2 then
			SuperTooltip_StaticPart_Item1:SetText(SuperTooltips:GetDesc1());
			if VoHon.Level > Player:GetData("LEVEL") then
				SuperTooltip_StaticPart_Item2:SetText("#cff0000C¤p: "..VoHon.Level);
			else
				SuperTooltip_StaticPart_Item2:SetText("#cC8B88EC¤p: "..VoHon.Level);
			end
			SuperTooltip_StaticPart_Item3:SetText("#GLoÕi Nµi Lñc");
			SuperTooltip_StaticPart_Item4:SetText(VoHon.Exp);
		else
			if VoHon.IsSkill == 0 then
				SuperTooltip_StaticPart_Item1:SetText(SuperTooltips:GetDesc1());
				SuperTooltip_StaticPart_Item3:SetText(SuperTooltips:GetDesc3());
			else
				SuperTooltip_StaticPart_Item1:SetText("");
				SuperTooltip_StaticPart_Item3:SetText("");
			end
			SuperTooltip_StaticPart_Item2:SetText(SuperTooltips:GetDesc2());
		end
		local StrongLevel = SuperTooltips:GetDesc4();
		if (StrongLevel ~= "" and tonumber(StrongLevel)>0) then
			SuperTooltip_StaticPart_Item4:SetText("#c0FFFFFCß¶ng hóa: +"..SuperTooltips:GetDesc4());
		end
		--SuperTooltip_StaticPart_Item5:SetText(SuperTooltips:GetDesc5());
		SuperTooltip_StaticPart_Icon:SetImage(IconName);
		SuperTooltip_ShortDesc_Text:SetText(typeDesc);

		-- ÏÔÊ¾µñÎÆ
		local dwIcon = 0;--SuperTooltips:GetDiaowenIcon()
		if (dwIcon ~= nil and dwIcon ~= "") then
			SuperTooltip_StaticPart_DW:Show()
			SuperTooltip_StaticPart_DW:SetProperty("Image", dwIcon)
		end

		if (IsProtectd == "1" and unLockingElapsedTime ~= 0) then
			local strLeftTime = g_GetUnlockingStr(unLockingElapsedTime);
			SuperTooltip_UnlockingTimePart:SetText("#b#cFFFF00"..strLeftTime);
			SuperTooltip_StaticPart_Icon_Protected : SetProperty("Image","set:CommonFrame6 image:NewLock");
		else
			SuperTooltip_UnlockingTimePart:SetText("");
			SuperTooltip_StaticPart_Icon_Protected : SetProperty("Image","set:UIIcons image:Icon_Lock");
		end

		if nGoodsProtect == 1 then
			SuperTooltip_Protect_Text:SetText("#{GDWPBH_090507_4}")
		else
			SuperTooltip_Protect_Text:SetText("")
		end

		--tongxi modify ÏÔÊ¾ÐÇÐÇ
		--AxTrace( 5,0,StrongLevel );
		SuperTooltip_StaticPart_Icon_Animate:Hide();
		local qual =SuperTooltips:GetEquipQual();
		if(type(qual) == "number" and tonumber(qual)>0)then
			local starNum	=	tonumber(qual);
			if(starNum<10) then
        --SuperTooltip_StaticPart_Icon_Animate:Show();
				for i=1,starNum do
					--AxTrace( 5,0,StrongLevel.."hehe" );
					if starNum <=4 then
						g_Stars[i]:SetProperty("Animate", "Animate_StarNoFlash");
					else
						g_Stars[i]:SetProperty("Animate", "Animate_Star");
					end
					g_Stars[i]:Show();
				end;
				for i=starNum+1, 9 do
					g_Stars[i]:SetProperty("Animate", "Animate_StarDark");
					g_Stars[i]:Show();
				end
			end;
		end;
		if(IsProtectd=="1") then
			SuperTooltip_StaticPart_Icon_Protected:Show();
		end;
		--modify end
		if( type(nGemHoleCounts) == "number" and nGemHoleCounts>0) then
			AxTrace(5,1,"nGemHoleCounts="..nGemHoleCounts)
			if(nGemHoleCounts > 0) then
				SuperTooltip_StaticPart_Gem1:Show();
			end

			if(nGemHoleCounts > 1) then
				SuperTooltip_StaticPart_Gem2:Show();
			end

			if(nGemHoleCounts > 2) then
				SuperTooltip_StaticPart_Gem3:Show();
			end

			if(nGemHoleCounts > 3) then
				SuperTooltip_StaticPart_Gem4:Show();
			end


			local gemIcon = SuperTooltips:GetGemIcon1();
			AxTrace(5,5,"gemIcon="..gemIcon)
			if(gemIcon ~= "") then
				SuperTooltip_StaticPart_Gem1:SetProperty("ShortImage", gemIcon);
			end

			gemIcon = SuperTooltips:GetGemIcon2();
			AxTrace(5,5,"gemIcon="..gemIcon)
			if(gemIcon ~= "") then
				SuperTooltip_StaticPart_Gem2:SetProperty("ShortImage", gemIcon);
			end

			gemIcon = SuperTooltips:GetGemIcon3();
			AxTrace(5,5,"gemIcon="..gemIcon)
			if(gemIcon ~= "") then
				SuperTooltip_StaticPart_Gem3:SetProperty("ShortImage", gemIcon);
			end

			gemIcon = SuperTooltips:GetGemIcon4();

			AxTrace(5,5,"gemIcon="..gemIcon)
			if(gemIcon ~= "") then
				SuperTooltip_StaticPart_Gem4:SetProperty("ShortImage", gemIcon);
			end

		end
		if(nMoney1 ~= nil)  then
			SuperTooltip_StaticPart_Money_Text:SetText(szMoneyDesc1);
			SetupMoneyPart(1,nMoney1);

		end
		if(nMoney2 ~= nil)  then
			SuperTooltip_StaticPart_Money_Text_2:SetText(szMoneyDesc2);
			SetupMoneyPart(2,nMoney2);
		end
		
		if( szPropertys ~= nil) then
			szPropertys = string.gsub(szPropertys, "£¨", "(");
			szPropertys = string.gsub(szPropertys, "£©", ")");
			szPropertys = string.gsub(szPropertys, "£º", " +");

			if VoHon.Is == 1 then
				if string.find(szPropertys,"#cccffffÐã ðßþc c¯ ð¸nh #r") then
					szPropertys = string.gsub(szPropertys,"#cccffffÐã ðßþc c¯ ð¸nh #r","#cccffffÐã ðßþc c¯ ð¸nh #r"..VoHon.Property);
				elseif string.find(szPropertys,"#cccffffKhi trang b¸ s¨ ðßþc c¯ ð¸nh #r") then
					szPropertys = string.gsub(szPropertys,"#cccffffKhi trang b¸ s¨ ðßþc c¯ ð¸nh #r","#cccffffKhi trang b¸ s¨ ðßþc c¯ ð¸nh #r"..VoHon.Property);
				else
					szPropertys = VoHon.Property..szPropertys;
				end
			end
			
			SuperTooltip_Property:SetText(szPropertys);
		end

		if(szAuthor ~= nil) then
			SuperTooltip_Manufacturer:SetText(szAuthor);
		end

		SuperTooltip_Explain:SetText(szExplain);

		AxTrace( 8,0,"Show tooltip  "..szExplain);

		return 1;

end

-------------------------------------------------------------------------------------------------------------------------------
--
-- Çå¿ÕÏÔÊ¾ÎÄ±¾
--
function SuperTooltip_ClearText()
	SuperTooltip_StaticPart_Title:SetText("");
	SuperTooltip_StaticPart_Item1:SetText("");
	SuperTooltip_StaticPart_Item2:SetText("");
	SuperTooltip_StaticPart_Item3:SetText("");
	SuperTooltip_StaticPart_Item4:SetText("");
	SuperTooltip_Protect_Text:SetText("");
	SuperTooltip_StaticPart_DW:SetImage("")
	SuperTooltip_StaticPart_DW:Hide()
	local starNum=9
	for i=1,starNum do
		g_Stars[i]:Hide();
	end;
	SuperTooltip_StaticPart_Gem1:SetImage("");
	SuperTooltip_StaticPart_Gem2:SetImage("");
	SuperTooltip_StaticPart_Gem3:SetImage("");
	SuperTooltip_StaticPart_Gem4:SetImage("");
	SuperTooltip_StaticPart_Gem1:Hide();
	SuperTooltip_StaticPart_Gem2:Hide()
	SuperTooltip_StaticPart_Gem3:Hide()
	SuperTooltip_StaticPart_Gem4:Hide()
	SuperTooltip_Explain:SetText("");
	SuperTooltip_Property:SetText("");
	SuperTooltip_Manufacturer:SetText("");
	SuperTooltip_StaticPart_Icon_Protected:Hide();
	
	--Clear Vo Hon--
	VoHon.Is = 0;
	VoHon.Type = 0;
	VoHon.IsSkill = 0;
end

function SetupMoneyPart(type,nPrice)
	local StaticPart_GB_Ctl;
	local StaticPart_Money_Ctl;
		--Ê¹ÓÃÊ²Ã´×÷Îª»õ±Ò
	local nUnit =  SuperTooltips:GetMoney1Type();
	if(type==1)then
		StaticPart_GB_Ctl = SuperTooltip_StaticPart_GB;
		local isShowJiaoZi = SuperTooltips:GetIsShowJiaoZi();
		if ( CU_MONEYJZ == nUnit ) then
			isShowJiaoZi = 1;
		end
		if (isShowJiaoZi == 1) then
			SuperTooltip_StaticPart_Money:Hide();
			StaticPart_Money_Ctl = SuperTooltip_StaticPart_Money_JiaoZi;
		else
			SuperTooltip_StaticPart_Money_JiaoZi:Hide()
			StaticPart_Money_Ctl = SuperTooltip_StaticPart_Money;
		end
	else
		StaticPart_GB_Ctl = SuperTooltip_StaticPart_GB_2;
		StaticPart_Money_Ctl = SuperTooltip_StaticPart_Money_2;
	end

	if(nUnit==nil)then
		nUnit = CU_MONEY;
	end;
	if(CU_MONEY	== nUnit or CU_TICKET == nUnit or CU_MONEYJZ == nUnit)       then      --Ç®£¬¹ÙÆ±Ç®, ½»×Ó
			StaticPart_GB_Ctl:Hide()
			StaticPart_Money_Ctl:Show();
			StaticPart_Money_Ctl:SetProperty("MoneyNumber", tostring(nPrice));

	elseif(CU_GOODBAD == nUnit) then			--ÉÆ¶ñÖµ

			StaticPart_GB_Ctl:Show()
			StaticPart_Money_Ctl:Hide();
			StaticPart_GB_Ctl:SetText("Giá tr¸ thi®n ác: " .. tostring(nPrice) .. " Ði¬m")


	elseif(CU_MORALPOINT == nUnit)  then	--Ê¦µÂµã

			StaticPart_GB_Ctl:Show()
			SuperTooltip_StaticPart_Money:Hide();
			StaticPart_GB_Ctl:SetText("Ði¬m Sß ÐÑc: " .. tostring(nPrice) .. " Ði¬m")

	elseif(CU_BIND_YUANBAO == nUnit) then	--°ó¶¨Ôª±¦

			StaticPart_GB_Ctl:Show()
			StaticPart_Money_Ctl:Hide();
			StaticPart_GB_Ctl:SetText("#{BDYB_090714_01}" .. tostring(nPrice))

	elseif(CU_YUANBAO == nUnit) then	--Ôª±¦

			StaticPart_GB_Ctl:Show()
			StaticPart_Money_Ctl:Hide();
			StaticPart_GB_Ctl:SetText("KNB: " .. tostring(nPrice))

	elseif(CU_ZENGDIAN == nUnit) then	--Ôùµã

			StaticPart_GB_Ctl:Show()
			StaticPart_Money_Ctl:Hide();
			StaticPart_GB_Ctl:SetText("Ði¬m t£ng: " .. tostring(nPrice))
	end
end;
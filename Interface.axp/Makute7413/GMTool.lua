local GMTool_MenpaiStr = {"Thiªu Lâm","Minh Giáo","Cái Bang","Võ Ðang","Nga My","Tinh Túc","Thiên Long","Thiên S½n","Tiêu Dao","Chßa có"}
local GMTool_Object = -1
local GMTool_GemID = -1
local GMTool_Accept_Clicked = 0
local MapDetail = {}
	MapDetail[0] = {"LÕc Dß½ng", 0}
	MapDetail[1] = {"Tô Châu", 1}
	MapDetail[2] = {"ÐÕi Lý", 2}
	MapDetail[3] = {"Tung S½n", 3}
	MapDetail[4] = {"Thái H°", 4}
	MapDetail[5] = {"Kính H°", 5}
	MapDetail[6] = {"Vô Lßþng S½n", 6}
	MapDetail[7] = {"Kiªm Các", 7}
	MapDetail[8] = {"Ðôn Hoàng", 8}
	MapDetail[9] = {"Thiªu Lâm Tñ", 9}
	MapDetail[10] = {"Cái Bang T±ng Ðà", 10}
	MapDetail[11] = {"Quang Minh Ði®n", 11}
	MapDetail[12] = {"Núi Võ Ðang", 12}
	MapDetail[13] = {"Thiên Long Tñ", 13}
	MapDetail[14] = {"Ðµng Lång Ba", 14}
	MapDetail[15] = {"Nga My S½n", 15}
	MapDetail[16] = {"Tinh Túc Häi", 16}
	MapDetail[17] = {"Thiên S½n", 17}
	MapDetail[18] = {"NhÕn Nam", 18}
	MapDetail[19] = {"NhÕn B¡c", 19}
	MapDetail[20] = {"Thäo Nguyên", 20}
	MapDetail[21] = {"Liêu Tây", 21}
	MapDetail[22] = {"Trß¶ng BÕch S½n", 22}
	MapDetail[23] = {"Hoàng Long Phü", 23}
	MapDetail[24] = {"Nhî Häi", 24}
	MapDetail[25] = {"Thß½ng S½n", 25}
	MapDetail[26] = {"ThÕch Lâm", 26}
	MapDetail[27] = {"Ng÷c Khê", 27}
	MapDetail[28] = {"Nam Chiêu", 28}
	MapDetail[29] = {"Miêu Cß½ng", 29}
	MapDetail[30] = {"Tây H°", 30}
	MapDetail[31] = {"Long Tuy«n", 31}
	MapDetail[32] = {"Võ Di", 32}
	MapDetail[33] = {"Mai Lînh", 33}
	MapDetail[34] = {"Nam Häi", 34}
	MapDetail[35] = {"QuÏnh Châu", 35}
	MapDetail[36] = {"Tø Hi«n Trang", 36}
	MapDetail[37] = {"Yªn TØ ‘", 37}
	MapDetail[38] = {"Nh¤t Ph¦m Ðß¶ng", 38}
	MapDetail[39] = {"Huy«n Vû Ðäo", 39}
	MapDetail[40] = {"Dñ Lßu 2", 40}
	MapDetail[41] = {"Dñ Lßu 3", 41}
	MapDetail[42] = {"Phän Quân Doanh Ð¸a", 42}
	MapDetail[43] = {"Mµc Nhân Cäng", 43}
	MapDetail[44] = {"Trân Long KÏ Cuµc", 44}
	MapDetail[45] = {"ThuÖ Lao", 45}
	MapDetail[46] = {"Sa MÕc Yªu TrÕi", 46}
	MapDetail[47] = {"Biên Gi¾i T¯ng Liêu", 47}
	MapDetail[48] = {"Dã NgoÕi TrÕi Phï", 48}
	MapDetail[49] = {"Trúc Lâm", 49}
	MapDetail[50] = {"Ti¬u Mµc Nhân Cäng 2", 50}
	MapDetail[51] = {"Quang Minh Ðµng", 51}
	MapDetail[52] = {"Ðáy C¯c Tiêu Dao", 52}
	MapDetail[53] = {"Linh Tính Phong", 53}
	MapDetail[54] = {"Cái Bang TØu Diªu", 54}
	MapDetail[55] = {"Ðào Hoa Tr§n", 55}
	MapDetail[56] = {"Tháp Lâm", 56}
	MapDetail[57] = {"Ngû Th¥n Ðµng", 57}
	MapDetail[58] = {"Huy®t Mµ", 58}
	MapDetail[59] = {"Chân Tháp", 59}
	MapDetail[60] = {"Chiªt Mai Phong", 60}
	MapDetail[61] = {"Ti¬u Mµc Nhân HÕng", 61}
	MapDetail[62] = {"H§u Hoa Viên", 62}
	MapDetail[63] = {"Chþ Phiên", 63}
	MapDetail[64] = {"Khoáng Trß¶ng", 64}
	MapDetail[65] = {"Møc Trß¶ng", 65}
	MapDetail[66] = {"Thß Các", 66}
	MapDetail[67] = {"Th¸ T§p", 67}
	MapDetail[68] = {"Tø Hi«n Trang", 68}
	MapDetail[69] = {"Yªn TØ ‘", 69}
	MapDetail[70] = {"Nh¤t Ph¦m Ðß¶ng", 70}
	MapDetail[71] = {"ÐÕi Lý 2", 71}
	MapDetail[72] = {"ÐÕi Lý 3", 72}
	MapDetail[73] = {"Vô Lßþng S½n 2", 73}
	MapDetail[74] = {"Vô Lßþng S½n 3", 74}
	MapDetail[75] = {"Kiªm Các 2", 75}
	MapDetail[76] = {"Kiªm Các 3", 76}
	MapDetail[77] = {"Ð¸a Phü", 77}
	MapDetail[78] = {"Núi Lôi C±", 78}
	MapDetail[79] = {"VÕn Kiªp C¯c", 79}
	MapDetail[80] = {"Thß½ng Mang S½n", 80}
	MapDetail[81] = {"Ti¬u Mµc Nhân Cäng 3", 81}
	MapDetail[82] = {"H§u Hoa Viên 2", 82}
	MapDetail[83] = {"Thß½ng Mang S½n", 83}
	MapDetail[84] = {"VÕn Kiªp C¯c", 84}
	MapDetail[85] = {"Núi Lôi C±", 85}
	MapDetail[86] = {"NhÕn Nam S½n Ðµng", 86}
	MapDetail[87] = {"NhÕn B¡c S½n Ðµng", 87}
	MapDetail[88] = {"Tây H° S½n Ðµng", 88}
	MapDetail[89] = {"Thß½ng S½n S½n Ðµng", 89}
	MapDetail[90] = {"Quang Minh Ðµng", 90}
	MapDetail[91] = {"Ðáy C¯c Tiêu Dao", 91}
	MapDetail[92] = {"Linh Tính Phong", 92}
	MapDetail[93] = {"Cái Bang TØu Diªu", 93}
	MapDetail[94] = {"Ðào Hoa Tr§n", 94}
	MapDetail[95] = {"Tháp Lâm", 95}
	MapDetail[96] = {"Ngû Th¥n Ðµng", 96}
	MapDetail[97] = {"Chiªt Mai Phong", 97}
	MapDetail[98] = {"Chân Tháp", 98}
	MapDetail[99] = {"Quang Minh Ðµng", 99}
	MapDetail[100] = {"Ðáy C¯c Tiêu Dao", 100}
	MapDetail[101] = {"Linh Tính Phong", 101}
	MapDetail[102] = {"Cái Bang TØu Diªu", 102}
	MapDetail[103] = {"Ðào Hoa Tr§n", 103}
	MapDetail[104] = {"Tháp Lâm", 104}
	MapDetail[105] = {"Ngû Th¥n Ðµng", 105}
	MapDetail[106] = {"Chiªt Mai Phong", 106}
	MapDetail[107] = {"Chân Tháp", 107}
	MapDetail[108] = {"Th¸ T§p", 108}
	MapDetail[109] = {"Th¸ T§p", 109}
	MapDetail[110] = {"Công Ð¸a", 110}
	MapDetail[111] = {"Trß¶ng Võ", 111}
	MapDetail[112] = {"Nha Môn", 112}
	MapDetail[113] = {"Tam Xuân Huy¬n Cänh", 113}
	MapDetail[114] = {"Tam HÕ Huy¬n Cänh", 114}
	MapDetail[115] = {"Tam Thu Huy¬n Cänh", 115}
	MapDetail[116] = {"Tam Ðông Huy¬n Cänh", 116}
	MapDetail[117] = {"Möm Núi Tr§n Ð¸a N½i Biên Quan", 117}
	MapDetail[118] = {"Möm Núi Tr§n Ð¸a N½i Biên Quan", 118}
	MapDetail[119] = {"Möm Núi Tr§n Ð¸a N½i Biên Quan", 119}
	MapDetail[120] = {"Möm Núi Tr§n Ð¸a N½i Biên Quan", 120}
	MapDetail[121] = {"DÕ Tây H°", 121}
	MapDetail[122] = {"Tàng Kinh Các", 122}
	MapDetail[123] = {"Bäo Tàng Ðµng T¥ng 1", 123}
	MapDetail[124] = {"Khäo Trß¶ng", 124}
	MapDetail[125] = {"Hoa S½n Tuy®t Ðïnh", 125}
	MapDetail[126] = {"Bäo Tàng Ðµng T¥ng 2", 126}
	MapDetail[127] = {"T£c Kh¤u Doanh Ð¸a", 127}
	MapDetail[128] = {"Tàng Kinh Các", 128}
	MapDetail[129] = {"Tàng Kinh Các", 129}
	MapDetail[130] = {"Thiªu Lâm Tñ", 130}
	MapDetail[131] = {"Cái Bang T±ng Ðà", 131}
	MapDetail[132] = {"Quang Minh Ðïnh", 132}
	MapDetail[133] = {"Núi Võ Ðang", 133}
	MapDetail[134] = {"Thiên Long Tñ", 134}
	MapDetail[135] = {"Ðµng Lång Ba", 135}
	MapDetail[136] = {"Nga My S½n", 136}
	MapDetail[137] = {"Tinh Túc Häi", 137}
	MapDetail[138] = {"Thiên S½n", 138}
	MapDetail[139] = {"Thiªu Lâm Tñ", 139}
	MapDetail[140] = {"Cái Bang T±ng Ðà", 140}
	MapDetail[141] = {"Quang Minh Ðïnh", 141}
	MapDetail[142] = {"Núi Võ Ðang", 142}
	MapDetail[143] = {"Thiên Long Tñ", 143}
	MapDetail[144] = {"Ðµng Lång Ba", 144}
	MapDetail[145] = {"Nga My S½n", 145}
	MapDetail[146] = {"Tinh Túc Häi", 146}
	MapDetail[147] = {"Thiên S½n", 147}
	MapDetail[148] = {"Bäo Tàng Ðµng T¥ng 3", 148}
	MapDetail[149] = {"Bäo Tàng Ðµng T¥ng 4", 149}
	MapDetail[150] = {"Bäo Tàng Ðµng T¥ng 5", 150}
	MapDetail[151] = {"Giám Ngøc", 151}
	MapDetail[152] = {"TÖ Võ Hµi Trß¶ng", 152}
	MapDetail[153] = {"L­ Ðß¶ng Ph± Thông", 153}
	MapDetail[154] = {"L­ Ðß¶ng Cao C¤p", 154}
	MapDetail[155] = {"L­ Ðß¶ng Hào Hoa", 155}
	MapDetail[156] = {"Thäo Li®u Trß¶ng", 156}
	MapDetail[157] = {"Miêu Nhân Ðµng", 157}
	MapDetail[158] = {"Thánh Thú S½n", 158}
	MapDetail[159] = {"Yªn Vß½ng C± Mµ T¥ng 1", 159}
	MapDetail[160] = {"Yªn Vß½ng C± Mµ T¥ng 2", 160}
	MapDetail[161] = {"Yªn Vß½ng C± Mµ T¥ng 3", 161}
	MapDetail[162] = {"Yªn Vß½ng C± Mµ T¥ng 4", 162}
	MapDetail[163] = {"Yªn Vß½ng C± Mµ T¥ng 5", 163}
	MapDetail[164] = {"Yªn Vß½ng C± Mµ T¥ng 6", 164}
	MapDetail[165] = {"Yªn Vß½ng C± Mµ T¥ng 7", 165}
	MapDetail[166] = {"Yªn Vß½ng C± Mµ T¥ng 8", 166}
	MapDetail[167] = {"Yªn Vß½ng C± Mµ T¥ng 9", 167}
	MapDetail[168] = {"S½n Ðµng Tuy«n Ô", 168}
	MapDetail[169] = {"Kiªm Gia", 169}
	MapDetail[170] = {"Ma Nhai Ðµng", 170}
	MapDetail[171] = {"Dã Nhân C¯c", 171}
	MapDetail[172] = {"Ôn Tuy«n Ðµng", 172}
	MapDetail[173] = {"Hoàng Long Ðµng", 173}
	MapDetail[174] = {"ThuÖ Kính H°", 174}
	MapDetail[175] = {"Tiên Vß½ng Ph¥n", 175}
	MapDetail[176] = {"Thiên Khanh Thø Ðµng", 176}
	MapDetail[177] = {"Ðào Hoa Nguyên", 177}
	MapDetail[178] = {"Häi T£c Ðµng", 178}
	MapDetail[179] = {"Tuyªt Lang H°", 179}
	MapDetail[180] = {"Phøng Hoàng C± Tr¤n", 180}
	MapDetail[181] = {"Ti«n Trang", 181}
	MapDetail[182] = {"H§u Hoa Viên 3", 182}
	MapDetail[183] = {"Tàng Kinh Các", 183}
	MapDetail[184] = {"Tàng Kinh Các", 185}
	MapDetail[185] = {"Lâu Lan", 186}
	MapDetail[186] = {"Ngân Ngai Tuyªt Nguyên", 188}
	MapDetail[187] = {"Kính H° Phï TrÕi", 189}
	MapDetail[188] = {"Khu Nghï Ng½i TÕi ÐÕi Lý", 193}
	MapDetail[189] = {"Hàn Ng÷c C¯c", 194}
	MapDetail[190] = {"Chính Nam NhÕn Nam", 205}
	MapDetail[191] = {"Chính Tây NhÕn B¡c", 206}
	MapDetail[192] = {"Chính Tây Tây H°", 207}
	MapDetail[193] = {"Chính B¡c Long Tuy«n", 208}
	MapDetail[194] = {"Thß½ng S½n Chính Tây", 209}
	MapDetail[195] = {"Chính Tây Nhî Häi", 210}
	MapDetail[196] = {"Chính Tây Thäo Nguyên", 211}
	MapDetail[197] = {"Tây B¡c Liêu Tây", 212}
	MapDetail[198] = {"Chính Tây Võ Di", 213}
	MapDetail[199] = {"Tây B¡c Mai Lînh", 214}
	MapDetail[200] = {"Chính Nam ThÕch Lâm", 215}
	MapDetail[201] = {"Tây Nam Ng÷c Khê", 216}
	MapDetail[202] = {"Tây B¡c Trß¶ng BÕch S½n", 217}
	MapDetail[203] = {"Tây B¡c Hoàng Long Phü", 218}
	MapDetail[204] = {"Chính B¡c Nam Häi", 219}
	MapDetail[205] = {"Hß¾ng Tây Cüa QuÏnh Châu", 220}
	MapDetail[206] = {"Tây Nam Nam Chiêu", 221}
	MapDetail[207] = {"Chính Ðông Miêu Cß½ng", 222}
	MapDetail[208] = {"Chính Nam NhÕn Nam", 223}
	MapDetail[209] = {"Chính Tây NhÕn B¡c", 224}
	MapDetail[210] = {"Chính Tây Tây H°", 225}
	MapDetail[211] = {"Chính B¡c Long Tuy«n", 226}
	MapDetail[212] = {"Thß½ng S½n Chính Tây", 227}
	MapDetail[213] = {"Chính Tây Nhî Häi", 228}
	MapDetail[214] = {"Chính Tây Thäo Nguyên", 229}
	MapDetail[215] = {"Tây B¡c Liêu Tây", 230}
	MapDetail[216] = {"Chính Tây Võ Di", 231}
	MapDetail[217] = {"Tây B¡c Mai Lînh", 232}
	MapDetail[218] = {"Chính Nam ThÕch Lâm", 233}
	MapDetail[219] = {"Tây Nam Ng÷c Khê", 234}
	MapDetail[220] = {"Tây B¡c Trß¶ng BÕch S½n", 235}
	MapDetail[221] = {"Tây B¡c Hoàng Long Phü", 236}
	MapDetail[222] = {"Chính B¡c Nam Häi", 237}
	MapDetail[223] = {"Hß¾ng Tây Cüa QuÏnh Châu", 238}
	MapDetail[224] = {"Tây Nam Nam Chiêu", 239}
	MapDetail[225] = {"Chính Ðông Miêu Cß½ng", 240}
	MapDetail[226] = {"Chính Nam NhÕn Nam", 241}
	MapDetail[227] = {"Chính Tây NhÕn B¡c", 242}
	MapDetail[228] = {"Chính Tây Tây H°", 243}
	MapDetail[229] = {"Chính B¡c Long Tuy«n", 244}
	MapDetail[230] = {"Thß½ng S½n Chính Tây", 245}
	MapDetail[231] = {"Chính Tây Nhî Häi", 246}
	MapDetail[232] = {"Chính Tây Thäo Nguyên", 247}
	MapDetail[233] = {"Tây B¡c Liêu Tây", 248}
	MapDetail[234] = {"Chính Tây Võ Di", 249}
	MapDetail[235] = {"Tây B¡c Mai Lînh", 250}
	MapDetail[236] = {"Chính Nam ThÕch Lâm", 251}
	MapDetail[237] = {"Tây Nam Ng÷c Khê", 252}
	MapDetail[238] = {"Tây B¡c Trß¶ng BÕch S½n", 253}
	MapDetail[239] = {"Tây B¡c Hoàng Long Phü", 254}
	MapDetail[240] = {"Chính B¡c Nam Häi", 255}
	MapDetail[241] = {"Hß¾ng Tây Cüa QuÏnh Châu", 256}
	MapDetail[242] = {"Tây Nam Nam Chiêu", 257}
	MapDetail[243] = {"Chính Ðông Miêu Cß½ng", 258}
	MapDetail[244] = {"Chính Nam NhÕn Nam", 259}
	MapDetail[245] = {"Chính Tây NhÕn B¡c", 260}
	MapDetail[246] = {"Chính Tây Tây H°", 261}
	MapDetail[247] = {"Chính B¡c Long Tuy«n", 262}
	MapDetail[248] = {"Thß½ng S½n Chính Tây", 263}
	MapDetail[249] = {"Chính Tây Nhî Häi", 264}
	MapDetail[250] = {"Chính Tây Thäo Nguyên", 265}
	MapDetail[251] = {"Tây B¡c Liêu Tây", 266}
	MapDetail[252] = {"Chính Tây Võ Di", 267}
	MapDetail[253] = {"Tây B¡c Mai Lînh", 268}
	MapDetail[254] = {"Chính Nam ThÕch Lâm", 269}
	MapDetail[255] = {"Tây Nam Ng÷c Khê", 270}
	MapDetail[256] = {"Tây B¡c Trß¶ng BÕch S½n", 271}
	MapDetail[257] = {"Tây B¡c Hoàng Long Phü", 272}
	MapDetail[258] = {"Chính B¡c Nam Häi", 273}
	MapDetail[259] = {"Hß¾ng Tây Cüa QuÏnh Châu", 274}
	MapDetail[260] = {"Tây Nam Nam Chiêu", 275}
	MapDetail[261] = {"Chính Ðông Miêu Cß½ng", 276}
	MapDetail[262] = {"Chính Nam NhÕn Nam", 277}
	MapDetail[263] = {"Chính Tây NhÕn B¡c", 278}
	MapDetail[264] = {"Chính Tây Tây H°", 279}
	MapDetail[265] = {"Chính B¡c Long Tuy«n", 280}
	MapDetail[266] = {"Thß½ng S½n Chính Tây", 281}
	MapDetail[267] = {"Chính Tây Nhî Häi", 282}
	MapDetail[268] = {"Chính Tây Thäo Nguyên", 283}
	MapDetail[269] = {"Tây B¡c Liêu Tây", 284}
	MapDetail[270] = {"Chính Tây Võ Di", 285}
	MapDetail[271] = {"Tây B¡c Mai Lînh", 286}
	MapDetail[272] = {"Chính Nam ThÕch Lâm", 287}
	MapDetail[273] = {"Tây Nam Ng÷c Khê", 288}
	MapDetail[274] = {"Tây B¡c Trß¶ng BÕch S½n", 289}
	MapDetail[275] = {"Tây B¡c Hoàng Long Phü", 290}
	MapDetail[276] = {"Chính B¡c Nam Häi", 291}
	MapDetail[277] = {"Hß¾ng Tây Cüa QuÏnh Châu", 292}
	MapDetail[278] = {"Tây Nam Nam Chiêu", 293}
	MapDetail[279] = {"Chính Ðông Miêu Cß½ng", 294}
	MapDetail[280] = {"Chính Nam NhÕn Nam", 295}
	MapDetail[281] = {"Chính Tây NhÕn B¡c", 296}
	MapDetail[282] = {"Chính Tây Tây H°", 297}
	MapDetail[283] = {"Chính B¡c Long Tuy«n", 298}
	MapDetail[284] = {"Thß½ng S½n Chính Tây", 299}
	MapDetail[285] = {"Chính Tây Nhî Häi", 300}
	MapDetail[286] = {"Chính Tây Thäo Nguyên", 301}
	MapDetail[287] = {"Tây B¡c Liêu Tây", 302}
	MapDetail[288] = {"Chính Tây Võ Di", 303}
	MapDetail[289] = {"Tây B¡c Mai Lînh", 304}
	MapDetail[290] = {"Chính Nam ThÕch Lâm", 305}
	MapDetail[291] = {"Tây Nam Ng÷c Khê", 306}
	MapDetail[292] = {"Tây B¡c Trß¶ng BÕch S½n", 307}
	MapDetail[293] = {"Tây B¡c Hoàng Long Phü", 308}
	MapDetail[294] = {"Chính B¡c Nam Häi", 309}
	MapDetail[295] = {"Hß¾ng Tây Cüa QuÏnh Châu", 310}
	MapDetail[296] = {"Tây Nam Nam Chiêu", 311}
	MapDetail[297] = {"Chính Ðông Miêu Cß½ng", 312}
	MapDetail[298] = {"T¥n Hoàng Ð¸a Cung T¥ng 1", 400}
	MapDetail[299] = {"T¥n Hoàng Ð¸a Cung T¥ng 2", 401}
	MapDetail[300] = {"T¥n Hoàng Ð¸a Cung T¥ng 3", 402}
	MapDetail[301] = {"Huy«n Lôi Pha", 403}
	MapDetail[302] = {"Ðµc Chß¾ng TrÕch Ð¸a", 404}
	MapDetail[303] = {"Dung Nham Chi Ð¸a", 405}
	MapDetail[304] = {"Huy«n Vû Ðäo", 406}
	MapDetail[305] = {"Lâu Lan Bäo Tàng Ðµng", 407}
	MapDetail[306] = {"Trøc Lµc", 408}
	MapDetail[307] = {"Lßþng Mã D¸ch", 409}
	MapDetail[308] = {"Lôi Ðài Sinh TØ", 410}
	MapDetail[309] = {"Tung S½n Phong Thi«n Ðài", 414}
	MapDetail[310] = {"Diêm H°", 415}
	MapDetail[311] = {"Phiêu Mi¬u Phong", 416}
	MapDetail[312] = {"Bang Hµi Trú Ð¸a", 417}
	MapDetail[313] = {"Ð® Nh¤t Khu Nghï Ng½i TÕi LÕc Dß½ng", 418}
	MapDetail[314] = {"Ð® Nh¸ Khu Nghï Ng½i TÕi LÕc Dß½ng", 419}
	MapDetail[315] = {"Thúc Hà C± Tr¤n", 420}
	MapDetail[316] = {"Höa Di®m S½n", 423}
	MapDetail[317] = {"Cao Xß½ng", 424}
	MapDetail[318] = {"Tháp Lý Mµc", 425}
	MapDetail[319] = {"Tháp Kh¡c LÕp Mã Can", 427}
	MapDetail[320] = {"Sân Bóng Ðá", 428}
	MapDetail[321] = {"Sân Bóng R±", 429}
	MapDetail[322] = {"Sân Bóng Bàn", 430}
	MapDetail[323] = {"ÐÕi Uy¬n", 431}
	MapDetail[324] = {"HÕn Huyªt Lînh", 432}
	MapDetail[325] = {"Côn Lôn Sôn", 433}
	MapDetail[326] = {"Sinh Tiêu Lôi Ðài", 500}
	MapDetail[327] = {"Nông Trß¶ng Dã Trß", 514}
	MapDetail[328] = {"Thánh Thú S½n", 515}
	MapDetail[329] = {"Mçu Ðan Uy¬n", 516}
	MapDetail[330] = {"BÕch Sa Diêm Khanh", 517}
	MapDetail[331] = {"Khu Nghï Ng½i TÕi Tô Châu", 518}
	MapDetail[332] = {"Höa Di®m S½n", 519}
	MapDetail[333] = {"Cao Xß½ng Mê Cung", 520}
	MapDetail[334] = {"Chính nam NhÕn Nam", 597}
	MapDetail[335] = {"Chính tây NhÕn B¡c", 598}
	MapDetail[336] = {"Chính tây Tây H°", 599}
	MapDetail[337] = {"Chính b¡c Long Tuy«n", 600}
	MapDetail[338] = {"Chính tây Thß½ng S½n", 601}
	MapDetail[339] = {"Chính tây Nhî Häi", 602}
	MapDetail[340] = {"Chính tây Thäo Nguyên", 603}
	MapDetail[341] = {"Tây b¡c Liêu Tây", 604}
	MapDetail[342] = {"Chính tây Võ Di", 605}
	MapDetail[343] = {"Tây b¡c Mai Lînh", 606}
	MapDetail[344] = {"Chính nam ThÕch Lâm", 607}
	MapDetail[345] = {"Tây nam Ng÷c Khê", 608}
	MapDetail[346] = {"Tây b¡c Trß¶ng BÕch S½n", 609}
	MapDetail[347] = {"Tây b¡c Hoàng Long Phü", 610}
	MapDetail[348] = {"Chính b¡c Nam Häi", 611}
	MapDetail[349] = {"Hß¾ng tây cüa QuÏnh Châu", 612}
	MapDetail[350] = {"Tây nam Nam Chiêu", 613}
	MapDetail[351] = {"Chính ðông Miêu Cß½ng", 614}
	MapDetail[352] = {"Chính nam NhÕn Nam", 615}
	MapDetail[353] = {"Chính tây NhÕn B¡c", 616}
	MapDetail[354] = {"Chính tây Tây H°", 617}
	MapDetail[355] = {"Chính b¡c Long Tuy«n", 618}
	MapDetail[356] = {"Chính tây Thß½ng S½n", 619}
	MapDetail[357] = {"Chính tây Nhî Häi", 620}
	MapDetail[358] = {"Chính tây Thäo Nguyên", 621}
	MapDetail[359] = {"Tây b¡c Liêu Tây", 622}
	MapDetail[360] = {"Chính tây Võ Di", 623}
	MapDetail[361] = {"Tây b¡c Mai Lînh", 624}
	MapDetail[362] = {"Chính nam ThÕch Lâm", 625}
	MapDetail[363] = {"Tây nam Ng÷c Khê", 626}
	MapDetail[364] = {"Tây b¡c Trß¶ng BÕch S½n", 627}
	MapDetail[365] = {"Tây b¡c Hoàng Long Phü", 628}
	MapDetail[366] = {"Chính b¡c Nam Häi", 629}
	MapDetail[367] = {"Hß¾ng tây cüa QuÏnh Châu", 630}
	MapDetail[368] = {"Tây nam Nam Chiêu", 631}
	MapDetail[369] = {"Chính ðông Miêu Cß½ng", 632}
	MapDetail[370] = {"Chính nam NhÕn Nam", 633}
	MapDetail[371] = {"Chính tây NhÕn B¡c", 634}
	MapDetail[372] = {"Chính tây Tây H°", 635}
	MapDetail[373] = {"Chính b¡c Long Tuy«n", 636}
	MapDetail[374] = {"Chính tây Thß½ng S½n", 637}
	MapDetail[375] = {"Chính tây Nhî Häi", 638}
	MapDetail[376] = {"Chính tây Thäo Nguyên", 639}
	MapDetail[377] = {"Tây b¡c Liêu Tây", 640}
	MapDetail[378] = {"Chính tây Võ Di", 641}
	MapDetail[379] = {"Tây b¡c Mai Lînh", 642}
	MapDetail[380] = {"Chính nam ThÕch Lâm", 643}
	MapDetail[381] = {"Tây nam Ng÷c Khê", 644}
	MapDetail[382] = {"Tây b¡c Trß¶ng BÕch S½n", 645}
	MapDetail[383] = {"Tây b¡c Hoàng Long Phü", 646}
	MapDetail[384] = {"Chính b¡c Nam Häi", 647}
	MapDetail[385] = {"Hß¾ng tây cüa QuÏnh Châu", 648}
	MapDetail[386] = {"Tây nam Nam Chiêu", 649}
	MapDetail[387] = {"Chính ðông Miêu Cß½ng", 650}
	MapDetail[388] = {"Chính nam NhÕn Nam", 651}
	MapDetail[389] = {"Chính tây NhÕn B¡c", 652}
	MapDetail[390] = {"Chính tây Tây H°", 653}
	MapDetail[391] = {"Chính b¡c Long Tuy«n", 654}
	MapDetail[392] = {"Chính tây Thß½ng S½n", 655}
	MapDetail[393] = {"Chính tây Nhî Häi", 656}
	MapDetail[394] = {"Chính tây Thäo Nguyên", 657}
	MapDetail[395] = {"Tây b¡c Liêu Tây", 658}
	MapDetail[396] = {"Chính tây Võ Di", 659}
	MapDetail[397] = {"Tây b¡c Mai Lînh", 660}
	MapDetail[398] = {"Chính nam ThÕch Lâm", 661}
	MapDetail[399] = {"Tây nam Ng÷c Khê", 662}
	MapDetail[400] = {"Tây b¡c Trß¶ng BÕch S½n", 663}
	MapDetail[401] = {"Tây b¡c Hoàng Long Phü", 664}
	MapDetail[402] = {"Chính b¡c Nam Häi", 665}
	MapDetail[403] = {"Hß¾ng tây cüa QuÏnh Châu", 666}
	MapDetail[404] = {"Tây nam Nam Chiêu", 667}
	MapDetail[405] = {"Chính ðông Miêu Cß½ng", 668}
	MapDetail[406] = {"Chính nam NhÕn Nam", 669}
	MapDetail[407] = {"Chính tây NhÕn B¡c", 670}
	MapDetail[408] = {"Chính tây Tây H°", 671}
	MapDetail[409] = {"Chính b¡c Long Tuy«n", 672}
	MapDetail[410] = {"Chính tây Thß½ng S½n", 673}
	MapDetail[411] = {"Chính tây Nhî Häi", 674}
	MapDetail[412] = {"Chính tây Thäo Nguyên", 675}
	MapDetail[413] = {"Tây b¡c Liêu Tây", 676}
	MapDetail[414] = {"Chính tây Võ Di", 677}
	MapDetail[415] = {"Tây b¡c Mai Lînh", 678}
	MapDetail[416] = {"Chính nam ThÕch Lâm", 679}
	MapDetail[417] = {"Tây nam Ng÷c Khê", 680}
	MapDetail[418] = {"Tây b¡c Trß¶ng BÕch S½n", 681}
	MapDetail[419] = {"Tây b¡c Hoàng Long Phü", 682}
	MapDetail[420] = {"Chính b¡c Nam Häi", 683}
	MapDetail[421] = {"Hß¾ng tây cüa QuÏnh Châu", 684}
	MapDetail[422] = {"Tây nam Nam Chiêu", 685}
	MapDetail[423] = {"Chính ðông Miêu Cß½ng", 686}
	MapDetail[424] = {"Chính nam NhÕn Nam", 687}
	MapDetail[425] = {"Chính tây NhÕn B¡c", 688}
	MapDetail[426] = {"Chính tây Tây H°", 689}
	MapDetail[427] = {"Chính b¡c Long Tuy«n", 690}
	MapDetail[428] = {"Chính tây Thß½ng S½n", 691}
	MapDetail[429] = {"Chính tây Nhî Häi", 692}
	MapDetail[430] = {"Chính tây Thäo Nguyên", 693}
	MapDetail[431] = {"Tây b¡c Liêu Tây", 694}
	MapDetail[432] = {"Chính tây Võ Di", 695}
	MapDetail[433] = {"Tây b¡c Mai Lînh", 696}
	MapDetail[434] = {"Chính nam ThÕch Lâm", 697}
	MapDetail[435] = {"Tây nam Ng÷c Khê", 698}
	MapDetail[436] = {"Tây b¡c Trß¶ng BÕch S½n", 699}
	MapDetail[437] = {"Tây b¡c Hoàng Long Phü", 700}
	MapDetail[438] = {"Chính b¡c Nam Häi", 701}
	MapDetail[439] = {"Hß¾ng tây cüa QuÏnh Châu", 702}
	MapDetail[440] = {"Tây nam Nam Chiêu", 703}
	MapDetail[441] = {"Chính ðông Miêu Cß½ng", 704}

function GMTool_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
end

function GMTool_OnLoad()
	GMTool_ChonMap:ResetList();
	GMTool_ChonMap:ComboBoxAddItem("Ch÷n Bän Ð°",-1);
	for i = 0, 441 do
		GMTool_ChonMap:ComboBoxAddItem("["..MapDetail[i][2].."] "..MapDetail[i][1],MapDetail[i][2]);
	end
	GMTool_ChonMap:SetCurrentSelect(-1);

	GMTool_ChonLoaiNgoc:ResetList();
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ch÷n LoÕi Ng÷c",0);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Miêu Nhãn ThÕch",101001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H± Nhãn ThÕch",101002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Hoàng Tinh ThÕch",102001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam Tinh ThÕch",102002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H°ng Tinh ThÕch",102003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Løc Tinh ThÕch",102004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh Hoàng Tinh ThÕch",102005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh Lam Tinh ThÕch",102006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh H°ng Tinh ThÕch",102007);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh Løc Tinh ThÕch",102008);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("TØ Ng÷c",103001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Biªn ThÕch",103002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("ThÕch Lñu ThÕch",111001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Tiêm Tinh ThÕch",111002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Hoàng Ng÷c",112001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("HÕo ThÕch",112002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("DÕ Quang ThÕch",112003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Bích TÖ",112004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh Hoàng Ng÷c",112005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh HÕo ThÕch",112006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh DÕ Quang ThÕch",112007);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu¥n T¸nh Bích TÖ",112008);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Hoàng Bäo ThÕch",113001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam Bäo ThÕch",113002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Løc Bäo ThÕch",113003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H°ng Bäo ThÕch",113004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H¡c Bäo ThÕch",113005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Huyªt Tinh ThÕch",113006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Hoàng Minh ThÕch",121001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam Minh ThÕch",121002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H°ng Minh ThÕch",121003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Løc Minh ThÕch",121004);
	GMTool_ChonLoaiNgoc:SetCurrentSelect(0);
	
	GMTool_ChonCapNgoc:ResetList();
	GMTool_ChonCapNgoc:ComboBoxAddItem("Ch÷n C¤p Ðµ",0);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 1",1);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 2",2);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 3",3);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 4",4);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 5",5);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 6",6);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 7",7);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 8",8);
	GMTool_ChonCapNgoc:ComboBoxAddItem("Bäo ThÕch C¤p 9",9);
	GMTool_ChonCapNgoc:SetCurrentSelect(0);
end

function GMTool_OnEvent(event)
	if event == "UI_COMMAND" and tonumber(arg0) == 7413 then
		local CharLevel = Get_XParam_INT(1)
		local MenpaiID = Get_XParam_INT(2)
		local CharMoney = Get_XParam_INT(3)
		local BindMoney = Get_XParam_INT(4)
		local CharKNB = Get_XParam_INT(5)
		local CharDT = Get_XParam_INT(6)
		
		local CharName = Get_XParam_STR(1)
		local GuildName = Get_XParam_STR(2)
		
		GMTool_Update(CharLevel,MenpaiID,CharMoney,BindMoney,CharKNB,CharDT, CharName,GuildName)
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 3147 then
		if this:IsVisible() then
			this:Hide();
			return;
		end
		GMTool_OnShow()
		this:Show();
	end
	
	if event == "UI_COMMAND" and tonumber(arg0) == 314701 then
		GMTool_ItemPush(tonumber(arg1))
		return;
	end
	
	if event == "PLAYER_LEAVE_WORLD" then
		GMTool_OnHidden();
		return;
	end
end

function GMTool_OnShow()
	GMTool_InputID:Show()
	GMTool_InputID2:Hide()
	GMTool_LockID:Enable()
	GMTool_UnlockID:Disable()
	
	GMTool_CharName:SetText("Tên:")
	GMTool_CharLevel:SetText("C¤p Ðµ:")
	GMTool_CharMenpai:SetText("Môn Phái:")
	GMTool_CharLeague:SetText("Bang Hµi:")
	GMTool_Money:SetText("N.Lßþng:")
	GMTool_BindMoney:SetText("Giao TØ:")
	GMTool_Yuanbao:SetText("Nguyên Bäo:")
	GMTool_Zengdian:SetText("Ði¬m T£ng:")
end

function GMTool_ItemPush(ItemPos)
	if ItemPos ~= GMTool_Object and GMTool_Object ~= -1 then
		LifeAbility:Lock_Packet_Item( GMTool_Object, 0 )
	end
	
	local TheAction = EnumAction( ItemPos, "packageitem" )
	if TheAction:GetID() == 0 then
		return
	end
	
	LifeAbility:Lock_Packet_Item( ItemPos, 1 )
	GMTool_ObjectItem:SetActionItem( TheAction:GetID() )
	GMTool_Object = ItemPos;
end

function GMTool_Update(CharLevel,MenpaiID,CharMoney,BindMoney,CharKNB,CharDT,  CharName,GuildName,LeagueName)
	GMTool_CharName:SetText("Tên: #G"..CharName)
	GMTool_CharLevel:SetText("C¤p Ðµ: #G"..CharLevel)
	GMTool_CharMenpai:SetText("Môn Phái: #G"..GMTool_MenpaiStr[MenpaiID+1])
	GMTool_CharLeague:SetText("Bang Hµi: #G"..GuildName)
	GMTool_Money:SetText("N.Lßþng: #G"..GMTool_StrMoney(CharMoney))
	GMTool_BindMoney:SetText("Giao TØ: #G"..GMTool_StrBindMoney(BindMoney))
	GMTool_Yuanbao:SetText("Nguyên Bäo: #G"..CharKNB)
	GMTool_Zengdian:SetText("Ði¬m T£ng: #G"..CharDT)
end

function GMTool_FnLockID()
	local CharID = GMTool_InputID:GetText()
	if CharID == "" then
		PushDebugMessage("Ðã khoá Char ID cüa bÕn!")
		GMTool_InputID:Hide()
		
		local szCharID = Player:GetGUID();
		GMTool_InputID2:SetText("#G"..szCharID)
		GMTool_InputID2:Show()
		
		GMTool_LockID:Disable()
		GMTool_UnlockID:Enable()
		return
	end
	

	if string.len(CharID) == 8 then
		CharID = tonumber(CharID, 16)
	elseif string.len(CharID) == 10 then
		CharID = CharID --Really =))--
	else
		PushDebugMessage("CharID không hþp l®!")
		return
	end
		
	
	PushDebugMessage("Ðã khoá Char ID!")
	GMTool_InputID:Hide()

	GMTool_InputID2:SetText("#G"..CharID)
	GMTool_InputID2:Show()

	GMTool_LockID:Disable()
	GMTool_UnlockID:Enable()
end

function GMTool_FnUnlockID()
	PushDebugMessage("Ðã m· khoá Char ID!")
	GMTool_InputID:SetText("")
	GMTool_InputID:Show()
	
	GMTool_InputID2:SetText("")
	GMTool_InputID2:Hide()
	
	GMTool_LockID:Enable()
	GMTool_UnlockID:Disable()
	
	GMTool_CharName:SetText("Tên:")
	GMTool_CharLevel:SetText("C¤p Ðµ:")
	GMTool_CharMenpai:SetText("Môn Phái:")
	GMTool_CharLeague:SetText("Bang Hµi:")
	GMTool_Money:SetText("N.Lßþng:")
	GMTool_BindMoney:SetText("Giao TØ:")
	GMTool_Yuanbao:SetText("Nguyên Bäo:")
	GMTool_Zengdian:SetText("Ði¬m T£ng:")
end

function GMTool_RefreshData()
	local CharID = GMTool_InputID2:GetText()
	if CharID == "" then
		PushDebugMessage("Vui lòng nh§p CharID")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,0)
	Set_XSCRIPT_Parameter(1,tonumber(string.sub(CharID,2,12)))
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_Help()
	PushDebugMessage("Công cø h² trþ ð¡t lñc cho GM!")
end

function GMTool_OnHidden()
	GMTool_Clear()
	this:Hide()
end

function GMTool_Clear()
	LifeAbility:Lock_Packet_Item( GMTool_Object, 0 )
	GMTool_ObjectItem:SetActionItem( -1 )
	GMTool_Object = -1
	GMTool_GemID = -1
	GMTool_Accept_Clicked = 0
end

function GMTool_DichMap()
	local SceneName, SceneID = GMTool_ChonMap:GetCurrentSelect()
	local PosX = GMTool_ToaDoX:GetText()
	local PosZ = GMTool_ToaDoZ:GetText()
	
	if SceneID == "" then
		PushDebugMessage("Vui lòng ch÷n bän ð°!")
		return
	end
	
	SceneID = tonumber(SceneID);
	
	if SceneID <= -1 then
		PushDebugMessage("Vui lòng ch÷n bän ð°!")
		return
	end
	
	if PosX == "" then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	PosX = tonumber(PosX);
	
	if PosX <= 0 then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	if PosZ == "" then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	PosZ = tonumber(PosZ);
	
	if PosZ <= 0 then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,3)
	Set_XSCRIPT_Parameter(1,SceneID)
	Set_XSCRIPT_Parameter(2,PosX)
	Set_XSCRIPT_Parameter(3,PosX)
	Set_XSCRIPT_ParamCount(4)
	Send_XSCRIPT();
end

function GMTool_DelItem()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	if GMTool_Accept_Clicked == 0 then
		ShowSystemInfo("GMTOOL");
		GMTool_Accept_Clicked = 1;
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,1)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
	GMTool_Accept_Clicked = 0;
end

function GMTool_GiamDinh()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,4)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_CuongHoa()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,5)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_KhacDanh()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,6)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_SuaChua()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,7)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_DucLo()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,8)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT();
end

function GMTool_ThaoNgoc()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	local GemNum = LifeAbility : GetEquip_GemCount(GMTool_Object)
	if GemNum > 3 then
		PushEvent("UI_COMMAND", 25702)
	else
		PushEvent("UI_COMMAND", 27)
	end
	GMTool_Clear()
	this:Hide()
end

function GMTool_KhamNgoc()
	if GMTool_Object == -1 then
		PushDebugMessage("Møc tiêu vô hi®u!")
		return
	end
	
	local GemName, GemIDLv1 = GMTool_ChonLoaiNgoc:GetCurrentSelect()
	if GemIDLv1 == "0" then
		PushDebugMessage("Vui lòng ch÷n Bäo ThÕch")
		return
	end
	GemIDLv1 = tonumber(GemIDLv1)
	if GemIDLv1 <= 0 then
		PushDebugMessage("Vui lòng ch÷n Bäo ThÕch")
		return
	end
	
	local GemLevelStr, GemLevel = GMTool_ChonCapNgoc:GetCurrentSelect()
	if GemLevel == "0" then
		PushDebugMessage("Vui lòng ch÷n C¤p ðµ Bäo ThÕch")
		return
	end
	GemLevel = tonumber(GemLevel)
	if GemLevel <= 0 then
		PushDebugMessage("Vui lòng ch÷n C¤p ðµ Bäo ThÕch")
		return
	end
	
	GMTool_GemID = GemIDLv1 + (GemLevel-1)*100000;
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,9)
	Set_XSCRIPT_Parameter(1,GMTool_Object)
	Set_XSCRIPT_Parameter(2,GMTool_GemID)
	Set_XSCRIPT_ParamCount(3)
	Send_XSCRIPT();
end

function GMTool_StrMoney(PriceValue)
	local VStr, BStr, DStr = "";
	VStr = tostring(math.floor(PriceValue/10000));
	BStr = tostring(math.mod(math.floor(PriceValue/100),100));
	DStr = tostring(math.mod(PriceValue,100));

	local StrMoney = "";
	
	if VStr == "0" and BStr ~= "0" then
		StrMoney = BStr.."#-03"..DStr.."#-04";
	elseif VStr == "0" and BStr == "0" then
		StrMoney = DStr.."#-04";
	else
		StrMoney = VStr.."#-02"..BStr.."#-03"..DStr.."#-04";
	end

	return StrMoney;
end

function GMTool_StrBindMoney(PriceValue)
	local VStr, BStr, DStr = "";
	VStr = tostring(math.floor(PriceValue/10000));
	BStr = tostring(math.mod(math.floor(PriceValue/100),100));
	DStr = tostring(math.mod(PriceValue,100));

	local StrMoney = "";
	
	if VStr == "0" and BStr ~= "0" then
		StrMoney = BStr.."#-15"..DStr.."#-16";
	elseif VStr == "0" and BStr == "0" then
		StrMoney = DStr.."#-16";
	else
		StrMoney = VStr.."#-14"..BStr.."#-15"..DStr.."#-16";
	end

	return StrMoney;
end

function GMTool_ToaDoX_Active()
	GMTool_ToaDoZ:SetProperty("DefaultEditBox", "True");
	GMTool_ToaDoX:SetProperty("DefaultEditBox", "False");
end

function GMTool_ToaDoZ_Active()
	local SceneName, SceneID = GMTool_ChonMap:GetCurrentSelect()
	local PosX = GMTool_ToaDoX:GetText()
	local PosZ = GMTool_ToaDoZ:GetText()
	
	if SceneID == "" then
		PushDebugMessage("Vui lòng ch÷n bän ð°!")
		return
	end
	
	SceneID = tonumber(SceneID);
	
	if SceneID <= -1 then
		PushDebugMessage("Vui lòng ch÷n bän ð°!")
		return
	end
	
	if PosX == "" then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	PosX = tonumber(PosX);
	
	if PosX <= 0 then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	if PosZ == "" then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	PosZ = tonumber(PosZ);
	
	if PosZ <= 0 then
		PushDebugMessage("Vui lòng nh§p t÷a ðµ!")
		return
	end
	
	Clear_XSCRIPT();
	Set_XSCRIPT_Function_Name("GMTool")
	Set_XSCRIPT_ScriptID(741306)
	Set_XSCRIPT_Parameter(0,3)
	Set_XSCRIPT_Parameter(1,SceneID)
	Set_XSCRIPT_Parameter(2,PosX)
	Set_XSCRIPT_Parameter(3,PosZ)
	Set_XSCRIPT_ParamCount(4)
	Send_XSCRIPT();
end
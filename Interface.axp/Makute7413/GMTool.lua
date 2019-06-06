local GMTool_MenpaiStr = {"Thi�u L�m","Minh Gi�o","C�i Bang","V� �ang","Nga My","Tinh T�c","Thi�n Long","Thi�n S�n","Ti�u Dao","Ch�a c�"}
local GMTool_Object = -1
local GMTool_GemID = -1
local GMTool_Accept_Clicked = 0
local MapDetail = {}
	MapDetail[0] = {"L�c D߽ng", 0}
	MapDetail[1] = {"T� Ch�u", 1}
	MapDetail[2] = {"��i L�", 2}
	MapDetail[3] = {"Tung S�n", 3}
	MapDetail[4] = {"Th�i H�", 4}
	MapDetail[5] = {"K�nh H�", 5}
	MapDetail[6] = {"V� L��ng S�n", 6}
	MapDetail[7] = {"Ki�m C�c", 7}
	MapDetail[8] = {"��n Ho�ng", 8}
	MapDetail[9] = {"Thi�u L�m T�", 9}
	MapDetail[10] = {"C�i Bang T�ng ��", 10}
	MapDetail[11] = {"Quang Minh �i�n", 11}
	MapDetail[12] = {"N�i V� �ang", 12}
	MapDetail[13] = {"Thi�n Long T�", 13}
	MapDetail[14] = {"еng L�ng Ba", 14}
	MapDetail[15] = {"Nga My S�n", 15}
	MapDetail[16] = {"Tinh T�c H�i", 16}
	MapDetail[17] = {"Thi�n S�n", 17}
	MapDetail[18] = {"Nh�n Nam", 18}
	MapDetail[19] = {"Nh�n B�c", 19}
	MapDetail[20] = {"Th�o Nguy�n", 20}
	MapDetail[21] = {"Li�u T�y", 21}
	MapDetail[22] = {"Tr߶ng B�ch S�n", 22}
	MapDetail[23] = {"Ho�ng Long Ph�", 23}
	MapDetail[24] = {"Nh� H�i", 24}
	MapDetail[25] = {"Th߽ng S�n", 25}
	MapDetail[26] = {"Th�ch L�m", 26}
	MapDetail[27] = {"Ng�c Kh�", 27}
	MapDetail[28] = {"Nam Chi�u", 28}
	MapDetail[29] = {"Mi�u C߽ng", 29}
	MapDetail[30] = {"T�y H�", 30}
	MapDetail[31] = {"Long Tuy�n", 31}
	MapDetail[32] = {"V� Di", 32}
	MapDetail[33] = {"Mai L�nh", 33}
	MapDetail[34] = {"Nam H�i", 34}
	MapDetail[35] = {"Qu�nh Ch�u", 35}
	MapDetail[36] = {"T� Hi�n Trang", 36}
	MapDetail[37] = {"Y�n T� �", 37}
	MapDetail[38] = {"Nh�t Ph�m �߶ng", 38}
	MapDetail[39] = {"Huy�n V� ��o", 39}
	MapDetail[40] = {"D� L�u 2", 40}
	MapDetail[41] = {"D� L�u 3", 41}
	MapDetail[42] = {"Ph�n Qu�n Doanh иa", 42}
	MapDetail[43] = {"M�c Nh�n C�ng", 43}
	MapDetail[44] = {"Tr�n Long K� Cu�c", 44}
	MapDetail[45] = {"Thu� Lao", 45}
	MapDetail[46] = {"Sa M�c Y�u Tr�i", 46}
	MapDetail[47] = {"Bi�n Gi�i T�ng Li�u", 47}
	MapDetail[48] = {"D� Ngo�i Tr�i Ph�", 48}
	MapDetail[49] = {"Tr�c L�m", 49}
	MapDetail[50] = {"Ti�u M�c Nh�n C�ng 2", 50}
	MapDetail[51] = {"Quang Minh еng", 51}
	MapDetail[52] = {"��y C�c Ti�u Dao", 52}
	MapDetail[53] = {"Linh T�nh Phong", 53}
	MapDetail[54] = {"C�i Bang T�u Di�u", 54}
	MapDetail[55] = {"��o Hoa Tr�n", 55}
	MapDetail[56] = {"Th�p L�m", 56}
	MapDetail[57] = {"Ng� Th�n еng", 57}
	MapDetail[58] = {"Huy�t M�", 58}
	MapDetail[59] = {"Ch�n Th�p", 59}
	MapDetail[60] = {"Chi�t Mai Phong", 60}
	MapDetail[61] = {"Ti�u M�c Nh�n H�ng", 61}
	MapDetail[62] = {"H�u Hoa Vi�n", 62}
	MapDetail[63] = {"Ch� Phi�n", 63}
	MapDetail[64] = {"Kho�ng Tr߶ng", 64}
	MapDetail[65] = {"M�c Tr߶ng", 65}
	MapDetail[66] = {"Th� C�c", 66}
	MapDetail[67] = {"Th� T�p", 67}
	MapDetail[68] = {"T� Hi�n Trang", 68}
	MapDetail[69] = {"Y�n T� �", 69}
	MapDetail[70] = {"Nh�t Ph�m �߶ng", 70}
	MapDetail[71] = {"��i L� 2", 71}
	MapDetail[72] = {"��i L� 3", 72}
	MapDetail[73] = {"V� L��ng S�n 2", 73}
	MapDetail[74] = {"V� L��ng S�n 3", 74}
	MapDetail[75] = {"Ki�m C�c 2", 75}
	MapDetail[76] = {"Ki�m C�c 3", 76}
	MapDetail[77] = {"иa Ph�", 77}
	MapDetail[78] = {"N�i L�i C�", 78}
	MapDetail[79] = {"V�n Ki�p C�c", 79}
	MapDetail[80] = {"Th߽ng Mang S�n", 80}
	MapDetail[81] = {"Ti�u M�c Nh�n C�ng 3", 81}
	MapDetail[82] = {"H�u Hoa Vi�n 2", 82}
	MapDetail[83] = {"Th߽ng Mang S�n", 83}
	MapDetail[84] = {"V�n Ki�p C�c", 84}
	MapDetail[85] = {"N�i L�i C�", 85}
	MapDetail[86] = {"Nh�n Nam S�n еng", 86}
	MapDetail[87] = {"Nh�n B�c S�n еng", 87}
	MapDetail[88] = {"T�y H� S�n еng", 88}
	MapDetail[89] = {"Th߽ng S�n S�n еng", 89}
	MapDetail[90] = {"Quang Minh еng", 90}
	MapDetail[91] = {"��y C�c Ti�u Dao", 91}
	MapDetail[92] = {"Linh T�nh Phong", 92}
	MapDetail[93] = {"C�i Bang T�u Di�u", 93}
	MapDetail[94] = {"��o Hoa Tr�n", 94}
	MapDetail[95] = {"Th�p L�m", 95}
	MapDetail[96] = {"Ng� Th�n еng", 96}
	MapDetail[97] = {"Chi�t Mai Phong", 97}
	MapDetail[98] = {"Ch�n Th�p", 98}
	MapDetail[99] = {"Quang Minh еng", 99}
	MapDetail[100] = {"��y C�c Ti�u Dao", 100}
	MapDetail[101] = {"Linh T�nh Phong", 101}
	MapDetail[102] = {"C�i Bang T�u Di�u", 102}
	MapDetail[103] = {"��o Hoa Tr�n", 103}
	MapDetail[104] = {"Th�p L�m", 104}
	MapDetail[105] = {"Ng� Th�n еng", 105}
	MapDetail[106] = {"Chi�t Mai Phong", 106}
	MapDetail[107] = {"Ch�n Th�p", 107}
	MapDetail[108] = {"Th� T�p", 108}
	MapDetail[109] = {"Th� T�p", 109}
	MapDetail[110] = {"C�ng иa", 110}
	MapDetail[111] = {"Tr߶ng V�", 111}
	MapDetail[112] = {"Nha M�n", 112}
	MapDetail[113] = {"Tam Xu�n Huy�n C�nh", 113}
	MapDetail[114] = {"Tam H� Huy�n C�nh", 114}
	MapDetail[115] = {"Tam Thu Huy�n C�nh", 115}
	MapDetail[116] = {"Tam ��ng Huy�n C�nh", 116}
	MapDetail[117] = {"M�m N�i Tr�n иa N�i Bi�n Quan", 117}
	MapDetail[118] = {"M�m N�i Tr�n иa N�i Bi�n Quan", 118}
	MapDetail[119] = {"M�m N�i Tr�n иa N�i Bi�n Quan", 119}
	MapDetail[120] = {"M�m N�i Tr�n иa N�i Bi�n Quan", 120}
	MapDetail[121] = {"D� T�y H�", 121}
	MapDetail[122] = {"T�ng Kinh C�c", 122}
	MapDetail[123] = {"B�o T�ng еng T�ng 1", 123}
	MapDetail[124] = {"Kh�o Tr߶ng", 124}
	MapDetail[125] = {"Hoa S�n Tuy�t ��nh", 125}
	MapDetail[126] = {"B�o T�ng еng T�ng 2", 126}
	MapDetail[127] = {"T�c Kh�u Doanh иa", 127}
	MapDetail[128] = {"T�ng Kinh C�c", 128}
	MapDetail[129] = {"T�ng Kinh C�c", 129}
	MapDetail[130] = {"Thi�u L�m T�", 130}
	MapDetail[131] = {"C�i Bang T�ng ��", 131}
	MapDetail[132] = {"Quang Minh ��nh", 132}
	MapDetail[133] = {"N�i V� �ang", 133}
	MapDetail[134] = {"Thi�n Long T�", 134}
	MapDetail[135] = {"еng L�ng Ba", 135}
	MapDetail[136] = {"Nga My S�n", 136}
	MapDetail[137] = {"Tinh T�c H�i", 137}
	MapDetail[138] = {"Thi�n S�n", 138}
	MapDetail[139] = {"Thi�u L�m T�", 139}
	MapDetail[140] = {"C�i Bang T�ng ��", 140}
	MapDetail[141] = {"Quang Minh ��nh", 141}
	MapDetail[142] = {"N�i V� �ang", 142}
	MapDetail[143] = {"Thi�n Long T�", 143}
	MapDetail[144] = {"еng L�ng Ba", 144}
	MapDetail[145] = {"Nga My S�n", 145}
	MapDetail[146] = {"Tinh T�c H�i", 146}
	MapDetail[147] = {"Thi�n S�n", 147}
	MapDetail[148] = {"B�o T�ng еng T�ng 3", 148}
	MapDetail[149] = {"B�o T�ng еng T�ng 4", 149}
	MapDetail[150] = {"B�o T�ng еng T�ng 5", 150}
	MapDetail[151] = {"Gi�m Ng�c", 151}
	MapDetail[152] = {"T� V� H�i Tr߶ng", 152}
	MapDetail[153] = {"L� �߶ng Ph� Th�ng", 153}
	MapDetail[154] = {"L� �߶ng Cao C�p", 154}
	MapDetail[155] = {"L� �߶ng H�o Hoa", 155}
	MapDetail[156] = {"Th�o Li�u Tr߶ng", 156}
	MapDetail[157] = {"Mi�u Nh�n еng", 157}
	MapDetail[158] = {"Th�nh Th� S�n", 158}
	MapDetail[159] = {"Y�n V߽ng C� M� T�ng 1", 159}
	MapDetail[160] = {"Y�n V߽ng C� M� T�ng 2", 160}
	MapDetail[161] = {"Y�n V߽ng C� M� T�ng 3", 161}
	MapDetail[162] = {"Y�n V߽ng C� M� T�ng 4", 162}
	MapDetail[163] = {"Y�n V߽ng C� M� T�ng 5", 163}
	MapDetail[164] = {"Y�n V߽ng C� M� T�ng 6", 164}
	MapDetail[165] = {"Y�n V߽ng C� M� T�ng 7", 165}
	MapDetail[166] = {"Y�n V߽ng C� M� T�ng 8", 166}
	MapDetail[167] = {"Y�n V߽ng C� M� T�ng 9", 167}
	MapDetail[168] = {"S�n еng Tuy�n �", 168}
	MapDetail[169] = {"Ki�m Gia", 169}
	MapDetail[170] = {"Ma Nhai еng", 170}
	MapDetail[171] = {"D� Nh�n C�c", 171}
	MapDetail[172] = {"�n Tuy�n еng", 172}
	MapDetail[173] = {"Ho�ng Long еng", 173}
	MapDetail[174] = {"Thu� K�nh H�", 174}
	MapDetail[175] = {"Ti�n V߽ng Ph�n", 175}
	MapDetail[176] = {"Thi�n Khanh Th� еng", 176}
	MapDetail[177] = {"��o Hoa Nguy�n", 177}
	MapDetail[178] = {"H�i T�c еng", 178}
	MapDetail[179] = {"Tuy�t Lang H�", 179}
	MapDetail[180] = {"Ph�ng Ho�ng C� Tr�n", 180}
	MapDetail[181] = {"Ti�n Trang", 181}
	MapDetail[182] = {"H�u Hoa Vi�n 3", 182}
	MapDetail[183] = {"T�ng Kinh C�c", 183}
	MapDetail[184] = {"T�ng Kinh C�c", 185}
	MapDetail[185] = {"L�u Lan", 186}
	MapDetail[186] = {"Ng�n Ngai Tuy�t Nguy�n", 188}
	MapDetail[187] = {"K�nh H� Ph� Tr�i", 189}
	MapDetail[188] = {"Khu Ngh� Ng�i T�i ��i L�", 193}
	MapDetail[189] = {"H�n Ng�c C�c", 194}
	MapDetail[190] = {"Ch�nh Nam Nh�n Nam", 205}
	MapDetail[191] = {"Ch�nh T�y Nh�n B�c", 206}
	MapDetail[192] = {"Ch�nh T�y T�y H�", 207}
	MapDetail[193] = {"Ch�nh B�c Long Tuy�n", 208}
	MapDetail[194] = {"Th߽ng S�n Ch�nh T�y", 209}
	MapDetail[195] = {"Ch�nh T�y Nh� H�i", 210}
	MapDetail[196] = {"Ch�nh T�y Th�o Nguy�n", 211}
	MapDetail[197] = {"T�y B�c Li�u T�y", 212}
	MapDetail[198] = {"Ch�nh T�y V� Di", 213}
	MapDetail[199] = {"T�y B�c Mai L�nh", 214}
	MapDetail[200] = {"Ch�nh Nam Th�ch L�m", 215}
	MapDetail[201] = {"T�y Nam Ng�c Kh�", 216}
	MapDetail[202] = {"T�y B�c Tr߶ng B�ch S�n", 217}
	MapDetail[203] = {"T�y B�c Ho�ng Long Ph�", 218}
	MapDetail[204] = {"Ch�nh B�c Nam H�i", 219}
	MapDetail[205] = {"H߾ng T�y C�a Qu�nh Ch�u", 220}
	MapDetail[206] = {"T�y Nam Nam Chi�u", 221}
	MapDetail[207] = {"Ch�nh ��ng Mi�u C߽ng", 222}
	MapDetail[208] = {"Ch�nh Nam Nh�n Nam", 223}
	MapDetail[209] = {"Ch�nh T�y Nh�n B�c", 224}
	MapDetail[210] = {"Ch�nh T�y T�y H�", 225}
	MapDetail[211] = {"Ch�nh B�c Long Tuy�n", 226}
	MapDetail[212] = {"Th߽ng S�n Ch�nh T�y", 227}
	MapDetail[213] = {"Ch�nh T�y Nh� H�i", 228}
	MapDetail[214] = {"Ch�nh T�y Th�o Nguy�n", 229}
	MapDetail[215] = {"T�y B�c Li�u T�y", 230}
	MapDetail[216] = {"Ch�nh T�y V� Di", 231}
	MapDetail[217] = {"T�y B�c Mai L�nh", 232}
	MapDetail[218] = {"Ch�nh Nam Th�ch L�m", 233}
	MapDetail[219] = {"T�y Nam Ng�c Kh�", 234}
	MapDetail[220] = {"T�y B�c Tr߶ng B�ch S�n", 235}
	MapDetail[221] = {"T�y B�c Ho�ng Long Ph�", 236}
	MapDetail[222] = {"Ch�nh B�c Nam H�i", 237}
	MapDetail[223] = {"H߾ng T�y C�a Qu�nh Ch�u", 238}
	MapDetail[224] = {"T�y Nam Nam Chi�u", 239}
	MapDetail[225] = {"Ch�nh ��ng Mi�u C߽ng", 240}
	MapDetail[226] = {"Ch�nh Nam Nh�n Nam", 241}
	MapDetail[227] = {"Ch�nh T�y Nh�n B�c", 242}
	MapDetail[228] = {"Ch�nh T�y T�y H�", 243}
	MapDetail[229] = {"Ch�nh B�c Long Tuy�n", 244}
	MapDetail[230] = {"Th߽ng S�n Ch�nh T�y", 245}
	MapDetail[231] = {"Ch�nh T�y Nh� H�i", 246}
	MapDetail[232] = {"Ch�nh T�y Th�o Nguy�n", 247}
	MapDetail[233] = {"T�y B�c Li�u T�y", 248}
	MapDetail[234] = {"Ch�nh T�y V� Di", 249}
	MapDetail[235] = {"T�y B�c Mai L�nh", 250}
	MapDetail[236] = {"Ch�nh Nam Th�ch L�m", 251}
	MapDetail[237] = {"T�y Nam Ng�c Kh�", 252}
	MapDetail[238] = {"T�y B�c Tr߶ng B�ch S�n", 253}
	MapDetail[239] = {"T�y B�c Ho�ng Long Ph�", 254}
	MapDetail[240] = {"Ch�nh B�c Nam H�i", 255}
	MapDetail[241] = {"H߾ng T�y C�a Qu�nh Ch�u", 256}
	MapDetail[242] = {"T�y Nam Nam Chi�u", 257}
	MapDetail[243] = {"Ch�nh ��ng Mi�u C߽ng", 258}
	MapDetail[244] = {"Ch�nh Nam Nh�n Nam", 259}
	MapDetail[245] = {"Ch�nh T�y Nh�n B�c", 260}
	MapDetail[246] = {"Ch�nh T�y T�y H�", 261}
	MapDetail[247] = {"Ch�nh B�c Long Tuy�n", 262}
	MapDetail[248] = {"Th߽ng S�n Ch�nh T�y", 263}
	MapDetail[249] = {"Ch�nh T�y Nh� H�i", 264}
	MapDetail[250] = {"Ch�nh T�y Th�o Nguy�n", 265}
	MapDetail[251] = {"T�y B�c Li�u T�y", 266}
	MapDetail[252] = {"Ch�nh T�y V� Di", 267}
	MapDetail[253] = {"T�y B�c Mai L�nh", 268}
	MapDetail[254] = {"Ch�nh Nam Th�ch L�m", 269}
	MapDetail[255] = {"T�y Nam Ng�c Kh�", 270}
	MapDetail[256] = {"T�y B�c Tr߶ng B�ch S�n", 271}
	MapDetail[257] = {"T�y B�c Ho�ng Long Ph�", 272}
	MapDetail[258] = {"Ch�nh B�c Nam H�i", 273}
	MapDetail[259] = {"H߾ng T�y C�a Qu�nh Ch�u", 274}
	MapDetail[260] = {"T�y Nam Nam Chi�u", 275}
	MapDetail[261] = {"Ch�nh ��ng Mi�u C߽ng", 276}
	MapDetail[262] = {"Ch�nh Nam Nh�n Nam", 277}
	MapDetail[263] = {"Ch�nh T�y Nh�n B�c", 278}
	MapDetail[264] = {"Ch�nh T�y T�y H�", 279}
	MapDetail[265] = {"Ch�nh B�c Long Tuy�n", 280}
	MapDetail[266] = {"Th߽ng S�n Ch�nh T�y", 281}
	MapDetail[267] = {"Ch�nh T�y Nh� H�i", 282}
	MapDetail[268] = {"Ch�nh T�y Th�o Nguy�n", 283}
	MapDetail[269] = {"T�y B�c Li�u T�y", 284}
	MapDetail[270] = {"Ch�nh T�y V� Di", 285}
	MapDetail[271] = {"T�y B�c Mai L�nh", 286}
	MapDetail[272] = {"Ch�nh Nam Th�ch L�m", 287}
	MapDetail[273] = {"T�y Nam Ng�c Kh�", 288}
	MapDetail[274] = {"T�y B�c Tr߶ng B�ch S�n", 289}
	MapDetail[275] = {"T�y B�c Ho�ng Long Ph�", 290}
	MapDetail[276] = {"Ch�nh B�c Nam H�i", 291}
	MapDetail[277] = {"H߾ng T�y C�a Qu�nh Ch�u", 292}
	MapDetail[278] = {"T�y Nam Nam Chi�u", 293}
	MapDetail[279] = {"Ch�nh ��ng Mi�u C߽ng", 294}
	MapDetail[280] = {"Ch�nh Nam Nh�n Nam", 295}
	MapDetail[281] = {"Ch�nh T�y Nh�n B�c", 296}
	MapDetail[282] = {"Ch�nh T�y T�y H�", 297}
	MapDetail[283] = {"Ch�nh B�c Long Tuy�n", 298}
	MapDetail[284] = {"Th߽ng S�n Ch�nh T�y", 299}
	MapDetail[285] = {"Ch�nh T�y Nh� H�i", 300}
	MapDetail[286] = {"Ch�nh T�y Th�o Nguy�n", 301}
	MapDetail[287] = {"T�y B�c Li�u T�y", 302}
	MapDetail[288] = {"Ch�nh T�y V� Di", 303}
	MapDetail[289] = {"T�y B�c Mai L�nh", 304}
	MapDetail[290] = {"Ch�nh Nam Th�ch L�m", 305}
	MapDetail[291] = {"T�y Nam Ng�c Kh�", 306}
	MapDetail[292] = {"T�y B�c Tr߶ng B�ch S�n", 307}
	MapDetail[293] = {"T�y B�c Ho�ng Long Ph�", 308}
	MapDetail[294] = {"Ch�nh B�c Nam H�i", 309}
	MapDetail[295] = {"H߾ng T�y C�a Qu�nh Ch�u", 310}
	MapDetail[296] = {"T�y Nam Nam Chi�u", 311}
	MapDetail[297] = {"Ch�nh ��ng Mi�u C߽ng", 312}
	MapDetail[298] = {"T�n Ho�ng иa Cung T�ng 1", 400}
	MapDetail[299] = {"T�n Ho�ng иa Cung T�ng 2", 401}
	MapDetail[300] = {"T�n Ho�ng иa Cung T�ng 3", 402}
	MapDetail[301] = {"Huy�n L�i Pha", 403}
	MapDetail[302] = {"еc Ch߾ng Tr�ch иa", 404}
	MapDetail[303] = {"Dung Nham Chi иa", 405}
	MapDetail[304] = {"Huy�n V� ��o", 406}
	MapDetail[305] = {"L�u Lan B�o T�ng еng", 407}
	MapDetail[306] = {"Tr�c L�c", 408}
	MapDetail[307] = {"L��ng M� D�ch", 409}
	MapDetail[308] = {"L�i ��i Sinh T�", 410}
	MapDetail[309] = {"Tung S�n Phong Thi�n ��i", 414}
	MapDetail[310] = {"Di�m H�", 415}
	MapDetail[311] = {"Phi�u Mi�u Phong", 416}
	MapDetail[312] = {"Bang H�i Tr� иa", 417}
	MapDetail[313] = {"Ю Nh�t Khu Ngh� Ng�i T�i L�c D߽ng", 418}
	MapDetail[314] = {"Ю Nh� Khu Ngh� Ng�i T�i L�c D߽ng", 419}
	MapDetail[315] = {"Th�c H� C� Tr�n", 420}
	MapDetail[316] = {"H�a Di�m S�n", 423}
	MapDetail[317] = {"Cao X߽ng", 424}
	MapDetail[318] = {"Th�p L� M�c", 425}
	MapDetail[319] = {"Th�p Kh�c L�p M� Can", 427}
	MapDetail[320] = {"S�n B�ng ��", 428}
	MapDetail[321] = {"S�n B�ng R�", 429}
	MapDetail[322] = {"S�n B�ng B�n", 430}
	MapDetail[323] = {"��i Uy�n", 431}
	MapDetail[324] = {"H�n Huy�t L�nh", 432}
	MapDetail[325] = {"C�n L�n S�n", 433}
	MapDetail[326] = {"Sinh Ti�u L�i ��i", 500}
	MapDetail[327] = {"N�ng Tr߶ng D� Tr�", 514}
	MapDetail[328] = {"Th�nh Th� S�n", 515}
	MapDetail[329] = {"M�u �an Uy�n", 516}
	MapDetail[330] = {"B�ch Sa Di�m Khanh", 517}
	MapDetail[331] = {"Khu Ngh� Ng�i T�i T� Ch�u", 518}
	MapDetail[332] = {"H�a Di�m S�n", 519}
	MapDetail[333] = {"Cao X߽ng M� Cung", 520}
	MapDetail[334] = {"Ch�nh nam Nh�n Nam", 597}
	MapDetail[335] = {"Ch�nh t�y Nh�n B�c", 598}
	MapDetail[336] = {"Ch�nh t�y T�y H�", 599}
	MapDetail[337] = {"Ch�nh b�c Long Tuy�n", 600}
	MapDetail[338] = {"Ch�nh t�y Th߽ng S�n", 601}
	MapDetail[339] = {"Ch�nh t�y Nh� H�i", 602}
	MapDetail[340] = {"Ch�nh t�y Th�o Nguy�n", 603}
	MapDetail[341] = {"T�y b�c Li�u T�y", 604}
	MapDetail[342] = {"Ch�nh t�y V� Di", 605}
	MapDetail[343] = {"T�y b�c Mai L�nh", 606}
	MapDetail[344] = {"Ch�nh nam Th�ch L�m", 607}
	MapDetail[345] = {"T�y nam Ng�c Kh�", 608}
	MapDetail[346] = {"T�y b�c Tr߶ng B�ch S�n", 609}
	MapDetail[347] = {"T�y b�c Ho�ng Long Ph�", 610}
	MapDetail[348] = {"Ch�nh b�c Nam H�i", 611}
	MapDetail[349] = {"H߾ng t�y c�a Qu�nh Ch�u", 612}
	MapDetail[350] = {"T�y nam Nam Chi�u", 613}
	MapDetail[351] = {"Ch�nh ��ng Mi�u C߽ng", 614}
	MapDetail[352] = {"Ch�nh nam Nh�n Nam", 615}
	MapDetail[353] = {"Ch�nh t�y Nh�n B�c", 616}
	MapDetail[354] = {"Ch�nh t�y T�y H�", 617}
	MapDetail[355] = {"Ch�nh b�c Long Tuy�n", 618}
	MapDetail[356] = {"Ch�nh t�y Th߽ng S�n", 619}
	MapDetail[357] = {"Ch�nh t�y Nh� H�i", 620}
	MapDetail[358] = {"Ch�nh t�y Th�o Nguy�n", 621}
	MapDetail[359] = {"T�y b�c Li�u T�y", 622}
	MapDetail[360] = {"Ch�nh t�y V� Di", 623}
	MapDetail[361] = {"T�y b�c Mai L�nh", 624}
	MapDetail[362] = {"Ch�nh nam Th�ch L�m", 625}
	MapDetail[363] = {"T�y nam Ng�c Kh�", 626}
	MapDetail[364] = {"T�y b�c Tr߶ng B�ch S�n", 627}
	MapDetail[365] = {"T�y b�c Ho�ng Long Ph�", 628}
	MapDetail[366] = {"Ch�nh b�c Nam H�i", 629}
	MapDetail[367] = {"H߾ng t�y c�a Qu�nh Ch�u", 630}
	MapDetail[368] = {"T�y nam Nam Chi�u", 631}
	MapDetail[369] = {"Ch�nh ��ng Mi�u C߽ng", 632}
	MapDetail[370] = {"Ch�nh nam Nh�n Nam", 633}
	MapDetail[371] = {"Ch�nh t�y Nh�n B�c", 634}
	MapDetail[372] = {"Ch�nh t�y T�y H�", 635}
	MapDetail[373] = {"Ch�nh b�c Long Tuy�n", 636}
	MapDetail[374] = {"Ch�nh t�y Th߽ng S�n", 637}
	MapDetail[375] = {"Ch�nh t�y Nh� H�i", 638}
	MapDetail[376] = {"Ch�nh t�y Th�o Nguy�n", 639}
	MapDetail[377] = {"T�y b�c Li�u T�y", 640}
	MapDetail[378] = {"Ch�nh t�y V� Di", 641}
	MapDetail[379] = {"T�y b�c Mai L�nh", 642}
	MapDetail[380] = {"Ch�nh nam Th�ch L�m", 643}
	MapDetail[381] = {"T�y nam Ng�c Kh�", 644}
	MapDetail[382] = {"T�y b�c Tr߶ng B�ch S�n", 645}
	MapDetail[383] = {"T�y b�c Ho�ng Long Ph�", 646}
	MapDetail[384] = {"Ch�nh b�c Nam H�i", 647}
	MapDetail[385] = {"H߾ng t�y c�a Qu�nh Ch�u", 648}
	MapDetail[386] = {"T�y nam Nam Chi�u", 649}
	MapDetail[387] = {"Ch�nh ��ng Mi�u C߽ng", 650}
	MapDetail[388] = {"Ch�nh nam Nh�n Nam", 651}
	MapDetail[389] = {"Ch�nh t�y Nh�n B�c", 652}
	MapDetail[390] = {"Ch�nh t�y T�y H�", 653}
	MapDetail[391] = {"Ch�nh b�c Long Tuy�n", 654}
	MapDetail[392] = {"Ch�nh t�y Th߽ng S�n", 655}
	MapDetail[393] = {"Ch�nh t�y Nh� H�i", 656}
	MapDetail[394] = {"Ch�nh t�y Th�o Nguy�n", 657}
	MapDetail[395] = {"T�y b�c Li�u T�y", 658}
	MapDetail[396] = {"Ch�nh t�y V� Di", 659}
	MapDetail[397] = {"T�y b�c Mai L�nh", 660}
	MapDetail[398] = {"Ch�nh nam Th�ch L�m", 661}
	MapDetail[399] = {"T�y nam Ng�c Kh�", 662}
	MapDetail[400] = {"T�y b�c Tr߶ng B�ch S�n", 663}
	MapDetail[401] = {"T�y b�c Ho�ng Long Ph�", 664}
	MapDetail[402] = {"Ch�nh b�c Nam H�i", 665}
	MapDetail[403] = {"H߾ng t�y c�a Qu�nh Ch�u", 666}
	MapDetail[404] = {"T�y nam Nam Chi�u", 667}
	MapDetail[405] = {"Ch�nh ��ng Mi�u C߽ng", 668}
	MapDetail[406] = {"Ch�nh nam Nh�n Nam", 669}
	MapDetail[407] = {"Ch�nh t�y Nh�n B�c", 670}
	MapDetail[408] = {"Ch�nh t�y T�y H�", 671}
	MapDetail[409] = {"Ch�nh b�c Long Tuy�n", 672}
	MapDetail[410] = {"Ch�nh t�y Th߽ng S�n", 673}
	MapDetail[411] = {"Ch�nh t�y Nh� H�i", 674}
	MapDetail[412] = {"Ch�nh t�y Th�o Nguy�n", 675}
	MapDetail[413] = {"T�y b�c Li�u T�y", 676}
	MapDetail[414] = {"Ch�nh t�y V� Di", 677}
	MapDetail[415] = {"T�y b�c Mai L�nh", 678}
	MapDetail[416] = {"Ch�nh nam Th�ch L�m", 679}
	MapDetail[417] = {"T�y nam Ng�c Kh�", 680}
	MapDetail[418] = {"T�y b�c Tr߶ng B�ch S�n", 681}
	MapDetail[419] = {"T�y b�c Ho�ng Long Ph�", 682}
	MapDetail[420] = {"Ch�nh b�c Nam H�i", 683}
	MapDetail[421] = {"H߾ng t�y c�a Qu�nh Ch�u", 684}
	MapDetail[422] = {"T�y nam Nam Chi�u", 685}
	MapDetail[423] = {"Ch�nh ��ng Mi�u C߽ng", 686}
	MapDetail[424] = {"Ch�nh nam Nh�n Nam", 687}
	MapDetail[425] = {"Ch�nh t�y Nh�n B�c", 688}
	MapDetail[426] = {"Ch�nh t�y T�y H�", 689}
	MapDetail[427] = {"Ch�nh b�c Long Tuy�n", 690}
	MapDetail[428] = {"Ch�nh t�y Th߽ng S�n", 691}
	MapDetail[429] = {"Ch�nh t�y Nh� H�i", 692}
	MapDetail[430] = {"Ch�nh t�y Th�o Nguy�n", 693}
	MapDetail[431] = {"T�y b�c Li�u T�y", 694}
	MapDetail[432] = {"Ch�nh t�y V� Di", 695}
	MapDetail[433] = {"T�y b�c Mai L�nh", 696}
	MapDetail[434] = {"Ch�nh nam Th�ch L�m", 697}
	MapDetail[435] = {"T�y nam Ng�c Kh�", 698}
	MapDetail[436] = {"T�y b�c Tr߶ng B�ch S�n", 699}
	MapDetail[437] = {"T�y b�c Ho�ng Long Ph�", 700}
	MapDetail[438] = {"Ch�nh b�c Nam H�i", 701}
	MapDetail[439] = {"H߾ng t�y c�a Qu�nh Ch�u", 702}
	MapDetail[440] = {"T�y nam Nam Chi�u", 703}
	MapDetail[441] = {"Ch�nh ��ng Mi�u C߽ng", 704}

function GMTool_PreLoad()
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
end

function GMTool_OnLoad()
	GMTool_ChonMap:ResetList();
	GMTool_ChonMap:ComboBoxAddItem("Ch�n B�n а",-1);
	for i = 0, 441 do
		GMTool_ChonMap:ComboBoxAddItem("["..MapDetail[i][2].."] "..MapDetail[i][1],MapDetail[i][2]);
	end
	GMTool_ChonMap:SetCurrentSelect(-1);

	GMTool_ChonLoaiNgoc:ResetList();
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ch�n Lo�i Ng�c",0);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Mi�u Nh�n Th�ch",101001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H� Nh�n Th�ch",101002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ho�ng Tinh Th�ch",102001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam Tinh Th�ch",102002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H�ng Tinh Th�ch",102003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("L�c Tinh Th�ch",102004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh Ho�ng Tinh Th�ch",102005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh Lam Tinh Th�ch",102006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh H�ng Tinh Th�ch",102007);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh L�c Tinh Th�ch",102008);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("T� Ng�c",103001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Bi�n Th�ch",103002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Th�ch L�u Th�ch",111001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ti�m Tinh Th�ch",111002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ho�ng Ng�c",112001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H�o Th�ch",112002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("D� Quang Th�ch",112003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("B�ch T�",112004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh Ho�ng Ng�c",112005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh H�o Th�ch",112006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh D� Quang Th�ch",112007);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Thu�n T�nh B�ch T�",112008);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ho�ng B�o Th�ch",113001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam B�o Th�ch",113002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("L�c B�o Th�ch",113003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H�ng B�o Th�ch",113004);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H�c B�o Th�ch",113005);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Huy�t Tinh Th�ch",113006);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Ho�ng Minh Th�ch",121001);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("Lam Minh Th�ch",121002);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("H�ng Minh Th�ch",121003);
	GMTool_ChonLoaiNgoc:ComboBoxAddItem("L�c Minh Th�ch",121004);
	GMTool_ChonLoaiNgoc:SetCurrentSelect(0);
	
	GMTool_ChonCapNgoc:ResetList();
	GMTool_ChonCapNgoc:ComboBoxAddItem("Ch�n C�p е",0);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 1",1);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 2",2);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 3",3);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 4",4);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 5",5);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 6",6);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 7",7);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 8",8);
	GMTool_ChonCapNgoc:ComboBoxAddItem("B�o Th�ch C�p 9",9);
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
	
	GMTool_CharName:SetText("T�n:")
	GMTool_CharLevel:SetText("C�p е:")
	GMTool_CharMenpai:SetText("M�n Ph�i:")
	GMTool_CharLeague:SetText("Bang H�i:")
	GMTool_Money:SetText("N.L��ng:")
	GMTool_BindMoney:SetText("Giao T�:")
	GMTool_Yuanbao:SetText("Nguy�n B�o:")
	GMTool_Zengdian:SetText("�i�m T�ng:")
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
	GMTool_CharName:SetText("T�n: #G"..CharName)
	GMTool_CharLevel:SetText("C�p е: #G"..CharLevel)
	GMTool_CharMenpai:SetText("M�n Ph�i: #G"..GMTool_MenpaiStr[MenpaiID+1])
	GMTool_CharLeague:SetText("Bang H�i: #G"..GuildName)
	GMTool_Money:SetText("N.L��ng: #G"..GMTool_StrMoney(CharMoney))
	GMTool_BindMoney:SetText("Giao T�: #G"..GMTool_StrBindMoney(BindMoney))
	GMTool_Yuanbao:SetText("Nguy�n B�o: #G"..CharKNB)
	GMTool_Zengdian:SetText("�i�m T�ng: #G"..CharDT)
end

function GMTool_FnLockID()
	local CharID = GMTool_InputID:GetText()
	if CharID == "" then
		PushDebugMessage("�� kho� Char ID c�a b�n!")
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
		PushDebugMessage("CharID kh�ng h�p l�!")
		return
	end
		
	
	PushDebugMessage("�� kho� Char ID!")
	GMTool_InputID:Hide()

	GMTool_InputID2:SetText("#G"..CharID)
	GMTool_InputID2:Show()

	GMTool_LockID:Disable()
	GMTool_UnlockID:Enable()
end

function GMTool_FnUnlockID()
	PushDebugMessage("�� m� kho� Char ID!")
	GMTool_InputID:SetText("")
	GMTool_InputID:Show()
	
	GMTool_InputID2:SetText("")
	GMTool_InputID2:Hide()
	
	GMTool_LockID:Enable()
	GMTool_UnlockID:Disable()
	
	GMTool_CharName:SetText("T�n:")
	GMTool_CharLevel:SetText("C�p е:")
	GMTool_CharMenpai:SetText("M�n Ph�i:")
	GMTool_CharLeague:SetText("Bang H�i:")
	GMTool_Money:SetText("N.L��ng:")
	GMTool_BindMoney:SetText("Giao T�:")
	GMTool_Yuanbao:SetText("Nguy�n B�o:")
	GMTool_Zengdian:SetText("�i�m T�ng:")
end

function GMTool_RefreshData()
	local CharID = GMTool_InputID2:GetText()
	if CharID == "" then
		PushDebugMessage("Vui l�ng nh�p CharID")
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
	PushDebugMessage("C�ng c� h� tr� �t l�c cho GM!")
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
		PushDebugMessage("Vui l�ng ch�n b�n �!")
		return
	end
	
	SceneID = tonumber(SceneID);
	
	if SceneID <= -1 then
		PushDebugMessage("Vui l�ng ch�n b�n �!")
		return
	end
	
	if PosX == "" then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	PosX = tonumber(PosX);
	
	if PosX <= 0 then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	if PosZ == "" then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	PosZ = tonumber(PosZ);
	
	if PosZ <= 0 then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
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
		PushDebugMessage("M�c ti�u v� hi�u!")
		return
	end
	
	local GemName, GemIDLv1 = GMTool_ChonLoaiNgoc:GetCurrentSelect()
	if GemIDLv1 == "0" then
		PushDebugMessage("Vui l�ng ch�n B�o Th�ch")
		return
	end
	GemIDLv1 = tonumber(GemIDLv1)
	if GemIDLv1 <= 0 then
		PushDebugMessage("Vui l�ng ch�n B�o Th�ch")
		return
	end
	
	local GemLevelStr, GemLevel = GMTool_ChonCapNgoc:GetCurrentSelect()
	if GemLevel == "0" then
		PushDebugMessage("Vui l�ng ch�n C�p � B�o Th�ch")
		return
	end
	GemLevel = tonumber(GemLevel)
	if GemLevel <= 0 then
		PushDebugMessage("Vui l�ng ch�n C�p � B�o Th�ch")
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
		PushDebugMessage("Vui l�ng ch�n b�n �!")
		return
	end
	
	SceneID = tonumber(SceneID);
	
	if SceneID <= -1 then
		PushDebugMessage("Vui l�ng ch�n b�n �!")
		return
	end
	
	if PosX == "" then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	PosX = tonumber(PosX);
	
	if PosX <= 0 then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	if PosZ == "" then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
		return
	end
	
	PosZ = tonumber(PosZ);
	
	if PosZ <= 0 then
		PushDebugMessage("Vui l�ng nh�p t�a �!")
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
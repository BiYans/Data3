local EQUIP_BUTTONS;
local EQUIP_QUALITY = -1;
local MATERIAL_BUTTONS;
local MATERIAL_QUALITY = -1;
local Need_Item = 0
local Need_Money =0
local Need_Item_Count = 0
local Bore_Count=0
local objCared = -1;
local MAX_OBJ_DISTANCE = 3.0;
local STILE_TYPE = -1 --������ͣ�1���2����

local x311200_Stiletto_four_ID = {
																	10514091,10514092,10514093,10514094,10514095,10514096,10514097,10514098,10515090,10515091,
																	10515092,10515093,10515094,10515095,10515096,10515097,10515098,10521090,10521091,10521092,
																	10521093,10521094,10521095,10521096,10521097,10521098,10522090,10522091,10522092,10522093,
																	10522094,10522095,10522096,10522097,10522098,10523090,10523091,10523092,10523093,10523094,
																	10523095,10523096,10523097,10523098,10514090,
																	-- ����΢��2008.6.12�����102�������޴��
																	10300100,10300101,10300102, 10301100,10301101,10301102, 10301200,10301201,10301202,
																	10302100,10302101,10302102, 10303100,10303101,10303102, 10303200,10303201,10303202,
																	10304100,10304101,10304102, 10305100,10305101,10305102, 10305200,10305201,10305202,
																	10422016,10423024,10422149,	10422150,
																	--������2008.8.29����100�ף�����ף�����96�׿��ż��޴��
																	10510009,10510019,10510029,10510039,10510049,10510059,10510069,10510079,10510089,10511009,
																	10511019,10511029,10511039,10511049,10511059,10511069,10511079,10511089,10512009,10512019,
																	10512029,10512039,10512049,10512059,10512069,10512079,10512089,10513009,10513019,10513029,
																	10513039,10513049,10513059,10513069,10513079,10513089,
--																	10511096,10512092,10520092,10522101,
--																	10523101,10511097,10512093,10520093,10522102,10523102,10511098,10512094,10520094,10522103,
--																	10523103,10511099,10512095,10520095,10522104,10523104,
																	--������2008.9.18��90�����ϣ���90������ܲ����Ľ�ָ���������翪�ż��޴��
  																	10215020,10222020,10223020,10222035,10222036,10223035,10223036,
																	--������2008.11.11��90�����ϣ���90���ֹ�װ�����ż��޴�ף�Ь���������������ף�ͷ�������������ף�������
--																	10200019,10200020,10201019,10201020,10202019,10202020,10203019,10203020,10204019,10204020,
--																	10205019,10205020,
                                                                    10210020,10210040,10210060,10213020,10213040,10213060,10212020,10212040,
  																	10212060,10211020,10211040,10211060,10214020,10221020,10220020,
																	--zchw��2008-11-17  TT��41140 90�����ף�92���������ŵ��Ŀ�
																	10510008,10510038,10510068,
																	10511018,10511028,10511048,10511058,10511078,10511088,10512008,10512038,
																	10512068,10513008,10513018,10513028,10513038,10513048,10513058,10513068,
																	10513078,10513088,10514028,10514058,10514088,10520018,10520028,10520048,
																	10520058,10520078,10520088,10521028,10521058,10521088,10522018,10522048,
																	10522078,10552008,10552038,10552068,10553008,10553018,10553038,10553048,
																	10553068,10553078,
																	--msl 2010-06-21 
														            10300005,10302005,10304005,10305005,
																	--zchw 2008-11-26 TT��41771
																	10410027, 10410035,
																	--lixiangx,2010-6-10,90���ö��伫�޴��
																	10410026, 10410034,
--																	10423025, 10423026,
																	--houzhifang 2008-12-22: dark
--																	10150001,10150002,
																	--lixiangxi,2010-8-11
																	10510090,10510091,10510092,10510093,10510094,10510095,10511090,10511091,10511092,10511093,
																	10511094,10511095,10511096,10511097,10511098,10511099,10512090,10512091,10512092,10512093,
																	10512094,10512095,10514099,10514100,10514101,10514102,10514103,10514104,10515099,10515100,
																	10520090,10520091,10520092,10520093,10520094,10520095,10521099,10521100,10521101,10521102,
																	10522099,10522100,10522101,10522102,10522103,10522104,10523099,10523100,10523101,10523102,
																	10523103,10523104,
																	--lixiangxi,2010-3-4,Խ�����ֹ�
																	10210103,10210106,10210109,10210112,10210115,10210118,
																	10210121,10210124,10210127,10210130,10210133,10210136,
																	10211103,10211106,10211109,10211112,10211115,10211118,
																	10211121,10211124,10211127,10211130,10211133,10211136,
																	10212103,10212106,10212109,10212112,10212115,10212118,
																	10212121,10212124,10212127,10212130,10212133,10212136,
																	10214103,10214106,10214109,10214112,10215103,10215106,
																	10215109,10215112,10220103,10220106,10220109,10220112,
																	10221103,10221106,10221109,10221112,10222103,10222108,
																	10222109,10222112,10222117,10222118,10222121,10222126,
																	10222127,10222130,10222135,10222136,10223103,10223108,
																	10223109,10223112,10223117,10223118,10223121,10223126,
																	10223127,10223130,10223135,10223136,
																	10300005,10302005,10304005,10305005, 
																	--likun 2009-8-18
																	10300103,10300104,10300105,10300106,10300107,10300108,10300109,10300110,10300111,10301103,
																	10301104,10301105,10301106,10301107,10301108,10301109,10301110,10301111,10301203,10301204,
																	10301205,10301206,10301207,10301208,10301209,10301210,10301211,10302103,10302104,10302105,
																	10302106,10302107,10302108,10302109,10302110,10302111,10303103,10303104,10303105,10303106,
																	10303107,10303108,10303109,10303110,10303111,10303203,10303204,10303205,10303206,10303207,
																	10303208,10303209,10303210,10303211,10304103,10304104,10304105,10304106,10304107,10304108,
																	10304109,10304110,10304111,10305103,10305104,10305105,10305106,10305107,10305108,10305109,
																	10305110,10305111,10305203,10305204,10305205,10305206,10305207,10305208,10305209,10305210,
																	10305211,
									--likun 2009-8-26
									10300007,	--������Ƶ�	96
									10301001,	--ն�Ƕϳ�ǹ	96
									10301199,	--������а��	96
									10302007,	--����ŪӰ��	96
									10302009,	--������Ԩ��	96
									10303001,	--ת�����ǹ�	96
									10304007,	--���������	96
									10304009,	--���������	96
									10305007,	--������Ӱ��	96
									10305009,	--����ҫ����	96
									--zhanglei 2009-9-4
									10156001, --��꣺������
									10156002, --��꣺������
									--�����
									10156003,
									10156004,
}





local g_Object = -1;

function Stiletto_Four_PreLoad()

	this:RegisterEvent("UPDATE_STILETTO_FOUR");
	this:RegisterEvent("UI_COMMAND");
	this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("PACKAGE_ITEM_CHANGED");
	this:RegisterEvent("RESUME_ENCHASE_GEM");


end

function Stiletto_Four_OnLoad()
	EQUIP_BUTTONS = Stiletto_Four_Item
	MATERIAL_BUTTONS = Stiletto_Four_Material
end

function Stiletto_Four_OnEvent(event)

	--PushDebugMessage(event)

	if ( event == "UI_COMMAND" and tonumber(arg0) == 75117) then

			local xx = Get_XParam_INT(0);
			local thistype = Get_XParam_INT(1);

			if thistype ~= STILE_TYPE then
				Stiletto_Four_Clear()
			end
			STILE_TYPE = thistype

			this:Show();

			if STILE_TYPE == 1 then
				Stiletto_Four_Explain1: SetText("#{INTERFACE_XML_JX_07}")
				Stiletto_Four_Explain3: SetText("#{INTERFACE_XML_1162}")
			else
				Stiletto_Four_Explain1: SetText("#{JXDK_080827_1}")
				Stiletto_Four_Explain3: SetText("#{INTERFACE_XML_1163}")
			end

			objCared = DataPool : GetNPCIDByServerID(xx);
			AxTrace(0,1,"xx="..xx .. " objCared="..objCared)
			if objCared == -1 then
					PushDebugMessage("D� li�u c�a server truy�n tr� l�i c� v�n �");
					return;
			end
			BeginCareObject_Stiletto_Four(objCared)

	elseif ( event == "UI_COMMAND" and tonumber(arg0) == 091016141) then	 --���ʧ�ܺ�װ����Ȼ�����ڽ�����  fsy 09/10/16 #57883
			local idBagPos = Get_XParam_INT(0);
			Stiletto_Update(1,idBagPos);
			Resume_Equip_Stiletto_Four(2);

	elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if(tonumber(arg0) ~= objCared) then
			return;
		end

		--�����NPC�ľ������һ��������߱�ɾ�����Զ��ر�
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then

			--ȡ������
			Stiletto_Four_Cancel_Clicked()
		end

	elseif ( event == "PACKAGE_ITEM_CHANGED" and this:IsVisible() ) then

		if( arg0~= nil and -1 == tonumber(arg0)) then
			return;
		end


		if (EQUIP_QUALITY == tonumber(arg0) ) then
			Stiletto_Four_Clear()
			Stiletto_Four_Update(1,tonumber(arg0))
		end

		if (MATERIAL_QUALITY == tonumber(arg0) ) then
			Stiletto_Four_Clear()
			Stiletto_Four_Update(2,tonumber(arg0))
		end


	elseif ( event == "RESUME_Stiletto_Four_EQUIP" ) then
		Resume_Equip(1);
	elseif( event == "UPDATE_STILETTO_FOUR") then
		AxTrace(0,1,"arg0="..arg0)
		if arg0 == nil or arg1 == nil then
			return
		end

		Stiletto_Four_Update(tonumber(arg0),tonumber(arg1));

	elseif( event == "RESUME_ENCHASE_GEM" and this:IsVisible() ) then
		if(arg0~=nil and tonumber(arg0) == 13) then
			Resume_Equip_Stiletto_Four(1);
		elseif(arg0~=nil and tonumber(arg0) == 53) then
			Resume_Equip_Stiletto_Four(2);
		end

	end
end

function Stiletto_Four_OnShown()
	Stiletto_Four_Clear()
end

function Stiletto_Four_Clear()
	if(EQUIP_QUALITY ~= -1) then
		EQUIP_BUTTONS : SetActionItem(-1);
		LifeAbility : Lock_Packet_Item(EQUIP_QUALITY,0);
		EQUIP_QUALITY = -1;
	end

--	Stiletto_Four_Material_Bak : SetProperty("Image", "set:CommonItem image:ActionBK");
--	Stiletto_Four_Material_Bak	: SetToolTip("")
	if(MATERIAL_QUALITY ~= -1) then
		MATERIAL_BUTTONS : SetActionItem(-1);
		LifeAbility : Lock_Packet_Item(MATERIAL_QUALITY,0);
		MATERIAL_QUALITY = -1;
	end
	Stiletto_Four_Money : SetProperty("MoneyNumber", "");
	Stiletto_Four_State: SetText("")
	LifeAbility : ClearSlotFour()
end

function Stiletto_Four_Update(pos1,pos0)
	local pos_packet,pos_ui;
	pos_packet = tonumber(pos0);
	pos_ui		 = tonumber(pos1)

	local theAction = EnumAction(pos_packet, "packageitem");
	if pos_ui == 1 then  --������Ʒʱ
		if theAction:GetID() ~= 0 then

			local Bore_Count1 = 0;
		  local Need_Item1 = -1;
		  local Need_Money1 = 0;
		  local Need_Item_Count1 =0;

			--Need_Item,Need_Money,Need_Item_Count,Bore_Count=LifeAbility : Stiletto_Preparation(pos_packet);
			Need_Item1,Need_Money1,Need_Item_Count1,Bore_Count1=LifeAbility : Stiletto_Preparation(pos_packet, STILE_TYPE);

			local taozhuangid = PlayerPackage : GetItemTableIndex( pos_packet )
			local istaozhuang = 0


		  for i, v in x311200_Stiletto_four_ID do
		    if taozhuangid == v then
			    istaozhuang = 1;
			    break
		    end
	    end

	    if(PlayerPackage:IsBagItemDark(pos_packet) == 1) then
	    	istaozhuang = 1;
	    end

	    if istaozhuang == 0 then
	    	PushDebugMessage("#{XQC_20080509_02}")
				return
	    end

			if Bore_Count1 < 3 then --add:lby 20080523
				PushDebugMessage("#{XQC_20080509_03}")
				return
			end

			if Bore_Count1 > 3 then --add:lby 20080523
				PushDebugMessage("#{XQC_20080509_04}")
				return
			end


			if Need_Item1 < -1 then
				PushDebugMessage("#{XQC_20080509_01}")
				return
			end

			Need_Item = Need_Item1
			Need_Money = Need_Money1
			Need_Item_Count = Need_Item_Count1
			Bore_Count = Bore_Count1

			--��֮ǰ�Ķ�������
			if EQUIP_QUALITY ~= -1 then
				LifeAbility : Lock_Packet_Item(EQUIP_QUALITY,0);
				Stiletto_Four_Money : SetProperty("MoneyNumber", "");
				Stiletto_Four_State: SetText("")
			end

			EQUIP_BUTTONS:SetActionItem(theAction:GetID());
			EQUIP_QUALITY = pos_packet;
			LifeAbility : Lock_Packet_Item(EQUIP_QUALITY,1);
		else
			EQUIP_BUTTONS:SetActionItem(-1);
			LifeAbility : Lock_Packet_Item(EQUIP_QUALITY,0);
			EQUIP_QUALITY = -1;
			Stiletto_Four_Money : SetProperty("MoneyNumber", "");
			Stiletto_Four_State: SetText("")
			return;
		end
		Stiletto_Four_Money : SetProperty("MoneyNumber", tostring(Need_Money));
		Stiletto_Four_State : SetText("S� m�ng l�m hi�n t�i: "..Bore_Count.."; c� th� t�ng th�m s� m�ng l�m: "..tostring(4-Bore_Count))

	elseif pos_ui == 2 then --���֮����񾫴�

		--local Item_Class = PlayerPackage : GetItemSubTableIndex(pos_packet,0)
	--	local Item_Quality = PlayerPackage : GetItemSubTableIndex(pos_packet,1)
		--local Item_Type = PlayerPackage : GetItemSubTableIndex(pos_packet,2)



		--if Item_Class ~= 2 or Item_Quality ~= 1 or Item_Type ~= 9 then
		--	return
		--end

		if theAction:GetID() ~= 0 then

			local itemindex = PlayerPackage : GetItemTableIndex(pos_packet)

			if STILE_TYPE == 1 then
				if itemindex ~= 20109101 then  --add:lby 20080523ֻ�ܷ�����֮��
	 				PushDebugMessage("#{XQC_20080509_05}")
	 				return
	  		end
			elseif STILE_TYPE == 2 then
				if itemindex ~= 20310111 then  --add:hukai ֻ�ܷ��뺮�񾫴�
	 				PushDebugMessage("#{JCDK_80905_05}")
	 				return
	  		end
			else
				PushDebugMessage("Sai s�t trong lo�i h�nh ti�u hao."..STILE_TYPE)
	 			return
			end

			MATERIAL_BUTTONS:SetActionItem(theAction:GetID());
			if MATERIAL_QUALITY ~= -1 then
				LifeAbility : Lock_Packet_Item(MATERIAL_QUALITY,0);
			end
			--��֮ǰ�Ķ�������
			MATERIAL_QUALITY = pos_packet;
			LifeAbility : Lock_Packet_Item(MATERIAL_QUALITY,1);
		else
			MATERIAL_BUTTONS:SetActionItem(-1);
			LifeAbility : Lock_Packet_Item(MATERIAL_QUALITY,0);
			MATERIAL_QUALITY = -1;
			return;
		end
	end

end

function Stiletto_Four_Buttons_Clicked()
	if MATERIAL_QUALITY == -1 then
		PushDebugMessage("M�i th�m v�o v�t li�u ��c l�")
		return
	end
	if EQUIP_QUALITY ~= -1 then
		if Need_Item == -2 then
			if STILE_TYPE == 1 then
				PushDebugMessage("#{XQC_20080509_07}")
			else
				PushDebugMessage("#{JCDK_80905_07}")
			end
		elseif Need_Item == -3 then
			PushDebugMessage("#{XQC_20080509_04}")

		elseif Player:GetData("MONEY")+Player:GetData("MONEY_JZ") < Need_Money then
			if STILE_TYPE == 1 then
				PushDebugMessage("#{XQC_20080509_08}")
			else
				PushDebugMessage("#{JCDK_80905_08}")
			end
		else
			if LifeAbility : Is_SlotFour(EQUIP_QUALITY,MATERIAL_QUALITY,STILE_TYPE) == 1 then
				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name("OnStiletto_Four");
					Set_XSCRIPT_ScriptID(311200);
					Set_XSCRIPT_Parameter(0,EQUIP_QUALITY);
					Set_XSCRIPT_Parameter(1,MATERIAL_QUALITY);
					Set_XSCRIPT_Parameter(2,STILE_TYPE);
					Set_XSCRIPT_ParamCount(3);
				Send_XSCRIPT();
			end
		end
	else
		PushDebugMessage("#{XQC_20080509_06}")
	end

end

function Stiletto_Four_Close()
	--�����ã��ñ������λ�ñ���
	this:Hide();
	Stiletto_Four_Clear();
	StopCareObject_Stiletto_Four(objCared)
end

function Stiletto_Four_Cancel_Clicked()
	Stiletto_Four_Close();
	return;
end

--=========================================================
--��ʼ����NPC��
--�ڿ�ʼ����֮ǰ��Ҫ��ȷ����������ǲ����Ѿ��С����ġ���NPC��
--����еĻ�����ȡ���Ѿ��еġ����ġ�
--=========================================================
function BeginCareObject_Stiletto_Four(objCaredId)

	g_Object = objCaredId;
	this:CareObject(g_Object, 1, "Stiletto_Four");

end

--=========================================================
--ֹͣ��ĳNPC�Ĺ���
--=========================================================
function StopCareObject_Stiletto_Four(objCaredId)
	this:CareObject(objCaredId, 0, "Stiletto_Four");
	g_Object = -1;

end

function Resume_Equip_Stiletto_Four(nIndex)

	if( this:IsVisible() ) then

		if(nIndex == 1) then
			if(EQUIP_QUALITY ~= -1) then
				LifeAbility : Lock_Packet_Item(EQUIP_QUALITY,0);
				EQUIP_BUTTONS : SetActionItem(-1);
				EQUIP_QUALITY	= -1;
				Stiletto_Four_Money : SetProperty("MoneyNumber", "");
				Stiletto_Four_State: SetText("")
			end
		else
			if(MATERIAL_QUALITY ~= -1) then
				LifeAbility : Lock_Packet_Item(MATERIAL_QUALITY,0);
				MATERIAL_BUTTONS : SetActionItem(-1);
				MATERIAL_QUALITY	= -1;
			end
		end

	end

end

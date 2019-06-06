--- һ������ʯ����
--- Author: David Gao 2012.08.13

local g_EquipBaoshiCheck_Frame_UnifiedPosition

local g_EquipBaoshiCheck_Equip_Gem            = {}     --- װ���ϵı�ʯ
local g_EquipBaoshiCheck_Equip_GemTypeList    = {}     --- װ���ϵı�ʯ������Ϣ

local g_EquipBaoshiCheck_Gem_Container              = {}     --- װ��λ�ϵı�ʯ
local g_EquipBaoshiCheck_Gem_Container_GemTypeList  = {}     --- װ��λ�ϵı�ʯ������Ϣ

local g_EquipBaoshiCheck_IsHaveEquiped  = -1     --- �Ƿ���װ��

local g_EquipBaoshiCheck_Current_Sel = -1       --- ��¼��ǰѡ����ĸ�����

--������ͼƬ�ز�
local g_EquipBaoshiCheck_UnActived_Image  = "set:Agname3 image:BaoShiCheckFeng"    --- δ���
local g_EquipBaoshiCheck_Actived_Image    = "set:UIIcons image:Equip_Ring"      --- ��ʱʹ����Ԫ�����ͼƬ

local g_EquipBaoshiCheck_Equip_TypeList =
{
	[1]  = { name="#{WBSS_120727_34}", gemConIndex=0,  equipIndex=0,  },    --- ����
	[2]  = { name="#{WBSS_120727_26}", gemConIndex=11, equipIndex=14, },    --- ����
	[3]  = { name="#{WBSS_120727_30}", gemConIndex=6,  equipIndex=6,  },    --- ��ָ���ϣ�
	[4]  = { name="#{WBSS_120727_31}", gemConIndex=8,  equipIndex=11, },    --- ��ָ���£�
	[5]  = { name="#{WBSS_120727_32}", gemConIndex=9,  equipIndex=12, },    --- �������ϣ�
	[6]  = { name="#{WBSS_120727_33}", gemConIndex=10, equipIndex=13, },    --- �������£�
	[7]  = { name="#{WBSS_120727_35}", gemConIndex=2,  equipIndex=2,  },    --- �·�
	[8]  = { name="#{WBSS_120727_24}", gemConIndex=1,  equipIndex=1,  },    --- ñ��
	[9]  = { name="#{WBSS_120727_25}", gemConIndex=12, equipIndex=15, },    --- ���
	[10] = { name="#{WBSS_120727_27}", gemConIndex=3,  equipIndex=3,  },    --- ����
	[11] = { name="#{WBSS_120727_28}", gemConIndex=5,  equipIndex=5,  },    --- ����
	[12] = { name="#{WBSS_120727_29}", gemConIndex=4,  equipIndex=4,  },    --- Ь��
	[13] = { name="#{WBSS_120727_36}", gemConIndex=7,  equipIndex=7,  },    --- ����
	[14] = { name="#{WBSS_120727_37}", gemConIndex=13, equipIndex=17, },    --- ����
	[15] = { name="#{WBSS_120727_39}", gemConIndex=15, equipIndex=19, },    --- ����
	[16] = { name="#{WBSS_120727_38}", gemConIndex=14, equipIndex=18, },    --- ���
	[17] = { name="#{BHZB_140521_241}", gemConIndex=16, equipIndex=20, },    --- ��ʯ��˵
	[18] = { name="#{HXYSJ_141031_131}", gemConIndex=17, equipIndex=21, },    --- ����ӡ
}

function EquipBaoshiCheck_PreLoad()
    this:RegisterEvent("UI_COMMAND");
    this:RegisterEvent("REFRESH_EQUIP");
    this:RegisterEvent("GEM_CONTAINER_REFRESH");

	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("SCENE_TRANSED");
	this:RegisterEvent("ON_SCENE_TRANSING");
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
	this:RegisterEvent("GEM_CONTAINER_CHECK")
end

function EquipBaoshiCheck_OnLoad()

	if SystemSetup:IsClassic() == 0 then	--���ͻ�����Ψ���棬����������ͼƬ�ز�ΪΨ����
		g_EquipBaoshiCheck_UnActived_Image  = "set:WM_CommonFrame1 image:Feng"    --- δ���
		g_EquipBaoshiCheck_Actived_Image    = "set:WM_Button2 image:Equip_Ring"      --- ��ʱʹ����Ԫ�����ͼ?
	end

    g_EquipBaoshiCheck_Frame_UnifiedPosition = EquipBaoshiCheck_Frame:GetProperty( "UnifiedPosition" )

    g_EquipBaoshiCheck_Equip_Gem[1] = EquipBaoshiCheck_Special_Button1
    g_EquipBaoshiCheck_Equip_Gem[2] = EquipBaoshiCheck_Special_Button2
    g_EquipBaoshiCheck_Equip_Gem[3] = EquipBaoshiCheck_Special_Button3
    g_EquipBaoshiCheck_Equip_Gem[4] = EquipBaoshiCheck_Special_Button4

    g_EquipBaoshiCheck_Gem_Container[1] = EquipBaoshiCheck_Special_Button6
    g_EquipBaoshiCheck_Gem_Container[2] = EquipBaoshiCheck_Special_Button7
    g_EquipBaoshiCheck_Gem_Container[3] = EquipBaoshiCheck_Special_Button8
    g_EquipBaoshiCheck_Gem_Container[4] = EquipBaoshiCheck_Special_Button9

    EquipBaoshiCheck_Clear()

    g_EquipBaoshiCheck_Current_Sel = -1

end

-- OnEvent
function EquipBaoshiCheck_OnEvent(event)
	if event == "GEM_CONTAINER_CHECK"  then
        local btnIndex = tonumber( arg0 )
        local isTarget = tonumber( arg1 )
        if btnIndex < 1 or btnIndex > 18 then
            return
        end

        --- ����ǲ鿴�Լ���װ��λ��ʯ
        if isTarget == 0 then
            if g_EquipBaoshiCheck_Current_Sel == btnIndex then
                if this:IsVisible() then
                    EquipBaoshiCheck_Close_Clicked()
                end
                 return
            end

            g_EquipBaoshiCheck_Current_Sel = btnIndex
            EquipBaoshiCheck_Update( btnIndex )
            if this:IsVisible() then
            else
                this:Show()
            end
        end
    end

    if ( event == "UI_COMMAND" ) and tonumber( arg0 ) == 2012081302 then
        if ( this : IsVisible() ) then
            EquipBaoshiCheck_Update( g_EquipBaoshiCheck_Current_Sel )
        end
    elseif ( event == "GEM_CONTAINER_REFRESH" ) then
        if ( this : IsVisible() ) then
            EquipBaoshiCheck_Update( g_EquipBaoshiCheck_Current_Sel )
        end
    elseif ( event == "REFRESH_EQUIP" ) then
        if ( this:IsVisible() ) then
            EquipBaoshiCheck_Update( g_EquipBaoshiCheck_Current_Sel )
        end
	elseif event == "PLAYER_LEAVE_WORLD"  then
		if( this:IsVisible() ) then
			this:Hide()
		end
	elseif event == "SCENE_TRANSED"  then
		if( this:IsVisible() ) then
			this:Hide()
		end
	elseif event == "ON_SCENE_TRANSING"  then
		if( this:IsVisible() ) then
			this:Hide()
		end
	elseif (event == "ADJEST_UI_POS" ) then
		EquipBaoshiCheck_On_ResetPos()

	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipBaoshiCheck_On_ResetPos()
	end
end

function EquipBaoshiCheck_Init( itemState )

    return
end

function EquipBaoshiCheck_OnClosed()
    this:Hide()
    return
end

function EquipBaoshiCheck_On_ResetPos()
    EquipBaoshiCheck_Frame:SetProperty( "UnifiedPosition", g_EquipBaoshiCheck_Frame_UnifiedPosition )
    return
end


function EquipBaoshiCheck_Update( btnIndex )
    if btnIndex < 1 or btnIndex > 18 then
        return
    end

    EquipBaoshiCheck_Clear()

    --- �Ի�������
    local equipName = g_EquipBaoshiCheck_Equip_TypeList[btnIndex].name
    local strTitle = ScriptGlobal_Format( "#{WBSS_120727_11}", equipName )
    EquipBaoshiCheck_DragTitle : SetText( strTitle )

    --- ��Ϣ��ʾ
    EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_19}" )

    --- ������ʾװ���ϵı�ʯ
    local curEquipIndex = g_EquipBaoshiCheck_Equip_TypeList[btnIndex].equipIndex
    local updateRet     = LifeAbility : SplitWearedEquipGem_Update( curEquipIndex )
    local itemTblIdx    = LifeAbility : GetWearedEquip_ItemTableIndex( curEquipIndex )
    --- �Ƿ��ǰ���
    local bIsDark       = LifeAbility : IsWearedEquipDark( curEquipIndex )
    
    local bIsHxy       = LifeAbility : IsWearedEquipHXY( curEquipIndex )

    if updateRet then
        local holeCount  = LifeAbility : GetWearedEquip_HoleCount( curEquipIndex )
        g_EquipBaoshiCheck_IsHaveEquiped = 1
        local ActionID,nItemID
        --- ��1~4�׽��б���
        for i=1, 4 do
            nItemID = LifeAbility : GetSplitGem_Gem ( i - 1 )
            --- ����б�ʯ
			if nItemID ~= -1 then
			    ActionID = DataPool:EnumPlayerMission_ItemAction(nItemID);
				g_EquipBaoshiCheck_Equip_Gem[i] : SetActionItem(ActionID);
                local gemTblIdx = LifeAbility : GetSplitGem_GemIndex ( i - 1 )
                g_EquipBaoshiCheck_Equip_GemTypeList[i] = EquipBaoshiCheck_GetGemTypeByIndex( gemTblIdx )
            --- û�б�ʯ
            else
                g_EquipBaoshiCheck_Equip_Gem[i] : SetActionItem( -1 );
                --- δ�����Ŀ���ʾ��ӡ״̬
                if i > holeCount then
                    g_EquipBaoshiCheck_Equip_Gem[i] : SetActionItem( -1 );
                    g_EquipBaoshiCheck_Equip_Gem[i] : SetToolTip( "#{WBSS_120727_40}" )   --- װ���ĸÿ�λδ����
                    g_EquipBaoshiCheck_Equip_Gem[i] : SetProperty( "BackImage",  g_EquipBaoshiCheck_UnActived_Image )
                    --- ���Ŀ������ж�
                    if i == 4 then
                        --- ����޷��������Ŀ�
                        if 0 == EquipBaoshiCheck_Can_Stiletto_Four( itemTblIdx, bIsDark, bIsHxy ) then
                            g_EquipBaoshiCheck_Equip_Gem[i] : SetToolTip( "#{WBSS_120727_41}" )   --- װ���޷��������Ŀ�
                        end
                    end
                --- ����δ��Ƕ��ʯ���Ӧ���Ӵ���ʾ�ո���
                else
                    g_EquipBaoshiCheck_Equip_Gem[i] : SetProperty( "BackImage",  g_EquipBaoshiCheck_Actived_Image )
                    g_EquipBaoshiCheck_Equip_Gem[i] : SetToolTip( "#{WBSS_120727_45}" )   --- �ÿ�λδ��Ƕ��ʯ
                end
            end
            g_EquipBaoshiCheck_Equip_Gem[i] : Show()
		end
        EquipBaoshiCheck_TXT : Hide()
    else
        g_EquipBaoshiCheck_IsHaveEquiped = -1
        for i = 1, 4 do
            g_EquipBaoshiCheck_Equip_Gem[i] : Hide()
        end
        EquipBaoshiCheck_TXT : Show()
    end

    --- �����ʾװ��λ�ϵı�ʯ
    LifeAbility : GemContainer_Update()
    for i = 1, 4 do
        local itemID, _, tmpGemType = LifeAbility : GetGemContainer_Gem( g_EquipBaoshiCheck_Equip_TypeList[btnIndex].gemConIndex, i - 1 )
        if itemID ~= -1 then
            local ActionID = DataPool : EnumPlayerMission_ItemAction( itemID )
            g_EquipBaoshiCheck_Gem_Container[i] : SetActionItem( ActionID )
            g_EquipBaoshiCheck_Gem_Container_GemTypeList[i] = tmpGemType
        else
            g_EquipBaoshiCheck_Gem_Container[i] : SetActionItem( -1 )
            g_EquipBaoshiCheck_Gem_Container[i] : SetToolTip( "#{WBSS_120727_45}" )   --- �ÿ�λδ��Ƕ��ʯ
        end
    end

    EquipBaoshiCheck_UpdateHints( btnIndex )
    return
end

--- ������Ʒ���к��������Ʒ������
function EquipBaoshiCheck_GetGemTypeByIndex( itemTblIdx )
    if itemTblIdx == nil or itemTblIdx <= 0 then
        return -1
    end

    local tmpValue = math.mod( itemTblIdx, 100000 )
    local itemType = math.floor( tmpValue / 1000 )
    return itemType
end

function EquipBaoshiCheck_Clear()
    --- ��ʼ�����е�Buttons
    for i=1, 4 do
        g_EquipBaoshiCheck_Equip_Gem[i]     : SetActionItem( -1 )
        g_EquipBaoshiCheck_Gem_Container[i] : SetActionItem( -1 )

        g_EquipBaoshiCheck_Equip_GemTypeList[i]         = -1
        g_EquipBaoshiCheck_Gem_Container_GemTypeList[i] = -1
    end
    EquipBaoshiCheck_DragTitle  : SetText( "" )
    EquipBaoshiCheck_Frame_Info : SetText( "" )

    g_EquipBaoshiCheck_IsHaveEquiped = -1
    EquipBaoshiCheck_TXT : Hide()
end

function EquipBaoshiCheck_Close_Clicked()
    EquipBaoshiCheck_Clear()
    g_EquipBaoshiCheck_Current_Sel = -1
    this:Hide()
end

function EquipBaoshiCheck_OnHidden()
    EquipBaoshiCheck_Close_Clicked()
end

--- ��Ϣ��ʾ�������ʾ
function EquipBaoshiCheck_UpdateHints( typeListIndex )
    local ret = EquipBaoshiCheck_Can_SwitchGem( typeListIndex )
    if ret == 1 then
        EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_20}" )      --- װ��λ����װ�����޷�������������
    elseif ret == 2 then
        EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_98}" )      --- װ��λ����δ��Ƕ��ʯ����װ��λ�����ܽ��л���
    elseif ret == 3 then
        EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_22}" )      --- ��Ӧ��װ����λ��û�б�ʯ���޷�������������
    elseif ret == 4 then
        EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_23}" )      --- ����ʱװ��ǰ���׻����ͬ���ͱ�ʯ���޷�������������
    elseif ret == 0 then
        EquipBaoshiCheck_Frame_Info : SetText( "#{WBSS_120727_19}" )      --- ���㻥�����������Խ�����������
    else
        EquipBaoshiCheck_Frame_Info : SetText( "" )
    end
end

function EquipBaoshiCheck_Can_SwitchGem( curSel )
    local conPos     = g_EquipBaoshiCheck_Equip_TypeList[curSel].gemConIndex
    local equipPoint = g_EquipBaoshiCheck_Equip_TypeList[curSel].equipIndex

    --- �õ�װ���ϵı�ʯ
    local equipTypeList = {}
    if g_EquipBaoshiCheck_IsHaveEquiped <= 0 then
        return 1    --- û��װ��
    end
    for i = 1, 4 do
        equipTypeList[i] = g_EquipBaoshiCheck_Equip_GemTypeList[i]
    end

    --- ��εõ�װ��λ�ϵı�ʯ����
    local gemConTypeList  = { }
    local bHaveGemCon     = 0       --- װ��λ���Ƿ��б�ʯ
    for i = 1, 4 do
        gemConTypeList[i] = g_EquipBaoshiCheck_Gem_Container_GemTypeList[i]
        if gemConTypeList[i] > 0 then
            bHaveGemCon       = 1
        end
    end
    if bHaveGemCon == 0 then
        return 2
    end

    --- �ж�װ��λ�ϵ����б�ʯ��Ӧ�ĵ�ǰװ���ϵĿ�λ�Ƿ񶼴��ڱ�ʯ
    for i = 1, 4 do
        --- ���װ��λ���б�ʯ
        if gemConTypeList[i] > 0 then
            -- �ж�װ��λ�ϵ����б�ʯ��Ӧ�ĵ�ǰװ���ϵĿ�λ�Ƿ񶼴��ڱ�ʯ
            if equipTypeList[i] <= 0 then
                return 3
            end
            equipTypeList[i] = gemConTypeList[i]
        end
    end

    --- �жϻ����󣬵�ǰװ��ǰ�����Ƿ�����ͬ���ͱ�ʯ
    if equipTypeList[1] > 0 then
        if ( equipTypeList[1] == equipTypeList[2] ) or ( equipTypeList[1] == equipTypeList[3] ) then
            return 4
        end
    end

    if equipTypeList[2] > 0 then
        if ( equipTypeList[1] == equipTypeList[2] ) or ( equipTypeList[2] == equipTypeList[3] ) then
            return 4
        end
    end

    if equipTypeList[3] > 0 then
        if ( equipTypeList[1] == equipTypeList[3] ) or ( equipTypeList[2] == equipTypeList[3] ) then
            return 4
        end
    end

    return 0
end

--- ��Ϊ���ж����Ƿ��ܴ��Ŀ�
local g_EquipBaoshiCheck_Stiletto_four_ID = {

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
																	10513039,10513049,10513059,10513069,10513079,10513089,10511096,10512092,10520092,10522101,
																	10523101,10511097,10512093,10520093,10522102,10523102,10511098,10512094,10520094,10522103,
																	10523103,10511099,10512095,10520095,10522104,10523104,
																	--������2008.9.18��90�����ϣ���90������ܲ����Ľ�ָ���������翪�ż��޴��
																	10215020,10222020,10223020,10222035,10222036,10223035,10223036,
																	--������2008.11.11��90�����ϣ���90���ֹ�װ�����ż��޴�ף�Ь���������������ף�ͷ�������������ף�������
																	10200019,10200020,10201019,10201020,10202019,10202020,10203019,10203020,10204019,10204020,
																	10205019,10205020,10210020,10210040,10210060,10213020,10213040,10213060,10212020,10212040,
																	10212060,10211020,10211040,10211060,10214020,10221020,10220020,
																	--zchw��2008-11-17  TT��41140 90�����ף�92���������ŵ��Ŀ�
																	10510008,10510038,10510068,
																	10511018,10511028,10511048,10511058,10511078,10511088,10512008,10512038,
																	10512068,10513008,10513018,10513028,10513038,10513048,10513058,10513068,
																	10513078,10513088,10514028,10514058,10514088,10520018,10520028,10520048,
																	10520058,10520078,10520088,10521028,10521058,10521088,10522018,10522048,
																	10522078,10552008,10552038,10552068,10553008,10553018,10553038,10553048,
																	10553068,10553078,
																	--zchw 2008-11-26 TT��41771
																	10410026, 10410027, 10410034, 10410035, 10423025, 10423026,
																	--houzhifang 2008-12-22: dark
																	10150001,10150002,
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
									--����Ϊ������װ��
									10510118,	10510119,	10511119,	10512118,	10512119,	10513118,10513119,
                  10514109, 10515109, 10521109,	10522109,	10523109, 10552118,10553118,
                   --Ľ������
                  10302011,10302200,10302201,10302202,10302203,10302204,10302205,
									10302206,10302207,10302208,10302209,10302210,10302211,
									--������䣬90�������Ͽ������޴��
									10422128,10422129,10422130,10422131,10422132,10422136,10422137,10422138,10422139,10422140,
									--��¥�� ��¥�� guochenshu 2010-09-17 ��¥��
									10422155,10423064,10420091,
									--��84235��84236��84237һ���ύ����ÿ��10�¡�90������װ����4�ס��ű��޸�
									10421941,10421942,10421943,10421944,10421951,10421952,10421953,10421954,10421961,10421962,10421963,10421964,
									10415941,10415942,10415943,10415944,10415951,10415952,10415953,10415954,10415961,10415962,10415963,10415964,
									10414941,10414942,10414943,10414944,10414951,10414952,10414953,10414954,10414961,10414962,10414963,10414964,
									--quyan ��¥��������¥�� 2010.11.29
									--lilianhuan �������󶨵�����¥��
									10420088,10420089,10420090,10420093,
									-- -_-!!!!kaibin for �������ɽ96��װ�ɴ��
									10510124,10510125,10510126,10510127,10511124,10511125,10511126,10511127,10512124,10512125,10512126,10512127,
									10522124,10522125,10522126,10522127,10523124,10523125,10523126,10523127,
									10157001,10157002, --����
									10422160,--�����ָ
									10415055,10415056, --modify by kaibin for ����¥����
									10423076,10423077, --����¥�������¥��
									10511138,10513138,10520138,10514149,10515149,			--��������90+װ��
									10521149,10522149,10523149,10522138,10523138,			----��������90+װ��
									10206023,10206024,10206025,10206026,10206027,10206028,10206029,10206030,10406006,10306004,10306005, --����װ��
									10306006,10306007,10306008,10306009,10306010,10306011,10306012,10306013,10306014,10306015,10306016,10306017,10306018,	--����װ��
									10306019,10306020,10306021,10306022,10306023,10306024,10306025,10306026,10306027,10306028,10306029,10306030,10306031,	--����װ��
									10306032,10306033,10306034,10306035,10306036,10306037,10306038,10306039,10306040,10306041,					--����װ��
									10510139,10511139,10512139,10513139,		--����100װ��
									--kk ����¥
									10410149,10410150,10410151,10410152,
									10411101,10411102,10411103,10411104,
									10412097,10412098,10412099,10412100,
									10413102,10413103,10413104,10413105,
									10414055,10414056,10414057,10414058,
									10421092,10421093,10421094,10421095,
		}
local g_EquipBaoshiCheck_Stiletto_four_80_ID = {
	10200018,10201018,10202018,10203018,10204018,10205018,10210018,10210038,10210058,10211018,
	10211038,10211058,10212018,10212038,10212058,10213018,10213038,10213058,10214018,10215018,
	10220019,10221019,10222019,10222033,10222034,10223019,10223033,10223034,10300004,10300006,
	10301000,10301198,10302004,10302006,10302008,10302010,10303000,10304004,10304006,10304008,
	10305004,10305006,10305008,10410025,10410033,10414841,10414842,10414843,10414844,10414851,
	10414852,10414853,10414854,10414861,10414862,10414863,10414864,10415841,10415842,10415843,
	10415844,10415851,10415852,10415853,10415854,10415861,10415862,10415863,10415864,10421841,
	10421842,10421843,10421844,10421851,10421852,10421853,10421854,10421861,10421862,10421863,
	10421864,10510017,10510047,10510077,10511007,10511037,10511067,10511117,10512017,10512047,
	10512077,10514007,10514017,10514037,10514047,10514067,10514077,10514117,10515027,10515057,
	10515087,10520027,10520057,10520087,10521007,10521017,10521027,10521037,10521047,10521057,
	10521067,10521077,10521087,10521117,10522007,10522037,10522067,10522117,10523017,10523047,
	10523077,10552027,10552057,10552087,10553007,10553027,10553037,10553057,10553067,10553087,
	10553117,10400075,10402075,10404072,10405071,10412081,10412083,10413084,10413086,10422122,
	10422124,10423047,10423049,10510092,10510093,10510094,10510095,10511094,10511095,10512090,
	10512091,10514101,10514102,10514103,10514104,10522099,10522100,10523099,10523100,10510120,
	10510121,10510122,10510123,10511120,10511121,10511122,10511123,10512120,10512121,10512122,
	10512123,10522120,10522121,10522122,10522123,10523120,10523121,10523122,10523123,
	10510137,10512137,10514137,10521137,10523137,		--��������װ��
	}
--- װ���Ƿ��ܴ���ĸ���
function EquipBaoshiCheck_Can_Stiletto_Four( itemTableIndex, isDark, isHxy )
    if( isDark == 1) then
        return 1
		end
		
		if( isHxy == 1 ) then
			return 1
		end

    --- 90+װ��
    for i, v in g_EquipBaoshiCheck_Stiletto_four_ID do
		if itemTableIndex == v then
            return 1
		end
	end
    --- 80~89��װ��
	for i, v in g_EquipBaoshiCheck_Stiletto_four_80_ID do
	    if itemTableIndex == v then
	        return 1
	    end
	end
    return 0
end

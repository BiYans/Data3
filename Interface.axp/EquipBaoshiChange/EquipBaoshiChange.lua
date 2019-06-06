--- ����Ƕ
--- Author: David Gao 2012.08.13

local g_EquipBaoshiChange_SERVER_CONTROL_1 = 2012081301   --- һ������ʯʹ�ý���
local g_EquipBaoshiChange_Frame_UnifiedPosition
local g_EquipBaoshiChange_ObjCared = -1

local g_EquipBaoshiChange_Container_Gems = {}    --- װ��λ�ϵı�ʯ
local g_EquipBaoshiChange_Container_Info = {}    --- װ��λ�ϵı�ʯ����
local g_EquipBaoshiChange_Container_Animates = {}    --- װ��λ�ϵĶ���

local g_EquipBaoshiChange_Equip_Gems     = {}    --- װ���ϵı�ʯ
local g_EquipBaoshiChange_Equip_Info     = {}    --- װ���ϵı�ʯ����

local g_EquipBaoshiChange_NeedHint       = 0     --- �Ƿ���Ҫ��ʾ

local g_EquipBaoshiChange_Equip_TypeList =
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
	[17] = { name="#{BHZB_140521_241}", gemConIndex=16, equipIndex=20, },    --- ���� 
	[18] = { name="#{HXYSJ_141031_131}", gemConIndex=17, equipIndex=21, },    --- ����ӡ
}

--�����ͼƬ�ز�
local g_EquipBaoshiChange_UnActived_Image  = "set:Agname3 image:BaoShiCheckFeng"    --- δ���
local g_EquipBaoshiChange_Actived_Image    = "set:UIIcons image:Equip_Ring"      --- ��ʱʹ����Ԫ�����ͼƬ

local g_EquipBaoshiChange_WanbaoXiangqian_Fu = 30900125     --- ����Ƕ��ID

function EquipBaoshiChange_PreLoad()
    this:RegisterEvent("EQUIP_BAOSHI_CHANGE");
    this:RegisterEvent("RESUME_ENCHASE_GEM");
    this:RegisterEvent("UI_COMMAND");
    this:RegisterEvent("GEM_CONTAINER_REFRESH");
    this:RegisterEvent("REFRESH_EQUIP");

    this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("SCENE_TRANSED");
	this:RegisterEvent("ON_SCENE_TRANSING");
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

function EquipBaoshiChange_OnLoad()

	if SystemSetup:IsClassic() == 0 then	--���ͻ�����Ψ���棬����������ͼƬ�ز�ΪΨ����
		g_EquipBaoshiChange_UnActived_Image  = "set:WM_CommonFrame1 image:Feng"    --- δ���
		g_EquipBaoshiChange_Actived_Image    = "set:WM_Button2 image:Equip_Ring"      --- ��ʱʹ����Ԫ�����ͼ?
	end

    g_EquipBaoshiChange_Frame_UnifiedPosition = EquipBaoshiChange_Frame:GetProperty( "UnifiedPosition" )

    g_EquipBaoshiChange_Equip_Gems[1]     = EquipBaoshiChange_Special_Button1
    g_EquipBaoshiChange_Equip_Gems[2]     = EquipBaoshiChange_Special_Button2
    g_EquipBaoshiChange_Equip_Gems[3]     = EquipBaoshiChange_Special_Button3
    g_EquipBaoshiChange_Equip_Gems[4]     = EquipBaoshiChange_Special_Button4

    --- �����Լ���װ���ϵı�ʯ��Ϣ
    g_EquipBaoshiChange_Equip_Info =
    {
        isEquiped       = 0,  --- �Ƿ���װ��
        holeNum         = 0,  --- �����
        gemNum          = 0,  --- ����Ƕ��ʯ��Ŀ
        canStilettoFour = 1,  --- �ܷ����Ŀ�
        equipPoint      = -1, --- װ��������
        containerPos    = -1, --- װ��λ������
        gemInfo         =     --- �Ѿ���Ƕ�ı�ʯ��Ϣ
        {
            [1] = { gemIndex = 0, gemType = -1, },
            [2] = { gemIndex = 0, gemType = -1, },
            [3] = { gemIndex = 0, gemType = -1, },
            [4] = { gemIndex = 0, gemType = -1, },
        },
    }

    g_EquipBaoshiChange_Container_Gems[1] = EquipBaoshiChange_Special_Button6
    g_EquipBaoshiChange_Container_Gems[2] = EquipBaoshiChange_Special_Button7
    g_EquipBaoshiChange_Container_Gems[3] = EquipBaoshiChange_Special_Button8
    g_EquipBaoshiChange_Container_Gems[4] = EquipBaoshiChange_Special_Button9

    g_EquipBaoshiChange_Container_Animates[1] = BaoShiCheck1
    g_EquipBaoshiChange_Container_Animates[2] = BaoShiCheck2
    g_EquipBaoshiChange_Container_Animates[3] = BaoShiCheck3
    g_EquipBaoshiChange_Container_Animates[4] = BaoShiCheck4

    g_EquipBaoshiChange_Container_Info =
    {
        --- actionID, ����λ��, �Ƿ��Ѿ���Ƕ, ��ʯ����
        [1] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [2] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [3] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [4] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
    }

    EquipBaoshiChange_tishi   : SetText( "" )
    EquipBaoshiChange_static3 : SetText( "" )
    EquipBaoshiChange_static3 : Hide()
end

-- OnEvent
function EquipBaoshiChange_OnEvent(event)
    if ( event == "UI_COMMAND" ) and tonumber( arg0 ) == g_EquipBaoshiChange_SERVER_CONTROL_1 then
        if ( this : IsVisible() ) then
            this:Hide()
        end
        EquipBaoshiChange_Update()
        this : Show()
        g_EquipBaoshiChange_ObjCared = -1
        local xx = Get_XParam_INT( 0 )
        g_EquipBaoshiChange_ObjCared = DataPool : GetNPCIDByServerID( xx )
        if g_EquipBaoshiChange_ObjCared == -1 then
            return
        end
        EquipBaoshiChange_BeginCareObject( g_EquipBaoshiChange_ObjCared )
        --- �Ƿ��ǵ�һ�δ�
        local isFirstOpen = Get_XParam_INT( 1 )
        --- ����ǵ�һ�δ򿪣���Ҫ����ָ��
        if isFirstOpen == 0 then
            EquipBaoshiChange_OpenFreshManGuide()
        end
    elseif ( event == "UI_COMMAND" ) and tonumber( arg0 ) == 2012081302 then
        if ( this : IsVisible() ) then
            EquipBaoshiChange_EquipSel( )
        end
    elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if(tonumber(arg0) ~= g_EquipBaoshiChange_ObjCared) then
			return;
		end

		--�����NPC�ľ������һ��������߱�ɾ�����Զ��ر�
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
		    --ȡ������
    		EquipBaoshiChange_OnClosed()
		end
    elseif ( event == "EQUIP_BAOSHI_CHANGE" ) then
        local type    = tostring( arg0 )
        local bagIdx  = tonumber( arg1 )
        local conIdx1 = tonumber( arg2 )
        local conIdx2 = tonumber( arg3 )
        EquipBaoshiChange_PutInGem( type, bagIdx, conIdx1, conIdx2 )
    elseif ( event == "RESUME_ENCHASE_GEM" ) then
		if arg0 ~= nil then
            arg0 = arg0 - 110
            EquipBaoshiChange_Resume( arg0 )
		end
    elseif ( event == "GEM_CONTAINER_REFRESH" ) then
        if ( this : IsVisible() ) then
            EquipBaoshiChange_EquipSel( )
        end
    elseif ( event == "REFRESH_EQUIP" ) then
        if ( this:IsVisible() ) then
            EquipBaoshiChange_EquipSel( )
        end
	elseif event == "PLAYER_LEAVE_WORLD"  then
		if( this:IsVisible() ) then
            EquipBaoshiChange_OnClosed()
		end
	elseif event == "SCENE_TRANSED"  then
		if( this:IsVisible() ) then
            EquipBaoshiChange_OnClosed()
		end
	elseif event == "ON_SCENE_TRANSING"  then
		if( this:IsVisible() ) then
            EquipBaoshiChange_OnClosed()
		end
	elseif (event == "ADJEST_UI_POS" ) then
		EquipBaoshiChange_On_ResetPos()
	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipBaoshiChange_On_ResetPos()
	end
end

function EquipBaoshiChange_Update(  )
    --- ����װ�������б�
    EquipBaoshiChange_zhuangbeixiala : ResetList ()
    for i = 1, table.getn( g_EquipBaoshiChange_Equip_TypeList ) do
        EquipBaoshiChange_zhuangbeixiala : AddTextItem( g_EquipBaoshiChange_Equip_TypeList[i].name, i - 1 )
    end
    --- Ĭ��ѡ�е�һ��
    EquipBaoshiChange_zhuangbeixiala : SetCurrentSelect( 0 )
    EquipBaoshiChange_EquipSel( )
end

function EquipBaoshiChange_EquipSel( )
    EquipBaoshiChange_Clear()

    --- ת��Ϊѡ�����ĸ�װ��
    local _, curSel = EquipBaoshiChange_zhuangbeixiala : GetCurrentSelect( )
    if curSel == nil or curSel < 0 or curSel > table.getn( g_EquipBaoshiChange_Equip_TypeList ) then
        return
    end
    --- ע: �ؼ������Ǵ�0��ʼ��
    curSel = curSel + 1
    local curEquipIndex  = g_EquipBaoshiChange_Equip_TypeList[curSel].equipIndex
    local curGemConIndex = g_EquipBaoshiChange_Equip_TypeList[curSel].gemConIndex
    local updateRet      = LifeAbility : SplitWearedEquipGem_Update( curEquipIndex )
    local itemTblIdx     = LifeAbility : GetWearedEquip_ItemTableIndex( curEquipIndex )
    --- �Ƿ��ǰ���
    local bIsDark        = LifeAbility : IsWearedEquipDark( curEquipIndex )
    --- �Ƿ��Ǻ���ӡ
    local bIsHXY        = LifeAbility : IsWearedEquipHXY( curEquipIndex )
    --- ����װ������
    g_EquipBaoshiChange_Equip_Info.equipPoint   = curEquipIndex
    g_EquipBaoshiChange_Equip_Info.containerPos = curGemConIndex

    local ActionID, nItemID, gemTblIdx
    --- ��ʾװ���ϵı�ʯ
    if updateRet then
        local holeCount  = LifeAbility : GetWearedEquip_HoleCount( curEquipIndex )
        g_EquipBaoshiChange_Equip_Info.isEquiped = 1
        g_EquipBaoshiChange_Equip_Info.holeNum   = holeCount
        --- ��1~4�׽��б���
        for i = 1, 4 do
            nItemID = LifeAbility : GetSplitGem_Gem ( i-1 );

            --- ����б�ʯ
			if nItemID ~= -1 then
			    ActionID = DataPool:EnumPlayerMission_ItemAction( nItemID );
				g_EquipBaoshiChange_Equip_Gems[i] : SetActionItem( ActionID );
                gemTblIdx = LifeAbility : GetSplitGem_GemIndex ( i - 1 );

                --- ����װ������
                g_EquipBaoshiChange_Equip_Info.gemNum      = 1 + g_EquipBaoshiChange_Equip_Info.gemNum
                g_EquipBaoshiChange_Equip_Info.gemInfo[i].gemIndex = gemTblIdx
                g_EquipBaoshiChange_Equip_Info.gemInfo[i].gemType  = EquipBaoshiChange_GetGemTypeByIndex( gemTblIdx )
            --- û�б�ʯ
            else
                --- δ�����Ŀ���ʾ��ӡ״̬
                if i > holeCount then
                    g_EquipBaoshiChange_Equip_Gems[i] : SetActionItem( -1 );
                    g_EquipBaoshiChange_Equip_Gems[i] : SetToolTip( "#{WBSS_120727_40}" )   --- װ���ĸÿ�λδ����
                    g_EquipBaoshiChange_Equip_Gems[i] : SetProperty( "BackImage",  g_EquipBaoshiChange_UnActived_Image )
                    --- ���Ŀ������ж�
                    if i == 4 then
                        --- ����޷��������Ŀ�
                        if 0 == EquipBaoshiChange_Can_Stiletto_Four( itemTblIdx, bIsDark, bIsHXY ) then
                            g_EquipBaoshiChange_Equip_Gems[i] : SetToolTip( "#{WBSS_120727_41}" )   --- װ���޷��������Ŀ�
                            g_EquipBaoshiChange_Equip_Info.canStilettoFour = 0
                        end
                    end
                --- ����δ��Ƕ��ʯ���Ӧ���Ӵ���ʾ�ո���
                else
                    g_EquipBaoshiChange_Equip_Gems[i] : SetProperty( "BackImage",  g_EquipBaoshiChange_Actived_Image )
                    g_EquipBaoshiChange_Equip_Gems[i] : SetToolTip( "#{WBSS_120727_45}" )   --- �ÿ�λδ��Ƕ��ʯ
                end
            end
		end
        EquipBaoshiChange_static3 : SetText( "" )
        EquipBaoshiChange_static3 : Hide()
    --- ��ҵ�ǰ��û�д�ָ��װ��
    else
        g_EquipBaoshiChange_Equip_Info.isEquiped = 0
        for i = 1, 4 do
            g_EquipBaoshiChange_Equip_Gems[i] : Hide()
        end
        EquipBaoshiChange_static3 : SetText( "#{WBSS_120727_13}" )
        EquipBaoshiChange_static3 : Show()
    end

    --- ��ʾװ��λ�ϵı�ʯ
    LifeAbility : GemContainer_Update()
    for i = 1, 4 do
        local gemConGemIndex, tmpGemType
        nItemID, gemConGemIndex, tmpGemType = LifeAbility : GetGemContainer_Gem( curGemConIndex, i - 1 )
        if nItemID ~= -1 then
            ActionID = DataPool : EnumPlayerMission_ItemAction( nItemID )
            g_EquipBaoshiChange_Container_Gems[i] : SetActionItem( ActionID )
            g_EquipBaoshiChange_Container_Info[i].actionID  = ActionID
            g_EquipBaoshiChange_Container_Info[i].bagIndex  = -1
            g_EquipBaoshiChange_Container_Info[i].isAlreadyFixed = 1
            g_EquipBaoshiChange_Container_Info[i].gemType   = tmpGemType
            g_EquipBaoshiChange_Container_Gems[i] : SetProperty("DraggingEnabled","False")
            g_EquipBaoshiChange_Container_Animates[i] : Hide()
        else
            g_EquipBaoshiChange_Container_Gems[i] : SetActionItem( -1 )
            g_EquipBaoshiChange_Container_Gems[i] : SetToolTip( "#{WBSS_120727_42}" )   --- �ÿ�λ����Ƕ��ʯ
            g_EquipBaoshiChange_Container_Info[i].actionID  = -1
            g_EquipBaoshiChange_Container_Info[i].bagIndex  = -1
            g_EquipBaoshiChange_Container_Info[i].isAlreadyFixed = 0
            g_EquipBaoshiChange_Container_Info[i].gemType   = -1
            g_EquipBaoshiChange_Container_Animates[i] : Hide()
        end
    end

    --- ������ʾ��Ϣ����ʾ
    EquipBaoshiChange_UpdateHints( curSel )
end

function EquipBaoshiChange_Clear(  )
    for i = 1, 4 do
        local bagIndex = g_EquipBaoshiChange_Container_Info[i].bagIndex
        if bagIndex >= 0 then
            LifeAbility : Lock_Packet_Item( bagIndex, 0 )
        end
    end

    for i=1, 4 do
        g_EquipBaoshiChange_Equip_Gems[i]     : SetActionItem( -1 )
        g_EquipBaoshiChange_Equip_Gems[i]     : Show()
        g_EquipBaoshiChange_Container_Gems[i] : SetActionItem( -1 )
        g_EquipBaoshiChange_Container_Gems[i] : Show()
        g_EquipBaoshiChange_Container_Gems[i] : SetProperty("DraggingEnabled","True")
        g_EquipBaoshiChange_Container_Animates[i] : Hide()
    end

    g_EquipBaoshiChange_Container_Info =
    {
        [1] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [2] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [3] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
        [4] = { actionID = -1, bagIndex = -1, isAlreadyFixed = 0, gemType = -1, },
    }

    g_EquipBaoshiChange_Equip_Info =
    {
        isEquiped       = 0,  --- �Ƿ���װ��
        holeNum         = 0,  --- �����
        gemNum          = 0,  --- ����Ƕ��ʯ��Ŀ
        canStilettoFour = 1,  --- �ܷ����Ŀ�
        equipPoint      = -1, --- װ����װ��λ��Ϣ
        gemInfo         =     --- �Ѿ���Ƕ�ı�ʯ��Ϣ
        {
            [1] = { gemIndex = 0, gemType = -1, },
            [2] = { gemIndex = 0, gemType = -1, },
            [3] = { gemIndex = 0, gemType = -1, },
            [4] = { gemIndex = 0, gemType = -1, },
        },
    }

    EquipBaoshiChange_tishi   : SetText( "" )
    EquipBaoshiChange_static3 : SetText( "" )
    EquipBaoshiChange_static3 : Hide()

    g_EquipBaoshiChange_NeedHint = 0
end

function EquipBaoshiChange_OnClosed()
    EquipBaoshiChange_Clear(  )
    this:Hide()
    PushEvent( "CLOSE_FRESHMAN_GUIDE" )
    return
end

function EquipBaoshiChange_On_ResetPos()
    EquipBaoshiChange_Frame:SetProperty( "UnifiedPosition", g_EquipBaoshiChange_Frame_UnifiedPosition )
    return
end

--- ������Ҽ�����
function EquipBaoshiChange_Handle_RClicked( bagIdx, equipPoint, gemConIndex, typeListIndex )

	--���ڸ��ʯ
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( bagIdx )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_53}")
		return
	end

    local gemIndex = PlayerPackage : GetItemTableIndex( bagIdx )
    local gem_type = LifeAbility : Get_Gem_Level( bagIdx, 2 )
    --- 1. �жϵ�ǰ�ı�ʯ�����Ƿ������Ƕ����װ��λ��
    if 0 == EquipBaoshiChange_Can_Gem_BePutIn( gem_type, equipPoint ) then
        local gemName = LifeAbility : Get_GemName( bagIdx )
        --- %S0װ��λ���޷���Ƕ%S1
        local strText = ScriptGlobal_Format( "#{WBSS_120727_55}", g_EquipBaoshiChange_Equip_TypeList[typeListIndex].name, gemName )
        PushDebugMessage( strText ) --- ������δ����������Ƕ����������X�����޷�ͬʱ��ǶX����ʯ
        return
    end

    --- 1. �жϵ�ǰװ��λ�Ƿ���ʣ��Ŀ�λ
    local firstThreeNum = 0
    local isExistSameType = 0
    for i = 1, 3 do
        --- ��¼�ж��ٿ�λ
        if g_EquipBaoshiChange_Container_Info[i].actionID ~= -1 then
            firstThreeNum = firstThreeNum + 1
        end
        --- �Ƿ���ͬ���ͱ�ʯ
        if g_EquipBaoshiChange_Container_Info[i].gemType == gem_type then
            isExistSameType = 1
        end
    end

    --- 2. �ж��ܷ������ĸ���λ
    local canBeInForthHole = EquipBaoshiChange_Can_BePutInForthHole( gemIndex )

    --- 3. ǰ3����λ����
    if firstThreeNum >= 3 then
        --- ���ĸ���λҲ����
        if g_EquipBaoshiChange_Container_Info[4].actionID ~= -1 then
            PushDebugMessage( "#{WBSS_120727_56}" )     --- ��ǰװ��λû��ʣ���λ�����������Ƕ�ı�ʯ���Ƚ�����ժ��
            return
        else
            --- �ж��ܷ������ĸ���λ
            if canBeInForthHole == 0 then
                PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
                return
            else
                --- �������ڿ��Է�����Ŀ���
                local theActionItem = EnumAction( bagIdx, "packageitem" )
                g_EquipBaoshiChange_Container_Gems[4] : SetActionItem( theActionItem:GetID() )
                LifeAbility:Lock_Packet_Item( bagIdx, 1 )
                g_EquipBaoshiChange_Container_Info[4].actionID  = theActionItem:GetID()
                g_EquipBaoshiChange_Container_Info[4].bagIndex  = bagIdx
                g_EquipBaoshiChange_Container_Info[4].isAlreadyFixed = 0
                g_EquipBaoshiChange_Container_Info[4].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 )
                g_EquipBaoshiChange_Container_Animates[4] : Show()
                return
            end
        end
    end

    --- 4. �ж�ǰ�������Ƿ���ͬ���͵ı�ʯ
    if isExistSameType == 1 then
        --- ��������жϣ�Ϊ������߻�����
        if g_EquipBaoshiChange_Container_Info[4].actionID ~= -1 then
                PushDebugMessage( "#{WBSS_120727_58}" )     --- ǰ�������޷���Ƕͬ���ͱ�ʯ
                return
        end

        --- ���ܷ�����Ŀ�
        if canBeInForthHole == 0 then
            PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
            return
        --- ������Ŀ�
        else
            --- ���ĸ���λҲ����
            if g_EquipBaoshiChange_Container_Info[4].actionID ~= -1 then
                PushDebugMessage( "#{WBSS_120727_58}" )     --- ǰ�������޷���Ƕͬ���ͱ�ʯ
                return
            else
                --- �������ڿ��Է�����Ŀ���
                local theActionItem = EnumAction( bagIdx, "packageitem" )
                g_EquipBaoshiChange_Container_Gems[4] : SetActionItem( theActionItem:GetID() )
                LifeAbility:Lock_Packet_Item( bagIdx, 1 )
                g_EquipBaoshiChange_Container_Info[4].actionID  = theActionItem:GetID()
                g_EquipBaoshiChange_Container_Info[4].bagIndex  = bagIdx
                g_EquipBaoshiChange_Container_Info[4].isAlreadyFixed = 0
                g_EquipBaoshiChange_Container_Info[4].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 )
                g_EquipBaoshiChange_Container_Animates[4] : Show()
            end
        end
    --- ǰ������û��ͬ���͵ı�ʯ
    else
        --- ����������ͬ���ͱ�ʯ��λ����Ƕ
        for i = 1, 3 do
            if g_EquipBaoshiChange_Equip_Info.gemInfo[i].gemType == gem_type and g_EquipBaoshiChange_Container_Info[i].actionID == -1  then
                local theActionItem = EnumAction( bagIdx, "packageitem" )
                g_EquipBaoshiChange_Container_Gems[i] : SetActionItem( theActionItem:GetID() )
                LifeAbility:Lock_Packet_Item( bagIdx, 1 )
                g_EquipBaoshiChange_Container_Info[i].actionID  = theActionItem:GetID()
                g_EquipBaoshiChange_Container_Info[i].bagIndex  = bagIdx
                g_EquipBaoshiChange_Container_Info[i].isAlreadyFixed = 0
                g_EquipBaoshiChange_Container_Info[i].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 )
                g_EquipBaoshiChange_Container_Animates[i] : Show()
                return
            end
        end

        --- ���û�У�����Ҹ���λ�÷�
        for i = 1, 3 do
            if g_EquipBaoshiChange_Container_Info[i].actionID == -1 then
                local theActionItem = EnumAction( bagIdx, "packageitem" )
                g_EquipBaoshiChange_Container_Gems[i] : SetActionItem( theActionItem:GetID() )
                LifeAbility:Lock_Packet_Item( bagIdx, 1 )
                g_EquipBaoshiChange_Container_Info[i].actionID  = theActionItem:GetID()
                g_EquipBaoshiChange_Container_Info[i].bagIndex  = bagIdx
                g_EquipBaoshiChange_Container_Info[i].isAlreadyFixed = 0
                g_EquipBaoshiChange_Container_Info[i].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 )
                g_EquipBaoshiChange_Container_Animates[i] : Show()
                break
            end
        end
    end
end
--- ����Ǵӱ�����ק��װ��λ
function EquipBaoshiChange_Handle_Drag( bagIdx, equipPoint, gemConIndex, typeListIndex, conIdx1, conIdx2 )
	--���ڸ��ʯ
	local bBP_Gem = BudgetPlanGem: IsBudgetPlanGem( bagIdx )
	if bBP_Gem > 0 then
		PushDebugMessage("#{FQBS_140508_53}")
		return
	end

    --- �õ���Ӧ�Ŀؼ�����
    local btnIndex = conIdx1 - 115
    if btnIndex < 1 or btnIndex > 4 then
        return
    end

    --- �жϵ�ǰ�ı�ʯ�����Ƿ������Ƕ����װ��λ��
    local gemIndex = PlayerPackage : GetItemTableIndex( bagIdx )
    local gem_type = LifeAbility : Get_Gem_Level( bagIdx, 2 )
    if 0 == EquipBaoshiChange_Can_Gem_BePutIn( gem_type, equipPoint ) then
        local gemName = LifeAbility : Get_GemName( bagIdx )
        --- %S0װ��λ���޷���Ƕ%S1
        local strText = ScriptGlobal_Format( "#{WBSS_120727_55}", g_EquipBaoshiChange_Equip_TypeList[typeListIndex].name, gemName )
        PushDebugMessage( strText ) --- ������δ����������Ƕ����������X�����޷�ͬʱ��ǶX����ʯ

        return
    end

    --- �Ƿ�����ǰ��������
    local isTryPutFirstThree = 0
    if btnIndex >= 1 and btnIndex <= 3 then
        --- �Ƿ��ǰ���ֱ�ʯͬ������
        if 1 == EquipBaoshiChange_Is_FristThree_Have_SameType( gem_type, btnIndex ) then
            PushDebugMessage( "#{WBSS_120727_58}" )         --- ǰ�������޷���Ƕͬ���ͱ�ʯ
            return
        end
    --- �����Ŀ�����
    else
        local canBeInForthHole = EquipBaoshiChange_Can_BePutInForthHole( gemIndex )
        if canBeInForthHole == 0 then
            PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
            return
        end
    end

    --- ����ǣ���ק���Ѿ���Ƕ��ʯ��װ��λ��λ
    if g_EquipBaoshiChange_Container_Info[btnIndex].isAlreadyFixed == 1 then
        PushDebugMessage( "#{WBSS_120727_51}" )         --- Ŀ���λ�Ѿ���Ƕ�˱�ʯ
        return
    end

    --- ����ǿ�λ
    if g_EquipBaoshiChange_Container_Info[btnIndex].actionID < 0 then
        local theActionItem = EnumAction( bagIdx, "packageitem" )
        if theActionItem:GetID() ~= 0 then
            --- �����ÿؼ�
            LifeAbility : Lock_Packet_Item( bagIdx, 1 )
            g_EquipBaoshiChange_Container_Gems[btnIndex] : SetActionItem( theActionItem:GetID() )
            g_EquipBaoshiChange_Container_Animates[btnIndex] : Show()
            --- ���û��������
            g_EquipBaoshiChange_Container_Info[btnIndex].actionID  = theActionItem:GetID()
            g_EquipBaoshiChange_Container_Info[btnIndex].bagIndex  = bagIdx
            g_EquipBaoshiChange_Container_Info[btnIndex].isAlreadyFixed = 0
            g_EquipBaoshiChange_Container_Info[btnIndex].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 );
        end
        return
    --- ����Ѿ��������ʯ
    else
        local theActionItem = EnumAction( bagIdx, "packageitem" )
        if theActionItem:GetID() ~= 0 then
            --- �����ÿؼ�
            --- �Ȱ�ԭ���ɺ���ͷ�
            LifeAbility:Lock_Packet_Item( g_EquipBaoshiChange_Container_Info[btnIndex].bagIndex, 0 )
            --- ����ס�µ�
            LifeAbility:Lock_Packet_Item( bagIdx, 1 )
            g_EquipBaoshiChange_Container_Gems[btnIndex] : SetActionItem( theActionItem:GetID() )
            g_EquipBaoshiChange_Container_Animates[btnIndex] : Show()
            --- ���û��������
            g_EquipBaoshiChange_Container_Info[btnIndex].actionID  = theActionItem:GetID()
            g_EquipBaoshiChange_Container_Info[btnIndex].bagIndex  = bagIdx
            g_EquipBaoshiChange_Container_Info[btnIndex].isAlreadyFixed = 0
            g_EquipBaoshiChange_Container_Info[btnIndex].gemType   = LifeAbility : Get_Gem_Level( bagIdx, 2 );
        end
        return
    end

end
--- ����Ǵӱ�����ק��װ��λ
function EquipBaoshiChange_Handle_Switch( bagIdx, equipPoint, gemConIndex, typeListIndex, conIdx1, conIdx2 )
    --- �õ���Ӧ�Ŀؼ�����
    local srcBtnIndex = conIdx1 - 115
    local dstBtnIndex = conIdx2 - 115
    if srcBtnIndex < 1 or srcBtnIndex > 4 or dstBtnIndex < 1 or dstBtnIndex > 4 or srcBtnIndex == dstBtnIndex then
        return
    end

    --- Դλ�����Ѿ���Ƕ��
    if g_EquipBaoshiChange_Container_Info[srcBtnIndex].isAlreadyFixed == 1 then
        return
    end

    --- Ŀ��λ�����Ѿ���Ƕ��
    if g_EquipBaoshiChange_Container_Info[dstBtnIndex].isAlreadyFixed == 1 then
        PushDebugMessage( "#{WBSS_120727_51}" )         --- Ŀ���λ�Ѿ���Ƕ�˱�ʯ
        return
    end

    --- Ŀ��λ���ǿ�λ
    if g_EquipBaoshiChange_Container_Info[dstBtnIndex].actionID < 0 then
        --- Ŀ���ǵ��Ŀ�
        if dstBtnIndex == 4 then
            local srcBagIdx = g_EquipBaoshiChange_Container_Info[srcBtnIndex].bagIndex
            local gemIndex  = PlayerPackage : GetItemTableIndex( srcBagIdx )
            if EquipBaoshiChange_Can_BePutInForthHole( gemIndex ) == 0 then
                PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
                return
            end
        end

        local dstActionID = g_EquipBaoshiChange_Container_Info[srcBtnIndex].actionID
        local dstBagIdx   = g_EquipBaoshiChange_Container_Info[srcBtnIndex].bagIndex
        local dstGemType  = g_EquipBaoshiChange_Container_Info[srcBtnIndex].gemType

        --- �Ƿ���������ͬ���ı�ʯ
        for i = 1, 3 do
            if i ~= srcBtnIndex and g_EquipBaoshiChange_Container_Info[i].gemType == dstGemType then
                PushDebugMessage( "#{WBSS_120727_58}" )     --- ǰ�������޷���Ƕͬ���ͱ�ʯ
                return
            end
        end

        --- ������Ŀ������
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].actionID  = dstActionID
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].bagIndex  = dstBagIdx
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].isAlreadyFixed = 0
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].gemType   = dstGemType
        --- ����Ŀ��ؼ�
        g_EquipBaoshiChange_Container_Gems[dstBtnIndex] : SetActionItem( dstActionID )
        g_EquipBaoshiChange_Container_Animates[dstBtnIndex] : Show()
        --- ������Դ����
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].actionID  = -1
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].bagIndex  = -1
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].isAlreadyFixed = 0
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].gemType   = -1
        --- ����Դ�ؼ�
        g_EquipBaoshiChange_Container_Gems[srcBtnIndex] : SetActionItem( -1 )
        g_EquipBaoshiChange_Container_Animates[srcBtnIndex] : Hide()

        return
    --- Ŀ��λ���б�ʯ
    else
        local dstActionID = g_EquipBaoshiChange_Container_Info[srcBtnIndex].actionID
        local dstBagIdx   = g_EquipBaoshiChange_Container_Info[srcBtnIndex].bagIndex
        local dstGemType  = g_EquipBaoshiChange_Container_Info[srcBtnIndex].gemType
        local dstGemIndex = PlayerPackage : GetItemTableIndex( dstBagIdx )

        local srcActionID = g_EquipBaoshiChange_Container_Info[dstBtnIndex].actionID
        local srcBagIdx   = g_EquipBaoshiChange_Container_Info[dstBtnIndex].bagIndex
        local srcGemType  = g_EquipBaoshiChange_Container_Info[dstBtnIndex].gemType
        local srcGemIndex = PlayerPackage : GetItemTableIndex( srcBagIdx )

        --- �Ƿ�������Ŀ��Ͻ���
        --- ����Ǵӵ��Ŀ��������Ŀ���
        if srcBtnIndex == 4 then
            --- Ŀ���Ƿ�����Ƕ�ڵ��Ŀ�
            if EquipBaoshiChange_Can_BePutInForthHole( srcGemIndex ) == 0 then
                PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
                return
            end
            --- Դ�Ƿ������������׵�ͬ����
            for i = 1, 3 do
                if i ~= dstBtnIndex and g_EquipBaoshiChange_Container_Info[i].gemType == dstGemType then
                    PushDebugMessage( "#{WBSS_120727_58}" )     --- ǰ�������޷���Ƕͬ���ͱ�ʯ
                    return
                end
            end

            --- ����Ǵ������ĵط������Ŀ���
        elseif dstBtnIndex == 4 then
            --- Դ��ʯ�ܷ���Ƕ�ڵ��Ŀ�
            if EquipBaoshiChange_Can_BePutInForthHole( dstGemIndex ) == 0 then
                PushDebugMessage( "#{WBSS_120727_57}" )     --- ���Ŀ��޷���ǶѪ��ʯ�ͺ챦ʯ
                return
            end
            --- Ŀ���Ƿ������������׵�ͬ����
            for i = 1, 3 do
                if i ~= srcBtnIndex and g_EquipBaoshiChange_Container_Info[i].gemType == srcGemType then
                    PushDebugMessage( "#{WBSS_120727_58}" )     --- ǰ�������޷���Ƕͬ���ͱ�ʯ
                    return
                end
            end
        end

        --- ������Ŀ������
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].actionID  = dstActionID
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].bagIndex  = dstBagIdx
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].isAlreadyFixed = 0
        g_EquipBaoshiChange_Container_Info[dstBtnIndex].gemType   = dstGemType
        --- ����Ŀ��ؼ�
        g_EquipBaoshiChange_Container_Gems[dstBtnIndex] : SetActionItem( dstActionID )
        g_EquipBaoshiChange_Container_Animates[dstBtnIndex] : Show()
        --- ������Դ����
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].actionID  = srcActionID
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].bagIndex  = srcBagIdx
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].isAlreadyFixed = 0
        g_EquipBaoshiChange_Container_Info[srcBtnIndex].gemType   = srcGemType
        --- ����Դ�ؼ�
        g_EquipBaoshiChange_Container_Gems[srcBtnIndex] : SetActionItem( srcActionID )
        g_EquipBaoshiChange_Container_Animates[srcBtnIndex] : Show()

        return
    end
end

--- TODO: �������������Ҫ�ع�, ��̫���ˣ���������Ū
--- �����conIdx��116��117��118��119���ֱ��Ӧ��1��2��3��4���ؼ�
function EquipBaoshiChange_PutInGem( type, bagIdx, conIdx1, conIdx2 )
    if type == nil or bagIdx == nil or conIdx1 == nil or conIdx2 == nil then
        return
    end

    --- �Ƿ�����Чװ��
    local equipPoint = g_EquipBaoshiChange_Equip_Info.equipPoint
    if equipPoint == -1 or equipPoint == 8 or equipPoint == 9 or equipPoint == 10 or equipPoint == 16 then
		return
    end

    local gemConIndex   = g_EquipBaoshiChange_Equip_Info.containerPos
    --- �õ���TypeList���������
    local typeListIndex = 1
    for i = 1, table.getn( g_EquipBaoshiChange_Equip_TypeList ) do
        if g_EquipBaoshiChange_Equip_TypeList[i].gemConIndex == gemConIndex then
            typeListIndex = i
            break
        end
    end

    --- ������Ҽ�����
    if type == "RClicked" then
        EquipBaoshiChange_Handle_RClicked( bagIdx, equipPoint, gemConIndex, typeListIndex )
    elseif type == "Drag" then
        --- ������б�Ҫ�����£���ͬ��װ��λ֮����������ק�ģ���������ط�װ��λ������ק�ı�ʯ��Container������CT_GEM_CONTAINER��
        --- ����Package����������Ƚ���
        --- �ж���ק�ı�ʯ��bagIndex�����֮ǰ�Ѿ�������ˣ�˵���Ѿ�������װ��λ���ˣ�����װ��λ��֮�����ק
        --- ������Ǵӱ�������ק��װ��λ��
        local preSel = -1
        for i = 1, 4 do
            if g_EquipBaoshiChange_Container_Info[i].bagIndex == bagIdx then
                preSel = i
                break
            end
        end

        --- ����Ǵӱ�����ק��װ��λ
        if preSel == -1 then
            EquipBaoshiChange_Handle_Drag( bagIdx, equipPoint, gemConIndex, typeListIndex, conIdx1, conIdx2 )
        --- �������װ��λ֮����ק
        else
            EquipBaoshiChange_Handle_Switch( bagIdx, equipPoint, gemConIndex, typeListIndex, preSel + 115, conIdx1 )
        end

    else
        return
    end

    --- ������ʾ��Ϣ
    EquipBaoshiChange_UpdateHints( typeListIndex )

    g_EquipBaoshiChange_NeedHint = 0

    return
end

function EquipBaoshiChange_SetHints()

end

function EquipBaoshiChange_OK_Clicked()
    --- �жϵ绰�ܱ��Ͷ������뱣��
	if CheckPhoneMibaoAndMinorPassword() ~= 1 then
		return
	end
	--- �ж��Ƿ�Ϊ��ȫʱ��
	if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
		PushDebugMessage("#{OR_PILFER_LOCK_FLAG}")
		return
	end

    --- �ж���ҵȼ��Ƿ���ڵ���90��
    local level = Player : GetData( "LEVEL" )
    if level < 90 then
        PushDebugMessage( "#{WBSS_120727_60}" ) --- ֻ�еȼ����ڵ���90������Ҳ��ܽ��д˲���
        return
    end

    --- �ж�����Ƿ��Ѿ�ѧϰ��������
    if 0 == EquipBaoshiChange_Is_Learned_Skill() then
        PushDebugMessage( "#{WBSS_120727_61}" ) --- ֻ��ѧϰ�����������Ҳ��ܽ��д˲���
        return
    end

    --- �жϵ�ǰװ��λ�Ƿ���ѡ��
    if g_EquipBaoshiChange_Equip_Info.equipPoint == -1 then
        PushDebugMessage( "#{WBSS_120727_62}" ) --- ����ѡ����Ҫ��������Ƕ��װ��λ
        return
    end

    --- �жϵ�ǰ�Ƿ��з�����Ƕ�ı�ʯ
    local putGemNum = 0
    local curAlreadyFixed = 0
    for i = 1, 4 do
        if g_EquipBaoshiChange_Container_Info[i].isAlreadyFixed == 0 then
            if g_EquipBaoshiChange_Container_Info[i].bagIndex >= 0 then
                putGemNum = putGemNum + 1
            end
        else
            curAlreadyFixed = curAlreadyFixed + 1
        end
    end
    if curAlreadyFixed == 4 then
        PushDebugMessage( "#{WBSS_120727_99}" )     --- װ��λ����Ƕ4�ű�ʯ�����������ʯ���Ƚ�����ժ��
        return
    end

    if putGemNum <= 0 then
        PushDebugMessage( "#{WBSS_120727_63}" ) --- �������Ҫ��Ƕ�ı�ʯ
        return
    end

    --- ����������ж��ˣ�֮ǰ���뱦ʯ��ʱ�������Ѿ��жϹ���
    --- �ж�ǰ�����Ƿ���ͬ���ͱ�ʯ
    --- �жϵ��Ŀ��Ƿ��к챦ʯ��Ѫ��ʯ

    --- �ж���Ұ�����δ����������Ƕ�������Ƿ���ڵ��ڷ���ı�ʯ����
    local curFuNum = PlayerPackage : CountAvailableItemByIDTable( g_EquipBaoshiChange_WanbaoXiangqian_Fu )
    if curFuNum < putGemNum then
        if putGemNum == 1 then
            PushDebugMessage("#{WBSS_120727_64}")       --- ������ȱ��δ����������Ƕ�����޷���������Ƕ
        else
            local strText = ScriptGlobal_Format( "#{WBSS_120727_65}", putGemNum, putGemNum )
            PushDebugMessage( strText ) --- ������δ����������Ƕ����������X�����޷�ͬʱ��ǶX����ʯ
        end
        return
    end

    if g_EquipBaoshiChange_NeedHint == 0 then
        PushEvent( "GAMELOGIN_SYSTEM_INFO_OK", "#{WBSS_120727_92}", "-1" )
        g_EquipBaoshiChange_NeedHint = 1
    else
        Clear_XSCRIPT();
	        Set_XSCRIPT_Function_Name( "PutGemInContainer" );
		    Set_XSCRIPT_ScriptID( 701614 );
    		Set_XSCRIPT_Parameter( 0, g_EquipBaoshiChange_Equip_Info.containerPos    );         --- װ��λ
	    	Set_XSCRIPT_Parameter( 1, g_EquipBaoshiChange_Container_Info[1].bagIndex );
		    Set_XSCRIPT_Parameter( 2, g_EquipBaoshiChange_Container_Info[2].bagIndex );
    		Set_XSCRIPT_Parameter( 3, g_EquipBaoshiChange_Container_Info[3].bagIndex );
	    	Set_XSCRIPT_Parameter( 4, g_EquipBaoshiChange_Container_Info[4].bagIndex );
		    Set_XSCRIPT_ParamCount( 5 );
        Send_XSCRIPT();
        g_EquipBaoshiChange_NeedHint = 0
    end

end

function EquipBaoshiChange_Cancel_Clicked()

    EquipBaoshiChange_OnClosed()
end

function EquipBaoshiChange_Resume( index )
    if index == nil or index < 6 or index > 9 then
        return
    end
    index =  index - 5
    local bagIndex = g_EquipBaoshiChange_Container_Info[index].bagIndex
    if bagIndex >= 0 then
        LifeAbility : Lock_Packet_Item( bagIndex, 0 )
    else
        --- ����ط��ı�ʯ�����Ѿ���Ƕ�ģ���������
        return
    end
    g_EquipBaoshiChange_Container_Gems[index] : SetActionItem( -1 )
    g_EquipBaoshiChange_Container_Animates[index] : Hide()

    g_EquipBaoshiChange_Container_Info[index].actionID       = -1
    g_EquipBaoshiChange_Container_Info[index].bagIndex       = -1
    g_EquipBaoshiChange_Container_Info[index].isAlreadyFixed = 0
    g_EquipBaoshiChange_Container_Info[index].gemType        = -1

    --- ������ʾ��Ϣ
    local typeListIndex = EquipBaoshiChange_GetTypeListIndex()
    EquipBaoshiChange_UpdateHints( typeListIndex )

    g_EquipBaoshiChange_NeedHint = 0

    return
end

-----------------------------------------------------------------------------------
--- ������Щȫ���Ǹ������� AuxFunc
-----------------------------------------------------------------------------------
--- ����Ƿ�ѧ����һ������ʯ����
function EquipBaoshiChange_Is_Learned_Skill()
    local gemSwitchSkillID = 278

	if( Player:GetSkillInfo( gemSwitchSkillID, "learn") ) then
        return 1
	else
        return 0
	end
end

--- ǰ���ױ�ʯ�Ƿ����ͬ������
function EquipBaoshiChange_Is_FristThree_Have_SameType( gem_type, srcIndex )
    for i = 1, 3 do
        if g_EquipBaoshiChange_Container_Info[i].gemType == gem_type and i ~= srcIndex then
            return 1
        end
    end
    return 0
end

--- ��ʯ�ܷ񱻷���װ��λ
--- װ����ʯ��Ƕ�߼�
local g_EquipBaoshiChange_EquipGemTable = {
    [0] = { 1, 2, 3, 4, 21 },
	[1] = { 11, 12, 13, 14 },
	[2] = { 11, 12, 13, 14 },
	[3] = { 11, 12, 13, 14 },
	[4] = { 11, 12, 13, 14 },
	[5] = { 11, 12, 13, 14 },
	[6] = { 1, 2, 3, 4, 21 },
	[7] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 },
	[11] = { 1, 2, 3, 4, 21 },
	[12] = { 1, 2, 3, 4, 21 },
	[13] = { 1, 2, 3, 4, 21 },
	[14] = { 1, 2, 3, 4, 21 },
	[15] = { 11, 12, 13, 14 },
	[17] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[18] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[19] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[20] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[21] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
}
function EquipBaoshiChange_Can_Gem_BePutIn( gem_type, equipPoint )
    local passFlag = 0
    for i, gt in g_EquipBaoshiChange_EquipGemTable[equipPoint] do
        if gt == gem_type then
            passFlag = 1
            return 1
        end
    end

    --- ���౦ʯ���ܷ��ڴ���װ��λ��
    if passFlag == 0 then
        return 0
    end

    return 1
end

--- �ܷ������Ŀ�
--- ���б�ʯ������Ƕ�ڵ��Ŀ���
local g_EquipBaoshiChange_GemEmbed_four_ID = {
    --- �챦ʯ
    50113004,50213004,50313004,50413004,50513004,50613004,50713004,50813004,50913004,
    --- Ѫ��ʯ
    50113006,50213006,50313006,50413006,50513006,50613006,50713006,50813006,50913006,
    --- �챦ʯ��ͨ��
	50313010,50413010,50513010,50613010,50713010,50813010,50913010,
	--- Ѫ��ʯ��ͨ��
	50313012,50413012,50513012,50613012,50713012,50813012,50913012,
    }
function EquipBaoshiChange_Can_BePutInForthHole( gem_Index )
    for i, gt in g_EquipBaoshiChange_GemEmbed_four_ID do
        if gem_Index == gt then
            return 0
        end
    end
    return 1
end

--- ��Ϊ���ж����Ƿ��ܴ��Ŀ�
local g_EquipBaoshiChange_Stiletto_four_ID = {

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
local g_EquipBaoshiChange_Stiletto_four_80_ID = {
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
function EquipBaoshiChange_Can_Stiletto_Four( itemTableIndex, isDark, isHXY )
    if( isDark == 1) then
        return 1
		end
		
		if( isHXY == 1) then
        return 1
		end

    --- 90+װ��
    for i, v in g_EquipBaoshiChange_Stiletto_four_ID do
		if itemTableIndex == v then
            return 1
		end
	end
    --- 80~89��װ��
	for i, v in g_EquipBaoshiChange_Stiletto_four_80_ID do
	    if itemTableIndex == v then
	        return 1
	    end
	end
    return 0
end

function EquipBaoshiChange_BeginCareObject( objCaredId )
	this:CareObject( objCaredId, 1, "EquipBaoshiChange");
end
function EquipBaoshiChange_StopCareObject( objCaredId )
	this:CareObject( objCaredId, 0, "EquipBaoshiChange");
end

--- ������Ʒ���к��������Ʒ������
function EquipBaoshiChange_GetGemTypeByIndex( itemTblIdx )
    if itemTblIdx == nil or itemTblIdx <= 0 then
        return -1
    end

    local tmpValue = math.mod( itemTblIdx, 100000 )
    local itemType = math.floor( tmpValue / 1000 )
    return itemType
end

function EquipBaoshiChange_Can_SwitchGem( curSel )
    local conPos     = g_EquipBaoshiChange_Equip_TypeList[curSel].gemConIndex
    local equipPoint = g_EquipBaoshiChange_Equip_TypeList[curSel].equipIndex

    --- �õ�װ���ϵı�ʯ
    local equipTypeList = {}
    if g_EquipBaoshiChange_Equip_Info.isEquiped <= 0 then
        return 1    --- û��װ��
    end
    for i = 1, 4 do
        equipTypeList[i] = g_EquipBaoshiChange_Equip_Info.gemInfo[i].gemType
    end

    --- ��εõ�װ��λ�ϵı�ʯ����
    local gemConTypeList  = { }
    local bHaveGemCon     = 0       --- װ��λ���Ƿ��б�ʯ
    for i = 1, 4 do
        gemConTypeList[i] = g_EquipBaoshiChange_Container_Info[i].gemType
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


--- ��Ϣ��ʾ�������ʾ
function EquipBaoshiChange_UpdateHints( typeListIndex )
    local ret = EquipBaoshiChange_Can_SwitchGem( typeListIndex )
    if ret == 1 then
        EquipBaoshiChange_tishi : SetText( "#{WBSS_120727_15}" )      --- װ��λ����װ��ʱ����Ƕ���޷�������������
    elseif ret == 2 then --- ������ֵ�
        EquipBaoshiChange_tishi : SetText( "#{WBSS_120727_98}" )      --- װ��λ����δ��Ƕ��ʯ����װ��λ�����ܽ��л���
    elseif ret == 3 then
        EquipBaoshiChange_tishi : SetText( "#{WBSS_120727_17}" )      --- ��Ӧ��װ����λ��û�б�ʯ����Ƕ���޷�������������
    elseif ret == 4 then
        EquipBaoshiChange_tishi : SetText( "#{WBSS_120727_18}" )      --- ����ʱװ��ǰ���׻����ͬ���ͱ�ʯ����Ƕ���޷�������������
    elseif ret == 0 then
        EquipBaoshiChange_tishi : SetText( "#{WBSS_120727_19}" )      --- ���㻥�����������Խ�����������
    else
        EquipBaoshiChange_tishi : SetText( "" )
    end
end

function EquipBaoshiChange_GetTypeListIndex( )
    --- �õ���TypeList���������
    local typeListIndex = 1
    for i = 1, table.getn( g_EquipBaoshiChange_Equip_TypeList ) do
        if g_EquipBaoshiChange_Equip_TypeList[i].equipIndex == g_EquipBaoshiChange_Equip_Info.equipPoint then
            typeListIndex = i
            break
        end
    end
    return typeListIndex
end

function EquipBaoshiChange_OpenFreshManGuide( )
    local fX, fY = this:GetChildOffset("EquipBaoshiChange_Special_Button9")
    fX = fX + EquipBaoshiChange_Special_Button9:GetProperty("AbsoluteWidth")  / 2
    fY = fY + EquipBaoshiChange_Special_Button9:GetProperty("AbsoluteHeight") / 2
    OpenFreshManGuide( 1, 37, fX, fY, "EquipBaoshiChange", "northeast" )
end

function EquipBaoshiChange_OnMoved()
    if "EquipBaoshiChange" == GetFreshManGuideOwner() then --��������show��������uiָ�򱾽���,����Ҫ��Ӧ
        OpenFreshManGuide(2, -1, -1, -1)
    end
end

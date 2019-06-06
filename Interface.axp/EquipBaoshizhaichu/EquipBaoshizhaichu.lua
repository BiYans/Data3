--- һ������ʯ����
--- Author: David Gao 2012.08.13

local g_EquipBaoshizhaichu_SERVER_CONTROL_1 = 2012081303   --- һ������ʯʹ�ý���
local g_EquipBaoshizhaichu_Frame_UnifiedPosition
local g_EquipBaoshiZhaichu_ObjCared = -1
local g_EquipBaoshiZhaichu_NeedHint = 0;

local g_EquipBaoshizhaichu_Container_Gems = {}        --- װ��λ�ϵı�ʯ
local g_EquipBaoshizhaichu_Gem_Lists      = {}        --- װ��λ�ϵı�ʯ
local g_EquipBaoshizhaichu_Selected_List  = {}        --- ѡ�еı�ʯ�б�
local g_EquipBaoshizhaichu_Pos_Selected   = -1        --- ѡ�е�װ��λ
local g_EquipBaoshizhaichu_Animates       = {}        --- ����Ч��
local g_EquipBaoshizhaichu_Equip_TypeList = 
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

local g_EquipBaoshiZhaichu_WanbaoZhaichu_Fu = 30900126     --- ��ժ����ID

function EquipBaoshizhaichu_PreLoad()
    this:RegisterEvent("UI_COMMAND");
    this:RegisterEvent("GEM_CONTAINER_REFRESH");
    this:RegisterEvent("OBJECT_CARED_EVENT");
	this:RegisterEvent("PLAYER_LEAVE_WORLD");
	this:RegisterEvent("SCENE_TRANSED");
	this:RegisterEvent("ON_SCENE_TRANSING");
	this:RegisterEvent("ADJEST_UI_POS")
	this:RegisterEvent("VIEW_RESOLUTION_CHANGED")
end

function EquipBaoshizhaichu_OnLoad()
    g_EquipBaoshizhaichu_Frame_UnifiedPosition = EquipBaoshizhaichu_Frame:GetProperty( "UnifiedPosition" )

    g_EquipBaoshizhaichu_Container_Gems[1] = EquipBaoshizhaichu_Special_Button1
    g_EquipBaoshizhaichu_Container_Gems[2] = EquipBaoshizhaichu_Special_Button2
    g_EquipBaoshizhaichu_Container_Gems[3] = EquipBaoshizhaichu_Special_Button3
    g_EquipBaoshizhaichu_Container_Gems[4] = EquipBaoshizhaichu_Special_Button4

    g_EquipBaoshizhaichu_Animates[1] = BaoShizhaichu1
    g_EquipBaoshizhaichu_Animates[2] = BaoShizhaichu2
    g_EquipBaoshizhaichu_Animates[3] = BaoShizhaichu3
    g_EquipBaoshizhaichu_Animates[4] = BaoShizhaichu4

    g_EquipBaoshizhaichu_Gem_Lists[1] = -1
    g_EquipBaoshizhaichu_Gem_Lists[2] = -1
    g_EquipBaoshizhaichu_Gem_Lists[3] = -1
    g_EquipBaoshizhaichu_Gem_Lists[4] = -1

    g_EquipBaoshizhaichu_Pos_Selected = -1
    EquipBaoshizhaichu_zhuangbeixiala : ResetList()
end

-- OnEvent
function EquipBaoshizhaichu_OnEvent(event)
    if ( event == "UI_COMMAND" ) and tonumber( arg0 ) == g_EquipBaoshizhaichu_SERVER_CONTROL_1 then
        EquipBaoshizhaichu_Update()
		this:Show()
        
        g_EquipBaoshiZhaichu_ObjCared = -1
        local xx = Get_XParam_INT( 0 )
        g_EquipBaoshiZhaichu_ObjCared = DataPool : GetNPCIDByServerID( xx )
        if g_EquipBaoshiZhaichu_ObjCared == -1 then
            return
        end
        EquipBaoshiZhaichu_BeginCareObject( g_EquipBaoshiZhaichu_ObjCared )
    elseif (event == "OBJECT_CARED_EVENT" and this:IsVisible()) then
		if(tonumber(arg0) ~= g_EquipBaoshiZhaichu_ObjCared) then
			return;
		end
		
		--�����NPC�ľ������һ��������߱�ɾ�����Զ��ر�
		if(arg1 == "distance" and tonumber(arg2)>MAX_OBJ_DISTANCE or arg1=="destroy") then
		    --ȡ������
    		EquipBaoshizhaichu_OnClosed()
		end
    elseif ( event == "UI_COMMAND" ) and tonumber( arg0 ) == 2012081302 then
        if ( this : IsVisible() ) then
            EquipBaoshizhaichu_EquipSel()
        end
    elseif ( event == "GEM_CONTAINER_REFRESH" ) then
        if ( this : IsVisible() ) then
            EquipBaoshizhaichu_EquipSel()
        end
	elseif event == "PLAYER_LEAVE_WORLD"  then
		if( this:IsVisible() ) then
            EquipBaoshizhaichu_OnClosed()
		end
	elseif event == "SCENE_TRANSED"  then
		if( this:IsVisible() ) then
            EquipBaoshizhaichu_OnClosed()
		end
	elseif event == "ON_SCENE_TRANSING"  then
		if( this:IsVisible() ) then
            EquipBaoshizhaichu_OnClosed()
		end
	elseif (event == "ADJEST_UI_POS" ) then
		EquipBaoshizhaichu_On_ResetPos()

	elseif (event == "VIEW_RESOLUTION_CHANGED") then
		EquipBaoshizhaichu_On_ResetPos()
	end
end

function EquipBaoshizhaichu_Update( )
    EquipBaoshizhaichu_zhuangbeixiala : ResetList ()
    for i = 1, table.getn( g_EquipBaoshizhaichu_Equip_TypeList ) do
        EquipBaoshizhaichu_zhuangbeixiala : AddTextItem( g_EquipBaoshizhaichu_Equip_TypeList[i].name, i - 1 )
    end
    EquipBaoshizhaichu_zhuangbeixiala : SetCurrentSelect( 0 )
    EquipBaoshizhaichu_EquipSel( )
end

function EquipBaoshizhaichu_EquipSel()
    EquipBaoshizhaichu_Clear()

    local _, curSel = EquipBaoshizhaichu_zhuangbeixiala : GetCurrentSelect( )
    if curSel == nil or curSel < 0 or curSel > table.getn( g_EquipBaoshizhaichu_Equip_TypeList ) then
        return
    end
    curSel = curSel + 1
    local curIndex = g_EquipBaoshizhaichu_Equip_TypeList[curSel].gemConIndex
    g_EquipBaoshizhaichu_Pos_Selected = curIndex

    --- ��ʾװ��λ�ϵı�ʯ
    LifeAbility : GemContainer_Update()
    for i = 1, 4 do
        local itemID, _, _ = LifeAbility : GetGemContainer_Gem( curIndex, i - 1 )
        if itemID ~= -1 then
            local ActionID = DataPool : EnumPlayerMission_ItemAction( itemID )
            g_EquipBaoshizhaichu_Container_Gems[i] : SetActionItem( ActionID )
            g_EquipBaoshizhaichu_Gem_Lists[i]     = itemID
        end
    end
    g_EquipBaoshizhaichu_NeedHint = 0;
end

function EquipBaoshizhaichu_Clear(  )
    for i=1, 4 do
        g_EquipBaoshizhaichu_Container_Gems[i]     : SetActionItem( -1 )
        g_EquipBaoshizhaichu_Gem_Lists[i]     = -1
        g_EquipBaoshizhaichu_Selected_List[i] = 0
        g_EquipBaoshizhaichu_Animates[i] : Hide()
    end
    g_EquipBaoshizhaichu_Pos_Selected = -1
    g_EquipBaoshizhaichu_NeedHint = 0;
end

function EquipBaoshizhaichu_OnClosed()
    EquipBaoshizhaichu_Clear()
    this:Hide()
    return
end

function EquipBaoshizhaichu_On_ResetPos()
    EquipBaoshizhaichu_Frame:SetProperty( "UnifiedPosition", g_EquipBaoshizhaichu_Frame_UnifiedPosition )
    g_EquipBaoshizhaichu_NeedHint = 0;
    return
end

--- �õ���ǰ���ϰ��ж��ٿ�λ
function EquipBaoshizhaichu_GetCurPacketMat_SpaceNum(  )
    local CurrBagNum = DataPool:GetMatBag_Num()
    local curMatNum  = 0
    local PACKAGE_NUM_PER_LINE = 5
    local nMaxLine = math.floor( CurrBagNum / PACKAGE_NUM_PER_LINE );
	--�����������
	if( nMaxLine * PACKAGE_NUM_PER_LINE == CurrBagNum ) then
	else
		nMaxLine = nMaxLine + 1;
	end

	--- ���������ǰ��ʾ�����Χ�ˣ��͸��°�������
	local nMaxDisplayNumber = nMaxLine * PACKAGE_NUM_PER_LINE;
	for i=1, nMaxDisplayNumber do
        local theAction,bLocked = PlayerPackage:EnumItem( "material", i-1 );
        if theAction : GetID() ~= 0 then
            curMatNum = curMatNum + 1
        end
    end

    return CurrBagNum - curMatNum

end

function EquipBaoshizhaichu_Selected( index )
    if index < 1 or index > 4 then
        return
    end
    
    if g_EquipBaoshizhaichu_Gem_Lists[index] < 0 then
        g_EquipBaoshizhaichu_Selected_List[index] = 0
        --- g_EquipBaoshizhaichu_Container_Gems[index] : SetPushed( 0 )
        g_EquipBaoshizhaichu_Animates[index] : Hide()
        return
    end

    local curValue = g_EquipBaoshizhaichu_Selected_List[index]
    if curValue == 0 then
        g_EquipBaoshizhaichu_Selected_List[index] = 1
        g_EquipBaoshizhaichu_Animates[index] : Show()
    else
        g_EquipBaoshizhaichu_Selected_List[index] = 0
        g_EquipBaoshizhaichu_Animates[index] : Hide()
    end

    g_EquipBaoshizhaichu_NeedHint = 0;
    --- g_EquipBaoshizhaichu_Container_Gems[index] : SetPushed( g_EquipBaoshizhaichu_Selected_List[index] ) 
    
end

function EquipBaoshizhaichu_OK_Clicked()
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
    if 0 == EquipBaoshizhaichu_Is_Learned_Skill() then
        PushDebugMessage( "#{WBSS_120727_61}" ) --- ֻ��ѧϰ�����������Ҳ��ܽ��д˲���
        return
    end

    --- �жϵ�ǰװ��λ�Ƿ���ѡ��
    if g_EquipBaoshizhaichu_Pos_Selected < 0 then
        PushDebugMessage( "#{WBSS_120727_67}" ) --- ����ѡ����Ҫ������ժ����װ��λ
        return
    end

    --- �жϵ�ǰ�Ƿ���ѡ�е���Ҫժ���ı�ʯ
    local selectedNum = 0
    for i = 1, 4 do
        selectedNum = selectedNum + g_EquipBaoshizhaichu_Selected_List[i]
    end
    if selectedNum == 0 then
        PushDebugMessage( "#{WBSS_120727_68}" ) --- ��ѡ����Ҫժ���ı�ʯ
        return
    end

    --- �ж���Ҳ������еĿ�λ�Ƿ���ڵ���ѡ�еı�ʯ����
    local curMatFreeSpace = EquipBaoshizhaichu_GetCurPacketMat_SpaceNum(  )
    if curMatFreeSpace < selectedNum then
        if selectedNum == 1 then
            PushDebugMessage( "#{WBSS_120727_69}" ) --- ������û�п�λ���޷�ժ����ʯ
        else
            local strText = ScriptGlobal_Format( "#{WBSS_120727_70}", selectedNum, selectedNum )
            PushDebugMessage( strText ) --- ��������λ����X�����޷�ͬʱժ��X����ʯ
        end
        return
    end

    --- �ж���Ұ�����δ��������ժ���������Ƿ���ڵ���ѡ�еı�ʯ����
    local curFuNum = PlayerPackage : CountAvailableItemByIDTable( g_EquipBaoshiZhaichu_WanbaoZhaichu_Fu ) 
    if curFuNum < selectedNum then
        if selectedNum == 1 then
            PushDebugMessage( "#{WBSS_120727_71}" ) --- ������ȱ��δ��������ժ�������޷�������ժ��
        else
            local strText = ScriptGlobal_Format( "#{WBSS_120727_72}", selectedNum, selectedNum )
            PushDebugMessage( strText ) --- ������δ��������ժ������������X�����޷�ͬʱժ��X����ʯ
        end
        return
    end
    
    if g_EquipBaoshizhaichu_NeedHint == 0 then
	    PushEvent("GAMELOGIN_SYSTEM_INFO_OK", "#{WBZC_140211_01}", "-1")
	    g_EquipBaoshizhaichu_NeedHint = 1;
    else
	    Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name( "RemoveGemFromContainer" );
		Set_XSCRIPT_ScriptID( 701614 );
		Set_XSCRIPT_Parameter( 0, g_EquipBaoshizhaichu_Pos_Selected     );         --- װ��λ
		Set_XSCRIPT_Parameter( 1, g_EquipBaoshizhaichu_Selected_List[1] );
		Set_XSCRIPT_Parameter( 2, g_EquipBaoshizhaichu_Selected_List[2] );
		Set_XSCRIPT_Parameter( 3, g_EquipBaoshizhaichu_Selected_List[3] );
		Set_XSCRIPT_Parameter( 4, g_EquipBaoshizhaichu_Selected_List[4] );
		Set_XSCRIPT_ParamCount( 5 );
	    Send_XSCRIPT();
	    g_EquipBaoshizhaichu_NeedHint = 0;
    end

  --  EquipBaoshizhaichu_OnClosed()

    return
end


-----------------------------------------------------------------------------------
--- ������Щȫ���Ǹ������� AuxFunc
-----------------------------------------------------------------------------------
--- ����Ƿ�ѧ����һ������ʯ����
function EquipBaoshizhaichu_Is_Learned_Skill()
    local gemSwitchSkillID = 278

	if( Player:GetSkillInfo( gemSwitchSkillID, "learn") ) then
        return 1
	else
        return 0
	end
end

function EquipBaoshiZhaichu_BeginCareObject( objCaredId )
	this:CareObject( objCaredId, 1, "EquipBaoshiZhaichu");
end
function EquipBaoshiZhaichu_StopCareObject( objCaredId )
	this:CareObject( objCaredId, 0, "EquipBaoshiZhaichu");
end

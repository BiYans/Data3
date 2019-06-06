--MisDescBegin
x250000_g_ScriptId = 250000
x250000_g_MissionId = 720
x250000_g_Name	="Sa Ch�u L�nh" 
x250000_g_rand = 0					--������1λ
x250000_g_MissionName="Ta mu�n b�n tr�n th�"
x250000_g_MissionInfo="    Xin h�y gi�p ti�u th� nh� ta b�t tr�n th�."  --��������
x250000_g_MissionTarget="    Ho�n th�nh nhi�m v� Sa Ch�u L�nh."		--����Ŀ��
x250000_g_ContinueInfo="Nhi�m v� �� l�m xong ch�a ?"		--δ��������npc�Ի�
x250000_g_MissionComplete="Th�t l� c�m �n c�c h�!"					--�������npc˵�Ļ�
function x250000_OnDefaultEvent( sceneId, selfId, targetId )	--����������ִ�д˽ű�
DispatchMissionDemandInfo(sceneId,selfId,targetId,x250000_g_ScriptId,x250000_g_MissionId, 2)
end
function x250000_HaveMissionToDo( sceneId, selfId,targetId )
end
function x250000_NoMissionToDo( sceneId, selfId, targetId )
end
function x250000_OnEnumerate( sceneId, selfId, targetId )
if GetName(sceneId,targetId) == x250000_g_Name then		--����Ƿ������npc		  
AddNumText(sceneId,x250000_g_ScriptId,x250000_g_MissionName,6,-1)
end
end
function x250000_CheckAccept( sceneId, selfId )
return 1
end
function x250000_OnAccept( sceneId, selfId )
end
function x250000_OnAbandon( sceneId, selfId )
end
function x250000_OnContinue( sceneId, selfId, targetId )
end
function x250000_CheckSubmit( sceneId, selfId )
local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x250000_g_MissionId )
if bRet ~= 1 then
return 0
end
end
function x250000_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end
function x250000_OnKillObject( sceneId, selfId, objdataId )
end
function x250000_OnEnterArea( sceneId, selfId, zoneId )
end
function x250000_OnItemChanged( sceneId, selfId, itemdataId )
end
function x250000_AcceptDialog(sceneId, selfId,x250000_g_rand,g_Dialog,targetId)
end
function x250000_SubmitDialog(sceneId, selfId,x250000_g_rand)
end
function x250000_SubmitDialog(sceneId, selfId,x250000_g_rand)
end
function x250000_DisplayMissionTips(sceneId,selfId,g_MissionTip)
BeginEvent(sceneId)
strText = g_MissionTip
AddText(sceneId,strText)
EndEvent(sceneId)
DispatchMissionTips(sceneId,selfId)
end
function x250000_GetEventMissionId(sceneId, selfId)
return x250000_g_MissionId
end
function x250000_PetValue( PetLevel )
local MoneyNum = 0
if PetLevel > 0  and PetLevel <=5 then		    
MoneyNum = 225
end
if PetLevel > 5  and PetLevel <=15 then
MoneyNum = 595
end
if PetLevel > 15  and PetLevel <=25 then
MoneyNum = 1191
end
if PetLevel > 25  and PetLevel <=35 then
MoneyNum = 1779
end
if PetLevel > 35  and PetLevel <=45 then
MoneyNum = 2450
end
if PetLevel > 45  and PetLevel <=55 then
MoneyNum = 3205
end
if PetLevel > 55  and PetLevel <=65 then
MoneyNum = 4042
end
if PetLevel > 65  and PetLevel <=75 then
MoneyNum = 4964
end
if PetLevel > 75  and PetLevel <=85 then
MoneyNum = 5968
end
if PetLevel > 85  and PetLevel <=95 then
MoneyNum = 7056
end
if PetLevel > 95 then
MoneyNum = 7056
end
return MoneyNum
end
function x250000_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
if indexpet == 255 then --����ֵ����255��ʾ�գ�û�ύ����
BeginEvent(sceneId)
strText = "H�y �em tr�n th� v�o trong c�a s�"
AddText(sceneId,strText);
EndEvent(sceneId)
DispatchMissionTips(sceneId,selfId)
else	
ValidIndex = indexpet
if 255 == ValidIndex then        
return        
end
local PetLevel = LuaFnGetPet_Level( sceneId, selfId, ValidIndex )		    --�õ����޼���				    
local DataID = LuaFnGetPet_DataID( sceneId, selfId, ValidIndex )       --�õ�����ID
local PetName = GetPetName( DataID )  
ret1 = LuaFnDeletePet(sceneId, selfId, ValidIndex ) --ɾ������				
if ret1 > 0 then     --�ɹ�ɾ������		    		    
local MoneyNum = x250000_PetValue( PetLevel )
AddMoney( sceneId, selfId, MoneyNum )
Msg2Player(  sceneId, selfId,"C�c h� �� b�n r�i"..PetName..", ��t ���c #{_MONEY"..MoneyNum.."}",MSG2PLAYER_PARA )
end
end
end

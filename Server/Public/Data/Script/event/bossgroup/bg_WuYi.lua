--V� Di BOSSȺˢ�½ű�

--�ű���
x810002_g_ScriptId	= 810002

--ˢ�·�ʽΪ:
--����˽ű�ʱ��� gi�y���10c�iBOSS....

--C�n ˢ��to� � BOSSto� � ���ݱ�....
--BOSSto� � MonsterID�����ظ�....T�i ������ͬm�t ʱ��ͬm�t c�iMonsterIDto� � ��ֻ�ܴ�T�i m�t c�i....���˾Ͳ�ˢ��....
x810002_g_BossData = {

	-- ID						BOSSto� �  monster id
	-- PosX					����
	-- PosY					����
	-- BaseAI				BOSSto� � BaseAI....
	-- ExtAIScript	BOSSto� � ��չAI....
	-- ScriptID			BOSSto� � �ű�ID....
	-- NeedCreate		����1....

	{ ID=9120, PosX=53,  PosY=242, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9121, PosX=88,  PosY=260, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9122, PosX=54,  PosY=212, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9123, PosX=41,  PosY=159, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9124, PosX=80,  PosY=147, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9125, PosX=114, PosY=43,  BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9126, PosX=267, PosY=136, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9127, PosX=202, PosY=242, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9128, PosX=147, PosY=265, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
	{ ID=9129, PosX=182, PosY=127, BaseAI=30, ExtAIScript=255, ScriptID=810100, NeedCreate=1 },
}


--**********************************
--�ű���ں���
--**********************************
function x810002_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )

	--M� ra �....
	StartOneActivity( sceneId, actId, 180*1000, iNoticeType )

	--BOSS���ݱ�Ϊ�վͲ�ˢBOSS....
	if getn(x810002_g_BossData) < 1 then
		return
	end

	--����Boss�ؽ�״̬....
	for _, Data in x810002_g_BossData do
		Data.NeedCreate = 1
	end

	--��������������to� � ��....����BOSS�ؽ�״̬....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		x810002_CurSceneHaveMonster( sceneId, MosDataID )
	end

	--�ؽ�C�n �ؽ�to� � BOSS....
	for _, BossData in x810002_g_BossData do
		if BossData.NeedCreate == 1 then
			local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
			if (BossData.ID == 9120) then
				SetCharacterTitle(sceneId, MonsterID, "Chung c�c b�o ph�")
			else
				SetCharacterTitle(sceneId, MonsterID, "T�i giai ph�i gi�c")
			end
		end
	end

end

--**********************************
--��������
--**********************************
function x810002_OnTimer( sceneId, actId, uTime )

	--�����ng�����
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end

end

--**********************************
--���ڸ����ؽ�״̬....
--**********************************
function x810002_CurSceneHaveMonster( sceneId, DataID )

	for i, Data in x810002_g_BossData do
		if DataID == Data.ID then
			x810002_g_BossData[i].NeedCreate = 0
			break
		end
	end

end

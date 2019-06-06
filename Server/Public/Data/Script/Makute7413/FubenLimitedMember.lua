
x741307_g_scriptId = 741307

function x741307_FubenChecker(sceneId,selfId,ScriptID,type)
	local FubenDetail = {}
		--FubenDetail[050013] = {ThanhVien,CapDo,TamPhap,SoLuot} --Fuben Description--
		FubenDetail[050013] = {3,20,1,1} --ok-testing-Ac Tac Tao Phan--
		FubenDetail[808016] = {3,20,1,1} --ok-tested-Danh Len Tieu Dao--
		FubenDetail[808027] = {3,20,1,1} --ok-tested-Danh Len Thieu Lam--
		FubenDetail[808028] = {3,20,1,1} --ok-tested-Danh Len Tinh Tuc--
		FubenDetail[808029] = {3,20,1,1} --ok-tested-Danh Len Thien long--
		FubenDetail[808030] = {3,20,1,1} --ok-tested-Danh Len Thien Son--
		FubenDetail[808031] = {3,20,1,1} --ok-tested-Danh Len Minh Giao--
		FubenDetail[808032] = {3,20,1,1} --ok-tested-Danh Len Cai Bang--
		FubenDetail[808033] = {3,20,1,1} --ok-tested-Danh Len Vo Dang--
		FubenDetail[808034] = {3,20,1,1} --ok-tested-Danh Len Nga My--
		FubenDetail[401001] = {3,10,1,1} --ok-tested-Tran Long Ky Cuoc--
		FubenDetail[232002] = {1,20,1,1} --ok-tested-Thuy Lao Phan Loan--
		FubenDetail[402030] = {3,10,1,1} --ok-tested-Diet Phi Kinh Ho--
		FubenDetail[050100] = {3,30,1,1} --ok-tested-Phu Ban QTC 1--
		FubenDetail[050101] = {3,30,1,1} --ok-tested-Phu Ban QTC 2--
		FubenDetail[050102] = {4,30,1,1} --ok-tested-Phu Ban QTC 3--
		FubenDetail[050220] = {3,75,45,1} --ok-tested-Phu Ban QLL 1--
		FubenDetail[050221] = {3,75,45,1} --ok-tested-Phu Ban QLL 2--
		FubenDetail[050222] = {3,75,45,1} --ok-tested-Phu Ban QLL 3--
		FubenDetail[808039] = {3,75,1,1} --ok-tested-Lau Lan Tam Bao--
		FubenDetail[402263] = {3,90,0,3} --ok-tested-Phieu Mieu Phong 90--
		FubenDetail[402276] = {3,75,0,3} --ok-tested-Phieu Mieu Phong 75--
		FubenDetail[402102] = {3,40,1,1} --ok-tested-Tiep Cuu Linh Thu--
		FubenDetail[402105] = {3,40,1,1} --ok-tested-Da Tru Vuong--
	
	if type == 0 then
		return FubenDetail[ScriptID][1],FubenDetail[ScriptID][2],FubenDetail[ScriptID][3],FubenDetail[ScriptID][4];
	else
		return FubenDetail[ScriptID][type];
	end
end

function x741307_ThongBaoBaoTri(sceneId,selfId)
	--Kiem Tra Bao Duong--
	local h = 00;
	local m = 00;

	local now_m = GetMinute();
	local now_h = GetHour();
	
	local ins_time = h * 60 + m;
	local now_time = now_h * 60 + now_m;
	
	local space_time = ins_time - now_time;
	if space_time >= 0 and space_time <= 30 then
		return space_time;
	else
		return 0;
	end
	--Kiem Tra Bao Duong--
end

function x741307_NotifyFailTips(sceneId,selfId,Tip)
	BeginEvent(sceneId)
		AddText(sceneId,Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
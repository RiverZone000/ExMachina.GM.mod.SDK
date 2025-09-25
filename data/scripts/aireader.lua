-- $Id: AIReader.lua,v 1.6 2004/10/20 06:57:07 den Exp $

g_AIManager = GET_GLOBAL_OBJECT "g_AIManager"

function ReadMatrix( fileName )
--	LOG( "Reading decision matrix from file " .. fileName )
	
	-- ������ �������� �������
	EXECUTE_SCRIPT ( "data\\gamedata\\lua\\" .. fileName )
	
	-- ������� �������, � ������� ����� ����������
	-- ����� local �����! ;)
	local dm = g_AIManager:CreateNewDecisionMatrix()
	
	-- ������ �������
	ReadSignals( dm, AI )
	
	-- ������ ���������
	ReadStates( dm, AI )
	
	-- ������ ��������� �� ���������
	ReadDefaultState( dm, AI, fileName )
	
	-- ������ ��������� ������
	ReadExitState( dm, AI )
		
	-- ������ ������� �������
	ReadDecisions( dm, AI )
	
	-- ������ ������ ���������. ��� ���� ������ � ����� �����, ����� �� ���������� 
	-- ������������ ���� � �������.
	ReadSubmatrices( dm, AI )
	
--	LOG( "Finished loading matrix from file " .. fileName )
	return dm
end


-- ������ ������� ��� �������
function ReadSignals( dm, AI )
	for signalName, signalValue in AI.SIGNALS do
		-- ���� � ������� ��� ���������, �� �������� nil'�, ����� �������� ������ ��������
		if signalValue == 0 then
			DebugLog( "signal " .. signalName .. " has no attributes" )
			dm:AddSignal( signalName, ToStr(nil), ToStr(nil) )
		else
			DebugLog( "signal " .. signalName )
			dm:AddSignal( signalName, ToStr(signalValue.extern), ToStr(signalValue.func) )
		end
	end
end


-- ������ ��������� ��� �������
function ReadStates( dm, AI )
	for stateName, stateValue in AI.STATES do
		-- � �������� �������� � ���� ��������� ���� ���� �������, �� ��� ����� � ������.
		if not stateValue or not stateValue.func then
			LOG( "Error: state '" .. stateName .. "' has no associated function." )
			return
		end
		
		dm:AddState( stateName, stateValue.func )
		
		-- ���� ���� ����� (� ������ �������� ����� ��� S1 = ACT_FINISHED, ...), �� ������������ ��
		if stateValue.scheme then
			for schemeName, schemeValue in stateValue.scheme do
				dm:SetRetValueInterpretation( stateName, schemeName, schemeValue )
			end
		end
	end
end


-- ������ ��������� �� ���������
function ReadDefaultState( dm, AI, fileName )
	local default = AI.default
	if not default then
		return
	end
	
	-- ������������� ��� ��������� �� ���������
	local stateName	= default[1];
	
	if not stateName then
		LOG( "Error: State name expected for default state" )
		return
	end
	
	dm:SetDefaultState( stateName )
	DebugLog( "default state is " .. stateName )
		
	
	-- � ��������� ��� ���������
	local stateParams	= default[2];
	
	if not stateParams then
		DebugLog( "default state has no parameters" )
		return
	end
	
	for i = 1, getn(stateParams) do
		local stateParamName = stateParams[i]
		
		-- -- println( "stateParams[" .. i .. "] is '" .. stateParamName .. "'" )

		if not stateParamName then
			LOG( "Error: Parameter name expected for default state" )
			return
		end
		
		-- �������� ������ ���� �������� � VAR, � ��� ��� �������������� ��� �������
		local stateParamFunction	= AI.VAR[stateParamName]
		
		-- -- println( "stateParamFunction is " .. stateParamFunction )

		if not stateParamFunction then
			LOG( "Error: Unexpected parameter name for default: " .. stateParamName .. " in " .. fileName )
			return
		end
		
		dm:AddDefaultStateParam( stateParamFunction )
	end
end


-- ������ ��������� ������
function ReadExitState( dm, AI )
	DebugLog( "Reading exit state" )
	
	local exitStateName = AI.exit
	
	if not exitStateName then
		return
	end

	-- ������������� ��� ��������� ������
	dm:SetExitState( exitStateName )

	DebugLog( "exit state is " .. exitStateName )
end

-- ������ ��������������� ������� �������
function ReadDecisions( dm, AI )
	DebugLog( "Reading decisions" )
	
	dm:FitMatrix()
	
	-- ���������� �������, ������ ��� ���������� �������
	for stateName, stateRow in AI.DECISION do
		DebugLog( "State: " .. stateName )
		
		for signalName, commandList in stateRow do
			DebugLog( "    Signal: " .. signalName )
			
			local numFirstCommand = 1
			
			if commandList[1] == "STACK_SAVE" then
				-- println( "            STACK_SAVE!!" )
				
				dm:SetSaveStackFlag( stateName, signalName)
				numFirstCommand = 2
			end
			
			DebugLog( "        Number of commands " .. ( getn( commandList ) + 1 - numFirstCommand ) )
			
			for iCommand = numFirstCommand, getn(commandList)  do
				local command = commandList[iCommand]
				newStateName = command[1]
				
				if not newStateName then
					LOG( "Error: Command name expected for state " .. stateName .. " and signal " .. signalName )
					return
				end
				
				-- println( "            Command: " .. newStateName )
				
				dm:ClearTemporaryParams()

				-- ���� � ������� ���� ���������, �� ��������� �� � ��������� ���������������
				-- ������� �� ��������� ������				
				local params = command[2]
				if params then
					for iParam = 1, getn(params) do
						-- println( "                Parameter: " .. params[iParam] )
						dm:AddTemporaryParam( GetCommandFunctionName( AI, signalName, params[iParam] ) )
					end
				end

				-- ��������� ���� �������. ���� ��������� ������ ���������� ���������� (����), �� ��
				-- ����� ������� ���������� ���� �������
				dm:AddCommand( stateName, signalName, newStateName )
			end
		end
	end
end


-- ������ � ��������� ����������
function ReadSubmatrices( dm, AI )
	for stateName, stateValue in AI.STATES do
		-- � �������� �������� � ���� ��������� ���� ���� �������, �� ��� ����� � ������.
		if not stateValue or not stateValue.func then
			LOG( "Error: state '" .. stateName .. "' has no associated function." )
			return
		end
	
		-- ���� ���� ����������, �� ������ ��
		if stateValue.submatrix then
			DebugLog( "State " .. stateName .. " has submatrix.")
			
			dm:AddSublevel( stateName, g_AIManager:LoadMatrix( stateValue.submatrix ) )
		end
	end
end

-- ��������� ��� ������� (���, �������� ������� �������� ��������� ���������) �� ����� ���������
function GetCommandFunctionName( AI, signalName, paramName )
	-- println( "**Getting cmd func name*** signal = " .. signalName .. ", param = " .. paramName )


	-- ���� � ������� �������� ������� ������� ������������� �� 0 (� ������ �������)
	-- �� �������� ����� ��� �������� � ������ ���������� �������	
	if AI.SIGNALS[signalName] ~= 0 then
		local paramNumForSignal = ValueIndexInTable( AI.SIGNALS[signalName].params, paramName )

		-- ���� �������� - ��� �������� �������, �� ����� �������  AIGetCmdParamN
		if paramNumForSignal then
			-- println( "**paramNumForSignal = " .. paramNumForSignal )
			
			return ( "AIGetCmdParam" .. paramNumForSignal )
		end
	end

	-- ����� ���� ��� ����� ���������� ����������	
	local globalFuncName = AI.VAR[paramName]
	
	if globalFuncName then
		-- -- println( "globalFuncName = " .. globalFuncName )

		return globalFuncName
	end
	
	LOG( "Error: Unexpected parameter " .. paramName )

	-- -- println( "Error in GetCommandFunctionName" )

	return nil
end


-- ���������� ������, ���� �������� ������������ � �������, ����� nil
function ValueIndexInTable( table, value )
	-- println( "                                   Searching " .. value )
	
	if not table then
		-- -- println( "                                     table is nil" )
		return nil
	end
	
	for k, v in table do
		if v == value then
			return k
		end
	end
	
	return nil
end


-- ����������� nil � ������ ������
function ToStr( s )
	if s then
		return s
	end
	
	return ""
end


function DebugLog( s )
--	LOG( s )
end

function testai()
	-- -- println( "Testing ReadMatrix" )
	ReadMatrix( "troopattack.lua" )
end


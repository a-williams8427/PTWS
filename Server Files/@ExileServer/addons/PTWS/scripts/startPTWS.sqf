private["_dateID","_date","_saveddate","_currentdate","_data","_extDB2Message","_timeMultiplier"];
if (!isServer) exitWith {};

missionNamespace setVariable ["PTWS",PTWS_ID];

_dateID = missionNamespace getVariable "PTWS";
_date = format ["getDate:%1", _dateID] call ExileServer_system_database_query_selectFull;
_saveddate = (_date select 0) select 0;

if (typeName _saveddate isEqualTo "ARRAY") then
{
	diag_log format["PTWS - Loading last saved date : %1", _saveddate];
	setDate _saveddate;
}
else
{
	setDate PTWS_StartingDate;
	diag_log format["PTWS - No saved date found, loading PTWS_StartingDate:%1",PTWS_StartingDate];
};

if (true) then
{
	diag_log "PTWS - SaveDate Initialised";
	//[60, PTWS_fnc_saveDate, [], true] call ExileServer_system_thread_addTask;	//This doesn't work for some reason :/
	while {true} do
	{
		_dateID = missionNamespace getVariable "PTWS";
		_currentdate = date;
		_data =
		[
			_currentdate,
			_dateID
		];
		_extDB2Message = ["setDate", _data] call ExileServer_util_extDB2_createMessage;
		_extDB2Message call ExileServer_system_database_query_fireAndForget;
		//Borrowed the template from second_coming's occupation mod.
		if (PTWS_timeAcc) then
		{
			if (daytime > PTWS_timeAccNightStart || daytime < PTWS_timeAccDayStart) then 
			{ 
				_timeMultiplier = PTWS_timeAccMultiplierNight; 
			} 
			else  
			{
				_timeMultiplier = PTWS_timeAccMultiplierDay;
			};

			if(timeMultiplier != _timeMultiplier) then { setTimeMultiplier _timeMultiplier; };
		};
		uiSleep 60;
	};
};
/*
if (PTWS_timeAcc) then
{
	diag_log "PTWS - TimeAcc Initialised";
	//[60, PTWS_fnc_timeAcc, [], true] call ExileServer_system_thread_addTask; //Help please?
};
*/

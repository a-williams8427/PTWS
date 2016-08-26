private["_currentWeather","_data","_extDB2Message"];
_windDB = [wind select 0, wind select 1, false];
_currentWeather = [overcast,rain,fogParams,_windDB,gusts,lightnings,waves];
_data =
[
	_currentWeather,
	PTWS_ID
];
_extDB2Message = ["setWeather", _data] call ExileServer_util_extDB2_createMessage;
_extDB2Message call ExileServer_system_database_query_fireAndForget;
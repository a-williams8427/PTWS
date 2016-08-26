private["_currentdate","_data","_extDB2Message"];
_currentdate = date;
_data =
[
	_currentdate,
	PTWS_ID
];
_extDB2Message = ["setDate", _data] call ExileServer_util_extDB2_createMessage;
_extDB2Message call ExileServer_system_database_query_fireAndForget;
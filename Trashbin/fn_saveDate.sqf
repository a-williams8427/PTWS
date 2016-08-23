//Can't be called by ExileServer_system_thread_addTask for some reason.
private["_dateID","_currentdate","_data","_extDB2Message"];
missionNamespace setVariable ["PTWS",PTWS_ID];

_dateID = missionNamespace getVariable "PTWS";
_currentdate = date;
_data =
[
	_currentdate,
	_dateID
];
_extDB2Message = ["setDate", _data] call ExileServer_util_extDB2_createMessage;
_extDB2Message call ExileServer_system_database_query_fireAndForget;
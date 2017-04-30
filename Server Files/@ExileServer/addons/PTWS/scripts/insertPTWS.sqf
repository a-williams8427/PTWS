private["_checkDatabaseID","_insertDatabaseID"];
if (!isServer) exitWith {};

_checkDatabaseID = profileNamespace getVariable ["PTWS_DatabaseID",false];

if !(_checkDatabaseID isEqualTo PTWS_ID) then
{
	profileNamespace setVariable ["PTWS_DatabaseID",PTWS_ID];
	saveProfileNamespace;
	_insertDatabaseID = format["createDate:%1", PTWS_ID] call ExileServer_system_database_query_insertSingle;
	_insertDatabaseID;
};
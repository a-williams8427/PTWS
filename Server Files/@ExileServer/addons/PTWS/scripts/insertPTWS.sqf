private["_dateID"];
if (!isServer) exitWith {};

missionNamespace setVariable ["PTWS",PTWS_ID];
PTWS_DB_ID = missionNamespace getVariable "ExileDatabaseID";

if (isNil "PTWS_DB_ID") then
{
_dateID = format["createDate:%1", missionNamespace getVariable "PTWS"] call ExileServer_system_database_query_insertSingle;
missionNamespace setVariable ["ExileDatabaseID", _dateID];
_dateID;
};

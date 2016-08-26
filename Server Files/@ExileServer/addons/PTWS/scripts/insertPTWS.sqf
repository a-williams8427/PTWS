private ["_insertDatabaseID"];
if (!isServer) exitWith {};
//None of my checks work for the database entry work :/
_insertDatabaseID = format["createDate:%1", PTWS_ID] call ExileServer_system_database_query_insertSingle;
_insertDatabaseID;
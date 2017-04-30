[] spawn 
{
    waitUntil {time > 0};
    diag_log "PTWS - Loading Config";

    // Get the config for PTWS
    call compile preprocessFileLineNumbers "\PTWS\config.sqf";
    //Borrowed from second_coming's occupation mod.
    if(isNil "PTWS_CompiledOkay") exitWith { diag_log "PTWS - Failed to read config.sqf, check for typos."; };

    diag_log "PTWS - Initialized";

    // Start PTWS
	//DonkeyPunch - DirtySanchez add database check for known ID if none then populate it with config setup information
	_isKnownPTWSDateID = format ["isKnownPTWSID:%1", PTWS_ID] call ExileServer_system_database_query_selectSingleField;
	if!(_isKnownPTWSDateID)then
	{
		_insertPTWSDateID = format["createDate:%1", PTWS_ID] call ExileServer_system_database_query_insertSingle;
	};
	sleep 1;
    []execVM "\PTWS\scripts\startPTWS.sqf";
};

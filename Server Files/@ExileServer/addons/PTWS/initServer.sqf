[] spawn 
{
    waitUntil {time > 0};
    diag_log "PTWS - Loading Config";

    // Get the config for PTWS
    call compile preprocessFileLineNumbers "\PTWS\config.sqf";
    //Borrowed from second_coming's occupation mod.
    if(isNil "PTWS_CompiledOkay") exitWith { diag_log "PTWS - Failed to read config.sqf, check for typos."; };

    diag_log "PTWS - Initialised";

    // Start PTWS
	[]execVM "\PTWS\scripts\insertPTWS.sqf";
	sleep 1;
    []execVM "\PTWS\scripts\startPTWS.sqf";
};

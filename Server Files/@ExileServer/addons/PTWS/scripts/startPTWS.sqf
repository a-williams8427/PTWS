private["_saveddate","_savedWeather","_overcast","_rain","_fog","_wind","_gusts","_lightnings","_waves","_timeforecast","_timeforecastMinutes"];
if (!isServer) exitWith {};

_saveddate = format ["getDate:%1", PTWS_ID] call ExileServer_system_database_query_selectSingleField;
_savedWeather = format ["getWeather:%1", PTWS_ID] call ExileServer_system_database_query_selectSingleField;
diag_log format["PTWSDebug:db data - date:%1  weather:%2",_saveddate,_savedWeather];
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

if (typeName _savedWeather isEqualTo "ARRAY") then
{
	diag_log format["PTWS - Loading last saved weather : %1", _savedWeather];
	_overcast = _savedWeather select 0;
	_rain = _savedWeather select 1;
	_fog = _savedWeather select 2;
	_wind = _savedWeather select 3;
	_gusts = _savedWeather select 4;
	_lightnings = _savedWeather select 5;
	_waves = _savedWeather select 6;
	
	0 setovercast _overcast;
	0 setrain _rain;
	0 setfog _fog;
	setwind _wind;
	0 setgusts _gusts;
	0 setlightnings _lightnings;
	0 setwaves _waves;
	forceWeatherChange;
}
else
{
	diag_log format["PTWS - No saved weather found, loading PTWS_StartingWeather:%1",PTWS_StartingWeather];
	_overcast = PTWS_StartingWeather select 0;
	_rain = PTWS_StartingWeather select 1;
	_fog = PTWS_StartingWeather select 2;
	_wind = PTWS_StartingWeather select 3;
	_gusts = PTWS_StartingWeather select 4;
	_lightnings = PTWS_StartingWeather select 5;
	_waves = PTWS_StartingWeather select 6;
	
	0 setovercast _overcast;
	0 setrain _rain;
	0 setfog _fog;
	setwind _wind;
	0 setgusts _gusts;
	0 setlightnings _lightnings;
	0 setwaves _waves;
	forceWeatherChange;
};

diag_log "PTWS - SaveDate Initialized";
//Thanks WolfkillArcadia!
[60, PTWS_fnc_saveDate, [], true] call ExileServer_system_thread_addTask;

diag_log "PTWS - SaveWeather Initialized";
[60, PTWS_fnc_saveWeather, [], true] call ExileServer_system_thread_addTask;

[] spawn {
diag_log "PTWS - ControlWeather Initialized";
while {true} do {
	call PTWS_fnc_controlWeather;
	
	if(PTWS_weatherChangeMin > PTWS_weatherChangeMax) exitwith {hint format["PTWS - Max time: %1 must to be higher than Min time: %2", PTWS_weatherChangeMax, PTWS_weatherChangeMin];};
	_timeforecast = PTWS_weatherChangeMin;

	if !(PTWS_weatherChangeFast) then {
		_timeforecast = PTWS_weatherChangeMin + (random (PTWS_weatherChangeMax - PTWS_weatherChangeMin));
	};

	_timeforecastMinutes = [_timeforecast,"HH:MM:SS"] call BIS_fnc_secondsToString;
	diag_log format ["PTWS - Time until next forecast:%1",_timeforecastMinutes];
	uiSleep _timeforecast;
	};
};

if (PTWS_timeAcc) then
{
	diag_log "PTWS - TimeAcc Initialized";
	[60, PTWS_fnc_timeAcc, [], true] call ExileServer_system_thread_addTask;
};


/**
 * ExileClient_object_player_stats_updateTemperature
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_timeElapsed","_forcedBodyTemperatureChangePerMinute","_wetnessChangePerMinute","_altitude","_isSwimming","_bodyTemperature","_bodyWetness","_temperatureConfig","_fromDayTimeTemperature","_toDayTimeTemperature","_environmentTemperature","_playerIsInVehicle","_playerVehicle","_isFireNearby","_startPosition","_endPosition","_intersections","_isBelowRoof","_clothingColdProtection","_movementInfluence","_regulation","_environmentInfluence"];
/*
// PTWS Season Temperature Control
*/

_month = date select 1;
_season = "";

_WinterEnd = 1;
_SpringEnd = 4;
_SummerEnd = 7;
_FallEnd = 10;

if ((_month > _WinterEnd) && (_month <= _SpringEnd)) then // The season will be the month after _PreviousSeasonEnd and the months upto and including _ThisSeasonEnd ex. Spring starts on Feb and ends in Apr. 
{
	_season = "Spring";
};

if ((_month > _SpringEnd) && (_month <= _SummerEnd)) then
{
	_season = "Summer";
};

if ((_month > _SummerEnd) && (_month <= _FallEnd)) then
{
	_season = "Fall";
};

if (_month == 11 || _month == 12 || _month == 1) then //The previous conditions won't work when the season includes December: 12 and January: 1 because x cannot be both >= 12 and  =< 1; 
{
	_season = "Winter";
};

_mapOverride = true; //Set true if you want the season to stay the same for specific maps, you can add more below. 

if (_mapOverride) then
{
	switch (worldName) do {
		case "tanoa": { _season = "Summer"; };
		case "namalsk": { _season = "Fall"; };
	};
};

//diag_log format["PTWS - Current Season:%1",_season];

_seasonDaytimeTemperature = [];

//Switches the daytimeTemperature array based on the season, this replace the values in the mission config.
switch (_season) do {
    case "Winter": { _seasonDaytimeTemperature = [-6.93,-5.89,-4.42,-3.40,-2.68,-1.10,1.48,2.63,3.40,4.66,5.32,6.80,6.80,5.32,4.66,3.40,2.63,1.48,-1.10,-2.68,-3.40,-4.42,-5.89,-6.93,-7.93]; };
    case "Spring": { _seasonDaytimeTemperature = [9,11,14,17,20,24,26,27,28,28,28,27,26,28,28,28,27,26,24,20,17,14,11,9,8]; };
    case "Summer": { _seasonDaytimeTemperature = [15.93,16.89,18.42,20.40,22.68,25.10,27.48,29.63,31.40,32.66,33.32,33.80,33.80,33.32,32.66,31.40,29.63,27.48,25.10,22.68,20.40,18.42,16.89,15.93,15.93]; };
    case "Fall": { _seasonDaytimeTemperature = [-2.00,-1.77,-1.12,-0.10,1.24,2.78,4.40,6.00,7.46,8.65,9.50,9.90,9.90,9.50,8.65,7.46,6.00,4.40,2.78,1.24,-0.10,-1.12,-1.77,-2.00,-2.00]; };
};

//diag_log format["PTWS - Current Temperature Array:%1",_seasonDaytimeTemperature];

/*
// PTWS Season Temperature Control
*/
_timeElapsed = _this;
_forcedBodyTemperatureChangePerMinute = 0;
_wetnessChangePerMinute = -0.1;
_altitude = ((getPosASL player) select 2) max 0;
_isSwimming = (_altitude < 0.1) || (underwater player);
_bodyTemperature = ExileClientPlayerAttributes select 5;
_bodyWetness = ExileClientPlayerAttributes select 6;
_temperatureConfig = missionConfigFile >> "CfgExileEnvironment" >> worldName >> "Temperature";
//_fromDayTimeTemperature = (getArray (_temperatureConfig >> "daytimeTemperature")) select (date select 3);
//_toDayTimeTemperature = (getArray (_temperatureConfig >> "daytimeTemperature")) select ((date select 3) + 1); 
_fromDayTimeTemperature = _seasonDaytimeTemperature select (date select 3);
_toDayTimeTemperature = _seasonDaytimeTemperature select ((date select 3) + 1); 
_environmentTemperature = [_fromDayTimeTemperature, _toDayTimeTemperature, (date select 4) / 60] call ExileClient_util_math_lerp;
_environmentTemperature = _environmentTemperature + overcast * (getNumber (_temperatureConfig >> "overcast"));
_environmentTemperature = _environmentTemperature + rain * (getNumber (_temperatureConfig >> "rain"));
_environmentTemperature = _environmentTemperature + windStr * (getNumber (_temperatureConfig >> "wind"));
_environmentTemperature = _environmentTemperature + _altitude / 100 * (getNumber (_temperatureConfig >> "altitude"));
if (_isSwimming) then 
{
	_environmentTemperature = _environmentTemperature + (getNumber (_temperatureConfig >> "water"));
};
ExileClientEnvironmentTemperature = _environmentTemperature;
_playerIsInVehicle = false;
_playerVehicle = vehicle player;
if !(_playerVehicle isEqualTo player) then 
{
	try 
	{
		if (_playerVehicle isKindOf "Exile_Bike_QuadBike_Abstract") throw false;
		if (_playerVehicle isKindOf "Exile_Bike_OldBike") throw false;
		if (_playerVehicle isKindOf "Exile_Bike_MountainBike") throw false;
		throw true;
	}
	catch
	{
		_playerIsInVehicle = _exception;
	};
};
if (_playerIsInVehicle) then 
{
	if (isEngineOn _playerVehicle) then 
	{
		_forcedBodyTemperatureChangePerMinute = 0.05; 
		_wetnessChangePerMinute = -0.5; 
	}
	else 
	{
		_forcedBodyTemperatureChangePerMinute = 0.01; 
		_wetnessChangePerMinute = -0.2; 
	};
}
else 
{
	if (_isSwimming) then 
	{
		_wetnessChangePerMinute = 99999; 
	}
	else 
	{
		_isFireNearby = [ASLtoAGL (getPosASL player), 5] call ExileClient_util_world_isFireInRange;
		if (_isFireNearby) then 
		{
			_forcedBodyTemperatureChangePerMinute = 1; 
			_wetnessChangePerMinute = -0.5; 
		}
		else 
		{
			if (rain > 0.1) then 
			{
				_startPosition = getPosASL player;
				_endPosition = [_startPosition select 0, _startPosition select 1, (_startPosition select 2 ) + 10];
				_intersections = lineIntersectsSurfaces [_startPosition, _endPosition, player, objNull, false, 1, "GEOM", "VIEW"];
				_isBelowRoof = !(_intersections isEqualTo []);
				if !(_isBelowRoof) then 
				{
					_wetnessChangePerMinute = rain; 
				};
			};
		};
	};
};
_bodyWetness = ((_bodyWetness + _wetnessChangePerMinute / 60 * _timeElapsed) max 0) min 1;
if (ExileClientEnvironmentTemperature > 25) then 
{
	_forcedBodyTemperatureChangePerMinute = 0.5; 
};
if (_forcedBodyTemperatureChangePerMinute > 0) then 
{
	_bodyTemperature = _bodyTemperature + _forcedBodyTemperatureChangePerMinute / 60 *_timeElapsed;
}
else 
{
	_clothingColdProtection = 0;
	if !((uniform player) isEqualTo "") then 
	{
		_clothingColdProtection = _clothingColdProtection + 0.25;
	};
	if !((headgear player) isEqualTo "") then 
	{
		_clothingColdProtection = _clothingColdProtection + 0.05;
	};
	if !((vest player) isEqualTo "") then 
	{
		_clothingColdProtection = _clothingColdProtection + 0.10;
	};
	_clothingColdProtection = ((_clothingColdProtection * (1 - (_bodyWetness * 0.5))) max 0) min 1;
	_movementInfluence = 0;
	if ((getPos player) select 2 < 0.1) then 
	{
		_movementInfluence = (37 - _bodyTemperature) * (1 - (_bodyWetness * 0.5)) * 0.075 * (vectorMagnitude (velocity player))/6.4;
	};
	if (_bodyTemperature < 37) then 
	{
		_regulation = 0.1;
	}
	else 
	{
		_regulation = -0.1; 
	};
	_environmentInfluence = (1 - _clothingColdProtection) * (-0.2 + 0.008 * ExileClientEnvironmentTemperature);
	_bodyTemperature = _bodyTemperature + (_regulation + _movementInfluence + _environmentInfluence) / 60 *_timeElapsed;
};
_bodyTemperature = _bodyTemperature min 37;
if (_bodyTemperature < 35) then 
{
	player setDamage ((damage player) + 0.1/60*_timeElapsed); 
};
ExileClientPlayerAttributes set [6, _bodyWetness];
ExileClientPlayerAttributes set [5, _bodyTemperature];

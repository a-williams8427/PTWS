	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013-2015 Nicolas BOITEUX

	Real weather for MP GAMES v 1.3 adapted for PTWS
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

private ["_lastrain","_rain","_overcast","_fogValue","_fogDecay","_fogHeight","_wind"];
_lastrain = rain;
_rain = 0;
_overcast = 0;
_fogValue = 0;
_fogDecay = 0;
_fogHeight =0;
_wind = [0,0,true];

_overcast = random 1;
if(_overcast > 0.5) then { 
	_rain = random 0.5;
} else { 
	_rain = 0;
};

if((date select 3 > 5) and (date select 3 <10)) then { 
	_fogValue = 0.2 + (random 0.8);
	_fogDecay = 0.2;
	_fogHeight = random 20;
} else { 
	if((_lastrain > 0.6) and (_rain < 0.2)) then {
		_fogValue = random 0.4;
		_fogDecay = 0;
		_fogHeight = 0;
	} else {
		_fogValue = 0;
		_fogDecay = 0;
		_fogHeight = 0;
	};
};

if(random 1 > 0.95) then 
{
	_wind = [random 7, random 7, true];
} 
else 
{
	_wind = [random 3, random 3, false];
};

wcweather = [_rain, [_fogValue,_fogDecay,_fogHeight], _overcast, _wind, date];
60 setRain (wcweather select 0);
60 setfog (wcweather select 1);
60 setOvercast (wcweather select 2);
setwind (wcweather select 3);

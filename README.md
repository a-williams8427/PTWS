# PTWS
####Persistent Time and Weather System

PTWS is a script made for Exile that allows time and weather to persist through server restarts. It also has seasons defined by months that will change the temperature. 

#### Features
* Persistent time (year, month, day, hour, minute)
* Persistent weather
* Dynamic weather (thanks to code34's Real weather)
* Seasons that change the temperature
* Snow based on temperature and current overcast
* Time accleration

#### To-do List
* ~~Add Persistent weather~~
* ~~Configure seasons based on months~~
* Make the seasons affect more than the temperature
* ????

## Installation

#### extDB
1) Execute `PTWS-SQL.sql` in your mySQL viewer.

2) You should now have a ptws table.

3) Copy the contents of `PTWS.ini` into your `@ExileServer\extDB\sql_custom_v2\exile.ini` file at the bottom.

##### Server
1) Take either the PTWS.pbo or the file and put it in your `@ExileServer\addons`. Use the file if you want to configure the settings and pack it after you're done.

##### Mission
1) Copy `PTWS` from `Mission Files\mpmissions\Exile.Yourmap` into the root of your Exile.Yourmap folder.

2) Open your `config.cpp` in your mission folder and edit your `CfgExileCustomCode` and add a two new lines inside like this:
`ExileServer_system_weather_initialize = "PTWS\ExileServer_system_weather_initialize.sqf";`
`ExileClient_object_player_stats_updateTemperature = "PTWS\ExileClient_object_player_stats_updateTemperature.sqf";`
`ExileClient_system_snow_thread_update = "PTWS\ExileClient_system_snow_thread_update.sqf";`

#### You are done!

# PTWS
####Persistent Time and Weather System

PTWS is a script made for Exile that allows time (and hopefully weather soon) to persist through server restarts. This is far from done but I think in its current state it is still useful for RP, or for people who want to run their servers on smaller time multipliers and still have their players experience a full day/night cycle.

#### Features
* Persistent time (year, month, day, hour, minute)
* Time accleration

#### To-do List
* Add Persistent weather
* Configure seasons based on months
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

2) Open your `config.cpp` in your mission folder and edit your `CfgExileCustomCode` and add a new line inside like this:
`ExileServer_system_weather_initialize = "PTWS\ExileServer_system_weather_initialize.sqf"`

#### You are done!

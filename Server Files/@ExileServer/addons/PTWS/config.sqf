PTWS_ID = "PTWS"; // The name of the id that will be in database, if changed the system will create a new entry and start over.
PTWS_StartingDate = [2016,8,22,12,0]; // The date that the server will start on NOTE: Must be in this format [year, month, day, hour, minute] see https://community.bistudio.com/wiki/date
PTWS_StartingWeather = [0,0,[0,0,0],[0,0,false],0,0,0,0,0]; //The weather parameters that the server will start with. NOTE: Must be in this format [overcast,rain,[fogValue, fogDecay, fogBase],[windx, windy, forced],gusts,lightnings,waves] 

PTWS_timeAcc = true; // Enables/Disables the time multipliers for day and night. 
PTWS_timeAccNightStart = 18; // The 24hr time that the night multiplier starts. 		Default: 18 = 6:00PM
PTWS_timeAccDayStart = 6; // The 24hr time that the day multiplier starts. 				Default:6 = 6:00AM 
PTWS_timeAccMultiplierNight = 6; //The multiplier for night time acceleration. 			Default: 6x = 2 hour nights
PTWS_timeAccMultiplierDay = 4; //The multiplier for day time acceleration. 				Default: 4x = 3 hour days

PTWS_weatherChangeFast = false; //If set to true, the weather will change every PTWS_weatherChangeMin seconds, if false it will change sometime between PTWS_weatherChangeMax and PTWS_weatherChangeMin.
PTWS_weatherChangeMax = 5400;
PTWS_weatherChangeMin = 900;

PTWS_CompiledOkay = true;

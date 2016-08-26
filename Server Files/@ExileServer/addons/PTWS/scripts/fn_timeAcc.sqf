//Borrowed the the template from second_coming's occupation mod.
private["_timeMultiplier"];
if (daytime > PTWS_timeAccNightStart || daytime < PTWS_timeAccDayStart) then 
{ 
    _timeMultiplier = PTWS_timeAccMultiplierNight; 
} 
else  
{
    _timeMultiplier = PTWS_timeAccMultiplierDay;
};

if(timeMultiplier != _timeMultiplier) then { setTimeMultiplier _timeMultiplier; };

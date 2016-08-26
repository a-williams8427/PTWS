class CfgPatches
{
	class PTWS {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_server"};
		author[]= {"MajorXAcE"};
	};
};

class CfgFunctions {
	class PTWS {
		class main {			
			class postInit
			{
				postInit = 1;
				file = "\PTWS\initServer.sqf";
			};
		};
		
		class compiles
		{
			file = "\PTWS\scripts";
			class saveDate 			{};
			class saveWeather		{};
			class controlWeather	{};
			class timeAcc			{};
		};
	
	};
};
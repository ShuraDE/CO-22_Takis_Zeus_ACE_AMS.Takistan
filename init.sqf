waituntil {!isnil "bis_fnc_init"}; 																	// Indikator gibt aus das alle bis BIS Funktionen fertig geladen sind  


//global vars

spawn_injured_cooldown_active = false;


//precompile sqf scripts
adl_fnc_vital_monitor_enable = compile preprocessFile "fnc\vitalMonitor.sqf";
adl_fnc_vital_monitor_disable = compile preprocessFile "fnc\disableMonitor.sqf";

adl_fnc_spawn_injured = compile preprocessFile "fnc\spawnInjured.sqf";
adl_fnc_destroy_medevac = compile preprocessFile "fnc\destroyMedevac.sqf";
adl_fnc_spawn_proband = compile preprocessFile "fnc\spawnProband.sqf";
adl_fnc_destroy_proband = compile preprocessFile "fnc\exitProband.sqf";

//no LR Radio for team leaders;
tf_no_auto_long_range_radio = true;

S_INIT = false;  																					// Variablen deklariert
S_CLIENT = false; 

if(isServer) then {S_INIT = true;}
else
{
	S_CLIENT = true;if(isNull player)then{[] spawn {waitUntil {!isNull player};S_INIT = true;}} else {S_INIT = true;};  	// erst wenn Player auf Karte wird init.sqf weitergelden
};
waitUntil{S_INIT};


//define equipment for each player
if !(isNull player) then {
	call compile preprocessFile "fnc\medicEquipment.sqf";
};

//set monitor variable to nil
JK_ViralMonitorPFH = nil;

//define ace interaction extension
call compile preprocessFile "fnc\aceMenu.sqf";



//Adler Intro
// ***********************************************************************************

titleCut ["", "BLACK FADED", 999]; 
[] Spawn {

titleText ["","PLAIN"]; 
titleFadeOut 1;
sleep 2;

titleCut ["", "BLACK IN", 2];

waitUntil {time > 3};
	["<img size= '6' shadow='false' image='pic\gruppe-adler.paa'/><br/><t size='.9' color='#FFFFFF'>Zeus ACE3 - AMS Training</t>",0,0,3,4] spawn BIS_fnc_dynamicText;
};


// Sonstiges
// ***********************************************************************************

enableSentences false;
0 setFog [0.0, 0.012, 0.0];
setViewDistance 3000;

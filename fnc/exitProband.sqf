(_this select 0) stop false;
_wp = (group (_this select 0)) addWaypoint [getMarkerPos "spawnProband", 0];

if ( count _this > 1) then {
	_wp setWaypointSpeed "LIMITED";
	
	//warten auf timer
	sleep (_this select 1);
	
	//anhalten und unmächtig setzen
	(_this select 0) stop true;
	[_this select 0] call ace_medical_fnc_setUnconscious;
	
	//werte manipulieren
	_this select 0 setVariable ["ace_medical_heartRate", (_this select 2), true];
	_this select 0 setVariable ["ace_medical_bloodPressure", [(_this select 2)+10,(_this select 2)+40], true];	
} else {
	_wp setWaypointSpeed "FULL";
};


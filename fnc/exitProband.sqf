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
	
	
	/* manuell wegschicken
	//warten bis behandlung auf ungefähren normal status ist
	waitUntil {
		sleep 1;
		if (alive (_this select 0)) exitWith {true};
		_hr = (_this select 0) getVariable ["ace_medical_heartRate", 80]; 
		(_hr >= 50 && _hr <= 80);
	};
	
	(_this select 0) stop false;
	_wp = (group (_this select 0)) addWaypoint [getMarkerPos "spawnProband", 0];
	_wp setWaypointSpeed "SAVE";
	*/
} else {
 _wp setWaypointSpeed "FULL";
};


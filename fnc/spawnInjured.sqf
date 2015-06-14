



if (spawn_injured_cooldown_active) then {
	waitUntil {hint "medevac cooldown active\nspawn delayed"; sleep 1;!spawn_injured_cooldown_active};
	hint "";
};
spawn_injured_cooldown_active = true;
	

_groupSize = 10;
if (count _this >= 1) then {_groupSize = _this select 0;};

//create group
_grpTango = createGroup west;
_grpMedEvac = createGroup west;

//create units
"ARC_GER_Tropentarn_soldier_M" createUnit [getMarkerPos "spawnMarker", _grpTango, "", 0.7, "corporal"];
for "_i" from 1 to (_groupSize-1) do {"ARC_GER_Tropentarn_soldier_M" createUnit [getMarkerPos "spawnMarker", _grpTango, "", 0.5, "private"];};
sleep 1;

//wound all
"Bo_GBU12_LGB_MI10" createVehicle (getMarkerPos "spawnMarker");
sleep 2;

//spawn transporter
_veh = "B_Truck_01_medical_F" createVehicle getMarkerPos "medicTruckSpawn";
"ARC_GER_Tropentarn_soldier_M" createUnit [getMarkerPos "medicTruckSpawn", _grpMedEvac, "", 0.5, "private"];
{
	_x moveInDriver _veh; 
} forEach units _grpMedEvac;


//move all units from group in cargo
_i = 17;
{
	_x assignAsCargoIndex [_veh, _i];
	_x moveInCargo _veh; 

	//hint name _x;
	//_veh moveInCargo [_x, _i];
	_i = _i -1;
} forEach units _grpTango;


_wp =_grpMedEvac addWaypoint [getMarkerPos "medEvacEnd", 0];
sleep 5;
spawn_injured_cooldown_active = false;

deleteGroup _grpTango;
deleteGroup _grpMedEvac;
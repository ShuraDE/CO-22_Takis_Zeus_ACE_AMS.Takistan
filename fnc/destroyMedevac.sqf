_veh = _this select 0;

_wp = (group (driver _veh)) addWaypoint [getMarkerPos "medEvacExit", 0];


sleep 60;

//_veh deleteVehicleCrew driver _veh;
{_veh deleteVehicleCrew _x} forEach crew _veh;

sleep 1;

deleteVehicle _veh;
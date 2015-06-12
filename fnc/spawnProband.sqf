//create group
_grpProband = createGroup west;

//create units
"B_engineer_F" createUnit [getMarkerPos "spawnProband", _grpProband, "", 0.5, "private"];

{
	removeAllWeapons _x;
	removeAllItems _x;
	removeAllAssignedItems _x;
	removeUniform _x;
	removeVest _x;
	removeBackpack _x;
	removeHeadgear _x;
	removeGoggles _x;
	
	_x forceAddUniform "U_C_Scientist";
	
} forEach units _grpProband;


_wp =_grpProband addWaypoint [position player, 0];


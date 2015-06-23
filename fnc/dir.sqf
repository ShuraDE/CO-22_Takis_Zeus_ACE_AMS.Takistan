//source: facing direction: http://forums.bistudio.com/showthread.php?121711-Finding-out-which-way-the-player-view-is-facing-%28not-direction%29
_a = 10;
while {_a =_a + 1; _a > 0} do {
	
	_target = if (isNull cursorTarget) then { player;} else { cursorTarget; };
	
	_pos1 = screenToWorld [0.5,0.5];
	_pos2 = getPos _target;
	//_dirWatching = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;
	
	_pos = getPosATL _target;

	//get facing direction
	_posStW = screenToWorld [0.5,0.5];
	_dirWatching = ((((_posStW select 0) - (_pos select 0)) atan2 ((_posStW select 1) - (_pos select 1))) + 360) % 360;	
	
	
	_posBody = getPosATL _target;
	
	hint format["looking in %1 direction\nbody direction is %2\nloc %3 %4 %5\ndirVisual %6\nstance %7\nstance id %8",(round _dirWatching), getDir _target, (_posBody select 0), (_posBody select 1), (_posBody select 2), getDirVisual _target, stance _target,[2, 1, 0, -1, -1] select (["STAND", "CROUCH", "PRONE", "UNDEFINED", ""] find stance _target)];

	sleep 1;
	
	//stances: ["STAND", "CROUCH", "PRONE", "UNDEFINED", ""]
};
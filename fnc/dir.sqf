//source: facing direction: http://forums.bistudio.com/showthread.php?121711-Finding-out-which-way-the-player-view-is-facing-%28not-direction%29
_a = 10;
while {_a =_a + 1; _a > 0} do {

	_pos1 = screenToWorld [0.5,0.5];
	_pos2 = getPos player;
	_dirWatching = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;
	
	_posBody = getPosATL player;
	
	hint format["looking in %1 direction\nbody direction is %2\nloc %3 %4 %5\ndirVisual %6\nstance %7",(round _dirWatching), getDir player, (_posBody select 0), (_posBody select 1), (_posBody select 2), getDirVisual player, stance player];
	sleep 1;
};
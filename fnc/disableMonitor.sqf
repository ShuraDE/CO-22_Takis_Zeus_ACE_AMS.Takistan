if (isNil "JK_ViralMonitorPFH") exitWith { hintSilent "Kein Tracker Attached" };
[JK_ViralMonitorPFH] call CBA_fnc_removePerFrameHandler;
JK_ViralMonitorPFH = nil;
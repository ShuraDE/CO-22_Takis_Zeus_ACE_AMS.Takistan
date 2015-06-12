/*
//	Very simple ECG (electrocardiogram) to train new medics trainees "ACE adv medic system" 
//  					for Gruppe Adler (www.gruppe-adler.de)
// 
//	Input optional Target, optional Duration (s); default values: cursorTarget, 9s
//	
// Output: hint box with a tendency from --- to +++ 
//
// Name [name _target]
// Pulse [pulse] [tendency]
// Bloodpresure [diastolic/systolic] [tendency]
// Duration [seconds remains on display]
*/


_target = player;
_duration = 10;
_target = cursorTarget;
_publicHint = 0; //hint via BIS_fnc_MP _publicHint == 1


if (count _this >= 3) then {_publicHint = _this select 2;};
if (count _this >= 2) then {_duration = _this select 1;};
if (count _this >= 1) then {_target = _this select 0;};


_msg_target = format["Person: %1", "Unbekannter"];
if (alive _target) then {
	_msg_target = format["Person: %1",name _target];
} else {
	if (_publicHint == 1) then {
		["He is dead","hint",true,true] call BIS_fnc_MP;
	} else {
		hint "He is dead";
	};	
};


// define init data
_lastPulse = _target getVariable ["ace_medical_heartRate",-1];
_lastBloodPresure = _target getVariable ["ace_medical_bloodPressure",[-1,-1]];

_lastSystolicBloodPresure = _lastBloodPresure select 1;
_lastDiastolicBloodPresure = _lastBloodPresure select 0;



_msg_pulse_history = "";
_msg_bloodPresure_history = "";
_msg_info = "";

//show for each second
while {_duration > 0 } do {
	
	
	_pulse = 0;
	_bloodPresure = [0,0];
	_diastolicBloodPresure = 0;
	_systolicBloodPresure = 0;
	_bloodVolume = 0;
	
	if (_pulse == -1) then {
		_duration = 0;
	};
	
	if (!alive _target) then 
	{		
		_duration = 0;
		_msg_info = "He is gone...";		
	} else {		
		_pulse = round (_target getVariable ["ace_medical_heartRate",-1]);
		_bloodPresure = _target getVariable ["ace_medical_bloodPressure", [-1,-1]];
		_bloodVolume  = _target getVariable ["ace_medical_bloodVolume",-1];
		_diastolicBloodPresure = _bloodPresure select 0;
		_systolicBloodPresure = _bloodPresure select 1;		
		
		_msg_info = format["End monitoring in %1s",_duration];		
	};
	
	//each 3s check for new tendency
	if (_duration mod 3 == 0 && _duration > 0) then {
		
		//check pulse tendency 
		_tmpCalc = _pulse-_lastPulse;
		_msg_pulse_history = switch (true) do {
								case (_tmpCalc < -2): {"---"};
								case (_tmpCalc < -1): {"--"};
								case (_tmpCalc < 0): {"-"};
								case (_tmpCalc == 0): {""};
								case (_tmpCalc > 2): {"+++"};
								case (_tmpCalc > 1): {"++"};
								case (_tmpCalc > 0): {"+"};
							};
							
		//check bloodpresure tendency 
		_tmpCalc = _diastolicBloodPresure-(_lastBloodPresure select 0);
		_msg_bloodPresure_history = switch (true) do {
								case (_tmpCalc < -2): {"---"};
								case (_tmpCalc < -1): {"--"};
								case (_tmpCalc < 0): {"-"};
								case (_tmpCalc == 0): {""};
								case (_tmpCalc > 2): {"+++"};
								case (_tmpCalc > 1): {"++"};
								case (_tmpCalc > 0): {"+"};
							};		
		
		//renew last values
		_lastPulse = _pulse;
		_lastBloodPresure = _bloodPresure;	
	};
	
	_msg_puls = format["Pulse: %1 %2", round(_pulse), _msg_pulse_history];
	_msg_bloodPresure = format["Bloodpresure: %1/%2 %3", round _diastolicBloodPresure, round _systolicBloodPresure, _msg_bloodPresure_history];
	_msg_bloodVolume = format["Bloodvolume: %1",_bloodVolume];
	
	if (_duration > 0) then {
		//hint format["%1 \n%2 \n%3 \n%4",_msg_target, _msg_puls, _msg_bloodPresure, _msg_info];
		if (_publicHint == 1) then {
			[format["%1 \n%2 \n%3 \n%4 \n%5",_msg_target, _msg_puls, _msg_bloodPresure, _msg_bloodVolume, _msg_info],"hint",true,true] call BIS_fnc_MP;
		} else {
			hint format["%1 \n%2 \n%3 \n%4 \n%5",_msg_target, _msg_puls, _msg_bloodPresure, _msg_bloodVolume, _msg_info];
		};
	};
	
	sleep 1;
	_duration = _duration - 1;	
};

hint "";




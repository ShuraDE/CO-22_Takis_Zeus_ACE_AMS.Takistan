/*
//    Very simple ECG (electrocardiogram) to train new medics trainees "ACE adv medic system" 
//          for Gruppe Adler (www.gruppe-adler.de)
// 
//    Input optional Target, optional Duration (s); default values: cursorTarget, 9s
//    
// Output: hint box with a tendency from --- to +++ 
//
// Name [name _target]
// Pulse [pulse] [tendency]
// Bloodpresure [diastolic/systolic] [tendency]
// ----  disabled  ---- Duration [seconds remains on display]
*/

_public = if (count _this >= 2) then { _this select 1 } else { false };
_subject = if (count _this >= 1) then { _this select 0 } else { if !(isNull cursorTarget) then { cursorTarget }else{ player }};
//_time = if (count _this >= 2) then { _this select 1 }  else { 3 };

if !(isNil "JK_ViralMonitorPFH") exitWith { hintSilent "Tracker schon Attached" };


_lastPulse = round (_subject getVariable ["ace_medical_heartRate",80]);
_lastBloodPressure = _subject getVariable ["ace_medical_bloodPressure", [80,120]];

if (isServer || !(_public)) then {

	JK_ViralMonitorPFH = [{
		_target = (_this select 0) select 0;	
		_publicHint = (_this select 0) select 1;
		
		_lastPulse  = (_this select 0) select 2;
		_lastBloodPressure = (_this select 0) select 3;
		
		if !(alive _target) exitWith {
			if (_publicHint) then {
				["He is dead","hintsilent",true,true] call BIS_fnc_MP;
			} else {
				hintsilent "He is dead";
			};
			[JK_ViralMonitorPFH] call CBA_fnc_removePerFrameHandler;
			JK_ViralMonitorPFH = nil;
		};

		_appliedMeds = _target getVariable ["ace_medical_allUsedMedication", []];  //usefull
		_painLevel = _target getVariable ["ace_medical_pain", 0];  //usefull

		_pulse = round (_target getVariable ["ace_medical_heartRate",80]);
		_bloodPressure = _target getVariable ["ace_medical_bloodPressure", [80,120]];
		_bloodVolume  = _target getVariable ["ace_medical_bloodVolume",100];
		_diastolicBloodPressure = _bloodPressure select 0;
		_systolicBloodPressure = _bloodPressure select 1;

		_tmpCalc = _pulse-_lastPulse;
		_msg_pulse_history = call {
			if (_tmpCalc < -2) exitWith {"---"};
			if (_tmpCalc < -1) exitWith {"--"};
			if (_tmpCalc < 0) exitWith {"-"};
			if (_tmpCalc > 2) exitWith {"+++"};
			if (_tmpCalc > 1) exitWith {"++"};
			if (_tmpCalc > 0) exitWith {"+"};
			if (_tmpCalc == 0) exitWith {""};
			""
		};

		//check bloodpresure tendency
		_tmpCalc = _diastolicBloodPressure - (_lastBloodPressure select 0);
		_msg_bloodPressure_history = call {
			if (_tmpCalc < -2) exitWith {"---"};
			if (_tmpCalc < -1) exitWith {"--"};
			if (_tmpCalc < 0) exitWith {"-"};
			if (_tmpCalc > 2) exitWith {"+++"};
			if (_tmpCalc > 1) exitWith {"++"};
			if (_tmpCalc > 0) exitWith {"+"};
			""
		};
		
		//renew last values
		_lastPulse = _pulse;
		_lastBloodPressure = _bloodPressure;
		
		_msg_pulse = format["Pulse: %1 %2", round(_pulse), _msg_pulse_history];
		_msg_bloodPressure = format["Bloodpresure: %1/%2 %3", round _diastolicBloodPressure, round _systolicBloodPressure, _msg_bloodPressure_history];
		_msg_bloodVolume = format["Bloodvolume: %1",_bloodVolume];

		/*
		_msgAppliedMed = [];
		{
			_msgAppliedMed pushBack ((_x select 1) select 0);
			true
		} count _appliedMeds;
		_msg_inVitro = format["Active Substances:\n%1",str(_msgAppliedMed)];
		_msg_pain = format["Pain Level: %1", _painLevel];
		*/

		_message = format["Person: %1 \n%2 \n%3 \n%4", name _target, _msg_pulse, _msg_bloodPressure, _msg_bloodVolume];

		if (_publicHint) then {
			[_message,"hintSilent",true,true] call BIS_fnc_MP;
		} else {
			hintSilent _message;
		};

	},1,[_subject,_public, _lastPulse, _lastBloodPressure]] call CBA_fnc_addPerFrameHandler;
};

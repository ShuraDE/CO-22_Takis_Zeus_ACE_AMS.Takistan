// ACE Menü für Training

//deaktiviert da training abgeschlossen ist
//if (name player == "Shura" || name player == "Fraggi") then {
	
	//class types for ace menu
	_TypesAllBLUFOR =["B_officer_F","B_Soldier_TL_F","B_soldier_exp_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_AR_F","B_Soldier_A_F","B_medic_F","B_Helipilot_F","ARC_GER_Tropentarn_medic","ARC_GER_Tropentarn_soldier_AR","ARC_GER_Tropentarn_soldier_exp","ARC_GER_Tropentarn_soldier_GL","ARC_GER_Tropentarn_Soldier_Base","ARC_GER_Tropentarn_soldier_M","B_engineer_F"];

	//health monitor
	_actionVitalMonitorAppend = ["vital_monitor", "append", "", {[_target] spawn adl_fnc_vital_monitor_enable}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionVitalMonitorAppendPublic = ["vital_monitor", "append for all", "", {[[[_target, true],"fnc\vitalMonitor.sqf"],"BIS_fnc_execVM",false,true] call BIS_fnc_MP}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionVitalMonitorRemove = ["vital_monitor", "remove", "", {[_target] spawn adl_fnc_vital_monitor_disable}, {true;}] call ace_interact_menu_fnc_createAction;

	//lieferung (verletzte und probanden)
	_actionGetNewMedEvac_10 = ["new_medevac", "ETA 50s, n10, Injured", "", {[[[10],adl_fnc_spawn_injured],"BIS_fnc_spawn",false,true] call BIS_fnc_MP}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionGetNewMedEvac_5 = ["new_medevac", "ETA 50s, n5, Injured", "", {[[[5],adl_fnc_spawn_injured],"BIS_fnc_spawn",false,true] call BIS_fnc_MP}, {true;}] call ace_interact_menu_fnc_createAction;	
	_actionGetNewProband = ["new_proband", "ETA 10s, n1, Healthy", "", {[] spawn adl_fnc_spawn_proband;}, {true;}] call ace_interact_menu_fnc_createAction;
	
	//removing orders
	_actionExitMedevac = ["exit_medevac", "Return Base", "", {[_target] spawn adl_fnc_destroy_medevac;}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionExitProband = ["exit_proband_norm", "Regular", "", {[_target] spawn adl_fnc_destroy_proband;}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionExitProbandCollLow = ["exit_proband_coll", "Collapse low", "", {[_target, 6, 35] spawn adl_fnc_destroy_proband;}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionExitProbandCollHigh = ["exit_proband_coll", "Collapse high", "", {[_target, 6, 140] spawn adl_fnc_destroy_proband;}, {true;}] call ace_interact_menu_fnc_createAction;
	
	//Submenü Definition
	_actionSubMenuVitals = ["vital_monitoring","Vitalmonitor","", {}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionSubMenuMedevac = ["medevac","Medevac","", {}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionSubMenuProband = ["proband","Proband","", {}, {true;}] call ace_interact_menu_fnc_createAction;
	_actionSubMenuExitProband = ["proband","Go back","", {}, {true;}] call ace_interact_menu_fnc_createAction;
	
	//append menu actions to menu
	{
		[_x, 0, ["ACE_MainActions"], _actionSubMenuVitals] call ace_interact_menu_fnc_addActionToClass;
		
		[_x, 0, ["ACE_MainActions","vital_monitoring"], _actionVitalMonitorAppend] call ace_interact_menu_fnc_addActionToClass;
		[_x, 0, ["ACE_MainActions","vital_monitoring"], _actionVitalMonitorRemove] call ace_interact_menu_fnc_addActionToClass;
		
		if (player in [Zeus1,Zeus2] || name player == "Shura") then {
			[_x, 0, ["ACE_MainActions","vital_monitoring"], _actionVitalMonitorAppendPublic] call ace_interact_menu_fnc_addActionToClass;
		};

		
		[_x, 1, ["ACE_SelfActions"], _actionSubMenuProband] call ace_interact_menu_fnc_addActionToClass;
		[_x, 1, ["ACE_SelfActions","proband"], _actionGetNewProband] call ace_interact_menu_fnc_addActionToClass;
		[_x, 1, ["ACE_SelfActions"], _actionSubMenuMedevac] call ace_interact_menu_fnc_addActionToClass;
		[_x, 1, ["ACE_SelfActions","medevac"], _actionGetNewMedEvac_5] call ace_interact_menu_fnc_addActionToClass;
		[_x, 1, ["ACE_SelfActions","medevac"], _actionGetNewMedEvac_10] call ace_interact_menu_fnc_addActionToClass;
	}forEach _TypesAllBLUFOR;	
	
	//medevac truck wegschicken
	["B_Truck_01_medical_F", 0,  ["ACE_MainActions"], _actionExitMedevac] call ace_interact_menu_fnc_addActionToClass;		
	["B_engineer_F", 0,  ["ACE_MainActions"], _actionSubMenuExitProband] call ace_interact_menu_fnc_addActionToClass;		
	["B_engineer_F", 0,  ["ACE_MainActions", "proband"], _actionExitProband] call ace_interact_menu_fnc_addActionToClass;
	["B_engineer_F", 0,  ["ACE_MainActions", "proband"], _actionExitProbandCollLow] call ace_interact_menu_fnc_addActionToClass;
	["B_engineer_F", 0,  ["ACE_MainActions", "proband"], _actionExitProbandCollHigh] call ace_interact_menu_fnc_addActionToClass;
//};

if (isServer) then {

private _logic = _this param [0,objNull,[objNull]];
private _groupVehicles = _this param [1,[],[[]]];

private _leaderVeh = _groupVehicles select 0;
_leaderVeh setVariable ["convoy_stopped", false, true];
_leaderVeh setVariable ["convoy_terminate", false, true];
_leaderVeh setVariable ["convoy_behaviourChanged", false, true];	// Note: used to fix some unknown bug with the module (can be set to true on script execution)

// call the "driver changes system" for each vehicle
// writes --> On Each Vehicle: 	{"driverIncapacitated", "vehicleIncapacitated","terminate_driverTransitions"}
// reads -->  On Each Vehicle: 	{"terminate_driverTransitions"}
for [{ _i = 0 }, { _i < count _groupVehicles }, { _i = _i + 1 }] do {
	call{ null = [_groupVehicles select _i] execFSM "\nagas_Convoy\functions\fn_driverTransitions.fsm" };
};

// call the "dynamic convoy system"
// writes --> On Leader: 		{"convoy_stopped","convoy_terminate"}
// reads -->  On Each Vehicle: 	{"driverIncapacitated","vehicleIncapacitated","convoy_terminate"}
call{ null = [_logic,_groupVehicles] execFSM "\nagas_Convoy\functions\fn_dynamicConvoyElements.fsm" };

// behaviour manager
call{ null = [_logic,_groupVehicles] execFSM "\nagas_Convoy\functions\fn_behaviorManager.fsm" };

// speed control Leader
call{ null = [_logic,_groupVehicles] execVM "\nagas_Convoy\functions\fn_leadSpeedControl.sqf" };

// speed control link
call{ null = [_logic,_groupVehicles] execVM "\nagas_Convoy\functions\fn_linkSpeedControl.sqf" };

// set path
call{ null = [_logic,_groupVehicles] execVM "\nagas_Convoy\functions\fn_pathCreator.sqf" };

};

true
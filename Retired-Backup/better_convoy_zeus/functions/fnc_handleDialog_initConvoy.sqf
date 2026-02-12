#include "script_component.hpp"
/* File: fnc_handleDialog_initConvoy.sqf
 * Author(s): riksuFIN
 * Description: Handles first part of creating a convoy from zeus module
 *
 * Called from: Zeus diealog
 * Local to:	Client
 * Parameter(s):
 * 0:	Data from dialog. Not meant for manual execution
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_better_convoy_zeus_fnc_handleDialog_initConvoy
*/

params ["_dialogValues", ["_convoy", objNull]];
_dialogValues params ["_convoyName", "_maxSpeed", "_seperation", "_awareness", "_behaviour", "", ["_stiffnessCoef", 0.2], ["_dampingCoef", 0.6], ["_curvesSlowdown", 0.3], ["_linkStiffness", 0.1], ["_pathFrequency", 0.05], ["_speedControlFrequency", 0.2], ["_debug", false]];

if (GVAR(debug)) then {systemChat format ["[RAA] %1", _this]; RAA_debug = _this};

// If convoy logic doesnt exist yet create a new one
if (isNull _convoy) then {
	// Check if group for logics is created yet..
	if (isNull GVAR(logicGroup)) then {
		GVAR(logicGroup) = createGroup sideLogic; 
		publicVariable QGVAR(logicGroup);
	};
	
	_convoy = GVAR(logicGroup) createUnit ["Logic", [0,0,0], [], 0, "NONE"];
	
	if (GVAR(debug)) then {systemChat format ["[RAA] Convoy %1 is new, creating logic %2", _convoyName, _convoy];};
};

// Update/ define all settings to logic
_convoy setVariable ["convoyName", _convoyName, true];
_convoy setVariable ["maxSpeed", _maxSpeed, true];
_convoy setVariable ["convSeparation", _seperation, true];
_convoy setVariable ["stiffnessCoeff", _stiffnessCoef, true];
_convoy setVariable ["dampingCoeff", _dampingCoef, true];
_convoy setVariable ["curvatureCoeff", _curvesSlowdown, true];
_convoy setVariable ["stiffnessLinkCoeff", _linkStiffness, true];
_convoy setVariable ["pathFrequecy", _pathFrequency, true];
_convoy setVariable ["speedFrequecy", _speedControlFrequency, true];
_convoy setVariable ["speedModeConv", _awareness, true];
_convoy setVariable ["behaviourConv", _behaviour, true];
_convoy setVariable ["debug", _debug, true];

// Find dialog ID's for these two, to be used in modify existing convoy -dialog
private _id = 0;
switch (_awareness) do {
	case ("UNCHANGED"): {_id = 0};
	case ("LIMITED"): {_id = 1};
	case ("NORMAL"): {_id = 2};
	case ("FULL"): {_id = 3};
};
_convoy setVariable ["awarenessID", _id, true];

switch (_behaviour) do {
	case ("AWARE"): {_id = 0};
	case ("pushThroughContact"): {_id = 1};
};
_convoy setVariable ["behaviourID", _id, true];



// Save logic reference for later usage
GVAR(allConvoys) pushBack _convoy;
publicVariable QGVAR(allConvoys);


/*
// create the convoy
[Convoy_01,[vehicleLead,vehicle2,vehicle3]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf"

// stop the convoy without erasing its waypoints
Convoy_01 setVariable ["maxSpeed", 0];
sleep 5; // wait for all vehicles to stop

// disband the convoy
vehicleLead setVariable ["convoy_terminate", true];
sleep .5; // wait for script to finish

// create a new convoy with only the first two vehicles
call{ 0 = [Convoy_01,[vehicleLead,vehicle2]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

// resume
Convoy_01 setVariable ["maxSpeed", 40];
*/


// Next we need to find vehicles for convoy

["NEW", objNull, nil, [_convoy, _convoyName]] call FUNC(createConvoy_selectNextVehicle);









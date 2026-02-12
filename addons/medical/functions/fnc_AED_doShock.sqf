#include "script_component.hpp"
/* File: fnc_defib_aed.sqf
 * Author(s): riksuFIN
 * Description: Handle using AED ground item
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_AED_doShock
*/

params ["_medic", "_patient", ["_aed", objNull], ["_trials", 0]];
if (RAA_misc_debug) then {systemChat format ["[RAA_ACEA] AED_doShock: %1", _this];};


if (_aed isEqualTo objNull || (_aed distance _patient) > 7) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED device too far from patient!";};
	if !(isNull _aed) then {
		[_aed, "RAA_AED_speak_connection_lost", 40] call EFUNC(common,3dSound);
		_aed setVariable ["RAA_AED_inUse", false, true];
	};
};





/*
[	{
	[_this select 0, "RAA_AED_speak_shock_delivered_analyzing", 40] call EFUNC(common,3dSound);
	}, [_aed]] call CBA_fnc_execNextFrame;
*/

[_aed, "RAA_AED_speak_shock_delivered_analyzing", 40] call EFUNC(common,3dSound);

[_patient, "RAA_AED_effect_shock", 40] call EFUNC(common,3dSound);


// Send shock to nearby clients. This script will run client-side and check if they're touching patient, and, if they are, harm them
private _nearMens = nearestObjects [_patient, ["CAManBase"], 5];
[_patient, objNull] remoteExec ["RAA_fnc_ACEA_defib_doDamage_local", _nearMens];

// Add event to treatment log
[_patient, "activity", format ["%1 used AED", name _medic], []] call ace_medical_treatment_fnc_addToLog;


// Roll dice to check if we were successfull
if (random 1 < RAA_ACEA_AEDSuccessChance) then {
	// Yep, success!
//	["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
	["ace_medical_CPRSucceeded", _patient, _patient] call CBA_fnc_targetEvent;
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED Shock: Success";};
	
} else {
	// Dice failed, better luck next time
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED Shock: Fail";};
	
};



[	{
		_this call RAA_fnc_ACEA_AED_afterShock;
	}, [
		_medic, _patient, _aed, _trials
	],
	8
] call CBA_fnc_waitAndExecute;





/*
[	{
		copyToClipboard str allVariables player;
	}, [
	],
	5
] call CBA_fnc_waitAndExecute;
*/



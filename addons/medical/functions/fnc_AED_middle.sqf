#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: description
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
 * Example:	[player, cursorObject] call RAA_fnc_ACEA_AED_middle
*/

params ["_medic", "_patient", ["_aed", objNull], ["_trials", 0]];
if (RAA_ACEA_debug) then {systemChat format ["[RAA_ACEA] AED_middle: %1", _this];};


// Check that connected AED is still useable
//private _aed = (nearestObjects [_patient, ["RAA_Item_AED"], 10]) param [0, objNull];
if (_aed isEqualTo objNull || (_aed distance _patient) > 7) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED device too far from patient!";};
	if !(isNull _aed) then {
		[_aed, "RAA_AED_speak_connection_lost", 40] call EFUNC(common,3dSound);
		_aed setVariable ["RAA_AED_inUse", false, true];
	};
};


if !(_patient getVariable ["ace_medical_incardiacarrest", false]) exitWith {
	
	// Patient is no longer in cardiadic arrest and therefore does not need a shock
	[_aed, "RAA_AED_speak_no_shock_adviced", 40] call EFUNC(common,3dSound);
	_aed setVariable ["RAA_AED_inUse", false];
	
	[	{
			[_this select 0, "RAA_AED_speak_safe_to_touch", 40] call EFUNC(common,3dSound);
		}, [
			_aed
		],
		2
	] call CBA_fnc_waitAndExecute;
};





//playSound3D ["\r\misc\addons\RAA_ACE_additions\sounds\AED_prep.ogg", _aed, false, [], 1, 1, 15];

[_aed, "RAA_AED_speak_preparing_shock", 40] call EFUNC(common,3dSound);


[	{
		_this call RAA_fnc_ACEA_AED_doShock;
	}, [
		_medic, _patient, _aed, _trials
	],
	9
] call CBA_fnc_waitAndExecute;

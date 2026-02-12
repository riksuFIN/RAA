#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: Start AED device script
 *
 * Called from: Medical menu
 * Local to: Client who operated AED
 * Parameter(s):
 0:	Medic who operated AED <OBJECT>
 1:	Patient <OBJECT>
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_AED_start
*/

params ["_medic", "_patient"];

/*
_patient setVariable [QEGVAR(medical,CPR_provider), _medic, true];
*/

private _aed = (nearestObjects [_patient, ["RAA_Item_AED"], 10]) param [0, objNull];
if ((_aed isEqualTo objNull) || (_aed getVariable ["RAA_AED_inUse", false])) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED device too far from patient or already in use!";};
};


// Make sure one AED is not used for two patients at once
_aed setVariable ["RAA_AED_inUse", true, true];



[_aed, "RAA_AED_speak_prep", 40] call EFUNC(common,3dSound);


/*
playSound3D ["\r\misc\addons\RAA_ACE_additions\sounds\AED_prep.ogg", _aed, false, [], 1, 1, 15];
*/

[	{
		_this call RAA_fnc_ACEA_AED_middle;
	}, [
		_medic, _patient, _aed
	],
	23
] call CBA_fnc_waitAndExecute;

#include "script_component.hpp"
/* File: .sqf
 * Author(s): riksuFIN
 * Description: Checks if AED device is present nearby on ground and available
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Medic <OBJECT>
 1:	Patient <OBJECT>
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_AED_canUse
*/

params ["_medic", "_patient"];

if !(_patient getVariable ["ace_isunconscious", false]) exitWith {
	false
};

private _nearestObjects = nearestObjects [_patient, ["RAA_Item_AED"], 7];

if (_nearestObjects isEqualTo []) exitWith {false};

private _nearestObject = _nearestObjects select 0;

if (_nearestObject getVariable ["RAA_AED_inUse", false]) exitWith {false};


true
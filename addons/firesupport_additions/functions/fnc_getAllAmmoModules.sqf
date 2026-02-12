#include "script_component.hpp"
/* File: fnc_getAllAmmoModules.sqf
 * Author(s): riksuFIN
 * Description: Apply new, modified params to gun
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
 Returns: ARRAY of all ammo modules, in order of their ID. Includes "nil" if some slot is not used
[AMMOMODULE_0, AMMOMODULE_1, AMMOMODULE_2]
 
 *
 * Example:	[GUNMODULE] call RAA_firesupport_additions_fnc_getAllAmmoModules
*/
params ["_module"];

if (isNull _module) exitWith {
//	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] [ERROR] fnc_getAllAmmoModules, %1 is null", _module];};
	[]
};


private _ammoModules = [];
//_ammoModules resize 3;	// Ensure array is at least this long
{
//	_ammoModules set [_x getVariable ["RAA_ammoSlotID", 9], _x];
	_ammoModules set [_x getVariable ["RAA_ammoSlotID", 9], _x];
//	_ammoModules pushBack _x;		//  Add this one to list (object reference)
	
} forEach synchronizedObjects _module;

if (RAA_firesA_debug) then {
	if (count _ammoModules > 5) then {
		systemChat format ["[RAA_firesA] [Note] Ammo modules count is out of bounds (%1 long)", count _ammoModules];
	};
};


// Sort array to order of ID
_ammoModules = [_ammoModules, [], { _x getVariable ["RAA_ammoSlotID", 9] }, "ASCEND"] call BIS_fnc_sortBy;


_ammoModules
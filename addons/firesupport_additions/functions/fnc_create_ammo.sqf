#include "script_component.hpp"
/* File:	fnc_create_ammo.sqf
 * Author: 	riksuFIN
 * Description:	Spawns new ammo logic for arty and syncs it to parent arty logic
 	
 
 
 * Called from:	Various
 * Local to: 		Client
 * Parameter(s):
 0:	
 1:	
 2:	
 Returns:		Created logic object <OBJECT> OR false in case of error
 * 
 * Example:
	[] call RAA_firesA_fnc_createAmmo
 */

params ["_ammoClassname", "_ammoCount", "_parentModule", "_ammoID", "_ammoSlotID"];


// Check if group for logics is created yet..
if (isNull RAA_firesA_group_artyLogics) then {
	RAA_firesA_group_artyLogics = createGroup sideLogic; 
};


// Create logic object that acts as arty ammo unit (virtual)
private _object = RAA_firesA_group_artyLogics createUnit ["RAA_logic_artyAmmo", getPos _parentModule, [], 0, "NONE"];

if (isNull _object) exitWith {
	systemChat "[RAA_firesA] ERROR: Failed to create gun module!";
	false
};

/*
// Extended network debug
if (RAA_firesA_debug) then {
	[_object, "Ammo", _ammoClassname, false, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
};
*/

_object setVariable ["Ammo", _ammoClassname, true]; 
_object setVariable ["count", _ammoCount, true]; 
_object setVariable ["currentCount", _ammoCount, true]; 
_object setVariable ["reservedCount", 0, true]; 

_object setVariable ["RAA_ammoID", _ammoID, true]; 		// This tells ammo type this module holds
_object setVariable ["RAA_ammoSlotID", _ammoSlotID, true]; 	// This tells order of modules in list


//_parentModule synchronizeObjectsAdd [_object];

// Sync this newly created module to gun module
// Since synchronizeObjectsAdd command seems to have unexpected behaviour in MP we will execute it on everyone
if (isMultiplayer) then {
	[_parentModule, [_object]] remoteExec ["synchronizeObjectsAdd", -2];
} else {
	[_parentModule, [_object]] remoteExec ["synchronizeObjectsAdd", 0];
};



if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] New ammo module %1 slot %2 ID %3 created (%4 x %5)", _object, _ammoSlotID, _ammoID, _ammoCount, _ammoClassname];};


// Return object reference
_object
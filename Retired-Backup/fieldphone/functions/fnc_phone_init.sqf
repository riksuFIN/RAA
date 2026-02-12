#include "script_component.hpp"
/* File: fnc_phone_init.sqf
 * Author(s): riksuFIN
 * Description: Used to init field_object when it is placed down
 *
 * Called from: Object init
 * Local to:	Everyone
 * Parameter(s):
 * 0:	fieldphone object <OBJECT>
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/




params ["_object"];


if !(isServer) exitWith {};

if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] field_phone init for %1", _object];};

// ACRE init
[_object] call acre_api_fnc_initVehicleRacks;

// Set radio channel to default disconnected channel
[[[_object] call acre_api_fnc_getVehicleRacks select 0] call acre_api_fnc_getMountedRackRadio, DISCONNECTED_CHANNEL] call acre_api_fnc_setRadioChannel;

_object setObjectTextureGlobal [1,QPATHTOF(pics\phone_disconnected.paa)];

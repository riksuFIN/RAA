#include "script_component.hpp"
/* File: fnc_debug_remoteExec.sqf
 * Author(s): riksuFIN
 * Description: Called by handleDialog_editAmmo and handleDialog_editGun to all clients _if_ client who called this 
 *						Supplied with variable and its value. Waits untill client's knowledge and supplied one match and gives headups
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Object where variable is attached to (if not global) <OBJECT>
 1:	Variable name <STRING>
 2:	Value this variable should be once synced
 3:	Is global variable. False for variable attached to object <BOOL>
 4:	Time this fnc was remoteExecuted. Used to measure how long it took for chance to happen
 *
 Returns:
 *
 * Example:	[_object, "someVariable", "someValue", false, serverTime] call FUNC(debug_remoteExec)
*/

params [["_object", objNull], "_variable", "_value", "_isGlobal", "_timeSent"];

// This debug functio should only be ran for clients with debug setting on
if !(RAA_firesA_debug) exitWith {};


if (_isGlobal) then {
	
	[	{		// Condition
			params ["", "", "_variable", "_value"];
			_variable isEqualTo _value
		}, {	// Code
			systemChat format ["[RAA_firesA] Debug: %1 synchronized in %2 seconds", _this select 0, serverTime - _this select 1];
		}, [	// Params
			_variable, _timeSent, _variable, _value
		],		// Timeout
			60,
		{		// Timeout code
			systemChat format ["[RAA_firesA] Debug variable sync over network: %1 failed to sync in time", _this select 0];
		}
	] call CBA_fnc_waitUntilAndExecute;
	
	
} else {
	if (isNull _object) exitWith {systemChat "[FiresA] [ERROR] Debug fnc supplied with null object!"};
	[	{		// Condition
			params ["", "", "_variable", "_value", "_object"];
			(_object getVariable [_variable, ""]) isEqualTo _value
		}, {	// Code
			systemChat format ["[RAA_firesA] Debug: %1 synchronized in %2 seconds", _this select 0, serverTime - _this select 1];
		}, [	// Params
			_variable, _timeSent, _variable, _value, _object
		],		// Timeout
			60,
		{		// Timeout code
			systemChat format ["[RAA_firesA] Debug variable sync over network: %1 failed to sync in time", _this select 0];
		}
	] call CBA_fnc_waitUntilAndExecute;
	
	
};








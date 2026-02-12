#include "script_component.hpp"
/* File: fnc_deployItem.sqf
 * Author(s): riksuFIN
 * Description: Removes given item from player's inventory and deploys physical version of it, using ACE carrying system
 *
 * Called from: 
 * Local to: Client
 * Parameter(s):
 0:	Inventory item <CLASSNAME>
 1:	Physical item to deploy <CLASSNAME>
 2:	Unit who did deploying <OBJECT, default player>
 *
 Returns: spawned object
 *
 * Example:	[cursorObject] call RAA_common_fnc_deployItem
*/
params ["_inventoryItem", "_item", ["_unit", player]];



private _result = [player, _inventoryItem] call CBA_fnc_removeItem;
if !(_result) exitWith {
	systemChat format ["[RAA_common] [ERROR] Failed to remove %1 from %2's inventory", _item, _unit];
};




private _object = _item createVehicle position _unit; 


// Allow time to spawn item.
[	{		// Condition
		params ["_unit", "_object"];
		(_unit distance _object) < 10
	}, {	// Code
		_this call ace_dragging_fnc_startCarry
	}, [	// Params
		_unit, _object
	],		// Timeout
	3,
	{
		if (RAA_misc_debug) then {systemChat format ["[RAA_common] Timeout for startCarry. Distance %1", _unit distance _object];};
	}
] call CBA_fnc_waitUntilAndExecute;



_object




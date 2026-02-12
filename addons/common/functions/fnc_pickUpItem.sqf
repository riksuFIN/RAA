#include "script_component.hpp"
/* File: fnc_pickupItem.sqf
 * Author(s): riksuFIN
 * Description: Pick up physical object from ground to inventory
 *
 * Called from: 
 * Local to: Client
 * Parameter(s):
 0:	object <OBJECT>
 1:	inventory item <CLASSNAME>
 2:	Unit who picked it up <OBJECT, default player>
 3:	Provide feedback if fail <BOOL, default true>
 *
 Returns: Success <BOOL>
 *
 * Example:	[cursorObject, "RAA_fieldphone_item"] call RAA_common_fnc_pickUpItem
*/
params ["_object", "_item", ["_unit", player], ["_feedback", true]];


// Do we have enough inventory space?
if !([_unit, _item] call CBA_fnc_canAddItem) exitWith {
	if (_feedback) then {
		systemChat "Insuffient inventory space";
		false
	};
};


private _result = [_unit, _item, false] call CBA_fnc_addItem;
if !(_result) exitWith {
	systemChat "[RAA_common] [ERROR] Failed to add item to inventory";		// This should never trigger since space is already checked before
	false
};


deleteVehicle _object;

/* This anim puts weapon to back first, thats no-go
// Drop animation
[_unit, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon", 1] call ace_common_fnc_doAnimation;
*/


true
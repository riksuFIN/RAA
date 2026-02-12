#include "script_component.hpp"
/* File: fnc_beltSlot_canMoveFrombelt.sqf
 * Author(s): riksuFIN
 * Description: Checks if it is possible to move item from belt to inventory
 *
 * Called from: ACE action menu
 * Local to:	Client
 * Parameter(s):
 0:	beltSlot <NUMBER>				0 for left, 1 for right slot
 1:	Unit <OBJECT, default player>
 2:	
 3:	
 4:	
 *
 Returns: Can move item <BOOL>
 *
 * Example:	[0, player] call RAA_misc_fnc_beltSlot_canMoveFrombelt
*/

params ["_slot", ["_unit", ACE_player]];


private _beltSlots = _unit getVariable [QGVAR(data), []];

private _classname = (_beltSlots param [_slot, []]) param [0, ""];

if (_classname isEqualTo "") exitWith {
	false
};


if ([_unit, _classname] call CBA_fnc_canAddItem) exitWith { true };

false


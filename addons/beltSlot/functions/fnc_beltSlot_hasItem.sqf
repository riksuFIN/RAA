#include "script_component.hpp"
/* File: fnc_beltSlot_hasItem.sqf
 * Author(s): riksuFIN
 * Description: Checks if given item is on belt
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Item to search for <STRING (Classname)>
 * 1:	Unit to search from <OBJECT, default player>
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: hasItemOnBelt <BOOL>
 *
 * Example:	
 *	["ACE_Canteen", player] call RAA_misc_fnc_beltSlot_hasItem
*/
params ["_item", ["_unit", ACE_player]];

private _beltSlotData = _unit getVariable [QGVAR(data), []];

private _return = false;
{
	if (_x param [0, ""] isEqualTo _item) exitWith {
		_return = true;
	};
	
} forEach _beltSlotData;

//if (GVAR(debug)) then {systemChat format ["[RAA_misc] hasItem returned %1. Searched for %2 from %3", _return, _item, _unit];};

// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE]]


_return
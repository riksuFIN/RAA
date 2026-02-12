#include "script_component.hpp"
/* File: fnc_beltSlot_getItems.sqf
 * Author(s): riksuFIN
 * Description: Returns array of item classnames that are on belt.
 						Resulting array only contains actual classnames, if any, no empty strings.
 *
 * Local to:	Client
 * Parameter(s):
 * 0:	Unit to search from <OBJECT, default player>
 *
 Returns: Items on belt <ARRAY of classnames>
 *
 * Example:	
 *	[player] call RAA_beltSlot_fnc_beltSlot_getItems
*/
params [["_unit", ACE_player]];
if (isNull _unit) exitWith {[]};

private _return = [];
private _data = _unit getVariable [QGVAR(data), []];

if (count _data < 1) exitWith {[]};
{
	private _item = _x param [0, ""];
	if (_item isNotEqualTo "") then {
		_return pushBack _item;
	};
	
} forEach _data;

// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE]]
_return


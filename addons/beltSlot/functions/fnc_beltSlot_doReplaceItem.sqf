#include "script_component.hpp"
/* File: fnc_beltSlot_doReplaceItem.sqf
 * Author(s): riksuFIN
 * Description: Replaces existing item on belt with another item
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Unit <OBJECT, default player>
 * 1:	Belt slot OR item's classname <INT or STRING>
 * 2:	Classname of replacer item <STRING>
 * 3:	Return replaced item to inventory <BOOL, default false>
 * 4:	Use existing item from inventory <BOOL, default false>
 *
 Returns: Success <BOOL>
 *
 * Example:	
 *	[] call RAA_misc_fnc_beltSlot_doReplaceItem
*/
params [["_player", ACE_player], ["_slot", -1], "_newItem", ["_returnToInventory", false], ["_useItemFromInventory", false]];


// If classname was supplied find slot ID from that
private _beltDataFull = _player getVariable [QGVAR(data), []];
if (_slot isEqualType "") then {
	{
		if ((_x param [0, ""]) isEqualTo _slot) then {
			_slot = _forEachIndex;
		};
	} forEach _beltDataFull;
};

if (_slot isEqualTo -1) exitWith {};

// Delete old item
private _deletionSuccess = if (_returnToInventory) then {
	[_slot, _player] call FUNC(beltSlot_doMoveFrombelt);
} else {
	[_slot, _player] call FUNC(beltSlot_deleteFromBelt);
};

if !(_deletionSuccess) exitWith {false};

if (_newItem isEqualTo "") exitWith {true};

// Now add new item
["", _player, _newItem, _useItemFromInventory, _slot] call FUNC(beltSlot_doMoveToBelt);


true
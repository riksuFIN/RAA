#include "script_component.hpp"
/* File: fnc_beltSlot_deleteFromBelt.sqf
 * Author(s): riksuFIN
 * Description: Remove item directly from belt without adding it back to unit's inventory
 						If you want to just move item from belt to inventory use fnc_beltSlot_doMoveFromBelt
 *
 * Local to:	Client
 * Parameter(s):
 0:	Belt slot ID OR item classname to delete <NUMBER, default 0> OR <STRING (classname>)
 1:	Unit <OJBECT, default player>
 *
 Returns: Success <BOOL>
 *
 * Example:	[0, player] call RAA_misc_fnc_beltSlot_deleteFromBelt
*/

params [["_slot", 0], ["_unit", ACE_player]];

private _beltDataFull = _unit getVariable [QGVAR(data), []];

// If classname is provided we need to figure out which slot that item is in
if (_slot isEqualType "") then {
	{
		if ((_x param [0, ""]) isEqualTo _slot) then {
			_slot = _forEachIndex;
		};
		
	} forEach _beltDataFull;
};



// Get information about item on belt
private _beltData = _beltDataFull param [_slot, []];

// Array is:
// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT]]

if (_beltData isEqualTo []) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_misc] [ERROR] Beltslot: array is empty";};
	false
};

// Get data about item from belt
//private _classname = _beltData select 0;
private _object = _beltData select 3;
private _weight = _beltData param [4, 0];




// Remove 3D model from belt
deleteVehicle _object;


// Remove virtual weight of item from player
[_unit, _unit, _weight * -1] call ace_movement_fnc_addLoadToUnitContainer;


// Now clear our reference variable
_beltDataFull set [_slot, nil];
_unit setVariable [QGVAR(data), _beltDataFull];


// If inventory screen is open refresh belt images
if !(isNull findDisplay 602) then {
	call FUNC(beltSlot_onInventoryOpened);
};

true
#include "script_component.hpp"
/* File: fnc_beltSlot_canMoveToBelt.sqf
 * Author(s): riksuFIN
 * Description: Checks if belt slots are all in use
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 0:	unit <OBJECT, default player>
 1:	
 2:	
 3:	
 4:	
 *
 Returns: Can move item to belt <BOOL>
 *
 * Example:	[] call RAA_misc_fnc_beltSlot_canMoveToBelt
*/

params [["_unit", ACE_player]];


private _slots = _unit getVariable [QGVAR(data), []];

private _freeSlots = 0;

for "_i" from 0 to BELTSLOT_NUMBEROFSLOTS do {
	if ((_slots param [_i, []]) isEqualTo []) then {
	//	_freeSlots = _freeSlots + 1;
		INC(_freeSlots);
	};
};


/*
if ((_slots param [1, []]) isEqualTo []) then {
	_freeSlots = _freeSlots + 1;
};
*/


// Count used slots
if (_freeSlots > 0) exitWith {
	true
};

false
#include "script_component.hpp"
/* File: fnc_beltSlot_doMoveFrombelt.sqf
 * Author(s): riksuFIN
 * Description: Adds item from belt to unit's inventory and deletes belt 3d model
 *
 * Called from: ACE action
 * Local to:	Client
 * Parameter(s):
 0:	Belt slot <NUMBER>	0 for slot 1, 1 for slot 2
 1:	Unit <OJBECT, default player>
 2:	Container to move item to. Used by inventory drag-and-drop system <INT, default -1>
 3:	Source container IDC. Used by inventory drag-and-drop system. <INT, default -1>
 *
 Returns: Success <BOOL>
 *
 * Example:	[0, player] call RAA_beltSlot_fnc_beltSlot_doMoveFrombelt
*/

params [["_slot", -1], ["_unit", ACE_player], ["_container", -1], ["_sourceContainerIDC", -1]];

if (_slot isEqualTo -1 && _sourceContainerIDC isEqualTo -1) exitWith {false};

// Support for drag-and-drop system. Use dialog ID to find out which slot we just dragged item from
private _exit = false;
if (_sourceContainerIDC > 0) then {
	switch (_sourceContainerIDC) do {
		case (1288): {_slot = 0};
		case (1289): {_slot = 1};
	//	case (-1): {};
		default {_exit = true};
	};
};

// Inventory drag-and-drop EH will trigger this fnc for every item move, including those not related to belt
if (_exit) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] doMoveFromBelt exit, undesired execution";};
};

// Get information about items on belt
private _beltDataFull = _unit getVariable [QGVAR(data), []];
private _beltData = _beltDataFull param [_slot, []];


// Array is:
// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT]]

if (_beltData isEqualTo []) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] [ERROR] Beltslot: array is empty";};
	false
};

// Get data about item from belt
private _classname = _beltData select 0;
private _object = _beltData select 3;
private _weight = _beltData param [4, 0];


// Check if there's enough space in inventory
private _uniform = true;
private _vest = true;
private _backpack = true;
private _externalContainer = false;
switch (_container) do {
	case (0): {_uniform = true; _vest = false; _backpack = false};
	case (1): {_uniform = false; _vest = true; _backpack = false};
	case (2): {_uniform = false; _vest = false; _backpack = true};
	case (9): {_externalContainer = true};
};

if !(_externalContainer) then {
	if !([_unit, _classname, 1, _uniform, _vest, _backpack] call CBA_fnc_canAddItem) exitWith {
		_exit = true;
		systemChat "No space in inventory";
	};
};
if (_exit) exitWith {false};


// Add item to unit's inventory
switch (_container) do {
	case (0): {_unit addItemToUniform _classname};
	case (1): {_unit addItemToVest _classname};
	case (2): {_unit addItemToBackpack _classname};
	case (9): {	// External container
		private _container = _unit getVariable [QGVAR(beltSlot_openedContainer), objNull];
		if (isNull _container) then {
			_container = createVehicle ["GroundWeaponHolder", position _unit, [], 0, "CAN_COLLIDE"];
			_unit setVariable [QGVAR(beltSlot_openedContainer), _container];
		};
		//	_container addItemCargoGlobal [_classname, 1];
			private _success = [_container, _classname, 1, true] call CBA_fnc_addItemCargo;										// TODO NOTE: CBA_fnc_addItemCargo is really bad fnc! Replace with something better if possible!
			if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Added %1 to %2. Success: %3", _classname, _container, _success];};
	};
	default {_unit addItem _classname};
};

if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Moving %1 to inventory %2", _classname, _container];};

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
#include "script_component.hpp"
#include "../defines.hpp"
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
		case (IDC_RAA_BELTSLOT_SLOT1): {_slot = 0};
		case (IDC_RAA_BELTSLOT_SLOT2): {_slot = 1};
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
private _classname = _beltData param [0, ""];
private _object = _beltData param [3, objNull];
private _weight = _beltData param [4, 0];
private _itemType = _beltData param [6, 0];
private _ammoCount = _beltData param [7, -1];


// Check if there's enough space in inventory
private _uniform = true;
private _vest = true;
private _backpack = true;
private _externalContainer = false;
private _output = false;
switch (_container) do {
	case (0): {_uniform = true; _vest = false; _backpack = false};	// Uniform
	case (1): {_uniform = false; _vest = true; _backpack = false};	// Vest
	case (2): {_uniform = false; _vest = false; _backpack = true};	// Backpack
	case (3): {_externalContainer = true};							// Headgear
	case (9): {_externalContainer = true};							// Ground
};


if (!_externalContainer && {!([_unit, _classname, 1, _uniform, _vest, _backpack] call CBA_fnc_canAddItem)}) exitWith {
	systemChat "No space in inventory";
	false
};

// Check target slot is head or general inventory.
private _oldHeadGear = "";
if (_container isEqualTo 3) then {

	// Check if item actually is headgear and, if it is, put hat on.
	if (_itemType isEqualTo 605) then {

		_oldHeadGear = headgear _unit;
		_unit addHeadgear _className;
	} else {
		_exit = true;
	};
} else {
	
	// Add item to unit's inventory
	switch (_container) do {
		case (0): {if (_ammoCount >= 0) then {_unit addMagazine [_classname, _ammoCount]} else {_unit addItemToUniform _classname}};
		case (1): {if (_ammoCount >= 0) then {_unit addMagazine [_classname, _ammoCount]} else {_unit addItemToVest _classname}};
		case (2): {if (_ammoCount >= 0) then {_unit addMagazine [_classname, _ammoCount]} else {_unit addItemToBackpack _classname}};
		case (9): {	// External container
			private _container = _unit getVariable [QGVAR(beltSlot_openedContainer), objNull];
			if (isNull _container) then {
				_container = createVehicle ["GroundWeaponHolder", position _unit, [], 0, "CAN_COLLIDE"];
				_unit setVariable [QGVAR(beltSlot_openedContainer), _container];
			};
				if (_ammoCount >= 0) then {_container addMagazineAmmoCargo [_className, 1, _ammoCount];} else {
					private _success = [_container, _classname, 1, true] call CBA_fnc_addItemCargo;				// TODO NOTE: CBA_fnc_addItemCargo is bad fnc! Replace with something better if possible!
					if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Added %1 to %2. Success: %3", _classname, _container, _success];};
				};
		};
		default {if (_ammoCount >= 0) then {_unit addMagazine [_classname, _ammoCount]} else {_unit addItem _classname}};
	};
};

if (_exit) exitWith {false};

if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Moving %1 to inventory %2", _classname, _container];};

// Remove 3D model from belt
deleteVehicle _object;

// Remove virtual weight of item from player
[_unit, _unit, _weight * -1] call ace_movement_fnc_addLoadToUnitContainer;

// Now clear our reference variable
_beltDataFull set [_slot, nil];
_unit setVariable [QGVAR(data), _beltDataFull, true];

// Move current helmet to belt if we moved headgear from belt to head
if (_oldHeadGear isNotEqualTo "") then {
	["", _unit, _oldHeadGear, true, _slot] call FUNC(beltSlot_doMoveToBelt);
};

// If inventory screen is open refresh belt images
if !(isNull findDisplay 602) then {
	call FUNC(beltSlot_onInventoryOpened);
};

true

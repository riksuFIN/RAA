#include "script_component.hpp"
#include "../defines.hpp"
/* File: fnc_beltSlot_doMoveToBelt.sqf
 * Author(s): riksuFIN
 * Description: Moves item from inventory to BeltSlot
 *
 * Called from: Various
 * Local to: 	Client. MUST be executed where Unit is local!
 * Parameter(s):
 0: not used
 1: Unit <OBJECT>
 2: Item classname <STRING>
 3: Ignore inventory <BOOL, default false>	If true, enables spawning new item directly to belt without having them in inventory
 4: Desired slot <INT, default -1>	If undefined (-1) will automatically select first free slot
 5: Source <INT, Default: -1>
 6: Magazine Ammo Count <INT, default: -1>
 *
 Returns: Success <BOOL>
 *
 * Examples:	
 		["", player, "ATMine_Range_Mag"] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt	// Move existing item from inventory to belt
		["", this, "ACE_canteen", true] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt		// Spawn new item directly to belt if there's free slot. Place to unit's init
*/
params ["", ["_unit", objNull], ["_classname", ""], ["_ignoreInventory", false], ["_slotToUse", -1], ["_source", -1], ["_ammoCount", -1]];

if !(local _unit) exitWith {
	[COMPNAME, true, "LOG", format ["doMoveToBelt: Failed to move to belt: %1 is not local", _unit]] call EFUNC(common,debugNew);
	false
};

private _beltData = _unit getVariable [QGVAR(data), []];

// Support for special source slots
switch (_source) do {
	case (IDC_SLOT_HEADGEAR): {_classname = headgear _unit;};	// headgear
	case (IDC_SLOT_GOGGLES): {_classname = goggles _unit;};		// Goggles
	case (IDC_SLOT_HMD): {_classname = hmd _unit;};			// NGV
	case (IDC_SLOT_BINOCULAR): {_classname = binocular _unit;};	// Binoculars
	case (IDC_RAA_BELTSLOT_SLOT1): {_classname = _beltData param [0, []] param [0, ""]; _ammoCount = _beltData param [0, []] param [7, ""]};
	case (IDC_RAA_BELTSLOT_SLOT2): {_classname = _beltData param [1, []] param [0, ""]; _ammoCount = _beltData param [1, []] param [7, ""]};
};

// This fnc must be executed where unit is local or problems will follow.
// This is to make it easier to be executed by mission maker
if (isNull _unit || _className isEqualTo "") exitWith {
	systemChat "[RAA_beltSlot] [ERROR] doMoveToBelt: Invalid object or classname provided!";
	[COMPNAME, true, "LOG", format ["doMoveToBelt: Invalid object %1 or classname %2 provided", _unit, _classname]] call EFUNC(common,debugNew);
	false
};

// Special handling for swapping beltslots
private _success = false;
if (_source in [IDC_RAA_BELTSLOT_SLOT1,IDC_RAA_BELTSLOT_SLOT2]) exitWith {
	private _sourceSlot = [1,0] select (_source isEqualTo IDC_RAA_BELTSLOT_SLOT1);
	if (_sourceSlot isEqualTo _slotToUse) exitWith {
		[COMPNAME, GVAR(debug), "INFO", "Tried to move from slot to same slot"] call EFUNC(common,debugNew);
	};

	// Copy data from old slot
	private _copySourceSlot = _beltData param [_sourceSlot, []];
	if (_copySourceSlot isEqualTo []) exitWith {[COMPNAME, GVAR(debug), "ERROR", "Nothing to copy over - why did this fnc execute??"] call EFUNC(common,debugNew);};

	_beltData set [_sourceSlot, nil];

	// If target slot is already occupied save that and directly paste it to other side
	private _copyTargetSlot = _beltData param [_slotToUse, []];
	if (_copyTargetSlot isNotEqualTo []) then {

		// Slot is occipied
		_beltData set [_sourceSlot, _copyTargetSlot];
		[_unit, _sourceSlot, _copyTargetSlot param [3, objNull]] call FUNC(attachBeltItem);
	};

	_beltData set [_slotToUse, _copySourceSlot];
	[_unit, _slotToUse, _copySourceSlot param [3, objNull]] call FUNC(attachBeltItem);

	// Refresh slots in inventory screen
	if !(isNull findDisplay 602) then {
		call FUNC(beltSlot_onInventoryOpened);
	};

	_unit setVariable [QGVAR(data), _beltData, true];
	[COMPNAME, GVAR(debug), "INFO", format ["Swapped belSlot %1 to %2", _sourceSlot, _slotToUse]] call EFUNC(common,debugNew);
};


// Find free slot to use
if (_slotToUse isEqualTo -1) then {
	// Slot not defined via parameter, find free one
	if (_beltData param [0, []] isEqualTo []) then {
		_slotToUse = 0;
		
	} else {
		if (_beltData param [1, []] isEqualTo []) then {
			_slotToUse = 1;
		};
	};
} else {
	// Slot defined in parameter, check it is free
	if (_beltData param [_slotToUse, []] isNotEqualTo []) then {

		// Slot is occupied, exit.
		_slotToUse = -1;
	};
	
};
if (_slotToUse < 0) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] Belt is full!";};
	false
};

// Find item's 3D model path
private _config = configFile >> "CfgWeapons" >> _classname;
private _modelPath = getText (_config >> "model");

// Figure out type of item
private _itemType = _classname call BIS_fnc_itemType;

// If item is mine or magazine it will be in cfgMagazines
if (_modelPath isEqualTo "") then {
	_config = configFile >> "CfgMagazines" >> _classname;
	
	_modelPath = getText (_config >> "model");
};

// If we still dont have correct path for model we give up
if (_modelPath isEqualTo "") exitWith {
	if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] [ERROR] Model not found for %1", _classname];};
	false
};


// Delete item from inventory
if (_ignoreInventory) then {
	_success = true;
} else {
	private _container = _unit;
	[COMPNAME, GVAR(debug), "INFO", format ["Source: %1", _source]] call EFUNC(common,debugNew);

	// Handle exception sources
	private _exit = false;
	switch (_source) do {
		case (632);		// Ground
		case (640): {	// External inventory (box, vehicle etc)
			_container = _unit getVariable [QGVAR(beltSlot_openedContainer), objNull];
			if (isNull _container) exitWith {[COMPNAME, GVAR(debug), "WARNING", format ["Failed to find external inventory to remove item from! %1", _container]] call EFUNC(common,debugNew); false};
		};
		case (IDC_SLOT_HEADGEAR): {	// Headgear
			removeHeadgear _unit;
			_success = true;
			_exit = true;
		};
		case (IDC_SLOT_BINOCULAR): {	// Binoculars
			_unit removeWeapon (binocular _unit);
			_success = true;
			_exit = true;
		};
		case (IDC_SLOT_GOGGLES): {	// Goggles
			_unit unlinkItem (goggles _unit);
			_success = true;
			_exit = true;
		};
		case (IDC_SLOT_HMD): {	// NVG
			_unit unlinkItem (hmd _unit);
			_success = true;
			_exit = true;
		};
//		case (IDC_RAA_BELTSLOT_SLOT1): {_success = [0, _unit] call FUNC(beltSlot_deleteFromBelt); _exit = true;};	// Moving between beltslots
//		case (IDC_RAA_BELTSLOT_SLOT2): {_success = [1, _unit] call FUNC(beltSlot_deleteFromBelt); _exit = true;};
	};

	if (_exit) exitWith {};

	private _isHuman = _container isKindOf "CAManBase";	// We need to differiate corpses from boxes
	switch (_itemType select 0) do {
		case ("Equipment");
	//	case ("Item"): {if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeItem} else {_success = [_container, _classname] call CBA_fnc_removeItemCargo}};
		case ("Item"): {
			if (_itemType select 1 isEqualTo "Binocular") then {	// Binocular is classed as item but handled as weapon
				if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeWeapon} else {_success = [_container, _classname] call CBA_fnc_removeWeaponCargo};
			} else {
				if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeItem} else {_success = [_container, _classname] call CBA_fnc_removeItemCargo};
			};
		};
		case ("Magazine");
		case ("Mine"): {if (_isHuman) then {_success = [_container, _classname, _ammoCount] call CBA_fnc_removeMagazine} else {_success = [_container, _classname, 1, _ammoCount] call CBA_fnc_removeMagazineCargo}};
		case ("Weapon"): {if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeWeapon} else {_success = [_container, _classname] call CBA_fnc_removeWeaponCargo}};
	};
	[COMPNAME, GVAR(debug), "INFO", format ["_container: %1, _itemType: %2, _success: %3", _container, _itemType, _success]] call EFUNC(common,debugNew);
};
if !(_success) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Failed to delete %1!", _itemType]] call EFUNC(common,debugNew);
	false
};


// Now that we have model path we can spawn it and place it on belt
private _object = createSimpleObject [_modelPath, getPosASL _unit];

// Attach and orient physical object to character
private _kindOf = [_unit, _slotToUse, _object, _classname] call FUNC(attachBeltItem);
if (_kindOf < 0) exitWith {
	deleteVehicle _object;
	false
};

// Potential fix for potential clipping problems
[_object, false] remoteExec ["setPhysicsCollisionFlag", 0];

// Add EH for get in/ get out of vehicles to handle hiding beltItems
if (_unit getVariable [QGVAR(EH_getIn), -1] isEqualTo -1) then {
	
	private _id = _unit addEventHandler ["GetInMan", {
		[_this select 0, true, _this select 2] call FUNC(beltSlot_onMountingVehicle);
	}];
	
	_unit addEventHandler ["GetOutMan", {
		[_this select 0, false, _this select 2] call FUNC(beltSlot_onMountingVehicle);
	}];

	_unit setVariable [QGVAR(EH_getIn), _id];
};


// Get remaining info we need for array
private _displayName = getText (_config >> "displayName");
	if (_ammoCount >= 0) then {
		_displayName = format ["%1 (%2)", _displayName, _ammoCount];
	};
private _picture = getText (_config >> "picture");
private _canDrink = (getNumber (_config >> "acex_field_rations_thirstQuenched")) > 0;
private _itemTypeCfg = getNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "type");

// Get item's mass. There are two possible config locations for it, depending on item type
private _weight = getNumber (_config >> "mass");
if (_weight isEqualTo 0) then {
	_weight = getNumber (_config >> "ItemInfo" >> "mass");
};

// Array is:
// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE, ITEMTYPE, AMMOCOUNT, KINDOF], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE, ITEMTYPE, AMMOCOUNT, KINDOF]]

// Save all this trash so we can find it again
_beltData set [_slotToUse, [_classname, _picture, _displayName, _object, _weight, _canDrink, _itemTypeCfg, _ammoCount, _kindOf]];
_unit setVariable [QGVAR(data), _beltData, true];

// Add mass of item to player as virtual mass
[_unit, _unit, _weight] call ace_movement_fnc_addLoadToUnitContainer;

// Refresh slots in inventory screen.
if !(isNull findDisplay 602) then {
	_unit action ["Gear", _unit getVariable [QGVAR(beltSlot_openedContainer), objNull]];	// Crude fix for inventory display getting confused after dragging item to slot

	[{call FUNC(beltSlot_onInventoryOpened);}, _unit, 0.5] call CBA_fnc_waitAndExecute;
	//_unit action ["Gear", _unit getVariable [QGVAR(beltSlot_openedContainer), objNull]];
};
// If inventory screen is open refresh belt images
//if !(isNull findDisplay 602) then {call FUNC(beltSlot_onInventoryOpened);};


true

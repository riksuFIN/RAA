#include "script_component.hpp"
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
 5: Source <Default: -1>
 *
 Returns: Success <BOOL>
 *
 * Examples:	
 		["", player, "ATMine_Range_Mag"] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt	// Move existing item from inventory to belt
		["", this, "ACE_canteen", true] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt		// Spawn new item directly to belt if there's free slot. Place to unit's init
*/
params ["", ["_unit", objNull], ["_classname", ""], ["_ignoreInventory", false], ["_slotToUse", -1], ["_source", -1]];


if !(local _unit) exitWith {
	[COMPNAME, true, "LOG", format ["doMoveToBelt: Failed to move to belt: %1 is not local", _unit]] call EFUNC(common,debugNew);
	false
};

/*
// Safety for executing this fnc before player charter exists
if (isNull (_this select 1)) exitWith {
	[	{
			_this call FUNC(beltSlot_doMoveToBelt);
		},
		_this,
		4
	] call CBA_fnc_waitAndExecute;
};
*/

// This fnc must be executed where unit is local or problems will follow.
// This is to make it easier to be executed by mission maker
if (isNull _unit || _className isEqualTo "") exitWith {
	systemChat "[RAA_beltSlot] [ERROR] doMoveToBelt: Invalid object or classname provided!";
	[COMPNAME, true, "LOG", format ["doMoveToBelt: Invalid object %1 or classname %2 provided", _unit, _classname]] call EFUNC(common,debugNew);
	false
};


private _beltSlots = _unit getVariable [QGVAR(data), []];

// Find free slot to use
if (_slotToUse isEqualTo -1) then {
	// Slot not defined via parameter, find free one
	if (_beltSlots param [0, []] isEqualTo []) then {
		_slotToUse = 0;
		
	} else {
		if (_beltSlots param [1, []] isEqualTo []) then {
			_slotToUse = 1;
		};
	};
} else {
	// Slot defined in parameter, check it is free
	if (_beltSlots param [_slotToUse, []] isNotEqualTo []) then {
		_slotToUse = -1;
	};
	
};
if (_slotToUse < 0) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] Belt is full!";};
	false
};


// Find item's 3D model path
private _config1 = configFile >> "CfgWeapons";
private _config = _config1 >> _classname;

private _modelPath = getText (_config >> "model");

// If item is mine or magazine it will be in cfgMagazines

if (_modelPath isEqualTo "") then {
	_config1 = configFile >> "CfgMagazines";
	_config = _config1 >> _classname;
	
	_modelPath = getText (_config >> "model");
//	_isKindOfMine = true;
};

// If we still dont have correct path for model we give up
if (_modelPath isEqualTo "") exitWith {
	if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] [ERROR] Model not found for %1", _classname];};
	false
};

private _kindOf = 0;	// 0: Generic item, 1: mine, 2: headgear, 3: magazine
private _exit = false;
private _itemType = _classname call BIS_fnc_itemType;
switch (_itemType select 0) do {
	case ("Item"): {_kindOf = 0};
	case ("Mine"): {_kindOf = 1};
	case ("Equipment"): {
		_kindOf = 2;
		if (_itemType select 1 isNotEqualTo "Headgear") then {
			_exit = true;
		};
	};
	case ("Magazine"): {_kindOf = 3};
	default {_exit = true};
};
if (_exit) exitWith {
	systemChat "Unsupported item.";
	if (GVAR(debug)) then {[ADDON, "WARNING", format ["Unsupported item %1 classname %2", _itemType, _classname], true, false] call EFUNC(common,debug);};
	false
};



// Delete item from inventory
private _success = false;
if (_ignoreInventory) then {
	_success = true;
} else {
	private _container = _unit;
	[COMPNAME, GVAR(debug), "INFO", format ["Source: %1", _source]] call EFUNC(common,debugNew);
	if (_source isEqualTo 632 || _source isEqualTo 640) then {
		// Item was picked up from external container
		_container = _unit getVariable [QGVAR(beltSlot_openedContainer), objNull];
		if (isNull _container) exitWith {[COMPNAME, GVAR(debug), "WARNING", format ["Failed to find external inventory to remove item from! %1", _container]] call EFUNC(common,debugNew); false};
		
	} else {
		// Item is from unit's uniform
	//	_unit removeItem _classname;
		_success = true;
	};
	
	private _isHuman = _container isKindOf "CAManBase";	// We need to differiate corpses from boxes
	switch (_itemType select 0) do {
		case ("Equipment");
		case ("Item"): {if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeItem} else {_success = [_container, _classname] call CBA_fnc_removeItemCargo}};
		case ("Magazine");
		case ("Mine"): {if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeMagazine} else {_success = [_container, _classname] call CBA_fnc_removeMagazineCargo}};
		case ("Weapon"): {if (_isHuman) then {_success = [_container, _classname] call CBA_fnc_removeWeapon} else {_success = [_container, _classname] call CBA_fnc_removeWeaponCargo}};
	};
	
	[COMPNAME, GVAR(debug), "INFO", format ["_container: %1, _itemType: %2, _success: %3", _container, _itemType, _success]] call EFUNC(common,debugNew);
	//_success = true;
};
if !(_success) exitWith {
	systemChat "[RAA_beltSlot] Failed to delete item from container!";
	false
};




//if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Item type: %1", _kindOf];};


// Overrides for weirdly oriented stuff
switch (_className) do {
	case ("SatchelCharge_Remote_Mag"): {_kindOf = 0};
};



// Now that we have model path we can spawn it and place it on belt
private _object = createSimpleObject [_modelPath, getPosASL _unit];

// Attach model to belt
if (_slotToUse isEqualTo 0) then {
	// -- Left side
	switch (_kindOf) do {
		case (0): {	// Generic item
			_object attachTo [_unit, [-0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];
		};
		case (1): {	// Mine
			_object attachTo [_unit, [-0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[0, 1, 0], [-1, 0, 0]];
		};
		case (2): {	// Headgear
			_object attachTo [_unit, [0.4, 0, -0.33], "Pelvis", true];
			_object setVectorDirAndUp [[-0.8, 0, -2], [-1, 0, 0]];
		};
		case (3): {	// Magazine
			_object attachTo [_unit, [-0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[1, 5, 0], [0, 0, 1]];
		};
	};
	
	
} else {
	// -- Right side
	
	switch (_kindOf) do {
		case (0): {	// Generic item
			_object attachTo [_unit, [0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];
		};
		case (1): {	// Mine
			_object attachTo [_unit, [0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[0, 1, 0], [1, 0, 0]];
		};
		case (2): {	// Headgear
			_object attachTo [_unit, [-0.3, -0.3, -0.33], "Pelvis", true];
			_object setVectorDirAndUp [[0.1, 0, -0.2], [1, 0.5, 0]];
		};
		case (3): {	// Magazine
			_object attachTo [_unit, [0.2, 0, -0.05], "Pelvis", true]; 
			_object setVectorDirAndUp [[1, -5, 0], [0, 0, 1]];
		};
	};
	
	/*
	_object attachTo [_unit, [0.2, 0, -0.05], "Pelvis", true]; 
	// Turn it
	if (_isKindOfMine) then {
		// mine
		_object setVectorDirAndUp [[0, 1, 0], [1, 0, 0]];
		
	} else {
		// Canteen
		_object setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];
	};
	*/
};


// Get remaining info we need
private _displayName = getText (_config >> "displayName");
private _picture = getText (_config >> "picture");
private _canDrink = (getNumber (_config >> "acex_field_rations_thirstQuenched")) > 0;

// Get item's mass
private _weight = 0;
if (_kindOf isEqualTo 1 || _kindOf isEqualTo 3) then {
	// In case of mines and magazines we need to handle them differently
	_weight = getNumber (_config >> "mass");
} else {
	_weight = getNumber (_config >> "ItemInfo" >> "mass");
};


// Array is:
// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE]]

// Save all this trash so we can find it again
_beltSlots set [_slotToUse, [_classname, _picture, _displayName, _object, _weight, _canDrink]];
_unit setVariable [QGVAR(data), _beltSlots];
publicVariableServer QGVAR(data);		// Send belt data to server. This is only used for deleting beltItems on user disconnect

// Add mass of item to player as virtual mass
[_unit, _unit, _weight] call ace_movement_fnc_addLoadToUnitContainer;


// If inventory screen is open refresh belt images
if !(isNull findDisplay 602) then {
	call FUNC(beltSlot_onInventoryOpened);
};


//  BELT ITEM's SIDE //
// Save owner of this belt item and make sure it's global
_object setVariable [QGVAR(beltSlotItem), [_unit, _className, _slotToUse], true];

// Add ACE interaction so other players can grab item from belt.
/* * Arguments:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon file path or Array of icon file path and hex color ("" for default icon) <STRING or ARRAY>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (default: {})
 * 6: Action parameters <ANY> (default: [])
 * 7: Position (Position array, Position code or Selection Name) <ARRAY or CODE or STRING> (default: {[0, 0, 0]})
 * 8: Distance <NUMBER> (default: 2)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (default: all false)
 * 10: Modifier function <CODE> (default: {})
 */
private _actionGrab = ["RAA_grabBeltItem", "Take Item from Belt", "", {[_target, _player] call FUNC(takeFromBelt)}, {true}, {}, [], [0, 0, 0], 2] call ace_interact_menu_fnc_createAction;
//_action = ["VulcanPinch", "Vulcan Pinch", "", {_target setDamage 1;}, {true}, {}, [parameters], [0, 0, 0], 100] call ace_interact_menu_fnc_createAction;


[_object, 0, ["ACE_Actions"], _actionGrab] remoteExec ["ace_interact_menu_fnc_addActionToObject", [0, -2] select isDedicated, true];
//[_object, 0, ["ACE_Actions"], VulcanPinchAction] call ace_interact_menu_fnc_addActionToObject;	// Note: This fnc is not global





/*
//model = "\idi\acre\addons\sys_prc148\Data\models\prc148.p3d";
private _modelPath = getText (_cfgWeapons >> _x >> "model");

// Left side
test2 attachTo [player, [-0.2, 0, -0.05], "Pelvis", true]; 

// Right side
test1 attachTo [player, [0.2, 0, -0.05], "Pelvis", true]; 
 
// Canteen
test1 setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];

// mine
test2 setVectorDirAndUp [[0, 1, 0], [-1, 0, 0]];
*/


true
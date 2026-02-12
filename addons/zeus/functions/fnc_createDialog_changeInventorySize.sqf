#include "script_component.hpp"
/* File: fnc_createDialog_changeInventorySize.sqf
 * Author(s): riksuFIN
 * Description: Creates dialog for changing size of object's inventory or ACE cargo space
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params [["_object", objNull]];

if (isNull _object || _object isKindOf "CAManBase") exitWith {
	["Invalid object selected"] call zen_common_fnc_showMessage;
	if (GVAR(debug)) then {[COMPONENT, "INFO", format ["Invalid object %1", _object], true, false, false] call EFUNC(common,debug);};
};

// Check if object has inventory space
private _inventory_title = "Inventory Size";
private _inventory_tooltip = "Change max size of space for weapons, magazines and other items inside this object.";
private _inventory_defaultSize = maxLoad _object;
private _inventory_maxSize = 20000;
private _inventory_minSize = 1;
if (_inventory_defaultSize isEqualTo 0) then {
	_inventory_title = "[Unsupported object]";
	_inventory_tooltip = "This object does not have accessable inventory space";
	_inventory_maxSize = -99;
	_inventory_defaultSize = -99;
	_inventory_minSize = -99;
};

// Now check if object has ACE cargo space
private ["_cargoSpace_minSize", "_cargoSpace_defaultSize", "_cargoSpace_maxSize", "_cargoSize_defaultSize", "_cargoSize_maxSize"];
private _cargoSpace_title = "ACE Cargo Space";
private _cargoSize_title = "ACE Cargo Size";
if (["ace_cargo"] call ace_common_fnc_isModLoaded) then {
	_cargoSpace_defaultSize = _object getVariable ["ace_cargo_space", -1];
	_cargoSpace_maxSize = 100;
	_cargoSpace_minSize = -1;
	
	//_cargoSize_defaultSize = _object getVariable ["ace_cargo_size", -1];
	_cargoSize_defaultSize = _object call ace_cargo_fnc_getSizeItem;
	_cargoSize_maxSize = 50;
	
} else {
	// ACE Cargo system not loaded
	_cargoSpace_title = "ACE_Cargo Not Loaded!";
	_cargoSize_title = "ACE_Cargo Not Loaded!";
	_cargoSpace_defaultSize = -99;
	_cargoSpace_maxSize = -99;
	_cargoSpace_minSize = -99;
	_cargoSize_defaultSize = -99;
	_cargoSize_maxSize = -99;
};


["CHANGE INVENTORY/ CARGO SIZE",	// Dialog Title
	[	
		["SLIDER",
			[_inventory_title, _inventory_tooltip ],[
				_inventory_minSize,							// Min value
				_inventory_maxSize,	// Max value
				_inventory_defaultSize,	// Default
				0							// Decimals
			],
			true	// Force default
		],
		
		["SLIDER",
			[_cargoSpace_title,
				"Set size of loadable ACE Cargo space (Used for loading ammo boxes, spare tires etc)\n\n0 to disable loading new items. Already loaded cargo will be unloadable. -1 to disabled entire system. Already loaded cargo will be inaccessable, but saved if system is later re-added."
			],[
				_cargoSpace_minSize,							// Min value
				_cargoSpace_maxSize,	// Max value
				_cargoSpace_defaultSize,	// Default
				0							// Decimals
			],
			true	// Force default
		],
		
		["SLIDER",
			[_cargoSize_title,
				"Set how large this object is if loaded inside another object's Cargo.\n\n-1 to make this unloadable."
			],[
				_cargoSpace_minSize,							// Min value
				_cargoSize_maxSize,	// Max value
				_cargoSize_defaultSize,	// Default
				0							// Decimals
			],
			true	// Force default
		],
		
		["EDIT",
			["Name of loadable object",
				"Set custom cargo name for loadable object.\n\nThis is used to differiate item from others in cargo menu.\nOPTIONAL."
			],[
				_object getVariable ["ace_cargo_customName", _object call ace_cargo_fnc_getNameItem],							// Default text
				{}	// Sanitizing function <CODE>
			],
			true	// Force default
		]
		
	], {	// Code to execute upon pressing OK
		
		params ["_dialogValues", "_params"];
		_params params ["_object"];
		_dialogValues params ["_inventorySize", "_cargoSpace", "_cargoSize", "_cargoName"];
		
		// -99 means we have already detected this object does not support inventory.
		if (_inventorySize isNotEqualTo -99) then {
			
			[_object, round _inventorySize] remoteExec ["setMaxLoad", [0, 2] select isMultiplayer];
		};
		
		
		if (_cargoSpace isNotEqualTo -99) then {
				// TODO: Add some more safety checks here to prevent anything stupid
			[_object, round _cargoSpace] call ace_cargo_fnc_setSpace
		};
		
		if (_cargoSize isNotEqualTo -99) then {
			
			[_object, round _cargoSize] call ace_cargo_fnc_setSize
		};
		
		if (_cargoName isNotEqualTo "" && _cargoName isNotEqualTo (_object getVariable ["ace_cargo_customName", ""])) then {
			
			_object setVariable ["ace_cargo_customName", _cargoName, true];
		};
		
		
		
	},
	{},	// On Cancel
	[	// Arguments
		_object	// Unit under cursor
	]
] call zen_dialog_fnc_create;


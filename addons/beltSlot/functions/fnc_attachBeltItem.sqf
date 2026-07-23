#include "../script_component.hpp"
/* File: fnc_attachBeltItem.sqf
* Author(s): riksuFIN
* Description:	Attaches already existing item to belt in correct position and correct orientation
*
* Called from:	
* Local to:		
* Parameter(s):	
* 0:	Unit <OBJECT>
* 1:	Belt slot to use <INT>
* 2:	Belt object <OBJECT>
* 3:	BeltItem's type <INT>
*
Returns: 	Success
*
* Example:	
*	[] call RAA_beltSlot_fnc_attachBeltItem
*/

params [["_unit", ACE_player], ["_slotToUse", -1], ["_object", objNull], ["_kindOf", -1]];

if (_slotToUse < 0 || _object isEqualTo objNull) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Attaching item failed: invalid parameter! %1", _this]] call EFUNC(common,debugNew);
	false
};

if (_kindOf < 0) then {
	_kindOf = (_unit getVariable [QGVAR(data), []] param [_slotToUse, []] param [8, -1]);
};

// Find out how we should orient this item based on its type
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
	[COMPNAME, GVAR(debug), "WARNING", "Attaching item FAILED!"] call EFUNC(common,debugNew);
	false
}

// Overrides for weirdly oriented stuff
switch (typeOf _object) do {
	case ("SatchelCharge_Remote_Mag"): {_kindOf = 0};
};

// Attach model to belt
private _success = true;
switch (_slotToUse) do {
	case (0): {		// -- Left side
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
				
				// Do additional check to see if model is in wrong orientation
				private _boundingBox = 0 boundingBoxReal _object select 0;

				private _selected = _boundingBox find selectMin _boundingBox;
				if (_selected <= 2) then {

				private _turn = [90, 0, 0] select _selected;
				_object setDir _turn;
				[COMPNAME, GVAR(debug), "NOTE", format ["Rotated belt object by %1 degress", _turn]] call EFUNC(common,debugNew);
				} else {
					// Standard orientation
					_object setVectorDirAndUp [[1, 5, 0], [0, 0, 1]];
				};
			};
		};
	};
	
	case (1): {		// -- Right side
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
				
				// Do additional check to see if model is in wrong orientation
				private _boundingBox = 0 boundingBoxReal _object select 0;

				private _selected = _boundingBox find selectMin _boundingBox;
				if (_selected <= 2) then {

				private _turn = [90, 0, 0] select _selected;
				_object setDir _turn;
				[COMPNAME, GVAR(debug), "NOTE", format ["Rotated belt object by %1 degress", _turn]] call EFUNC(common,debugNew);

				} else {
					// Standard orientation
					_object setVectorDirAndUp [[1, -5, 0], [0, 0, 1]];
				};
			};
		};
	};
	default {
		if (_slotToUse < 0) exitWith {
			[COMPNAME, GVAR(debug), "WARNING", "Attaching item failed: invalid slot provided!"] call EFUNC(common,debugNew);
			_success = false;
		};
	};
};

_success

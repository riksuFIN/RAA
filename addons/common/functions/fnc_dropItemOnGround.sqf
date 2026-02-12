#include "script_component.hpp"
/* File: fnc_dropItemOnGround.sqf
 * Author(s): riksuFIN
 * Description: Drops given item from unit's inventory to ground or vehicle floor if inside vehicle
 					NOTE: Does not support weapons with attachments and wearables with items inside (uniform etc) at this time!
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Unit <OBJECT, default player>
 * 1:	Classname of object(s) to drop <STRING or ARRAY_OF_STRINGS>
 * 2:	isBeltItem <BOOL, default false>
 * 3:	
 * 4:	
 *
 Returns: Success
 *
 * Example:	
 *	[] call RAA_common_fnc_dropItemOnGround
*/
params ["_unit", "_classNames", ["_isBeltItem", false]];

// If we're provided with single classname we transform that to array
if (_classNames isEqualType "") then {
	_classNames = [_classNames];
};



// First we need to find out where we want to drop items
private _weaponHolder = objNull;
if (vehicle _unit isNotEqualTo _unit && maxLoad (vehicle _unit) > 0) then {
	// Inside vehicle with cargo space, drop item there
	_weaponHolder = vehicle _unit;
	
} else {
	// On foot on in vehicle without cargo (e.g. Static turret)
	// Find any existing weaponHolders
	_weaponHolder = nearestObject [_unit, "WeaponHolder"];
	
	if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
		_weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
		_weaponHolder setPosASL getPosASL _unit;
	};
};


// next we figure out what kind of items we have
private _resultFinal = true;
{
	// Sort items to basic categories
	private _itemType = _x call BIS_fnc_itemType;
	private _result = switch (_itemType param [0, ""]) do {
		case ("Weapon"): {
			_result = [_weaponHolder, _x, 1, false] call CBA_fnc_addWeaponCargo;
			if (_result) then {
				_unit removeWeaponGlobal _x;
			};
			_result
		};
		case ("Mine");		// mine is a magazine
		case ("Magazine"): {
			_result = [_weaponHolder, _x, 1, false] call CBA_fnc_addMagazineCargo;
			if (_result) then {
				if (_isBeltItem && ["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
					[_x, _unit] call EFUNC(beltSlot,beltSlot_deleteFromBelt);
				} else {
					_unit removeMagazineGlobal _x;
				};
			};
			_result
		};
		case ("Item"): {
			private _unassigned = false;
			if (!(_x in items _unit) && !_isBeltItem) then {
				// Item is likely NVG/ binocs/ similar in their own slot
				_unit unassignItem _x;
				_unassigned = true;
			};
			if (_unassigned && !(_x in items _unit)) exitWith {false};	// Check if unassign failed
			
			_result = [_weaponHolder, _x, 1, false] call CBA_fnc_addItemCargo;
			
			if (_result) then {
				if (_isBeltItem && ["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
					[_x, _unit] call EFUNC(beltSlot,beltSlot_deleteFromBelt);
				} else {
					_unit removeItem _x;
				};
			};
			_result
		};
		case ("Equipment"): {
			switch (_itemType param [1, ""]) do {
				case ("Glasses"): {
					_weaponHolder addItemCargoGlobal [_x, 1];
					removeGoggles _unit;
				};
				case ("Headgear"): {
					_weaponHolder addItemCargoGlobal [_x, 1];
					removeHeadgear _unit;
				};
				case ("Vest"): {
					_weaponHolder addItemCargoGlobal [_x, 1];
					removeVest _unit;
				};
				case ("Uniform"): {
				 	_weaponHolder addItemCargoGlobal [_x, 1];
					removeUniform _unit;
				};
				case ("Backpack"): {
					_weaponHolder addItemCargoGlobal [_x, 1];
					removeBackpackGlobal _unit;
				};
			};
			true
		};
		
		default {	// General items
			false
		};
	};
	
	
	if !(_result) exitWith {_resultFinal = false;};
} forEach _classNames;

//////////////////////////////////////////////////
/*
// Drop headgear
_weaponHolder addItemCargoGlobal [_headgear, 1];
removeHeadgear _unit;

// Drop NVG since it's mounted to helmet
private _hmd = hmd _unit;
if (_hmd isNotEqualTo "") then {
	_weaponHolder addItemCargoGlobal [_hmd, 1];
	_unit unassignItem (_hmd);
	_unit removeItem _hmd;
};
*/

_resultFinal



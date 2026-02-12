#include "script_component.hpp"
/* File: fnc_createDialog_editAmmo.sqf
 * Author(s): riksuFIN
 * Description: Create GUI dialog for adjusting AI skill preset settings
 *
 * Local to: Caller
 * Parameter(s):
	1: Array containing all gun modules on given side
 *
 Returns:
 *
 * Example:	[0] call RAA_firesA_fnc_createDialog_editAmmo
*/
params ["_sideID"];

private _gunsArray = [];
private _gunsArrayRAA = [];
private _ammoModulesArray = [];
switch (_sideID) do {
	case (0): {
		_gunsArray = tun_firesupport_guns_east;
		_gunsArrayRAA = RAA_firesA_gunTypes_east;
		_ammoModulesArray = RAA_firesA_ammoModules_east;
	 };
	case (1): {
		_gunsArray = tun_firesupport_guns_west;
		_gunsArrayRAA = RAA_firesA_gunTypes_west;
		_ammoModulesArray = RAA_firesA_ammoModules_west;
	};
	case (2): {
		_gunsArray = tun_firesupport_guns_resistance;
		_gunsArrayRAA = RAA_firesA_gunTypes_resistance;
		_ammoModulesArray = RAA_firesA_ammoModules_resistance;
	};
	case (3): {
		_gunsArray = tun_firesupport_guns_civilian;
		_gunsArrayRAA = RAA_firesA_gunTypes_civilian;
		_ammoModulesArray = RAA_firesA_ammoModules_civilian;
	};
};







// Lets create dialog with 5 slots for artillery by looping
private _content = [];
for "_i" from 0 to 4 do {
	
	private _gunsArrayIndex = _gunsArrayRAA param [_i, 0];		// GunType index from gunsArrayRAA
	private _ammoTypeClassnames = RAA_firesA_artyAmmoTypes param [(_gunsArrayIndex - 1), []];	// ["rhs_mag_3vo18_10", "rhs_mag_d832du_10", "rhs_mag_3vs25m_10"]
	
//	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] _ammoTypeClassnames = %1", _ammoTypeClassnames];};
	
	private _dialog0_values = [-1];
	private _dialog0_prettyValues = ["NONE"];
	
	// Element 0 is "EMPTY" for no gun type assigned to this slot.
	// In that case we do not fill options
	if (_gunsArrayIndex isEqualTo 0) then {
		_dialog0_prettyValues = ["NO GUN"];
		_dialog0_values = [-1];
		
	} else {
		{	// Put together prettyNames array
			private _temp = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
			
			_dialog0_prettyValues pushBack _temp;
			_dialog0_values pushBack _forEachIndex;
			
		} forEach _ammoTypeClassnames;
	};
	
	
	if (count _dialog0_values != count _dialog0_prettyValues) then {
		systemChat format ["[RAA_firesA] [ERROR] Dialog0_values and prettyValues are inequal! Impossible! loop %1", _i];
	};
	
	
	private _gunModule = _gunsArray param [_i, objNull];
	
	private _temp1 = _gunModule getVariable ["displayName", "NO GUN"];
	private _temp2 = RAA_firesA_artyTypeSettings param [_gunsArrayIndex, ""];
	private _numberOfBarrels = _gunModule getVariable ["gunCount", 1];
	_temp2 =  _temp2 select 1 select 0;
	
	private _gunName = format ["%1 (%2 x%3)", _temp1, _temp2, _numberOfBarrels];	// "HAMMER-1 (155 K 83 Howitzer (Sustained) x3)"
	
	_content pushBack ["EDIT",	// classname
		[(format ["=== GUN %1", _i + 1]), "This is just a spacer, please ignore"],
		[	// Control-specific arguments
			_gunName,
			{}
		],
		true
	];
	
	
	// Create 3 ammo slots for each gun for each gun.
	// Therefore single gun can have up to 3 different ammo types
	
//	private _ammoModules = [_gunModule] call RAA_firesA_fnc_getAllAmmoModules;
	private _ammoModules = [_gunModule] call FUNC(getAllAmmoModules);
	
	for "_o" from 0 to 2 do {
		
	//	private _classname = (_ammoModules select _o) getVariable ["Ammo", 0];
		private _ammoModule = _ammoModules param [_o, objNull];
		
		private _ammoModulesArray_forThisGun_andAmmo = _ammoModulesArray_forThisGun param [_o, [objNull, 0]];		// [AmmoModuleRef, ammoSlotID]
	//	private _defaultIndex0 = _ammoModulesArray_forThisGun_andAmmo param [1, 0];	// Should return number (ammoType ID)
		private _defaultIndex0 = _ammoModule getVariable ["RAA_ammoID", -1];	// Should return number (ammoType ID)
		_defaultIndex0 = _defaultIndex0 + 1;
	//	private _defaultIndex1 = _ammoModulesArray_forThisGun_andAmmo param [];	// Should return amount of ammo remaining
		
		private _defaultCount = RAA_firesA_artyTypeSettings param [_gunsArrayIndex, 0];
		_defaultCount = _defaultCount param [7, 0];	// This is used if ammo slot is currently undefined
		_defaultCount = _defaultCount * _numberOfBarrels;	// Multiply default value for each gun
		_defaultCount = _defaultCount min 1000;		// Make sure rounds count doesnt get out of bounds
		private _defaultIndex1 = _ammoModule getVariable ["currentCount", _defaultCount];
		
		
		_content pushBack ["COMBO",	// classname
			[(format ["%1: Ammo Type", _o + 1]), "Select ammo type for this gun"],
			[	// Control-specific arguments
			 
				_dialog0_values,
				_dialog0_prettyValues,
				_defaultIndex0	// Default index
			],
			true
		];
		
		
		
		_content pushBack ["SLIDER",
		[(format ["%1: Ammo Count",_o + 1]), "How much of this ammo should this gun have"],
			[
				1,		// Min value
				1000,	// Max value
				_defaultIndex1,	// Default value
				0
			],
			true	// Force default
		];
	
	};
	
};







// Create actual dialog
["Artillery Ammo Edit",
	_content,
	
	{ // ON CONFIRM CODE
	//(_this select 0) params ["_dialog0", "_dialog1", "_dialog2", "_dialog3", "_dialog4"];
	(_this select 1) params ["_sideID"];
	
	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] exec'd handleDialog with %1", _this]; RAA_firesA_debugFeed = _this;};
//	[_this select 0, _module_pos, _gunsArray, _gunsArrayRAA] remoteExec ["RAA_firesA_fnc_handleDialog_editGun", 2] ;
//	[_this select 0, _sideID] call RAA_firesA_fnc_handleDialog_editAmmo;
	[_this select 0, _sideID] call FUNC(handleDialog_editAmmo);
	
	
},{	// On cancel code
	
},	// Arguments
	_sideID

] call zen_dialog_fnc_create;
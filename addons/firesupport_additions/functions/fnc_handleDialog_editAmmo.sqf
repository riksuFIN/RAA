#include "script_component.hpp"
/* File:	fnc_handleDialog_ammo.sqf
 * Author: 	riksuFIN
 * Description:	
 
 
 * Called from:	ammo Dialog (fnc_createDialog_editAmmo)
 * Local to: 		Client
 * Parameter(s):
 0:	Various
 Returns:		Nothing
 * 
 * Example:		SHOULD NOT BE MANUALLY CALLED!
	[] call RAA_firesA_fnc_handleDialog_ammo
*/

params ["_dialogValues", "_sideID"];
_dialogValues params [
	"", "_gun1_ammo1_type", "_gun1_ammo1_count", "_gun1_ammo2_type", "_gun1_ammo2_count", "_gun1_ammo3_type", "_gun1_ammo3_count",
	"", "_gun2_ammo1_type", "_gun2_ammo1_count", "_gun2_ammo2_type", "_gun2_ammo2_count", "_gun2_ammo3_type", "_gun2_ammo3_count",
	"", "_gun3_ammo1_type", "_gun3_ammo1_count", "_gun3_ammo2_type", "_gun3_ammo2_count", "_gun3_ammo3_type", "_gun3_ammo3_count",
	"", "_gun4_ammo1_type", "_gun4_ammo1_count", "_gun4_ammo2_type", "_gun4_ammo2_count", "_gun4_ammo3_type", "_gun4_ammo3_count",
	"", "_gun5_ammo1_type", "_gun5_ammo1_count", "_gun5_ammo2_type", "_gun5_ammo2_count", "_gun5_ammo3_type", "_gun5_ammo3_count"
];

private _ammoArray = [
	[[_gun1_ammo1_type, round _gun1_ammo1_count], [_gun1_ammo2_type, round _gun1_ammo2_count], [_gun1_ammo3_type, round _gun1_ammo3_count]],
	[[_gun2_ammo1_type, round _gun2_ammo1_count], [_gun2_ammo2_type, round _gun2_ammo2_count], [_gun2_ammo3_type, round _gun2_ammo3_count]],
	[[_gun3_ammo1_type, round _gun3_ammo1_count], [_gun3_ammo2_type, round _gun3_ammo2_count], [_gun3_ammo3_type, round _gun3_ammo3_count]],
	[[_gun4_ammo1_type, round _gun4_ammo1_count], [_gun4_ammo2_type, round _gun4_ammo2_count], [_gun4_ammo3_type, round _gun4_ammo3_count]],
	[[_gun5_ammo1_type, round _gun5_ammo1_count], [_gun5_ammo2_type, round _gun5_ammo2_count], [_gun5_ammo3_type, round _gun5_ammo3_count]]
];

if (RAA_firesA_debug) then {
	RAA_firesA_debugFeed = _this;
};



private _gunsArray = [];
private _gunsArrayRAA = [];
switch (_sideID) do {
	case (0): {
		_gunsArray = tun_firesupport_guns_east;
		_gunsArrayRAA = RAA_firesA_gunTypes_east;
	 };
	case (1): {
		_gunsArray = tun_firesupport_guns_west;
		_gunsArrayRAA = RAA_firesA_gunTypes_west;
	};
	case (2): {
		_gunsArray = tun_firesupport_guns_resistance;
		_gunsArrayRAA = RAA_firesA_gunTypes_resistance;
	};
	case (3): {
		_gunsArray = tun_firesupport_guns_civilian;
		_gunsArrayRAA = RAA_firesA_gunTypes_civilian;
	};
};




// Loop through all arty modules
{
	private _gunModule = _x;
//	private _ammoModuleAlreadyCreated = false;
	private _gunID = _forEachIndex;
	private _gunTypeID = _gunsArrayRAA param [_gunID, -1];
	
//	private _ammoModules = [_gunModule] call RAA_firesA_fnc_getAllAmmoModules;
	private _ammoModules = [_gunModule] call FUNC(getAllAmmoModules);
	
	
	private _ammoSettings = _ammoArray select _gunID;		// 	[[_gun2_ammo1_type, _gun2_ammo1_count], [_gun2_ammo2_type, _gun2_ammo2_count], [_gun2_ammo3_type, _gun2_ammo3_count]]
	
	// Go through all possible ammo slots
	for "_i" from 0 to 2 do {
		private _ammoSlotID = _i;
		private _ammoModule = _ammoModules param [_ammoSlotID, objNull];	// Find object reference for correct ammo module
		
		private _ammoArrayForGunAndSlot = _ammoSettings select _ammoSlotID;	// [_gun2_ammo1_type, _gun2_ammo1_count]
		private _ammoID = _ammoArrayForGunAndSlot select 0;
		
	//	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] %1", _ammoID];};
		
		// First check that Zeus wants this slot to be used
		if ((_ammoArrayForGunAndSlot param [0, 0]) isNotEqualTo -1) then {
			
			private _ammoClassname = RAA_firesA_artyAmmoTypes param [(_gunTypeID - 1), []];	// ["rhs_mag_3vo18_10", "rhs_mag_d832du_10", "rhs_mag_3vs25m_10"]
			_ammoClassname = _ammoClassname select _ammoID;	// "rhs_mag_3vo18_10"
			
			if !(isNull _ammoModule) then {
				// Ammo module is already created, just apply new values to it
				
				// Apply new settings to modules only if they're different, to reduce net traffic
				if (_ammoModule getVariable ["Ammo", ""] isNotEqualTo _ammoClassname) then {
					// Extended network debug
					if (RAA_firesA_debug) then {
						[_ammoModule, "Ammo", _ammoClassname, false, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
					};
					_ammoModule setVariable ["Ammo", _ammoClassname, true];
				};
				if (_ammoModule getVariable ["RAA_ammoID", -1] isNotEqualTo _ammoID) then {
					_ammoModule setVariable ["RAA_ammoID", _ammoID, true];
				};
				if (_ammoModule getVariable ["currentCount", -1] isNotEqualTo (_ammoArrayForGunAndSlot select 1)) then {
					_ammoModule setVariable ["currentCount", _ammoArrayForGunAndSlot select 1, true];
				};
				
				
				if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Updated gun %1 slot %2 with %3 %4", _gunID, _ammoSlotID, _ammoClassname, _ammoArrayForGunAndSlot select 1];};
				
				
			} else {
				// Ammo module is not created, make a new one
				
			//	_ammoModule = [_ammoClassname, _ammoArrayForGunAndSlot select 1, _gunModule, _ammoID, _ammoSlotID] call RAA_firesA_fnc_createAmmo;
				_ammoModule = [_ammoClassname, _ammoArrayForGunAndSlot select 1, _gunModule, _ammoID, _ammoSlotID] call FUNC(create_ammo);
				
				
			};
			
			// Just a warning in case there's a bug. This should never fire
			if (_ammoModule getVariable ["Ammo", "NONE"] isEqualTo "NONE") then {
				systemChat "[RAA_FiresA] [ERROR] Ammo module with faulty ammo class name!";
			};
			
		} else {
			// This ammo module was not defined not to be used by Zeus
			if !(isNull _ammoModule) then {
				// This ammo slot exists. We must delete it
				
				deleteVehicle _ammoModule;
				
				if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Deleted ammo for gun %1 slot %2", _gunID, _i];};
			};
			
			
		};
	};
	
	
	
	
	
//	_gunModule setVariable [""];
	
	
} forEach _gunsArray;

/*
AmmoID = slot number

*/

["Updated Artillery Settings"] call zen_common_fnc_showMessage;
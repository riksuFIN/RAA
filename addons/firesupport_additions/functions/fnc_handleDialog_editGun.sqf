#include "script_component.hpp"
/* File:	fnc_handleDialog_editGun.sqf
 * Author: 	riksuFIN
 * Description:	Handle effects of fnc_createDialog_editGun
 	
	
 * Called from:	Various
 * Local to: 		Client
 * Parameter(s):
 0: 	Dialog values from fnc_createDialog_editGun
 1: sideID 	0: east, 1: west, 2: independent, 3: civilian
 2: position
 3: Auto-Open follow-up ammo dialog	<BOOL> Default: False
 Returns:		Nothing
 * 
 * Example:
	[] call RAA_firesA_fnc_handleDialog_editGun
*/

params ["_dialogValues", "_sideID", "_pos", ["_openAmmoDialog", false]];
_dialogValues params [
	"_gun1_type", "_gun1_name", "_gun1_number",
	"_gun2_type", "_gun2_name", "_gun2_number",
	"_gun3_type", "_gun3_name", "_gun3_number",
	"_gun4_type", "_gun4_name", "_gun4_number",
	"_gun5_type", "_gun5_name", "_gun5_number",
	["_createMapMarker", false]
];

if (RAA_firesA_debug) then {
	systemChat format ["[RAA_firesA] HandleDialog_editGun %1", _this];
	RAA_debug = _this;
};


// Set up usable form of array for gun values
// Propably should directly get these values insteant of declaring them in params first
private _gunValuesArray = [
	[_gun1_type, _gun1_name, round _gun1_number],
	[_gun2_type, _gun2_name, round _gun2_number],
	[_gun3_type, _gun3_name, round _gun3_number],
	[_gun4_type, _gun4_name, round _gun4_number],
	[_gun5_type, _gun5_name, round _gun5_number]
];

private _gunsArray = [];
private _gunsArrayRAA = [];
private _sideName = "west";
switch (_sideID) do {
	case (0): {
		_gunsArray = tun_firesupport_guns_east;
		_gunsArrayRAA = RAA_firesA_gunTypes_east;
		_sideName = "east";
	 };
	case (1): {
		_gunsArray = tun_firesupport_guns_west;
		_gunsArrayRAA = RAA_firesA_gunTypes_west;
		_sideName = "west";
	};
	case (2): {
		_gunsArray = tun_firesupport_guns_resistance;
		_gunsArrayRAA = RAA_firesA_gunTypes_resistance;
		_sideName = "resistance";
	};
	case (3): {
		_gunsArray = tun_firesupport_guns_civilian;
		_gunsArrayRAA = RAA_firesA_gunTypes_civilian;
		_sideName = "civilian";
	};
};






// Loop through all guns
{
	private _index = _forEachIndex;
	private _module = _gunsArray param [_index, objNull];
	private _thisSlotIsOccupied = !(isNull _module);
	private _definedGunType = _x select 0;
	
	
	if (_definedGunType < 1) then {
		// This slot was defined in dialog to be deleted
		
	//	if ((_gunsArray param [_index, ""]) != "") then {
		if (_thisSlotIsOccupied) then {
			// This slot was defined to be deleted and there is a gun
			
			// Delete all synchronized ammo modules
			{
				deleteVehicle _x;
			} forEach synchronizedObjects _module;
			
			// Now delete gun module itself
			deleteVehicle _module;
				// This should mark this gun as objNull in gunsArray, and will be removed from array
				// in cleanup at end of file
			
			
			
			// Delete reference in arrays
			_gunsArrayRAA set [_index, 0];
			// Since actually deleting object can take place next tick, but we clean array this tick we set objNull manually
			_gunsArray set [_index, objNull];
			
			
			
			if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Deleted gun index %1", _index];};
		};
		
		
	} else {
		// Gun was defined in this slot.
		// Check if it is already created
		if (_thisSlotIsOccupied) then {
			// There is already something in this slot. Just apply new params to it
			
			if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Changing guns params for gunID %1 at slot %2", _x select 0, _forEachIndex];};
			
			_gunsArrayRAA set [_index, (_gunValuesArray select _index) select 0];
			
			private _gunSettingsArray = RAA_firesA_artyTypeSettings select (_gunsArrayRAA param [_index, 0]);
			
			_module setVariable ["classname", _gunSettingsArray select 0, true];
		//	_module setVariable ["displayname", _gunValuesArray select _index select 1, true];
			_module setVariable ["displayname", format ["%1 (%2)",_gunValuesArray select _index select 1, _gunSettingsArray select 8], true];
			_module setVariable ["countdown", _gunSettingsArray select 2, true];
			_module setVariable ["delaymin", _gunSettingsArray select 3, true];
			_module setVariable ["spreadmin", _gunSettingsArray select 4, true];
			_module setVariable ["minrange", _gunSettingsArray select 5, true];
			_module setVariable ["maxrange", _gunSettingsArray select 6, true];
			_module setVariable ["gunCount", _gunValuesArray select _index select 2];
			
			
			
		} else {
			// No gun found, we need to create it
			if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Adding new gun %1 at slot %2 (Might be changed)", _x, _forEachIndex];};
			
			// Create gun logic
		//	private _object = [_x, _pos, _sideName] call RAA_firesA_fnc_createGun;
			private _object = [_x, _pos, _sideName] call FUNC(create_gun);
			
			if (_object isEqualTo false) exitWith {};
			
			// Set new gun in arrays
			_gunsArray set [_index, _object];
			_gunsArrayRAA set [_index, _definedGunType];
			
		};
	};
	
} forEach _gunValuesArray;



// If Zeus created new gun with empty slot between previous gun that will create nills in guns array
// This looks bad in fire support interface, therefore we need to sort array to get rid of nils
// We modify this copy of array inside loop to avoid pulling mattress from under our feet while looping
//private _gunsArray_temp = _gunsArray;
// We crawl through array starting from top to avoid us skipping a step when array resizes as element is deleted
for "_i" from 4 to 0 step -1 do {
	if (isNull (_gunsArray param [_i, objNull])) then {
		// This gun slot is nill. We need to delete it
		_gunsArray deleteAt _i;	// Delete nil value
		
		// Now RAA array is out of order so we need to update it as well
		if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] Deleted %1 at %2", _x, _i];};
		
		// This error message should never fire. Just in case, likely will be deleted at later date
		if (_gunsArrayRAA param [_i, 0] != 0) then {
			private _message = format ["[ERROR] [RAA_firesA] Deleted occupied slot %2 from gunsArrayRAA! Content: %1", _gunsArrayRAA select _i, _index];
			systemChat _message;
			diag_log _message;
		};
		
		/*
		// Copy element above currently iterated one and paste it to current position
		private _temp = _gunsArrayRAA select (_i + 1);
		_gunsArrayRAA set [_i, _temp];
		
		// Now clear that slot
		_gunsArrayRAA set [_i + 1, 0];
		*/
		
		_gunsArrayRAA deleteAt _i;
		
		
	};
};
//} forEach _gunsArray;		// Apparently forEach skips nills

// Now save results from loop above
//_gunsArray = _gunsArray_temp;





// Add gun module to be visible for Zeus
{
_x addCuratorEditableObjects [_gunsArray, false];
} forEach allCurators;




if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] gunsArray is now: %1", _gunsArray];};



// Make sure everyone has latest info on guns
switch (_sideID) do {
	case (0): {
		// Extended network debug
		if (RAA_firesA_debug) then {
			[objNull, "tun_firesupport_guns_east", _gunsArray, true, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
		};
		tun_firesupport_guns_east = _gunsArray;
		RAA_firesA_gunTypes_east = _gunsArrayRAA;
		publicVariable "tun_firesupport_guns_east";
		publicVariable "RAA_firesA_gunTypes_east";
	 };
	case (1): {
		if (RAA_firesA_debug) then {
			[objNull, "tun_firesupport_guns_west", _gunsArray, true, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
		};
		tun_firesupport_guns_west = _gunsArray;
		RAA_firesA_gunTypes_west = _gunsArrayRAA;
		publicVariable "tun_firesupport_guns_west";
		publicVariable "RAA_firesA_gunTypes_west";
	};
	case (2): {
		if (RAA_firesA_debug) then {
			[objNull, "tun_firesupport_guns_resistance", _gunsArray, true, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
		};
		tun_firesupport_guns_resistance = _gunsArray;
		RAA_firesA_gunTypes_resistance = _gunsArrayRAA;
		publicVariable "tun_firesupport_guns_resistance";
		publicVariable "RAA_firesA_gunTypes_resistance";
	};
	case (3): {
		if (RAA_firesA_debug) then {
			[objNull, "tun_firesupport_guns_civilian", _gunsArray, true, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
		};
		tun_firesupport_guns_civilian = _gunsArray;
		RAA_firesA_gunTypes_civilian = _gunsArrayRAA;
		publicVariable "tun_firesupport_guns_civilian";
		publicVariable "RAA_firesA_gunTypes_civilian";
	};
};
/*
	publicVariable "_gunsArray";
	publicVariable "_gunsArrayRAA";
*/

/*	NEVER MIND; WOULD NEED FOR EACH SIDE TO HAVE DIFFERENT MARKER
WILL BE DONE AT LATER DATE
// handle map marker for guns
private _markerExists = false;
if (markerType "mark1" != "") then {_markerExists = true}

if (_createMapMarker) then {
	if (_markerExists) then {
		
		
	} else {
		
		
	};
	
} else {
	
	
};
*/






if (_openAmmoDialog) then {
	// Call follow-up dialog to set ammo
//	[_sideID] call RAA_firesA_fnc_createDialog_editAmmo;
	[_sideID] call FUNC(createDialog_editAmmo);
} else {
	["Artillery guns were added"] call zen_common_fnc_showMessage;
};





#include "script_component.hpp"
/* File: fnc_doLoad_client.sqf
 * Author(s): riksuFIN
 * Description: Loads loadout (on each client) from save
 *
 * Called from: fnc_doLoad
 * Local to:	Each invidual client
 * Parameter(s):
 * 0:	doLoad settings module <OBJECT>
 *
 Returns: Nothing
 *
 * Example:			Execute on client you wish effect to happen. RemoteExec can be used.
 	[objNull] call RAA_saveLoad_fnc_doLoad_client
 */
params [["_module", objNull]];

if !(hasInterface) exitWith {};

// Make sure blacklist array still exists
if (isNil QGVAR(blacklist)) then {
	call FUNC(blacklist);
};

if (player in GVAR(blacklist) || name player in GVAR(blacklist) || player getVariable [QGVAR(blacklist), false]) exitWith {
	[COMPNAME, true, "INFO", format ["%1, Your loadout was not loaded as you're blacklisted.", name player]] call EFUNC(common,debugNew);
};

if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_load_main)) then {
	_module = entities QGVAR(module_load_main) param [0, objNull];
};

if (isNull _module || _module getVariable [QGVAR(save_key), ""] isEqualTo "") exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["[Client] Load settings module not found or invalid! Load system init failed! %1", _module], [true, true, true, false]] call EFUNC(common,debugNew);
};

private _debug_time = diag_tickTime;
private _key = format ["RAA_saveLoad_%1", _module getVariable QGVAR(save_key)];
private _loadLoadouts = _module getVariable [QGVAR(loadouts), true] in [true, 1];
private _fieldRations = _module getVariable [QGVAR(fieldRations), true] in [true, 1];
private _playerPos = _module getVariable [QGVAR(playerpos), false] in [true, 1];

// Check if we should use testMode save.
// If we're in SP and savedata created with testMode 1 exists we use that instead of main save.
if !(isMultiplayer) then {
	if (profileNamespace getVariable [format ["%1_sp_meta", _key], []] isNotEqualTo []) then {
		_key = format ["%1_sp", _key];
	};
};

private _saveData = profileNamespace getVariable [format ["%1_client", _key], []];
if (_saveData isEqualTo []) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Client Savedata Not Found using key %2! %1", _saveData, format ["%1_client", _key]]] call EFUNC(common,debugNew);
};
// ------------------ LOAD GEAR -----------------------------------
_saveData params [["_loadout", []], ["_beltItems", []], ["_hungerValues", []], ["_savedPos", []]];
if (_loadLoadouts) then {
	
	if (_loadout isNotEqualTo []) then {
		
		player setUnitLoadout _loadout;
		
		if (_beltItems isNotEqualTo [] && ["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
			{
				["", player, _x, true] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt;
			} forEach _beltItems;
		};
		
		
		private _save_meta = profileNamespace getVariable [format ["%1_meta", _key], []];
		if (_save_meta isNotEqualTo []) then {
			if (GVAR(debug)) then {
				[COMPNAME, true, "INFO", format ["[Client] Finished loading a save from %1.%2.%3 %4:%5. Loading took %6 s", _save_meta select 2, _save_meta select 1, _save_meta select 0, _save_meta select 3, _save_meta select 4, diag_tickTime - _debug_time]] call EFUNC(common,debugNew);
				
			} else {
				systemChat format ["Your loadout dated %1.%2.%3 %4:%5 was loaded.", _save_meta select 2, _save_meta select 1, _save_meta select 0, _save_meta select 3, _save_meta select 4];
			};
		};
		
	} else {
		[COMPNAME, true, "WARNING", format ["Failed to find saveData for your personal loadout. %1", _loadout]] call EFUNC(common,debugNew);
	};
	
};

if (_fieldRations && _hungerValues isNotEqualTo []) then {
	player setVariable ["acex_field_rations_thirst", _hungerValues select 0];
	player setVariable ["acex_field_rations_hunger", _hungerValues select 1];
};

// Move player where he was during saving
if (_playerPos && _savedPos isNotEqualTo []) then {
	player setPos _savedPos;
};



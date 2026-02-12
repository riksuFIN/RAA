#include "script_component.hpp"
/* File: fnc_doSave.sqf
 * Author(s): riksuFIN
 * Description: Handles saving function for each plauer's own loadout. Data is saved to each player's own profile file to avoid bloating server's savefile.
 *
 * Called from: fnc_doSave.sqf.	Should not be manually called!
 * Local to:	Every client, no server
 * Parameter(s):
 * 0:	Main Module <OBJ, default objNull>		If undefined or objNull module will be automatically searched for
 * 1:	ExtendedDebug <BOOL, default false>		Dumps whole bunch of debug data to screen. Regular debug data can be enabled from CBA settings
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: Nothing
 *
 * Example:		NOTE: Should not be manually called, instead call RAA_saveLoad_fnc_doSave
 *	[] call RAA_saveLoad_fnc_doSave_client
*/

params [["_module", objNull, [objNull]], ["_extendedDebug", false, [true]]];

// Sanity checks.
// This function runs _dedicated_ on clients    (get it, hehe?)
if !(hasInterface) exitWith {
	[COMPNAME, GVAR(debug), "NOTE", "fnc_doSave_client executed on non-player client or server, exiting.", [true, false, true]] call EFUNC(common,debugNew);
};

if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_save_main)) then {
	_module = entities QGVAR(module_save_main) param [0, objNull];
};

if (isNull _module || _module getVariable [QGVAR(save_key), ""] isEqualTo "") exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["[Client] Save settings module not found or invalid! Saving failed! %1 %2", _module, _module getVariable [QGVAR(save_key), ""]], [true, true, true, false]] call EFUNC(common,debugNew);
};
// END OF sanity checks

if (isNil QGVAR(blacklist)) then {
	call FUNC(blacklist);
};

private _debug_time = diag_tickTime;	// Measure how long it takes to run this fnc.

private _key = format ["RAA_saveLoad_%1", _module getVariable [QGVAR(save_key), ""]];
private _saveLoadouts = _module getVariable [QGVAR(loadouts), 1];
private _deleteDeadsLoadout = _module getVariable [QGVAR(deleteDeadsLoadout), true] in [true, 1];
private _fillMagazines = _module getVariable [QGVAR(fillMags), true] in [true, 1];
private _testMode = _module getVariable [QGVAR(testMode), true];

if (_saveLoadouts isEqualTo 0) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", "Client-side saving is disabled!"] call EFUNC(common,debugNew);
};

private _saveRTP = true;		// Dump savedata to .rtp in addition to profileNameSpace
private _saveToProfile = true;	// Main saving

// Check if current client has been blacklisted
if (getPlayerUID player in GVAR(blacklist) || player in GVAR(blacklist) || name player in GVAR(blacklist) || player getVariable [QGVAR(blacklist), false]) exitWith {
	[COMPNAME, true, "Client", "You're in blacklist, your personal loadout was not saved.", [true, false, true]] call EFUNC(common,debugNew);
};

switch (_testMode) do {
	case (0): {	// Normal saving, no extended debug
		[COMPNAME, GVAR(debug), "Client", "Started loadout saving."] call EFUNC(common,debugNew);
	};
	case (1): {		// Saves from MP are seperated from SP
		if !(isMultiplayer) then {
			_key = format ["%1_sp", _key];
			[COMPNAME, GVAR(debug), "Client", "Started loadout saving in SP Test Mode"] call EFUNC(common,debugNew);
		} else {
			[COMPNAME, GVAR(debug), "Client", "Started loadout saving."] call EFUNC(common,debugNew);
		};
	};
	case (2): {		// No saving, just debug feed.
		_saveToProfile = false;
		_saveRTP = true;
		GVAR(debug) = true;
		_extendedDebug = true;
		[COMPNAME, true, "WARNING", "[Client] Loadout saving was triggered in Debug Mode. No data will be actually saved!.", [true, false, true]] call EFUNC(common,debugNew);
	};
};

// Handle dead or spectating players
if ((!alive player || player in (call ace_spectator_fnc_players)) && _deleteDeadsLoadout) exitWith {
	profileNamespace setVariable [format ["%1_client", _key], nil];
	profileNameSpace setVariable [format ["%1_meta", _key], nil];
	saveProfileNamespace;// Optional since namespace is saved when game is closed
		
	systemChat "[RAA_Save] You're dead or spectator, your loadout save was deleted";
	[COMPNAME, true, "LOG", format ["Client %1 is either dead:%2 or in spectator, their loadout was NOT saved and previours loadout was deleted.", name player, !alive player]] call EFUNC(common,debugNew);
	if (GVAR(debug)) then {systemChat format ["fnc_doSave_client.sqf execution took %1 s", diag_tickTime - _debug_time]};
};

// Handle saving loadouts only if player's inside saveZone
private _continue = false;
if (_saveLoadouts isEqualTo 2) then {
	private _locationsToSearch = [_module];
	_locationsToSearch append entities QGVAR(module_save_additionalSearchLocation);
	{
		if (player inArea ([_x] + (_x getVariable "objectarea"))) exitWith {
			_continue = true;
		};
	} forEach _locationsToSearch;
} else {
	_continue = true;
};

if !(_continue) exitWith {
	[COMPNAME, true, "INFO", "Your loadout was NOT saved (You were not inside savezone)", [true, false, true]] call EFUNC(common,debugNew);
};

private _loadout = [];
private _beltItems = [];
if (_saveLoadouts > 0) then {
	// Get loadout
	_loadout = getUnitLoadout [player, !_fillMagazines];
	
		// Get beltSlot items (if any)
	if (["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
		_beltItems = [player] call RAA_beltSlot_fnc_beltSlot_getItems;
	};
	
	if (_saveRTP) then {diag_log "[RAA_saveLoad] RTP Save: ";diag_log _loadout; diag_log _beltItems};
} else {
	[COMPNAME, GVAR(debug), "NOTE", "Personal loadout was NOT saved since loadout saving was disabled."] call EFUNC(common,debugNew);
};

// Save hunger and thirst
private _hungerValues = [];
if (["acex_field_rations"] call ace_common_fnc_isModLoaded) then {
	 _hungerValues = [player getVariable ["acex_field_rations_thirst", -1], player getVariable ["acex_field_rations_hunger", -1]];
	if (_extendedDebug) then {systemChat format ["Hunger and thirst: %1", _hungerValues]};
};

private _saveData = [_loadout, _beltItems, _hungerValues, getPos player];

if (_extendedDebug) then {GVAR(saveData_client) = _saveData};

// Sanity check. This should NEVER fire!
if (_saveData isEqualTo []) exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["Client-side saving failed! Output: %1, saveLoadout: %2", _saveData, _saveLoadouts]] call EFUNC(common,debugNew);
};

// Save loadout to player's mission profile file
if (_saveToProfile) then {
	profileNamespace setVariable [format ["%1_client", _key], _saveData];
	if !(isServer) then {		// This is written by server too, so avoid writing it twice.
		profileNameSpace setVariable [format ["%1_meta", _key], systemTimeUTC];			// Mark when this save was done.
	};
	saveProfileNamespace;
};

if (GVAR(debug)) then {
	[COMPNAME, true, "Client", format ["Personal Loadout Saved! Took %1s, used key: %2", diag_tickTime - _debug_time, _key], [true, false, true]] call EFUNC(common,debugNew)
} else {
	systemChat "Personal Loadout Saved.";
	[COMPNAME, true, "Log", format ["Saving Client's personal loadout took %1s", diag_tickTime - _debug_time]] call EFUNC(common,debugNew)
};

true
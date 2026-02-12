#include "script_component.hpp"
/* File: fnc_doSave.sqf
 * Author(s): riksuFIN
 * Description: Handles saving saving function.
 *
 * Called from: 
 * Local to:	Server
 * Parameter(s):
 * 0:	Main Module <OBJ, default objNull>		If undefined or objNull module will be automatically searched for
 * 1:	Extended Debug <BOOL, default false>
 * 2:	Save Clients' Loadouts	<BOOL, default true>		Choose if we want to run client's saving functions as well.
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_saveLoad_fnc_doSave
*/
params [["_module", objNull, [objNull]], ["_extendedDebug", false, [true]], ["_saveClients", true, [true]]];

if (time < 30) exitWith {
	[COMPNAME, true, "ERROR_G", format ["fnc_doSave executed too early at %1, aborted. Check how you execute saving.", time]] call EFUNC(common,debugNew);
};

// Safety checks.
if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_save_main)) then {
	_module = entities QGVAR(module_save_main) param [0, objNull];
};

if (isNull _module || _module getVariable [QGVAR(save_key), ""] isEqualTo "") exitWith {
	[COMPNAME, GVAR(debug), "ERROR_G", format ["Save settings module not found or invalid! Mission Saving failed! %1", _module], [true, true, true, true]] call EFUNC(common,debugNew);
};

if (isNil QGVAR(blacklist)) then {
	call FUNC(blacklist);
};

// Player clients have their own function.
if !(isServer) exitWith {
	[COMPNAME, true, "WARNING", "fnc_doSave executed on client, doing nothing (must be executed on server!).", [true, false, true, true]] call EFUNC(common,debugNew);
};
// END OF safety checks


// Run each client's own saving function
if (_module getVariable [QGVAR(loadouts), 1] > 0 && _saveClients) then {
	[_module, _extendedDebug] remoteExec [QFUNC(doSave_client), [0, -2] select isDedicated];
};


private _dbg_time = diag_tickTime;	// Measure how long it takes to run this fnc. Mostly a debug thing
private _dbg_blcklst = 0;
private _dbg_vehs = 0;

// Retrieve all settings
private _key = format ["RAA_saveLoad_%1", _module getVariable [QGVAR(save_key), ""]];
private _saveVehicles = _module getVariable [QGVAR(saveVehicles), true] in [true, 1];
private _saveVehicles_ammo = _module getVariable [QGVAR(saveVehicles_ammo), false] in [true, 1];		// Accurate ammo count saving
private _saveVehicles_damage = _module getVariable [QGVAR(saveVehicles_damage), false] in [true, 1];	// Accurate damage state saving
private _saveVehicles_textures = _module getVariable [QGVAR(saveVehicles_textures), false] in [true, 1];
private _saveAmmoCrates = _module getVariable [QGVAR(ammoCrates), true] in [true, 1];
private _testMode = _module getVariable [QGVAR(testMode), 1];


if !(_saveVehicles || _saveAmmoCrates) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", "Server-side saving is disabled!"] call EFUNC(common,debugNew);
};

private _saveRTP = true;		// Dump savedata to .rtp in addition to profileNameSpace

switch (_testMode) do {
	case (0): {	// Normal saving, no extended debug
		
	};
	case (1): {		// Saves from MP are seperated from SP
		if !(isMultiplayer) then {
			_key = format ["%1_sp", _key];
		};
	};
	case (2): {		// No saving, just debug feed.
		_saveToProfile = false;
		_saveRTP = true;
		GVAR(debug) = true;
		_extendedDebug = true;
	};
};

// Get together list containing all vehicles and crates we need to crawl through

private _searchFilters = [];
if (_saveVehicles) then {
	_searchFilters pushBack "AllVehicles";
};
if (_saveAmmoCrates) then {
	_searchFilters pushBack "ReammoBox_F";
	_searchFilters pushBack "WeaponHolderSimulated";
};



// Find all locations we want to search in hopeless search of survivors... Sorry, saveable objects.
private _locationsToSearch = [_module];
_locationsToSearch append entities QGVAR(module_save_additionalSearchLocation);

// Find all objects we can find from all areas
private _objects = [];
private _entities = entities [_searchFilters, []];
{
	/*{		ONCE ARMA UPDATE 2.18 COMES OUT SWITCH TO THIS!!!
		// Filter "AllVehicles" includes soldiers which we do not want
		if !(_x isKindOf "Man" || _x in GVAR(blacklist) || _x getVariable [QGVAR(blacklist), false]) then {
			_objects pushBackUnique _x;	// We only want one of each object in array, our searches might return same thing several times. Such a waste of resources, right?
		};
		
	} forEach ((_x getvariable "objectarea") nearEntities [_searchFilters]);	// 'objectarea' is where modules save their size		THIS SYNTAX FOR nearEntities COMMAND WILL BE RELEASED IN 1.8 A3 UPDATE.
	*/
	
	// Find loose items on ground
	private _entities2 = _entities;
	if (_saveAmmoCrates) then {
		_entities2 append (_x nearObjects ["WeaponHolder", vectorMagnitude (_x getVariable "objectarea" select [0,2])]);
	};
	{
		if !(_x in GVAR(blacklist) || _x getVariable [QGVAR(blacklist), false] || _x isKindOf "Man") then {
			_objects pushBackUnique _x;
		} else {
			INC(_dbg_blcklst);
		};
	} forEach (_entities2 inAreaArray ([_x] + (_x getVariable "objectarea")));
	// ON ARMA 2.18 UPDATE REPLACE DOWN TO HERE
	
} forEach _locationsToSearch;

if (_extendedDebug) then {systemChat format ["We found %1 saveable objects in %2 areas", count _objects, count _locationsToSearch]};


// Find objects near each eligible player
/*		THIS IS NOT USED IN MOD VERSION
if (_searchDistance > 0) then {
	{
		if !(_x in GVAR(blacklist) || !alive _x || _x getVariable [QGVAR(blacklist), false]) then {
			
			{
				// Filter "AllVehicles" includes soldiers which we do not want
				if !(_x isKindOf "Man" || _x in GVAR(blacklist) || damage _x > 50 || _x getVariable [QGVAR(blacklist), false]) then {
					
					_objects pushBackUnique _x;	// We only want one of each object in array, our searches can and likely will return same thing several times
				};
				
			} forEach ((getPos _x) nearEntities [_searchFilters, 100]);
			
		};
	} forEach (call BIS_fnc_listPlayers - call ace_spectator_fnc_players);
};
*/


// By now we should have _objects which should contain long list of vehicles and crates we need to crawl through

private _vehicles = [];		// [className, fuel, dmg, [textures]]
private _weapons = [];		// weaponsItemsCargo		addWeaponWithAttachmentsCargoGlobal
private _magazines = [];	// magazinesAmmoCargo	
private _items = [];			// itemCargo
private _backpacks = [];	// itemCargo ((everyContainer cursorObject) select 2 select 1)

// =============================== SAVE VEHICLES =========================
{
	if (_x isKindOf "AllVehicles" || _x isKindOf "ReammoBox_F") then {
		
		// Check if saving vehicle ammocount is enabled
		private _ammo = if (_saveVehicles_ammo) then {
			false	// TODO FINISH SAVEFULLAMMOCOUNT!!		WIP, TODO: FINISH THIS! (at later stage)
		} else {
			false
		};
		
		// Do we want to save full dmg values or just simplified ones?
		private _damage = if (_saveVehicles_damage) then {
			// Extended (full) damage values		WIP, TODO: FINISH THIS! (at later stage)
			damage _x
		} else {	// Simplified damage level
			damage _x
		};
		// [className, direction, positionAGLS, fuel, dmg, ammoCount, [textures]]
		_vehicles pushBack [typeOf _x, direction _x, getPos _x, fuel _x, _damage, _ammo, [[], getObjectTextures _x] select _saveVehicles_textures];
		INC(_dbg_vehs);
		
		// Find crates stored in vehicle via ACE Cargo system
		{
			// Save objects in ACE Cargo system
			if (typeName _x isEqualTo "OBJECT") then {
				// Physical objects
				_objects pushBackUnique _x;
			} else {
				// Virtual objects (i.e. classname only)
				if !(_x in ["ACE_Track", "ACE_Wheel"]) then {
					_vehicles pushBack [_x, direction _x, getPos _x,1, 0, []];
				};
			};
		} forEach (_x getVariable ["ace_cargo_loaded", []]);
	};
	
	// Crates and vehicle cargo
	if (maxLoad _x > 0) then {
		_weapons append (weaponsItemsCargo _x);	// Saves weapons with their attachments and attached mags
		_items append (itemCargo _x);
		
		_magazines append (magazinesAmmoCargo _x);	// Save magazines, including their round  count
		
		// Containers (backpacks, vests etc) are a real pain if they contain items, so we "just" empty them
		{
			private _className = _x select 0;
			private _objectRef = _x select 1;
			
			_backpacks pushBack _className;
			
			// Save items to their respective arrays
			_weapons append (weaponsItemsCargo _objectRef);
			_magazines append (magazinesAmmoCargo _objectRef);
			_items append (itemCargo _objectRef);
			
		} forEach (everyContainer _x);
	};
} forEach _objects;


// Count how many of each gear piece we have. This will greatly shrink size of arrays we need to save
_weapons = _weapons call CBA_fnc_getArrayElements;
_magazines = _magazines call CBA_fnc_getArrayElements;
_items = _items call CBA_fnc_getArrayElements;
_backpacks = _backpacks call CBA_fnc_getArrayElements;



// Save everything to file. Since missionProfileNamespace is its own, seperate file it wont grow profile file size
//		CONVERSION TO MOD: Changed to write to server's profile since missionProfileNamespace becomes too much troublesome in mod-format
profileNamespace setVariable [format ["%1_vehicles", _key], _vehicles];
profileNamespace setVariable [format ["%1_weapons", _key], _weapons];
profileNamespace setVariable [format ["%1_magazines", _key], _magazines];
profileNamespace setVariable [format ["%1_items", _key], _items];
profileNamespace setVariable [format ["%1_backpacks", _key], _backpacks];
profileNameSpace setVariable [format ["%1_meta", _key], systemTimeUTC];			// Mark when this save was done.
saveProfileNamespace;	// Optional since namespace is saved when game is closed


if (_saveRTP) then {
	diag_log format ["[RAA_saveLoad] Saved following to server missionProfileNamespace using key %1:", _key];
	diag_log _vehicles;
	diag_log _weapons;
	diag_log _magazines;
	diag_log _items;
	diag_log _backpacks;
};

[COMPNAME, true, "INFO", format ["fnc_doSave.sqf was executed on server in %1s, used key: %2", diag_tickTime - _dbg_time, _key], [GVAR(debug), false, true, [false, true] select _extendedDebug]] call EFUNC(common,debugNew);


// Feedback for ease of mind.
["[RAA_SaveLoad] Mission was saved."] remoteExec ["systemChat", 0];

true
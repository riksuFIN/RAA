#include "script_component.hpp"
/* File: fnc_doLoad.sqf
 * Author(s): riksuFIN
 * Description: Loads loadout (on each client) and vehicles and gear (on server) from save
 *
 * Called from: 3Den module or manually.
 * Local to:	Server
 * Parameter(s):
 * 0:	
 * 1:	
 *
 Returns: 
 *
 * Example:	
 [] call RAA_saveLoad_fnc_doLoad
*/
//params ["_key", ["_loadLoadouts", true], ["", true], ["", []], ["", true], ["", true], ["", [0,0,0]], ["", []], ["", false]];

params [["_module", objNull], ["_loadClients", true]];


if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_load_main)) then {
	_module = entities QGVAR(module_load_main) param [0, objNull];
};

if (isNull _module || _module getVariable [QGVAR(save_key), ""] isEqualTo "") exitWith {
	[COMPNAME, GVAR(debug), "ERROR_G", format ["[Server] Load settings module not found or invalid! Load system init failed! %1", _module], [true, true, true, true]] call EFUNC(common,debugNew);
};

// Load client's gear
if (hasInterface && _loadClients) then {
	[_module] call FUNC(doLoad_client);
//	[_module] remoteExec [QFUNC(doLoad_client), [0, -2] select isDedicated];
};

private _debug_timeStart = diag_tickTime;

private _key = format ["RAA_saveLoad_%1", _module getVariable QGVAR(save_key)];
private _loadVehicles = _module getVariable QGVAR(loadVehicles) in [true, 1];
private _loadVehicles_fuel = _module getVariable QGVAR(vehicles_fuel) in [true, 1];
private _loadVehicles_ammo = _module getVariable QGVAR(vehicles_ammo) in [true, 1];
private _loadVehicles_damage = _module getVariable QGVAR(vehicles_damage) in [true, 1];
private _loadGear = _module getVariable QGVAR(equipment) in [true, 1];
private _loadEmptyCrates = _module getVariable QGVAR(ammoCrates_empty) in [true, 1];
// Check if we should use testMode save.
// If we're in SP and savedata created with testMode 1 exists we use that instead of main save.
if !(isMultiplayer) then {
	if (profileNamespace getVariable [format ["%1_sp_meta", _key], []] isNotEqualTo []) then {
		_key = format ["%1_sp", _key];
		[COMPNAME, GVAR(debug), "INFO", format ["Using SP key %1", _key]] call EFUNC(common,debugNew);
	};
};



/*		TO BE DELETED
// Order all clients to load their own gears
if (_loadClients) then {
	[_module] remoteExec [QFUNC(doLoad_client), [0, -2] select isDedicated];
};
*/
// Just server stuff from here on
if !(isServer) exitWith {};


// Handle module module_load_vehSpawnPos
private _vehSpawnPos_crates = [];
private _vehSpawnPos_cars = [];
private _vehSpawnPos_tanks = [];
private _vehSpawnPos_aircrafts = [];
private _vehSpawnPos_turrets = [];
private _vehSpawnPos_miscs = [];

{	// Single module can act as spawn point for several types of objects.
	if (_x getVariable QGVAR(crates)) then {_vehSpawnPos_crates pushBack _x;};
	if (_x getVariable QGVAR(cars)) then {_vehSpawnPos_cars pushBack _x;};
	if (_x getVariable QGVAR(tanks)) then {_vehSpawnPos_tanks pushBack _x;};
	if (_x getVariable QGVAR(aircrafts)) then {_vehSpawnPos_aircrafts pushBack _x;};
	if (_x getVariable QGVAR(turrets)) then {_vehSpawnPos_turrets pushBack _x;};
	if (_x getVariable QGVAR(other)) then {_vehSpawnPos_miscs pushBack _x;};
	
} forEach entities QGVAR(module_load_vehSpawnPos);


// Counters for debug messages
private _debug_objectsLoaded = 0;
private _debug_vehSpawnedDefaultPos = 0;
private _dbg_itemsNotLoaded = 0;
private _cfgVehicles = (configFile >> "CfgVehicles");
// ======================= LOADING VEHICLES ========================================================
if (_loadVehicles) then {
	
	private _vehicles = profileNamespace getVariable [format ["%1_vehicles", _key], []];
	if (count _vehicles > 0) then {
		// Spawn all vehicles. Hopefully without much explosions
		{
			_x params ["_className", "_direction", "_position", "_fuel", "_dmg", "_ammo", "_textures"];
			
			private _isCrate = false;
			private _spawnPosArray = switch true do {
				case (_className isKindOf "ReammoBox_F"): {_isCrate = true; _vehSpawnPos_crates};
				case (_className isKindOf "Car"): {_vehSpawnPos_cars};
				case (_className isKindOf "Tank"): {_vehSpawnPos_tanks};
				case (_className isKindOf "StaticWeapon"): {_vehSpawnPos_turrets};
				case (_className isKindOf "Air"): {_vehSpawnPos_aircrafts};
				default {_vehSpawnPos_miscs};
			};
			
			// If loading ammo crates was disabled skip this loop
			if (_isCrate && !_loadEmptyCrates) then { INC(_dbg_itemsNotLoaded); continue};
			
			// Find out where to spawn vehicles
			// If spawnPos is defined for this script we will use that, otherwise use value saved with vehicle
			if (_spawnPosArray isNotEqualTo []) then {
				_position = selectRandom _spawnPosArray;
			} else {
				INC(_debug_vehSpawnedDefaultPos);
			};
			
			// Spawn vehicle
			private _veh = createVehicle [_className, _position, [], 0, "NONE"];
			
			// For UAV's spawn AI, otherwise it's useless
			if (getNumber (_cfgVehicles >> _className >> "isUav") isEqualTo 1) then {
				createVehicleCrew _veh;
			};
			
			INC(_debug_objectsLoaded);
			
			clearWeaponCargoGlobal _veh;
			clearMagazineCargoGlobal _veh;
			clearItemCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			
			// Apply all parameters
			_veh setDir _direction;
			if (_loadVehicles_fuel) then {_veh setFuel _fuel};
			
			// Damage
			if (_loadVehicles_damage) then {
				if (typeName _dmg isEqualTo "SCALAR") then {	// Check if we saved simple or advanced damage values
					_veh setDamage _dmg;
				} else {
					// Advanced damage values were saved, we use that
					// TODO: Add handling for Advanced damage
				};
			};

			if (_loadVehicles_ammo && _ammo isNotEqualTo []) then {	// Same thing but for ammo count
				// TODO: ADD HANDLING FOR AMMOCOUNT!
			};
			
			// Vehicle skins
			if (_textures isNotEqualTo []) then {
				{
					_veh setObjectTextureGlobal [_forEachIndex, _x];
				} forEach _textures;
			};
			
		} forEach _vehicles;
		
	} else {
		// There were no saved vehicles
		[COMPNAME, true, "WARNING_G", format ["No Savedata Found For Vehicles using key %2! %1", _vehicles, _key]] call EFUNC(common,debugNew);
	};
};

if (GVAR(debug)) then {[COMPNAME, true, "INFO", format ["Loaded %1 vehicles, of which %2 were spawned at their original locations and %3 at custom positions. Used key %4", _debug_objectsLoaded, _debug_vehSpawnedDefaultPos, _debug_objectsLoaded - _debug_vehSpawnedDefaultPos, _key]] call EFUNC(common,debugNew);};

private _debug_timeVehDone = diag_tickTime;

// ======================= LOADING EQUIPMENT ========================================================
if (_loadGear) then {
	// Load all data from file
	private _weapons = profileNamespace getVariable [format ["%1_weapons", _key], []];
	private _magazines = profileNamespace getVariable [format ["%1_magazines", _key], []];
	private _items = profileNamespace getVariable [format ["%1_items", _key], []];
	private _backpacks = profileNamespace getVariable [format ["%1_backpacks", _key], []];
	
	// Check that there actually is something saved
	if (_weapons isEqualTo [] && _magazines isEqualTo [] && _items isEqualTo [] && _backpacks isEqualTo []) exitWith {
		[COMPNAME, true, "WARNING_G", format ["No Savedata Found For Equipment using key %2! %1", _weapons, _key]] call EFUNC(common,debugNew);
	};
	
	
	// ============== Prepare crates for equipment =================
	private _boxWeapons = [];
	private _boxMagazines = [];
	private _boxItems = [];
	private _boxGear = [];
	private _boxMedical = [];
	
	// Check if mission maker has defined some pre-defined containers as spawn points for equipment
	{
		private _thisModule = _x;
		{
			// Go through all objects synchronized to this module and process them
			if (maxLoad _x > 10) then {
				if (_thisModule getVariable [QGVAR(crate_weapons), true]) then {_boxWeapons pushBack _x};
				if (_thisModule getVariable [QGVAR(crate_magazines), true]) then {_boxMagazines pushBack _x};
				if (_thisModule getVariable [QGVAR(crate_items), true]) then {_boxItems pushBack _x};
				if (_thisModule getVariable [QGVAR(crate_gear), true]) then {_boxGear pushBack _x};
				if (_thisModule getVariable [QGVAR(crate_medical), true]) then {_boxMedical pushBack _x};
				if (_thisModule getVariable [QGVAR(clearCrate), true]) then {
					clearWeaponCargoGlobal _x;
					clearMagazineCargoGlobal _x;
					clearItemCargoGlobal _x;
					clearBackpackCargoGlobal _x;
				};
				// Inflate box to make sure everything fits there
				_x setMaxLoad 10000;
			} else {
				[COMPNAME, is3DENPreview || GVAR(debug), "WARNING", format ["Invalid container %1 synchronized to Load: Configure Crate since it has no inventory capacity!", _x]] call EFUNC(common,debugNew);
			};
			
		} forEach synchronizedObjects _x;
	} forEach entities QGVAR(module_load_defineCrate);
	
	
	// Check that all crate types exist. If any is not defined by mission maker, spawn them.
	{
		if (_x isEqualTo []) then {
			[COMPNAME, true, "LOG", format ["Spawning box %1", _forEachIndex]] call EFUNC(common,debugNew);
			// Spawn new boxes
			private _box = objNull;
			switch (_forEachIndex) do {
				case (0): {_box = createVehicle ["Box_NATO_Wps_F", _module, [], 10, "NONE"]; _boxWeapons pushBack _box};
				case (1): {_box = createVehicle ["Box_NATO_Ammo_F", _module, [], 10, "NONE"]; _boxMagazines pushBack _box};
				case (2): {_box = createVehicle ["Box_NATO_Support_F", _module, [], 10, "NONE"]; _boxItems pushBack _box};
				case (3): {_box = createVehicle ["B_supplyCrate_F", _module, [], 10, "NONE"]; _boxGear pushBack _box};
				case (4): {_box = createVehicle ["ACE_medicalSupplyCrate", _module, [], 10, "NONE"]; _boxMedical pushBack _box};
			};
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearItemCargoGlobal _box;
			clearBackpackCargoGlobal _box;
			[COMPNAME, is3DENPreview || GVAR(debug), "INFO", format ["Spawned gear box type %1", _x]] call EFUNC(common,debugNew);
		};
		
	} forEach [_boxWeapons, _boxMagazines, _boxItems, _boxGear, _boxMedical];
	
	
	// ======== Start loading stuff into crates. Get those hands moving!
	private _dbg_weaps = 0;
	private _dbg_mags = 0;
	private _dbg_items = 0;
	private _dbg_back = 0;
	private _item = [];
	private _count = 0;
	private _cfgWeapons = configFile >> "cfgWeapons";
	private _cfgMagazines = configFile >> "CfgMagazines";
	
	// WEAPONS
	for "_i" from 0 to (count _weapons - 1) step 2 do {
		// Go through all saved weapons and add them to crate
		// Array is in format: [WEAPON1DATA], COUNT1, [WEAPON2DATA], COUNT2...
		_item = _weapons param [_i, ""];
		_count = _weapons param [_i + 1, "0"];
		
		selectRandom _boxWeapons addWeaponWithAttachmentsCargoGlobal [_item, _count];
		INC(_dbg_weaps);
	};
	
	// MAGAZINES
	for "_i" from 0 to (count _magazines - 1) step 2 do {
		_magazines param [_i, []] params [["_item", ""], ["_rounds", 0]];
		_count = _magazines param [_i + 1, "0"];
		
		// Check if this is medical item
		if (getNumber (_cfgMagazines >> _item >> "ACE_isMedicalItem") isEqualTo 1) then {
			selectRandom _boxMedical addItemCargoGlobal  [_item, _count];
		} else {
		//	selectRandom _boxMagazines addMagazineCargoGlobal [_item, _count];
			selectRandom _boxMagazines addMagazineAmmoCargo [_item, _count, _rounds];
		};
		INC(_dbg_mags);
	};
	
	// ITEMS
	private _itemType = "";
	for "_i" from 0 to (count _items - 1) step 2 do {
		_item = _items param [_i, ""];
		_count = _items param [_i + 1, "0"];
		
		// Seperate medical items to their own box
		if (getNumber (_cfgWeapons >> _item >> "ACE_isMedicalItem") isEqualTo 1) then {
			selectRandom _boxMedical addItemCargoGlobal  [_item, _count];
		} else {
			// Find type of item. This fnc is propably not too effecient but best one I know of
			// Possible altenerative: getText (_cfgWeapons >> _item >> "itemInfo" >> "uniformModel") isNotEqualTo ""	// This likely gets all wearable items
			_itemType = (_item call BIS_fnc_itemType) param [0, ""];
			
			if (_itemType isEqualTo "Equipment") then {
				// Vests, uniforms etc
				selectRandom _boxGear addItemCargoGlobal  [_item, _count];
			} else {
				// Everything that isnt wearable or medical item
				selectRandom _boxItems addItemCargoGlobal  [_item, _count];
			};
		};
		INC(_dbg_items);
	};
	
	// BACKPACKS
	for "_i" from 0 to (count _backpacks - 1) step 2 do {
		_item = _backpacks param [_i, ""];
		_count = _backpacks param [_i + 1, "0"];
		
		if (getNumber (_cfgVehicles >> _item >> "isbackpack") isEqualTo 1) then {
			selectRandom _boxGear addBackpackCargoGlobal [_item, _count];	// This is a backpack
		} else {
			selectRandom _boxGear addItemCargoGlobal  [_item, _count];		// This is a vest or uniform
		};
		INC(_dbg_back);
	};
	
	[COMPNAME, true, "LOG", format ["Loaded %1 weapons, %2 mags, %3 items, %4 gear", _dbg_weaps, _dbg_mags, _dbg_items, _dbg_back]] call EFUNC(common,debugNew);
	[COMPNAME, GVAR(debug), "INFO", format ["[Server] Spawned %1 equipment in %2 boxes.", _dbg_weaps + _dbg_mags + _dbg_items + _dbg_back, count _boxWeapons + count _boxMagazines + count _boxItems + count _boxGear + count _boxMedical]] call EFUNC(common,debugNew);
};


private _save_meta = profileNamespace getVariable [format ["%1_meta", _key], []];
if ((is3DENPreview || GVAR(debug)) && (_save_meta isNotEqualTo [])) then {
	[COMPNAME, true, "INFO", format ["[Server] Loaded save from %1.%2.%3 %4:%5 in %6 s (vehicles took %7s, gear %8s). Used key %9",_save_meta select 2, _save_meta select 1, _save_meta select 0, _save_meta select 3, _save_meta select 4, diag_tickTime - _debug_timeStart, _debug_timeVehDone - _debug_timeStart, diag_tickTime - _debug_timeVehDone, _key], [true, false, true]] call EFUNC(common,debugNew);
};
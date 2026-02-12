#include "script_component.hpp"
/* File: fnc_save_module.sqf
 * Author(s): riksuFIN
 * Description: Executed by module at mission start to prepare necessary features for saveLoad system.
 					Also does a sanity check on parameters
 *
 * Called from: module RAA_saveLoad_save_main
 * Local to:	Server
 * Parameter(s):
 * 0:	Data from module
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_saveLoad_save_module
*/
params [["_module", objNull, [objNull]], "", "", ["_secondRun", false]];

if !(isServer || hasInterface) exitWith {};	// Throw out HC, they have no business here


private _saveKey = _module getVariable [QGVAR(save_key), ""];
if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_save_main)) then {
	_module = entities QGVAR(module_save_main) param [0, objNull];
};

if (isNull _module || _saveKey isEqualTo "") exitWith {
	if (_secondRun) then {
		[COMPNAME, true, "ERROR_G", format ["[Save Sanity Check] Save settings module not found or invalid! Saving init failed! %1, %2", _module, _module getVariable [QGVAR(save_key), "FAIL"]], [true, true, true, true]] call EFUNC(common,debugNew);
	} else {
		[COMPNAME, GVAR(debug), "LOG", "Second run on Save"] call EFUNC(common,debugNew);
		[	{		// Condition
				entities QGVAR(module_save_main) select 0 getVariable [QGVAR(save_key), ""] isNotEqualTo ""
			}, {	// Code
				[objNull, nil, nil, true] call FUNC(save_module)
			}, [	// Params
			],		// Timeout
				15,
			{		// Timeout code
				[COMPNAME, true, "ERROR", "Save Settings Module Timeout! Saving Init Failed!"] call EFUNC(common,debugNew);
			}
		] call CBA_fnc_waitUntilAndExecute;
	};
};

if (count (entities QGVAR(module_save_main)) > 1) exitWith {
	[COMPNAME, is3DENPreview || GVAR(debug), "ERROR", format ["[Save Sanity Check] ! FAIL ! (only one Save module is allowed! There are %1 modules)", count (entities QGVAR(module_save_main))], [true, true, true]] call EFUNC(common,debugNew);
};
private _saveTrigger = _module getVariable [QGVAR(saveTrigger), 1];
private _showZones = _module getVariable [QGVAR(showZonesMap), 2];
GVAR(module_save) = _module;

// Add automatic saving triggers
if (_saveTrigger isEqualTo 1) then {
	
//	addMissionEventHandler ["Ended", {[GVAR(module_save)] call FUNC(doSave);}];
	if (isServer) then {
	//	["Ended", {[GVAR(module_save)] call FUNC(doSave)}] remoteExec ["addMissionEventHandler", [0, -2] select isDedicated, true];
	//	["MPEnded", {[GVAR(module_save)] call FUNC(doSave)}] remoteExec ["addMissionEventHandler", [0, -2] select isDedicated, true];
		addMissionEventHandler ["Ended", {[GVAR(module_save), false, false] call FUNC(doSave)}];
		addMissionEventHandler ["MPEnded", {[GVAR(module_save), false, false] call FUNC(doSave)}];
	} else {
		addMissionEventHandler ["Ended", {[GVAR(module_save)] call FUNC(doSave_client)}];
	};
	
	["RAA_SaveLoad system is setup with automatic saving at mission end."] remoteExec ["systemChat", [0, -2] select isDedicated];
} else {
	if (is3DENPreview || GVAR(debug)) then {["RAA_SaveLoad system is setup with manual saving."] remoteExec ["systemChat", [0, -2] select isDedicated];};
};


// Check blacklist
private _blackList = call FUNC(blacklist);

["Save", GVAR(debug), "INFO", format ["Blacklist contains %1 items", count _blacklist]] call EFUNC(common,debugNew);

if !(hasInterface) exitWith {};
// Add info text to map
[] call FUNC(addDiary);

private _dbg_marks = 0;
// Show saving zones on map
if (_showZones > 0) then {
	// 1: Everyone, 2: Admin and zeus'
	if !(_showZones isEqualTo 2 && {!(!(isNull getAssignedCuratorLogic player) || (serverCommandAvailable "#kick"))}) exitWith {
		[COMPNAME, GVAR(debug), "INFO", "MapMarkers not shown since you're not zeus or admin"] call EFUNC(common,debugNew);
	};
	
	private _searchLocations = [_module];
	_searchLocations append entities QGVAR(module_save_additionalSearchLocation);
	{
		private _areaData = _x getVariable "objectarea";
		private _marker = createMarkerLocal [format ["RAA_saveLoad_mark1_%1", _x], position _x];
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Saving Area";
		_marker setMarkerShapeLocal (["ELLIPSE", "RECTANGLE"] select (_areaData select 3));
		_marker setMarkerSizeLocal [_areaData select 0, _areaData select 1];
		_marker setMarkerDirLocal (_areaData select 2);
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerBrushLocal "Border";
		INC(_dbg_marks);
		private _marker2 = createMarkerLocal [format ["RAA_saveLoad_mark2_%1", _x], position _x];
		_marker2 setMarkerShapeLocal "ICON";
		_marker2 setMarkerTypeLocal "mil_dot";
		_marker2 setMarkerTextLocal "Saving Area";
		INC(_dbg_marks);
	} forEach ([_module] + entities QGVAR(module_save_additionalSearchLocation));
	[COMPNAME, GVAR(debug), "INFO", format ["Created %1 map markers", _dbg_marks]] call EFUNC(common,debugNew);
};



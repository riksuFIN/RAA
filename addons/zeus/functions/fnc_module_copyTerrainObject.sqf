#include "script_component.hpp"
/* File: fnc_module_copyTerrainObject.sqf
 * Author(s): riksuFIN
 * Description: Finds nearest terrain object from given (module) location and allows spawning it at selected location
 *
 * Called from: Zeus Module
 * Local to: Client (Zeus)
 * Parameter(s):
 0:	Position where to search <POSITION ASL>
 1:	
 2:	
 3:	
 4:	
 *
 Returns: 
 *
 * Example:	[getPos player] call RAA_zeus_fnc_module_copyTerrainObject
*/

params ["_pos"];

// Module supplies it with ASL format, we need AGL
_pos = ASLToAGL _pos;

// Find nearest object. Note: Only able to find objects with config
private _object = nearestObjects [_pos, ["Static"], 10];

// Check if we found something
if (_object isEqualTo []) exitWith {
	// Nope, nothing found. For sake of feedback try to figure out reason
	private _objects = nearestTerrainObjects [_pos, [], 10];
	if (count _objects > 0) then {
		["This object cannot be spawned"] call zen_common_fnc_showMessage;	// = is terrain object without config entry. Most likely vegetation or some walls
	} else {
		["Could not find object"] call zen_common_fnc_showMessage;	// = Just plain nothing nearby
	};
};

_object = _object select 0;

if (isNull _object) exitWith {
	["Object is invalid"] call zen_common_fnc_showMessage;
};

private _classname = typeOf _object;


if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] Found %1 | %2", _classname, _object];};



[_object, {
	systemChat str _this; 
	if (_this select 0) then {
		private _obj = createVehicle [_this select 3 select 0, ASLToAGL (_this select 2), [], 0, "NONE"];
		{_x addCuratorEditableObjects [[_obj], false];
		} forEach allCurators;
	}
}, [_classname], format ["Select where to spawn %1", _classname]] call zen_common_fnc_selectPosition



#include "script_component.hpp"
/* File: fnc_clear_saveData.sqf
 * Author(s): riksuFIN
 * Description: Used to clear saved data from file once savedata is no longer required.
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	["myGreatKey", true] call RAA_saveLoad_fnc_clear_saveData
*/
params [["_module", objNull], ["_clearNow", false]];


if (typeName _module isEqualTo "STRING") exitWith {
	// Manually defined key. We instantly delete everything with this key.
	private _key = format ["RAA_saveLoad_%1", _module];
	{
		profileNameSpace setVariable [format ["%1_%2", _key, _x], nil];
		profileNameSpace setVariable [format ["%1_sp_%2", _key, _x], nil];
	} forEach ["vehicles", "weapons", "magazines", "items", "backpacks", "meta", "client"];
	
	saveProfileNamespace;
	[COMPNAME, GVAR(debug), "INFO", format ["Deleted all saved entries under key %1", _module]] call EFUNC(common,debugNew);
	
};

/*
private _key = format ["RAA_saveLoad_%1", _module getVariable QGVAR(save_key)];
profileNamespace setVariable [format ["%1_vehicles", _key], _vehicles];
profileNamespace setVariable [format ["%1_weapons", _key], _weapons];
profileNamespace setVariable [format ["%1_magazines", _key], _magazines];
profileNamespace setVariable [format ["%1_items", _key], _items];
profileNamespace setVariable [format ["%1_backpacks", _key], _backpacks];*/
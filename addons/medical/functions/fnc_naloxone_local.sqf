#include "script_component.hpp"
/* File: fnc_naloxone_local.sqf
 * Author(s): riksuFIN
 * Description: Handle naloxone (as antidote for morphine) effects
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_naloxone_local
*/

params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

// PROPOFOL
private _propofolTime = _target getVariable [QGVAR(propofol_lastAdministered), 0];
private _propofolEffectTime = _target getVariable [QGVAR(propofol_effectLength), 0];
if (_propofolTime + _propofolEffectTime - time > 0) then {
	[	{
			[_this select 0, false, 0, false] call ace_medical_fnc_setUnconscious;
		}, [
			_target
		],
		random 10
	] call CBA_fnc_waitAndExecute;
	
	if (GVAR(debug)) then {systemChat format ["[RAA_ACEA] Neutralizing propofol which was injected %1 seconds ago", _propofolTime + _propofolEffectTime - time];};
};



private _medsArray = (_target getVariable ["ace_medical_medications", []]);

if (_medsArray isEqualTo []) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Naloxone used, but no meds in system";};
};

private _lastMedIndex = -1;
// Loop through all meds in patients system and find most recent morphine
{
	
//	private _temp = _x select 0;	
	if ((_x select 0) isEqualTo "Morphine") then {	// ["Morphine",35.5254,30,1800,-24.0122,0.8,-10]
		_lastMedIndex = _forEachIndex;
	};
	
} forEach _medsArray;	// [["Morphine",35.5254,30,1800,-24.0122,0.8,-10],["Morphine",147.59,30,1800,-28.7956,0.8,-10],["Morphine",153.318,30,1800,-18.5464,0.8,-10]]

// Above loop will return most recent morphine instance's index
// now we will delete
if (_lastMedIndex > -1) then {
	
	if (RAA_ACEA_debug) then {systemChat format ["[RAA_ACEA] Naloxone removed %1", _medsArray select _lastMedIndex];};
	
	_medsArray deleteAt _lastMedIndex;
	
	_target setVariable ["ace_medical_medications", _medsArray, true];
} else {
	
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Naloxone used, but no morphine found";};
};

/*
(player getVariable "ace_medical_medications") select 0 select 4
[["Morphine",120.037,30,1800,-27.0141,0.8,-10]]

*/








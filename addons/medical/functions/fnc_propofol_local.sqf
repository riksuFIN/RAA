#include "script_component.hpp"
/* File: fnc_propofol.sqf
 * Author(s): riksuFIN
 * Description: description
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
 *	[] call RAA_ACEA_fnc_propofol
*/
params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];


private _delay = random [15, 45, 60];

// Black-out player's screen
if (_target isEqualTo player) then {
	cutText ["", "BLACK OUT", _delay, true];
	
	[	{
			["You're starting to feel sleepy..", false, 15, 2] call ace_common_fnc_displayText;
		}, [
		],
		_delay / 2
	] call CBA_fnc_waitAndExecute;
	
};


private _unconFor = random [120, 450, 600];
if (GVAR(debug)) then {systemChat format ["[RAA_ACEA] Propofol injected to %2 taking effect in %1 for %4, injected by %3", _delay, _target, _caller, _unconFor];};

[	{
		[_this select 0, true, _this select 1, false] call ace_medical_fnc_setUnconscious;
	}, [
		_target,
		_unconFor
	],
	_delay
] call CBA_fnc_waitAndExecute;

// Save time we applied propofol and for how long it effects for use by naloxone
_target setVariable [QGVAR(propofol_lastAdministered), time, true];
_target setVariable [QGVAR(propofol_effectLength), _unconFor + _delay, true];

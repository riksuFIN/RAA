#include "script_component.hpp"
/* File: fnc_handleDialog_surrenderOnEvent.sqf
 * Author(s): riksuFIN
 * Description: Handles Zeus dialog for making unit surrender on event
 *
 * Called from: Zeus dialog
 * Local to:	Target Unit
 * Parameter(s):
 * 0:	Dialog values
 * 1:	Unit
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_dialogValues", "_unit"];
_dialogValues params ["_onHit", "_onPanic", "_doDropWeapon", "_doSurrender", ["_doShout", ""]];


// Save these settings in unit's variables so they can be reached via fnc fired by EH later
_unit setVariable [QUOTE(GVAR(doDropWeapon)), _doDropWeapon];
_unit setVariable [QUOTE(GVAR(doSurrender)), _doSurrender];
_unit setVariable [QUOTE(GVAR(doShout)), _doShout];
_unit setVariable [QUOTE(GVAR(hasSurrendered)), false];


// Add eventHandlers for selected events
if (_onHit) then {
	// Check if EH already exists
	if ((_unit getVariable [QUOTE(GVAR(eh_hit)), -1]) isEqualTo -1) then {
		private _eh = _unit addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
			[_unit] call FUNC(doSurrenderOnEvent);
			
		}];
		_unit setVariable [QUOTE(GVAR(eh_hit)), _eh];
		if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] Added Hit EH %2 to %1", _unit, _eh];};
	};
};


if (_onPanic) then {
	// Check if EH already exists
	if ((_unit getVariable [QUOTE(GVAR(eh_firedNear)), -1]) isEqualTo -1) then {
		private _eh = _unit addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			
			// Since this EH can activate for unit itself firing...
			if (_firer isNotEqualTo _unit && _distance < 3) then {
				[_unit] call FUNC(doSurrenderOnEvent);
			};
		}];
		_unit setVariable [QUOTE(GVAR(eh_firedNear)), _eh];
		if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] Added FiredNear EH %2 to %1", _unit, _eh];};
	};
};

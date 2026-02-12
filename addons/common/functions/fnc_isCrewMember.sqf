#include "script_component.hpp"
/* File: fnc_isCrewMember.sqf
 * Author(s): riksuFIN
 * Description: Returns true of given unit is driver, gunner or commander of any vehicle. If not, or unit's not in vehicle returns false
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Unit <OBJECT>
 *
 Returns: isCrewmember <BOOL>
 *
 * Example:	
 *	[] call fileName
*/
params ["_unit"];


if (vehicle _unit isEqualTo _unit) exitWith {false};	// This doesnt seem to work??!
/*
private _role = fullCrew (vehicle _unit);
if (_role in ["driver", "commander", "gunner"]) exitWith {true};
*/
if (commander vehicle _unit isEqualTo _unit) exitWith {true};
if (driver vehicle _unit isEqualTo _unit) exitWith {true};
if (gunner vehicle _unit isEqualTo _unit) exitWith {true};



false

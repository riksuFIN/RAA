#include "script_component.hpp"
/* File: fnc_onRespawn.sqf
 * Author(s): riksuFIN
 * Description: Run when player client respawns
 *	
 * Called from: EventHandler "Respawn"
 * Local to:	Client
 * Parameter(s):
 * 0:	New unit <OBJECT>
 * 1:	Corpse <OBJECT>
 *
 Returns: 
 *
 * Example:
 *	[] call RAA_beltSlot_fnc_onRespawn
*/

params ["_unit", "_corpse"];

private _beltData = _unit getVariable [QGVAR(data), []];

if (_beltData isEqualTo []) exitWith {};
_unit setVariable [QGVAR(data), []];	// Clear this, its no longer needed

{
	// Remove kept virtual mass of items after respawn
	[_unit, _unit, (_x select 4) * -1] call ace_movement_fnc_addLoadToUnitContainer;
	
	// If ACE setting "save gear" is enabled we re-spawn belt items
	if (ace_respawn_savePreDeathGear) then {
			["", _unit, _x select 0, true] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt;
	};
} forEach _beltData;


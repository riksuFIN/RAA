#include "script_component.hpp"
/* File: fnc_handleAIInit.sqf
 * Author(s): riksuFIN
 * Description: Spawns water bottles to AI units
 *
 * Called from: CBA eventHandler initPost
 * Local to:	Server
 * Parameter(s):
 * 0:	Unit to handle <OBJECT>
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_misc_fnc_handleAIInit
*/

params [["_unit", objNull]];

// This function is only for AI units
if (isPlayer _unit || isNull _unit) exitWith {
//	if (GVAR(debug)) then {systemChat format ["[RAA_misc] IsNull or player: %1", _this];};	// DEBUG; REMOVE THIS ON RELEASE!
};

if (_unit getVariable [QGVAR(AI_spawnWater_skipThis), false]) exitWith {};

if (isNil QGVAR(allConsumeableItems)) exitWith {};

// Spawn couple of consumeable items to inventory
for "_i" from 0 to (round (random [0,0.4,2])) do {
	
	private _itemToSpawn = selectRandom GVAR(allConsumeableItems);
	//private _itemToSpawn = GVAR(AI_spawnWater_itemTypes) selectRandomWeighted GVAR(AI_spawnWater_itemTypes_weights);
	
	_unit addItem _itemToSpawn;	// addItem is not partically relieable command, but that's actually not a bad thing in this case
};

//if (GVAR(debug)) then {systemChat format ["[RAA_misc] Added %1 to %2, loop %3", _debug1, _unit];};// DEBUG; REMOVE THIS ON RELEASE!

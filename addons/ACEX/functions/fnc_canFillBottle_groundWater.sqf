#include "script_component.hpp"
/* File: fnc_canFillBottle_groundWater.sqf
 * Author(s): riksuFIN
 * Description: Tests if player can fill bottle from ground water source (pond, lake, sea etc)
 *
 * Called from: ACE action menu condition check
 * Local to: Client
 * Parameter(s):	NONE
 *
 Returns: 
 *
 * Example:	[] call RAA_acex_fnc_canFillBottle_groundWater
*/

private _inventoryItems = [_player] call ace_common_fnc_uniqueItems;

// If player has none of these items exit
if !("ACE_WaterBottle_Empty" in _inventoryItems || "RAA_waterBottle_dirty_half" in _inventoryItems) exitWith {
	
	false
};

surfaceIsWater position _player;




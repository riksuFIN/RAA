#include "script_component.hpp"
/* File: fnc_doFillBottle_groundWater.sqf
 * Author(s): riksuFIN
 * Description: Handle filling bottle from ground water source, like a lake
 *
 * Called from: ACE action menu
 * Local to: Client
 * Parameter(s): NONE
 *
 Returns: 
 *
 * Example:	[] call RAA_acex_fnc_doFillBottle_groundWater
*/
//params ["VARIABLE_1", "VARIABLE_2"];

if (RAA_misc_debug) then {systemChat format ["[RAA_module] %1", _this];};

[player, "RAA_waterBottle_dirty", true] call CBA_fnc_addItem;


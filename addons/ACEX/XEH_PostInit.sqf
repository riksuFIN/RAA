#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */

GVAR(testUpdate) = true;		// What the heck is this?!?
if !(hasInterface) exitWith {};


["acex_rationConsumed", {[_this] call RAA_acex_fnc_handleItemConsumptionEffects}] call CBA_fnc_addEventHandler;




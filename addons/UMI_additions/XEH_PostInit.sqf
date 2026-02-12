#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */

if !(hasInterface) exitWith {};

/*
// Compile functions
RAA_acex_fnc_handleItemConsumptionEffects	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_handleItemConsumptionEffects.sqf";
RAA_acex_fnc_effect_drunk	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_effect_drunk.sqf";
RAA_acex_fnc_effect_drug	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_effect_drug.sqf";
RAA_acex_fnc_effect_genericAlcohol	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_effect_genericAlcohol.sqf";

// Dirty water
RAA_acex_fnc_effect_dirtyWater	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_effect_dirtyWater.sqf";
RAA_acex_fnc_canFillBottle_groundWater	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_canFillBottle_groundWater.sqf";
RAA_acex_fnc_doFillBottle_groundWater	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_doFillBottle_groundWater.sqf";

// Experiment
//RAA_acex_fnc_drinkFromBottle	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_ACEX_Additions\functions\fnc_drinkFromBottle.sqf";
*/

["acex_rationConsumed", {[_this] call FUNC(handleItemConsumptionEffects)}] call CBA_fnc_addEventHandler;




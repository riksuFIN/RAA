#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: Client
 * Scheduled
 */


if !(hasInterface) exitWith {};	// Only hungry players allowed here



/*
// Compile functions
RAA_fnc_startLoop	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_FieldRation_Warnings\functions\fnc_startLoop.sqf";
RAA_fnc_mainLoop 	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_FieldRation_Warnings\functions\fnc_mainLoop.sqf";
RAA_fnc_playSound	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_FieldRation_Warnings\functions\fnc_playSound.sqf";
RAA_fnc_showWarning	= compileFinal preprocessFileLineNumbers "\r\misc\addons\RAA_FieldRation_Warnings\functions\fnc_showVisualWarnings.sqf";
*/


player setVariable [QGVAR(lastTextTime),0];		// Pre-set variables to player
player setVariable [QGVAR(SoundLastPlayed),0];

// Config static variables
GVAR(running) = false;		// Used to check if mainLoop is already running
GVAR(sharedSounds_distance) = 15;

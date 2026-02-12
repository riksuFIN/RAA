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
// CBA CONVERSION: These functions are incorrectly named and cannot be transferred to PREP directly
RAA_animation_createAnimList	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\animation\functions\fnc_createAnimList.sqf";
RAA_animation_fnc_playAnim	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\animation\functions\fnc_playAnim.sqf";
RAA_animation_fnc_pissing	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\animation\functions\fnc_pissing.sqf";
*/

// 0: Exited anim, 
player setVariable ["RAA_animation_loopAnim", -1];
player setVariable ["RAA_animation_currentLoopedAnim", ""];
player setVariable ["RAA_animation_currentlyControlledUnit", player];

// Set up Eventhandlers to detect when Zeus starts remote controlling unit
//["zen_remoteControlStarted", {player setVariable ["RAA_animation_currentlyControlledUnit", _this select 0];}] call CBA_fnc_addEventHandler;
//["zen_remoteControlStopped", {player setVariable ["RAA_animation_currentlyControlledUnit", _this select 0];}] call CBA_fnc_addEventHandler;

["unit", {player setVariable ["RAA_animation_currentlyControlledUnit", _this select 0]}] call CBA_fnc_addPlayerEventHandler;

//https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addPlayerEventHandler-sqf.html#CBA_fnc_addPlayerEventHandler



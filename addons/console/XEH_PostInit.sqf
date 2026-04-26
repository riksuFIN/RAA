#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 
 * Called from: config.cpp/ XEH_postInit
 * Scheduled
 */

[ACE_player] call FUNC(initDevice);

GVAR(currentConsoleObject) = ACE_player;    // Currently opened object is saved here. This is either object to interacted computer object OR ACE_player for dev mode.


if !(isServer) exitWith {};

[QGVAR(server_sendData), {_this call FUNC(server_sendData)}] call CBA_fnc_addEventHandler;


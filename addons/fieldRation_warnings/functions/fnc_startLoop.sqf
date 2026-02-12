#include "../script_component.hpp"
/* File: fnc_startLoop.sqf
 * Authors: riksuFIN
 * Description: Handle starting/ stopping CBA perFrameHandler for FRW mainloop. 
 *				This fnc is called once at every mission start and every time RAA_FRW_MasterEnable setting is changed
 *
 * Called from: CBA_Settings.sqf // RAA_FRW_MasterEnable Setting
 * Parameter(s):
 0:	
 1: 
 2: 
 3: 
 4:
 *
 Returns:
 *
 */



//params ["_enable"];
if !(hasInterface) exitWith {};	// No point running this for server/ HC


if (RAA_FRW_MasterEnable) then {	// Start loop
	if (player getVariable ["RAA_FRW_PFH_Handle", -1] != -1) exitWith {	// Check if loop is already dead
		if (GVAR(debug)) then {systemChat "[RAA_FRW] startLoop: Attempted start, loop is already running";};
	};
	
	private _handle = [{
		[] call RAA_fnc_mainLoop;
	},	15, []] call CBA_fnc_addPerFrameHandler;
	player setVariable ["RAA_FRW_PFH_Handle",_handle];
	
	if (GVAR(debug)) then {systemChat format ["[RAA_FRW] startLoop: Started loop with handle %1",_handle];};
	
} else {	// Stop loop
	if (player getVariable ["RAA_FRW_PFH_Handle", -1] == -1) exitWith {	// Check if loop already exists
		if (GVAR(debug)) then {systemChat "[RAA_FRW] startLoop: Attempted stop, is already dead";};
	};
	
	private _handle = player getVariable "RAA_FRW_PFH_Handle";
	
	private _success = [_handle] call CBA_fnc_removePerFrameHandler;
	
	if (_success) then {
		player setVariable ["RAA_FRW_PFH_Handle",-1];
		if (GVAR(debug)) then {systemChat "[RAA_FRW] startLoop: Loop stopped successfully";};
	} else {
		if (GVAR(debug)) then {systemChat "[RAA_FRW] startLoop: Failed to stop loop! ";};
	};
	
};

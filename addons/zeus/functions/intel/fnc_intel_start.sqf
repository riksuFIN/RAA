/* File: fnc_intel_start.sqf
 * Author(s): riksuFIN
 * Description: Starts first loop
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:		
 1: 	
 2: 	
 3: 
 4:
 *
 Returns:
 *
 * Example:	[] call RAA_zeus_fnc_intel_start
 */

params ["_object", "_dialogValues"];

if !(isServer) exitWith {	// For sake of simplicity we only handle intel on server
	systemChat "[RAA_Zeus] ERROR: fnc_intel_start executed outside server";
};


if !(_object getVariable ["RAA_zeus_intel_created", false]) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] ERROR: fnc_intel_start executed with bad object";};
};






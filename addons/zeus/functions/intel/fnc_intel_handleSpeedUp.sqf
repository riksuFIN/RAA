/* File: fnc_handleSpeedUp.sqf
 * Author(s): riksuFIN
 * Description: If player chooses to attempt to speed up intel collection it has random chance of failing
 
 *
 * Called from: 
 * Local to: 	server
 * Parameter(s):
 0:	Object where intel takes place <OBJECT>
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call fileName
*/
params ["_object"];

if !(_object getVariable ["RAA_zeus_intel_started", false]) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] ERROR: HandleSpeedUp executed without intel started";};
};



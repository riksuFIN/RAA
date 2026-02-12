#include "script_component.hpp"
/* File: fnc_fieldphone_setting_mute.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
/*
systemChat str _this;
RAA_debugFeed = _this;
*/
params ["_object", "_doMute"];

if (_object getVariable [QGVAR(connected), -1] < 0) exitWith {
	if GVAR(debug) then {systemChat "[RAA_fieldphone] Cable is not connected, exit script";};
};
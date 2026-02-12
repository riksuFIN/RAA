#include "script_component.hpp"
/* File:	fnc_create_gun.sqf
 * Author: 	riksuFIN
 * Description:	Modified version of Tuntematon's Firesupport mod's fnc_module_gun.sqf file
 	
 
 
 * Called from:	Various
 * Local to: 		Client
 * Parameter(s):
 0:	
 1:	
 2:	
 Returns:		Created logic object <OBJECT>
 * 
 * Example:
	[] call RAA_firesA_fnc_createGun
 */

params ["_gunValuesArray", "_pos", "_sideName"];
_gunValuesArray params ["_gunType", "_gunName", "_numberOfGuns"];


// Check if group for logics is created yet..
if (isNull RAA_firesA_group_artyLogics) then {
	RAA_firesA_group_artyLogics = createGroup sideLogic; 
	publicVariable "RAA_firesA_group_artyLogics";
};

/*
"Logic" createUnit [ 
_pos, 
RAA_firesA_group_artyLogics,
"RAA_firesA_temp = this" 		// Necessary to create global variable since createUnit does not return unit reference
];
*/

// Create logic object that acts as arty unit (virtual)
private _object = RAA_firesA_group_artyLogics createUnit ["RAA_logic_artyGun", ASLtoAGL _pos, [], 0, "NONE"];

if (isNull _object) exitWith {
	systemChat "[RAA_firesA] ERROR: Failed to create gun module!";
	false
};


private _gunSettings = RAA_firesA_artyTypeSettings select _gunType;

/*
// Extended network debug
if (RAA_firesA_debug) then {
	[_object, "displayName", _gunName, false, serverTime] remoteExec [QFUNC(debug_remoteExec), -2, false];
};
*/

_object setVariable ["className", _gunSettings select 0, true]; 
//_object setVariable ["displayName", _gunName, true]; 
_object setVariable ["displayName", format ["%1 (%2)", _gunName, _gunSettings select 8], true]; 
_object setVariable ["side", _sideName, true]; 
_object setVariable ["marker", false, true]; 
_object setVariable ["gunCount", _numberOfGuns, true]; 
_object setVariable ["countDown", _gunSettings select 2, true]; 
_object setVariable ["delayMin", _gunSettings select 3, true]; 
_object setVariable ["delayMax", 180, true]; 
_object setVariable ["spreadMin", _gunSettings select 4, true]; 
_object setVariable ["spreadMax", 500, true]; 
_object setVariable ["minRange", _gunSettings select 5, true]; 
_object setVariable ["maxRange", _gunSettings select 6, true];










/*
private _classname = _gunModule getVariable ["className", "Missing classname"];
private _name = _gunModule getVariable ["displayName", "Missing name"];
private _side = _gunModule getVariable ["side", sideLogic];
private _markerConditio = _gunModule getVariable ["marker", true];
private _gunCount= _gunModule getVariable ["gunCount", 1];
// private _countdown = _gunModule getVariable ["countDown", 60];
// private _min_spread = _gunModule getVariable ["spreadMin", 50];
// private _max_spread = _gunModule getVariable ["spreadMax", 500];
// private _min_delay = _gunModule getVariable ["delayMin", 1];
// private _max_delay = _gunModule getVariable ["delayMax", 60];
// private _minRange= _gunModule getVariable ["minRange", 0];
// private _maxRange = _gunModule getVariable ["maxRange", 10000];
*/


/*
if (_gunCount < 1) then {
	_gunModule setVariable ["Tun_firesupport_gunCount", 1, true];
};
*/


_object setVariable ["Tun_firesupport_is_firing", false, true];
_object setVariable ["Tun_firesupport_status", "STR_Tun_firesupport_status_free" call BIS_fnc_localize, true];
_object setVariable ["Tun_firesupport_firemissions", [], true];
_object setVariable ["Tun_firesupport_firemissionCount", 0, true];


// Return object reference
_object
#include "script_component.hpp"
/* File: fnc_doSurrenderOnEvent.sqf
 * Author(s): riksuFIN
 * Description: Handles forced surrendering on event (as defined by Zeus via module)
 *
 * Called from: 
 * Local to:	Target unit
 * Parameter(s):
 * 0:	Unit	<OBJECT>
 * 1:	doShout <STRING, default: "">
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_unit"];

// Get settings saved in variables
private _doDropWeapon = _unit getVariable [QUOTE(GVAR(doDropWeapon)), false];
private _doSurrender = _unit getVariable [QUOTE(GVAR(doSurrender)), false];
private _doShout = _unit getVariable [QUOTE(GVAR(doShout)), ""];
private _hasSurrendered = _unit getVariable [QUOTE(GVAR(hasSurrendered)), true];


if (!alive _unit || _hasSurrendered) exitWith {
};

// This is to make sure this fnc wont be able to run several times in case EH activates too many times
_unit setVariable [QUOTE(GVAR(hasSurrendered)), false];

// Remove eventHandlers
private _eh = _unit getVariable [QUOTE(GVAR(eh_hit)), -1];
if (_eh > -1) then {
	_unit removeEventHandler ["Hit", _eh];
	_unit setVariable [QUOTE(GVAR(eh_hit)), nil];
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] Removed EH Hit";};
};
_eh = _unit getVariable [QUOTE(GVAR(eh_firedNear)), -1];
if (_eh > -1) then {
	_unit removeEventHandler ["FiredNear", _eh];
	_unit setVariable [QUOTE(GVAR(eh_firedNear)), nil];
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] Removed EH FiredNear";};
};





if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] doSurrenderOnEvent: %1", _this];};

// Make unit shout defined sound
if (_doShout isNotEqualTo "") then {
	if (_doShout isEqualTo "RANDOM") then {
		_doShout = selectRandom [
			"RAA_misc_dialog_holyShit",
			"RAA_misc_dialog_noShoot",
			"RAA_misc_dialog_nooo",
			"RAA_misc_dialog_perkele"
		];
	};
	
//	_unit say _doShout;
	[_unit, _doShout] remoteExec ["say3D", [0, -2] select isDedicated];
};



// If drop weapon enabled make unit drop his current weapon to ground
private _delay = 1;
if (_doDropWeapon) then {
//	private _weaponHolder = "GroundWeaponHolder_Scripted" createVehicle getPosATL _unit;
	private _weaponHolder = createVehicle ["GroundWeaponHolder_Scripted", getPosATL _unit, [], 1, "CAN_COLLIDE"];
	
	{
		_unit removeWeapon (_x select 0);
		_weaponHolder addWeaponWithAttachmentsCargoGlobal [_x, 1];
	//	_unit action ["DropWeapon", _weaponHolder, _x];
		
	} forEach (weaponsItems _unit);
	
	
	
	_delay = 2;
	if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1 drop weapon!", _unit];};
};


// Make unit surrender
if (_doSurrender) then {
	[	{
			_this call ACE_captives_fnc_setSurrendered;
			if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1 surrender!", _this select 0];};
		}, [
			_unit, true
		],
		_delay
	] call CBA_fnc_waitAndExecute;
	
};





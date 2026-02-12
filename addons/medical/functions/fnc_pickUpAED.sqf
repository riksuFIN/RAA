#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: Handle picking up AED action
 *
 * Called from: ACE action attached to AED object
 * Local to: Client
 * Parameter(s):
 0:	AED object <OBJECT>
 1:	Unit who picked it up <OBJECT, default player>
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[cursorObject] call RAA_fnc_ACEA_AED_pickUpItem
*/
params ["_aed", ["_player", ACE_player]];

/*
{deleteVehicle _target; _player addItem 'RAA_AED'},
//	{!(_target getVariable ["RAA_AED_inUse", false]) && (_player canAdd "RAA_AED")}
*/
if (_aed getVariable ["RAA_AED_inUse", false]) exitWith {
	systemChat "Unable to pick up AED as it is currently in use";
};

private _success = [_player, "RAA_AED"] call CBA_fnc_addItem;

if !(_success) exitWith {
	systemChat "Unable to pick up AED as you do not have enough space in inventory";
};


deleteVehicle _aed;

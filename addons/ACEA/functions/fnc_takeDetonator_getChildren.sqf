#include "script_component.hpp"
/* File: fnc_takeDetonator_getChildren.sqf
 * Author(s): riksuFIN
 * Description: Gets childrens for ACE interaction menu. Collects actions 
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
 *	[] call RAA_ACEA_fnc_takeDetonator_getChildren
*/
params ["_target", "_player"];


private _detonators = [_target] call ace_explosives_fnc_getDetonators;
if (count _detonators isEqualTo 0) exitWith {[]};
/*
private _beltItems = _unit getVariable [QGVAR(data), []];
if (count _beltItems isEqualTo 0) exitWith {[]};
*/


private _actions = [];
private _cfgWeapons = configFile >> "CfgWeapons"; 
{
	private _config = _cfgWeapons >> _x;
	private _displayName = getText (_config >> "displayName");
	private _picture = getText (_config >> "picture");
	
	
	private _action = [_x, _displayName, _picture, {_this call FUNC(takeDetonator)}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _target, _player];
	
} forEach _detonators;

_actions
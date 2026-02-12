#include "script_component.hpp"
/* File: fnc_connect_insertChildren.sqf
 * Author(s): riksuFIN
 * Description: Inserts children for simple connect ACE action menu
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

params ["_target", "_player", "_params"];
//diag_log format ["_insertChildren [%1, %2, %3]", _target, _player, _params];


private _actions = [];
// Add children to this action
for "_i" from 1 to 10 do {
	private _childStatement = {[_target, _this select 2] call FUNC(connectCable)};
	private _action = [_i, format ["Cable #%1",_i], "", _childStatement, {true}, {}, _i] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
	
	
};



_actions


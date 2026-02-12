#include "script_component.hpp"
/* File:	fnc_disableAIMovement.sqf
 * Author: 	riksuFIN
 * Description:	
 *
 * Called from:	
 * Local to: 	
 * Parameter(s):
 0:	_objects		<ARRAY>		List of selected objects
 1:	
 2:	
 3:	
 4:	
 Returns:		
 * 
 * Example:

 */

 params ["_objects"];
 

 private _enabled = 0;	// Counters for feedback
 private _disabled = 0;

{
	if (alive _x && {_x isKindOf "CAManBase"} && !isPlayer _x) then {
		
		if (_x checkAIFeature "PATH") then {	// Check if already disabled
			if (local _x) then { // Check unit's locality
				_x disableAI "PATH";
			} else {	// AI is not on local machine
				[_x,"PATH"] remoteExec ["disableAI", owner _x];
			};
			_disabled = _disabled + 1;
		} else {	// If unit is not local command must be executed via remoteExec
			if (local _x) then { // Check unit's locality
				_x enableAI "PATH";	// Enable pathfinding
			} else {	// AI is not on local machine, remoteExec command
				[_x,"PATH"] remoteExec ["enableAI", owner _x];
			};
			_enabled = _enabled + 1;
		};
	};
} forEach _objects;

["%1 AI's legs were disabled. %2 AI's received their legs back", _disabled, _enabled] call zen_common_fnc_showMessage;












#include "script_component.hpp"
/* File:	fnc_canDisableAIMovement.sqf
 * Author: 	riksuFIN
 * Description:	Condition check for Zeus Context menu item
 *
 * Called from:	
 * Local to: 	
 * Parameter(s):
 0:	_objects		<ARRAY>
 1:	
 2:	
 3:	
 4:	
 Returns:		
 * 
 * Example:
	[[player]] call RAA_zeus_fnc_canDisableAIMovement
 */

params ["_objects"];

_objects findIf {alive _x && {_x isKindOf "CAManBase"} && !isPlayer _x} != -1;






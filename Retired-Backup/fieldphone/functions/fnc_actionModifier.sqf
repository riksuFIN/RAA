#include "script_component.hpp"
/* File: fnc_actionModifier.sqf
 * Author(s): riksuFIN
 * Description: Modifies action name to include channel ID
 *
 * Called from: ACE action menu
 * Local to:	Client
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
params ["_target", "_player", "_params", "_actionData"];

_actionData set [1, format ["Disconnect cable ID#%1", _target getVariable [QGVAR(connected), -1]]];


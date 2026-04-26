#include "../script_component.hpp"
#include "../defines.hpp"
/* File: fnc_passwordChallenge.sqf
 * Author(s): riksuFIN
 * Description: Handles password challenge on console
 *
 * Called from: 
 * Local to:	Client
 * Parameter(s):
 * 0:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_passwordChallenge
*/
params [["_password", ""], ["_commandToExec", ""]];
["Enter password:", nil, false] call FUNC(addLine);

GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge), _password];
GVAR(currentConsoleObject) setVariable [QGVAR(passwordChallenge_commandToExec), _commandToExec];	// This will be executed on console upon successful password


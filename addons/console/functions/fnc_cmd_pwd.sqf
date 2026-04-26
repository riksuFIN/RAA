#include "../script_component.hpp"
/* File: fnc_cmd_.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	Params  <ARRAY>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_cmd_
*/
params ["_sudo", ["_params", []], ["_interactedObject", ACE_player]];

private _interactedObject = missionNamespace getVariable [QGVAR(currentConsoleObject), ACE_player];
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];

[_currentPath, nil, false] call FUNC(addLine);

//[COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);




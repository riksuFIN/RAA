#include "../script_component.hpp"
/* File: fnc_cmd_.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	Sudo permissions <BOOL>
 * 1:	Params  <ARRAY>
 * 2:	Object being interacted with <OBJECT>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_cmd_
*/
params ["_sudo", ["_params", []], ["_interactedObject", ACE_player]];

/*  Some common functions and variables used:
// INPUT_TEXT, OBJECTTOWRITE, WRITECURRENTDIRECTORY
["SOME TEXT TO PRINT", _interactedObject] call FUNC(addLine);
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];
private _fileSystem = _interactedObject getVariable [QGVAR(fileSystem), []];
*/

[COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);






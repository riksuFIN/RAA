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



private _fileSystem = _interactedObject getVariable [QGVAR(fileSystem), []];
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];

private _directoryContent = _fileSystem getOrDefault [_currentPath, []];


if (_directoryContent isEqualTo []) exitWith {
	["ERROR: DIRECTORY NOT FOUND", nil, false] call FUNC(addLine);
};

_directoryContent params [["_metadata", []], ["_directories", []]];
_metadata params [["_passworded", false]];

[COMPNAME, GVAR(debug), "DEBUG", format ["Path: %1, content: %2", _currentPath, _directories]] call EFUNC(common,debugNew);

if (count _directories > 0) then {
	[_directories joinString "  ", nil, false] call FUNC(addLine);
} else {
	[COMPNAME, GVAR(debug), "NOTE", format ["Folder %1 is empty", _currentPath]] call EFUNC(common,debugNew);
};








#include "../script_component.hpp"
/* File: fnc_cmd_cat.sqf
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
 *	[] call RAA_console_fnc_cmd_cat
*/
params ["_sudo", ["_params", []], ["_interactedObject", ACE_player]];

private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];

_params params [["_filePath", ""]];

// If provided param is relative we handle that
if (_filePath select [0, 1] isNotEqualTo "/") then {
	_filepath = format ["%1/%2", _currentPath, _filePath];
};

// Get file content and check if it's valid
private _files = _interactedObject getVariable [QGVAR(files), []];
private _file = _files getOrDefault [_filePath, -1];
if (_file isEqualTo -1) exitWith {
	[format ["cat: %1: No such file or directory", _filePath], _interactedObject] call FUNC(addLine);
};

_file params [["_meta", []], "_content"];
_meta params [["_password", false], "_content"];

// Check password
if (_password isNotEqualTo false && !(_interactedObject getVariable [QGVAR(sudo_enabled), false])) exitWith {
	[_password, format ["%1cat %2", ["", "sudo "] select _sudo, (_params joinString " ")]] call FUNC(passwordChallenge);
};

// Now we can finally print this file to console
[_content, _interactedObject] call FUNC(addLine);



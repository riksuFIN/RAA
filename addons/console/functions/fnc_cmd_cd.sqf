#include "../script_component.hpp"
/* File: fnc_cmd_.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_cmd_
*/
params ["_sudo", ["_params", []], ["_interactedObject", ACE_player]];

//[COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);

private _targetPath = _params param [0,""];

private _fileSystem = _interactedObject getVariable [QGVAR(fileSystem), []];
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];

// Empty param goes to home
if (_targetPath isEqualTo "") exitWith {
    _targetPath = "/home";
	[COMPNAME, GVAR(debug), "DEBUG", format ["CD: param empty, went home %1", _this]] call EFUNC(common,debugNew);
};

// Go back one step in file structure
if (_targetPath isEqualTo "..") exitWith {
	_targetPath = _currentPath splitString "/\";
	_targetPath deleteAt [-1];
	_targetPath insert [0, [""]];
	if (count _targetPath isEqualTo 1) then {_targetPath pushBack ""};	// Handle going to root
	_targetPath = _targetPath joinString "/";

	// Ensure this path exists
	if (_targetPath in _fileSystem) then {
		_interactedObject setVariable [QGVAR(currentPath), _targetPath];
		[] call FUNC(onConsoleOpen);
	} else {
		[format ["bash: cd %1: No such file or directory", _targetPath], nil, false] call FUNC(addLine);
	};

};

// If provided param is relative path we handle that
private _newPath = _targetPath;
if (_targetPath select [0, 1] isNotEqualTo "/") then {
	// Relative path
	if (_currentPath isEqualTo "/") then {
		_newPath = format ["/%1", _targetPath];
	} else {
		_newPath = format ["%1/%2", _currentPath, _targetPath];
	};
};

// If last character in given path is slash remove that
if (_targetPath select [count _targetPath - 1, 1] isNotEqualTo "/") then {
	_targetPath = _targetPath trim ["/\", 2];
};

// We've got out path. Now check if it's valid one.
private _getFolder = _fileSystem getOrDefault [_newPath, -1];
if (_getFolder isNotEqualTo -1) then {
	_getFolder params [["_metadata", []], ["_directories", []]];
	_metadata params [["_password", false]];

	// If this is first time using sudo we run a password challenge
	if (_password isNotEqualTo false && !(_interactedObject getVariable [QGVAR(sudo_enabled), false])) exitWith {
		[_password, format ["%1cd %2", ["", "sudo "] select _sudo, _params joinString " "]] call FUNC(passwordChallenge);
	};
	_interactedObject setVariable [QGVAR(currentPath), _newPath];

	// Also call console refresh
	[] call FUNC(onConsoleOpen);
} else {
	
	[format ["bash: cd %1: No such file or directory", _targetPath], nil, false] call FUNC(addLine);
	[COMPNAME, GVAR(debug), "DEBUG", format ["CD: Path:%1", _newPath]] call EFUNC(common,debugNew);
};








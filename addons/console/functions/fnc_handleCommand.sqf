#include "../script_component.hpp"
/* File: fnc_handleCommand.sqf
 * Author(s): riksuFIN
 * Description: Handles calling various commands called from console
 *
 * Called from: fnc_onKeyUp.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Input <STRING>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_
*/
params [["_input", "", [""]], ["_sudo", false, [false]]];

if (_input isEqualTo "") exitWith {
    [COMPNAME, GVAR(debug), "WARNING", format ["Received invalid or nil command %1", _this]] call EFUNC(common,debugNew);
};

// Split intake to command and its params
private _values = _input splitString " ";
private _command = toLower (_values param [0, ""]);

// Handle sudo
if (_command isEqualTo "sudo") then {
	_sudo = true;
	_values deleteAt 0;
	_command = toLower (_values param [0, ""]);

	// TODO: Add sudo challenge!	----------------------------------------------------------------------------------

};

// Check for empty value
if (_command isEqualTo "") exitWith {
    [COMPNAME, GVAR(debug), "NOTE", format ["Received invalid or nil command %1", _this]] call EFUNC(common,debugNew);
};

// Check if this command exists
//	====================== TODO: Add support for function-added commands to support adding custom commands in missions
private _commandName = getText (configFile >> QGVAR(commands) >> _command >> "name");
if (_commandName isEqualTo "") exitWith {
    [format ["Command '%1' not found.", _command], nil, false] call FUNC(addLine);
};

// Remove command from values array.
_values deleteAt 0;

private _object = missionNamespace getVariable [QGVAR(currentConsoleObject), ACE_player];

// Execute given function
[_sudo, _values, _object] call compile (getText (configFile >> QGVAR(commands) >> _command >> "function"));



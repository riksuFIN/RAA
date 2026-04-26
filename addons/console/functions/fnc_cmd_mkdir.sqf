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

if (count _params < 1) exitWith {
    ["mkdir: missing operand<br/>Try 'help mkdir' for more information", nil, false] call FUNC(addLine);
};

private _fileSystem = _interactedObject getVariable [QGVAR(fileSystem), []];
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];

{
	// Check if we're dealing with hard or relative path
    if (_x select [0, 1] isEqualTo "/")  then {
        // This param is a hard path

		// Check if this path already exists
		if (_x in _fileSystem) then {
			[format ["Provided directory already exists: %1", _x], nil, false] call FUNC(addLine);

		} else {
		// TODO: ADD HARD PATH	===========================================

		//	} forEach (_x splitString "/\");

			[COMPNAME, GVAR(debug), "DEBUG", format ["CD: Created path %1 (not really, not implemented yet)", _x]] call EFUNC(common,debugNew);
		};
        
    } else {
        // Relative path
		private _return = [_interactedObject, _x, _currentPath, _sudo, false] call FUNC(createFolder);
		if (_return isEqualTo false) then {
			[format ["Unable to create directory %1/%2", _currentPath, _x], nil, false] call FUNC(addLine);
		};

    };
} forEach _params;


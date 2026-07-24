#include "../script_component.hpp"
/* File: fnc_cmd_rmdir.sqf
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
    ["rmdir: missing operand<br/>Try 'help rmdir' for more information", nil, false] call FUNC(addLine);
};

private _fileSystem = _interactedObject getVariable [QGVAR(fileSystem), []];
private _currentPath = _interactedObject getVariable [QGVAR(currentPath), "/"];


{
	private _countSlash = count (_x splitString "/");
    if (_countSlash > 1) then {
        // This param is a hard path
		private _split = _x splitString "/\";
		private _folderName = _split select -1;
		private _path = (_split deleteAt [-1]);
		_path insert [0, ""];
		_path joinString "/";
        [_interactedObject, _folderName, _path] call FUNC(removeFolder);

    } else {
        // This is relative path
		[_interactedObject, _x, _currentPath] call FUNC(removeFolder);

		//params [["_object", GVAR(currentConsoleObject)], "_folderName", "_path", "_ignorePassword", "_params"];

    };
    [COMPNAME, GVAR(debug), "DEBUG", format ["Removed folder %1", _x]] call EFUNC(common,debugNew);
} forEach _params;



/*
{
	private _countSlash = count (_x splitString "/");
    if (_countSlash > 1) then {
        // This param is a hard path
        _fileSystem deleteAt _x;

    } else {
        // This is plain text with just folder.

        // TODO: do some input parsing to make sure there are no douple quotes or something that could break something
        // For now only support creating one level of folders, no nested folder creation with single command.
        if (_countSlash > 1) exitWith {
            ["Failed to delete directory: nested directory deletion is not supported.", nil, false] call FUNC(addLine);
        };

		_fileSystem deleteAt format ["%1/%2", _currentPath, _x];
		// TODO: delete all folders under this deleted one as well!
		// Propably a function that loops and does new call for every subfolder with items in it
        
    };
    [COMPNAME, GVAR(debug), "DEBUG", format ["Removed folder %1", _x]] call EFUNC(common,debugNew);
} forEach _params;
*/



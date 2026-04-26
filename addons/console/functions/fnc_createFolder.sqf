#include "../script_component.hpp"
/* File: fnc_createFolder.sqf
 * Author(s): riksuFIN
 * Description: Used to create new folder or re-name existing one
				This fnc can be executed without having console interface open, but in that case should only be executed on server to avoid data desync
 *
 * Called from: Any
 * Local to:	Client
 * Parameter(s):
 * 0:	Console's object ref	<OBJECT, default GVAR(currentConsoleObject)>
 * 0:	Name of folder to be created	<STRING>
 * 1:	Path where folder will be created (without new folder)	<STRING>
 * 2:	Sudo or password required for accessing new folder	<BOOL or STRING, default false>
 *
 Returns: False if failed, 1 if created new folder, 2 if overwrote previous
 *
 * Example:	
 *	[] call RAA_console_fnc_createFolder
*/
params [["_object", GVAR(currentConsoleObject)], "_folderName", "_path", ["_sudo", false], ["_allowModify", true]];

private _fileSystem = _object getVariable [QGVAR(fileSystem), []];

// Check if this filepath even exists
if !(_path in _fileSystem) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Failed to create folder %2: Path %1 does not exist", _path, _folderName]] call EFUNC(common,debugNew);
	// ============ TODO: instead of hard-quit add missing filepath
	false
};

private _folderToAdd = format ["%1/%2", _path, _folderName];

// If modification of existing folder is disabled we check that now
if (_folderToAdd in _fileSystem && !_allowModify) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Folder %1 already exists and we're not allowed to modify it", _folderToAdd]] call EFUNC(common,debugNew);
	false
};

// Now add or modify folder
private _get = _fileSystem getOrDefault [_folderToAdd, -1];
private _wasOverwritten = _fileSystem set [_folderToAdd , [[_sudo], (_get param [1, []])]];

// We also need to register this folder in its parent folder
_fileSystem get _path params [["_password", [false]], ["_content", []]];
_content pushBack _folderName;
_fileSystem set [_path, [_password, _content]];


[COMPNAME, GVAR(debug), "INFO", format ["Created folder %1", _folderToAdd]] call EFUNC(common,debugNew);

[1, 2] select _wasOverwritten

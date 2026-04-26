#include "../script_component.hpp"
/* File: fnc_removeFolder.sqf
 * Author(s): riksuFIN
 * Description: Used to create new folder or re-name existing one
				This fnc can be executed without having console interface open, but in that case should only be executed on server to avoid data desync
 *
 * Called from: Any
 * Local to:	Client
 * Parameter(s):
 * 0:	Console's object ref	<OBJECT, default GVAR(currentConsoleObject)>
 * 0:	Name of folder to be deleted	<STRING>
 * 1:	Path where folder will be removed (without folder in question)	<STRING>
 *
 Returns:	False if failed, true if success
 *
 * Example:	
 *	[] call RAA_console_fnc_removeFolder
*/
params [["_object", GVAR(currentConsoleObject)], "_folderName", "_path", "_ignorePassword", "_params"];

private _fileSystem = _object getVariable [QGVAR(fileSystem), []];

private _workFolder = format ["%1/%2", _path, _folderName];

// Since folder we want to delete could have nested folders inside we want to delete all of them at same time
private _pathsToRemove = [_workFolder];
_pathsToRemove append ([_fileSystem, format ["%1/%2", _path, _folderName]] call FUNC(findNestedFolders));


{
	// Delete actual folder
	_fileSystem deleteAt _x;

	// Remove reference from parent folder
	private _parentPath = _x splitString "/\";
	private _removedFolder = _parentPath deleteAt [-1];
	_parentPath insert [0, [""]];
	_parentPath = _parentPath joinString "/";

	_fileSystem get _parentPath params [["_password", [false]], ["_content", []]];

	_content = _content - [_removedFolder];
	_fileSystem set [_parentPath, [_password, _content]];

} forEach _pathsToRemove;

[COMPNAME, GVAR(debug), "INFO", format ["Deleted %1 folders", count _pathsToRemove]] call EFUNC(common,debugNew);

/*
// If modification of existing folder is disabled we check that now
private _get = _fileSystem getOrDefault [_folderToAdd, -1];
if (_folderToAdd in _fileSystem && !_allowModify) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", format ["Folder %1 already exists and we're not allowed to modify it", _folderToAdd]] call EFUNC(common,debugNew);
	false
};

// Now add or modify folder
private _wasOverwritten = _fileSystem set [_folderToAdd , [[_sudo], (_get param [1, []])]];

// We also need to register this folder in its parent folder
private _oldArray = _fileSystem get _path;
_fileSystem set [_path, [_oldArray param [0, false], _oldArray param [1, []] pushBack _folderName]];


[COMPNAME, GVAR(debug), "INFO", format ["Created folder %1", _folderToAdd]] call EFUNC(common,debugNew);

[1, 2] select _wasOverwritten
*/

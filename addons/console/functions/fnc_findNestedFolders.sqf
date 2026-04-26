#include "../script_component.hpp"
/* File: fnc_findNestedFolders.sqf
* Author(s): riksuFIN
* Description:	description
*
* Called from:	
* Local to:		
* Parameter(s):	
* 0:	
* 1:	
* 2:	
*
Returns: 	
*
* Example:	
*	[] call RAA_console_fnc_findNestedFolders
*/
params ["_fileSystem", "_basePath"];


private _result = [];
(_fileSystem get _basePath) params ["_metadata", ["_directories", []]];
_metadata params [["_password", false]];

	// ============= TODO: Add password challenge if encountering passworded/ sudo folder
if (count _directories > 0) then {
	_result append _directories;
	{
		_result append ([_fileSystem, format ["%1/%2", _basePath, _x]] call FUNC(findNestedFolders));
	} forEach _directories;
};

[COMPNAME, GVAR(debug), "DEBUG", format ["findNestedFolders: Found: %1", _result]] call EFUNC(common,debugNew);

_result

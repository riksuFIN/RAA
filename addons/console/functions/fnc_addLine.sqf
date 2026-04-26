#include "../script_component.hpp"
#include "../defines.hpp"
/* File: fnc_addLine.sqf
 * Author(s): riksuFIN
 * Description: Writes a new line to console log. Input must NOT be structured text!
 *
 * Called from: Anywhere
 * Local to:	Client
 * Parameter(s):
 * 1: Text to add to new line   <STRING>
 * 2: Console's object. If empty global test variable will be used  <OBJECT, default objNull>
 * 3: Append current console path to text <BOOL, default false>
 * 4: Save added line. Disable for promts which do not have to be saved to log. <BOOL, default true>		NOTE: THIS DOES NOT WORK FOR NOW
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_
*/
params [["_lineInput", ""], ["_object", GVAR(currentConsoleObject)], ["_addPath", false], ["_saveLine", true]];
if (_object isEqualTo objNull) then {_object = ACE_player};

private _consoleFeed = _object getVariable [QGVAR(consoleFeed), []];

private _currentPathStr = ["", _object getVariable [QGVAR(currentPath), "/"]] select _addPath;

_consoleFeed pushBack [_currentPathStr, _lineInput];

// Now save.
_object setVariable [QGVAR(consoleFeed), _consoleFeed];


// If console is currently open we update that
if !(isNull (uiNamespace getVariable [QGVAR(consoleDisplay), displayNull])) then {
	[] call FUNC(onConsoleOpen);

};


//[COMPNAME, GVAR(debug), "DEBUG", format ["AddLine: %1", _lineInput, _object]] call EFUNC(common,debugNew);


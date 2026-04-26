#include "../script_component.hpp"
#include "../defines.hpp"
/* File: fnc_onConsoleOpen.sqf
 * Author(s): riksuFIN
 * Description: Fills console display with content
 *
 * Called from: onLoad EH attached console display
 * Local to:	Client
 * Parameter(s):
 * 1: Display   <DISPLAY>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_
*/

disableSerialization;

params [["_display", displayNull], ["_saveDisplay", false]];

if (_saveDisplay) then {
	uiNamespace setVariable [QGVAR(consoleDisplay), _display];
};


//private _openConsoleFeed = composeText ([GVAR(currentConsoleObject) getVariable [QGVAR(consoleFeed), []], GVAR(consoleFeed)] select (isNull GVAR(currentConsoleObject)));

private _format = format ["<t font='%1' size='0.6' color='#00ff00'>", FONT];

private _openConsoleFeedArr = [];
//_openConsoleFeedArr pushBack parseText format ["<t font=%1>", FONT];
{
	_x params [["_path", "N/A"], ["_input", "N/A"]];
	if (_path isEqualTo "") then {
		_openConsoleFeedArr pushBack parseText format ["%1 %2", _format, _input];
	} else {
		_openConsoleFeedArr pushBack parseText format ["%1 %2: <t color='#ffffff'>%3", _format, _path, _input];
	};
	_openConsoleFeedArr pushBack lineBreak;

} forEach (GVAR(currentConsoleObject) getVariable [QGVAR(consoleFeed), []]);

private _openConsoleFeed = composeText _openConsoleFeedArr;

// Write text to UI
private _ctrlRef_feedBox = displayCtrl IDC_FEEDBOX;
_ctrlRef_feedBox ctrlSetStructuredText _openConsoleFeed;

// Resize feedbox to allow scrolling if lines start overlapping screen
private _textHeight = ctrlTextHeight _ctrlRef_feedBox;
private _textHeight = _textHeight max (FEEDBOX_HEIGHT);
private _pos = ctrlPosition _ctrlRef_feedBox;

_ctrlRef_feedBox ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, _textHeight];
//_ctrlRef_feedBox ctrlSetPositionH _textHeight;

_ctrlRef_feedBox ctrlCommit 0;


/*		MOVED TO onCommited EH on gui_console.hpp
// Force scrolling to bottom
//[{displayCtrl IDC_FEEDBOX_GROUP ctrlSetScrollValues [1,0];},[]] call CBA_fnc_execNextFrame;
[{
    displayCtrl IDC_FEEDBOX_GROUP ctrlSetScrollValues [1, 1];
}, [], 1] call CBA_fnc_waitAndExecute;
//(displayCtrl IDC_FEEDBOX_GROUP) ctrlSetScrollValues [1,0];
//_ctrlRef_feedBox ctrlSetScrollValues [0,0];
*/

// Now set path box
private _ctrlRef_path = displayCtrl IDC_PATHBOX;
_ctrlRef_path ctrlSetText (GVAR(currentConsoleObject) getVariable [QGVAR(currentPath), "/"]);


// Shrink size of path box to fit exactly text it contains
private _path_width = ctrlTextWidth _ctrlRef_path;
_ctrlRef_path ctrlSetPositionW _path_width;
_ctrlRef_path ctrlCommit 0;

// Get sizes of each control
private _ctrlPos_path = ctrlPosition _ctrlRef_path;
private _ctrlRef_edit = displayCtrl IDC_INPUT;
private _ctrlPos_edit = ctrlPosition _ctrlRef_edit;
private _ctrlPos_feed = ctrlPosition displayCtrl IDC_FEEDBOX;

_ctrlRef_edit ctrlSetPosition [(_ctrlPos_path select 0) + (_ctrlPos_path select 2), _ctrlPos_edit select 1, (_ctrlPos_feed select 2) - (_ctrlPos_path select 2), _ctrlPos_edit select 3];
_ctrlRef_edit ctrlCommit 0;



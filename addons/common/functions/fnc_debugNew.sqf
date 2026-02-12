#include "script_component.hpp"
/* File: fnc_debugNew.sqf
 * Author(s): riksuFIN
 * Description: Handles debug message(s) with different severitys
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 *
 Returns: 
 *
 * Example(s):	
*/
params [["_module", "Common"], ["_debug", false], ["_priority_text", "INFO"], ["_text", ""], ["_overrides", []]];

// We don't run debugs if it's not critical or debugs are not enabled by client
if (!_debug && (_priority_text isNotEqualTo "ERROR")) exitWith {};


_overrides params [["_chat", true], ["_hint", false], ["_log", false], ["_broadcast", false]];

switch (_priority_text) do {
	case ("ERROR"): {_log = true; _chat = true; _hint = true};
	case ("WARNING"): {_log = true; _chat = true};
	case ("WARNING_G"): {_log = true; _chat = true; _broadcast = true;};
	case ("LOG"): {_log = true;};
	case ("INFO");
	case ("NOTE"): {_chat = true};
	case ("ERROR_G"): {_log = true; _chat = true; _broadcast = true};
	case ("BROADCAST"): {_chat = false; _broadcast = true};
};

private _text = format ["[%1  %2] %3", str _module, [_priority_text, ""] select (_priority_text isEqualTo "BROADCAST"), _text];

if (_chat) then {
	systemChat _text;
};

if (_hint) then {
	hintC _text;
};

if (_log) then {
	diag_log format ["[RAA] %1", _text];
};

if (_broadcast) then {
	[_text] remoteExec ["systemChat", [0, -2] select isDedicated];
};
#include "script_component.hpp"
/* File: fnc_debug.sqf
 * Author(s): riksuFIN
 * Description: Shows debug messages
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Module <STRING, default "Common">
 * 1:	Text	<STRING, default "">
 * 2:	Show systemChat <BOOL, default true>
 * 3:	Show pop-up to player (hintC)	<Bool, default false>
 * 4:	Print in log <BOOL, default false>
 *
 Returns: 
 *
 * Example(s):	
["RAA_misc", "WARNING", "Don't worry, everything's gonna be fine", true, false, false] call RAA_common_fnc_debug
if (GVAR(debug)) then {[COMPONENT, "INFO", format ["%1 is %2", false, true], true, false] call EFUNC(common,debug);};
*/
params [["_module", "Common"], ["_priority", "WARNING"], ["_text", ""], ["_systemChat", true], ["_popup", false], ["_log", false]];

// If priority was given as number format it to text
if (_priority isEqualType 0) then {
	_priority = switch (_priority) do {
		case (0): {"ERROR"};
		case (1): {"WARNING"};
		case (2): {"INFO"};
		default {"INFO"};
	};
};


private _text = format ["[%1  %2] %3",_module, _priority, _text];

if (_systemChat) then {
	systemChat _text;
};

if (_popup) then {
	hintC _text;
};

if (_log) then {
	diag_log _text;
};


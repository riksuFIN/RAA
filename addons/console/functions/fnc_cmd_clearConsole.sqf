#include "../script_component.hpp"
/* File: fnc_cmd_clearConsole.sqf
 * Author(s): riksuFIN
 * Description: Clears history from current console
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

if !(_sudo) exitWith {
	["Insuffient permission", nil, false] call FUNC(addLine);
};

private _interactedObject = missionNamespace getVariable [QGVAR(currentConsoleObject), ACE_player];

_interactedObject setVariable [QGVAR(consoleFeed), []];         // This is array all existing text on console will be saved to.


// If console is currently open we update that
if !(isNull (uiNamespace getVariable [QGVAR(consoleDisplay), displayNull])) then {
	[] call FUNC(onConsoleOpen);
};

//[COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);




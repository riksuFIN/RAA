#include "../script_component.hpp"
/* File: fnc_cmd_.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	Sudo permissions <BOOL>
 * 1:	Params  <ARRAY>
 * 2:	Object being interacted with <OBJECT>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_cmd_
*/
params ["_sudo", ["_params", []], ["_interactedObject", ACE_player]];

date params ["_year", "_month", "_day", "_hours", "_minutes"];
if (_minutes < 10) then {
	_minutes = format ["0%1", _minutes];
};
[format ["%1.%2.%3 %4:%5", _day, _month, _year, _hours, _minutes], _interactedObject] call FUNC(addLine);

//[COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);






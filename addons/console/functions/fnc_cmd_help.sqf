#include "../script_component.hpp"
/* File: fnc_cmd_help.sqf
 * Author(s): riksuFIN
 * Description: 	Prints all commands or detailed info about specific command to console
 *
 * Called from: fnc_handleCommand
 * Local to:	Client
 * Parameter(s):
 * 0:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_addLine
*/
params [["_sudo", false], ["_params", []], ["_interactedObject", ACE_player]];

if (_params isEqualTo []) then {
    // We list all possible commands in console
    [COMPNAME, GVAR(debug), "DEBUG", format ["Params %1", _this]] call EFUNC(common,debugNew);

    private _configClasses = "getNumber (_x >> 'hidden') < 1" configClasses (configFile >> QGVAR(commands));

    // Print all non-hidden commands to console
    private _text = "";
    {
        private _commandName = configName (_x);
        private _help = getText (_x >> "help");

        _text = format ["%1<br/>%2", _text, _help];

    } forEach _configClasses;

    [_text, nil, false] call FUNC(addLine);

} else {
    // We only want deeper information about single command
    private _param1 = (_params param [0, ""]);
    private _helpLong = getText (configFile >> QGVAR(commands) >> _param1 >> "helpLong");
    if (_helpLong isEqualTo "") exitWith {
        [format ["[HELP] Command %1 not found.", _param1], nil, false] call FUNC(addLine);
    };

    // Give feedback
    [format [_helpLong], nil, false] call FUNC(addLine);
};



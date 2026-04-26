#include "../script_component.hpp"
/* File: fnc_onUnload.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: UI EH
 * Local to:	Client
 * Parameter(s):
 * 0:	Sudo permissions <BOOL>
 * 1:	Params  <ARRAY>
 * 2:	Object being interacted with <OBJECT>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_console_fnc_onUnload
*/


// Sync data back to server for safekeeping
private _obj = GVAR(currentConsoleObject);
if !(isServer) then {
	[COMPNAME, GVAR(debug), "DEBUG", "Unload: Synchronizing data to server"] call EFUNC(common,debugNew);
	_obj setVariable [QGVAR(fileSystem), _obj getVariable QGVAR(fileSystem), 2];
	_obj setVariable [QGVAR(consoleFeed), _obj getVariable QGVAR(consoleFeed), 2];
	_obj setVariable [QGVAR(history), _obj getVariable QGVAR(history), 2];
	_obj setVariable [QGVAR(historyIndex), _obj getVariable QGVAR(historyIndex), 2];
	_obj setVariable [QGVAR(files), _obj getVariable QGVAR(files), 2];
	_obj setVariable [QGVAR(currentPath), _obj getVariable QGVAR(currentPath), 2];
	_obj setVariable [QGVAR(sudo), _obj getVariable QGVAR(sudo), 2];
	_obj setVariable [QGVAR(passwordChallenge), _obj getVariable QGVAR(passwordChallenge), 2];
	_obj setVariable [QGVAR(sudo_enabled), _obj getVariable QGVAR(sudo_enabled), 2];
};


// Un-reserve console object and detach from it
_obj setVariable [QGVAR(reserved), -1, true];				// This value has to be present on every machine
_obj setVariable [QGVAR(last_update), serverTime, true];	// Used to limit unnecessary network traffic
_obj setVariable [QGVAR(last_update_local), serverTime];
_obj = ACE_player;

uiNamespace setVariable [QGVAR(consoleDisplay), nil]; 


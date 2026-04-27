#include "../script_component.hpp"
/* File: fnc_loadInterface.sqf
* Author(s): riksuFIN
* Description:	Used to boot console interface
*
* Called from:	
* Local to:		
* Parameter(s):	
* 0:	Console object. For debugging you may pass ACE_player or player		<OBJECT>
* 1:	
* 2:	
*
Returns: 	
*
* Example:	
*	[] call RAA_console_fnc_loadInterface
*/

params [["_interactedObject", objNull]];

if (_interactedObject isEqualTo objNull) exitWith {
	[COMPNAME, GVAR(debug), "WARNING", "Invalid object passed!"] call EFUNC(common,debugNew);
};


GVAR(currentConsoleObject) = _interactedObject;

// Reserve this object for this client so no-one else can access it.
_interactedObject setVariable [QGVAR(reserved), clientOwner, true];

// If version of saved data is later on server than our machine we need to request latest version from server
if (isMultiplayer && {_interactedObject getVariable [QGVAR(last_update), 0] > (_interactedObject getVariable [QGVAR(last_update_local), -1])}) exitWith {

	[clientOwner, _interactedObject] call FUNC(server_sendData);
	[{_this getVariable [QGVAR(last_update), 0] > _this getVariable [QGVAR(last_update_local), -1]}, {
		createDialog "RAA_console_console";
	}, _interactedObject, 10, {[COMPNAME, GVAR(debug), "ERROR", "loadInterface: Data request from server failed!"] call EFUNC(common,debugNew);}] call CBA_fnc_waitUntilAndExecute;
};



createDialog "RAA_console_console"


/*if !(isServer) then {
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

uiNamespace setVariable [QGVAR(consoleDisplay), nil]; */

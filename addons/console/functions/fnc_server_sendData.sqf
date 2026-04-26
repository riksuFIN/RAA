#include "../script_component.hpp"
/* File: fnc_server_sendData.sqf
* Author(s): riksuFIN
* Description:	Synchronizes console system's data on given device to given client
*
* Called from:	Event "server_sendData"
* Local to:		Server
* Parameter(s):	
* 0:	Network ID of client who requested data (clientOwner)	<NUMBER>
* 1:	Object data is requested to be synchronized from		<OBJECT>
* 2:	
*
Returns: 	Success	<BOOL>
*
* Example:	
*	[] call RAA_console_fnc_server_sendData
*	[QGVAR(server_sendData)", "test message server"] call CBA_fnc_serverEvent;
*/
params ["_client", ["_interactedObject", objNull, [objNull]]];

if (isNull _interactedObject) exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["server_sendData: Invalid object %1", _interactedObject]] call EFUNC(common,debugNew);
	false
};
if (_interactedObject getVariable [QGVAR(reserved), -1] > -1) exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["server_sendData: Object %1 reserved by %2", _interactedObject, _client]] call EFUNC(common,debugNew);
	false
};


[COMPNAME, GVAR(debug), "DEBUG", format ["server_sendData: Synchronizing Obj %1 data to %2", _interactedObject, _client]] call EFUNC(common,debugNew);
_interactedObject setVariable [QGVAR(fileSystem), _interactedObject getVariable QGVAR(fileSystem), _client];
_interactedObject setVariable [QGVAR(consoleFeed), _interactedObject getVariable QGVAR(consoleFeed), _client];
_interactedObject setVariable [QGVAR(history), _interactedObject getVariable QGVAR(history), _client];
_interactedObject setVariable [QGVAR(historyIndex), _interactedObject getVariable QGVAR(historyIndex), _client];
_interactedObject setVariable [QGVAR(files), _interactedObject getVariable QGVAR(files), _client];
_interactedObject setVariable [QGVAR(currentPath), _interactedObject getVariable QGVAR(currentPath), _client];
_interactedObject setVariable [QGVAR(sudo), _interactedObject getVariable QGVAR(sudo), _client];
_interactedObject setVariable [QGVAR(passwordChallenge), _interactedObject getVariable QGVAR(passwordChallenge), _client];
_interactedObject setVariable [QGVAR(sudo_enabled), _interactedObject getVariable QGVAR(sudo_enabled), _client];
_interactedObject setVariable [QGVAR(last_update_local), serverTime, _client];

// TODO: Check if when saving variables on client also deletes them on sender's side

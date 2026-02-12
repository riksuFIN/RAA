#include "script_component.hpp"
/* File: fnc_handleRackRadio.sqf
 * Author(s): riksuFIN
 * Description: Adds or removes radio to/from rack.
 *
 * Called from: fnc_connectCable.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Phone object <OBJECT>
 * 1:	Channel to connect to <NUMBER>	-1 to delete current radio
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_object", "_channel"];



private _rack = ([_object] call acre_api_fnc_getVehicleRacks) select 0;
if (_channel < 0 || _channel > 90) then {
	// Remove phone's cable
	
	
	// Check if phone is currently ringing
	private _soundSource = _object getVariable [QGVAR(ringing_source), objNull];
	if !(isNull _soundSource) then {
		deleteVehicle _soundSource;
		_object setVariable [QGVAR(ringing_source), nil, true];
		_object setVariable [QGVAR(ringing), false, true];
	};
	
	_channel = _object getVariable [QGVAR(connected), 0];
	
	// Delete radio from rack
	_object setVariable [QGVAR(mountedRadioID), nil, true];	// Clear variable used in action
	private _mountedRadio = [_rack] call acre_api_fnc_getMountedRackRadio;
	[_mountedRadio, DISCONNECTED_CHANNEL] call acre_api_fnc_setRadioChannel;
	
	/*	Radio is no longer removed, just switched to different chnl
	if (_mountedRadio isNotEqualTo "") then {		// Avoid calling ACRE functions unnecessarily
		[_rack, _mountedRadio] remoteExec ["acre_api_fnc_unmountRackRadio", [0, 2] select isMultiplayer];		// SERVER EXEC
		if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Radio removed from rack: %1", _rack];};
	} else {
		if (GVAR(debug)) then {systemChat "[RAA_fieldphone] No radio mounted";};
	};
	*/
	// Update status on screen
	_object setObjectTextureGlobal [1,QPATHTOF(pics\phone_disconnected.paa)];
	
	
	// Remove this from array of connected phones
	private _array = GVAR(connectedPhones) param [_object getVariable [QGVAR(connected), 0], []];
	private _index = _array find _object;
	if (_index >= 0) then {
		_array deleteAt _index;
	};
	
	_channel = _object getVariable [QGVAR(connected), 0];
	GVAR(connectedPhones) set [_channel, _array];
	publicVariable QGVAR(connectedPhones);
	
	
	// Set flag for other scripts that cable is disconnected
	_object setVariable [QGVAR(connected), -1, true];
	
	if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] %1 disconnected from %2, index 3", _object, _channel, _index];};
	
} else {
	// Connect cable
	
	
	/*	SWITCHED TO RADIO BEING ALWAYS MOUNTED		TODO DELETE THIS BLOCK LATER
	// Add new radio to rack
	[_rack, "ACRE_PRC148"] remoteExec ["acre_api_fnc_mountRackRadio", [0, 2] select isMultiplayer];	// SERVER EXEC
		// !!! Digging code, above fnc raises event for PLAYER to mount radio (via non-public fnc) ?!?
	*/
	
	// Now we need to wait until radio has been created. I guess this is a great spot to add some animation
	
	[_object, "CONNECTING", true] call FUNC(doUpdateScreen);
	
	if (GVAR(debug)) then {GVAR(connectionStarted) = time;};
	
	/*
	[	{		// Condition
			([_this select 2] call acre_api_fnc_getMountedRackRadio) isNotEqualTo "" && (time - GVAR(connectionStarted) > 3)
		}, {	// Code
			_this call RAA_fieldphone_fnc_handleRackRadio2;
			if GVAR(debug) then {systemChat format ["[RAA_fieldphone] Connecting took %1s", time - GVAR(connectionStarted)]};
			GVAR(connectionStarted) = nil;
		}, [	// Params
			_object, _channel, _rack
		],		// Timeout
			10,
		{		// Timeout code
			[_object, "CONNECTION_FAILED", true] call FUNC(doUpdateScreen);
			if GVAR(debug) then {systemChat "[RAA_fieldphone] [ERROR] Connection failed!";};
		}
	] call CBA_fnc_waitUntilAndExecute;
	*/
	[	{
			_this call RAA_fieldphone_fnc_handleRackRadio2;
			if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Connecting took %1s", time - GVAR(connectionStarted)]};
			if (GVAR(debug)) then {GVAR(connectionStarted) = nil;};
		}, [
			_object, _channel, _rack
		],
		CONNECTION_TIME + (random 2)
	] call CBA_fnc_waitAndExecute;
	
	
	
};

#include "script_component.hpp"
/* File: fnc_doRing.sqf
 * Author(s): riksuFIN
 * Description: Handles starting of ringing action
 *
 * Called from: ACE action
 * Local to:	Client
 * Parameter(s):
 * 0:		Phone <OBJECT>
 * 1:		Start ringing <BOOL>
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_object", "_doRing"];

private _channel = _object getVariable [QGVAR(connected), -1];
if (_channel < 0) exitWith {
	if GVAR(debug) then {systemChat "[RAA_fieldphone] Cable is not connected, exit script";};
};



if (_doRing) then {
	// Start ringing
	
	// Mark this phone as one that started ringing action. This will cause sligly different behaviour on this phone
	_object setVariable [QGVAR(ringing_origin), true, true];
	
	{
		// Muted phones will not have ringing, only light
		if (!(_x getVariable [QGVAR(muted), false]) && !(_x getVariable [QGVAR(ringing), false])) then {
			private _soundSource = createSoundSource ["RAA_sound_phone_ringing", position _x, [], 0];
			_soundSource attachTo [_x, [0, 0, 0]];
			
			_x setVariable [QGVAR(ringing_source), _soundSource, true];
			
			
			if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Ringing started for %1", _x];};
		} else {
			
			
			if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Ringing was muted for %1", _x];};
		};
		
		_x setVariable [QGVAR(ringing), true, true];
		
		// Start visual effect loop. This runs locally on each client
		[_x] remoteExec [QFUNC(ringing_loop), [0, -2] select isDedicated];
		
		
	} forEach (GVAR(connectedPhones) param [_channel, []]);
	
} else {
	// Stop ringing
	
	{
		private _soundSource = _x getVariable [QGVAR(ringing_source), objNull];
		if !(isNull _soundSource) then {
			deleteVehicle _soundSource;
			
			_x setVariable [QGVAR(ringing_source), nil, true];
		};
		
		_x setVariable [QGVAR(ringing), false, true];
		if (_x getVariable [QGVAR(ringing_origin), false]) then {	// Only one phone has this, so no need to broadcast nil value for every phone
			_object setVariable [QGVAR(ringing_origin), nil, true];
		};
		
		if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Ringing stopped for %1", _x];};
	} forEach (GVAR(connectedPhones) param [_channel, []]);
	
};





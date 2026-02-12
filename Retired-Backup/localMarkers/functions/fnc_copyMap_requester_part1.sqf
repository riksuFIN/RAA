#include "script_component.hpp"
/* File: fnc_copyMap_requester.sqf
 * Author(s): riksuFIN
 * Description: Requests allmapMarkers data from target client.
 *
 * Called from: ACE action menu
 * Local to:	(requster) Client
 * Parameter(s):
 * 0:	Target
 * 1:	ShowMessage (optional, default true)	Feedback for client on how many markers were copied
 Returns: 
 *
 * Example:	
 *	[] call RAA_localMarkers_fnc_copyMap_requester_part1
*/
params ["_target", ["_showMessage", true]];


// Target client will answer to this array, so we have to clear it first
GVAR(allMarkers_send) = nil;
GVAR(allMarkers_data) = nil;

// Send request to target client to transmit their allMapMarkers data
[QGVAR(get_allMarkers), [CBA_clientID, GVAR(channelOverride)], _target] call CBA_fnc_targetEvent;

// Progressbar for checking number of markers. Quits as soon as data is received from target client, but not before 3 seconds
GVAR(startCopyingTime) = time;
[
	format ["Checking if %1 has new markers..", name _target],	// Title
	10,		// Delay. We use this for timeout in case target client never responds to our data request.
	{!(!isNil QGVAR(allMarkers_send) && (time - GVAR(startCopyingTime) > 3))},		// Condition
	{	// On Success (bad for us, means we didnt receive answer in time)
		[COMPNAME, GVAR(debug), "ERROR", format ["Failed to receive data from target client %1", _this select 0 select 0]] call EFUNC(common,debugNew);
		
	}, {	// On failure (in this case desired)
		params ["", "", "_elapsedTime", "", "_failure_code"];
		if (_failure_code isEqualTo 2) then {	// Condition turned false; we received requested data
			
			[	{
					_this select 0 call FUNC(copyMap_requster_part2);
				}, 
				_this,
				1
			] call CBA_fnc_waitAndExecute;
			[COMPNAME, GVAR(debug), "INFO", format ["Data received after %1 s", _elapsedTime]] call EFUNC(common,debugNew);
			
		};
	},
	_this	// Arguments
] call CBA_fnc_progressBar;
/*
[
	format ["Copying map markers from %1..", name _target],	// Title
	_delay,		// Delay
	{true},		// Condition
	{_this call FUNC(copyMap)},		// On Success
	{},	// On Failure
	_this	// Arguments
] call CBA_fnc_progressBar;
*/






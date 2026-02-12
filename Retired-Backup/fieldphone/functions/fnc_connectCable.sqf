#include "script_component.hpp"
/* File: fnc_fieldphone_connectCable.sqf
 * Author(s): riksuFIN
 * Description: handle connecting simulated cable to radio
 *
 * Called from: ACE action
 * Local to:	Client
 * Parameter(s):
 * 0:	Phone object <OBJECT>
 * 1:	Cable ID that we should connect to (represents radio channel) <STRING, default -1>	If -1 ID will be randomly picked for manual connecting
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_object", "_cableID"];


private _exit = false;
if (_cableID < 0) then {
	// -1 was supplied as channel
	// This means we want to connect cable, but dont know which one is free
	// This should only be case when using Normal connection method (having to walk between each phone)
	
	if (player getVariable [QGVAR(deployingCable), _cableID] >= 0) exitWith {
		_exit = true;
		systemChat "Unable to pick up cable, you already have one";
	};
	
	
	// Find unused channel
	private _index = GVAR(connectedPhones) find [];
	if (_index >= 0) then {
		// Great, we have our cable index
		_cableID = _index;
		
		systemChat "One end of cable is now connected, now walk to second phone and connect other end of cable";
		
	} else {
		// All slots are in use. Too bad. 
		// As a fallback just join some random cable and say that someone just accidentally cross-connected some cables
		_cableID = floor random [0, 7, 15];
		systemChat "One end of cable is now connected, now walk to second phone and connect other end of cable. You ran out of spare cables so you used Y-splitter on existing line.";
		
	};
	
	
	
	
	player setVariable [QGVAR(deployingCable), _cableID];
	
	
} else {
	// Check if player was deploying cable in manual mode, and reset it
	if (player getVariable [QGVAR(deployingCable), -1] >= 0) then {
		if (_object getVariable [QGVAR(connected), -1] >= 0) then {
			if (_cableID < 90) then {
				// If passed cableID is 99 that means we're trying to disconnect current cable.
				systemChat "Unable to connect cable, there is one already connected!";
				_exit = true;
			};
			
		} else {
			systemChat "Cable laying finished!";
			
			player setVariable [QGVAR(deployingCable), nil];
		};
		
		
	};
};

// This condition will happen if attempting to start laying new cable while player already is laying one
if (_exit) exitWith {};

//[_object, _cableID] remoteExec [QFUNC(handleRackRadio), [0, 2] select isMultiplayer];
[_object, _cableID] call FUNC(handleRackRadio);






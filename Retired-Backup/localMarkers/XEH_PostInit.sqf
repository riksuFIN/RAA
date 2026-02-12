#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */

// ================ PRIVATE CHANNEL =======================
// This is used for Private marker channel system (where players can add markers which will never be copied to others)

// Init gvar if it's not yet broadcasted from server to avoid errors in other functions.
if (isNil QGVAR(privateChannelID)) then {
	GVAR(privateChannelID) = -99;
};


// Create Private Channel and broadcast its ID to clients
if (isServer && GVAR(privateChannel_enabled)) then {
	private _channelName = "Private Markers";
	private _channelID = radioChannelCreate [[0.12, 0.35, 0.75, 1], _channelName, "%UNIT_NAME", []];
	if (_channelID == 0) exitWith {[COMPONENT, GVAR(debug), "WARNING", "Private chat channel creation failed!"] call EFUNC(common,debugNew)};
	GVAR(privateChannelID) = _channelID;
	publicVariable QGVAR(privateChannelID);
//	[_channelID, {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
};

	// Client-side
if (hasInterface) then {
	
	// ================ PRIVATE CHANNEL =======================
	// Re-add player's unit to Private channel after every respawn
	if (GVAR(privateChannel_enabled)) then {
		player addEventHandler ["Respawn", {
			params ["_unit"];
			if (GVAR(privateChannelID) >= 0) then {
				
				GVAR(privateChannelID) radioChannelAdd [_unit];
				[COMPNAME, GVAR(debug), "INFO", format ["%1 re-added to Private Markers Channel", _unit]] call EFUNC(common,debugNew);
			};
		}];
		
		// Join channel on first start.
		[	{		// Condition
				GVAR(privateChannelID) >= 0
			}, {	// Code
				GVAR(privateChannelID) radioChannelAdd [player];
			}, [	// Params
			],		// Timeout
				20
		] call CBA_fnc_waitUntilAndExecute;
	};
	

	
	
	// ================ LOCAL MARKERS =======================
	// This is hasMap used to store all markers made players but whose markers have not been shared globally
	GVAR(hiddenMarkers) = createHashMap;
	
	// Set up system to request allMarkers command's result from other clients.
	// This creates unavoidable net traffic, since allMapMarkers is a local command
	[QGVAR(get_allMarkers), LINKFUNC(copyMap_target_part1)] call CBA_fnc_addEventHandler;
	
	
	// Create a way to get marker data for certain marker(s) from client, in case requester client does not already have them
	[QGVAR(get_marker_data), LINKFUNC(copyMap_target_part2)] call CBA_fnc_addEventHandler;
	
	
	
	
	
	
	// Handle JIP
	if (didJIP && GVAR(enabled)) then {
		[	{
				call compile preprocessFileLineNumbers QPATHTOF(functions\fnc_onJIP.sqf)
			}, [
			],
			10
		] call CBA_fnc_waitAndExecute;
		
	};
	
};




#include "script_component.hpp"
/* File: fnc_copyMap_target_allMarkers.sqf
 * Author(s): riksuFIN
 * Description: Second part of copying map markers. 
 *					Tells requester client our filtered allmapMarkers result, based on which they can copy our markers
 *
 * Called from: 
 * Local to:	Target client
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
	params ["_requesterClientID", "_overrideChannel"];
	
	// We want to ship as little data as possible
	private _marker = "";
	private _markersToSend = [];
	{
		// First we strip off all markers made in editor or by scripts
		if (_x call FUNC(madeByPlayer)) then {
			
			// Never send over any markers on private channel.
			if (markerChannel _x isNotEqualTo (GVAR(privateChannelID) + 5)) then {
				[COMPNAME, GVAR(debug), "INFO", format ["%1 was madeByPlayer", _marker]] call EFUNC(common,debugNew);
				
				// Next we make sure marker name is stripped off of our tags
				_marker = [_x] call FUNC(marker_stripTag);
				[COMPNAME, GVAR(debug), "INFO", format ["%1 was madeByPlayer", _marker]] call EFUNC(common,debugNew);
				// Great, we've got a marker made by player.
				// Now strip away markers on excluded channel. For this we use requester's overriden channel
				if (markerChannel _marker isNotEqualTo _overrideChannel) then {
					// This is data we want to send, name of marker made by player without any tags.
					_markersToSend pushBack _marker;
					
					// ----------------------------
					// TODO perhaps add option here to pre-send data on markers that requester client likely won't already have?
					
				};
			};
		};
		
	} forEach allMapMarkers;
	
	GVAR(allMarkers_send) = _markersToSend;
	
	[_markersToSend, CBA_clientID] remoteExec [QFUNC(copyMap_requster_part2), _requesterClientID];
	
	if (_requesterClientID != CBA_ClientID) then {
		_requesterClientID publicVariableClient QGVAR(allMarkers_send); // send back over network
	};
	
	[COMPNAME, GVAR(debug), "INFO", format ["Client %1 requested your markers, sent %2 markers out of %3 total.", _requesterClientID, count _markersToSend, count allMapMarkers]] call EFUNC(common,debugNew);
	
//	if (GVAR(debug)) then {[ADDON, "INFO", format ["Client %1 requested your map markers, sent %2 markers", _requesterClientID, count _markersToSend], true, false] call EFUNC(common,debug);};

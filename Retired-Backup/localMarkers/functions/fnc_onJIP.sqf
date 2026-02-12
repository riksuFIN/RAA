#include "script_component.hpp"
/* File: fnc_onJIP.sqf
 * Author(s): riksuFIN
 * Description: Handle localMarkers system for JIP players by deleting all markers that are not on overriden channel.
 					It is not possible to know who created marker so even player's own markers will be lost if they crash or dc'd
					Unless, of course, someone else had those markers and copied them from that player
 
 *
 * Called from: XEH_postInit
 * Local to:	
 * Parameter(s):
 * 0:	Data from MissionEventhandler MarkerCreated
 *
 Returns: 
 *
*/
//params ["_x", "_channelNumber", "_owner", "_local"];

//if (GVAR(debug)) then {[ADDON, "INFO", "Running localMarkers JIP handling", true, false] call EFUNC(common,debug);};

if !(GVAR(enabled)) exitWith {};




// Provide a way to override functionality on global or unit-level via variable RAA_misc_override
// These are checked since I don't think there is better way to check for global variables in fail-safe way
private _var1 = [GVAR(override), false] select (isNil QGVAR(override));
private _var2 = [zafw_safestart_on, false] select (isNil "zafw_safestart_on");

if (player getVariable [QGVAR(override), false] || _var1 || _var2) exitWith {
	if (GVAR(debug)) then {
		if (_var1 || _var2) then {
			systemChat format ["[localMarkers] Local markers override is enabled globally, doing nothing", _x];
		} else {
			systemChat format ["[localMarkers] Local Markers is overriden on unit (setVariable), doing nothing", _x];
		};
	};
};




	// Game is in full play, so we will delete all markers shared to us that we should not see
	// We will play by assumption that JIP'd player is a brand new one, and they did not JIP due to crash or other technical issue, since we can't know that
private _debug_handledMarkers = 0;
private _debug_hiddenMarkers = 0;
{
	INC(_debug_handledMarkers);
	
	// We only want to touch player-made markers
	if (_x call FUNC(madeByPlayer)) then			// "_USER_DEFINED #2070497606/13/0"
	{
		// Delete marker if it was created by non-local player
		if (markerChannel _x isEqualTo GVAR(channelOverride)) then {
			// This marker should not be deleted. We'll leave it here
			
		} else {
			INC(_debug_hiddenMarkers);
			
			// Add this marker to our list of hidden markers and delete it
			GVAR(hiddenMarkers) set [
			_x, [
				getPlayerID player, 	// NOTE: This reference is only "de-cryptable" on server, so useless for us. Keeping it there for future
				markerAlpha _x,
				markerChannel _x,
				markerColor _x,
				markerDir _x,
				markerPolyline _x,
				markerPos _x,
				markerShadow _x,
				markerShape _x,
				markerSize _x,
				markerText _x,
				markerType _x
			]];
			
			deleteMarkerLocal _x;
		};
	};
	
} forEach allMapMarkers;


if (GVAR(debug)) then {[COMPNAME, "INFO", format ["JIP handling hid %1 markers, %2 were checked. This only counts player-made markers.", _debug_hiddenMarkers, _debug_handledMarkers], true, false, true] call EFUNC(common,debug);};

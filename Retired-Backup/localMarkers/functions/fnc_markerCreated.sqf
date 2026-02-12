#include "script_component.hpp"
/* File: fnc_markerCreated.sqf.sqf
 * Author(s): riksuFIN
 * Description: Handles markerCreated MissionEventHandler for localMarkers and privateChannel systems. 
 *
 * Called from: Mission Event Handler, set up in cba_settings.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Data from MissionEventhandler MarkerCreated
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_localMarkers_fnc_markerCreated
*/
params ["_marker", "_channelNumber", "_owner", "_local"];

// Any markers created on privateChannel are immediately deleted and excluded
if (_channelNumber isEqualTo (GVAR(privateChannelID) + 5)) exitWith {
	if !(_local) then {
		deleteMarkerLocal _marker;
	};
	[COMPNAME, GVAR(debug), "INFO", format ["Marker %1 was created on Private Channel.", _marker]] call EFUNC(common,debugNew);
};


// Rest of this fnc is dedcated for localmarkers system. If it's disabled we have no business down there.
if !(GVAR(enabled)) exitWith {};

if (_marker find "_localMarkers" > 0) exitWith {
	[COMPNAME, GVAR(debug), "INFO", format ["%1 was created by localMarkers, doing nothing", _marker]] call EFUNC(common,debugNew);
};


// Check if marker is created on Override chat channel
if (_channelNumber isEqualTo GVAR(channelOverride)) exitWith {
	// This marker should not be deleted. We'll leave it here
	if (GVAR(debug)) then {
		systemChat format ["[localMarkers] Marker %1 by %2 was created on overriden channel", _marker, _owner];
	};
};


// We only want markers created by players
if !(_marker call FUNC(madeByPlayer) || _owner isEqualTo objNull) exitWith {
	[COMPNAME, GVAR(debug), "INFO", format ["Skipping marker %1 since it was not made by player", _marker]] call EFUNC(common,debugNew);
};


// Provide a way to override functionality on global or unit-level via variable RAA_localMarkers_override
// These are checked since I don't think there is better way to check for global variables in fail-safe way
private _var1 = [RAA_localMarkers_override, false] select (isNil "RAA_localMarkers_override");
private _var2 = [zafw_safestart_on, false] select (isNil "zafw_safestart_on");

if (_owner getVariable ["RAA_localMarkers_override", false] || _var1 || _var2) exitWith {
	if (GVAR(debug)) then {
		if (_var1 || _var2) then {
			systemChat format ["[localMarkers] Local markers override is enabled globally, doing nothing", _marker];
		} else {
			systemChat format ["[localMarkers] Local Markers is overriden on unit (setVariable), doing nothing", _marker];
		};
	};
};


// Add (or update) this marker to our list of hidden markers
private _isNewMarker = GVAR(hiddenMarkers) set [
_marker, [
	getPlayerID _owner, 	// NOTE: This reference is only "de-cryptable" on server, so useless for us. Keeping it there for future
	markerAlpha _marker,
	markerChannel _marker,
	markerColor _marker,
	markerDir _marker,
	markerPolyline _marker,
	markerPos _marker,
	markerShadow _marker,
	markerShape _marker,
	markerSize _marker,
	markerText _marker,
	markerType _marker
]];

if (typeName markerShape _marker isNotEqualTo "STRING") then {
	[COMPNAME, GVAR(debug), "WARNING", format ["Marker %1 markerShape is %2!", _marker, markerShape _marker]] call EFUNC(common,debugNew);
};



// We're done with this marker, lets banzai it (but only if it originates from someone else)
private _debug_hidden = "ERROR";
if (!_local) then {
	if (GVAR(directChatOverride) && _channelNumber isEqualTo 5) then {
		_debug_hidden = "false (direct chat)";
	} else {
		deleteMarkerLocal _marker;
		_debug_hidden = "true (was not local)";
	};
} else {
	_debug_hidden = "false (is local)";
};


if (GVAR(debug)) then {[COMPNAME, "INFO", format ["Marker %1 was handled, hidden: %3, it was new: %2", _marker, !_isNewMarker, _debug_hidden], true, false] call EFUNC(common,debug);};


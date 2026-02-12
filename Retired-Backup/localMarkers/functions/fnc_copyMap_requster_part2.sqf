#include "script_component.hpp"
/* File: fnc_copyMap_target.sqf
 * Author(s): riksuFIN
 * Description: Applies data requsted from target client in copyMap_requster_part1 to requester client's map.
 *
 * Called from: localMarkers\fnc_copyMap_requester_part1.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Target whose map we're copying 	<Player OBJECT>
 * 1:	Show feedback message	<BOOL, default true>
 *
 Returns: 
 *
 * Example:	
 *	[cursorObject] call RAA_localMarkers_fnc_copyMap_requster_part2
*/
//params ["_target", ["_showMessage", true]];
params ["_markers_data", "_target", ["_showMessage", true]];



/*------------------------
if (isNil QGVAR(allMarkers_send)) exitWith {
	[COMPNAME, GVAR(debug), "ERROR", format ["Failed to receive data from target client %1!", _target]] call EFUNC(common,debugNew);
};
*/


// Progressbar
//private _progressBarTime = count GVAR(allMarkers_send) * 0.25 min 20 max 3;
private _progressBarTime = count _markers_data * 0.25 min 20 max 3;
[
	format ["Copying %1 markers from %2", count GVAR(allMarkers_send), name _target],	// Title
	_progressBarTime,		// Delay
	{true},		// Condition
	{	// On Success
		
	}, {	// On failure 
	},	// On Failure
	[]	// Arguments
] call CBA_fnc_progressBar;




// Go through all markers to find new markers
private _markerCount = 0;
private _modifiedMarkers = 0;
private _unknownMarkers = [];
{
	private _markerWithTag = format ["%1_localMarkers", _x];
	
	if (_x in GVAR(hiddenMarkers) || _markerWithTag in allMapMarkers) then {
		// This marker is in list of hidden markers or already exists on map. Not for long!
		
		// Get data from hasMap
		private _markerData = GVAR(hiddenMarkers) get _x;
		
		// Check if marker is already copied or if we need to create new one. Now we need to add our tag back
		
		if (_markerWithTag in allMapMarkers ) then {
			// This marker already exists, lets just modify it
			INC(_modifiedMarkers);
			
		} else {
			// This marker doesnt exist yet, we create new one
			_markerWithTag = createMarkerLocal [_markerWithTag, _markerData select 6, _markerData select 2, _target];
			INC(_markerCount);
		};
		
		
		// Now update all data to marker.
		_markerWithTag setMarkerAlphaLocal (_markerData select 1);
		_markerWithTag setMarkerColorLocal (_markerData select 3);
		_markerWithTag setMarkerDirLocal (_markerData select 4);
		if (_markerData select 5 isNotEqualTo []) then {	// This command throws error if it's called unnecessarily
			_markerWithTag setMarkerPolylineLocal (_markerData select 5);
		};
		_markerWithTag setMarkerShadowLocal (_markerData select 7);
		private _markerShape = _markerData select 8;		// For some weird reason markerShape is sometimes saved wrong (as 0 instead of string??)
		if (typeName _markerShape isNotEqualTo "STRING") then {
			_markerShape = "ICON";
			[COMPNAME, GVAR(debug), "WARNING", format ["Marker %1 markershape is %2!!", _marker, _markerShape]] call EFUNC(common,debugNew);
		};
		_markerWithTag setMarkerShapeLocal (_markerShape);
		_markerWithTag setMarkerSizeLocal (_markerData select 9);
		_markerWithTag setMarkerTextLocal (_markerData select 10);
		_markerWithTag setMarkerTypeLocal (_markerData select 11);
		
		// Now that this marker is no longer hidden we delete it from our hasMap
		GVAR(hiddenMarkers) deleteAt _x;
		
	} else {
		// We have no data for this marker, we need to request it from target client
		_unknownMarkers pushBack _x;
	};
	
/*	markerData (array):
0		getPlayerID _owner, 	
1		markerAlpha _marker,	
2		markerChannel _marker,
3		markerColor _marker,	
4		markerDir _marker,	
5		markerPolyline _marker,
6		markerPos _marker,	
7		markerShadow _marker,
8		markerShape _marker,	
9		markerSize _marker,	
10		markerText _marker,	
11		markerType _marker	
*/
	
//} forEach GVAR(allMarkers_send);
} forEach _markers_data;

if (count _unknownMarkers > 0) then {
	[COMPONENT, GVAR(debug), "NOTE", format ["We're missing data on %1 markers, sent request to target client", count _unknownMarkers]] call EFUNC(common,debugNew);
	[COMPONENT, GVAR(debug), "LOG", format ["Requesting missing marker data from client %1: %2", _target, _unknownMarkers]] call EFUNC(common,debugNew);
	
	[QGVAR(get_marker_data), [CBA_clientID, _unknownMarkers], _target] call CBA_fnc_targetEvent;
	
	GVAR(get_marker_data_answer) = nil;	// This is where target client will answer our request.
	
	[	{		// Condition
			!(isNil QGVAR(get_marker_data_answer))
		}, {	// Code
			params ["_target"];
			{
			// Check if this marker already contains tag. If not we add it. Transmitted markers should never come with tags!
			private _marker_nameToUse = _x select 0;
				if !(_x select 0 find "_localMarkers" > 0) then {
					_marker_nameToUse = format ["%1_localMarkers", _x select 0];
				};
				private _marker = createMarkerLocal [_marker_nameToUse , _x select 6, _x select 2, _target];
				
				// Update all data to marker.
				_marker setMarkerAlphaLocal (_x select 1);
				_marker setMarkerColorLocal (_x select 3);
				_marker setMarkerDirLocal (_x select 4);
				if (_x select 5 isNotEqualTo []) then {	// This command throws error if it's called unnecessarily
					_marker setMarkerPolylineLocal (_x select 5);
				};
				_marker setMarkerShadowLocal (_x select 7);
				_marker setMarkerShapeLocal (_x select 8);
				_marker setMarkerSizeLocal (_x select 9);
				_marker setMarkerTextLocal (_x select 10);
				_marker setMarkerTypeLocal (_x select 11);
			} forEach GVAR(get_marker_data_answer);
			
		}, [	// Params
			_target
		],		// Timeout
			15,
		{		// Timeout code
			[COMPONENT, GVAR(debug), "ERROR", format ["Failed to receive requested markers from client %1! (unkown markers request)", _this]] call EFUNC(common,debugNew);
		}
	] call CBA_fnc_waitUntilAndExecute;
	
	
	
};



if (_showMessage) then {
	if (_markerCount + _modifiedMarkers > 0) then {
		[format ["%1 markers copied and %2 already existing ones modified from %3's map. Missing data requested for %4 markers", _markerCount, _modifiedMarkers, name _target, count _unknownMarkers], false, 20, 3] call ace_common_fnc_displayText;
	} else {
		[format ["%1 has no new markers to copy", name _target], false, 20, 3] call ace_common_fnc_displayText;
	};
};


if (GVAR(debug)) then {[COMPONENT, "INFO", format ["Target %1 had %2 markers, %3 were new and %5 were updated to us. Missing data requested for %4 markers", _target, count GVAR(allMarkers_send), _markerCount, _modifiedMarkers, count _unknownMarkers], true, false, false] call EFUNC(common,debug);};


//if (GVAR(debug)) then {systemChat format ["[RAA_misc-localMarkers] Target %1, ID %3. Found %2 markers to show, Went through %3 markers", _target, _markerCount, _netID, _crawledMarkers];};



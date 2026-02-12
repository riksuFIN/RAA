#include "script_component.hpp"
/* File: fnc_copyMap_target_part2.sqf
 * Author(s): riksuFIN
 * Description: Sends data on markers which requester client don't have information on.
 *
 * Called from: 
 * Local to:	
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

params ["_clientID", "_requestedMarkers"];

GVAR(get_marker_data_answer) = [];
{
	private _marker = _x;
	if !(_marker in allMapMarkers) then {
		_marker = _x call FUNC(marker_stripTag);
	};
	GVAR(get_marker_data_answer) pushBack [
		_x,
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
	];
	
} forEach _requestedMarkers;

if (_clientID != CBA_clientID) then {
	_clientID publicVariableClient QGVAR(get_marker_data_answer); // send back over network

	[COMPNAME, GVAR(debug), "INFO", format ["Client %1 requested data for %2 markers", _clientID, count _requestedMarkers]] call EFUNC(common,debugNew);
};
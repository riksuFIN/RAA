#include "script_component.hpp"
/* File: fnc_marker_stripTag.sqf
 * Author(s): riksuFIN
 * Description: Strips off our localMarkers tag from marker's name if there is one.
 *
 * Called from: 
 * Local to:	Client
 * Parameter(s):
 * 0:	Name of marker to check
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *			STRING name of marker withouth our localMarkers tag
 * Example:	
 *	[] call fileName
*/
params ["_marker"];

private _find = _marker find "_localMarkers";
if (_find > 0) then {
	
	_marker select [0, _find - 1];
	
} else {
	_marker
};
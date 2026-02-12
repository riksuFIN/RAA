#include "script_component.hpp"
/* File: fnc_markerDeleted.sqf
 * Author(s): riksuFIN
 * Description: Deletes marker from array
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Marker (String)
 * 1:	Is marker local (bool)
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_localMarkers_fnc_markerDeleted
*/

params ["_marker", "_local"];





if (_marker in GVAR(hiddenMarkers)) then {
	GVAR(hiddenMarkers) deleteAt _marker;
	
	[COMPNAME, GVAR(debug), "INFO", format ["%1 was deleted from hidden markers array", _marker]] call EFUNC(common,debugNew);
};


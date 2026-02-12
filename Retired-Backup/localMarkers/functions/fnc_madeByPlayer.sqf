#include "script_component.hpp"
/* File: fnc_madeByPlayer.sqf
 * Author(s): riksuFIN
 * Description: Returns true if given marker is made by player, false if not
 *
 * Called from: 
 * Local to:	Caller
 * Parameter(s):
 * 0:	Marker <STRING>
 *
 Returns: 
 * made by player (Bool)
 * 
 *
 Is given marker made by player (or localMarkers feature) (BOOL)
 			
 *
 * Example:	
 *	[] call RAA_localMarkers_fnc_madeByPlayer
*/
params ["_marker"];

if (_marker select [0,15] isEqualTo "_USER_DEFINED #") exitWith			// "_USER_DEFINED #2070497606/13/0"
{
	true;
};

false

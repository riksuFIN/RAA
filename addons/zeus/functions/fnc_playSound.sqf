#include "script_component.hpp"
/* File: fnc_playSound.sqf
 * Author(s): riksuFIN
 * Description: Plays given sound to all players in given radius
 *
 * Called from: 
 * Local to: Caller
 * Parameter(s):
 0:		
 1: 	
 2: 	
 3: 
 4:
 *
 Returns:
 *
 * Example:	[] call fileName
*/

params ["_sound", "_radius"];





// Only send sound across MP to players who can actually hear it
private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, _distance, _distance, 0, false, _distance];
if (_targets isEqualTo []) exitWith {
	
};
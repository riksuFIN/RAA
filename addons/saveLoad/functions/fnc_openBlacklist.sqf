#include "script_component.hpp"
/* File: fnc_openBlacklist.sqf
 * Author(s): riksuFIN
 * Description: Put together list of blacklisted entities and SteamID64's into single, easily processable array
 *
 * Called from: Various
 * Local to:	Caller
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: ARRAY containing all entries of blacklist modules and objects synchorized to them
 *
 * Example:	
 *	[] call RAA_saveLoad_fnc_openBlacklist
*/


// Check blacklist
private _blackList = [];
{
	_blackList pushBackUnique parseSimpleArray _x;		// Entries written to field inside module by missionMaker
	_blackList pushBackUnique synchronizedObjects _x;	// Objects synchronized to module itself
} forEach entities QGVAR(save_blacklist);




_blacklist
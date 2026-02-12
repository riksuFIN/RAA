#include "script_component.hpp"
/* File: fnc_blacklist.sqf
 * Author(s): riksuFIN
 * Description: Handles 'Blacklist' modules. Assigns variables to all synchronized objects and adds hand-writted entries to array
 *
 * Called from: Various
 * Local to:	Caller
 * Parameter(s): NONE
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_saveLoad_fnc_blacklist
*/


// Mark all synchronized objects as blacklisted and shoutout that to everyone
private _debug_objs = 0;
private _debug_misc = 0;
private _blacklist = [];
{
	{	// Objects synchronized to module
		_x setVariable [QGVAR(blacklist), true, true];
		INC(_debug_objs);
	} forEach synchronizedObjects _x;
	
//	private _entries = call compile (_x getvariable [QGVAR(blacklist), ""]);
	private _entries = _x getvariable [QGVAR(blacklist), ""];
	if (typeName _entries isEqualTo "ARRAY" && {count _entries > 0}) then {
		{
			_blacklist pushBackUnique _x;		// Entries written to field inside module by missionMaker
			INC(_debug_misc);
		} forEach _entries;
	};
} forEach entities QGVAR(module_blacklist);

[COMPNAME, GVAR(debug), "INFO", format ["Blacklist contains %1 objects and %2 other entries.", _debug_objs, _debug_misc]] call EFUNC(common,debugNew);

// Now publish list of shame to everyone on server
GVAR(blacklist) = _blackList;

if (isServer) then {	// Only server may send blacklist to clients to avoid spamming network
	publicVariable QGVAR(blacklist);	// This should be JIP compatible
};

_blacklist
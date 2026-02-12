#include "script_component.hpp"
/* File: fnc_takeFromBelt.sqf
 * Author(s): riksuFIN
 * Description: Steals item from another player's belt.
 *
 * Local to:	Client who's taking item
 * Parameter(s):
 0:	BeltSlot's physical object which is being taken
 1: Player who's taking this object
 *
 Returns: Nothing
 *
 * Example:	
 *	[player] call RAA_beltSlot_fnc_takeFromBelt
*/
params [["_object", objNull], ["_player", ACE_player]];

if (isNull _object || isNull _player) exitWith {};


_object getVariable [QGVAR(beltSlotItem), []] params [["_owner", ACE_player], ["_classname", ""], ["_slot", -1]];

private _classname = _object getVariable [QGVAR(classname), ""];

[COMPNAME, GVAR(debug), "INFO", format ["Taking object %1 from %2 by %3 from slot %4", _object, _owner, _player, _slot]] call EFUNC(common,debugNew);

// Remove this item from its owner's belt. Has to be done on their machine
[_slot, _owner] remoteExec [QFUNC(beltSlot_deleteFromBelt), _owner];

// Add visual feedback
[_player, "PutDown"] call "ACE_common_fnc_doGesture";
[4, 1, 5] remoteExec ["addCamShake", _owner];
["Someone took something from your belt"] remoteExec ["systemChat", _owner];

// Attempt to put it directly to player's own belt
private _success = ["", _player, _className, true] call RAA_beltSlot_fnc_beltSlot_doMoveToBelt;

if (_success) exitWith {};

// Failed to put on belt, spawn it in inventory or, if even that fails, spawn it on ground
private _return = [_player, _className, ""] call ace_common_fnc_addToInventory;
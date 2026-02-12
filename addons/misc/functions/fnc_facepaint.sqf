#include "script_component.hpp"
/* File: fnc_facepaint.sqf
 * Author(s): riksuFIN
 * Description: Changes player's face between camo and original one
 *
 * Called from: 	ACE self-action menu
 * Parameter(s):
 0:		Unit (MUST be player)	<unit>
 *
 Returns:
 *
 * Example:	[player] call RAA_misc_fnc_facepaint
 */

params ["_unit"];

//private _paintApplied = _unit getVariable ["RAA_misc_facepaintApplied", false];


private _faces = _unit getVariable ["RAA_misc_facepaint_faces", []];
private _face = "Kerry";

if ((face _unit) == (_faces select 0)) then {
	// Unit does not have camo face, so lets apply one
	_face = _faces select 1;
	
} else {
	// Unit's face is already painted so lets wash it away
	_face = _faces select 0;
};


//private _jip = "RAA_facePaint_" + str _unit;	// Generate custom ID for JIP which we can overwrite at will
[_unit, _face] remoteExec ["setFace", 0, _unit];
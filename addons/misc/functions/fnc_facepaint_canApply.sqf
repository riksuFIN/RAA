#include "script_component.hpp"
/* File: fnc_facepaint_canApply.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: 	ACE self-action menu
 * Parameter(s):
 0:		Unit
 1: 	
 2: 	
 3: 
 4:
 *
 Returns: Boolean: Can use facepaint feature
 *
 * Example:	[player] call RAA_misc_fnc_facepaint_canApply
 */
params [["_unit", ACE_player]];

private _faces = _unit getVariable ["RAA_misc_facepaint_faces", []];
if (_faces isEqualTo []) exitWith {
	execVM QPATHTOF(scripts\facepaint_init.sqf);
	false
};

if (RAA_misc_requireFacePaintItem) then {
	"RAA_facepaint" in ([_unit] call ace_common_fnc_uniqueItems) && (face _unit) isNotEqualTo (_faces select 1);
	
} else {
	(face _unit) isNotEqualTo (_faces select 1);
	
};




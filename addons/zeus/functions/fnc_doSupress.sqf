#include "script_component.hpp"
/* File:	fnc_doSupress.sqf
 * Author: 	riksuFIN
 * Description:	Calls Lambs fnc_tacticsSuppress
 *
 * Called from:	
 * Local to: 	
 * Parameter(s):
 0:	_objects		<ARRAY>		List of selected objects
 1:	
 2:	
 3:	
 4:	
 Returns:		
 * 
 * Example:

*/

params ["_objects"];

// Pick leader of group from first selected unit
private _leader = leader (_objects select 0);



if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] Ordering group %1 to supress", group _leader];};
//["%1 AI's legs were disabled. %2 AI's received their legs back", _disabled, _enabled] call zen_common_fnc_showMessage;


[_leader, {	// Source object
	params ["_success","_objects","_pos", "_args", "_shiftState", "_controlState", "_altState"];
	_args params ["_leader"];
	if (_success) then {
		
		// Order supress
		[_leader, _pos] call lambs_danger_fnc_tacticsSuppress;
		
	};
}, [_leader], "Target Location"] call zen_common_fnc_selectPosition;








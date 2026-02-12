#include "script_component.hpp"
/* File: fnc_tearFabric_start.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[ACE_player, _cursorObject] call RAA_ACEA_fnc_tearFabric_start
*/
params ["_player", "_target"];

private _fabric_torn_times = _target getVariable [QGVAR(tear_fabric_times), 0];

// Reset tearing times if uniform classname has changed
private _fabric_torn_times = _target getVariable [QGVAR(tear_fabric_times), 0];
private _uniform = _target getVariable [QGVAR(tear_fabric_uniformClass), ""];
if (_uniform isNotEqualTo (uniform _target)) then {
	_fabric_torn_times = 0;
	_target setVariable [QGVAR(tear_fabric_times), 0, true];
	[COMPNAME, GVAR(debug), "INFO", format ["Uniform was changed to %1, tearCount was reset,", _uniform]] call EFUNC(common,debugNew);
};

// Check if uniform's already depleted
if (_fabric_torn_times > GVAR(tearFrabric_tearingTimesUntilDepleted)) exitWith {
	if (_target isEqualTo ACE_Player) then {
		[parseText "<t color='#384bc7'>Your</t> uniform has already been torn to pieces, nothing useable remains.", false, 15, 3] call ace_common_fnc_displayText;
	} else {
		[parseText format ["<t color='#384bc7'>%1</t>'s uniform has already been torn to pieces, nothing useable remains.", name _target], false, 15, 3] call ace_common_fnc_displayText;
	};
};

[{[_this select 0, "RAA_tearFabric", 10] call EFUNC(common,3dSound);

// ExecNextFrame may be unnecessary here, but better safe than sorry.
["Tearing uniform..", 3, {true}, {_this call FUNC(tear_fabric)}, {}, _this] call CBA_fnc_progressBar}, [_player, _target]] call CBA_fnc_execNextFrame;

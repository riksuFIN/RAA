#include "script_component.hpp"
/* File: fnc_AISkillPresets_handleModule_unitOverride.sqf
 * Author(s): riksuFIN
 * Description: Handles Zeus module for overriding skill level of invidual units/ group
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
 *	[] call fileName
*/
params ["_dialogValues", "_unit"];
_dialogValues params ["_effected", "_skillLevel"];
//_unit = _unit select 0;

//if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1", _this];};


if (_skillLevel < 1) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] SkillLevelOverride was less than 1, doing nothing";};
};

private _units = _unit;
if (_effected isEqualTo 1) then {
	// Whole group was selected to be effected in module
	_units = units group (_unit select 0);
};

{
	// Update skill level on AI's
	// Has to be called invidually on each unit since each unit could be on different host
	["RAA_zeus_AISkillPreset_set", [_x, _skillLevel], _x] call CBA_fnc_targetEvent;
	
	
} forEach _units;





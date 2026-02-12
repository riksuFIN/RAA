#include "script_component.hpp"
/* File: fnc_AISkillPresets_getSkillsArray.sqf
 * Author(s): riksuFIN
 * Description: Gets array containing skills for side
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Side	<STRING>
 1: 	
 2: 	
 *
 Returns:	Array containing skill settings for side. False if failed	<ARRAY>
 *
 * Example:	_skillsArray = [west] call RAA_zeus_fnc_AISkillPreset_getSkillsArray
 */


params ["_side"];

private _number = -1;
switch (_side) do {
	case (west): {
		_number = RAA_zeus_AISkill_west_level select 0;
	};
	case (east): {
		_number = RAA_zeus_AISkill_east_level select 0;
	};
	case (resistance): {
		_number = RAA_zeus_AISkill_ind_level select 0;
	};
};


private _return = false;
switch (_number) do {
	case (1): {
		_return = RAA_zeus_AISkill_default_1_array;
	};
	
	case (2): {
		_return = RAA_zeus_AISkill_default_2_array;
	};
	
	case (3): {
		_return = RAA_zeus_AISkill_default_3_array;
	};
	
	case (4): {
		_return = RAA_zeus_AISkill_default_4_array;
	};
	
	case (5): {
		_return = RAA_zeus_AISkill_default_5_array;
	};
};


_return




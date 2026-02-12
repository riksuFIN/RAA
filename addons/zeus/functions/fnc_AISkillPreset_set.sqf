#include "script_component.hpp"
/* File: fnc_AISkillPresets_set.sqf
 * Author(s): riksuFIN
 * Description: Sets defined skills for invidual AI unit
 *
 * Local to: Where _unit is local!
 * Parameter(s):
 0:	Unit to affect	<UNIT>
 1: 	Skill level to set <BOOL, default -1 (no change)>		Values: 1-5: skill levels. 0: Use side default. -1:
 *
 Returns: Nothing
 *
 * Examples:	
 		[_this] call RAA_zeus_fnc_AISkillPreset_set
 		["RAA_zeus_AISkillPreset_set", cursorObject, cursorObject] call CBA_fnc_targetEvent;	// Ensure this fnc is called on right machine
 
 */

params ["_unit", ["_overrideSkill", -1]];


// Safety in case this fnc is called on non-AI unit (Whitelist)
if (isPlayer _unit || !(alive _unit) || !(side _unit in [west, east, independent]) || !(_unit isKindOf "CAManBase")) exitWith {
	if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] AiSkillPreset_set.sqf: Exit at whitelist for %1", _unit];};
};


// If _overrideSkill is defined via parameter we manually add it
private _skillsArray = 0;
if (_overrideSkill > -1) then {
	// Skill level is overriden via parameter
	_unit setVariable ["RAA_zeus_skillLevel", _overrideSkill];
} else {
	// Check if skill level is overriden via variable
	_overrideSkill = _unit getVariable ["RAA_zeus_skillLevel", -1];
};

// If invidual unit's skill level is overriden use that
if (_overrideSkill > 0) then {
	// This unit's skill level is overriden via variable, apply than instead
	switch (_overrideSkill) do {
		case (1): {_skillsArray = RAA_zeus_AISkill_default_1_array};
		case (2): {_skillsArray = RAA_zeus_AISkill_default_2_array};
		case (3): {_skillsArray = RAA_zeus_AISkill_default_3_array};
		case (4): {_skillsArray = RAA_zeus_AISkill_default_4_array};
		case (5): {_skillsArray = RAA_zeus_AISkill_default_5_array};
		default {_skillsArray = false};
	};
	
} else {
	
	// This unit is not overriden, Fetch correct skills array for side
	//private _skillsArray = [side _unit] call RAA_zeus_fnc_AISkillPreset_getSkillsArray;
	_skillsArray = [side _unit] call FUNC(AISkillPreset_getSkillsArray);
};


if (_skillsArray isEqualTo false) exitWith {
	if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] No skills Array found for unit %1", _unit];};
};


// Set subskills
_unit setSkill ["aimingAccuracy", _skillsArray select 0];
_unit setSkill ["aimingShake", _skillsArray select 1];
_unit setSkill ["aimingSpeed", _skillsArray select 2];
_unit setSkill ["spotDistance", _skillsArray select 3];
_unit setSkill ["spotTime", _skillsArray select 4];
_unit setSkill ["courage", _skillsArray select 5];
_unit setSkill ["reloadSpeed", _skillsArray select 6];
_unit setSkill ["commanding", _skillsArray select 7];
_unit setSkill ["general", _skillsArray select 8];



private _skillsSettingsArray = [];
switch (side _unit) do {
	case (west): {
		_skillsSettingsArray = RAA_zeus_AISkill_west_level;
	};
	case (east): {
		_skillsSettingsArray = RAA_zeus_AISkill_east_level;
	};
	case (resistance): {
		_skillsSettingsArray = RAA_zeus_AISkill_ind_level;
	};
};


// Lambs AI
private _isCrewMember = [_unit] call EFUNC(common,isCrewMember);
private _crewLambsEnabled = _skillsSettingsArray select 4;
private _setting = (_skillsSettingsArray select 3);
if (_isCrewMember) then {
	_setting = _crewLambsEnabled;
};

_unit setVariable ["lambs_danger_disableAI", !_setting];



// Group leader
if (leader group _unit isEqualTo _unit) then {	// Avoid spamming by only setting group variable by leader
	private _setting = (_skillsSettingsArray select 2);
	if (_isCrewMember) then {
		_setting = _crewLambsEnabled;
	};
	
	group _unit setVariable ["lambs_danger_disableGroupAI", !_setting];
};


if (_skillsSettingsArray select 1) then {
	_unit enableAI "AUTOCOMBAT";
} else {
	_unit disableAI "AUTOCOMBAT";
};




if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] AiSkill applied to %1 with settings: %2", _unit, _skillsSettingsArray];};
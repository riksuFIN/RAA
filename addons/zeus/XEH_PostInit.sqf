#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description:

 * Called from: config.cpp/ XEH_postInit
 * Local to: Client
 * Scheduled
 */

GVAR(testUpdate) = true;



// AI Skill Presets
// Set default settings. Default preset is grabbed from CBA settings in case mission maker has chosen to change it to suit mission
RAA_zeus_AISkill_west_level = [RAA_zeus_AISkill_default_west, true, true, true, GVAR(AISkill_default_crew_west)];	// Form:
RAA_zeus_AISkill_east_level = [RAA_zeus_AISkill_default_east, true, true, true, GVAR(AISkill_default_crew_east)];	// Preset, Auto-combat, LambsGroupAI, LambsUnitAI, enableLambsforVehicles
RAA_zeus_AISkill_ind_level = [RAA_zeus_AISkill_default_ind, true, true, true, GVAR(AISkill_default_crew_ind)];




// Add custom eventHandlers
[QGVAR(AISkillPreset_set), {
//	params ["_unit", "_overrideSkill"];
//	[_unit, _overrideSkill] call FUNC(AISkillPreset_set);
	_this call FUNC(AISkillPreset_set);
}] call CBA_fnc_addEventHandler;





[	{	// Wait 5 seconds after mission start to make sure all scripts and variables have time to init
	//	[] execVM "\r\misc\addons\RAA_zeus\scripts\AISkillPreset_init.sqf";
		call compile preprocessFileLineNumbers QPATHTOF(scripts\AISkillPreset_init.sqf);
	}, 
	[],
	5
] call CBA_fnc_waitAndExecute;


// Init all custom Zeus modules
call compile preprocessFileLineNumbers QPATHTOF(scripts\createZeusModules.sqf);
call compile preprocessFileLineNumbers QPATHTOF(scripts\createZeusModules_animScreen.sqf);

// Init modules that are dependant Zantza's Mission Making Framework, if there is one in the mission
[{!isNil "zafw_endinprogress"}, {
//	[] execVM "\r\misc\addons\RAA_zeus\scripts\createZeusModules_ZAFW.sqf";
	call compile preprocessFileLineNumbers QPATHTOF(scripts\createZeusModules_ZAFW.sqf);
},
[],
15, {}] call CBA_fnc_waitUntilAndExecute;









#include "script_component.hpp"
/* File: fnc_AISkillPresets_handleModule.sqf
 * Author(s): riksuFIN
 * Description: 
 *
 * Called from: Zeus module
 * Local to: 
 * Parameter(s):
 0:		Data from module
 1: 	
 2: 	
 3: 
 4:
 *
 Returns:
 *
 * Example:	[_this] call RAA_zeus_fnc_AISkillPreset_handleModule
 */



//params ["_params"];
params ["_paramsDialog", "_paramsModule"];

_paramsDialog params [
	"_west_preset",
	"_west_autoCombat",
	"_west_lambsGroup",
	"_west_lambsUnit",
	"_west_lambsVehicle",
	"_east_preset",
	"_east_autoCombat",
	"_east_lambsGroup",
	"_east_lambsUnit",
	"_east_lambsVehicle",
	"_ind_preset",
	"_ind_autoCombat",
	"_ind_lambsGroup",
	"_ind_lambsUnit",
	"_ind_lambsVehicle"
];



RAA_zeus_AISkill_west_level = [_west_preset, _west_autoCombat, _west_lambsGroup, _west_lambsUnit, _west_lambsVehicle];
RAA_zeus_AISkill_east_level = [_east_preset, _east_autoCombat, _east_lambsGroup, _east_lambsUnit, _east_lambsVehicle];
RAA_zeus_AISkill_ind_level = [_ind_preset, _ind_autoCombat, _ind_lambsGroup, _ind_lambsUnit, _ind_lambsVehicle];

publicVariable "RAA_zeus_AISkill_west_level";	// Update these on all clients and server as well
publicVariable "RAA_zeus_AISkill_east_level";
publicVariable "RAA_zeus_AISkill_ind_level";


// Loop through all units in mission and set our setting to them
{	// Only set skills for units that make sense
	if (!(isPlayer _x) && alive _x && _x isKindOf "CAManBase" && (side _x != civilian)) then {
		
	//	[_x] call RAA_zeus_fnc_AISkillPreset_set;
	//	[_x] call FUNC(AISkillPreset_set);
		["RAA_zeus_AISkillPreset_set", [_x], _x] call CBA_fnc_targetEvent;
		
	};
} forEach allUnits;

























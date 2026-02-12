#include "script_component.hpp"
/* File: fnc_AISkillPreset_init.sqf
 * Author(s): riksuFIN
 * Description: Inits AI Skill Preset system
 *
 * Called from: XEH_PostInit.sqf
 * Local to: 
 * Parameter(s):
 0:		
 1: 	
 *
 Returns: Nothing
 */

if !(RAA_zeus_AISkill_masterEnabled) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] AISkillPreset_init.sqf exit: masterEnabled setting was disabled";};
};


if (isServer) then {	// Init EH. We don't need to run this on each client
	["CAManBase", "InitPost", {[_this select 0] call RAA_zeus_fnc_AISkillPreset_set;}, true, [], true] call CBA_fnc_addClassEventHandler;
//	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] AISkillPreset_init.sqf: init EH created for server";};
};


	// From now on we do only check for clients
if !(hasInterface) exitWith {};

if !(["RAA_isMotti"] call ace_common_fnc_isModLoaded) exitWith {};
// Skill levels are not set -warnings.  These are only thrown if this is in Motti's internal games.
if (isMultiplayer) then {		// MP
	if (!(isNull getAssignedCuratorLogic player) || (serverCommandAvailable "#kick")) then {
		if ((RAA_zeus_AISkill_default_west isEqualTo 0) && (RAA_zeus_AISkill_default_east isEqualTo 0) && (RAA_zeus_AISkill_default_ind isEqualTo 0)) then {
			// Show prompt to Zeus and Admin
			private _message = "Defaults for AI Skills were not set by mission maker. Zeus must manually define these using module 'Set AI Skill Level'";
			systemChat _message;
			[_message,0,0.5,6,1] spawn bis_fnc_dynamicText;
			
			[	{		// Condition
					!isNull curatorCamera
				}, {	// Code
					hintC "AI Skill levels are not defined!";
					[] call RAA_zeus_fnc_AISkillPreset_createDialog;
				}, [	// Params
				],		// Timeout
				120,
				{		// Timeout code
				}
			] call CBA_fnc_waitUntilAndExecute;
			
		};
	};
} else {		// SP
	if (!isNil "zafw_endinprogress") then {
		if ((RAA_zeus_AISkill_default_west isEqualTo 0) && (RAA_zeus_AISkill_default_east isEqualTo 0) && (RAA_zeus_AISkill_default_ind isEqualTo 0)) then {
			private _message = "Defaults for AI Skill levels are not set. Go to Addon Settings --> 'mission' tab --> 'Motti_Misc AI Skill Presets' to set these.";
			systemChat _message;
			hintC _message;
			[_message,0,0.5,4,1] spawn bis_fnc_dynamicText;
		};
	};
};



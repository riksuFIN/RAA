#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */

// Hard-disabled feature untill feature is finished. When done switch this to CBA settings
GVAR(windAffectWalking) = false;

	// Client-side
if (hasInterface) then {
	
	
	[] execVM QPATHTOF(scripts\facepaint_init.sqf);	// Init facepaint system
//	[] execVM "\r\misc\addons\RAA_misc\scripts\init_chat_commands.sqf";	// Init chat commands
	
	
	
};







	// Server-side
if (isServer) then {
	
	// Fix for zeus' Belt items floating in air
	["zen_common_hideObjectGlobal", {
		params ["_object", "_hide"];
	//	_object hideObjectGlobal _hide;
	//	[_object, _hide] call FUNC(beltSlot_onMountingVehicle);
		[_object, _hide] remoteExec [QFUNC(beltSlot_onMountingVehicle), _object];
		// This is activaed on server, then remoteExec'd to client, who remoteExecs to everyone
		// Ineffecient, but best way I can think of to detect when Zeus goes invisible
		// (Uses ZEN event, which is only activated on server, while beltItems is client-side only)
		
	}] call CBA_fnc_addEventHandler;
	
	
	
	// Spawn water bottles to AI's. 10 seconds delay from spawning to allow everything else do their stuff first
//	["CAManBase", "init", {[_this select 0] call FUNC(handleAIInit);}, true, [], true] call CBA_fnc_addClassEventHandler;
	["CAManBase", "init", {
		[	{
				[_this select 0] call FUNC(handleAIInit);
			}, 
				_this,
			6
		] call CBA_fnc_waitAndExecute;
	}, true, [], true] call CBA_fnc_addClassEventHandler;
	
	
	if (["RAA_isMotti"] call ace_common_fnc_isModLoaded) then {
		if (RAA_misc_zafw_timeOutReminder_enabled && (count allCurators > 0)) then {
			// Init ZAFW timeout reminders
			// Only if framework is found and safestart system is enabled
			[{ (!isNil "zafw_endinprogress") && (!isNil "zafw_safestart_enabled")}, {
				if (zafw_safestart_enabled) then {
					private _allPlayers = [] call CBA_fnc_players;
					
					if (count _allPlayers > 3) then {
						if (RAA_misc_debug) then {diag_log "[RAA_misc] Safestart timeout reminders activated";};
						[false] execVM QPATHTOF(scripts\zafw_timeout_reminder.sqf);
					} else {
						// Less than 4 players in mission. Delay countdown untill enough players are inside mission
						
						if (RAA_misc_debug) then {diag_log "[RAA_misc] Safestart timeout reminders delayed due to low player count";};
						[	{	// Condition
								_allPlayers = call CBA_fnc_players;
								count _allPlayers > 3;
								
							}, {	// Statement
								if (RAA_misc_debug) then {diag_log "[RAA_misc] Safestart timeout reminders activated";};
								[true] execVM QPATHTOF(scripts\zafw_timeout_reminder.sqf);
								
							}, 
							[]	// Params
						] call CBA_fnc_waitUntilAndExecute;
						
					};
				};
			}, 
			[], 
			15, {}] call CBA_fnc_waitUntilAndExecute;
		};
	};
};



// For spawning drinkable/ edible consumeables to AI units, get all possible items from cfg 
GVAR(allConsumeableItems) = [];
{
	GVAR(allConsumeableItems) pushBack configName _x;
} forEach ("getNumber (_x >> 'scope') > 0 && {getNumber (_x >> 'acex_field_rations_thirstQuenched') >= 2 || getNumber (_x >> 'acex_field_rations_hungerSatiated') >= 2}" configClasses (configFile >> "CfgWeapons"));
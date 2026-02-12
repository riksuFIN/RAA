#include "script_component.hpp"
/* File: fnc_damageableItems_onHit.sqf
 * Author(s): riksuFIN
 * Description: Manages damaging inventory items (if enabled via setting) when taking a hit
 *
 * Called from: EventHandles onHit
 * Local to:	Client
 * Parameter(s):
 * 0:	Data from EventHandler
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_misc_fnc_damageableItems_onHit
*/

//params ["_target", "_source", "_damage", "_instigator"];
params ["_target", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

if (!alive _target || !_directHit || {_damage < 0.05}) exitWith {};

// Timeout to avoid spamming this too much
if (time - (_target getVariable [QGVAR(damageableItems_lastHit), 0]) < 2) exitWith {};

// Filter only those selections we're interested in
//[["hitface","hitneck","hithead","hitpelvis","hitabdomen","hitdiaphragm","hitchest","hitbody","hitarms","hithands","hitlegs","incapacitated","hitleftarm","hitrightarm","hitleftleg","hitrightleg"],["face_hub","neck","head","pelvis","spine1","spine2","spine3","body","arms","hands","legs","body","hand_l","hand_r","leg_l","leg_r"],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
switch (_hitPoint) do {
	case ("hitchest"): {
		if (GVAR(damageableItems_chance) > random 100) then {
			// RNG decided we hit something. Roll dice to check if it's weapon or general item
			_target setVariable [QGVAR(damageableItems_lastHit), time];	// This flag will prevent damage happening several times too quickly
		//	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Torso was hit AND dice roll SUCCESS! Items are in danger with dmg %1", _damage];};
			[_target] call FUNC(damageableItems_doDamage);
			
		} else {
			// Items are safe, check for weapon jam
			if (GVAR(damageableItems_chance_weapon) > random 100) then {
				// RNG decided that weapon was hit
				_target setVariable [QGVAR(damageableItems_lastHit), time];	// This flag will prevent damage happening several times too quickly
				if (currentWeapon _target isEqualTo primaryWeapon _target && primaryWeapon _target isNotEqualTo "") then {	// Only primary weapon can be jammed.
					
					if (GVAR(debug)) then {systemChat format ["[RAA_misc] %2's Weapon %1 was hit", primaryWeapon _target, _target]};
					// Do ACE weapon jam if proper ACE module is loaded
					if (["ace_overheating"] call ace_common_fnc_isModLoaded) then {
						[_target, primaryWeapon _target] call ace_overheating_fnc_jamWeapon;
						[parseText "Your <t color='#ff0000'>weapon</t> was hit, causing a jam.", false, 20, 3] call ace_common_fnc_displayText;
					};
				};
			} else {
				if (GVAR(debug)) then {systemChat format ["[RAA_misc] Torso was hit but dice roll failed. No item damage."];};
			};
		};
	};
	case ("hithead"): {
		// Special handling for TFN mod's helmets with secureable chinstrap
		private _chance = GVAR(damageableItems_headgearChance);
		if (headgear _target select [0,3] isEqualTo "TFN" && {headgear _target select [count headgear _target - 4,1] isEqualTo "U"}) then {
			_chance = _chance * 2;
		};
		
		if (_chance > random 100) then {
			// RNG decided we hit something
			_target setVariable [QGVAR(damageableItems_lastHit), time];	// This flag will prevent damage happening several times too quickly
			if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit head AND dice roll SUCCESS!"];};
			[_target, 1] call FUNC(damageableItems_headgear);
			
		} else {
			if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit head but dice roll failed."];};
		};
	};
};

/*
// THESE ARE ONLY FOR "HIT" EVENTHANDLER - REPLACE THESE TWO WITH ONES ABOVE WHEN SWITCHING EH
if (random 100 > GVAR(damageableItems_chance)) then {
	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit torso but dice roll failed. No item damage"];};
} else {
	// RNG decided we hit something
	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit torso AND dice roll SUCCESS! Items are in danger with dmg %1", _damage];};
	[_target] call FUNC(damageableItems_doDamage);
};
*/
/*
// Special handling for TFN mod's helmets with secureable chinstrap
private _chance = GVAR(damageableItems_headgearChance);
if (headgear _target select [0,3] isEqualTo "TFN" && {headgear _target select [count headgear _target - 4,1] isEqualTo "U"}) then {
	_chance = _chance * 2;
};
if (random 100 > _chance) then {
	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit head but dice roll failed"];};
} else {
	// RNG decided we hit something
	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Hit head AND dice roll SUCCESS!"];};
//	player setVariable [QGVAR(damageableItems_lastHit), time];
	[_target, 1] call FUNC(damageableItems_headgear);
};
*/
/*
if (random 100 > GVAR(damageableItems_chance_weapon)) then {

} else {
	// Only primary weapon can be jammed.
	if (currentWeapon _target isEqualTo primaryWeapon _target || primaryWeapon _target isNotEqualTo "") then {
		// RNG decided we hit something
		if (GVAR(debug)) then {systemChat format ["[RAA_misc] %2's Weapon %1 was hit", primaryWeapon _target, _target]};
	//	[_target, currentWeapon _target] remoteExec ["ace_overheating_fnc_jamWeapon", _target];
		[_target, primaryWeapon _target] call ace_overheating_fnc_jamWeapon;
		[parseText "Your <t color='#ff0000'>rifle</t> was hit, causing a jam.", false, 20, 3] call ace_common_fnc_displayText;
		
	};
};
*/


nil


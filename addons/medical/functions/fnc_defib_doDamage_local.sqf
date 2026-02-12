#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: Handle damaging players if they're touching patient that is being defib'd
 *
 * Called from: Defib operator's client
 * Local to: Each client near patient
 * Parameter(s):
 0:	Patient who's being defib'd <OBJECT>
 1:	Medic (who operators defibrillator) <OBJECT>
 2:	
 3:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_defib_doDamage_local
*/
params ["_patient", "_medic"];

if !(hasInterface) exitWith {};

if (_medic isEqualTo player) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib damage: You're medic, no damage";};
};


private _doShock = false;
private _ui = uiNamespace getVariable ["ace_medical_gui_menuDisplay", displayNull];

// Check if this player is viewing patinet's medical menu OR is currently in act of treatment
if (!(isNull _ui) || ace_medical_gui_pendingreopen) then {
	
	// Check if target of action is shocked patient
	if (ace_medical_gui_target isEqualTo _patient) then {
		_doShock = true;
	};
};




if (_doShock) then {
	
	// Randomly make player shout from pain
	if (random 100 > 33) then {
		
		[player, "hit", 1] call ace_medical_feedback_fnc_playInjuredSound;
	};
	
	
	// Decide what kind of damage we do
	if (random 100 > 50) then {
		
		// Stop heart
	//	[player, true] call ace_medical_status_fnc_setCardiacArrestState;		// MUST BE REPLACED; THIS IS INTERNAL FNC
		["ace_medical_FatalVitals", player] call CBA_fnc_localEvent;
		if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib Damage: Shocked, in crdc arrest!";};
	} else {
		
		// Cause major pain
		[player, 0.8] call ace_medical_fnc_adjustPainLevel;
	//	player setVariable ["ace_medical_pain", 1];
		if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib Damage: Shocked, major pain!";};
	};
	
	// Apply burn damage to hands to give feedback where this unit might have taken damage from
	// https://github.com/acemod/ACE3/blob/master/addons/medical/functions/fnc_addDamageToUnit.sqf
	//	private _dmg = random [0.05, 0.1, 0.3];
	//	private _arm = selectRandom ["LeftArm", "RightArm"];
		[player, 0.1, "LeftArm", "burn", _medic] call ace_medical_fnc_addDamageToUnit
	
};

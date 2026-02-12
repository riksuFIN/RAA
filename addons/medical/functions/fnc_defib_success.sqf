#include "script_component.hpp"
/* File: fnc_defib_success.sqf
 * Author(s): riksuFIN
 * Description: Last step of defib sequence
 *
 * Called from: TBA
 * Local to: 
 * Parameter(s):
 0:	Medic (player) <OBJECT>
 1:	Target <OBJECT>
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[player, cursorObject] call RAA_fnc_ACEA_defib_success
*/

params ["_medic", "_patient"];


//_patient setVariable [QEGVAR(medical,CPR_provider), _medic, true];

private _crdArrest = _patient getVariable ["ace_medical_incardiacarrest", false];
if (_crdArrest) then {
	
	// Lets roll dice so its not always boringly certain
	if (random 1 < RAA_ACEA_defibSuccessChance) then {
		// We're currrently in cardiadic arrest, so we leave that state upon using defib
		
	// https://github.com/acemod/ACE3/blob/master/addons/medical_statemachine/Statemachine.hpp
		["ace_medical_CPRSucceeded", _patient, _patient] call CBA_fnc_targetEvent;
		if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib Success Chance: SUCCESS!";};
		
	} else {
		// Dice roll failed, we do not revive patient
		if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib Success Chance: FAILED!";};
	};
	
	
} else {
	// Unit is currently healthy, therefore we damage him
//	["ace_medical_FatalVitals", _patient] call CBA_fnc_localEvent;
	["ace_medical_FatalVitals", _patient, _patient] call CBA_fnc_targetEvent;
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Defib: Unit was healthy, so we stopped heart!";};
};


[_patient, "activity", format ["%1 used Defibrillator", name _medic], []] call ace_medical_treatment_fnc_addToLog;



// Shock everyone who is interracting with patient
private _nearMens = nearestObjects [_patient, ["CAManBase"], 5];

[_patient, _medic] remoteExec ["RAA_fnc_ACEA_defib_doDamage_local", _nearMens];









/*
_patient setVariable ["ace_medical_statemachine_cardiacArrestTimeLeft", nil];
_patient setVariable ["QGVAR(cardiacArrestTimeLastUpdate", nil];
*/




/*
[QGVAR(cprLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;


//[QEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
*/

/*
[_target, "activity", localize "STR_ADV_ACECPR_AED_EXECUTE", [[_caller, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
[_target, "activity_view", localize "STR_ADV_ACECPR_AED_EXECUTE", [[_caller, false, true] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;

*/
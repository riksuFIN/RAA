#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: Checks vitals after shocking patient
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_fnc_ACEA_AED_afterShock
*/

params ["_medic", "_patient", ["_aed", objNull], ["_trials", 0]];

if (_aed isEqualTo objNull || (_aed distance _patient) > 7) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] AED device too far from patient!";};
	if !(isNull _aed) then {
		[_aed, "RAA_AED_speak_connection_lost", 40] call EFUNC(common,3dSound);
		_aed setVariable ["RAA_AED_inUse", false, true];
	};
};


_trials = _trials + 1;

// We try to shock 3 times, after that we give up
if (_trials > 2) exitWith {
	
	_aed setVariable ["RAA_AED_inUse", false, true];
	
	if (_patient getVariable ["ace_medical_heartrate", 0] < 25) then {
		[_aed, "RAA_AED_speak_start_cpr", 40] call EFUNC(common,3dSound);
	} else {
		
		[_aed, "RAA_AED_speak_check_pulse", 40] call EFUNC(common,3dSound);
	};
	
};





if (_patient getVariable ["ace_medical_incardiacarrest", false]) exitWith {
	
	[_medic, _patient, _aed, _trials] call RAA_fnc_ACEA_AED_middle;
	
};

if (_patient getVariable ["ace_medical_heartrate", 0] < 30) then {
	// Patient's vitals are still unstable
	[_aed, "RAA_AED_speak_check_pulse", 40] call EFUNC(common,3dSound);
	
} else {
	// Patient's vitals are stable. Reset AED for next patient
	
	[_aed, "RAA_AED_speak_safe_to_touch", 40] call EFUNC(common,3dSound);
	
	_aed setVariable ["RAA_AED_inUse", false, true];
	
};







//_aed setVariable ["RAA_AED_inUse", false, true];
//ace_medical_heartrate




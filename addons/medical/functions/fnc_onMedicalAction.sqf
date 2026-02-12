#include "script_component.hpp"
/* File: fnc_onMedicalAction.sqf
 * Authors: riksuFIN
 * Description: Checks for custom item used and executes custom function, like handling multi-use medication
 *
 * Called from: EventHandler ace_treatmentSucceded
 * Parameter(s):
 0:
 Returns: NONE
 Example: [_this] call RAA_fnc_ACEA_onMedicalAction
 *
 */



params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];


_this call ace_medical_treatment_fnc_medication;



private _painKillerItems = [
	"RAA_painkiller",
	"RAA_painkiller_4",
	"RAA_painkiller_3",
	"RAA_painkiller_2"
];


if (_usedItem in _painKillerItems) then {
	if (RAA_misc_debug) then {systemChat "[RAA_ACE] Painkiller was used, add new item to inventory";};
	
	switch (_usedItem) do {
		case ("RAA_painkiller"): {
			_caller addItem "RAA_painkiller_4";
		};
		
		case ("RAA_painkiller_4"): {
			_caller addItem "RAA_painkiller_3";
		};
		
		case ("RAA_painkiller_3"): {
			_caller addItem "RAA_painkiller_2";
		};
		
		case ("RAA_painkiller_2"): {
			_caller addItem "RAA_painkiller_1";
		};
		
	};
};







//["ace_treatmentSucceded", {systemChat str _this}] call CBA_fnc_addEventHandler;

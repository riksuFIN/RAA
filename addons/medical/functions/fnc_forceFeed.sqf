#include "script_component.hpp"
/* File: fnc_checkHunger.sqf
 * Authors: riksuFIN
 * Description: 
 *
 * Called from: 
 * Parameter(s):
 0: medic
 1: patient
 2: 
 3: 
 4:
 *
 Returns:
 *
 */
params ["_medic", "_patient"];

// Get patient's hunger and thirst levels
private _thirst = _patient getVariable ["acex_field_rations_thirst", -1];
private _hunger = _patient getVariable ["acex_field_rations_hunger", -1];

private _priorizeFood = _hunger > _thirst;

// Consume item from inventory
private _itemValues = [_medic, _priorizeFood, true, false] call EFUNC(common,consumeItem);

if (_itemValues isEqualTo 0) exitWith {
	systemChat "Force Feeding Failed - You do not have suitable food or drink";
};

// Update patient's thirst and hunger levels
_thirst = (_thirst - (_itemValues param [1, 0])) max 0;
_hunger = (_hunger - (_itemValues param [0, 0])) max 0;
_patient setVariable ["acex_field_rations_thirst", _thirst, true];
_patient setVariable ["acex_field_rations_hunger", _hunger, true];

private _itemName = getText (configFile >> "CfgWeapons" >> (_itemValues select 2) >> "displayName");

if (_priorizeFood) then {
	[parseText format ["%1 was hungry so you gave them <t color='#ff0000'>%2</t>.", name _patient, _itemName], false, 8, 5] call ace_common_fnc_displayText;
} else {
	[parseText format ["%1 was thirsty so you gave them <t color='#ff0000'>%2</t>.", name _patient, _itemName], false, 8, 5] call ace_common_fnc_displayText;
};

[COMPNAME, GVAR(debug), "INFO", format ["Consumed item with values %1, patient's new thirst:%2, hunger:%3", _itemValues, _thirst, _hunger]] call EFUNC(common,debugNew);
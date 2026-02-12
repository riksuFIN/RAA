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

private _thirst = _patient getVariable ["acex_field_rations_thirst", -1];
private _hunger = _patient getVariable ["acex_field_rations_hunger", -1];

private _textThirst = "%1 is not thirsty";
if (_thirst > 50) then {
	_textThirst = "%1 is extremely thirsty";
} else {
	if (_thirst > 20) then {
		_textThirst = "%1 is thirsty";
	};
};

private _textHunger = "%1 is not hungry";
if (_hunger > 50) then {
	_textHunger = "%1 is extremely hungry";
} else {
	if (_hunger > 20) then {
		_textHunger = "%1 is hungry";
	};
};

_textThirst = format [_textThirst, name _patient];
_textHunger = format [_textHunger, name _patient];

hint format ["%1\n\n%2", _textThirst, _textHunger];


/*
//hint format ["Hunger:: %1\n\nThirst: %2", _hunger,_thirst];
private _text = format ["Hunger: %1\nThirst: %2", round _hunger, round _thirst];
//[[_text], 1.75, _medic] call ace_common_fnc_displayTextStructured;
hint _text;
*/
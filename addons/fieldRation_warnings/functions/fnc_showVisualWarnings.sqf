#include "../script_component.hpp"
/* File: fnc_showVisualWarnings.sqf
 * Authors: riksuFIN
 * Description: Shows text hunger/ thirst warning to player.

 *
 * Called from: fnc_mainLoop
 * Parameter(s):
 0: text to show  		STRING
 1: RANDOM CHANCE			NUMBER, 0 - 100	OPTIONAL, default 100
 2: Hunger					Bool				Optional, default true. True for hunger, false for thirst
 3: 
 4:
 *
 Returns:
 *
 Example: ["Starving", 50] call RAA_fieldration_warnings_fnc_showVisualWarnings;
 */


params ["_text",["_random", 100], ["_hunger", true]];


_lastRun = player getVariable "RAA_lastTextTime";
_timeSinceLastRun = CBA_MissionTime - _lastRun;
if (_timeSinceLastRun < RAA_FRW_textCoolDown) exitWith {	// Avoid repeating text too frequently
	if (GVAR(debug)) then {
		systemChat "[RAA_FRW] showText exit: Too early since last run";
	};	
};

private _warningType = 3;
if (_hunger) then {
	_warningType = RAA_FRW_HungerVisualWarningType;
} else {
	_warningType = RAA_FRW_ThirstVisualWarningType;
};



if (_random > (random 100)) then {
	
	switch (_warningType) do {
		case (1): {	// Only text
			[true, _random / 100] call ace_medical_feedback_fnc_effectPain;
		};
		
		case (2): {	// Only visual
			[_text,0,0.9,4,1] spawn bis_fnc_dynamicText;
		};
		
		case (3): {	// Both types are allowed
			if (random 100 > 40) then {
				[_text,0,0.9,4,1] spawn bis_fnc_dynamicText;
			} else {
				[true, _random / 100] call ace_medical_feedback_fnc_effectPain;
			};
		};
	};
	
	player setVariable ["RAA_lastTextTime", CBA_MissionTime];
} else {
	if (GVAR(debug)) then {systemChat format ["[RAA_FRW] fnc_showText at %1 -per cent chance, FAIL",_random]};
};





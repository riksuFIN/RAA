#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
// https://community.bistudio.com/wiki/DIK_KeyCodes

if !(hasInterface) exitWith {};



[["RAA", "Whistling"],		// ModName
	QGVAR(Whistling_1), 
	"Whistling: Attention",	// Pretty name
	{	// Fnc to call
		if ([ACE_player] call ace_common_fnc_isAwake) then {
			[ACE_player, "RAA_misc_whistling_1", 150] call EFUNC(common,3dSound);
		};
	}, ""	// Up code (on button release)
] call CBA_fnc_addKeybind;

[["RAA", "Whistling"],		// ModName
	QGVAR(Whistling_2), 
	"Whistling: Admire",	// Pretty name
	{	// Fnc to call
		if ([ACE_player] call ace_common_fnc_isAwake) then {
			[ACE_player, "RAA_misc_whistling_2", 150] call EFUNC(common,3dSound);
		};
	}, ""	// Up code (on button release)
] call CBA_fnc_addKeybind;

[["RAA", "Whistling"],		// ModName
	QGVAR(Whistling_3), 
	"Whistling: Bird",	// Pretty name
	{	// Fnc to call
		if ([ACE_player] call ace_common_fnc_isAwake) then {
			[ACE_player, selectRandom ['RAA_misc_whistling_3', 'RAA_misc_whistling_4'], 150] call EFUNC(common,3dSound);
		};
	}, ""	// Up code (on button release)
] call CBA_fnc_addKeybind;

[["RAA", "Whistling"],		// ModName
	QGVAR(Whistling_4), 
	"Whistling: Short",	// Pretty name
	{	// Fnc to call
		if ([ACE_player] call ace_common_fnc_isAwake) then {
			[ACE_player, "RAA_misc_whistling_5", 150] call EFUNC(common,3dSound);
		};
	}, ""	// Up code (on button release)
] call CBA_fnc_addKeybind;

[["RAA", "Whistling"],		// ModName
	QGVAR(Whistling_5), 
	"Whistling: Long",	// Pretty name
	{	// Fnc to call
		if ([ACE_player] call ace_common_fnc_isAwake) then {
			[ACE_player, "RAA_misc_whistling_6", 150] call EFUNC(common,3dSound);
		};
	}, ""	// Up code (on button release)
] call CBA_fnc_addKeybind;



/*
["ACE3 Common", QGVAR(InteractKey), (localize LSTRING(InteractKey)),
{
    // Statement
    [0] call FUNC(keyDown)
},{[0,false] call FUNC(keyUp)},
[219, [false, false, false]], false] call CBA_fnc_addKeybind;  //Left Windows Key
*/
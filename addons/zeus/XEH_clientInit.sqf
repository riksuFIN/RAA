#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
// https://community.bistudio.com/wiki/DIK_KeyCodes

if !(hasInterface) exitWith {};





["RAA",		// ModName
	QGVAR(teleport_key), 
	"Zeus: Teleport Selected Object(s)",	// Pretty name
	{	// Fnc to call
		//	Find selected object. Hovered object has priority, otherwise selected ones are used
		private _objects = [curatorMouseOver param [1, []]];
		if (_objects select 0 isEqualTo []) then {
			if (RAA_zeus_debug) then {systemChat "[RAA_zeus] Using selected objects";};
			_objects = curatorSelected param [0, []];
		};
		
		if (count _objects > 0) then {
			[_objects] call FUNC(teleportVehicle)
		} else {
			
			if (RAA_zeus_debug) then {systemChat "[RAA_zeus] Nothing to teleport";};
		};
		
		
	}, 
	"", 
	[
		DIK_V, 
		[true, false, false]
	]
] call CBA_fnc_addKeybind;


/*
["ACE3 Common", QGVAR(InteractKey), (localize LSTRING(InteractKey)),
{
    // Statement
    [0] call FUNC(keyDown)
},{[0,false] call FUNC(keyUp)},
[219, [false, false, false]], false] call CBA_fnc_addKeybind;  //Left Windows Key
*/
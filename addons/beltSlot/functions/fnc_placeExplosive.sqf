#include "script_component.hpp"
/* File: fnc_placeExplosive.sqf
 * Author(s): riksuFIN
 * Description: Intermediate function for handling explosives placement from belt. Actual placement is, however, handled by regular ACE's functions
 *	
 * Called from: ACE action menu
 * Local to:	Client
 * Parameter(s):
 * 0:	Vehicle <OBJECT>
 * 1:	Player <OBJECT>
 * 2:	Classname of explosive to place <STRING>
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_beltSlot_fnc_placeExplosive
*/

params ["_vehicle", "_unit", "_magClassname"];

// Add explosive to inventory, preferring backpack, to be able to use ACE's own function for this
private _container = switch (true) do {
	case (!isNull backpackContainer _unit): {backpackContainer _unit};
	case (!isNull vestContainer _unit): {backpackContainer _unit};
	case (!isNull uniformContainer _unit): {backpackContainer _unit};
	default {objNull};
};

if (isNull _container) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] No container found for item";};
};

_container addItemCargoGlobal [_magClassname, 1];

[_magClassname, _unit] call FUNC(beltSlot_deleteFromBelt);

_this call ACE_Explosives_fnc_SetupExplosive;

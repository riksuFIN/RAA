#include "script_component.hpp"
/* File: fnc_defib_canUse.sqf
 * Author(s): riksuFIN
 * Description: Checks if player is able to use defibrillator
 *
 * Called from: ACE_medical_actions.hpp
 * Local to:	Client
 * Parameter(s):
 * 0:	Unit <OBJECT, default player>
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params [["_unit", ace_player]];

private _return = false;

if ("RAA_defibrillator" in (items _unit)) exitWith {
	true
};


if (["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
	_return = ["RAA_defibrillator", _unit] call EFUNC(beltSlot,beltSlot_hasItem);
};


_return


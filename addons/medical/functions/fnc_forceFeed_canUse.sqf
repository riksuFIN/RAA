#include "script_component.hpp"
/* File: fnc_defib_canUse.sqf
 * Author(s): riksuFIN
 * Description: Checks if player has something to drink in order to forceDrink/ forceFeed patient
 *
 * Called from: ACE_medical_actions.hpp
 * Local to:	Client
 * Parameter(s):
 * 0:	target <OBJECT, default player>
 *
 Returns: canForceDrink <BOOL>
 *
 * Example:	
 *	[] call fileName
*/
params [["_unit", ace_player]];

// Make sure FieldRations is enabled
if !(ACEX_field_rations_enabled) exitWith {false};

private _itemsPlayer = +(_unit call ace_common_fnc_uniqueItems);		// Get all items in _unit's inventory
if (["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
	_itemsPlayer append ([_unit] call EFUNC(beltSlot,beltSlot_getItems));
};

// Search through all inventory items to check if there's anything drinkable.
private _cfgWeapons = configFile >> "CfgWeapons";
if (_itemsPlayer findIf {getNumber (_cfgWeapons >> _x >> "acex_field_rations_thirstQuenched") > 0} >= 0) exitWith {true};


false
#include "script_component.hpp"
/* File:	fnc_consumeItem.sqf
 * Author: 	riksuFIN
 * Description:	Finds first food/ water item from unit's inventory and 'consumes' it
 *						This does NOT actually change thirst/ hunger values, only deletes item
 						and returns value consuming that item effects to hunger/ thirst
 * Called from:	fnc_skipTimeWithHunger_local.sqf
 * Local to: 	Client
 * Parameter(s):
 0:	UNIT		<OBJECT>
 1:	 TRUE for FOOD, FALSE for WATER	<BOOL>
 2:	
 3:	
 4:	
 Returns:	Amount of water/ food replenished	<NUMBER>
 				0 if no suitable item found
 *	
 * Example:
	[player, true] call RAA_zeus_fnc_consumeItem;
 */

params ["_unit", "_food"];


private _itemsPlayer = [_unit] call ace_common_fnc_uniqueItems;		// Get all items in _unit's inventory

private _cfgWeapons = configFile >> "CfgWeapons";


private _configToSearch = "";
if (_food) then {		// Select food or water config
	_configToSearch = "acex_field_rations_hungerSatiated";
} else {
	_configToSearch = "acex_field_rations_thirstQuenched";
};


// Crwal through _unit's items and return first drinkable/ eatable item
/*
private _resultIndex = _itemsPlayer findIf {
	getNumber (_cfgWeapons >> _x >> _configToSearch) > 0
};

if (_resultIndex == -1) exitWith {	// Suitable item was not found, exit
	0
};
*/



// Find best consumeable item
private _itemToUse = [_itemsPlayer, {getNumber (configFile >> "CfgWeapons" >> _x >> "acex_field_rations_thirstQuenched")}] call CBA_fnc_selectBest;

if (getNumber (_cfgWeapons >> _itemToUse >> _configToSearch) <= 2) exitWith {	// No consumeable item was found. Ignores items under 2 to avoid consuming drugs
	
	0
};


//private _itemToUse = _itemsPlayer select _resultIndex;	// This is item we want to use


private _replacementItem = getText (_cfgWeapons >> _itemToUse >> "acex_field_rations_replacementItem");
private _itemToUseValue = getNumber (_cfgWeapons >> _itemToUse >> _configToSearch);
if (_food) then {	// Adjust numbers with modifier in CBA settings
	_itemToUseValue = acex_field_rations_hungerSatiated * _itemToUseValue;
} else {
	_itemToUseValue = acex_field_rations_thirstQuenched * _itemToUseValue;
};



if (RAA_misc_debug) then {systemChat format ["[RAA_Zeus] ConsumeItem: Consumed %1 with value %2", _itemToUse, _itemToUseValue];};


_unit removeItem _itemToUse;

if (_replacementItem != "") then {
	 [_unit, _replacementItem] call ace_common_fnc_addToInventory;
};





_itemToUseValue
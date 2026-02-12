#include "script_component.hpp"
/* File:	fnc_consumeItem.sqf
 * Author: 	riksuFIN
 * Description:	Finds best food/ water item from unit's inventory and 'consumes' it
 *						This does NOT actually change thirst/ hunger values, only deletes item
 						and returns value consuming that item effects to hunger/ thirst
 * Local to: 	Client
 * Parameter(s):
 0:	UNIT		<OBJECT>
 1:	TRUE for priorize FOOD, FALSE for WATER <BOOL>		Which kind of item is searched for.
 2:	Alt. Return values <BOOL, default false>		If true returns . Using this makes this fnc return ARRAY instead of NUMBER!
 3:	Remove item from inventory <BOOL, default true>
 4:	Force removal of item <BOOL, default true>		If true will remove item even if replacement is not found. Only suitable for consumeables where empty bottle should be kept
 Returns: IF PARAM #2 is FALSE:		Returns 0 if suitable item not found!
 	0: Amount of water/ food replenished	<NUMBER>
				
	IF PARAM #2 is TRUE:			Returns 0 if suitable item not found!
	0: Item's Food value
	1: Item's Water value
	2: Item's Classname
 *	
 * Example:
	[player, true] call RAA_common_fnc_consumeItem;
 */

params [["_unit", ACE_player], ["_food", false], ["_returnBoth", false], ["_removeItem", true], ["_removeItemForced", true]];


private _itemsPlayer = [_unit] call ace_common_fnc_uniqueItems;		// Get all items in _unit's inventory

private _cfgWeapons = configFile >> "CfgWeapons";

private _configToSearch = (["acex_field_rations_thirstQuenched", "acex_field_rations_hungerSatiated"] select _food);

// Find best consumeable item
private _itemToUse = [_itemsPlayer, {getNumber (configFile >> "CfgWeapons" >> _x >> _configToSearch)}] call CBA_fnc_selectBest;

if (getNumber (_cfgWeapons >> _itemToUse >> _configToSearch) <= 2) exitWith {	// Check if result is valid consumeable. CBA_selectBest returns random item if nothing suitable found
	0
};

private _replacementItem = getText (_cfgWeapons >> _itemToUse >> "acex_field_rations_replacementItem");
private _foodValue = getNumber (_cfgWeapons >> _itemToUse >> "acex_field_rations_hungerSatiated");
private _waterValue = getNumber (_cfgWeapons >> _itemToUse >> "acex_field_rations_thirstQuenched");
// Adjust numbers with modifier in CBA settings
_foodValue = acex_field_rations_hungerSatiated * _foodValue;
_waterValue = acex_field_rations_thirstQuenched * _waterValue;




if (RAA_misc_debug) then {systemChat format ["[RAA_Zeus] ConsumeItem: Consumed %1 with value %2 (hunger) and %3 (thirst)", _itemToUse, _foodValue, _waterValue];};

if (_removeItem) then {
	_unit removeItem _itemToUse;
	
	if (_replacementItem != "" && _removeItemForced) then {
		 [_unit, _replacementItem] call ace_common_fnc_addToInventory;
	};
};


private _return = 0;
if (_returnBoth) then {
	_return = [_foodValue, _waterValue, _itemToUse]
} else {
	_return = [_waterValue, _foodValue] select _food
};

_return
#include "script_component.hpp"
/* File: fnc_getConsumeableItem.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: Unused?
 * Local to:	
 * Parameter(s):
 * 0:	Unit whose inventory to search <OBJECT, default ACE_player>
 * 1:	false for drinkables, true for consumeables <BOOL, default false>
 * 2: Search for items from belt as well <BOOL, default false>
 *
 Returns: [itemToUseValue, itemToUse] if item found <ARRAY>
 *
 * Example:	
 *	[cusorObject, false] call RAA_ACEA_fnc_getConsumeableItem
*/
//		NOT DECLARED IN PREP!!!!!!!!


params [["_unit", ACE_player], ["_searchForFood", false], ["_searchBelt", false]];

if (ACEX_field_rations_enabled) exitWith {[-1,""]};

private _itemsPlayer = [_unit] call ace_common_fnc_uniqueItems;		// Get all items in _unit's inventory
if (_searchBelt && ["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
	_itemsPlayer append (["RAA_defibrillator", _unit] call EFUNC(beltSlot,beltSlot_getItems));
};

private _variableToGet = "";
if (_searchForFood) then {
	_variableToGet = "acex_field_rations_hungerSatiated";
} else {
	_variableToGet = "acex_field_rations_thirstQuenched";
};

private _cfgWeapons = configFile >> "CfgWeapons";

// Find best consumeable item
private _itemToUse = [_itemsPlayer, {getNumber (_cfgWeapons >> _x >> _variableToGet)}] call CBA_fnc_selectBest;

private _itemToUseValue = getNumber (_cfgWeapons >> _itemToUse >> _variableToGet);



[_itemToUseValue, _itemToUse]
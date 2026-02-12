#include "script_component.hpp"
/* File: fnc_arsenal_overview_getInventoryItems.sqf
 * Author(s): riksuFIN
 * Description: Gets and sorts array of items in unit's inventory for Arsenal Overview feature
 *
 * Called from: fnc_arsenal_overview_update.sqf
 * Local to:	Client
 * Parameter(s): NONE
 1: Unit whose inventory we're looking at. 	<OBJECT, default ace_arsenal_center>
 
 Returns: Sorted ARRAY. MUST be format: ["Item1Classname", 1, "Item2Classname", 5]		Where numbers after each classname corresponds to previous item's count
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_arsenal_overview_getInventoryItems
*/
params [["_unit", ace_arsenal_center]];


private _weapons = [];
private _magazines = [];
private _items = [];
private _mines = [];
private _medical = [];
private _cfgWeapons = configFile >> "cfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";
// Get items on belt if we have beltSlot .pbo loaded
/*		DISABLED since this feature, for some weird reason, throws error every time arsenalOverview is refreshed while having one or none items on belt
private _beltItems = [];
if (["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
	_beltItems = player call EFUNC(beltSlot,beltSlot_getItems);
};
*/
// Sort items to basic categories
private _itemType = "";
{
	_itemType = (_x call BIS_fnc_itemType) param [0, ""];
	switch (_itemType) do {
		case ("Weapon"): {_weapons pushBack _x};
		case ("Magazine"): {
			if (getNumber (_cfgMagazines >> _x >> "ACE_isMedicalItem") isEqualTo 1) then {
				_medical pushBack _x;
			} else {
				_magazines pushBack _x;
			};
		};
		case ("Mine"): {_mines pushBack _x};
		case ("Item"): {
			if (getNumber (_cfgWeapons >> _x >> "ACE_isMedicalItem") isEqualTo 1) then {
				_medical pushBack _x;
			} else {
				_items pushBack _x;
			};
		};
			
			/*if (_x in RAA_common_allMedicalItems) then {_medical pushBack _x} else {
				_items pushBack _x
			};*/
		default {
			
			_items pushBack _x;
		};
	};
	
} forEach (itemsWithMagazines _unit + weapons _unit);


// Put together final array
private _inventory = [];		// Weapons
_inventory append _weapons;
_inventory pushBack "  ";		// Mags
_inventory append _magazines;
if (count _mines > 0) then {	// Mines/ explosives
	_inventory pushBack "   ";
	_inventory append _mines;
};
_inventory pushBack "    ";		// Medical
_inventory append _medical;

_inventory pushBack "     ";		// Misc items
_inventory append _items;


// Count how many of each item are in inventory
// This propably should be at very bottom of this fnc, since it modifies array with count of items
_inventory = _inventory call CBA_fnc_getArrayElements;



if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1 items, %2", count _inventory, _unit];};


_inventory

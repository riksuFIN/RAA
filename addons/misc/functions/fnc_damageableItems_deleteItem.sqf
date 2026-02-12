#include "script_component.hpp"
/* File: fnc_damageableItems_doDamage.sqf
 * Author(s): riksuFIN
 * Description: Replace given item with another item from either belt or inventory, whereever it is
 *
 * Called from: fnc_damageableItems_onHit
 * Local to:	Client
 * Parameter(s):
 * 0:	Unit <OBJECT, default player>
 * 1:	Item classname to delete <STRING>1
 * 2:	Item classname to replace with <STRING, default "">
 * 3:	Remaining ammo count replacementItem should be spawned with, (if its magazine) <NUMBER, default -1>
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_misc_fnc_damageableItems_deleteItem
*/

params [["_unit", player], "_itemToDelete", ["_replacementItem", ""], ["_remainingAmmoCount", -1], ["_ammoCountFull", -1]];


// Find out if beltSlot system is enabled, as it requires special handling
private _beltSlotEnabled = !(isNil "RAA_misc_beltSlot_autoMoveBottlesToBelt");


// First check if item is on belt
private _done = false;
if (_beltSlotEnabled) then {
	if ([_itemToDelete, _unit] call FUNC(beltSlot_hasItem)) then {
		// Yeah, item found on belt
		[_itemToDelete, _unit] call FUNC(beltSlot_deleteFromBelt);
		
		// Add replacement to belt
		// NOTE: Since belt does not support half-empty mags (yet) in case of those we will
		// spawn them in regular inventory if possible, and drop on ground if they dont fit
		if (_remainingAmmoCount < 0) then {
			["", _unit, _replacementItem, true] call FUNC(beltSlot_doMoveToBelt);
		} else {
			[_unit, _replacementItem, _remainingAmmoCount, true] call CBA_fnc_addMagazine;
		};
		
		_done = true;
	};
};


// If item wasnt on belt we delete it from inventory
if !(_done) then {
	
	
	
	if (_remainingAmmoCount >= 0) then {
		[_unit, _itemToDelete, _ammoCountFull] call CBA_fnc_removeMagazine;
		// Spawn half-empty mag
		[_unit, _replacementItem, _remainingAmmoCount] call CBA_fnc_addMagazine;
		
	} else {
		[_unit, _itemToDelete] call CBA_fnc_removeItem;
		// Spawn items
		[_unit, _replacementItem] call CBA_fnc_addItem;
	};
	
};





























#include "script_component.hpp"
/* File:	fnc_handleItemConsumptionEffects.sqf
 * Author: 	riksuFIN
 * Description:	Check if consuming item should result to some effect and if so, execute fnc responsible for that
 *
 * Called from:	EventHandler 
 * Local to: 		Client
 * Parameter(s):
 0:	player
 1:	Item consumed
 2:	Replacement Item
 3:	Amount of thirst reduced
 4:	Amount of hunger reduced
 Returns:		
 * 
 * Example:
	
 */

(_this select 0) params ["_unit", "_consumeItem", "_replacementItem", "_thirstQuenched", "_hungerSatiated"];



// ADJUSTABLE PARAMETERS
private _itemsDrunk = [
	"RAA_Can_beer",
	"RAA_bottle_whiskey",
	"RAA_bottle_whiskey_75",
	"RAA_bottle_whiskey_50",
	"RAA_bottle_whiskey_25"
];

private _itemsDrug = [
	"UMI_Cocaine_Brick",
	"UMI_Cocaine_Brick_4",
	"UMI_Cocaine_Brick_3",
	"UMI_Cocaine_Brick_2",
	"UMI_Cocaine_Brick_1",
	"UMI_Coke_Pile_01",
	"UMI_Coke_Pile_01_4",
	"UMI_Coke_Pile_01_3",
	"UMI_Coke_Pile_01_2",
	"UMI_Coke_Pile_01_1"
];

private _itemsGenericAlcohol = [
	"RAA_bottle_genericAlcohol",
	"RAA_bottle_genericAlcohol_23",
	"RAA_bottle_genericAlcohol_13",
	"RAA_bottle_genericAlcohol_water"
];


private _itemsDirtyWater = [
	"RAA_waterBottle_dirty",
	"RAA_waterBottle_dirty_half"
];






// END OF ADJUSTABLE STUFF



if (_consumeItem in _itemsDrunk) exitWith {
	
	[	{	// Code
			[_unit, 300, true] call FUNC(effect_drunk);
		}, [	// Params
			_unit
		], 
		random [7, 9, 15]	// Delay
	] call CBA_fnc_waitAndExecute;
	
	if (RAA_misc_debug) then {systemChat format ["Calling effect for item %1", _consumeItem];};
};

if (_consumeItem in _itemsDrug ) exitWith {
	
	[	{	// Code
			[_unit, 60] call FUNC(effect_drug);
		}, [	// Params
			_unit
		], 
		random [6, 9, 15]	// Delay
	] call CBA_fnc_waitAndExecute;
	
	if (RAA_misc_debug) then {systemChat format ["Calling effect for item %1", _consumeItem];};
};


if (_consumeItem in _itemsGenericAlcohol ) exitWith {
	
	[_consumeItem] call FUNC(effect_genericAlcohol);
	
	if (RAA_misc_debug) then {systemChat format ["Calling effect for item %1", _consumeItem];};
};


/*
if (_consumeItem isEqualTo "RAA_Can_ES") then {
	
	
};
*/


if (_consumeItem in _itemsDirtyWater ) exitWith {
	
	[_consumeItem] call FUNC(effect_dirtyWater);
	
	if (RAA_misc_debug) then {systemChat format ["Calling effect for item %1", _consumeItem];};
};





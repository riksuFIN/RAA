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

private _itemsDrug = [
	"UMI_Cocaine_Brick",
	"UMI_Coke_Pile_01",
	"UMI_Coke_Pile_01_4",
	"UMI_Coke_Pile_01_3",
	"UMI_Coke_Pile_01_2",
	"UMI_Coke_Pile_01_1"
];





// END OF ADJUSTABLE STUFF




if (_consumeItem in _itemsDrug ) exitWith {
	
	[	{	// Code
			[_unit, 60] call EFUNC(ACEX,effect_drug);
		}, [	// Params
			_unit
		], 
		random [6, 9, 15]	// Delay
	] call CBA_fnc_waitAndExecute;
	
	if (RAA_misc_debug) then {systemChat format ["Calling effect for item %1", _consumeItem];};
};





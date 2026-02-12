#include "script_component.hpp"
/* File: fnc_handleDialog_zafw_addSupplies.sqf
 * Author(s): Zantza, riksuFIN
 * Description: Handles Zeus module dialog for adding supplies to object.
 					Requires Zantza's Mission Making Framework
 *
 * Called from: Zeus Dialog
 * Local to: 	Client
 * Parameter(s):
 0:	Dialog Params <ARRAY>
 	- 0: Group leader <OBJECT>							Leader of group whose supplies should box contain
	- 1: Clear Box first <BOOL, default true>		Empty box from pre-existing items first or not
	- 2: Water Type <INT, default 1>					In what form water is spawned;  0: No water, 1: as canteens, 2: as water source to box, 2: both source and canteens
	- 3: Amount of water per player <NUMBER, default 3>	Amount in litres how much water is provided, multiplied by number of players in group
	
 1:	Box to fill with supplies <OBJECT>		Must have inventory!
 
 *
 Returns: Nothing
 *
 * Example:	[[leader group_alpha, true, 1, 3], [supplyBox1]] call RAA_zeus_fnc_handleDialog_zafw_addSupplies;
*/

if (isNil "zafw_endinprogress") exitWith {
	systemChat "ZA Framework is required for this function!"
};

params ["_paramsDialog", "_paramsModule"];
_paramsModule params ["_object"];
_paramsDialog params ["_groupLead", ["_clearStorage", true], ["_waterType", 1], ["_waterPerPlayer", 3], ["_expandInventory", true]];


// Clear inventory
if (_clearStorage) then {
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearBackpackCargoGlobal _object;
	clearItemCargoGlobal _object;
};

zafw_resupply_client = _groupLead;
zafw_resupply_supplycrate = _object;
publicVariable "zafw_resupply_client";
publicVariable "zafw_resupply_supplycrate";

private _groupsize = count units group zafw_resupply_client;
private _bloodamount = round (_groupsize * 0.6); // 0.6 bags of saline per player in group
private _splintamount = round (_groupsize * 0.35);
if (_bloodamount < 3) then {
	_bloodamount = 3; // minimum 3 blood
};
if (_splintamount < 2) then {
	_splintamount = 2; // minimum 2 splint
};

zafw_resupply_supplycrate addItemCargoGlobal ["ACE_epinephrine", 8];
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_morphine", 10];
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_fieldDressing", 12];
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_salineIV", _bloodamount]; // Base set of medical supplies
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_salineIV_500", (_bloodamount/2)+1];
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_salineIV_250", (_bloodamount/2)];
zafw_resupply_supplycrate addItemCargoGlobal ["ACE_splint", _splintamount];

if (zafw_fieldrations_active) then {
	
	// Add water to object
	switch (_waterType) do {
		case (0): {	// Canteens
			zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Canteen", round (_groupsize * _waterPerPlayer)];
		};
		case (1): {	// Water source
			[zafw_resupply_supplycrate, round (_groupsize * _waterPerPlayer)] call acex_field_rations_fnc_setRemainingWater;
		};
		case (2): {	// Both
			zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Canteen", round (_groupsize * _waterPerPlayer)];
			[zafw_resupply_supplycrate, round (_groupsize * _waterPerPlayer)] call acex_field_rations_fnc_setRemainingWater;
		};
	};
	
	/*
	if (_waterType) then {
		[zafw_resupply_supplycrate, round (_groupsize * _waterPerPlayer)] call acex_field_rations_fnc_setRemainingWater;
	};
	zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Canteen", round (_groupsize * _waterPerPlayer)];	// Added water as item in case given object does not support water
	*/
	if (random 100 > 88) then {
		zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Can_Franta", 0.6*(round random _groupsize)];
		zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Can_RedGull", 0.6*(round random _groupsize)];
		zafw_resupply_supplycrate addItemCargoGlobal ["ACE_Can_Spirit", 0.6*(round random _groupsize)];
		if (random 100 > 50) then {
			zafw_resupply_supplycrate addItemCargoGlobal ["RAA_Can_ES", 0.6*(round random _groupsize)];
			zafw_resupply_supplycrate addItemCargoGlobal ["RAA_sodaBottle", 0.4*(round random _groupsize)];
			zafw_resupply_supplycrate addItemCargoGlobal ["RAA_tinCan_peaSoup", 0.7*(round random _groupsize)];
		};
	};
};



if (isMultiplayer) then {
	remoteExec ["zafw_fnc_resupply_client", group zafw_resupply_client];
} else {
	call zafw_fnc_resupply_client;
};



if (_expandInventory) then {
	
	[	{
			[str COMPONENT, GVAR(debug), "INFO", format ["params: %1", _this]] call EFUNC(common,debugNew);
			if (GVAR(debug)) then {systemChat str _this;};
			if (load _this > 1) then {
				private _load = load _this;
				
				// Increase inventory size and a bit extra. Server Execution.
				[_this, (loadAbs _this + 100)] remoteExec ["setMaxLoad", 2];
				
			};
		}, 
			zafw_resupply_supplycrate
		,
		5
	] call CBA_fnc_waitAndExecute;
	
};
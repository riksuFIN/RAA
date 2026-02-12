#include "script_component.hpp"
/* File: fnc_createDialog_zafw_addSupplies.sqf
 * Author(s): Zantza, riksuFIN
 * Description: Create module dialog for adding supplies to object.
 					Requires Zantzan's Mission Making Framework
 *
 * Called from: Zeus module
 * Local to: 	Client
 * Parameter(s):
 0:	Object which to fill supplies to <OBJECT>
 *
 Returns: Nothing
 *
 * Example:	[_this] call RAA_zeus_fnc_zafw_createDialog_addSupplies;
*/

params ["_object"];

if (isNil "zafw_endinprogress") exitWith {
	hintC "ZA Framework is required for this function!"
};



if (maxLoad _object < 50) exitWith {
	["MODULE MUST BE PLACED ON OBJECT WITH INVENTORY STORAGE"] call zen_common_fnc_showMessage;
};


// Get human players
private _players = call BIS_fnc_listPlayers;
private _arrayGroups = [];
private _arrayGroupsPretty = [];
{
	if (alive _x && leader group _x == _x) then {
		_arrayGroups pushBack _x;
		
		_arrayGroupsPretty pushBack format ["%1 (%2)", group _x, name _x ];
		
	};
} forEach _players;

if (_arrayGroups isEqualTo []) exitWith {
	systemChat "[RAA_Zeus] ERROR: No player groups detected";
};


["Select group to add supplies for",
	[ // CONTENT
		["LIST", // Type  
		["Group for which supplies are for", "Amount and type of supplies will depend on weapons and equipment of selected group."], // Name  
			[_arrayGroups,
			_arrayGroupsPretty,
			0,
			5],
			false	// Force default
		],
		
		
		["TOOLBOX:YESNO", // Type  
		"Clear storage first", // Name  
			true,	// Default value
			false	// Force default
		],
		/*
		["TOOLBOX:YESNO", // Type  
		["Add water source to object", "Adds water source of 20 litres to object from which players can drink or fill their bottles.\nNOTE: Adding this likely makes crate much harder to move through ACE menu"], // Name  
			true,	// Default value
			false	// Force default
		]
		*/
		["TOOLBOX", // Type  
		["Add water as..", ""], // Name  
			[	0,		// Default
				2,		// Rows
				2,		// Columns
				[		// Option names
					"Water Canteens",
					["Water source", "NOTE: Interaction for Water Source might overlap with object's general Interaction Point, making Water Source hard to reach."],
					"Both",
					"None"
				]
			],
			false	// Force default
		],
		
		["SLIDER", // Type  
		"Litres of water per player in group", // Name  
			[0.1, // Min value  
			5,  // Max value  
			1.3, // Default value  
			1],	// Number of decimals
			false	// Force default
		],
		
		["TOOLBOX:YESNO", // Type  
		["Expand Inventory Size", "Increases size of object's inventory to make everything fit.\n\nAll items will spawn regardless of this setting, but expanding inventory size will make items easier for players to handle."], // Name  
			true,	// Default value
			false	// Force default
		]
		
	], { // ON CONFIRM CODE
		
		
		["Supplies will now be filled"] call zen_common_fnc_showMessage;
		
	//	_this call RAA_zeus_fnc_handleDialog_zafw_addSupplies;
		_this call FUNC(handleDialog_zafw_addSupplies);
		
		/*
		params ["_paramsDialog", "_paramsModule"];
		_paramsModule params ["_object"];
		_paramsDialog params ["_groupLead", "_clearStorage", "_waterType", "_waterPerPlayer"];
		
		
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
		
		*/
		
	},{	// On cancel code
	},[	// Arguments
	_object
	]
] call zen_dialog_fnc_create;
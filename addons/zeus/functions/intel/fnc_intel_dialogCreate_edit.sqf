/* File: fnc_intel_dialogCreate_edit.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Object containing intel values <OBJECT>
 1: 	
 2: 	
 3: 
 4:
 *
 Returns:
 *
 * Example:	[] call RAA_zeus_fnc_intel_dialogCreate_edit
*/


// If module is placed on top of existing object check that object's eligibility
private _exit = false;
if !(isNull _object) then {
	if ((count getObjectTextures _object == 0) || (_object isKindOf "Man")) then {
		_exit = true;
	};
};

if (_exit) exitWith {
	["Unsupported object"] call zen_common_fnc_showMessage;
};


/*	if (
	!(isNull _object) ||
	(count getObjectTextures _object == 0) || (_object isKindOf "Man")
	
	) exitWith {
	["Unsupported object"] call zen_common_fnc_showMessage;
};
*/	

private _dialog1 = [];
// First dialog changes based on if module is placed on existing object or not
	// Module was placed on existing object, use that. Let user pick correct screen



// DIALOG 3: Required player
private _allPlayers = call BIS_fnc_listPlayers;
private _allPlayersPretty = ["ANYONE"];
{
	
	_allPlayersPretty pushBack (format ["%1 (%2)", name _x, roleDescription _x]);
	
} forEach _allPlayers;

_allPlayers = ["ANYONE"] + _allPlayers;



["EDIT Electronic Intel",
	[ // CONTENT
		
		["TOOLBOX",
		["1. Select object face to use", "Often first value is desired one"],
			[
				0,		// Default value
				2,		// Number of rows
				2,		// Number of columns
				getArray (configFile >> "CfgVehicles" >> typeOf _object >> "hiddenSelections")
				
			],
			true	// Force default
		],
		
		["COMBO",
		["2. Required item", "Select item required to be present in player's inventory to collect this intel\n\nThis item will be spawned in seperate box nearby"],
			[
				[	// Values. These MUST be magazines!
					"NONE",
					"FlashDisk",
					"Laptop_Unfolded",		//	Laptop_Closed
					"SmartPhone",
					"FileNetworkStructure"
				],
				[	// Pretty values
					"NONE",
					["Memory stick", "", "\a3\Missions_F_Oldman\Props\data\FlashDisk_ca.paa"],
					["Laptop", "", "\a3\Missions_F_Oldman\Props\data\Laptop_Unfolded_ca.paa"],
					["Smart phone", "", "\a3\Missions_F_Oldman\Props\data\SmartPhone_ca.paa"],
					["Document: Network Structure", "", "\a3\Missions_F_Oldman\Props\data\FileNetworkStructure_ca.paa"]
				],
				0	// Default index
			],
			false	// Force default
		],
		
		
		["TOOLBOX:YESNO",
		["2.2. Re-spawn required item", ""],
			[
				false
			],
			true	// Force default
		],
		
		["COMBO",
		["3. Required player", "Who has necessary skill to 'hack' computer. Engineer, Specialist etc"],
			[
				_allPlayers,	// Values
				_allPlayersPretty,	// Pretty values
				
				0	// Default index
			],
			false	// Force default
		],
		
		["SLIDER",
		["6. Frequency of interruption (%)", "How often intel retvieval process can be interrupted, requiring player's manual intervention to continue"],
			[
				0,		// Min value
				75,	// Max value
				33,	// Default value
				0		// Formatting
			],
			false	// Force default
		],
		
		["EDIT",
		["6. Intel Title", "Title of this intel"],
			[
				"",
				{}
			],
			false	// Force default
		],
		
		["EDIT:MULTI",
		["7. Intel Text", "Define contents of this intel"],
			[
				"",
				{},
				4
			],
			false	// Force default
		],
		
		["COMBO",
		["8. Intel retrieval type", "How successfully retrieved intel is given to player"],
			[
			[	// Values
				"acex_intelitems_document",
				"Briefing"
			],
			[	// Pretty values
				["ACE Intel Item", "Physical document item added to player's inventory.\nOnly player who's in posession of item can read it, but it can be passed along"],
				"Map Briefing",
				"Laptop",
				"Smart phone"
			],
			0	// Default index
			],
			false	// Force default
		],
		
		["COMBO",
		["9. Intel shared with (If map briefing used)", "Who will see intel text.\nONLY APPLIES TO SETTING 7. TYPE 'MAP BRIEFING'"],
			[
				[	// Values
					"NONE",
					"GROUP",
					"SIDE",
					"EVERYONE"
				],
				[	// Pretty values
					"Nobody",
					"Same group",
					"Same side",
					"Everyone"
				],
				3	// Default index
			],
			false	// Force default
		]
		
		
		
	], { // ON CONFIRM CODE
		(_this select 0) params ["_dialog0", "_dialog1", "_dialog2"];
		(_this select 1) params ["_module_pos", "_object"];
		
		[_object, _module_pos, _this select 0] call RAA_zeus_fnc_intel_create;
		
		
	},{	// On cancel code
		
	},	// Arguments
	_this
	
] call zen_dialog_fnc_create;
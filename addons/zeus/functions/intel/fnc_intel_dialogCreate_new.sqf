/* File: fnc_intel_dialogCreate_new.sqf
 * Author(s): riksuFIN
 * Description: Create dialog for creating a new e-intel object
 *						If object is _not_ supplied position is used
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Position to spawn new intel object	<ARRAY>
 1: 	Object to use <OBJECT>
 2:	
 3:	
 4:
 *
 Returns:
 *
 * Example:	[getPos player, _this] call RAA_zeus_fnc_intel_dialogCreate_new
*/
params ["_pos", "_object"];


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
if !(isNull _object) then {
	// Module was placed on existing object, use that. Let user pick correct screen
	_dialog1 = ["TOOLBOX",
	["1. Select object face to use", "Often first value is desired one"],
		[
			0,		// Default value
			2,		// Number of rows
			2,		// Number of columns
			getArray (configFile >> "CfgVehicles" >> typeOf _object >> "hiddenSelections")
			
		],
		true	// Force default
	];
	
} else {
	_dialog1 = ["COMBO",
	["1. Select object", ""],
		[
			[	// Values
				"Land_Laptop_unfolded_F",
				"Land_Laptop_03_black_F",
				"Land_Laptop_03_olive_F",
				"Land_PCSet_01_screen_F",
				"Land_FlatTV_01_F",
				"Item_SmartPhone",
				"Land_Tablet_01_F",
				"Land_Tablet_02_F",
				"Land_MultiScreenComputer_01_olive_F",
				"Land_TripodScreen_01_large_black_F",
				"Land_TripodScreen_01_dual_v2_black_F"

			],
			[	// Pretty values
				["Laptop", "", "A3\EditorPreviews_F\Data\CfgVehicles\Land_Laptop_unfolded_F.jpg"],
				["Rugged laptop (Black)", "", "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_Laptop_03_black_F.jpg"],
				["Rugged Laptop (Olive)", "", "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_Laptop_03_olive_F.jpg"],
				["PC Screen", "", "\A3\EditorPreviews_F\Data\CfgVehicles\Land_PCSet_01_screen_F.jpg"],
				["TV Screen", "", "\A3\EditorPreviews_F\Data\CfgVehicles\Land_FlatTV_01_F.jpg"],
				["Smartphone", "", "\A3\EditorPreviews_F\Data\CfgVehicles\Land_MobilePhone_smart_F.jpg"],
				["Tablet", "", "\A3\EditorPreviews_F\Data\CfgVehicles\Land_Tablet_01_F.jpg"],
				["Rugged Tablet", "", "\A3\EditorPreviews_F\Data\CfgVehicles\Land_Tablet_02_F.jpg"],
				["Rugged PC (3 screens)", "Note: Only middle screen will be active!", "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_MultiScreenComputer_01_olive_F.jpg"],
				["Rugged Display (huge, on tripod)", "", "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_TripodScreen_01_large_black_F.jpg"],
				["Rugged Display (2 screens, on tripod)", "Note: Only left screen will be active!", "\A3\EditorPreviews_F_Enoch\Data\CfgVehicles\Land_TripodScreen_01_dual_v2_black_F.jpg"]

			],
			0	// Default index
		],
		false	// Force default
	];
};

// DIALOG 3: Required player
private _allPlayers = call BIS_fnc_listPlayers;
private _allPlayersPretty = ["ANYONE"];
{
	
	_allPlayersPretty pushBack (format ["%1 (%2)", name _x, roleDescription _x]);
	
} forEach _allPlayers;

_allPlayers = ["ANYONE"] + _allPlayers;




["Electronic Intel Creator",
	[ // CONTENT
	
		// First dialog is defined above because it can change dynamically
		_dialog1,
		
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
		["COMBO",
		["3. Required player", "Who has necessary skill to 'hack' computer. Engineer, Specialist etc"],
			[
				_allPlayers,	// Values
				_allPlayersPretty,	// Pretty values
				
				0	// Default index
			],
			false	// Force default
		],
		
		
		["COMBO",
		["4. Animation", "Select which animation should play"],
			[
				[	// Values
					"PROGRESS_GENERIC",
					"",
					""
				],
				[	// Pretty values
					"Generic",
					"",
					""
				],
				0	// Default index
			],
			false	// Force default
		],
		
		["SLIDER",
		["5. Intel retrieval time (s)", "How long it takes to get this intel"],
			[
				5,		// Min value
				300,	// Max value
				10,	// Default value
				0		// Formatting
			],
			false	// Force default
		],
		
		["SLIDER",
		["6. Average number of interruptions", "How many times, in average, will this intel gathering process be interrupted, requiring player's nanual intervention.\n\nE.g: 2 = 2 interruptions during intel gathering, 0.5= one in two gatherings will have interruption"],
			[
				0,		// Min value
				5,	// Max value
				0.5,	// Default value
				1		// Formatting
			],
			false	// Force default
		],
		
		["EDIT",
		["7. Intel Title", "Title of this intel"],
			[
				"",
				{}
			],
			false	// Force default
		],
		
		["EDIT:MULTI",
		["8. Intel Text", "Define contents of this intel"],
			[
				"",
				{},
				4
			],
			false	// Force default
		],
		
		["COMBO",
		["9. Intel retrieval type", "How successfully retrieved intel is given to player"],
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
		["10. Intel shared with", "Who will see intel text.\nONLY APPLIES IF SETTING 9. TYPE 'MAP BRIEFING' SELECTED\n\nALWAYS shared with Zeus regardless of this setting"],
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
	//	(_this select 0) params ["_dialog0", "_dialog1", "_dialog2"];
		(_this select 1) params ["_module_pos", "_object"];
		
		[_object, _module_pos, _this select 0] remoteExec ["RAA_zeus_fnc_intel_dialogHandle_new", 2];
		
		
	},{	// On cancel code
		
	},	// Arguments
	_pos,
	_object
	
] call zen_dialog_fnc_create;
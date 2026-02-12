#include "script_component.hpp"
/* File:				createZeusModules.sqf
 * Authors: 		riksuFIN
 * Description:	Adds custom modules to Zeus
 *
 * Called from:	XEH_PostInit.sqf
 * Local to: 		Client
 * Parameter(s): 	None

 Returns:		None
 *
 */

/*
["Maadaa", "Aseta respawn tiketit", {
	["TICKETS",
		[ // CONTENT
			["SLIDER", // Type
			"Respa tikettien määrä", // Name
				[0, // Min value
				20,  // Max value
				[maadaa_respawnTickets, 0] select (isNil "maadaa_respawnTickets"), // Default value
				0], // Formatting (number of decimals)
				true	// Force default
			]
		], { // ON CONFIRM CODE
			[format ["TICKETS UPDATED TO %1", round (_this select 0 select 0)]] call zen_common_fnc_showMessage;
			maadaa_respawnTickets = round (_this select 0 select 0);
			publicVariable "maadaa_respawnTickets";
		},{	// On cancel code
		},[	// Arguments
		]
	] call zen_dialog_fnc_create;
	
},
"z\ace\addons\field_rations\ui\icon_survival.paa"
] call zen_custom_modules_fnc_register;



*/

[
	"RAA", "Play Animation on unit", {
		// Function to execute once module is placed down
		params ["_position", "_object"];

		if (!isNull _object && (_object isKindOf "CAManBase")) then {
		//	[_object] call RAA_animation_createAnimList;
			[_object] call EFUNC(animation,createAnimList);
			
		} else {
			["Module must be placed on unit"] call zen_common_fnc_showMessage;
		};
	},
//	"\r\misc\addons\RAA_animation\pics\icon_dance.paa"
	QPATHTOEF(animation,pics\icon_dance.paa)
] call zen_custom_modules_fnc_register;



["RAA", "Set Player Hunger/ Thirst", {
	if !(isPlayer (_this select 1)) exitWith {
		["MODULE MUST BE PLACED ON PLAYER UNIT"] call zen_common_fnc_showMessage;
	};
	
	["PLAYER HUNGER/ THIRST",
		[ // CONTENT
			["SLIDER", // Type  
			"Hunger", // Name  
				[0, // Min value  
				90,  // Max value  
				_this select 1 getVariable ["acex_field_rations_hunger", 0], // Default value  
				0], // Formatting (number of decimals)
				true	// Force default
		   ],
			
			["SLIDER", // Type  
			"Thirst", // Name  
				[0, // Min value  
				90,  // Max value  
				_this select 1 getVariable ["acex_field_rations_thirst", 0], // Default value  
				0],
				true	// Force default
			]
			
		], { // ON CONFIRM CODE
			["PLAYER's HUNGER AND THIRST UPDATED"] call zen_common_fnc_showMessage;
			_this select 1 select 0 setVariable ["acex_field_rations_hunger",_this select 0 select 0, true];
			_this select 1 select 0 setVariable ["acex_field_rations_thirst",_this select 0 select 1, true]; 
			
		},{	// On cancel code
		},[	// Arguments
		_this select 1
		]
	] call zen_dialog_fnc_create;
	
},
"z\ace\addons\field_rations\ui\icon_survival.paa"
] call zen_custom_modules_fnc_register;



[	"RAA", "Skip Time with Hunger", {
	// Function to execute once module is placed down
	//	params ["_position", "_object"];
		
		["SKIP TIME WITH HUNGER",[
				["SLIDER",			// Type
					"HOURS to skip",[
						0,		// Min
						24,	// Max
						1,		// Default
						{		// Formatting, Must return string
							format ["%1 h", floor _this]
						}
					]
				],
			
				["SLIDER",			// Type
					"MINUTES to skip",[
						0,		// Min
						60,	// Max
						0,		// Default
						{		// Formatting, Must return string
							format ["%1 min", floor _this]
						}
					]
				],
			
				["TOOLBOX:YESNO",
					["Simulate Hunger And Thirst",
						"Select Yes to make each player's hunger and thirst grow as time passes. \nWill be capped, so will never actually kill them.\n\nRequired for 'Consume Field Ration Items'"
					],[
						true	// Default setting
					]
				],
				
				["TOOLBOX:YESNO",
					["Consume Field Ration Items",
						"Yes to automatically consume each player's food and drink items from their inventory to simulate consuming them\n\nSelect No to prevent this.\nThis will never kill players, even if they run out of food/ drink"
					],[
						true	// Default setting
					]
				],
				
				["SLIDER",			// Type
					["Item consumption easing",
							"How much consumption of items is eased up during timeskip compared to if players were to consume items in real time.\nAUTO to calculate based on length of time skip\n1:1 to consume items exactly at same rate as normally\n2 for doupling their effect.\n3 for tripling their effect, and so on"
					],[
						0,		// Min
						5,	// Max
						0,		// Default
						{		// Formatting, Must return string
							switch (round _this) do {
								case (0): {"AUTO"};
								case (1): {"1:1"};
								case (2): {"2"};
								case (3): {"3"};
								case (4): {"4"};
								case (5): {"5"};
							}
						}
					]
				],
				
				["EDIT",
					["Custom message",
						"Text that will be shown to players during black screen. %1 Will be replaced with skipped time\n Default: Waiting for %1"
					],[
						"Waiting for %1"	// Default text
					]
				],
				
				["TOOLBOX",
					["Auto-filled text Language",
						"If %1 is used in above field it is replaced with amount of time skipped. Select language used for that text"
					],[
						0,	// Default
						1,	// Rows
						2,	// Columns
						["English", "Finnish"]	// Option names
						
					]
				],
				
				["TOOLBOX:YESNO",
					["Effect Zeus",
						"Select if you wish to get black screen and receive hunger simulation as well"
					],[
						false	// Default setting
					]
				],
				
				["SLIDER",
					["Blackout length",
						"How long player's screen will be blacked out.\nIncrease if you need extra time to hide your actions, like teleporting players."
					],[
						7,		// Min value
						120,	// Max value
						7,		// Default value
						0	// Formatting
					]
				]/*,
				["TOOLBOX:YESNO",		// https://github.com/acemod/ACE3/tree/master/addons/volume/functions
					["Disable player's volume during blackout",
						"If enabled will disable effect sounds for players during blackout time.\nHides whatever you're doing."
					],[
						false	// Default setting
					]
				]*/
				
			], {	// Code to execute upon pressing OK
				[
					_this select 0 select 0,	// Hours
					_this select 0 select 1,		// Minutes
					_this select 0 select 2,		// Simulate hunger
					_this select 0 select 3,		// Consume items
					round (_this select 0 select 4),	// Consumption easing
					_this select 0 select 5,		// Message
					_this select 0 select 6,		// Language
					_this select 0 select 7,		// Effect Zeus
					round (_this select 0 select 8)		// Extended blackout
			//	] remoteExec ["RAA_zeus_fnc_skipTimeWithHunger", 0];
				] remoteExec [QFUNC(skipTimeWithHunger_local), [0, -2] select isDedicated];
				
				private _hours = _this select 0 select 0;
				private _minutes = _this select 0 select 1;
				
				private _timeToSkip = _hours + (_minutes / 60);
				
				[ {
					[_this select 0] remoteExec ["skipTime", 2];
					}, 
					[_timeToSkip
					], 
					3	// Delay
				] call CBA_fnc_waitAndExecute;
				
			},
			{},	// On Cancel
			[	// Arguments
			]
		] call zen_dialog_fnc_create;
	},
//	"\r\misc\addons\RAA_zeus\pics\icon_skip.paa"
	QPATHTOF(pics\icon_skip.paa)
] call zen_custom_modules_fnc_register;





[
	"RAA", "Jam player's weapon", {
		// Function to execute once module is placed down
		params ["_position", "_object"];

		if (!isNull _object && (_object isKindOf "CAManBase") && isPlayer _object) then {
			
			[_object, currentWeapon _object] remoteExec ["ace_overheating_fnc_jamWeapon", _object];
			
			
		//	[_object, currentWeapon _object] call ace_overheating_fnc_jamWeapon;
			["Jammed!"] call zen_common_fnc_showMessage;
			
		} else {
			["Module must be placed on player"] call zen_common_fnc_showMessage;
		};
	},
//	"\r\misc\addons\RAA_zeus\pics\icon_weapon_disabled.paa"
	QPATHTOF(pics\icon_weapon_disabled.paa)
] call zen_custom_modules_fnc_register;









[	"RAA", "Force player spectator", {
	// Function to execute once module is placed down
	
		params ["_position", "_object"];
		if (!isNull _object && (_object isKindOf "CAManBase") && isPlayer _object) then {
			
			["FORCE PLAYER IN SPECTATOR",[	// Dialog Title
			
					["TOOLBOX:ENABLED",
						["Spectator Interface",
							"Enable to force player in spectator. Disable to pull them back"
						],[
							true	// Default setting
						]
					],
					
					["TOOLBOX:YESNO",
						["Force interface",
							"Choose if player should be locked in spectator.\nIf false, player will be able to exit spectator by pressing ESC"
						],[
							true	// Default setting
						]
					]
					
					
				], {	// Code to execute upon pressing OK
					[
						_this select 0 select 0,	// force spectator 
						_this select 0 select 1,	// Force interface
						true
					] remoteExec ["ace_spectator_fnc_setSpectator", _this select 1 select 0];
					
					if (RAA_misc_debug) then {systemChat format ["ForceSpect params: interface %1 force %2 unit %3", _this select 0 select 0, _this select 0 select 1, _this select 1 select 0];};
					
				},
				{},	// On Cancel
				[	// Arguments
					_this select 1	// Unit under cursor
				]
			] call zen_dialog_fnc_create;
		} else {
			["Module must be placed on player"] call zen_common_fnc_showMessage;
		};
	}
] call zen_custom_modules_fnc_register;






[	"RAA", "Set AI Skill Level", {
	// Function to execute once module is placed down
	
//	[] call RAA_zeus_fnc_AISkillPreset_createDialog;
	[] call FUNC(AISkillPreset_createDialog);
	
	},
//	"\r\misc\addons\RAA_zeus\pics\icon_skill.paa"
	QPATHTOF(pics\icon_skill.paa)
] call zen_custom_modules_fnc_register;




["Environment", "Set Fog", {
	params ["_pos","_object"];
	
	private _currentFog = fogParams;
	
	RAA_zeus_fogModuleParams = fogParams;
	
	["Set Fog",
		[ // CONTENT
			["SLIDER",
				["Transition Time", "Time in seconds how long it will take to transit from current fog to set value"],
				[	0, // Min value
					300,  // Max value
					30, // Default value
				{		// Formatting, Must return string
					if (_this == 0) then {
						"INST"
					} else {
						format ["%1 s", round _this]
					};
				}],
				false	// Force default
		   ],
			
			["SLIDER",
				["Value", "Amount of fog in the air"],
				[0, // Min value
				1,  // Max value
				_currentFog select 1, // Default value
				{		// Formatting, Must return string.
					RAA_zeus_fogModuleParams set [0,_this];
					0 setFog [RAA_zeus_fogModuleParams select 0, RAA_zeus_fogModuleParams select 1, RAA_zeus_fogModuleParams select 2];
					
					if (_this == 0) then {
						"NONE"
					} else {
						_this toFixed 2;
					};
				}],
				true	// Force default
			],
			
			["SLIDER",
			["Decay", "How strong altitude boundary of fog is. Defined by setting 'Base'.\nSmaller values mean smoother transition, while large values create clear boundaries between clear air and fog.\n\nIf positive: Fog will be generated below 'Base' altitude\nIf negative: Fog will be generated above 'Base' altitude\n\nExample uses: Positive to create fog in valleys. Negative to make mountain peaks covered in fog while ground-level is clear."],
				[-1, // Min value
				1,  // Max value
				_currentFog select 1, // Default value
				{		// Formatting, Must return string.
					RAA_zeus_fogModuleParams set [1,_this];
					0 setFog [RAA_zeus_fogModuleParams select 0, RAA_zeus_fogModuleParams select 1, RAA_zeus_fogModuleParams select 2];
					
					_this toFixed 2;
				}],
				true	// Force default
			],
			
			["SLIDER",
			["Base", "Altitude of fog base.\nDefaults to module altitude.\n\nUsed to define boundary of fog altitude for 'Decay' setting"],
				[0, // Min value
				500,  // Max value
				_pos select 2, // Default value
				{		// Formatting, Must return string.
					RAA_zeus_fogModuleParams set [2,_this];
					0 setFog [RAA_zeus_fogModuleParams select 0, RAA_zeus_fogModuleParams select 1, RAA_zeus_fogModuleParams select 2];
					
					str round _this;
				}],
				true	// Force default
			]
			
			
		], { // ON CONFIRM CODE
			
			if (isMultiplayer) then {
				["Server will now update fog"] call zen_common_fnc_showMessage;
				[_this select 0 select 0,[
				_this select 0 select 1,
				_this select 0 select 2,
				_this select 0 select 3]] remoteExec ["setFog", 2];
			} else {
				["Updating fog"] call zen_common_fnc_showMessage;
				_this select 0 select 0 setFog [_this select 0 select 1, _this select 0 select 2, _this select 0 select 3];
				
			};
			
			RAA_zeus_fogModuleParams = nil;
		},{	// On cancel code
			RAA_zeus_fogModuleParams = nil;
		},	// Arguments
		_this select 0
		
	] call zen_dialog_fnc_create;
},
//"\r\misc\addons\RAA_zeus\pics\icon_fog.paa"
QPATHTOF(pics\icon_fog.paa)
] call zen_custom_modules_fnc_register;





[	"RAA", "Copy Terrain object", {
	// Function to execute once module is placed down
	params ["_pos","_object"];
	
//	[_pos] call RAA_zeus_fnc_module_copyTerrainObject;
	[_pos] call FUNC(module_copyTerrainObject);
	
	},
//	"\r\misc\addons\RAA_zeus\pics\icon_copy.paa"
	QPATHTOF(pics\icon_copy.paa)
] call zen_custom_modules_fnc_register;






["RAA", "Change instadeath-settings", {
	params ["_pos","_object"];
	
	["Instadeath Settings",
		[ // CONTENT
		
		["TOOLBOX",
			["Instadeath for Players",
				""
			],[
				ace_medical_statemachine_fatalInjuriesPlayer,	// Default
				1,	// Rows
				3,	// Columns
				["Always", "In Cardiac Arrest", "Never"]	// Option names
			],
			true	// Force default
		],
		
		["TOOLBOX",
			["Instadeath for AI",
				""
			],[
				ace_medical_statemachine_fatalInjuriesAI,	// Default
				1,	// Rows
				3,	// Columns
				["Always", "In Cardiac Arrest", "Never"]	// Option names
			],
			true	// Force default
		]
			
		], { // ON CONFIRM CODE
			params ["_dialogValues"];
			_dialogValues params ["_instaDeath_player", "_instaDeath_ai"];
			
			// Force override CBA settings variables with desired settings
			ace_medical_statemachine_fatalInjuriesPlayer = _instaDeath_player;
			publicVariable "ace_medical_statemachine_fatalInjuriesPlayer";
			ace_medical_statemachine_fatalInjuriesAI = _instaDeath_ai;
			publicVariable "ace_medical_statemachine_fatalInjuriesAI";
			
			["Settings applied"] call zen_common_fnc_showMessage;
			
		//	["Updating fog"] call zen_common_fnc_showMessage;
		//	_this call FUNC(setInstadeathSettings)
			
			
		},{	// On cancel code
			
		}	// Arguments
	//	_this select 0
		
	] call zen_dialog_fnc_create;
},
//"\r\misc\addons\RAA_zeus\pics\icon_fog.paa"
QPATHTOF(pics\icon_instadeath.paa)
] call zen_custom_modules_fnc_register;




["Fire Support", "Rapid Fire MLRS/ Artillery", {
	params ["_pos","_object"];
	
	if (count (getArtilleryAmmo [_object]) > 0) then {
		
		[_object] call FUNC(createDialog_doArtilleryFire);
		
		
		
	} else {
		["Bad unit"] call zen_common_fnc_showMessage;
		
		
	};
	
	
},
//"\r\misc\addons\RAA_zeus\pics\icon_fog.paa"
QPATHTOF(pics\icon_instadeath.paa)
] call zen_custom_modules_fnc_register;




// cTab mod
if !(isNil "cTab_encryptionKey_west") then {
	[	"RAA", "Set cTab encryption keys", {
		// Function to execute once module is placed down
		
		["SET cTab ENCRYPTION KEYS",
			[ // CONTENT
			
			["EDIT",
				["Key for WEST",
					"Sides with matching keys will see each other on CTAB\n\nEg. If keys are: 'B' for WEST and EAST, 'A' for IND, in that case WEST and EAST see each other but INDEPENDENT sees neither\n\nActual key should be single letter"
				],[
					cTab_encryptionKey_west,	// Default
					{}
				],
				true	// Force default
			],
			
			["EDIT",
				["Key for EAST",
					"Sides with matching keys will see each other on CTAB\n\nEg. If keys are: 'B' for WEST and EAST, 'A' for IND, in that case WEST and EAST see each other but INDEPENDENT sees neither\n\nActual key should be single letter"
				],[
					cTab_encryptionKey_east,	// Default
					{}
				],
				true	// Force default
			],
			
			["EDIT",
				["Key for INDEPENDENT",
					"Sides with matching keys will see each other on CTAB\n\nEg. If keys are: 'B' for WEST and EAST, 'A' for IND, in that case WEST and EAST see each other but INDEPENDENT sees neither\n\nActual key should be single letter"
				],[
					cTab_encryptionKey_guer,	// Default
					{}
				],
				true	// Force default
			],
			
			["EDIT",
				["Key for CIVILIAN",
					"Sides with matching keys will see each other on CTAB\n\nEg. If keys are: 'B' for WEST and EAST, 'A' for IND, in that case WEST and EAST see each other but INDEPENDENT sees neither\n\nActual key should be single letter"
				],[
					cTab_encryptionKey_civ,	// Default
					{}
				],
				true	// Force default
			]
				
				
				
			], { // ON CONFIRM CODE
				params ["_dialogValues"];
				_dialogValues params ["_west", "_east", "_ind", "_civ"];
				
				cTab_encryptionKey_west = _west;
				publicVariable "cTab_encryptionKey_west";
				cTab_encryptionKey_east = _east;
				publicVariable "cTab_encryptionKey_east";
				cTab_encryptionKey_guer = _ind;
				publicVariable "cTab_encryptionKey_guer";
				cTab_encryptionKey_civ = _civ;
				publicVariable "cTab_encryptionKey_civ";
				
				["Settings applied"] call zen_common_fnc_showMessage;
				
				
			},{	// On cancel code
			}	// Arguments
		//	_this select 0
			
		] call zen_dialog_fnc_create;
		
		
		
		},
		QPATHTOF(pics\icon_encryption_key.paa)
	] call zen_custom_modules_fnc_register;
};



[	"RAA", "Force Surrender on Hit", {
	// Function to execute once module is placed down
	
		params ["_position", "_object"];
		if (!isNull _object && (_object isKindOf "CAManBase") && !(isPlayer _object)) then {
			
			["FORCE SURRENDER ON EVENT",[	// Dialog Title
			
					["TOOLBOX:ENABLED",
						["EVENT: On Hit",
							"Unit surrenders when taking direct hit"
						],[
							true	// Default setting
						]
					],
					["TOOLBOX:ENABLED",
						["EVENT: On FiredNear",
							"Unit surrenders if weapon is discharged nearby\n\nNOTE: Does NOT work with bullets fired by friendlies!"
						],[
							true	// Default setting
						]
					],
					["TOOLBOX:YESNO",
						["ACTION: Drop Weapon",
							""
						],[
							true	// Default setting
						]
					],
					["TOOLBOX:YESNO",
						["ACTION: Surrender",
							""
						],[
							true	// Default setting
						]
					],
					
					["COMBO",
						["ACTION: Shout",
							"Make unit shout something on action"
						],[
							[
								"",
								"RANDOM",
								"RAA_misc_dialog_noShoot",
								"RAA_misc_dialog_holyShit",
								"RAA_misc_dialog_perkele"
								
							],	// Values
							[
								["Nothing", ""],
								["Random", ""],
								["No Shoot!", ""],
								["Holy shit!", ""],
								["Perkele!", ""]
							],	// Pretty values
							1	// Default index
						]
					]
					
					
				], {	// Code to execute upon pressing OK
					
					// Ensure code is executed on machine where target unit is local
					[
						_this select 0,
						_this select 1 select 0
					] remoteExec [QUOTE(FUNC(handleDialog_surrenderOnEvent)), _this select 1 select 0];
					
					//if (RAA_misc_debug) then {systemChat format ["ForceSpect params: interface %1 force %2 unit %3", _this select 0 select 0, _this select 0 select 1, _this select 1 select 0];};
					
				},
				{},	// On Cancel
				[	// Arguments
					_this select 1	// Unit under cursor
				]
			] call zen_dialog_fnc_create;
		} else {
			["Invalid object selected"] call zen_common_fnc_showMessage;
		};
	}
] call zen_custom_modules_fnc_register;




[	"RAA", "Override group/unit skill level", {
	// Function to execute once module is placed down
	
		params ["_position", "_object"];
		if (!isNull _object && (_object isKindOf "CAManBase") && !(isPlayer _object)) then {
			
			["OVERRIDE INVIDUAL'S SKILL LEVEL",	// Dialog Title
				[	
					["TOOLBOX",
						["Who to effect",
							""
						],[
							0,	// Default setting
							1,
							2,
							["Selected unit only", "Group of selected unit"]
						]
					],
					
					["TOOLBOX",
						["Skill Level",
							""
						],[
							0,	// Default setting
							3,
							2,
							[
								"No override", 
								"Untrained", 
								"Poorly trained",
								"Trained",
								"Experienced",
								"Special Forces"
							]
						]
					]
					
				], {	// Code to execute upon pressing OK
					_this call FUNC(AISkillPresets_handleModule_unitOverride);
					
				},
				{},	// On Cancel
				[	// Arguments
					_object	// Unit under cursor
				]
			] call zen_dialog_fnc_create;
		} else {
			["Invalid object selected"] call zen_common_fnc_showMessage;
		};
	}
] call zen_custom_modules_fnc_register;




if (["acre_main"] call ace_common_fnc_isModLoaded) then {
	// Babel

	[	"ACRE", "Babel: Add Language", {
		// Function to execute once module is placed down
		
		_this call FUNC(babel_createDialog_addLanguage);
	}] call zen_custom_modules_fnc_register;
	
	
	
	[	"ACRE", "Babel: Configure Languages", {
		// Function to execute once module is placed down
		if (count acre_sys_core_languages < 1) exitWith {
			private _msg = "There are no speakable languages! You must first add some with 'ACRE -> Babel: Add Speakable Languages' module!";
			systemChat _msg;
			[_msg] call zen_common_fnc_showMessage;
		};
		
		private _options = ["-1"];
		private _optionsPretty = [""];
		{
			_options pushBack (_x select 0);
			_optionsPretty pushBack format ["%1 (%2)", _x select 1, _x select 0];
		} forEach acre_sys_core_languages;
		
		private _dialogs = [];
		{
			_dialogs pushBack ["EDIT",	// This is used as a spacer
				["",
					""
				],[
					_x
				],
				true	// Force default
			];
			for "_i" from 1 to 3 do {
				_dialogs pushBack ["COMBO",
					[format ["%1 Language %2", _x, _i], format ["Select language that ALL %1 units are able to speak\n\nEach side MUST have at least one speakable language, otherwise they will have nothing to say!", _x]],
					[
						_options,
						_optionsPretty,
						0
					],
					false	// Force default
				]
			};
		} forEach ["BLUFOR", "OPFOR", "INDEPENDENT", "CIVILIAN"];
		
	//	if (GVAR(debug)) then {systemChat format ["[RAA_zeus] %1", _dialogs]};
		
		["BABEL: CONFIGURE SIDES",	// Dialog Title
				
			_dialogs,
			{	// Code to execute upon pressing OK
				params ["_dialogValues"];
			//	_dialogValues params ["_west_1", "_west_2", "_west_3", "_east_1", "_east_2", "_east_3", "_ind_1", "_ind_2", "_ind_3", "_civ_1", "_civ_2", "_civ_3", ];
				
				//	[west, "English", "French"], [east, "Russian"], [civilian, "French"] ] call acre_api_fnc_babelSetupMission;
				private _dataToSend = [];
				private _temp = [];
				{
					// Put together array in right format for ACRE
					switch (_forEachIndex) do {
						case (0): {}; // Start of WEST
						case (4): {	// Start of EAST
							if (count _temp isEqualTo 0) then {
								systemChat "[WARNING] No language defined for WEST";
							};
							_dataToSend pushBack _temp;
							_temp = [];
						};
						case (8): {	// Start of INDEPENDENT
							if (count _temp isEqualTo 0) then {
								systemChat "[WARNING] No language defined for EAST";
							};
							_dataToSend pushBack _temp;
							_temp = [];
						};
						case (12): {	// Start of CIVILIAN
							if (count _temp isEqualTo 0) then {
								systemChat "[WARNING] No language defined for INDEPENDENT";
							};
							_dataToSend pushBack _temp;
							_temp = [];
						};
						case (15): {	// This one is final one, end of CIVILIAN.
							if (_x isNotEqualTo "-1") then {
								_temp pushBack _x;
							};
							if (count _temp isEqualTo 0) then {
								systemChat "[WARNING] No language defined for CIVILIAN";
							};
							_dataToSend pushBack _temp;
						};
						
						default {
							if (_x isNotEqualTo "-1") then {
								_temp pushBack _x;
							};
						};
						
					};
				} forEach _dialogValues;
				
				
				_dataToSend remoteExec [QFUNC(babel_handleDialog_configureSide), [0, -2] select isDedicated, true];
				
				
			//	[west, "English", "French"], [east, "Russian"], [civilian, "French"] ] call acre_api_fnc_babelSetupMission;
				
				// I think this has to be executed globally (?)
				//_sendToACRE remoteExec ["acre_api_fnc_babelSetupMission", [0, -2] select isDedicated, true];
				
				if (GVAR(debug)) then {systemChat format ["[RAA_zeus] %1", _dataToSend]; RAA_debug_zeus = _dataToSend};
			},
			{},	// On Cancel
			[	// Arguments
			]
		] call zen_dialog_fnc_create;
	}] call zen_custom_modules_fnc_register;
	
	
	
	["ACRE", "Babel: Configure Invidual Unit", {
			// Function to execute once module is placed down
			if (count acre_sys_core_languages < 1 || !(isPlayer (_this select 1))) exitWith {
				private _msg = "There are no speakable languages OR unit is invalid!";
				systemChat _msg;
				[_msg] call zen_common_fnc_showMessage;
			};
			
			private _options = ["-1"];
			private _optionsPretty = [""];
			{
				_options pushBack (_x select 0);
			//	_optionsPretty pushBack (_x select 1);
				_optionsPretty pushBack format ["%1 (%2)", _x select 1, _x select 0];
			} forEach acre_sys_core_languages;
			
			
			private _tempArray = [];
			{
				_tempArray pushBack (_x select 0)
				
			} forEach acre_sys_core_languages;
			
			
			
		["BABEL: CONFIGURE INVIDUAL",	// Dialog Title
			[
				["COMBO",
					["Language #1", "Select language this unit will be able to speak\n\nThis will override any side-specific languages"],
					[
						_options,
						_optionsPretty,
						0
					],
					false	// Force default
				],
				["COMBO",
					["Language #2", "Select language this unit will be able to speak\n\nThis will override any side-specific languages"],
					[
						_options,
						_optionsPretty,
						0
					],
					false	// Force default
				],
				["COMBO",
					["Language #3", "Select language this unit will be able to speak\n\nThis will override any side-specific languages"],
					[
						_options,
						_optionsPretty,
						0
					],
					false	// Force default
				]
			], {	// Code to execute upon pressing OK
				params ["_dialogValues", "_params"];
				_params params ["_unit"];
				
				private _sendToACRE = [];
				{
					if (_x isNotEqualTo "-1") then {
						_sendToACRE pushBack _x;
					};
				} forEach _dialogValues;
				
				if (count _sendToACRE > 0) then {
					// Send defined languages to player
					_sendToACRE remoteExec ["acre_api_fnc_babelSetSpokenLanguages", _unit];
				} else {
					["No languages defined"] call zen_common_fnc_showMessage;
				};
				
				if (GVAR(debug)) then {systemChat format ["[RAA_zeus] %1", _sendToACRE];};
			},
			{},	// On Cancel
			[	// Arguments
				_this select 1	// Unit under cursor
			]
		] call zen_dialog_fnc_create;
	}] call zen_custom_modules_fnc_register;
	
	
	
	
};	// End of ACRE dependency


["RAA", "Change Inventory/ Cargo Size", {
	params ["_pos","_object"];
	
	[_object] call FUNC(createDialog_changeInventorySize);
	
},
QPATHTOF(pics\icon_cargo.paa)
] call zen_custom_modules_fnc_register;


[
	"RAA", "Kill Player", {
		// Function to execute once module is placed down
		params ["_position", "_object"];

		if (!isNull _object) then {
			
			_object setDamage 1;
			
		} else {
			["Module must be placed on Object or Unit"] call zen_common_fnc_showMessage;
		};
	},
	QPATHTOF(pics\icon_x_ca.paa)
] call zen_custom_modules_fnc_register;





/*
[	"RAA", "Add Bloody Uniform", {
		// Function to execute once module is placed down
		params ["_position", "_object"];
		if (!isNull _object && (_object isKindOf "CAManBase")) then {
			
			
			
			
			
		};
	},
	QPATHTOF(pics\icon_encryption_key.paa)
] call zen_custom_modules_fnc_register;
*/




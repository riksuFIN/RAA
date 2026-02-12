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




["RAA", "Set Object Texture: Static", {
	params ["_pos","_object"];
	
	// Check that object actually has hiddenTextures available
	if ((count getObjectTextures _object == 0) || (_object isKindOf "Man")) exitWith {
		["Unsupported object"] call zen_common_fnc_showMessage;
	};
	
	["Static Texture",
		[ // CONTENT
			["LIST",
				["Image", ""],
				[	// Control-specific arguments
				
					[	// Values
					//	"r\RAA\addons\common\pics\Motti_Logo.paa",
						QPATHTOEF(common,pics\Motti_Logo.paa),
						QPATHTOF(pics\monitor\tv_home.paa),
						QPATHTOF(pics\monitor\tv_home_wide.paa),
						QPATHTOF(pics\monitor\tv_no_signal.paa),
						QPATHTOF(pics\monitor\tv_standby.paa),
						"A3\missions_f_oldman\Data\img\Screens\CSATNtb_co.paa",
						"A3\missions_f_oldman\Data\img\Screens\CSATNtbDesktop_co.paa",
						
						QPATHTOF(pics\numbers\0.paa),
						QPATHTOF(pics\numbers\1.paa),
						QPATHTOF(pics\numbers\2.paa),
						QPATHTOF(pics\numbers\3.paa),
						QPATHTOF(pics\numbers\4.paa),
						QPATHTOF(pics\numbers\5.paa),
						QPATHTOF(pics\numbers\6.paa),
						QPATHTOF(pics\numbers\7.paa),
						QPATHTOF(pics\numbers\8.paa),
						QPATHTOF(pics\numbers\9.paa),
						QPATHTOF(pics\numbers\10.paa),
						QPATHTOF(pics\numbers\15.paa),
						QPATHTOF(pics\numbers\20.paa),
						QPATHTOF(pics\numbers\25.paa),
						QPATHTOF(pics\numbers\30.paa),
						QPATHTOF(pics\numbers\40.paa),
						QPATHTOF(pics\numbers\50.paa),
						QPATHTOF(pics\numbers\60.paa),
						QPATHTOF(pics\numbers\70.paa),
						QPATHTOF(pics\numbers\80.paa),
						QPATHTOF(pics\numbers\90.paa),
						QPATHTOF(pics\numbers\100.paa),
						QPATHTOF(pics\numbers\150.paa),
						QPATHTOF(pics\numbers\200.paa),
						QPATHTOF(pics\numbers\300.paa),
						QPATHTOF(pics\numbers\400.paa),
						QPATHTOF(pics\numbers\500.paa),
						QPATHTOF(pics\numbers\600.paa),
						QPATHTOF(pics\numbers\700.paa),
						QPATHTOF(pics\numbers\800.paa),
						QPATHTOF(pics\numbers\900.paa),
						QPATHTOF(pics\numbers\1000.paa),
						QPATHTOF(pics\numbers\2000.paa),
						QPATHTOF(pics\numbers\3000.paa)
						
					],
					[	// Corresponding pretty names
						["Motti Logo", "", QPATHTOEF(common,pics\Motti_Logo.paa), [0,1,0,1]],
						["TV: Home screen", "", QPATHTOF(pics\monitor\tv_home.paa), [0,1,0,1]],
						["TV: Home screen (Wide)", "", QPATHTOF(pics\monitor\tv_home_wide.paa), [0,1,0,1]],
						["TV: No Signal", "", QPATHTOF(pics\monitor\tv_no_signal.paa), [0,1,0,1]],
						["TV: Standby", "", QPATHTOF(pics\monitor\tv_standby.paa), [0,1,0,1]],
						["PC: Intel v1", "", "A3\missions_f_oldman\Data\img\Screens\CSATNtb_co.paa", [0,1,0,1]],
						["PC: Intel v1 wide", "", "A3\missions_f_oldman\Data\img\Screens\CSATNtbDesktop_co.paa", [0,1,0,1]],
						
						["0", "", QPATHTOF(pics\numbers\0.paa), [0,0,1,1]],
						["1", "", QPATHTOF(pics\numbers\1.paa), [0,0,1,1]],
						["2", "", QPATHTOF(pics\numbers\2.paa), [0,0,1,1]],
						["3", "", QPATHTOF(pics\numbers\3.paa), [0,0,1,1]],
						["4", "", QPATHTOF(pics\numbers\4.paa), [0,0,1,1]],
						["5", "", QPATHTOF(pics\numbers\5.paa), [0,0,1,1]],
						["6", "", QPATHTOF(pics\numbers\6.paa), [0,0,1,1]],
						["7", "", QPATHTOF(pics\numbers\7.paa), [0,0,1,1]],
						["8", "", QPATHTOF(pics\numbers\8.paa), [0,0,1,1]],
						["9", "", QPATHTOF(pics\numbers\9.paa), [0,0,1,1]],
						["10", "", QPATHTOF(pics\numbers\10.paa), [0,0,1,1]],
						["15", "", QPATHTOF(pics\numbers\15.paa), [0,0,1,1]],
						["20", "", QPATHTOF(pics\numbers\20.paa), [0,0,1,1]],
						["25", "", QPATHTOF(pics\numbers\25.paa), [0,0,1,1]],
						["30", "", QPATHTOF(pics\numbers\30.paa), [0,0,1,1]],
						["40", "", QPATHTOF(pics\numbers\40.paa), [0,0,1,1]],
						["50", "", QPATHTOF(pics\numbers\50.paa), [0,0,1,1]],
						["60", "", QPATHTOF(pics\numbers\60.paa), [0,0,1,1]],
						["70", "", QPATHTOF(pics\numbers\70.paa), [0,0,1,1]],
						["80", "", QPATHTOF(pics\numbers\80.paa), [0,0,1,1]],
						["90", "", QPATHTOF(pics\numbers\90.paa), [0,0,1,1]],
						["100", "", QPATHTOF(pics\numbers\100.paa), [0,0,1,1]],
						["150", "", QPATHTOF(pics\numbers\150.paa), [0,0,1,1]],
						["200", "", QPATHTOF(pics\numbers\200.paa), [0,0,1,1]],
						["300", "", QPATHTOF(pics\numbers\300.paa), [0,0,1,1]],
						["400", "", QPATHTOF(pics\numbers\400.paa), [0,0,1,1]],
						["50", "", QPATHTOF(pics\numbers\500.paa), [0,0,1,1]],
						["600", "", QPATHTOF(pics\numbers\600.paa), [0,0,1,1]],
						["700", "", QPATHTOF(pics\numbers\700.paa), [0,0,1,1]],
						["800", "", QPATHTOF(pics\numbers\800.paa), [0,0,1,1]],
						["900", "", QPATHTOF(pics\numbers\900.paa), [0,0,1,1]],
						["1000", "", QPATHTOF(pics\numbers\1000.paa), [0,0,1,1]],
						["2000", "", QPATHTOF(pics\numbers\2000.paa), [0,0,1,1]],
						["3000", "", QPATHTOF(pics\numbers\3000.paa), [0,0,1,1]]
						
					],
					0,		// Default index
					20		// Height
				]
		   ],
			
			
			["TOOLBOX",
			["Texture face", "Often first value is desired one"],
				[
					0,		// Default value
					2,		// Number of rows
					2,		// Number of columns
					getArray (configFile >> "CfgVehicles" >> typeOf _object >> "hiddenSelections")
					
				],
				true	// Force default
			]
			
			
		], { // ON CONFIRM CODE
			(_this select 0) params ["_dialog1", "_dialog2"];
			(_this select 1) params ["_module_pos", "_object"];
			
			_object setObjectTextureGlobal [_dialog2, _dialog1];
			
		},{	// On cancel code
			
		},	// Arguments
		_this
		
	] call zen_dialog_fnc_create;
},
//"\r\misc\addons\RAA_zeus\pics\icon_texture.paa"
QPATHTOF(pics\icon_texture.paa)
] call zen_custom_modules_fnc_register;









["RAA", "Set Object Texture: Animated", {
	params ["_pos","_object"];
	
	// Check that object actually has hiddenTextures available
	if ((count getObjectTextures _object == 0) || (_object isKindOf "Man")) exitWith {
		["Unsupported object"] call zen_common_fnc_showMessage;
	};
	
	
	["Animated screen",
		[ // CONTENT
			["LIST",
				["Animation type", ""],
				[	// Control-specific arguments
				
					[	// Values
						"COUNTDOWN_5",
						"COUNTDOWN_10",
						"BSOD",
						"EREASING"
						
					],
					[	// Corresponding pretty names
						["Countdown 5 to 0", "", QPATHTOF(pics\numbers\5.paa), [1,1,1,1]],
						["Countdown 10 to 0", "", QPATHTOF(pics\numbers\10.paa), [1,1,1,1]],
						["Blue screen of Death", "", QPATHTOF(pics\bsod\bsod_0.paa), [1,1,1,1]],
						["hacker: Ereasing Hard Drive", "Long, recommended length > 30 seconds", QPATHTOF(pics\hacking_ereasing\1.paa), [1,1,1,1]]
						
					],
					0,		// Default index
					10		// Height
				]
		   ],
			
			["SLIDER",
			["Animation Length", "Total length of animation\nImages in sequence will be distributed evenly through this length"],
				[
					5,		// Min value
					300,	// Max value
					10,	// Default value
					{		// Formatting
						private _return = round _this;
						format ["%1 s", _return]
					}
				],
				false	// Force default
			],
			
			["TOOLBOX",
			["Texture face", "Often first value is desired one"],
				[
					0,		// Default value
					2,		// Number of rows
					2,		// Number of columns
					getArray (configFile >> "CfgVehicles" >> typeOf _object >> "hiddenSelections")
					
				],
				true	// Force default
			]
			
			
			
			
		], { // ON CONFIRM CODE
			(_this select 0) params ["_dialog0", "_dialog1", "_dialog2"];
			(_this select 1) params ["_module_pos", "_object"];
			
			
			[_object, _dialog2, true, _dialog0, _dialog1, {hint "DONE"}] call FUNC(animScreen_start);
		//	[_object, _dialog2, true, _dialog0, _dialog1, {hint "DONE"}] remoteExec [QFUNC(animScreen_start), 2];
			
			
			
		},{	// On cancel code
			
		},	// Arguments
		_this
		
	] call zen_dialog_fnc_create;
},
//"\r\misc\addons\RAA_zeus\pics\icon_texture.paa"
QPATHTOF(pics\icon_texture.paa)
] call zen_custom_modules_fnc_register;







/*

["RAA", "Electronic Intel Creator", {
	params ["_pos",["_object", objNull]];
	
	if (_object getVariable ["RAA_intelCreated", false]) then {
		[_object] call RAA_zeus_fnc_intel_dialogCreate_edit
	} else {
		[_pos, _object] call RAA_zeus_fnc_intel_dialogCreate_new;
	};
},
"\r\misc\addons\RAA_zeus\pics\icon_hacking.paa"
QPATHTOF(pics\icon_hacking.paa)
] call zen_custom_modules_fnc_register;

*/



















































/*
["ZAFW", "End Mission (ZAFW)", {
//	params ["_pos","_object"];
	
	
	["End Mission (ZAFW)",
		[ // CONTENT
			
			["TOOLBOX:WIDE",
			["Ending Type", ""],
				[
					3,		// Default value		"Mission Success"
					4,		// Number of rows
					3,		// Number of columns
					[	
						["BLUFOR Victory"],
						["OPFOR Victory"],
						["INDEPENDENT Victory"],
						["Mission Success"],
						["Mission Failed"],
						["Pyrrhic Victory"],
						["Minor Victory"],
						["Major Victory"],
						["Minor Defeat"],
						["Major Defeat"]
					]
				],
				false	// Force default
			],
			
			["EDIT:MULTI",
			["Additional Text", "Text shown under Ending Type on End Screen"],
				[
					"",		// Default text
					{},		// Sanitizing function <CODE>
					4		// Height
				],
				false	// Force default
			]
			
			
		], { // ON CONFIRM CODE
			(_this select 0) params ["_dialog0", "_dialog1"];
		
			
			
			// This function is passed INDEX of selected option.
			// For example, "Mission Success" is index 3, "Major Victory" would be 7
			[_dialog0 + 1, 27, _dialog1] remoteExec ["zafw_fnc_endmission", 0]
			
			
		},{	// On cancel code
		}	// Arguments
	//	_this		// Passthrough from module (Not needed in this case)
		
	] call zen_dialog_fnc_create;
}
//"\r\misc\addons\RAA_zeus\pics\icon_texture.paa"
] call zen_custom_modules_fnc_register;
*/
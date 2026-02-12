

/*
configFile >> "ACEX_Fortify_Presets" >> 

configs1 = configProperties [configFile >> "ACEX_Fortify_Presets", "true"];
"true" configClasses (configFile >> "ACEX_Fortify_Presets");
getArray ((configs1 select 0) >> "objects")




class small
{
	displayName = "Small";
	objects[] = {{"Land_BagFence_Round_F",5},{"Land_BagFence_Short_F",5},{"Land_BagFence_Long_F",10},{"Land_Plank_01_4m_F",10},{"Land_BagBunker_Small_F",25}};
};
*/


//=============================
// THIS FILE WAS USED AS A SCRATCHPAD; TO BE DELETED!
// THIS FILE IS NEVER EXECUTED ANYWHERE

["ZAFW", "ACE Fortify Settings", {
	
	// Fill up presets from array
	private _presetClasses = [];
	private _presetPrettynames = [];	// This will be in format: [["Custom Preset 1", "Tooltip for Preset 1"], ["Custom Preset Huge", "Tooltip for Huge Preset"]]
	{
		// Provide option to blacklist certain presets via config
		if (getNumber (_x >> "za_ignoreInZeusDialog") isNotEqualTo 1) then {
			_presetClasses pushBack configName _x;
			_presetPrettynames pushBack [getText (_x >> "displayName"), getText (_x >> "za_toolTip")];
		};
		// Options are searched first from mission's config and then mod-created config
	} forEach (("true" configClasses (missionConfigFile >> "ACEX_Fortify_Presets")) + ("true" configClasses (configFile >> "ACEX_Fortify_Presets")));
	
	// Build dialog
	["ACE Fortify Settings",
		[ // CONTENT
		
			["TOOLBOX:YESNO", // Type
				"Fortify Enable", // Name
				true
			],
			
			["COMBO", // Type
				"User Side", // Name
				[ // Content-Specific arguments:
					[BLUFOR,OPFOR,INDEPENDENT,CIVILIAN],
					[
						["Blufor","", "\A3\3den\Data\Displays\Display3DEN\PanelRight\side_west_ca.paa"],
						["Opfor","", "\A3\3den\Data\Displays\Display3DEN\PanelRight\side_east_ca.paa"],
						["Independent","", "\A3\3den\Data\Displays\Display3DEN\PanelRight\side_guer_ca.paa"],
						["Civilian","", "\A3\3den\Data\Displays\Display3DEN\PanelRight\side_civ_ca.paa"]
					],
					0
				]
			],
			
			["SLIDER", // Type
				["Budget","Set to -1 for infinite"], // Name
				[ // Content-Specific arguments:
					-1,		// Min value
					5000,	// Max value
					500,	// Default value
					0		// Formatting
				]
			],
			
			["LIST", // Type
				["Preset","Select of items players can build"], // Name
				[ // Content-Specific arguments:
					_presetClasses,	//Values that can be returned
					_presetPrettynames,	//Corresponding pretty names
					0,	//Default index
					8	//Height
				]
			]
		], {	// On Success
			_this select 0 params ["_enable", "_side", "_budget", "_preset"];
			
			if (_enable) then {
				["On"] call acex_fortify_fnc_handleChatCommand;
				[format ["%1 %2 %3",_side,_preset,round _budget]] call acex_fortify_fnc_handleChatCommand;
				systemChat format ["Fortify enabled on %1, preset %2 with budget %3",_side,_preset,round _budget];
			} else {
				["Off"] call acex_fortify_fnc_handleChatCommand;
				systemChat "Fortify system disabled";
			};
		},{// On Cancel code
		},[
		// Arguments
		]
	] call zen_dialog_fnc_create
},
"za_framework\resources\icon_hammer.paa"
] call zen_custom_modules_fnc_register;
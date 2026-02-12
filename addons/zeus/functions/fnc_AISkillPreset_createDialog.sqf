#include "script_component.hpp"
/* File: fnc_AISkillPreset_createDialog.sqf
 * Author(s): riksuFIN
 * Description: Create GUI dialog for adjusting AI skill preset settings
 *
 * Local to: Caller
 * Parameter(s):
		NONE
 *
 Returns:
 *
 * Example:	[] call RAA_zeus_fnc_AISkillPreset_createDialog;
 */


private _skillPresetNumbers = [0, 1, 2, 3, 4, 5];
private _skillPresetNames = [
	["No change", "Do not change any AI Skill settings for this side. Retains settings previously written by any method"],
	["Untrained"],
	["Poorly trained"],
	["Trained"],
	["Experienced"],
	["Special Forces"]
];
private _toolTip_autoCombat = "Select if AI should be able to automatically switch to 'combat' mode\nRecommended to keep on most of time";
private _toolTip_lambsAI = "Enables LAMBS Danger mod's Unit effects. These include:\nentering buildings, the reaction state to combat, panicking and various other core LAMBS Danger FSM features.\n\nUsually should be kept enabled";
private _toolTip_lambsGroup = "Enables LAMBS Danger mod's Group AI, which handles tactical components of the mod;\ncalling for artillery, coordinated building assaults, hiding from tanks or airplanes, remanning static weapons, and additional levels of extra-group communication\n\nUsually should be kept enabled";
private _toolTip_lambsVehicle = "Allows disabling Lambs Danger mod's features for vehicles.\nDisables both AI and Group features for all vehicle crews of this side";



["AI SKILL- PRESET",
	[
		["COMBO",
			["BLUFOR Skill Preset",
				"Select desired skills preset for each side."
			],[
				_skillPresetNumbers,
				_skillPresetNames,
				RAA_zeus_AISkill_west_level select 0
			]
		],
		
		["TOOLBOX:ENABLED",
			["BLUFOR Auto-Combat",
				_toolTip_autoCombat
			],[
				RAA_zeus_AISkill_west_level select 1
			]
		],
		
		["TOOLBOX:ENABLED",
			["BLUFOR LAMBS Group AI",
				_toolTip_lambsGroup
			],[
				RAA_zeus_AISkill_west_level select 2
			]
		],
		
		["TOOLBOX:ENABLED",
			["BLUFOR LAMBS Unit AI",
				_toolTip_lambsAI
			],[
				RAA_zeus_AISkill_west_level select 3
			]
		],
		
		["TOOLBOX:ENABLED",
			["BLUFOR for vehicle crews",
				_toolTip_lambsVehicle
			],[
				RAA_zeus_AISkill_west_level select 3
			]
		],
		
		
		
		
		
		
		["COMBO",
			["OPFOR Skill Preset",
				"Select desired skills preset for each side."
			],[
				_skillPresetNumbers,
				_skillPresetNames,
				RAA_zeus_AISkill_east_level select 0
			]
		],
		
		["TOOLBOX:ENABLED",
			["OPFOR Auto-Combat",
				_toolTip_autoCombat
			],[
				RAA_zeus_AISkill_east_level select 1
			]
		],
		
		["TOOLBOX:ENABLED",
			["OPFOR LAMBS Group AI",
				_toolTip_lambsGroup
			],[
				RAA_zeus_AISkill_east_level select 2
			]
		],
		
		["TOOLBOX:ENABLED",
			["OPFOR LAMBS Unit AI",
				_toolTip_lambsAI
			],[
				RAA_zeus_AISkill_east_level select 3
			]
		],
		
		["TOOLBOX:ENABLED",
			["OPFOR for vehicle crews",
				_toolTip_lambsVehicle
			],[
				RAA_zeus_AISkill_east_level select 3
			]
		],
		
		
		["COMBO",
			["INDEPENDENT Skill Preset",
				"Select desired skills preset for each side."
			],[
				_skillPresetNumbers,
				_skillPresetNames,
				RAA_zeus_AISkill_ind_level select 0
			]
		],
		
		["TOOLBOX:ENABLED",
			["INDEPENDENT Auto-Combat",
				_toolTip_autoCombat
			],[
				RAA_zeus_AISkill_ind_level select 1
			]
		],
		
		["TOOLBOX:ENABLED",
			["INDEPENDENT LAMBS Group AI",
				_toolTip_lambsGroup
			],[
				RAA_zeus_AISkill_ind_level select 2
			]
		],
		
		["TOOLBOX:ENABLED",
			["INDEPENDENT LAMBS Unit AI",
				_toolTip_lambsAI
			],[
				RAA_zeus_AISkill_ind_level select 3
			]
		],
		
		["TOOLBOX:ENABLED",
			["INDEPENDENT for vehicle crews",
				_toolTip_lambsVehicle
			],[
				RAA_zeus_AISkill_ind_level select 3
			]
		]
	], {	
			
		//	_this call RAA_zeus_fnc_AISkillPreset_handleModule;
			_this call FUNC(AISkillPreset_handleModule);
			
	},
	{},	
	[	// Params
		
	]
] call zen_dialog_fnc_create;
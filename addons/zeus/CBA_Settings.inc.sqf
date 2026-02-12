/* File: CBA_Settings.sqf
 * Authors: riksuFIN
 * Description: Makes mod settings

 * Called from: 
 * Local to:
 * Unscheduled
 */

//https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#create-a-custom-setting-for-mission-or-mod

/* EXAMPLE
[
    "RAA_ViewDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "View Distance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Motti Misc: AI Skill Presets", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [200, 15000, 5000, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    nil, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        setViewDistance _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
*/



[
    "RAA_zeus_enableZeusMarkerFix", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable duck-tape fix for Zeus marker rotation", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Zeus"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		if (_this) then {
		//	[] execVM "\r\misc\addons\RAA_zeus\scripts\fixMapMarkers.sqf";
		//	execVM "\r\misc\addons\RAA_zeus\scripts\fixMapMarkers.sqf";
			call compile preprocessFileLineNumbers QPATHTOF(scripts\fixMapMarkers.sqf);
		};
		
    }, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_enableSideMarker", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable Side Relations Marker", "If enabled will show icon on top-left corner of screen detailing which side is hostile to which."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Zeus"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		if (_this) then {		// Add or remove EH for opening Zeus interface
			// We delay running fnc to ensure Zeus interface has time to load before we apply image to it
			GVAR(EH_displayLoaded) = ["zen_curatorDisplayLoaded", {
				[	{ 
						call FUNC(onZeusInterfaceOpen);
					},
					[],
					1
				] call CBA_fnc_waitAndExecute;
				
			}] call CBA_fnc_addEventHandler;
			
		} else {
			if !(isNil QGVAR(EH_displayLoaded)) then {
				
				["zen_curatorDisplayLoaded", GVAR(EH_displayLoaded)] call CBA_fnc_removeEventHandler;
				GVAR(EH_displayLoaded) = nil;
			};
		};
		
	},
	false	// needRestart flag
] call CBA_fnc_addSetting;






[
    "RAA_zeus_debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Zeus", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    }, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;




// Defaults for mission maker
private _presets = [0, 1, 2, 3, 4, 5];
private _presetsPretty = [
	"No chance",
	"Untrained",
	"Poorly trained",
	"Trained",
	"Experienced",
	"Special Forces"
];

private _nameCategory = "RAA: AI Skill Presets";
private _toolTip = "Set default preset to be used. Can be changed in-game by Zeus.\nMeant to be used by missin maker to pre-set approriate skills depending on mission.\n\nNOTE: Will overwrite any skill changes done in editor/ any other scripts!";

[
    "RAA_zeus_AISkill_masterEnabled", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable AISkills module", "If disabled no AI skills will be automatically changed. Zeus may still update skills for existing units, but new units will be unaffected."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 General"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    1, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    }, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;


[
    "RAA_zeus_AISkill_default_west", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    ["AI skill preset for West", _toolTip], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [	// Data for this setting
		_presets,	//  Values this setting can take. <ARRAY>
		_presetsPretty,	// Corresponding pretty names for the ingame settings menu. Can be stringtable entries. <ARRAY>
		0	// Index of the default value. Not the default value itself. <NUMBER>
	],
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    QGVAR(AISkill_default_crew_west), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Lambs enabled for WEST vehicles crews", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_east", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    ["AI skill preset for East", _toolTip], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [	// Data for this setting
		_presets,	//  Values this setting can take. <ARRAY>
		_presetsPretty,	// Corresponding pretty names for the ingame settings menu. Can be stringtable entries. <ARRAY>
		0	// Index of the default value. Not the default value itself. <NUMBER>
	],
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    QGVAR(AISkill_default_crew_east), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Lambs enabled for EAST vehicles crews", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_ind", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    ["AI skill preset for Independent", _toolTip], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [	// Data for this setting
		_presets,	//  Values this setting can take. <ARRAY>
		_presetsPretty,	// Corresponding pretty names for the ingame settings menu. Can be stringtable entries. <ARRAY>
		0	// Index of the default value. Not the default value itself. <NUMBER>
	],
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    QGVAR(AISkill_default_crew_ind), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Lambs enabled for INDEPENDENT vehicles crews", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "0 FOR MISSION MAKER: Default Preset"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;








// https://community.bistudio.com/wiki/Arma_3:_AI_Skill#Sub-Skills

RAA_zeus_AISkill_default_1_array = [];
// --------- Untrained ---------------------
[
    "RAA_zeus_AISkill_default_1_aimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Aiming Accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [0, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Aiming Shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [1, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Aiming Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [2, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Spotting Distance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [3, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Spotting Time", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [4, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [5, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true	// needRestart flag
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Reload Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [6, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: Commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [7, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_1_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "UNTRAINED: General", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "1 For Server Admin: Untrained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.25, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_1_array set [8, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;




// --------- POORLY TRAINED
RAA_zeus_AISkill_default_2_array = [];
[
    "RAA_zeus_AISkill_default_2_aimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Aiming Accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [0, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Aiming Shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [1, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Aiming Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [2, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Spotting Distance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [3, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Spotting Time", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [4, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [5, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Reload Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [6, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: Commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [7, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_2_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "POORLY TRAINED: General", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "2 Poorly Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.35, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_2_array set [8, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;





// ------------- TRAINED ------------------
RAA_zeus_AISkill_default_3_array = [];
[
    "RAA_zeus_AISkill_default_3_aimingAccuracy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Aiming Accuracy", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [0, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_aimingShake", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Aiming Shake", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [1, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_aimingSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Aiming Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [2, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_spotDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Spotting Distance", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [3, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_spotTime", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Spotting Time", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [4, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_courage", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Courage", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [5, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_reloadSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Reload Speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [6, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_3_commanding", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: Commanding", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [7, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;


[
    "RAA_zeus_AISkill_default_3_general", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "TRAINED: general", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [_nameCategory, "3 Trained"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 1, 0.45, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
		RAA_zeus_AISkill_default_3_array set [8, _this];
	}, // function that will be executed once on mission start and every time the setting is changed.
	true
] call CBA_fnc_addSetting;





// ----------------------- EXPERIENCED -----------------------------
RAA_zeus_AISkill_default_4_array = [];
[
    "RAA_zeus_AISkill_default_4_aimingAccuracy",
    "SLIDER", 
    "EXPERIENCED: Aiming Accuracy", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2],
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [0, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_aimingShake", 
    "SLIDER", 
    "EXPERIENCED: Aiming Shake", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true,
    {
		RAA_zeus_AISkill_default_4_array set [1, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_aimingSpeed",
    "SLIDER",
    "EXPERIENCED: Aiming Speed", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [2, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_spotDistance", 
    "SLIDER", 
    "EXPERIENCED: Spotting Distance",
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [3, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_spotTime", 
    "SLIDER", 
    "EXPERIENCED: Spotting Time", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2],
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [4, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_courage", 
    "SLIDER", 
    "EXPERIENCED: Courage", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [5, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_reloadSpeed",
    "SLIDER", 
    "EXPERIENCED: Reload Speed", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [6, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_commanding",
    "SLIDER", 
    "EXPERIENCED: Commanding", 
    [_nameCategory, "4 Experienced"],
    [0, 1, 0.6, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_4_array set [7, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_4_general", 
    "SLIDER", 
    "EXPERIENCED: General", 
    [_nameCategory, "4 Experienced"], 
    [0, 1, 0.6, 2], 
    true,
    {
		RAA_zeus_AISkill_default_4_array set [8, _this];
	},
	true
] call CBA_fnc_addSetting;









// ------------------------ SPECIAL FORCES ----------------
RAA_zeus_AISkill_default_5_array = [];
[
    "RAA_zeus_AISkill_default_5_aimingAccuracy", 
    "SLIDER", // setting type
    "SPECIAL FORCE: Aiming Accuracy", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true,
    {
		RAA_zeus_AISkill_default_5_array set [0, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_aimingShake", 
    "SLIDER", 
    "SPECIAL FORCE: Aiming Shake", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [1, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_aimingSpeed", 
    "SLIDER", 
    "SPECIAL FORCE: Aiming Speed", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [2, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_spotDistance", 
    "SLIDER", 
    "SPECIAL FORCE: Spotting Distance", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true,
    {
		RAA_zeus_AISkill_default_5_array set [3, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_spotTime", 
    "SLIDER", 
    "SPECIAL FORCE: Spotting Time", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [4, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_courage", 
    "SLIDER", 
    "SPECIAL FORCE: Courage", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2],
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [5, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_reloadSpeed", 
    "SLIDER", 
    "SPECIAL FORCE: Reload Speed", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [6, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_commanding", 
    "SLIDER", 
    "SPECIAL FORCE: Commanding", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2],
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [7, _this];
	},
	true
] call CBA_fnc_addSetting;

[
    "RAA_zeus_AISkill_default_5_general", 
    "SLIDER", 
    "SPECIAL FORCE: General", 
    [_nameCategory, "5 Special Force"], 
    [0, 1, 0.75, 2], 
    true, 
    {
		RAA_zeus_AISkill_default_5_array set [8, _this];
	},
	true
] call CBA_fnc_addSetting;








/* File: CBA_Settings.sqf
 * Authors: riksuFIN
 * Description: Makes mod settings

 * Called from: config.cpp/ XEH_preInint
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
    "RAA_ACEA_debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: ACE-A", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    }, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;



[
    QGVAR(arsenal_overview), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Show Items Overview in ACE Arsenal", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Arsenal"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;
[
    QGVAR(arsenal_overview_disableZeros), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Hide item count with unique items", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Arsenal"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;
/*
[
    QGVAR(arsenal_overview_textScale), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Font size scale", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Arsenal Overview"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.1, 5, 1, 1],	// Min, max, default, digits
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;
*/
[
	QGVAR(arsenal_description), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"CHECKBOX", // setting type
	"Show Items Description in ACE Arsenal", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	["RAA", "Arsenal"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true, // data for this setting (Default value)
	0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
	{
		/*
		if (_this) then {
			GVAR(arsenal_description_EH) = ["ace_arsenal_displayStats", {
				_this call FUNC(arsenal_description);
			}] call CBA_fnc_addEventHandler;
		} else {
			if !(isNil QGVAR(arsenal_description_EH)) then {
				["ace_arsenal_displayStats", GVAR(arsenal_description_EH)] call CBA_fnc_removeEventHandler;
				GVAR(arsenal_description_EH) = nil;
			};
		};
		*/
		
	}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;


//========== Fabric tearing from uniform ==================
[
    QGVAR(tearFrabric_enable), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable", "Enables ability to tear fabric from uniforms."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Tear Fabric from Uniform"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

[	QGVAR(tearFrabric_disableUniformDestruction), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Disable uniform destruction", "Enables ability to tear fabric from uniforms."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Tear Fabric from Uniform"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {}, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

[
    QGVAR(tearFrabric_tearingTimesUntilDepleted), 
    "SLIDER",
	 ["Fabric Tearing Times", "How many pieces of fabric can be torn off from single uniform. Note: Changing uniform does not reset this counter!"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	 ["RAA", "Tear Fabric from Uniform"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 30, 8, 0],	// Min, max, default, digits
    false, 
   {
		GVAR(tearFrabric_tearingTimesUntilDepleted) = round _this;
	},
	false
] call CBA_fnc_addSetting;
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
    "RAA_ACEA_defibSuccessChance", 
    "SLIDER", 
    "Defibrillator Success Chance", 
    ["RAA", "ACE Additions"], 
    [0.1, 1, 0.9, 2, true],
    false, 
    {},
	false
] call CBA_fnc_addSetting;

[
    "RAA_ACEA_AEDSuccessChance", 
    "SLIDER", 
    "AED Success Chance", 
    ["RAA", "ACE Additions"], 
    [0.1, 1, 0.9, 2, true],
    false, 
    {},
	false
] call CBA_fnc_addSetting;


[
    "RAA_ACEA_addItemToMedic_defib", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    ["Add item to player medic on spawn", "Note: Will not add item if it already exists. Waits for 8 seconds for other scripts to spawn item"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "ACE Additions"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [	// data for this setting
		[0, 1, 2],
		["None", "Defibrillator", "AED"],
		0	// Default
	], 
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    }, // function that will be executed once on mission start and every time the setting is changed.
	 true	// Requires restart flag
] call CBA_fnc_addSetting;

[
    "RAA_ACEA_addItemToMedic_naloxone", 
    "SLIDER", 
    "Add number of Naloxone to medics", 
    ["RAA", "ACE Additions"], 
    [0, 10, 0, 0],	// Min, max, default, digits
    false, 
    {},
	false
] call CBA_fnc_addSetting;

[
    QGVAR(painkiller_useTime), 
    "SLIDER", 
    "Painkillers time to use", 
    ["RAA", "ACE Additions"], 
    [3, 20, 5, 0],	// Min, max, default, digits
    false, 
    {},
	false
] call CBA_fnc_addSetting;




[
    "RAA_ACEA_debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Medical", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    }, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentFeedback), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable Treatment Feedback", "Allow notifications to unscoscious people whenever they're being treated, to let them know they're not forgotten."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "ACE Additions"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		if (_this) then {
			// Whenever someone is treating someone let them know
			GVAR(treatmentFeedback_eh) = ["ace_treatmentStarted", FUNC(treatmentFeedback_helper)] call CBA_fnc_addEventHandler;
		} else {
			if !(isNil QGVAR(treatmentFeedback_eh)) then {
				["ace_treatmentStarted", GVAR(treatmentFeedback_eh)] call CBA_fnc_removeEventHandler;
				GVAR(treatmentFeedback_eh) = nil;
				if (GVAR(debug)) then {systemChat "[RAA_ACEA] Removed EventHandler 'ace_treatmentStarted'";};
			};
		};
	 }, // function that will be executed once on mission start and every time the setting is changed.
	false	// needRestart flag
] call CBA_fnc_addSetting;

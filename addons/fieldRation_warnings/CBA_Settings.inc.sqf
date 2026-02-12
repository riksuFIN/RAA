/* File: CBA_Settings.sqf
 * Authors: riksuFIN
 * Description: Makes mod settings

 * Called from: config.cpp/ XEH_preInint
 * Local to: 
 * Unscheduled
 */

//https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#create-a-custom-setting-for-mission-or-mod


//  Master Switch for FieldRation Warnings
[
    "RAA_FRW_MasterEnable", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable Field Ration Warnings", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		[{time > 10 && !(isNull player)}, {	// Wait untill mission starts and start main loop
			[] call FUNC(startLoop);
		}] call CBA_fnc_waitUntilAndExecute;
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[
    "RAA_FRW_hungerWarningTreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["HUNGER: First treshold", "How hungry one must be before first warnings appear"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [30, 70, 50, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[	// Enable hunger sounds 
    "RAA_FRW_enableHungerSound", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "HUNGER: Enable Sounds", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;



[	// Enable hunger text warnings
    "RAA_FRW_HungerVisualWarningType", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "HUNGER: Enable Visual Effects", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [		// data for this setting
		 [0,1,2,3],		// Values
		 ["None","Text","Visual", "Both"],	// Pretty names
		 3		// Default index
	 ], 
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[
    "RAA_FRW_thirstWarningTreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "THIRST: Treshold", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [30, 70, 50, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {  
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;

[	// Enable thirst sound
    "RAA_FRW_enableThirstSound", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "THIRST: Enable Sounds", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[	// Enable hunger text warnings
    "RAA_FRW_ThirstVisualWarningType", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "THIRST: Enable Visual Effects", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [		// data for this setting
		 [0,1,2,3],		// Values
		 ["None","Text","Visual", "Both"],	// Pretty names
		 3		// Default index
	 ], 
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;




[
    "RAA_FRW_SoundCoolDown", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Cooldown between sounds", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 600, 120, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {  
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[
    "RAA_FRW_textCoolDown", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Cooldown between text/ Visual", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 300, 120, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {  
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[	// 
    "RAA_FRW_sharedSounds", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Make sounds global", "If enabled those near you can hear you stomach growling"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Field Ration Warnings"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {  
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[	// DEBUG
    QGVAR(debug), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Fieldration Warnings", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {  
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
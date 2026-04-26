/* File: CBA_Settings.sqf
 * Authors: riksuFIN
 * Description: Makes mod settings

 * Called from: config.cpp/ XEH_preInint
 * Local to: 
 * Unscheduled
 */

//https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#create-a-custom-setting-for-mission-or-mod

[	
    QGVAR(debug), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Console", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0 // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

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
    "My Mission Settings", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [200, 15000, 5000, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    nil, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        setViewDistance _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
*/

[
	QGVAR(enabled),
	"CHECKBOX",
	["Enable Belt Slot", "Allow using belt to carry up to two items or magazines in inventory."],
	["RAA", "Belt Slot"],
	true, // data for this setting (Default value)
	0 // "_isGlobal" flag.
] call CBA_fnc_addSetting;

[
    QGVAR(autoMoveBottlesToBelt), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Auto-move bottles to belt", "Automatically moves water bottle/ canteen to Belt Slots on mission start"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Belt Slot"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		 
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;

[	
    QGVAR(debug), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: BeltSlot", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;



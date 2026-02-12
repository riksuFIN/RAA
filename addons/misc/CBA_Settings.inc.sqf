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
    "RAA_misc_hideACEUnjamming", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Hide ACE Weapon Unjamming Action", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "General"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[
    "RAA_misc_requireFacePaintItem", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Facepaint: Require item", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "General"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[
    "RAA_misc_disableShiftClickOnMap", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Disable Shift-click Waypoint creation on map", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "General"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		if (_this) then {
			onMapSingleClick {_shift};
		};
    }, // function that will be executed once on mission start and every time the setting is changed.
	 true
] call CBA_fnc_addSetting;

/*		DISABLED untill feature is finished, for now hard-disabled in XEH_postInit
[
    QGVAR(windAffectWalking), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Strong wind affects walking speed", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "General"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		if (_this && hasInterface) then {
			[player] call FUNC(windAffectWalkingLoop)
		};
    }
] call CBA_fnc_addSetting;
*/
[
    "RAA_misc_woodCuttingTime_axe", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Tree cutting time: Axe", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Tree Cutting"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [1, 120, 30, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
[
    "RAA_misc_woodCuttingTime_shovel", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Tree cutting time: Field Shovel", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Tree Cutting"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [1, 120, 50, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
[
    "RAA_misc_woodCuttingTime_chainsaw", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Tree cutting time: Chainsaw", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Tree Cutting"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [1, 120, 14.5, 1], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;


[	// ==================== DAMAGEABLE ITEMS ====================================================
    QGVAR(damageableItems_enabled), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable Damageable Inventory Items", "If enabled certain inventory items may be damaged if taking damage"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Damageable Inventory Items"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
   {	// function that will be executed once on mission start and every time the setting is changed.
		if (hasInterface) then {
			if (_this) then {
				// Setting was enabled
				GVAR(damageableItems_EH) = player addEventHandler ["HandleDamage", {
			//	GVAR(damageableItems_EH) = player addEventHandler ["Hit", {		10.11.24
					call FUNC(damageableItems_onHit);
					nil
				}];
			} else {
				// This setting was disabled, delete EH if there is one
				if !(isNil QGVAR(damageableItems_EH)) then {
					player removeEventHandler ["HandleDamage", GVAR(damageableItems_EH)];
					GVAR(damageableItems_EH) = nil;
				};
			};
		};
	}
] call CBA_fnc_addSetting;
[
    QGVAR(damageableItems_chance),
    "SLIDER",
    ["Chance for items taking damage", "in percent"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Damageable Inventory Items"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [0.01, 100, 2, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
[
    QGVAR(damageableItems_headgearChance), 
    "SLIDER",
    ["Chance for helmets being knocked off", "in percent\n\nTFN mod's helmets that have their chinbands open will have this value *2"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Damageable Inventory Items"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [0.01, 100, 5, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
[
    QGVAR(damageableItems_chance_weapon),
    "SLIDER",
    ["Chance for weapon to be hit", "Causes a jam, never a complete weapon failure"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Damageable Inventory Items"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
   [0.01, 100, 3, 0], // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;



[	// ================================ SPAWN AI ADDITIONAL GEAR =========================
    QGVAR(AI_spawnWater_enabled),
    "CHECKBOX",
    ["Add water to AI units", "Automatically spawns one or two water bottles of given types to all AI units"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "AI Additional Gear"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
   {	// function that will be executed once on mission start and every time the setting is changed.
	}
] call CBA_fnc_addSetting;

/*  REMOVED in 2.00 to go with items drawn directly from cfg
[	QGVAR(AI_spawnWater_itemTypes),
    "Editbox",
    ["Spawnable items","ARRAY of Classnames to be spawned. Items are randomly selected from this list. \nHeavily weighted torwards first few enties\n\nMUST be Array of Strings. Make sure format is correct, otherwise will throw error!"],
    ["RAA", "AI Additional Gear"],
    "['ACE_Canteen','ACE_Canteen','ACE_WaterBottle','ACE_Can_Franta','ACE_Can_RedGull','ACE_MRE_LambCurry','ACE_MRE_BeefStew','ACE_Humanitarian_Ration','ACE_Canteen_Half','ACE_WaterBottle_Half','RAA_sodaBottle','ACE_Can_Spirit','RAA_Can_ES','RAA_sodaBottle_half','RAA_bottle_whiskey','RAA_Can_beer','ACE_MRE_MeatballsPasta','ACE_MRE_ChickenTikkaMasala','RAA_sodaBottle_mixed','RAA_Can_Beer_AlcoholFree','RAA_bottle_whiskey_75','RAA_bottle_whiskey_50','RAA_bottle_whiskey_25']",
    1,
    {
		// Since CBA settings returns string we need to parse it for functions
//        [_this] param [_input, ['ACE_Canteen','ACE_Canteen','ACE_WaterBottle','ACE_Can_Franta','ACE_Can_RedGull','ACE_MRE_LambCurry','ACE_MRE_BeefStew','ACE_Humanitarian_Ration','ACE_Canteen_Half','ACE_WaterBottle_Half','RAA_sodaBottle','ACE_Can_Spirit','RAA_Can_ES','RAA_sodaBottle_half','RAA_bottle_whiskey','RAA_Can_beer','ACE_MRE_MeatballsPasta','ACE_MRE_ChickenTikkaMasala','RAA_sodaBottle_mixed','RAA_Can_Beer_AlcoholFree','RAA_bottle_whiskey_75','RAA_bottle_whiskey_50','RAA_bottle_whiskey_25'], [""]];

		GVAR(AI_spawnWater_itemTypes) = parseSimpleArray _this;
		
		// Put together weights array to go with items. Used to determine chance of each items spawning
		private _randomness = 1;
		private _weights = [];
		for "_i" from 0 to (count GVAR(AI_spawnWater_itemTypes)) do {
			_randomness = _randomness * 0.9 max 0.05;
			_weights pushBack _randomness;
		};
		GVAR(AI_spawnWater_itemTypes_weights) = _weights;
	}
] call CBA_fnc_addSetting;
*/
[	// ================================ Whistling =========================
    QGVAR(whistling_enabled),
    "CHECKBOX",
    ["Enable Whistling","This removes or enables whistling option in ACE Self-Interaction Menu"],
    ["RAA", "Whistling"],
    true,
    0,
    {}
] call CBA_fnc_addSetting;


[	
    "RAA_misc_debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Misc", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {
		
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;





if (["RAA_isMotti"] call ace_common_fnc_isModLoaded) then {
	// TIMEOUT REMINDERS
	[	"RAA_misc_zafw_timeOutReminder_enabled", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"CHECKBOX", // setting type
		"Enabled", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		false, // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{
		} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;

	[	"RAA_misc_zafw_timeOutReminder_firstWarning", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"SLIDER", // setting type
		"First reminder: Minutes after mission start", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		[1, 120, 10, 0], // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{
		} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;

	[	"RAA_misc_zafw_timeOutReminder_firstWarning_jip", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"SLIDER", // setting type
		["First reminder delay IF countdown was delayed", "Countdown will be delayed if there are too few players present at start of mission"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		[1, 120, 5, 0], // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{
		} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;


	[	"RAA_misc_zafw_timeOutReminder_firstWarning_text", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"EDITBOX", // setting type
		"First reminder: Text", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		"Time for Zeus briefing!", // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{
		} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;

	[
	    "RAA_misc_zafw_timeOutReminder_secondWarning", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	    "SLIDER", // setting type
	    ["Second reminder: Minutes after mission start", "There will be additional warnings 5 and 2 minutes before this time."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	    ["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
	    [6, 120, 25, 0], // data for this setting (Default value)
	    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
	    {} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;

	[
	    "RAA_misc_zafw_timeOutReminder_secondWarning_jip", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	    "SLIDER", // setting type
	    ["Second reminder if countdown delayed", "There will be additional warnings 5 and 2 minutes before this time."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	    ["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
	    [6, 120, 20, 0], // data for this setting (Default value)
	    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
	    {} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;

	[	"RAA_misc_zafw_timeOutReminder_secondWarning_text_5", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"EDITBOX", // setting type
		"Second reminder: 5 minutes remaining text", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		"5 minutes of preparation time remaining!", // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;
	[	"RAA_misc_zafw_timeOutReminder_secondWarning_text_2", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"EDITBOX", // setting type
		"Second reminder: 2 minutes remaining text", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		"2 minutes of preparation time remaining!", // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;
	[	"RAA_misc_zafw_timeOutReminder_secondWarning_text_now", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
		"EDITBOX", // setting type
		"Second reminder: Timeout text", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
		["RAA", "Timeout Reminders"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
		"Preparation time is over!", // data for this setting (Default value)
		0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
		{} // function that will be executed once on mission start and every time the setting is changed.
	] call CBA_fnc_addSetting;
};	// End of isMotti
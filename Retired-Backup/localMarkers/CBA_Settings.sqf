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



[	// ==================== LOCAL MARKERS ====================================================
    QGVAR(enabled), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable Local Markers", "Disables magic sharing of map markers over all players, essentially isolating each player's maps."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Local Markers"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
   {	// function that will be executed once on mission start and every time the setting is changed.
		if (hasInterface) then {
			if (_this || GVAR(privateChannel_enabled)) then {
				// Setting was enabled
				// Delay execution untill we're actullay in-game
				[	{		// Condition
						getClientStateNumber >= 10 || getClientStateNumber isEqualTo 0		// 0: SP, 10: "Briefing read"
					}, {	// Code
						GVAR(EH_created) = addMissionEventHandler  ["MarkerCreated", {
							call FUNC(markerCreated);
							nil
						}];
					}, [	// Params
					],		// Timeout
						9999,
					{		// Timeout code
					}
				] call CBA_fnc_waitUntilAndExecute;
				
			} else {
				// This setting was disabled, delete EH if there is one
				if !(isNil QGVAR(EH_created)) then {
					removeMissionEventHandler ["MarkerCreated", GVAR(EH_created)];
				//	removeMissionEventHandler ["MarkerDeleted", GVAR(EH_deleted)];
					GVAR(EH_created) = nil;
				};
			};
		};
	}
] call CBA_fnc_addSetting;
[
	QGVAR(channelOverride), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"LIST", // setting type
	["Override Channel", "Select a channel where placed markers are always global, essentially ignored by this function."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	["RAA", "Local Markers"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
	[// data for this setting
		[-99, 0, 1, 3, 4],	// Setting return values
		["Disabled", "Global  Chat", "Side Chat", "Group Chat", "Vehicle Chat"],	// Pretty names for values
		0		// Default value index
	], 
	0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
	{	// function that will be executed once on mission start and every time the setting is changed.
	}
] call CBA_fnc_addSetting;

[
    QGVAR(privateChannel_enabled), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Enable Private Channel", "Adds a new chat channel which can be used to privately create markers which nobody else will ever see and will never be copied to others maps."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Local Markers"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    1, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
   {	// function that will be executed once on mission start and every time the setting is changed.
	},
	true	// Requires restart -flag
] call CBA_fnc_addSetting;
[
    QGVAR(directChatOverride), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Direct Channel as Override", "If enabled any markers created on Direct channel will be ignored by this feature. This allows for anyone nearby to immediately see created markers (they're watching over your shoulder!)."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Local Markers"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
   {	// function that will be executed once on mission start and every time the setting is changed.
	},
	true	// Requires restart -flag
] call CBA_fnc_addSetting;







[	
    QGVAR(debug), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Debug: Local Markers", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    ["RAA", "Debug"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting (Default value)
    0, // "_isGlobal" flag. Set this to 1 to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;



#include "script_component.hpp"
/* File: fnc_babel_createDialog_addLanguage.sqf
 * Author(s): riksuFIN
 * Description: Creates dialog for adding new Babel speakable language
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_zeus_fnc_babel_createDialog_addLanguage
*/

if !(["acre_main"] call ace_common_fnc_isModLoaded) exitWith {};


private _existingLanguages = "";
{
	_existingLanguages = _existingLanguages + (_x select 1) + ", "
} forEach acre_sys_core_languages;

["BABEL MISSION SETUP: Add Language",	// Dialog Title
	[	
		["EDIT:MULTI",
			["INFO",
				""
			],[
				parseText "Add new language speakable in this scenario.<br/>Who actually can speak this will be defined at later stage.<br/><br/>One language at time, enter desired (visible) name for language in bottom-most box, then hit 'accept'.<br/>Repeat until all languages are added, then press 'cancel' to proceed to next step.",
				{},
				7
			],
			true	// Force default
		],
		["EDIT:MULTI",
			["Already added languages:",
				"This is a list of all languages already speakable in mission.\nIt is not possible to delete these."
			],[
				parseText _existingLanguages,
				{
					private _existingLanguages = "";
					{
						_existingLanguages = _existingLanguages + (_x select 1) + ", "
					} forEach acre_sys_core_languages;
					_existingLanguages
				},
				3
			],
			true	// Force default
		],
		["EDIT",
			["New Language",
				"What should new language be called?\nExamples: English, Russian, Finnish\n\nOnly one language at time!"
			],[
				""
			],
			true	// Force default
		]
		
	], {	// Code to execute upon pressing OK
		params ["_dialogValues"];
		_dialogValues params ["","", "_newLanguageName"];
		if (_newLanguageName isNotEqualTo "") then {
			private _newID = count acre_sys_core_languages + 1;	// Use number of existing languages as ID.
			
			[
				str _newID,
			//	_newLanguageName,
				_newLanguageName
			] remoteExec ["acre_api_fnc_babelAddLanguageType", [0, -2] select isDedicated];
		};
		
		// Re-open this interface for next language. Wait untill language is registered
		[	{		// Condition
				count acre_sys_core_languages isEqualTo _this
			}, {	// Code
				call FUNC(babel_createDialog_addLanguage)
			}, 	// Params
				(count acre_sys_core_languages + 1)
			,		// Timeout
				5,
			{		// Timeout code
				systemChat "[WARNING] Language failed to register in time."
			}
		] call CBA_fnc_waitUntilAndExecute;
		
		
	//	[{call FUNC(babel_createDialog_addLanguage)}] call CBA_fnc_execNextFrame;
		
	},
	{	// On Cancel
		params ["_dialogValues"];
		_dialogValues params ["","", "_newLanguageName"];
		if (_newLanguageName isNotEqualTo "") then {
			private _newID = count acre_sys_core_languages + 1;	// Use number of existing languages as ID.
			[
				str _newID,
				//_newLanguageName,
				_newLanguageName
			] remoteExec ["acre_api_fnc_babelAddLanguageType", [0, -2] select isDedicated];
		};
		
	},	
	[	// Arguments
	]
] call zen_dialog_fnc_create;



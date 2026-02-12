#include "script_component.hpp"
/* File: fnc_createDialog_doArtilleryFire.sqf
 * Author(s): riksuFIN
 * Description: Create dialog for selecting settings of firing MLRS/ arty
 *
 * Called from: Zeus module
 * Local to:	
 * Parameter(s):
 * 0:	Object
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/

params [["_object", objNull]];




//private _config = getText (configFile >> "CfgAmmo" >> _object);

// Prep all avaiable ammo types for this
private _content = [];
private _contentPretty = [];
private _ammoName = "";
{
	
//	_ammoName = getText (configFile >> "CfgVehicles" >> "Thing" >> "icon");
	_ammoName = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
	_content pushBack _x;
	_contentPretty pushBack _ammoName;
	
} forEach (getArtilleryAmmo [_object]);





["FIRE MLRS/ RAPID ARTILLERY",
	[ // CONTENT
		["LIST",
			["Ammo to be fired",
				""
			],[
				_content,
				_contentPretty,
				0,
				6
			],
			false	// Force default
		],
		
		["SLIDER",
			["Number of rounds to be fired",
				"Unit will only fire rounds equal to one magazine OR this value, whichever is lower"
			],[
				1,
				40,
				10,
				0
			],
			false	// Force default
		],
		
		["CHECKBOX",
			["Refill ammo",
				"Refill unit's ammmo before fire mission"
			],[
				false
			],
			false	// Force default
		],
		
		["SLIDER",
			["Delayed barrage start",
				""
			],[
				0,
				3600,
				0,
				{
					if (_this isEqualTo 0) then {
						"INST"
					} else {
						[_this, "MM:SS"] call BIS_fnc_secondsToString
					}
				}
			],
			false	// Force default
		]
	
	], { // ON CONFIRM CODE
	//	params ["_dialogValues", "_object"];
		 
		/*
		[	{
				_this call FUNC(handleDialog_doArtilleryFire);
			}, [
				_this
			],
			_this select 0 select 3
		] call CBA_fnc_waitAndExecute;
		*/
		_this call FUNC(handleDialog_doArtilleryFire);
		
		
	},{	// On cancel code
		
	},	// Arguments
		_object
	
] call zen_dialog_fnc_create;

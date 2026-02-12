#include "script_component.hpp"
/* File: fnc_createDialog_editGun.sqf
 * Author(s): riksuFIN
 * Description: Create GUI dialog for adjusting AI skill preset settings
 *
 * Local to: Caller
 * Parameter(s):
	1: side ID
	2: Position ASL where new battery should be located
 *
 Returns:
 *
 * Example:	[0, getPos player] call RAA_firesA_fnc_createDialog_editGun
*/
params ["_sideID", "_pos"];
 

private _gunsArray = [];
private _gunsArrayRAA = [];
switch (_sideID) do {
	case (0): {
		_gunsArray = tun_firesupport_guns_east;
		_gunsArrayRAA = RAA_firesA_gunTypes_east;
	 };
	case (1): {
		_gunsArray = tun_firesupport_guns_west;
		_gunsArrayRAA = RAA_firesA_gunTypes_west;
	};
	case (2): {
		_gunsArray = tun_firesupport_guns_resistance;
		_gunsArrayRAA = RAA_firesA_gunTypes_resistance;
	};
	case (3): {
		_gunsArray = tun_firesupport_guns_civilian;
		_gunsArrayRAA = RAA_firesA_gunTypes_civilian;
	};
};





private _dialog_values = [];
private _dialog_prettyValues = [];
private _tooltip = "";	// Declaring it here insteant of inside loop because apparently more effecient this way
{
	_dialog_values pushBack _forEachIndex;
	
	if ((_x select 0) isNotEqualTo "NONE") then {
		
		// Put together data about gun for tooltip
		private _toolTip = format [
			"Response Delay: %1 sec\nRate of Fire: %2 rpm\nRange: %3 m - %4 km\nDefault ammo per unit: %5 rounds",
			_x select 2,		// Response Time
			60 / (_x select 3),	// ROF
			_x select 5,		// Range min
			(_x select 6) / 1000,	// Range max
			_x select 7			// Default ammo per unit
		];
		
		
		_dialog_prettyValues pushBack [_x select 1 select 0, _toolTip, getText (configFile >> "CfgVehicles" >> (_x select 0) >> "picture"), _x select 1 select 1];
		
		
	} else {
		_dialog_prettyValues pushBack ["NONE", "Delete this gun"];
	};
} forEach RAA_firesA_artyTypeSettings;


/* This is how these arrays should look like
tun_firesupport_guns_resistance = ["gunModule1","gunModule2"];
RAA_firesA_gunTypes_civilian = [1, 2];

*/



// Create dialog with 5 slots for artillery by looping
private _content = [];
for "_i" from 0 to 4 do {
	
//	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] CreateDialog: %1", _gunsArrayRAA param [_i, 0]];};
	_content pushBack ["COMBO",
			[(format ["=== Battery %1: Type", _i + 1]), "Burst: Unit firing as fast as possible. Usually limited to 3 (or so) rounds before slowing down, but due to technical limitations this slowdown is not possible.\nTherefore it is recommended to limit Burst unit's ammo to avoid players exploiting its greater rate of fire by using more rounds than realistically possible"],
			[
				_dialog_values,
				_dialog_prettyValues,
				_gunsArrayRAA param [_i, 0]
			],
			true
		];
		
		_content pushBack ["EDIT",
		[(format ["Battery %1: Callsign", _i + 1]), "This is name shown in Fire Support Tablet.\nMUST be unique"],
			[
			//	(format ["Hammer-%1", _i + 1]),	// Default text
				(_gunsArray param [_i, objNull]) getVariable ["displayName", (format ["Hammer-%1", _i + 1])],	// Default text
				{}		// Sanitazing fnc
			],
			true	// Force default
		];
		
		_content pushBack ["SLIDER",
		[(format ["Battery %1: Number of guns", _i + 1]), "How many guns are in this battery"],
			[
				1,		// Min value
				10,	// Max value
				(_gunsArray param [_i, objNull]) getVariable ["gunCount", 1],	// Default value
			
				0		// how many decimals
			],
			true	// Force default
		];
	
};
/*
_content pushBack ["TOOLBOX:YESNO",
["Create map marker for guns", "Whether to mark location of guns with map marker or not"],
	[
		true
	],
	false	// Force default
];
*/






// Create actual dialog
["Artillery Batteries Add/ Edit",
	_content,
	
	{ // ON CONFIRM CODE
	//(_this select 0) params ["_dialog0", "_dialog1", "_dialog2", "_dialog3", "_dialog4"];
	(_this select 1) params ["_sideID", "_module_pos"];
	
	if (RAA_firesA_debug) then {systemChat format ["[RAA_firesA] remoteXec'd handleDialog with %1", _this];};
//	[_this select 0, _sideID, _module_pos, true] call RAA_firesA_fnc_handleDialog_editGun;
	[_this select 0, _sideID, _module_pos, true] call FUNC(handleDialog_editGun);
	
	
 },{	// On cancel code
 },[	// Arguments
	_sideID,
	_pos
 ]
] call zen_dialog_fnc_create;
#include "script_component.hpp"
/* File: fnc_createDialog_selectConvoy.sqf
 * Author(s): riksuFIN
 * Description: Called from various Zeus modules to select if player wants to
 					create new convoy or modify one of existing ones
 *
 * Called from: Zeus module
 * Local to:	Client
 * Parameter(s): NONE
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/

params ["_functionToCall"];

private _allConvoys = [objNull];
private _allConvoysPretty = ["Create a new convoy"];

{
	_allConvoys pushBack _x;
	_allConvoysPretty pushBack (_x getVariable ["convoyName", "ERROR: NO CONVOY NAME"]);
	
} forEach GVAR(allConvoys);



["Select convoy",
	[ // CONTENT
		["LIST",
			["Select convoy to modify", "Select what existing convoy you want to modify or create a new one"],
			[	_allConvoys,
				_allConvoysPretty,
				0,
				6
			],
			false	// Force default
		]
		
		
	], { // ON CONFIRM CODE
		
		(_this select 1) params ["_functionToCall", "_passThroughParams"];
		[_this select 0 select 0, _passThroughParams] call _functionToCall;
		
		if (GVAR(debug)) then {systemChat format ["[RAA] SelectConvoy. Params: %1", _this];};
		
		
	//	(_this select 0) call FUNC(handleDialog_initConvoy);
		
	},{	// On cancel code
		
	},	// Arguments
	[
		_functionToCall
	]
] call zen_dialog_fnc_create;



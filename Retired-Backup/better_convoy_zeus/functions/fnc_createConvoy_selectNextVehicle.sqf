#include "script_component.hpp"
/* File: fnc_createConvoy_selectNextVehicle.sqf
 * Author(s): riksuFIN
 * Description: Handles selecting vehicles of convoy as part of convoy's creation
 *
 * Called from: Zeus module / itself (loop)
 * Local to:	Client
 * Parameter(s):
 * 0:	Status <ANY>	Used to convey to script what to do. True or 0 to add new vehicle, 1 to finish convoy, 2 to cancel cnv creation
 * 1:	Object to add to convoy <OBJECT>		Only used if above params is true or 0
 * 2:	Position (Not used) <LOCATION (Array)>
 * 3:	Arguments (See below) <ARRAY>
 * 4:	Shift
 * 5:	Ctrl
 * 6:	Alt
 
 	Params (in above):
	 * 0:	Convoy logic <OBJECT>	Logic object where convoy settings are saved
	 * 1:	Name of convoy <STRING>	Name given by zeus for his reference only
	 * 2:	Vehicles in convoy <ARRAY>
 *
 Returns: Nothing
 *
 * Example:	
 *	[] call RAA_better_convoy_zeus_fnc_createConvoy_selectNextVehicle
*/

params ["_status", "_object", "", "_arguments"];
_arguments params ["_convoyLogic", "_convoyName", ["_vehicles", []]];

if (GVAR(debug)) then {systemChat format ["[RAA] %1", _this]; RAA_debug = _this};


if (_status isEqualTo 2) exitWith {
	// Zeus selected "Cancel" in status selection dialog
	systemChat format ["Creation of convoy %1 cancelled", _convoyName];
	deleteVehicle _convoyLogic;
	titleText ["", "PLAIN DOWN"];
};



if (_status isEqualTo 1) exitWith {
	// Zeus selected "Finish" in status selection dialog
	
	if (GVAR(debug)) then {systemChat format ["[RAA] Convoy %1 was finished with %2 vehicles: %3", _convoyName, count _vehicles, _vehicles];};
	
	[_convoyLogic, _vehicles] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf";
	
	
};




// Trying to add a new vehicle to convoy
if (_status isEqualTo true) then {
//	if ((isNull _object) || (_object in _vehicles) || !(alive _object)) then {
	if ((_object in _vehicles) || !(alive _object)) then {
		
		// Bad vehicle was provided
			private _text = "Invalid object. What do you wish to do?";
			if (isNull _object) then {
				_text = "No suitable vehicle selected. What do you wish to do?";
			} else {
				if (_object in _vehicles) then {
					_text = "Vehicle was already selected. What do you wish to do?";
				};
			};
			
			// TODO: Add Zeus "interrupted" sound effect here
			
		["SELECT ACTION",
			[ // CONTENT
				["TOOLBOX",
				_text,
					[
					0,	//	0: Default value <BOOL|NUMBER>
					3,	//	1: Number of rows <NUMBER>
					1,	//	2: Number of columns <NUMBER>
					["Add another vehicle", "Finish convoy creation", "Cancel convoy creation"]	//	3: Option names <ARRAY>
					]
				]
				
				
			], { // ON CONFIRM CODE
				[_this select 0 select 0, objNull, nil, _this select 1] call FUNC(createConvoy_selectNextVehicle);
				
				if (GVAR(debug)) then {systemChat format ["[RAA] Convoy Creation confirmation box. Params: %1", _this];};
				
			},{	// On cancel code
				[2, objNull, nil, _this select 1] call FUNC(createConvoy_selectNextVehicle);	// Cancel convoy creation
			},[	// Arguments
				_arguments
			]
		] call zen_dialog_fnc_create;
		
	} else {
		// Good vehicle was provided, let's add it to convoy
		
		_vehicles pushBack _object;
		
		if (GVAR(debug)) then {systemChat format ["[RAA] %1 added to convoy %2", _object, _convoyName];};
		
	};
};



// Put together instructions for zeus
private _numberOfVehicles = count _vehicles;
private _feedbackText = "";

switch (_numberOfVehicles) do {
	case (0): {
		_feedbackText = "Please select lead vehicle for convoy\nPathfinding capability of this vehicle is paramount for entire convoy's success";
	};
	case (1): {
		_feedbackText = "Select 2nd vehicle for convoy\nOr press esc to finish convoy creation";
	};
	case (2): {
		_feedbackText = "Select 3rd vehicle for convoy\nOr press esc to finish convoy creation";
	};
	default {
		_feedbackText = format ["Select %1th vehicle for convoy\nOr press esc to finish convoy creation"];
	};
};

titleText [_feedbackText, "PLAIN DOWN"];


[	player, 	// Fnc to call
	{
		//	_this spawn {[{_this call RAA_better_convoy_zeus_fnc_createConvoy_selectNextVehicle}, _this] call CBA_fnc_execNextFrame;};
		[{_this call FUNC(createConvoy_selectNextVehicle)}, [_this]] call CBA_fnc_execNextFrame;
		
	},
//	call FUNC(createConvoy_selectNextVehicle),
	[	// Arguments
		_convoyLogic,
		_convoyName,
		_vehicles
	], 
	"Select Next vehicle"
	
] call zen_common_fnc_selectPosition;


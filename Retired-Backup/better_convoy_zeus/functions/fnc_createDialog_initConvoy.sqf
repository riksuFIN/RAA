#include "script_component.hpp"
/* File: fnc_createModule_initConvoy.sqf
 * Author(s): riksuFIN
 * Description: Creates dialog to create convoy from existing vehicles
 *
 * Called from: Zeus Module
 * Local to:	Client
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
 *	[] call fileName
*/

params [["_convoyLogic", objNull]];



// If we're modifying existing convoy we need to to force defaults so they get
// read correctly from logic.
private _forceDefault = false;
if !(isNull _convoyLogic) then {
	_forceDefault = true;
};


// This name used by zeus to identify different convoys in dialogs
private _defaultConvoyName = format ["CONVOY_%1", count GVAR(allConvoys)];

["Create Convoy",
	[ // CONTENT
		["EDIT",
			["Convoy name", "This name will only be shown to you and will be used to identify different convoys in dialogs"],
			[ _convoyLogic getVariable ["convoyName", _defaultConvoyName], // Default value
				{}
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Max Speed", "Max speed in km/h convoy will be travelling at\n\nVehicles may slow down below this value to allow other vehicles in convoy catch them up"],
			[	5, // Min value
				120,  // Max value
				_convoyLogic getVariable ["maxSpeed", 40], // Default value
				0	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Seperation", "Safety distance in metres vehicles in convoy try to keep between each other"],
			[	3, // Min value
				100,  // Max value
				_convoyLogic getVariable ["convSeparation", 20], // Default value
				0	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["COMBO",
			["Awareness", "Speed Mode for all the convoy's groups"],
			[
				["UNCHANGED", "LIMITED", "NORMAL", "FULL"], // Values
				["Unchanged", "Limited", "Normal", "Full"], // Corresponding pretty names
				_convoyLogic getVariable ["awarenessID", 0]	// Default index
			],
			_forceDefault	// Force default
		],
		
		["COMBO",
			["Behaviour", "Forces convoy vehicles to push through enemy contact"],
			[	
				["AWARE", "pushThroughContact"], // Values
				["Aware", "Push Through Contact"], // Corresponding pretty names
				_convoyLogic getVariable ["behaviourID", 1]	// Default index
			],
			_forceDefault	// Force default
		],
		
		
		["EDIT",
			["Fine-tuning", "Anything below here is for fine-tuning and does not have to be adjusted from defaults unless you know what you're doing or want to try and optimize"],
			[	"Anything below here is for fine-tuning", // Default text
				{} // Sanitizing fnc
			],
			_forceDefault	// Force default
		],
		
		
		["SLIDER",
			["Stiffness Coeff", "How much should the lead vehicle brake, in order to establish the desired convoy separation"],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_stiffnessCoef", 0.2], // Default value
				2	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Damping Coeff", "How much should the lead vehicle brake, in order to minimize the relative speeds between the vehicles."],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_dampingCoef", 0.6], // Default value
				1	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Curves Slowdown", "How much should the lead vehicle brake, when traversing winding roads."],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_curvesSlowdown", 0.3], // Default value
				1	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Link Stiffness", "How much should a follower vehicle accelerate and break, in order to establish the desired convoy separation with the vehicle in front."],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_linkStiffness", 0.1], // Default value
				1	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Path Frequency", "Path update frequency, in seconds (adjust for performance)"],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_pathFrequency", 0.05], // Default value
				2	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["SLIDER",
			["Speed Control Frequency", "Speed control update frequency, in seconds (adjust for performance)"],
			[	0, // Min value
				1,  // Max value
				_convoyLogic getVariable ["_speedControlFrequency", 0.2], // Default value
				2	// Number of decimals
			],
			_forceDefault	// Force default
		],
		
		["CHECKBOX",
			["Debug", ""],
			[	
				_convoyLogic getVariable ["debug", false]
			],
			_forceDefault	// Force default
		]
		
		
		
		
		
		
		
	], { // ON CONFIRM CODE
		
		[_this select 0, _this select 1 select 0] call FUNC(handleDialog_initConvoy);
		
	},{	// On cancel code
		
	},[	// Arguments
		_convoyLogic
	]
] call zen_dialog_fnc_create;







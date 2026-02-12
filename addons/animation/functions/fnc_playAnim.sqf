#include "script_component.hpp"
/* File:	fnc_playAnim.sqf
 * Author: 	riksuFIN
 * Description:	Plays animation and handles looping them
 *
 * Called from:	fnc_createAnimList
 * Local to: 	Client
 * Parameter(s):
	DATA 		Complex array of variuous data.		<ARRAY>
				Meant to come directly from dialog
				
 Returns:		Nothing
 * 
 * Example:	
	
	[[["Acts_Ambient_Relax_2", 1], true], [player]] call RAA_animation_fnc_playAnim;
	
 */



params ["_data1", ["_looped", false]];
_data1 params ["_dataDialog", "_dataModule"];	//_this select 0 select X

_dataDialog params [	// _this select 0 select 0 select x
	"_dataDialogAnim",
	["_loopAnim", false]
//	["_loopAnimTypeOverride", 0]	// When re-enabling dev settings uncomment this and remember column!
];
	private _loopAnimTypeOverride = 0;



	_dataDialogAnim params [	// _this select 0 select 0 select 0 select x
		"_animation",
		["_playType", 1],
		["_leadsToBadAnim", false],
		["_loop_length", 10],
		["_loopEndAnimation", ""],
		["_loopType", 0]
	];
	
_dataModule params [["_unit", player]];	// _this select 0 select 1 select X


// DEV STUFF --- REMOVE BEFORE FINAL RELEASE ----------------------------------
// This is for dev/ debug
if (_loopAnimTypeOverride > 0) then {
	_loopType = _loopAnimTypeOverride;
};

if (_loop_length isEqualTo 0) then {
	_loop_length = 10;
};




if (_unit == player) then {	// In case Zeus is remote controlling someone, update to that
	_unit = player getVariable ["RAA_animation_currentlyControlledUnit", player];	// This variable is updated to refer to RC unit by eventHandler
};


// Special exception for taking a leak animation
if (_animation == "Acts_AidlPercMstpSlowWrflDnon_pissing") exitWith {
	systemchat "This animation can not be looped";
//	_unit spawn RAA_animation_fnc_pissing;
	_unit spawn FUNC(pissing);
	
};




private _currentAnimation = _unit getVariable ["RAA_animation_currentLoopedAnim", ""];
private _currentLoop = _unit getVariable ["RAA_animation_loopAnim", 0];


	// If passed data and variable don't match stop looping. Player likely stopped it manually
if (_looped && _loopType != _currentLoop) exitWith {
	if (RAA_misc_debug) then {systemChat "[RAA_animation] Anim loop was cut (User cancelled it?)";};
	_unit setVariable ["RAA_animation_loopAnim", _loopType];
	_unit setVariable ["RAA_animation_currentLoopedAnim", _animation];
};


	// Save settings for looping if this is not already looped cycle
if !(_looped) then {
	_unit setVariable ["RAA_animation_loopAnim", _loopType];
	_unit setVariable ["RAA_animation_currentLoopedAnim", _animation];
};



/*
// Check if animation is already playing and this execution is actually for looping
if (_currentLoop == 0) then {
	
	// Reset settings to ensure they're defaults
	_unit setVariable ["RAA_animation_loopAnim", 0];
	_unit setVariable ["RAA_animation_currentLoopedAnim", ""];
	
} else {
	if (animationState _unit != _currentAnimation) then {
		// There is already animation playing, but it isnt same as 
		
		
	};
}:
*/


if (_animation == "random1") then {
	private _selection = selectRandom [	// List of generic idle anims. MUST be activateable with type 1
		["AidlPercMstpSlowWrflDnon_G01",29.971],
		["AidlPercMstpSlowWrflDnon_G02",30.083],
		["AidlPercMstpSlowWrflDnon_G03",30.097],
		["AidlPercMstpSlowWrflDnon_G04",30.064],
		["AidlPercMstpSlowWrflDnon_G05",30.089],
		["Acts_Ambient_Cleaning_Nose",3.67401],
		["Acts_Ambient_Gestures_Yawn",5.52701],
		["AidlPercMstpSlowWrflDnon_G05",30.078]
		];
		
	_animation = _selection select 0;
	_loop_length = _selection select 1;
};



if (RAA_misc_debug) then {systemChat format ["Playing animation %1 using command type %2. Looped: %4, loopType: %3",_animation, _playType, _loopType, _loopAnim];};






// Fix unwanted animation by cutting anim before it proceeds to next one
// If loop is disabled animation will be cut 
// POTENTIAL PROBLEM: THIS MAY ACTIVATE EVEN IF USER HAS ALREADY SWITCHED TO ANOTHER ANIMATION
//if ((_leadsToBadAnim && _loopAnim) || (!_loopAnim && _loopType > 0)) then {
if (_leadsToBadAnim && !(_loopAnim && _loopType == 1)) then {
	_unit  setVariable ["RAA_animation_loopAnim", 5];
	
	[	{	// Function to exec
			if ((_this select 0) getVariable ["RAA_animation_loopAnim",0] == 5) then {	// If player manually reset anim do nothing
				
				[_this select 0, "", 2] call ace_common_fnc_doAnimation;
				if (RAA_misc_debug) then {systemChat "[RAA_anim] Animation was cut short on purpose";};
				
			} else {
				if (RAA_misc_debug) then {systemChat "[RAA_anim] Anim auto-cut was cancelled (User reset animation already?)";};
			};
		}, 
		[	// Params
			_unit
		], 
		_loop_length	// Delay
	] call CBA_fnc_waitAndExecute;
};


// Do animation if this is not already looped run with type 1
if !(_looped && _loopType == 1) then {
	// Start animation
	[_unit, _animation, _playType] call ace_common_fnc_doAnimation;
	
};



if (_loopAnim && _loopType < 0) exitWith {
	if (_loopType == -1) then {
		systemChat "This animation cannot be looped.";
	};
};






if (_loopAnim) then {
	// Handle forced looping (= if animation does not loop naturally)

	
	
	switch (_loopType) do {
		case 1: {	// Queue
			
			if (_animation == "random1" && !_looped) then {
				private _selection = selectRandom [	// List of generic idle anims. MUST be activateable with type 1
					["AidlPercMstpSlowWrflDnon_G01",29.971],
					["AidlPercMstpSlowWrflDnon_G02",30.083],
					["AidlPercMstpSlowWrflDnon_G03",30.097],
					["AidlPercMstpSlowWrflDnon_G04",30.064],
					["AidlPercMstpSlowWrflDnon_G05",30.089],
					["Acts_Ambient_Cleaning_Nose",3.67401],
					["Acts_Ambient_Gestures_Yawn",5.52701],
					["AidlPercMstpSlowWrflDnon_G05",30.078]
				];
				_animation = _selection select 0;
			//	_loop_length = _selection select 1;
			};
			
			
			[_unit, _animation, 0] call ace_common_fnc_doAnimation;
			
				
			[	{
				//	[_this select 0 select 0, true] call RAA_animation_fnc_playAnim;
					[_this select 0 select 0, true] call FUNC(playAnim);
				}, [
					_this
				],
				_loop_length
			] call CBA_fnc_waitAndExecute;
			
			
			
			
			if (RAA_misc_debug) then {systemChat "[RAA_anim] Animation was queued";};
			
		};
		
		case 2: {	// Detect
			[
				{	// Condition
					(animationState (_this select 0 select 1 select 0)) != (_this select 0 select 1 select 0 getVariable ["RAA_animation_currentLoopedAnim", ""])
				}, {	// Function
					if ((_this select 0 select 0 select 1 select 0) getVariable ["RAA_animation_loopAnim", 0] > 0) then {
						
						// Animation change was detected, so restart current anim
						[_this select 0 select 0, true] call RAA_animation_fnc_playAnim;
						if (RAA_misc_debug) then {systemChat "[RAA_animation] AnimLoop type 2: Restarting animation now";};
						
					} else {
						if (RAA_misc_debug) then {systemChat "[RAA_animation] AnimLoop type 2: Looping was cancelled";};
					};
				}, [	// params
					_this
				]
			] call CBA_fnc_waitUntilAndExecute;
			
			if (RAA_misc_debug) then {systemChat "[RAA_animation] Looping animation with type 2 (Detect)";};
		};
		
		case 3: {	// Timed
			
			if (_loop_length == 10) then {	// In case time is not configured exit
				systemChat format ["[RAA_animation] WARNING: Loop_length not defined for animation %1. Default length of 10 seconds used instead", _animation];
			};
			
			
			
			[	{	// Function to exec
					if ((_this select 0 select 0 select 1 select 0) getVariable ["RAA_animation_loopAnim",0] == 3) then {
						
					//	[_this select 0 select 0, true] call RAA_animation_fnc_playAnim;
						[_this select 0 select 0, true] call FUNC(playAnim);
						if (RAA_misc_debug) then {systemChat "[RAA_animation] Timed animation restart";};
						
					} else {
						if (RAA_misc_debug) then {systemChat "[RAA_animation] Timed animation restart: Cancelled. (User manually cleared anim?)";};
					};
				}, 
				[	// Params
					_this
				], 
				_loop_length + 0.05	// Delay + a little to let autoCut do its thing first
			] call CBA_fnc_waitAndExecute;
			
			if (RAA_misc_debug) then {systemChat "[RAA_animation] Looping animation with type 3 (Timed)";};
			
		};
	};
} else {	// Do NOT loop, cut animation if necessary
	
	if (_loopType == 6) then {
		[	{
				[_this select 0, "", 2] call ace_common_fnc_doAnimation;	// Force cut animation
			}, [
				_unit
			],
			_loop_length
		] call CBA_fnc_waitAndExecute;
		
		
		
		
		
	};
	
	
	
	
	//systemChat "DEBUG: Loop cut was ran (No code included yet)";
	
	
	/*
	
	[	{
			params ["_unit", "_endAnim", "_playType"];
			if (_loopEndAnimation != "") then {
				// End animation with out-animation
				[_unit, _endAnim, _playType] call ace_common_fnc_doAnimation;
			} else {
				// No end animation was defined, just force-cut
				
				[_unit, "", 2] call ace_common_fnc_doAnimation;
			};
			
			
			_unit setVariable ["RAA_animation_loopAnim", 0];
			_unit setVariable ["RAA_animation_currentLoopedAnim", ""];
			
			
			
		}, [
			_unit, _loopEndAnimation, _playType
		],
		_loop_length
	] call CBA_fnc_waitAndExecute;
	*/
	
	
	
	
	
	
	
	
	
};






/*
Notes for loop dev stuff
getNumber (configfile >> "CfgMovesMaleSdr" >> "States" >> animationState player >> "looped")
getText (configfile >> "CfgMovesMaleSdr" >> "States" >> animationState player >> "Actions")
getArray (configfile >> "CfgMovesMaleSdr" >> "States" >> animationState player >> "InterpolateTo")

*/
/* File: fnc_mainLoop.sqf
 * Author(s): riksuFIN
 * Description: Handle updating screen and random interruption checking
 *
 * Called from: Various
 * Local to: 	SERVER
 * Parameter(s):
 0:	Object where intel is ran <OBJECT>
 1:	Face on object to use <NUMBER>
 2:	Array of override pictures <ARRAY, default []>	IF empty will use those stored on object, otherwise will use those passed
 		Interruptions pass override pics, normal run is stored on object
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] remoteExec ["RAA_zeus_fnc_intel_mainLoop", 2]
*/


params [
	"_object", 
	["_face", (_this select 0) getVariable ["RAA_zeus_intel_face", 0]], 
	["_animInterval", (_this select 0) getVariable ["RAA_zeus_intel_animIntervals", 0]],
	["_failChance", (_this select 0) getVariable ["RAA_zeus_intel_failChance", 0]],
	["_isInterrupted", false], 
	["_framesArray", []]
	
];

/*
// Normally we pass info along via variables to next iteration, but if some cases we have to fetch them from object's variable
if (_face isEqualTo -1) then {
	_face = _object getVariable ["RAA_zeus_intel_face", 0];
};
*/


// If this is interrupted cycle (devoid of main screens) we use passed along info. Otherwise we store what we need in object's variable
private _exit = false;
if !(_isInterrupted) then {
	_framesArray = _object getVariable ["RAA_zeus_intel_remainingFrames", []];
	
	
	if (_failChance < (random 1)) then {
		_exit = true;
	};
};


if (_exit) exitWith {
	[] call RAA_zeus_fnc_intel_handleInterruption;
	
};






// Select next picture from array. This is always first one
private _nextFrame = _framesArray select 0;

// Now that we have our picture secured we can delete it from array
_framesArray deleteAt 0;


if !(_isInterrupted) then {
	_object setVariable ["RAA_zeus_intel_remainingFrames", _framesArray];
};

/*
// Check if we have exhausted our array of pictures
private _finished = false;
if (count _framesArray == 0) then {
	_finished = true;
};
*/


if (count _framesArray isEqualTo 0) then {
	// We've exhausted all pictures, therefore we're done with loop
	[_nextFrame, _object, _face, false] call RAA_zeus_fnc_animScreen_setScreenPicture;
	// Reset interruption and return to main anim sequence
	if (_isInterrupted) then {
		_isInterrupted = false;
		
		_object setVariable ["RAA_zeus_intel_isInterrupted", false, true];
	};
} else {
	// Proceed to next picture
	[_nextFrame, _object, _face, true] call RAA_zeus_fnc_animScreen_setScreenPicture;		// Last frame is broadcasted globally in case someone wanders near it
};






// If we're not through loop yet will will call next iteration
[	{
		_this call RAA_zeus_fnc_intel_mainLoop;
	}, [
		_object, _face, _animInterval, _failChance, _isInterrupted
	],
	_animInterval
] call CBA_fnc_waitAndExecute;





#include "script_component.hpp"
/* File: fnc_animScreen_loop.sqf
 * Author(s): riksuFIN
 * Description: Handle animation looping
 *
 * Called from: fnc_animScreen_loop.sqf
 * Local to: Various
 * Parameter(s):
 0:	Object									<OBJECT>			
 1:	Object hiddenSelection number		<INT>				
 2: 	Animation Array (of pictures)		<ARRAY>			
 3: 	Animation intervals					<NUMBER>
 4:	Code to call once anim finished	<CODE>			Optional, default {}
 :	
 *
 Returns:
 *
 * Example:	[this, "COUNTDOWN_5", 5, {hint "DONE"}] call RAA_zeus_fnc_animScreen_loop
 */

params ["_object", "_face", "_animArray", "_animInterval", ["_finishedCode", {}]];


if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] %1", _this];};
//debug1 = _this;

// Select next picture from array. This is always first one
private _nextPicture = _animArray select 0;

// Now that we have our picture secured we can delete it from array
_animArray deleteAt 0;

// Check if we have exhausted our array of pictures
private _finished = false;
if (count _animArray == 0) then {
	_finished = true;
};


// If this fnc is executed on client, effect is limited to that client only
// If executed on server effect is assumed to be intended as global and broadcasted

/*
if (isServer) then {
	// Server
	_object setObjectTextureGlobal [_face, _nextPicture];
	
} else {
	// Client
	_object setObjectTexture [_face, _nextPicture];
	
};
*/

if !(_finished) then {
	[_nextPicture, _object, _face, false] call FUNC(animScreen_setScreenPicture);
} else {
	[_nextPicture, _object, _face, true] call FUNC(animScreen_setScreenPicture);		// Last frame is broadcasted globally in case someone wanders near it
};



// If we're done one last thing we will do is execute custom code sent to us in params
if (_finished) exitWith {
	[_object] spawn _finishedCode;
};



// .. If we're not through loop yet will will call next iteration
[	{
		_this call FUNC(animScreen_loop);
	}, [
		_object, _face, _animArray, _animInterval, _finishedCode
	],
	_animInterval
] call CBA_fnc_waitAndExecute;





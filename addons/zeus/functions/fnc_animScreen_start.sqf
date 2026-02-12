#include "script_component.hpp"
/* File: fnc_animScreen_start.sqf
 * Author(s): riksuFIN
 * Description: Handle animation init call from Zeus module
 *
 * Called from: Zeus Module (scripts\createZeusModules.sqf)
 * Local to: Client
 * Parameter(s):
 0:	Object									<OBJECT>			
 1:	Object hiddenSelection number		<INT>				
 2:	isGlobal									<BOOL>			
 3: 	Animation type							<STRING>			
 4: 	Animation length						<NUMBER, secs>	Optional, default 10
 5:	Code to call once anim finished	<CODE>			Optional, default {}
 6: 	Params that are passed to finishedCode				Optional, default []		Sent to executed function as _this select 0	// [some, "params"]
 7:	Chance of loop beign interrupted	<NUMBER, 0 - 100>	Optional, default 0 
 8:	Code executed in case of interruption	<CODE>	Optional, default {}
 9:
 *
 Returns:
 *
 * Example:	[this, 0, true, "COUNTDOWN_5", 5, {hint "DONE"}] call RAA_zeus_fnc_animScreen_start
 */

 params ["_object", "_face", "_isGlobal", "_animType", ["_animLength", 10], ["_finishedCode", {}], ["_passthroughParams", []], ["_interruptionChance", 0], ["_interruptionCode", {}]];




//private _animArray = _animType call RAA_zeus_fnc_animScreen_getAnimArray;
private _animArray = _animType call FUNC(animScreen_getAnimationArray);




// Calculate interval between each picture. Mininum 1 sec to avoid too much net traffic
private _interval = (_animLength / (count _animArray)) max 1;





// Call fnc to execute actual animation. If global will be handled server-side, otherwise client-side
if (_isGlobal) then {
//	[_object, _face, _animArray, _interval, _finishedCode] remoteExec ["RAA_zeus_fnc_animScreen_loop", 2];
	[_object, _face, _animArray, _interval, _finishedCode] remoteExec [QUOTE(FUNC(animScreen_loop)), 2];
	
} else {
//	[_object, _face, _animArray, _interval, _finishedCode] call  RAA_zeus_fnc_animScreen_loop;
	[_object, _face, _animArray, _interval, _finishedCode] call  FUNC(animScreen_loop);
	
};





















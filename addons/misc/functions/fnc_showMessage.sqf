/* File: showMessage.sqf
 * Author(s): riksuFIN
 * Description: Shows very clear message composed of several parts of client.
 					Also can play optional sound
 *
 	Effect is local
 
 * Parameter(s):
 0:	Message to show 			STRING
 1: 	Sound to play				SoundName (STRING)	Optional, default ""
 2: 	Forced (hintC)				<BOOL>
 3: 
 4:
 *
 Returns:
 *
 * Example:	["This is message", "", false] call RAA_misc_fnc_showMessage
 */

params ["_text", ["_sound", ""], ["_forced", false]];


//titleText [_text, "PLAIN", 8];
[_text,0,0.8,8,2] spawn bis_fnc_dynamicText;
if (_forced) then {
	hintC _text;
};


if (_sound isEqualTo "") exitWith {};

playSound _sound;


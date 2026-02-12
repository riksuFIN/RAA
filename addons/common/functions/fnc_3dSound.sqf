/* File: fnc_3dSound.sqf
 * Author(s): riksuFIN
 * Description: Plays given sound from cfgSounds in multiplayer-friendly way
 *
 * Called from: 
 * Local to: Client, global effect
 * Parameter(s):
 0:	Sound source <OBJECT>
 1:	Sound classname from cfgSounds <STRING>
 2:	Distance sound is played (and broadcasted) to <NUMBER>
 3:	
 *
 Returns:
 *
 * Example:	[_player, "RAA_AED_doShock", 40] call RAA_fnc_ACEA_3dSound;
*/

params ["_source", "_sound", ["_distance", 50]];


// Only send sound across MP to players who can actually hear it
private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _source, _distance, _distance, 0, false, _distance];
if (_targets isEqualTo []) exitWith {
	if (RAA_misc_debug) then {systemChat "[RAA_common] 3dSound exit, no targets";};
};
if (RAA_misc_debug) then {systemChat format ["[RAA_common] 3D sounds broadcast to: %1", _targets];};


[_source, [_sound, _distance]] remoteExec ["say3D", _targets];


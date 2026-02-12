/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Sound source <OBJECT>
 1:	Sound classname from cfgSounds <STRING>
 2:	Distance sound is played (and broadcasted) to <NUMBER>
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[player, "RAA_AED_doShock", 40] call RAA_fnc_ACEA_3dSound;
*/

params ["_source", "_sound", ["_distance", 50]];


// Only send sound across MP to players who can actually hear it
private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _source, _distance, _distance, 0, false, _distance];
if (_targets isEqualTo []) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] 3dSound exit, no targets";};
};
if (RAA_ACEA_debug) then {systemChat format ["[RAA_ACEA] 3D sounds broadcast to: %1", _targets];};


[_source, [_sound, _distance]] remoteExec ["say3D", _targets];


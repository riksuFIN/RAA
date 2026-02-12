#include "script_component.hpp"
/* File: fnc_handleRadioAction.sqf
 * Author(s): riksuFIN
 * Description: Handles ACE action menu for music radio
 *
 * Called from: ACE interaction menu
 * Local to:	Server, effects global
 * Parameter(s):
 * 0:	See Params line #20
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
params ["_aceVars", "_action"];
_aceVars params ["_object"];

// Ensure this function cannot run several times on top of each other
if (_object getVariable [QGVAR(alreadySwitching), false]) exitWith {};

// Command: Radio OFF
if (_action <= 0) exitWith {
	private _musicSource = _object getVariable [QGVAR(radio_source), objNull];
	private _ehKilled = _object getVariable [QGVAR(EH_killed_id), -1];
	private _ehDeleted = _object getVariable [QGVAR(EH_deleted_id), -1];
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Deleted %1 and EH %2, %3", _musicSource, _ehKilled, _ehDeleted];};
	
	_object setVariable [QGVAR(radioPower), false, true];
	_object removeEventHandler ["Killed", _ehKilled];
	_object removeEventHandler ["Deleted", _ehDeleted];
	deleteVehicle _musicSource;
};


// Command: Radio ON or SWITCH CHANNEL
_object setVariable [QGVAR(radioPower), true, true];
_object setVariable [QGVAR(alreadySwitching), true];

if (_object getVariable [QGVAR(EH_killed_id), -1] isEqualTo -1) then {
	// Add EH in case object is destroyed or deleted by Zeus.
	private _ehKilled = _object addEventHandler ["Killed", {
		params ["_unit"];
		private _soundSource = _unit getVariable [QGVAR(radio_source), objNull];
		if (RAA_misc_debug) then {systemChat format ["[RAA_misc] (KilledEH) Deleted soundSource %1", _soundSource];};
		deleteVehicle _soundSource;
	}];
	private _ehDeleted = _object addEventHandler ["Deleted", {
		params ["_unit"];
		private _soundSource = _unit getVariable [QGVAR(radio_source), objNull];
		if (RAA_misc_debug) then {systemChat format ["[RAA_misc] (DeletedEH) Deleted soundSource %1", _soundSource];};
		deleteVehicle _soundSource;
	}];
	
	_object setVariable [QGVAR(EH_killed_id), _ehKilled];
	_object setVariable [QGVAR(EH_deleted_id), _ehDeleted];
	
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] EH ID: %1", _ehKilled];};
	
};



// Switch station
private _soundSource = _object getVariable [QGVAR(radio_source), objNull];
if !(isNull _soundSource) then {
	deleteVehicle _soundSource;
};

// Add static sound effect
playSound3D [QPATHTOF(sounds\radio_static.ogg), _object];

// Handle Workshop release censoring
private _sounds = [
	"RAA_sound_radio_chill",
	"RAA_sound_radio_epic",
	"RAA_sound_radio_rock",
	"tanoamusic1",
	"tanoamusic2",
	"ME_radio_music",
	"ME_radio_music2",
	"russian_music_tripaloski",
	"music_club",
	"music_rockbar",
	"music_radio1",
	"music_radio2"];
if !(isNil {NOT_WORKSHOP}) then {
	_sounds pushBack "RAA_sound_radio_vdvSong";
};


private _soundToPlay = selectRandom _sounds;


// Create new source. Delayed so that static effect has some time to player
[	{
	params ["_soundToPlay", "_object"];
	_soundSource = createSoundSource [_soundToPlay, position _object, [], 0];
	_soundSource attachTo [_object, [0, 0, 0]];
	
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Now playing: %1", _soundToPlay];};
	
	_object setVariable [QGVAR(radio_source), _soundSource];
	_object setVariable [QGVAR(alreadySwitching), false];
	}, [
		_soundToPlay, _object
	],
	2
] call CBA_fnc_waitAndExecute;


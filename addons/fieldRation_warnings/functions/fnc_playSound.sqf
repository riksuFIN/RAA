#include "../script_component.hpp"
/* File: fnc_playSound.sqf
 * Authors: riksuFIN
 * Description: Plays sound, such as stomach growling, on player
 *
 * Called from: fnc_mainLoop.sqf
 * Parameter(s):
 0: soundType		INT		0= hunger, 1= thirst
 1: soundLevel		INT		0 = normal, 1= increased. This effects sound played to indicate severity of hunger/ thirst
 2: Random			NUMBER	Random chance of sound playing (0 - 100)
 3: unit			STRING	Unit to play sound from. Mainly used for shared sound
 4: Shared			BOOL	Optional, default: false	 DISUSED, CURRENTLY IN CBA SETTINGS
 5: soundFile		STRING, Filename		Optional, if set will overwrite setting 0
 *
 Returns:
 *	
 */

/*

ToDo: 
Add shared sounds:

if (isClass(configfile >> "CfgPatches" >> "RAA_FieldRation_Warnings")) then {
	// RAA_FRW mod was detected, so execute this thing here
};


*/

params ["_soundType", "_soundlevel", "_random", "_unit", ["_shared", false], ["_file", ""]];
private ["_soundToPlay"];

_soundsHunger = ["RAA_Hungry1"];	// Array of sound files for hunger
_soundsHungerHigh = ["RAA_Hungry1"];	// version for more severe hunger
_soundsThirst = [""];	// ^ Ditto, but for thirst
_soundsThirstHigh = [""];


// Avoid executing this fnc too frequently to avoid spam
_lastRun = player getVariable "RAA_Hunger_SoundLastPlayed";
_timeSinceLastRun = CBA_MissionTime - _lastRun;

if (_timeSinceLastRun < RAA_FRW_SoundCoolDown) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_FRW] playSound exit: Too early since last run";};
};



private _sounds = [];
private _soundsHigh = [];


	// Select thirst or hunger sound
if (_soundType == 0) then {
	_sounds = _soundsHunger;
	_soundsHigh = _soundsHungerHigh;
	
} else {
	_sounds = _soundsThirst;
	_soundsHigh = _soundsThirstHigh;
};





if (_random < (random 100)) then {
	
	
	// Pick sound to use
	if (_soundLevel == 1) then {	// Severe sounds
		_soundToPlay = selectRandom _sounds;
		
	} else {	// Normal sounds
		_soundToPlay = selectRandom _soundsHigh;
	};
	
	
	
	if (RAA_FRW_sharedSounds) then {
		// Broadcast sound to nearby players
		
		private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, GVAR(sharedSounds_distance), GVAR(sharedSounds_distance), 0, false, GVAR(sharedSounds_distance)];
		if (_targets isEqualTo []) exitWith {
		};
		
		
		if (isNil _soundToPlay) exitWith {};
		["ace_medical_feedback_forceSay3D", [_unit, _soundToPlay, GVAR(sharedSounds_distance) * 2], _targets] call CBA_fnc_targetEvent;
		
		
	} else {
		// Setting was disabled, so only this client can hear his own stomach
		if (_soundToPlay isEqualTo "") exitWith {};
		playSound _soundToPlay;
		
	};
	if (GVAR(debug)) then {systemChat format ["[RAA_FRW] Playing sound %1 globally: %2", _soundToPlay, RAA_FRW_sharedSounds];};
	
	
	if (GVAR(debug)) then {
		systemChat format ["[RAA_FRW] fnc_playSound playing sound at %1 -per cent chance, SUCCESS, now playing %2",_random, _soundToPlay];
	};
	
	player setVariable [QGVAR(SoundLastPlayed),CBA_MissionTime];
	
	
} else {
	if (GVAR(debug)) then {
		systemChat format ["[RAA_FRW] fnc_playSound playing sound at %1 -per cent chance, FAIL",_random];
	};
	
	
	
};























	// THIRST
	
	
	
	
	
	/*
	if (_random > (random 100)) then {

		
		if (_soundLevel == 1) then {	// Severe sounds
			_soundToPlay = selectRandom _soundsHunger;	// TODO: SelectRandom
			
		} else {	// Normal sounds
			_soundToPlay = selectRandom _soundsHungerHigh;
			playSound _soundToPlay;
			
		};
		
		
		
		if (RAA_FRW_sharedSounds) then {
			
			// Make nearby players hear sound as well
			private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, RAA_FRW_sharedSounds_distance, RAA_FRW_sharedSounds_distance, 0, false, RAA_FRW_sharedSounds_distance];
			if (_targets isEqualTo []) exitWith {
				
			};
			
			
			["ace_medical_feedback_forceSay3D", [_unit, _soundToPlay, RAA_FRW_sharedSounds_distance * 2], _targets] call CBA_fnc_targetEvent;
			
			//systemChat "[RAA_FRW] WARNING: Shared sounds feature is WIP!";
			if (RAA_FRW_debug) then {systemChat format ["[RAA_FRW] Playing sound %1 globally: %2", _soundToPlay, RAA_FRW_sharedSounds];};
			
			
		} else {
			// Setting was disabled, so only this client can hear his own stomach
			playSound _soundToPlay;
		};
		
		
		
		if (RAA_FRW_debug) then {
			systemChat format ["[RAA_FRW] fnc_playSound playing sound at %1 -per cent chance, SUCCESS, now playing %2",_random, _soundToPlay];
		};
		
		player setVariable ["RAA_Hunger_SoundLastPlayed",CBA_MissionTime];
	*/
	
	
	





















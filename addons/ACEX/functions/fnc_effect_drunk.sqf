#include "script_component.hpp"
/* File: fnc_effect_drunk.sqf
 * Authors: riksuFIN
 * Description: Handle drunk effects, eg. hilarious laughing. Loops at random intervals untill time out
 *
 * Called from: fnc_handleItemConsumptionEffects
 * Parameter(s):
 0:		Player unit 	<OBJECT, default player>
 1: 	Time for how long effects will play for (seconds)		<NUMBER, default 60>
 2: 	Do animation 	<BOOL, default false>
 3: 
 4:
 *
 Returns:
 *
 * Example:	[player, 60] call RAA_ACEX_fnc_effect_drunk
 */

params [["_unit", player], ["_timeLeft", 60], ["_doAnim", false], ["_safeStartEnabled", false]];

private _exit = false;
private _safestart = false;
// Handle exit on safestart end if Zanzan's Framework is present
if (!isNil "zafw_safestart_enabled") then {
	if (zafw_safestart_enabled) then {	// If safestart is not enabled in mission stop checks here
		if (zafw_safestart_on) then {
			_safestart = zafw_safestart_on;	// Update value for next loop cycle
			
		} else {
			if (_safeStartEnabled && !zafw_safestart_on) then {	// If SS WAS enabled and is no more, stop loop
			_exit = true;		// This makes script exit on next exitWith block
			
			};
		};
	};
};



if (_exit) exitWith {
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEX] Drunk effect was cancelled due to safestart ending";};
	
	// Clear visual effects
	"chromAberration" ppEffectEnable false;
	"radialBlur" ppEffectEnable false;
};

// Add some minor visual effet (screen edges blurred)
if (random 100 > 75) then {
	"chromAberration" ppEffectEnable true;
	"chromAberration" ppEffectAdjust [0.01,0.01,true];
	"chromAberration" ppEffectCommit 1; 
	"radialBlur" ppEffectEnable true;
	"radialBlur" ppEffectAdjust [0.02,0.02,0.15,0.15];
	"radialBlur" ppEffectCommit 1;
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Added visual effect";};
	
};







// Safety to avoid two effects overlapping
if (_unit getVariable ["RAA_acex_drunk_effectRunning", false]) exitWith {
	// Another effect is already running, delay this one to avoid overlap
	
	if (RAA_ACEA_debug) then {systemChat "[RAA] drunkEffects: Effect already running, delayed this one";};
	[	{
			[_this select 0, _this select 1] call FUNC(effect_drunk);
		}, [
			_unit, _timeLeft
		], 
		random 15	// Delay
	] call CBA_fnc_waitAndExecute;
	
};

// Reserve effect window in case there are several loops running from multiple drinks
_unit setVariable ["RAA_acex_drunk_effectRunning", true];	


private _soundToPlay = selectRandom [
	"RAA_drunk1",
	"RAA_drunk2",
	"RAA_drunk3",
	"RAA_drunk4",
	"RAA_drunk5",
	"RAA_drunk6"
];

private _distance = 15;		// Distance at which other players may hear sound from



// Only send sound across MP to players who can actually hear it
private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, _distance, _distance, 0, false, _distance];
if (_targets isEqualTo [] || _soundToPlay isEqualTo nil) exitWith {
};



["ace_medical_feedback_forceSay3D", [_unit, _soundToPlay, _distance * 2], _targets] call CBA_fnc_targetEvent;


if (RAA_ACEA_debug) then {systemChat format ["[RAA] drunkEffect: playing sound %1", _soundToPlay]};

private _random = random 100;
if (_doAnim && _random > 50) then {
	[_unit, "Acts_Ambient_Rifle_Drop", 2] call ace_common_fnc_doAnimation;
};


// Clear effect reservation after a while so that other drinks can get on
[	{
		(_this select 0) setVariable ["RAA_acex_drunk_effectRunning", false];
	}, [
		_unit
	], 
	7	// Delay
] call CBA_fnc_waitAndExecute;


	// Loops if suffient time remains in effect counter
if (_timeLeft > 10) then {
	private _timeToNextEffect = random [8, _timeLeft / 3 max 10, _timeLeft max 40];
	_timeLeft = _timeLeft - _timeToNextEffect;		// Update effect runtime counter for next cycle
	
	
	[	{
			[_this select 0, _this select 1, false, _safestart] call FUNC(effect_drunk);
		}, [
			_unit, _timeLeft
		], 
		_timeToNextEffect	// Delay
	] call CBA_fnc_waitAndExecute;
} else {
	
	// Clear visual effects
	"chromAberration" ppEffectEnable false;
	"radialBlur" ppEffectEnable false;
};
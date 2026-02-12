#include "script_component.hpp"
/* File: fnc_windAffectWalkingLoop.sqf
 * Author(s): riksuFIN
 * Description: Slows down and speeds up player's movement in strong wind conditions.
 *
 * Called from: Itself (loops), first run from CBA setting
 * Local to:	Client
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_misc_fnc_windAffectWalkingLoop
*/

// NOTE: THIS FEATURE FAILED DUE TO ACE's FUNCTION NOT WORKING WAY I EXCEPTED, LEADING TO EXCESSIVE COMPLEXITY



params [["_unit", player]];

if !(GVAR(windAffectWalking)) exitWith {};

private _lastSetting = _unit getVariable [QGVAR(windAffectWalking_lastSpeedCoef), -1];
private _windSpeed = vectorMagnitude wind;

// If mission's wind speed is above limit where it could affect walking we start to run this fnc at much faster pace
if (_windSpeed > 13 && vehicle _unit isEqualTo _unit && GVAR(windAffectWalking)) then {
	
	if (_lastSetting <= 0) then {
		// We need to let player know that there's strong wind affecting their movement
		["You feel strong wind affecting your movement", false, 15, 5] call ace_common_fnc_displayText;
		
		// We need to disable ACE's system from overriding our value
		if !(isNil "ACE_advanced_fatigue_setAnimExclusions") then {
			ACE_advanced_fatigue_setAnimExclusions pushBack QUOTE(ADDON);
		};
	};
	
	
	// Find out how much wind should slow us down
	private _speedCoef = 13 /_windSpeed;
	_speedCoef = _speedCoef min 1.7;	// Cap speeds so they don't get ridiculous
	_speedCoef = _speedCoef max 0.5;
	
	// Avoid spamming speed change too much, since it creates network traffic
	if (abs (_speedCoef - _lastSetting) > 0.1) then {
		["ACE_common_setAnimSpeedCoef", [_unit, _speedCoef]] call CBA_fnc_globalEvent;
		_unit setVariable [QGVAR(windAffectWalking_lastSpeedCoef), _speedCoef];
	};
	
	if (GVAR(debug)) then {systemChat format ["[RAA_misc] Strong wind, walking speed: %1", _speedCoef];};
	
	[	{
			_this call FUNC(windAffectWalkingLoop)
		}, 
			_this
		,
		1
	] call CBA_fnc_waitAndExecute;
	
	
} else {
	if (GVAR(debug)) then {systemChat "[RAA_misc] WindAffectWalking: Weak wind, using delayed checks";};
	
	if (_lastSetting > 0) then {
		// Notify player that wind is no longer a factor
	//	["You feel like wind has slowed down", false, 15, 5] call ace_common_fnc_displayText;
		
		// Allow ACE's Advanced Fatigue to continue doing that it likes to do
		if !(isNil "ACE_advanced_fatigue_setAnimExclusions") then {
			ACE_advanced_fatigue_setAnimExclusions deleteAt (ACE_advanced_fatigue_setAnimExclusions find QUOTE(ADDON))
		};
	};
	
	[	{
			_this call FUNC(windAffectWalkingLoop)
		}, 
			_this
		,
		10
	] call CBA_fnc_waitAndExecute;
	
	
};



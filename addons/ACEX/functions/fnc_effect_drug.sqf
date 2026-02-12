#include "script_component.hpp"
/* File: fnc_.sqf
 * Authors: riksuFIN
 * Description: 	Handle drugged effect. NOTE: This is horribly unoptimized! Not my fault though :)
 *
 * Called from: init.sqf
 * Parameter(s):
 0: UNIT to play effect on (MUST BE PLAYER)		<OBJECT, default player>
 1: How long effect will last for 		<NUMBER, default 30>
 2: 
 3: 
 4:
 *
 Returns:
 *
 * Example:	[player, 60] call RAA_ACEX_fnc_effect_drug
 */
 
 


 
 
params [["_unit", player], ["_timeToPlay", 30]];










if (_unit getVariable ["RAA_acex_drug_effectRunning", false]) exitWith {
	if (RAA_misc_debug) then {systemChat "[RAA] drunkEffect: Effect already running, cancel this run"};
};

_unit setVariable ["RAA_acex_drug_effectRunning", true];

private _random = random 100;


/*
//hint "effects online";
sleep 3 + (random 10);
*/



// Some people just can't take a good dose of drug
if (_random > 80) exitWith {
	[_unit, "Acts_Stunned_Unconscious", 1] call ace_common_fnc_doAnimation;
	[_unit, "Acts_Stunned_Unconscious_end", 0] call ace_common_fnc_doAnimation;
	
	[	{	// Code
			// TODO: Turn unit about 90 degrees before this command, since this animation starts at different pos than last one
			[_this select 0, "Acts_UnconsciousStandUp_part1", 2] call ace_common_fnc_doAnimation;	
		}, [	// Params
			_unit
		], 
		random [8, 12, 25]	// Delay
	] call CBA_fnc_waitAndExecute;
};


	// Stop effect after a while
[	{
		(_this select 0) setVariable ["RAA_acex_drug_effectRunning", false];
	}, [
		_unit
	], 
	_timeToPlay	// Delay
] call CBA_fnc_waitAndExecute;



 [_unit] spawn {
 
         _aberat = ppEffectCreate ["ChromAberration", 250];
         _aberat ppEffectEnable true;
         enableCamShake true;
 
         while {_this select 0 getVariable ["RAA_acex_drug_effectRunning", false]} do
         {
          _pprandom = random [2, 4, 10];
             addCamShake [1,(_pprandom),33];
             _aberat ppEffectAdjust[1, 0.8, true];
             _aberat ppEffectCommit (_pprandom);
             sleep _pprandom;
             addCamShake [1,4,33];
             _aberat ppEffectAdjust[0, 0, true];
             _aberat ppEffectCommit _pprandom;
             sleep (19 + random 25);
        };
         _aberat ppEffectEnable false;
         ppEffectDestroy _aberat;
         enableCamShake false;
 };
 
 
 /*
 [_unit] spawn {
                 while {_this select 0 getVariable ["RAA_acex_drug_effectRunning", false]} do
                 {
                  _tuse = ["tuse_1","tuse_2","tuse_3","tuse_4","tuse_5","tuse_6"] call BIS_fnc_selectRandom;
            playSound (_tuse);
                  sleep 10 + random 20;
               };
 };
 */
 
 
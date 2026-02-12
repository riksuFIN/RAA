#include "script_component.hpp"
/* File:	fnc_skipTimeWithHunger_local.sqf
 * Author: 	riksuFIN
 * Description:	Handles black screen and hunger/ thirst simulation of Skip Time with Hunger -zeus module
 *
 * Called from:	createZeusModules.sqf/ Time Skip With Hunger -module (remoteExec)
 * Local to: 	Client
 * Parameter(s):
 0:	Skipped hours						<NUMBER>
 1:	Skipped minutes					<NUMBER>
 2:	Simulate hunger growup during time-skip	<BOOL>
 3:	Consume FieldRation Items		<BOOL>
 4:	Easing of item consumption (0: auto, 1: no easing, 2: douple item's effect etc)		<NUMBER>
 5:	Custom Message for black-out scrn	<STRING>
 6:	Language of auto-filled text	<NUMBER, 0 for ENG, 1 for FIN>
 7:	Effect Zeus Screen				<BOOL>
 Returns:		Nothing
 * 
 * Example:
	[_this] call RAA_zeus_fnc_skipTimeWithHunger;
 */

if !(hasInterface) exitWith {};

params ["_skipHours", "_skipMins", "_simulate_hunger","_consumeItems", ["_itemEasing", 0] , ["_message", "Waiting for %1"],["_language", 0], ["_effectZeus", false], ["_extendedBlackout", 0]];

// Convert skipped time to hours
private _skipCombined = _skipHours + (_skipMins / 60);



/*
	// Exclude Zeus from effect if so choosen in dialog
if (!(isNull curatorCamera) && !_effectZeus) exitWith {
	if (GVAR(debug)) then {systemChat "Zeus excluded from black-out, exiting";};
};
*/

private _hasEffects = true;
if (!(isNull curatorCamera) && !_effectZeus) then {
	_hasEffects = false;
};


// Declare counted variables we need at end of this fnc
private _itemsConsumedDrink = 0;	// For end-of-timeskip message
private _itemsConsumedFood = 0;

if (_hasEffects) then {
	// Do effect
		// prepare amount of time skipped in text form for message
	private _timeText = "";
	if (_skipHours > 0) then {
		if (_skipMins > 0) then {	// Skipped x hour and x minutes
			_timeText = format ["%1 hours %2 minutes", floor _skipHours, floor _skipMins];
			if (_language isEqualTo 1) then {
				_timeText = format ["%1 tuntia %2 minuuttia", floor _skipHours, floor _skipMins];
			};
			
			
		} else {	// Skipped full hour, 0 minutes
			if (_skipHours == 0) then {
				_timeText = format ["%1 hour", floor _skipHours];	// Skipped 1 hour
				if (_language isEqualTo 1) then {
					_timeText = format ["%1 tunti", floor _skipHours];
				};
			} else {
				_timeText = format ["%1 hours", floor _skipHours];	// Skipped more than 1 hours
				if (_language isEqualTo 1) then {
					_timeText = format ["%1 tuntia", floor _skipHours];
				};
			};
		};
	} else {	// Skipped 0 hours, x minutes
		_timeText = format ["%1 minutes", floor _skipMins];
		if (_language isEqualTo 1) then {
			_timeText = format ["%1 minuuttia", floor _skipMins];
		};
	};

		// Put together full message to show during blackout
	_message = format [_message, _timeText];


	cutText [_message, "BLACK OUT", 3, true];		// Black-out player's screen



	// Handle end of black-out
	if (_simulate_hunger) then {
		private _hunger = player getVariable ["acex_field_Rations_hunger", 0]; 
		private _thirst = player getVariable ["acex_field_rations_thirst", 0]; 


		// Calculate how much to ease-up item usage if auto-adjustment was selected
		if (_itemEasing == 0) then {
			if (_skipHours <= 1) then {
				_itemEasing = 2;
			} else {
				if (_skipHours <= 6) then {
					_itemEasing = 3;
				} else {
						_itemEasing = _skipHours / 2;
					
				};
			};
			if (GVAR(debug)) then {systemChat format ["[RAA_zeus] Item usage easing was %1 times (calculated)", _itemEasing];};
			
		};
		
		
		//	Calculate how much hunger/ thirst would have rised during time skip.
		// Result divided by 2 to ease it a bit
		private _thirstCalc = _skipCombined / acex_field_rations_timeWithoutWater * 100 / _itemEasing + _thirst;
		private _hungerCalc = _skipCombined / acex_field_rations_timeWithoutFood * 100 / _itemEasing + _hunger;
		
		
		
		
		if (GVAR(debug)) then {systemChat format ["[RAA_Zeus] Hunger after timeskip: %1, Thirst: %2", _hungerCalc, _thirstCalc];};


		if ( _thirstCalc > 75 || _hungerCalc > 75) then {	// Above dangerous treshold
			if (_consumeItems) then {	// Consume fieldRation items until thirst/ hunger below treshold
				
				// Loop consuming items until below treshold
				while {_thirstCalc > 75 || _hungerCalc > 75} do {
					if (_thirstCalc > 75) then {
					//	private _consumedItemEffectAmount = [player, false] call RAA_zeus_fnc_consumeItem;
						private _consumedItemEffectAmount = [player, false] call EFUNC(common,consumeItem);
						if (_consumedItemEffectAmount == 0) then {	// Suitable item was not found, therefore artificially forgive rest of thirst
							_thirstCalc = 70;
						} else {
							_thirstCalc = (_thirstCalc - _consumedItemEffectAmount * _itemEasing) max 0;	// Ease up item consumption by increasing their normal effect value
							_itemsConsumedDrink = _itemsConsumedDrink + 1;
						};
					};
					
					if (_hungerCalc > 75) then {
					//	private _consumedItemEffectAmount = [player, true] call RAA_zeus_fnc_consumeItem;
						private _consumedItemEffectAmount = [player, true] call EFUNC(common,consumeItem);
						if (_consumedItemEffectAmount == 0) then {	// Suitable item was not found, therefore artificially forgive rest of hunger
							_hungerCalc = 70;
						} else {
							_hungerCalc = (_hungerCalc - _consumedItemEffectAmount * _itemEasing) max 0;	// Ease up item consumption by increasing their normal effect value
							_itemsConsumedFood = _itemsConsumedFood + 1;
						};
						
					};
					sleep 0.1;
				};
			} else {	// Items consumption was disabled, therefore simply cap hunger/ thirst to avoid outright killing players
				_thirstCalc = _thirstCalc min 60;
				_hungerCalc = _hungerCalc min 60;
			};
		};

		player setVariable ["acex_field_Rations_hunger", _hungerCalc, true];
		player setVariable ["acex_field_rations_thirst", _thirstCalc, true];

	};
} else {
	
	// Zeus ignores effects if so chosen in dialog
	if (GVAR(debug)) then {systemChat "Zeus excluded from black-out, exiting";};
};


if !(_hasEffects) exitWith {
	// Give Zeus a progress bar so they know exactly how much time before players can see again
	[
		"Blackout for players", 
		_extendedBlackout, 	// Time for progress bar to complete
		{true}, 			// Condition. Brogress bar closes if returns false
		{systemChat "Blackout ends now"},	// On success code
		{},	// On fail code
		[],	// Args
		false,	// Block mouse
		false,	// Block keyboard
		false		// Allow esc to cancel
	] call CBA_fnc_progressBar;
};



sleep _extendedBlackout;	// Wait to ensure server skips time and has time to sync it to clients


if (_simulate_hunger && _consumeItems) then {
	private _message2 = format ["While waiting you consumed %1 sips of drink and had %2 meal(s)", _itemsConsumedDrink, _itemsConsumedFood];
	if (_language isEqualTo 1) then {
		_message2 = format ["Odottaessa nautit %1 kulausta juomaa ja %2 välipalaa", _itemsConsumedDrink, _itemsConsumedFood];
	};
	cutText [_message2, "BLACK IN", 7, true];
} else {
	cutText [_message, "BLACK IN", 7, true];
};







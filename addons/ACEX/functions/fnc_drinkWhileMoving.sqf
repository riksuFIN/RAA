#include "script_component.hpp"
/* File: fnc_drinkWhileMoving.sqf
 * Author(s): riksuFIN
 * Description: Handles drinking action while moving. This is just a modified version of ACE's fnc_consumeItem.sqf
 * Called from: 
 * Local to:	
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
 *	[] call RAA_ACEX_fnc_drinkWhileMoving
*/


/*			THIS IS ORIGINAL HEADER FROM ACE3// field_rations/functions/fnc_consumeItem.sqf
			Pulled from Github at 3.6.2023
 * Author: mharis001, Glowbal, PabstMirror
 * Consumes an item. Creates a progress bar and handles relevant thirst/hunger values.
 *
 * Arguments:
 * 0: Target (not used) <OBJECT>
 * 1: Player <OBJECT>
 * 2: Item data <ARRAY>
 *    0: Item classname <STRING>
 *    1: Item config <CONFIG>
 *    2: Is item magazine <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objNull, ACE_player, "["ACE_WaterBottle_Empty", configFile >> "CfgWeapons" >> "ACE_WaterBottle_Empty", false]] call ace_field_rations_fnc_consumeItem
 *
 * Public: No
 */

params ["", "_player", "_consumeData"];
_consumeData params ["_consumeItem", "_config", "_isMagazine", "_isBeltItem"];

// Get consume time for item
private _consumeTime = getNumber (_config >> "acex_field_rations_consumeTime");

// Get restored values and replacement item
private _thirstQuenched = acex_field_rations_thirstQuenched * getNumber (_config >> "acex_field_rations_thirstQuenched");
private _hungerSatiated = acex_field_rations_hungerSatiated * getNumber (_config >> "acex_field_rations_hungerSatiated");
private _replacementItem = getText (_config >> "acex_field_rations_replacementItem");

// Create consume text for item
private _displayName = getText (_config >> "displayName");
private _consumeText = getText (_config >> "acex_field_rations_consumeText");

if (_consumeText == "") then {
    _consumeText = if (_hungerSatiated > 0) then {
        "Eating %1...";
    } else {
        "Drinking %1...";
    };
};

// Format displayName onto consume text
// Allows for common strings to be used for multiple items
_consumeText = format [_consumeText, _displayName];

// Get consume animation and sound for item
private _stanceIndex = ["STAND", "CROUCH", "PRONE"] find stance _player;

// Handle in vehicle when stance is UNDEFINED
if (vehicle _player != _player) then {_stanceIndex = 0};

private _consumeAnim = getArray (_config >> "acex_field_rations_consumeAnims") param [_stanceIndex, "", [""]];	// CONVERSION TO WALKABLE: This animation doesnt matter, just here for legacy reasons
private _consumeSound = getArray (_config >> "acex_field_rations_consumeSounds") param [_stanceIndex, "", [""]];

/*
private _soundPlayed = if (_consumeAnim != "" && {vehicle _player == _player && {!(_player call EFUNC(common,isSwimming))}}) then {
    // Store current weapon for resetting
    _player setVariable [QGVAR(previousWeaponIndex), [player] call FUNC(getFiremodeIndex)];
    [_player, _consumeAnim, 1] call EFUNC(common,doAnimation);
    false
} else {
    // No animation to sync sound to
    if (_consumeSound != "") then {
        playSound _consumeSound;
    };
    true
};*/
private _firemodeIndex = [player] call FUNC(getFiremodeIndex);
GVAR(soundPlayed) = if (_firemodeIndex isNotEqualTo -1 && {vehicle _player == _player && {!(_player call ace_common_fnc_isSwimming)}}) then {
	player action ["SwitchWeapon", player, player, -1];
	GVAR(timeStarted) = time;
	_consumeTime = _consumeTime + 2;	// It takes a little bit longer
	false
} else {
    // Weapon is already holstered, start animation immediately
    if (_consumeSound != "") then {
        playSound _consumeSound;
   };
	[_player, "RAA_ACEX_drinkMove"] call ace_common_fnc_doGesture;
	if (GVAR(debug)) then {systemChat format ["[RAA_ACEX] %1 playing gesture instantly", time];};
	true
};
_player setVariable [QGVAR(previousWeaponIndex), _firemodeIndex];



private _fnc_onSuccess = {
    params ["_args"];
    _args params ["_player", "_consumeItem", "_replacementItem", "_thirstQuenched", "_hungerSatiated", "", "", "", "_isMagazine", "_isBeltItem"];
    TRACE_1("Consume item successful",_args);

    // Remove consumed item
	 if (_isBeltItem) then {
		[_player, _consumeItem, _replacementItem, false, false] call EFUNC(beltSlot,beltSlot_doReplaceItem);
		
	 } else {
		 if (_isMagazine) then {
			  _player removeMagazineGlobal _consumeItem;
		 } else {
			  _player removeItem _consumeItem;
		 };
	
    // Add replacement item if needed
    if (_replacementItem != "") then {
        [_player, _replacementItem] call ace_common_fnc_addToInventory;
    };
	};
    // Handle thirst and hunger values
    if (_thirstQuenched > 0) then {
        private _thirst = _player getVariable ["acex_field_rations_thirst", 0];
        _player setVariable ["acex_field_rations_thirst", (_thirst - _thirstQuenched) max 0];
    };

	if (_hungerSatiated > 0) then {
		private _hunger = _player getVariable ["acex_field_rations_hunger", 0];
		_player setVariable ["acex_field_rations_hunger", (_hunger - _hungerSatiated) max 0];
	};
	 
	 // Select weapon player had selected before drinking
	_player action ["SwitchWeapon", _player, _player, (_player getVariable [QGVAR(previousWeaponIndex), -1])];
	
	["acex_rationConsumed", [_player, _consumeItem, _replacementItem, _thirstQuenched, _hungerSatiated, _isMagazine]] call CBA_fnc_localEvent;

	_player setVariable [QGVAR(previousWeaponIndex), nil];
	GVAR(soundPlayed) = nil;
	GVAR(timeStarted) = nil;
};

private _fnc_onFailure = {
	params ["_args"];
//	_args params ["_player", "_consumeItem"];
	_args params ["_player", "_consumeItem", "", "", "", "", "", "", "", "_isBeltItem"];
	TRACE_1("Consume item failed",_args);
	
	
	[_player, _consumeItem, _isBeltItem] call EFUNC(common,dropItemOnGround);
	
	["In a hurry you dropped your drink", false, 10, 3] call ace_common_fnc_displayText;
	
	/*
	// Reset animation if needed
		if (vehicle _player == _player && {!(_player call ace_common_fnc_isSwimming)}) then {
		private _previousWeaponIndex = _player getVariable [QGVAR(previousWeaponIndex), 300];
		if (_previousWeaponIndex != "") then {
			[_player, _previousWeaponIndex, 2] call ace_common_fnc_doAnimation;
		};
	};
	*/
	_player setVariable [QGVAR(previousWeaponIndex), nil];
	GVAR(soundPlayed) = nil;
	GVAR(timeStarted) = nil;
};

private _fnc_condition = {
	params ["_args"];
	_args params ["_player", "_consumeItem", "", "", "", "_consumeAnim", "_consumeSound", "", "_isMagazine", "_isBeltItem"];
	
//	if (GVAR(soundPlayed) && gestureState _player isNotEqualTo "<none>") exitWith {
	if (GVAR(soundPlayed) && _player call FUNC(getFiremodeIndex) > -1) exitWith {
		if (GVAR(debug)) then {systemChat format ["[RAA_ACEX] %1 Player draw weapon %2, dropping bottle", time, _player call FUNC(getFiremodeIndex)];};
		false
	};
	
    // Attempt to sync sound with animation start
    //if (!_soundPlayed && {_consumeSound != "" && {_consumeAnim == "" || {animationState _player == _consumeAnim}}}) then {
   // if (!_soundPlayed && {[_player] call FUNC(getFiremodeIndex) isEqualTo -1}) then {
   // if (!GVAR(soundPlayed) && {[_player] call FUNC(getFiremodeIndex) isEqualTo -1}) then {
	if (!GVAR(soundPlayed) && {gestureState _player isEqualTo "<none>"} && {[_player] call FUNC(getFiremodeIndex) isEqualTo -1} && {time - GVAR(timeStarted) > 1}) then {
		if (_consumeSound != "") then {
			playSound _consumeSound;
		};
		[_player, "RAA_ACEX_drinkMove"] call ace_common_fnc_doGesture;
		GVAR(soundPlayed) = true;
		
		if (GVAR(debug)) then {systemChat format ["[RAA_ACEX] %1 playing gesture", time];};
	};
	
	
	if (_isMagazine) exitWith {
		 _consumeItem in magazines _player // return
	};
	if (_isBeltItem) exitWith {
		[_consumeItem, _player] call EFUNC(beltSlot,beltSlot_hasItem) // return
	};

	_consumeItem in (_player call ace_common_fnc_uniqueItems) // return
};

/*
[
    _consumeTime,
    [
        _player,
        _consumeItem,
        _replacementItem,
        _thirstQuenched,
        _hungerSatiated,
        _consumeAnim,
        _consumeSound,
        _soundPlayed,
        _isMagazine
    ],
    _fnc_onSuccess,
    _fnc_onFailure,
    _consumeText,
    _fnc_condition,
   // ["isNotInside"]
    []
] call ace_common_fnc_progressBar;
*/
[
	_consumeText, 		// Title
	_consumeTime, 		// Duration
	_fnc_condition, 	// Condition
	_fnc_onSuccess, 	// onSuccess
	_fnc_onFailure,	// onFail
	[						// Args
		_player,
		_consumeItem,
		_replacementItem,
		_thirstQuenched,
		_hungerSatiated,
		_consumeAnim,
		_consumeSound,
		false,
		_isMagazine,
		_isBeltItem
	],
	false,			// Block mouse
	false,			// Block keys
	true				// Allow close
] call CBA_fnc_progressBar;
#include "script_component.hpp"
/* File: fnc_beltSlot_doDrinkFromBelt.sqf
 * Author(s): riksuFIN
 * Description: Modified version of ACE's fnc_consumeItem.sqf to support item on belt
 *
 * Called from: ACE action
 * Local to:	Client
 * Parameter(s):
 0:	Target (Not used)
 0:	Unit <OBJECT, default player>
 1:	Slot to use item from <NUMBER, default -1 (unspecified)>
 2:	
 3:	
 4:	
 *
 Returns: 
 *
 * Example:	[] call RAA_beltSlot_fnc_beltSlot_doDrinkFromBelt
*/

(_this select 0) params ["", ["_player", ACE_player], ["_slot", -1]];

if (GVAR(debug)) then {systemChat format ["[RAA_beltslot] %1", _this];};

private _beltItems = _player getVariable [QGVAR(data), []];

private _beltSlot = _beltItems param [_slot, []];
private _consumeItem = _beltSlot param [0, ""];
if (_consumeItem isEqualTo "") exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_beltSlot] Consumed item does not exist!";};
};

if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Consuming item %1 slot %2", _consumeItem, _slot];};
private _config = configFile >> "CfgWeapons" >> _consumeItem;

// Get consume time for item
private _consumeTime = getNumber (_config >> "acex_field_rations_consumeTime");

// Get restored values and replacement item
private _thirstQuenched = acex_field_rations_thirstQuenched * getNumber (_config >> "acex_field_rations_thirstQuenched");
//private _hungerSatiated = XGVAR(hungerSatiated) * getNumber (_config >> QXGVAR(hungerSatiated));		// Eateable items not supported yet
private _hungerSatiated = 0;
private _replacementItem = getText (_config >> "acex_field_rations_replacementItem");

// Create consume text for item
private _displayName = getText (_config >> "displayName");
private _consumeText = getText (_config >> "acex_field_rations_consumeText");

if (_consumeText == "") then {
	_consumeText = "Drinking from %1...";
	/*
    _consumeText = if (_hungerSatiated > 0) then {
        LLSTRING(EatingX);
    } else {
        LLSTRING(DrinkingX);
    };
	 */
};


// Format displayName onto consume text
// Allows for common strings to be used for multiple items
_consumeText = format [_consumeText, _displayName];

// Get consume animation and sound for item
private _stanceIndex = ["STAND", "CROUCH", "PRONE"] find stance _player;

// Handle in vehicle when stance is UNDEFINED
if (isNull objectParent _player) then {_stanceIndex = 0};

private _consumeAnim = getArray (_config >> "acex_field_rations_consumeAnims") param [_stanceIndex, "", [""]];
private _consumeSound = getArray (_config >> "acex_field_rations_consumeSounds") param [_stanceIndex, "", [""]];

private _soundPlayed = if (_consumeAnim != "" && {vehicle _player == _player && {!(_player call ace_common_fnc_isSwimming)}}) then {
    // Store current animation for resetting
    _player setVariable ["ace_field_rations_previousAnim", animationState _player];
    [_player, _consumeAnim, 1] call ace_common_fnc_doAnimation;
    false
} else {
    // No animation to sync sound to
    if (_consumeSound != "") then {
        playSound _consumeSound;
    };
    true
};


// Custom code for belt items:
private _objectOnBelt = _beltSlot param [3, objNull];

_objectOnBelt hideObjectGlobal true;



private _fnc_onSuccess = {
    params ["_args"];
    _args params ["_player", "_consumeItem", "_replacementItem", "_thirstQuenched", "_hungerSatiated", "", "", "", "_objectOnBelt", "_slotToUse"];
	 if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Consumed item %1", _args];};
	 
    _objectOnBelt hideObjectGlobal false;
    
    // Add replacement item if needed
    if (_replacementItem != "") then {
		
		// Replace object on belt info
		private _beltSlots = _player getVariable [QGVAR(data), []];
		
		private _config = configFile >> "CfgWeapons" >> _replacementItem;
		private _picture = getText (_config >> "picture");
		private _displayName = getText (_config >> "displayName");
		private _weight = getNumber (_config >> "ItemInfo" >> "mass");
		private _weightOld = (_beltSlots param [_slotToUse, []]) param [4, 0];
		private _canDrink = (getNumber (_config >> "acex_field_rations_thirstQuenched")) > 0;
		
		
		_beltSlots set [_slotToUse, [_replacementItem, _picture, _displayName, _objectOnBelt, _weight, _canDrink]];
		_player setVariable [QGVAR(data), _beltSlots];
		
		
		// Update virtual weight
		if (_weightOld > 0) then {
			[_player, _player, (_weightOld - _weight) * -1] call ace_movement_fnc_addLoadToUnitContainer;
//			[_player, _player, _weightOld * -1] call ace_movement_fnc_addLoadToUnitContainer;
//			[_player, _player, _weight] call ace_movement_fnc_addLoadToUnitContainer;
		};
		
		// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE]]
    };
	
	
    // Handle thirst and hunger values
    if (_thirstQuenched > 0) then {
        private _thirst = _player getVariable ["acex_field_rations_thirst", 0];
        _player setVariable ["acex_field_rations_thirst", (_thirst - _thirstQuenched) max 0];
    };

    ["acex_rationConsumed", [_player, _consumeItem, _replacementItem, _thirstQuenched, _hungerSatiated]] call CBA_fnc_localEvent;

    _player setVariable ["ace_field_rations_previousAnim", nil];
};

private _fnc_onFailure = {
    params ["_args"];
    _args params ["_player", "", "", "", "", "", "", "", "_objectOnBelt"];
//    TRACE_1("Consume item failed",_args);
	if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Consume item failed %1", _args];};

    // Reset animation if needed
    if (isNull objectParent _player && {!(_player call ace_common_fnc_isSwimming)}) then {
        private _previousAnim = _player getVariable ["ace_field_rations_previousAnim", ""];
        if (_previousAnim != "") then {
            [_player, _previousAnim, 2] call ace_common_fnc_doAnimation;
        };
    };
	 
	 _objectOnBelt hideObjectGlobal false;
    _player setVariable ["ace_field_rations_previousAnim", nil];
};

private _fnc_condition = {
    params ["_args"];
    _args params ["_player", "_consumeItem", "", "", "", "_consumeAnim", "_consumeSound", "_soundPlayed"];

    // Attempt to sync sound with animation start
    if (!_soundPlayed && {_consumeSound != "" && {_consumeAnim == "" || {animationState _player == _consumeAnim}}}) then {
        playSound _consumeSound;
        _args set [7, true];
    };

   // _consumeItem in (_player call ace_common_fnc_uniqueItems))
		true
};

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
		  _objectOnBelt,
		  _slot
    ],
    _fnc_onSuccess,
    _fnc_onFailure,
    _consumeText,
    _fnc_condition,
    ["isNotInside"]
] call ace_common_fnc_progressBar;


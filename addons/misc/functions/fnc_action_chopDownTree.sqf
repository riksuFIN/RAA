#include "script_component.hpp"
/* File: action_chopDownTree.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call RAA_misc_fnc_action_chopDownTree
*/
params ["_player", ["_isDelimbing", false]];


// Find which item will be simulated, most effective one first
private _delay = 30;
private _sound = "";
private _soundDistance = 50;
private _useText = "";
private _anim = "baseConstructionB_loop";
//private _useSFX = false;

private _inventoryItems = [_player] call ace_common_fnc_uniqueItems;
if ("RAA_chainsaw" in _inventoryItems) then {
	_delay = RAA_misc_woodCuttingTime_chainsaw;
	_sound = "RAA_sound_chainsaw_01";
	_soundDistance = 1000;
	_useText = "Sawing down tree with chainsaw";
	_anim = "RAA_anim_chainsaw_01";
//	_useSFX = true;
} else {
	if ("RAA_axe" in _inventoryItems) then {
		_delay = RAA_misc_woodCuttingTime_axe;
		_sound = "RAA_sound_axe_01";
		_soundDistance = 150;
		_useText = "Chopping down tree with axe";
	//	_useSFX = true;
		
	} else {
		if ("ACE_EntrenchingTool" in _inventoryItems) then {
			_delay = RAA_misc_woodCuttingTime_shovel;
			_sound = "RAA_sound_axe_01";
			_soundDistance = 100;
			_useText = "Chopping down tree with Entrenching Tool";
		//	_useSFX = true;
			
		};
	};
};



private _treeArray = nearestTerrainObjects [_player, ["Tree"], 10, true, true];
private _tree = _treeArray select 0;

// If nearest object is already hidden tree try again two times 
if (isObjectHidden _tree) then {
	_tree = _treeArray select 1; 
	if (isObjectHidden _tree) then {
		_tree = _treeArray select 2; 
	};
};
// Check if third tree is still hidden one, if so give up
if (isObjectHidden _tree) exitWith {
	systemChat "No suitable trees nearby"
};





if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Tree: %1", _tree];};

//if (_useSFX) then {
// Randomized sound effect created from several short sounds
private _soundSource = createSoundSource [_sound, position _player, [], 0];
[
	_delay, 
	[
		_player,
		_soundSource,
		_tree
	], 
	{
		[_this select 0 select 0, _this select 0 select 2] call FUNC(DoChopDownTree);
		deleteVehicle (_this select 0 select 1);
		if (RAA_misc_debug) then {systemChat "[RAA_misc] CuttingTree ProgressBar: Success";};
	}, {
		[_this select 0 select 0, "", 2] call ace_common_fnc_doAnimation;
		deleteVehicle (_this select 0 select 1);
		if (RAA_misc_debug) then {systemChat "[RAA_misc] CuttingTree ProgressBar: Cancelled by user";};
	}, 
	_useText
] call ace_common_fnc_progressBar;
/*
	
} else {
	// Fixed sound effect for chainsaw
	[_player, _sound, _soundDistance] call RAA_fnc_ACEA_3dSound;
	[_delay, [_player], {[_this select 0 select 0] call RAA_misc_fnc_doChopDownTree}, {[_this select 0 select 0, "", 2] call ace_common_fnc_doAnimation;}, _useText] call ace_common_fnc_progressBar;
};
*/



[_player, _anim, 2] call ace_common_fnc_doAnimation;






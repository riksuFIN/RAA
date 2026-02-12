/* File: canChopDownTree.sqf
 * Author(s): riksuFIN
 * Description: Checks if player can use axe/ fortify tool/ chainsaw to chop down a nearby tree
 *
 * Called from: ACE action
 * Local to: 	Client
 * Parameter(s):
 0:	Unit near who tree is searched for <OBJECT>
 1:	Wants to delimb tree rather than cut it
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example(s):	[player, false] call RAA_misc_fnc_canChopDownTree
*/

params [["_player", player], ["_isDelimbing", false]];

private _inventoryItems = [_player] call ace_common_fnc_uniqueItems;

// If player has none of these items exit
if !("ACE_EntrenchingTool" in _inventoryItems || "RAA_axe" in _inventoryItems || "RAA_chainsaw" in _inventoryItems) exitWith {
	
	false
};


private _trees = nearestTerrainObjects [_player, ["Tree"], 5, true, true];
private _exitResult = false;
if (count _trees > 0) then {
	// Seperate chopping and delimbing actions
	if (_isDelimbing) then {
		if (damage (_trees param [0, objNull]) > 0.9) then {
			_exitResult = true
		} else {
			_exitResult = false
		};
	} else {
		_exitResult = true
	};
};

_exitResult
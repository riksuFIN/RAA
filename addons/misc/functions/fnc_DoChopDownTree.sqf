/* File: axe.sqf
 * Author(s): riksuFIN
 * Description: Handles axe/ motorsaw item to chop down nearest tree/ bush
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Tree to be chopped down
 *
 Returns:
 *
 * Example:	[player] call RAA_misc_fnc_DoChopDownTree
 				[player, cursorObject] call FUNC(DoChopDownTree)
*/

params ["_player", "_tree"];






if (random 100 > 95) then {
	private _anim = selectRandom [
		"Acts_Ambient_Gestures_Sneeze",
		"Acts_Ambient_Aggressive"
	];
	
	[_player, _anim, 2] call ace_common_fnc_doAnimation;
	
	[	{
			[_player, "", 2] call ace_common_fnc_doAnimation;
		}, [],
		4
	] call CBA_fnc_waitAndExecute;
	
	
} else {
	[_player, "", 2] call ace_common_fnc_doAnimation;
};



// See if we have to chop down a tree or delimb it
if (damage _tree < 0.9) then {
	// Cut it down!
	[_tree, 1, true, _player] remoteExec ["setDamage", 2];		// Must be executed on server to ensure it falls in right direction
//	_tree setDamage [1, true, _player];
	if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Chopped down tree %1", _tree];};
	
} else {
	// Delimb it
	
	[_tree, true] remoteExec ["hideObjectGlobal", 2];	// Hide tree since it cannot be deleted
	
	if (["CUP_Editor_Plants_Config"] call ace_common_fnc_isModLoaded) then {
		private _trunk = createVehicle ["CUP_kmen_1_buk", getPos _tree, [], 0, "CAN_COLLIDE"];	// Create object trunk which we can modify
		
		_trunk setPosASL (getPosASL _tree);
		_trunk setDir (getDir _tree - 180);	// Turn trunk facing same direction as fallen tree, but flipped 180 degrees
		
		if (RAA_misc_debug) then {systemChat format ["[RAA_misc] Stripped tree %1 and replaced with %2", _tree, _trunk];};
	};
};



/*
[	{
		(_this select 0) setDamage 1;
	}, 
		[_tree],
	3
] call CBA_fnc_waitAndExecute;
*/





/* NOTE s
Trees cannot be deleted with deleteVehicle, only hidden via hideObject
Cannot be moved via setPos
getDir gives direction facing sideways from trunk

"CUP_kmen_1_buk"	// Fallen tree trunk stripped


private _action = ["resupplyaction","Request Resupply","",{call zafw_fnc_resupply_action},{true}] call ace_interact_menu_fnc_createAction;

trunk1 setDir (getDir tree1 - 180)
*/
#include "script_component.hpp"
/* File: fnc_beltSlot_getChildrens.sqf
 * Author(s): riksuFIN
 * Description: Get children actions for ACE action menu
 *
 * Called from: ACE action menu
 * Local to:	Client
 * Parameter(s):
 0:	Unit who's inventory we're looking <OBJECT, default player>
 1:	
 2:	
 3:	
 4:	
 *
 Returns: List of childrens for action menu
 *
 * Example:	[player] call RAA_misc_fnc_beltSlot_getChildrens
*/
/*
Result:
0.0997 ms
*/

params [["_unit", ACE_player]];


private _actions = [];
private _cfgWeaponsBase = configFile >> "CfgWeapons";
private _cfgMagazinesBase = configFile >> "CfgMagazines";
{
//private _configToSearch = "ItemInfo" >> "mass";

// Filter out too small items to avoid cluttering menu


private _cfgWeapons = _cfgWeaponsBase >> _x;
private _cfgMagazines = _cfgMagazinesBase >> _x;
private _config = _cfgWeapons;
	
	if ((getNumber (_cfgWeapons >> "ItemInfo" >> "mass")) > 22 || (getNumber (_cfgWeapons >> "acex_field_rations_thirstQuenched")) > 0 || {(getNumber (_cfgMagazines >> "mass")) > 22}) then {
		
				//	if (getNumber (_config >> "mass")) > 22) then {
		
		// getNumber (configFile >> "CfgWeapons" >> _cfgWeapons >> "ACE_tourniquet" >> "ItemInfo" >> "mass")
		if ((getNumber (_cfgMagazines >> "mass")) > 0) then {
			_config = _cfgMagazines;
		} else {
			_config = _cfgWeapons;
		};
		
		
		private _displayName = getText (_config >> "displayName");
		private _picture = getText (_config >> "picture");
		
		
		private _action = [_x, _displayName, _picture, {_this call FUNC(beltSlot_doMoveToBelt)}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
	//	_actions pushBack [_action, [], _unit];
		_actions pushBack [_action, [], _unit];
		
		
	};
	
	
} forEach ((_unit call ace_common_fnc_uniqueItems) + magazines _unit);



_actions
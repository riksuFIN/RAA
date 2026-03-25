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

params [["_unit", ACE_player]];


private _actions = [];
private _cfgWeaponsBase = configFile >> "CfgWeapons";
private _cfgMagazinesBase = configFile >> "CfgMagazines";
private _items = +(_unit call ace_common_fnc_uniqueItems);
//_items append magazines _unit;
if (GVAR(enabled_headgearAction)) then {_items pushBackUnique headgear _unit};
//_items append magazines _unit;
if (enabled_headgearAction) then {_items pushBackUnique headgear _unit};

{
	// Handle general items
	private _cfgWeapons = _cfgWeaponsBase >> _x;
	private _cfgMagazines = _cfgMagazinesBase >> _x;
	private _config = _cfgWeapons;
	
	if ((getNumber (_cfgWeapons >> "ItemInfo" >> "mass")) > 22 || (getNumber (_cfgWeapons >> "acex_field_rations_thirstQuenched")) > 0 || {(getNumber (_cfgMagazines >> "mass")) > 22}) then {
		
		if ((getNumber (_cfgMagazines >> "mass")) > 0) then {
			_config = _cfgMagazines;
		} else {
			_config = _cfgWeapons;
		};
		
		private _displayName = getText (_config >> "displayName");
		private _picture = getText (_config >> "picture");
		
		private _action = [_x, _displayName, _picture, {["", _player, (_this select 2)] call FUNC(beltSlot_doMoveToBelt)}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _unit];
		
	};
	
} forEach _items;


// Handle magazines
{
	_x params ["_classname", "_ammoCount", "_isLoaded", "_type", "_location"];
	private _cfgMagazines = _cfgMagazinesBase >> _classname;
	if (!_isLoaded && (getNumber (_cfgMagazines >> "mass")) > 22) then {
		
		private _displayName = getText (_cfgMagazines >> "displayName");
		private _picture = getText (_cfgMagazines >> "picture");
		
		private _action = [_classname, format ["%1 (%2)", _displayName, _ammoCount], _picture, {["", _player, (_this select 2 select 0), false, -1, -1, (_this select 2 select 1)] call FUNC(beltSlot_doMoveToBelt);}, {true}, {}, [_classname, _ammoCount]] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _unit];

	};

} forEach magazinesAmmoFull _unit;





_actions

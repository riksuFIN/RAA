#include "script_component.hpp"
/* File: fnc_drinkWhileMoving_getChildren.sqf
 * Author(s): riksuFIN
 * Description: Gets children actions for ACE action menu. This is basically a modified version of ACE's fnc_getConsumeableChildren.sqf
 *
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
 *	[player] call RAA_ACEX_fnc_drinkWhileMoving_getChildren
*/

params ["_player"];

private _fnc_getActions = {

	[COMPNAME, GVAR(debug), "INFO", format ["fnc_drinkWhileMoving_getChildren Param: %1", _this]] call EFUNC(common,debugNew);

	private _actions = [];
	private _cfgWeapons = configFile >> "CfgWeapons";
	private _cfgMagazines = configFile >> "CfgMagazines";

	{
		_x params ["_config", "_items"];
		private _isMagazine = _config == _cfgMagazines;
		{
			private _itemConfig = _config >> _x;
			if (getNumber (_itemConfig >> "acex_field_rations_thirstQuenched") > 0/* || {getNumber (_itemConfig >> "ace_field_rations_hungerSatiated") > 0}*/) then {
			private _displayName = getText (_itemConfig >> "displayName");
			private _picture = getText (_itemConfig >> "picture");

			// Exec next frame so closing interaction menu doesn't block progressBar
			private _action = [_x, _displayName, _picture, {[FUNC(drinkWhileMoving), _this] call CBA_fnc_execNextFrame}, {true}, {}, [_x, _itemConfig, _isMagazine, false]] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _player];
			};
		} forEach _items;
	} forEach [
		[_cfgWeapons, _player call ace_common_fnc_uniqueItems],
		[_cfgMagazines, [magazines _player] call ace_common_fnc_uniqueElements]
	];

	
	if (["RAA_beltSlot"] call ace_common_fnc_isModLoaded) then {
		{	// Items on belt
			private _itemConfig = _cfgWeapons >> _x;
			if (getNumber (_itemConfig >> "acex_field_rations_thirstQuenched") > 0 /*|| {getNumber (_itemConfig >> "ace_field_rations_hungerSatiated") > 0}*/) then {
			private _displayName = format ["%1 (On Belt)", getText (_itemConfig >> "displayName")];
			private _picture = getText (_itemConfig >> "picture");
			
			// Exec next frame so closing interaction menu doesn't block progressBar
			private _action = [_x, _displayName, _picture, {[FUNC(drinkWhileMoving), _this] call CBA_fnc_execNextFrame}, {true}, {}, [_x, _itemConfig, false, true]] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _player];
			};
		} forEach ([_player] call EFUNC(beltSLot,beltSlot_getItems));
	};


	_actions
};

[[], _fnc_getActions, _player, QGVAR(consumableActionsCache), 15, "cba_events_loadoutEvent"] call ace_common_fnc_cachedCall;

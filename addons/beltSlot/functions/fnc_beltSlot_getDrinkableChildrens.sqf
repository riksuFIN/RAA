#include "script_component.hpp"
/* File: fnc_beltSlot_getDrinkableChildrens.sqf
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
 * Example:	[player] call RAA_beltslot_fnc_beltSlot_getDrinkableChildrens
*/

params [["_unit", ACE_player]];



private _beltItems = _unit getVariable [QGVAR(data), []];
if (count _beltItems isEqualTo 0) exitWith {[]};



private _actions = [];
private _cfgWeapons = configFile >> "CfgWeapons"; 
{
//private _configToSearch = "ItemInfo" >> "mass";

	private _className = _x param [0, ""];
	private _config = _cfgWeapons >> _className;
	if (!(_className isEqualTo "") && (getNumber (_config >> "acex_field_rations_thirstQuenched") > 0)) then {
		
		
		
		if ((getNumber (_config >> "acex_field_rations_thirstQuenched")) > 0) then {
			
			private _displayName = format ["%1 (on Belt)", getText (_config >> "displayName")];
			private _picture = getText (_config >> "picture");
			
			
			private _action = [_x, _displayName, _picture, {[_this] call FUNC(beltSlot_doDrinkFromBelt)}, {true}, {}, _forEachIndex, nil, nil, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _unit];
			
			
		};
	};
	
} forEach _beltItems;



_actions
#include "script_component.hpp"
/* File: fnc_placeExplosive_getChildren.sqf
 * Author(s): riksuFIN
 * Description: Gets children actions for ACE action menu. Very much just a slighly modified version of
 						ACE's fnc_addExplosiveActions.sqf to use belt
 *
 * Called from: ACE Action menu
 * Local to:	Client
 * Parameter(s):
 * 0:	Player
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_beltSlot_fnc_placeExplosive_getChildren
*/

/*		ORIGINAL HEADER FROM ace/addons/explosives/functions/fnc_addExplosiveActions.sqf
 * Author: Garth 'L-H' de Wet, CAA-Picard, mharis001
 * Returns children actions for explosive magazines in the player's inventory.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [_player] call 
 *
 * Public: No
 */

[_this, {
    params ["_player"];

    private _cfgMagazines = configFile >> "CfgMagazines";
   // private _magazines = magazines _player;
	private _magazines = [_player] call FUNC(beltSlot_getItems);	// This returns anything there is, not just explosives, but they will be filtered out soon anyway
	

   private _actions = [];
   {
        private _config = _cfgMagazines >> _x;
        if (getNumber (_config >> "ace_explosives_Placeable") isEqualTo 1) then {
            private _name = getText (_config >> "displayNameShort");
            private _picture = getText (_config >> "picture");
            if (_name isEqualTo "") then {
                _name = getText (_config >> "displayName");
            };

            private _action = [_x,  _name, _picture, {[{_this call FUNC(placeExplosive)}, _this] call CBA_fnc_execNextFrame}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _player];
        };
   } forEach _magazines;

	_actions
}, ACE_player, QGVAR(placeExplosive), 30, "cba_events_loadoutEvent"] call ace_common_fnc_cachedCall;
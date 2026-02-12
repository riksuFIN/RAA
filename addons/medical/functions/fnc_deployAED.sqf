#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: Removes AED from inventory and deploys it on ground
 *
 * Called from: ACE action menu, ACE Medical menu
 * Local to:    Helper
 * Parameter(s):
 0:	
 1:	
 *
 Returns:
 *
 * Example:	[player] call RAA_fnc_ACEA_AED_deployitem
*/
params [["_player", ACE_player], [_patient, objNull]];

private _helper = ace_player;
if ("RAA_AED" in items ace_player) exitWith {
    ace_player removeItem "RAA_AED";
    private _aed = "RAA_Item_AED" createVehicle position _player;
    [_player, _aed] call ace_dragging_fnc_startCarry;
    [COMPNAME, GVAR(debug), "INFO", "%1, Deployed AED from your inventory."] call EFUNC(common,debugNew);
};


if ("RAA_AED" in items _patient) exitWith {
    _patient removeItem "RAA_AED";
    private _aed = "RAA_Item_AED" createVehicle position _player;
    [_player, _aed] call ace_dragging_fnc_startCarry;
    [COMPNAME, GVAR(debug), "INFO", format ["%1, Deployed AED from patients %1 inventory.", name _patient]] call EFUNC(common,debugNew);
};
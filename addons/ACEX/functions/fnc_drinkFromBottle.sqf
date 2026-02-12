#include "script_component.hpp"
/* File: fnc_drinkFromBottle.sqf
 * Author(s): riksuFIN
 * Description: An attempt to have water bottle model visible in hands when drinking
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
 * Example:	[] call RAA_acex_fnc_drinkFromBottle
*/



// https://github.com/acemod/ACE3/blob/master/addons/field_rations/functions/fnc_getConsumableChildren.sqf
//private _action = [_x, _displayName, _picture, {[FUNC(consumeItem), _this] call CBA_fnc_execNextFrame}, {true}, {}, _x] call EFUNC(interact_menu,createAction);


private _bottle = "ACE_WaterBottle_Item" createVehicle getPos player;


/*
ACE_WaterBottle
ACE_WaterBottle_Item
*/
[objNull, ACE_player, "ACE_WaterBottle"] call ace_field_rations_fnc_consumeItem;

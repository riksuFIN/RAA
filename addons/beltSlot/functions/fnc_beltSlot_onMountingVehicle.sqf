#include "script_component.hpp"
/* File: fnc_beltSlot_onMountingVehicle.sqf
 * Author(s): riksuFIN
 * Description: Handles player getting in/ out of vehicle (hides 3d models of items on belt)
 *
 * Called from: EventHandlers getInMan and getOutMan
 * Local to:	Client. Global effect
 * Parameter(s):
 0:	Unit <OBJECT, default player>
 1:	Get in <BOOL, default true>	True: Get in, False: Get out

 *
 Returns: Nothing
 *
 * Example:	[] call RAA_misc_fnc_beltSlot_onMountingVehicle
*/

// NOTE: This fnc was disabled from eventHandler (postInit) side due to Arma update 2.10 adding support for attachTo items while sitting in vehicles

params [["_unit", ACE_player], ["_getIn", true]];

// Get items on belt (array)
private _beltItems = _unit getVariable [QGVAR(data), []];

// Exit if nothing on belt
if (count _beltItems isEqualTo 0) exitWith {};


// Go through all items on belt and hide/ unhide them
private _object = objNull;
{
	_object = _x param [3, objNull];
	if !(isNull _object) then {
		if (_getIn) then {
		//	_object hideObjectGlobal true;
			[_object, true] remoteExec ["hideObject", 0];
			if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Hidd %1", _object];};
		} else {
		//	_object hideObjectGlobal false;
			[_object, false] remoteExec ["hideObject", 0];
			if (GVAR(debug)) then {systemChat format ["[RAA_beltSlot] Unhidd %1", _object];};
		};
	};
	
} forEach _beltItems;


// Array is:
// [[SLOT1_CLASSNAME, SLOT1_PICPATH, SLOT1_ITEMNAME, SLOT1_OBJECT, WEIGHT, DRINKABLE], [SLOT2_CLASSNAME, SLOT2_PICPATH, SLOT2_ITEMNAME, SLOT2_OBJECT, WEIGHT, DRINKABLE]]

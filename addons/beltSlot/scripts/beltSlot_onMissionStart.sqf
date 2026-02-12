#include "script_component.hpp"
/* File: beltSlot_onMissionStart.sqf
 * Author(s): riksuFIN
 * Description: Auto-moves first 2 drinkables to belt slot if enabled
 *
 * Called from: XEH_postInit/ waitUntill
 * Local to:	Client
 * Parameter(s): NONE
 *
 Returns: NOTHING
 *
 * Example:	
*/

// Exit if belt is already full
private _beltItems = player getVariable [QGVAR(data), []];
if (count _beltItems > 1) exitWith {};


private _cfgWeaponsBase = configFile >> "CfgWeapons";

private _countItems = 0;
{
	private _cfgWeapons = _cfgWeaponsBase >> _x;
	if ((getNumber (_cfgWeapons >> "acex_field_rations_thirstQuenched")) > 0) then {
		["", player, _x] call FUNC(beltSlot_doMoveToBelt);
	//	_countItems = _countItems + 1;
		INC(_countItems);
		
		if (GVAR(debug)) then {systemChat format ["[RAA_misc] Moved %1 to belt", _x];};
	};
	
	// There are only two belt slots so we're done once they're filled
	if (_countItems >= 2) then {
		break
	};
	
} forEach (items player);





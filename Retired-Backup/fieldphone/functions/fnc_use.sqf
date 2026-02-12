#include "script_component.hpp"
/* File: fnc_fieldphone_use.sqf
 * Author(s): riksuFIN
 * Description: Pick up and use earpiece (radio)
 *
 * Called from: ACE action
 * Local to:	Client
 * Parameter(s):
 * 0:	Phone object <OBJECT>
 * 1:	Use phone (False to stop using)	<BOOL>
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_object", "_use"];



private _radioID = [[_object] call acre_api_fnc_getVehicleRacks select 0] call acre_api_fnc_getMountedRackRadio;

if (_use) then {
	// Start using phone (pick up earpiece)
	[player, vehicle player, _radioID] call acre_sys_rack_fnc_startUsingMountedRadio;
	
	// Put speaker on right ear only
	[_radioID, "RIGHT" ] call acre_api_fnc_setRadioSpatial;
	
	// Set order of radio PTT's so that cable is always first
	private _ptt = [] call acre_api_fnc_getMultiPushToTalkAssignment;
	if (count _ptt > 1) then {
		// Only re-order radios if player has more than one
		private _radio = _ptt deleteAt (_ptt find _radioID);
		_ptt insert [0, [_radio]];
		[_ptt] call acre_api_fnc_setMultiPushToTalkAssignment;
	};
	
	// Automatically stop call if we're ones being called. Simplified behaviour from real one
	if (_object getVariable [QGVAR(ringing), false] && !(_object getVariable [QGVAR(ringing_origin), false])) then {
		[_object, false] call FUNC(doRing);
		
	};
	
	[_object, QGVAR(earpiece_pickup), 15] call EFUNC(common,3dSound);

	if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] Picked up %1", _radioID];};
	
} else {
	// Stop using phone (return earpiece)
	
	[player, vehicle player, _radioID] call acre_sys_rack_fnc_stopUsingMountedRadio;
	
	[_object, QGVAR(earpiece_return), 15] call EFUNC(common,3dSound);
	
	if (GVAR(debug)) then {systemChat "[RAA_fieldphone] Stopped using fieldphone"};
};

// ToDo: Add warning when walking too far away from radio?

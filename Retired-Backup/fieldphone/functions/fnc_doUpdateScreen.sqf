#include "script_component.hpp"
/* File: fnc_doUpdateScreen.sqf
 * Author(s): riksuFIN
 * Description: Handle updating digital display on phone
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	Phone object <OBJECT>
 * 1:	Screen ID to show <STRING>
 * 2:	isGlobal <BOOL, default false>
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[_object, "CONNECTED", false] call FUNC(doUpdateScreen)
*/
params ["_object", "_imageID", "_isGlobal"];


private _img = QPATHTOF(pics\phone_idle.paa);
switch (_imageID) do {
	case ("CONNECTED"): {
		private _chnl = _object getVariable QGVAR(connected);
		_img = format [QPATHTOF(pics\connected_%1.paa), _chnl];
	};
	
	case ("DISCONNECTED"): {_img = QPATHTOF(pics\phone_disconnected.paa)};
	case ("CONNECTING"): {_img = QPATHTOF(pics\connecting.paa)};
	case ("CONNECTION_FAILED"): {_img = QPATHTOF(pics\connection_failed.paa)};
};


if (_isGlobal) then {
	_object setObjectTextureGlobal [1, _img];
} else {
	_object setObjectTexture [1, _img];
};



#include "script_component.hpp"
/* File: fnc_ringing_loop.sqf.sqf
 * Author(s): riksuFIN
 * Description: Handle cycling visual effect for ringing phone.
 						This includes flashing red indicator light
 *
 * Called from: fnc_doRing.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Object
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call fileName
*/
params ["_object"];

//if (GVAR(debug)) then {systemChat format ["[RAA_fieldphone] %1 ringing", _object];};


if !(_object getVariable [QGVAR(ringing), false]) exitWith {

	[_object, "CONNECTED", false] call FUNC(doUpdateScreen);
	//_object setObjectTexture [1,QPATHTOF(pics\phone_connected.paa)];
	
	if (GVAR(debug)) then {systemChat "[RAA_fieldphone] Ringing loop ended";};
};


// Cycle between two textures to create cycling image
private _img = QPATHTOF(pics\phone_ringing_1.paa);
private _cycle = _object getVariable [QGVAR(ringing_texture1), false];
if (_cycle) then {
	// We've got different textures for one calling and those being called to differiate between them
	if (_object getVariable [QGVAR(ringing_origin), false]) then {
		_img = QPATHTOF(pics\phone_calling_1.paa);
	} else {
		_img = QPATHTOF(pics\phone_ringing_1.paa);
	};
	
} else {
	
	if (_object getVariable [QGVAR(ringing_origin), false]) then {
		_img = QPATHTOF(pics\phone_calling_2.paa);
	} else {
		_img = QPATHTOF(pics\phone_ringing_2.paa);
	};
};

_object setObjectTexture [1, _img];
_object setVariable [QGVAR(ringing_texture1), !_cycle];


[	{
		_this call FUNC(ringing_loop);
	}, [
		_object
	],
	1
] call CBA_fnc_waitAndExecute;
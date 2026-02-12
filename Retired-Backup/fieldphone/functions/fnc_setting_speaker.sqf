#include "script_component.hpp"
/* File: fnc_setting_speaker.sqf
 * Author(s): riksuFIN
 * Description: Switches loudspeaker on or off
 *
 * Called from: ACE action
 * Local to:	Client
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
 *	[] call fileName
*/
params ["_object", "_speaker"];

_object setVariable [QGVAR(speaker), _speaker, true];


if (_object getVariable [QGVAR(connected), -1] < 0) exitWith {
	if GVAR(debug) then {systemChat "[RAA_fieldphone] Cable is not connected";};
};

// https://acre2.idi-systems.com/wiki/frameworks/functions-list#acre_api_fnc_setradioaudiosource
private _radioID = [[_object] call acre_api_fnc_getVehicleRacks select 0] call acre_api_fnc_getMountedRackRadio;

private _speakerType = ["HEADSET", "INTSPEAKER"] select _speaker;

// Set radio audio outlet
[_radioID, _speakerType] call acre_api_fnc_setRadioAudioSource;

/*
[radio1, "INTAUDIO"] call acre_api_fnc_setRadioAudioSource;
[radio1] call acre_api_fnc_getCurrentRadioChannelNumber; 
[RADIO1, 19] call acre_api_fnc_setRadioChannel;
[radio1, "RIGHT" ] call acre_api_fnc_setRadioSpatial;
radio1 = [[phone] call acre_api_fnc_getVehicleRacks select 0] call acre_api_fnc_getMountedRackRadio;


*/

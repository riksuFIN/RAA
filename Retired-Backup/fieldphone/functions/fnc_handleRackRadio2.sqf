#include "script_component.hpp"
/* File: fnc_handleRackRadio2.sqf
 * Author(s): riksuFIN
 * Description: Continuation of handleRackRadio.sqf
 						Split into two parts as a quick fix to unexcepted bug
 *
 * Called from: fnc_connectCable.sqf
 * Local to:	Client
 * Parameter(s):
 * 0:	Phone object <OBJECT>
 * 1:	Channel to connect to <NUMBER>	-1 to delete current radio
 * 2:	Radio Rack
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_fieldphone_fnc_handleRackRadio2
*/
params ["_object", "_channel", "_rack"];


// Now get radio we just mounted
private _mountedRadio = [_rack] call acre_api_fnc_getMountedRackRadio;
if (_mountedRadio isEqualTo "") exitWith {
	systemChat "[ERROR] Failed to mount radio to fieldphone";
	diag_log "[ERROR] Failed to mount radio to fieldphone";
};


_object setVariable [QGVAR(mountedRadioID), _mountedRadio, true];

// Set speaker on or off, depending on how was is defined by player.
private _speakerType = ["HEADSET", "INTSPEAKER"] select (_object getVariable [QGVAR(speaker), true]);

[_mountedRadio, _speakerType] call acre_api_fnc_setRadioAudioSource;


// Set channel
// Using group 2 of 148 to slightly try and "hide" used channel
// Possible channel values: 17 - 32	(15 channels)
[_mountedRadio, _channel + GVAR(channelOffset)] call acre_api_fnc_setRadioChannel;

// Set flag for other scripts that cable is connected
_object setVariable [QGVAR(connected), _channel, true];

// Update screen
//_object setObjectTextureGlobal [1,QPATHTOF(pics\phone_connected.paa)];
[_object, "CONNECTED", true] call FUNC(doUpdateScreen);

// Add this phone to list of connected phones in cable. This is used for ringing function
private _array = GVAR(connectedPhones) param [_channel, []];
_array pushBack _object;
GVAR(connectedPhones) set [_channel, _array];
publicVariable QGVAR(connectedPhones);


if (RAA_fieldphone_debug) then {systemChat format ["[RAA_fieldphone] Connected %1 to cable %2", _mountedRadio, _channel];};

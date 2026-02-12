#include "script_component.hpp"
/* File: fnc_setScreenPicture.sqf
 * Author(s): riksuFIN
 * Description: Used to set texture on screen. Only sends picture to nearby players unless otherwise defined via param
 						NOTE: If this script runs on server above behavior is true. If it runs on client will only update that client, UNLESS broadcast globally is true!
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	picture path <STRING>
 1:	object <OBJECT>
 2:	face to use <NUMBER, default 0
 3:	broadcast globally <BOOL, default false>	If false will only send update to nearby players, otherwise to everyone on server
 4:	
 *
 Returns: Successfull <BOOL>
 *
 * Example:	["r\misc\addons\RAA_zeus\pics\numbers\5.paa", cursorObject, 0] call RAA_zeus_fnc_animScreen_setScreenPicture
*/

params ["_picture", "_object", ["_face", 0], ["_broadcast", false]];

private _shareDistance = 15;


if (_broadcast) then {
	// Always broadcast picture globally if so chosen
		_object setObjectTextureGlobal [_face, _picture];
		true
} else {
	if (isServer) then {
		// We only send image to nearby players who can see screen
		
		private _targets = allPlayers inAreaArray [ASLToAGL getPosASL _object, _shareDistance, _shareDistance, 0, false, _shareDistance];
		if (_targets isEqualTo []) exitWith {
			if (RAA_zeus_debug) then {systemChat "[RAA_zeus] Picture failed to transmit: No targets"};
			false
		};
		
	//	["ace_medical_feedback_forceSay3D", [_unit, _soundToPlay, RAA_FRW_sharedSounds_distance * 2], _targets] call CBA_fnc_targetEvent;
		
		[_object, [_face, _picture]] remoteExec ["setObjectTexture", _targets];
		
		
		
		
		
	} else {
		// This script is run on client with broadcast false, only update that client
		_object setObjectTexture [_face, _picture];
		
	};
};


true
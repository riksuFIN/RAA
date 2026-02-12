#include "script_component.hpp"
/* File: fnc_takeDetonator.sqf
 * Author(s): riksuFIN
 * Description: Copies connected explosives from one player to another, allowing players to
 						swap detonators
 *
 * Called from: ACE action menu
 * Local to:	Client (who takes detonator)
 * Parameter(s):
 * 0:	Target who to take detonator from <OBJECT>
 * 1:	Unit who detonator will be added to <OBJECT>
 * 2:	Classname of detonator <STRING>
 * 3:	Let target player know someone took their detonator <BOOL, default true>
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_takeDetonator
*/
params ["_target", "_player", "_classname", ["_notifyTarget", true]];


//[[393019: mine_ap_miniclaymore.p3d,0.5,"Explosive code: 3","ClaymoreDirectionalMine_Remote_Mag","Command"],[393074: mine_slam_directional.p3d,0.5,"Explosive code: 4","SLAMDirectionalMine_Wire_Mag","MK16_Transmitter"]]
private _triggerType = getText (configFile >> "CfgWeapons" >> _className >> "ace_explosives_triggerType");
private _explosivesToTransfer = [];
private _connectedExplosives = _target getVariable ["ace_explosives_Clackers", []];
if (_connectedExplosives isEqualTo []) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_ACEA] No connected explosives";};
};



// Removing elements from array while looping would break forEach, so we deep-copy array for looping.
private _connectedExplosives2 = + _connectedExplosives;
{
	// Filter explosives connected to this detonator
	if (_x select 4 isEqualTo _triggerType) then {
		_explosivesToTransfer pushBack _x;
		_connectedExplosives deleteAt _forEachIndex;
	};
	
} forEach _connectedExplosives2;


// Move connected explosives over to player
private _playerExplosives = _player getVariable ["ace_explosives_Clackers", []];
_playerExplosives append _explosivesToTransfer;
_player setVariable ["ace_explosives_Clackers", _playerExplosives, true];

// Remove those explosives from original unit
_target setVariable ["ace_explosives_Clackers", _connectedExplosives, true];

if (GVAR(debug)) then {systemChat format ["[RAA_ACEA] Transferred %1 explosives and detonator %2. Target has %3 explosives remaining", count _explosivesToTransfer, _className, count _connectedExplosives];};

// Move detonator over to new owner
_target removeItem _className;
_player addItem _className;

systemChat format ["You took detonator connected to %1 explosives", count _explosivesToTransfer];

// Let target player know someone took their detonator
if (_notifyTarget) then {
	["ace_common_displayTextStructured", [format ["%1 took your detonator", [_player] call ace_common_fnc_getName], 1.5, _target], [_target]] call CBA_fnc_targetEvent;
};
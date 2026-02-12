#include "script_component.hpp"
/* File: fnc_tear_fabric.sqf
 * Author(s): riksuFIN
 * Description: Simulates tearing up uniform to get piece of fabric that can be used as a zip tie or makeshift bandage.
 *
 * Called from: ACE action menu 
 * Local to:	(tearer) Client. Target can be either local or remote.
 * Parameter(s):
 * 0:	Target <OBJECT, default ACE_player>
 * 1:	Caller (OBJECT, default ACE_player)
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_tear_fabric
*/

(_this select 0) params [["_player", ACE_player], ["_target", ACE_player]];

private _fabric_torn_times = _target getVariable [QGVAR(tear_fabric_times), 0];

[COMPONENT, GVAR(debug), "INFO", format ["Target %1's uniform has been torn %2 times out of %3", _target, _fabric_torn_times + 1, GVAR(tearFrabric_tearingTimesUntilDepleted)]] call EFUNC(common,debugNew);

// Safety in case multiple players are playing around with single uniform at once.
if (uniform _target isEqualTo "") exitWith {
	[str COMPONENT, GVAR(debug), "WARNING", format ["%1 is not wearing a uniform!", _target]] call EFUNC(common,debugNew);
};

// Exit if uniform's already been completely destroyed. This is only possible if uniform destruction is disabled (anti-grief setting)
if (_fabric_torn_times > GVAR(tearFrabric_tearingTimesUntilDepleted)) exitWith {
	[parseText format ["<t color='#384bc7'>%1</t>'s uniform has already been torn to pieces, there's nothing left.", name _target], false, 15, 3] call ace_common_fnc_displayText;
};


private _success = [_player, "RAA_torn_fabric", true] call CBA_fnc_addItem;


if (_fabric_torn_times >= GVAR(tearFrabric_tearingTimesUntilDepleted)) then {
	
	// This uniform has been depleted, destroy it (unless disabled as anti-grief measure)
	if !(GVAR(tearFrabric_disableUniformDestruction)) then {
		
		// Move over all items from uniform to ground
		private _weaponHolder = createVehicle ["GroundWeaponHolder", getPosATL _target, [], 1, "CAN_COLLIDE"];
		private _itemCargo = (getItemCargo (uniformContainer _target));
		{
			_weaponHolder addItemCargoGlobal [_x, _itemCargo select 1 select _forEachIndex];
		} forEach (_itemCargo select 0);
		
		private _magCargo = getMagazineCargo uniformContainer _target;
		{
			_weaponHolder addMagazineCargoGlobal [_x, _magCargo select 1 select _forEachIndex];
		} forEach (_magCargo select 0);
		
		// Add bit more remains of uniform to pile of garbage
		_weaponHolder addItemCargoGlobal ["RAA_torn_fabric", random floor 8];
		
		removeUniform _target;
		
		// Reset counter so that should player pick up new uniform that can be torn off as well
		_target setVariable [QGVAR(tear_fabric_times), 0, true];
	} else {
		// Uniform destruction is disabled, mark tearTimes so crazy high that future executions of this script will detect it
		_target setVariable [QGVAR(tear_fabric_times), 100, true];
	};
	
	// Let target know what just happend
	if (_target isEqualTo ACE_player) then {
		// Target is local player
		[parseText "<t color='#384bc7'>Your</t> uniform was torn to pieces.", false, 15, 3] remoteExec ["ace_common_fnc_displayText", _target];
		
	} else {
		// Target is anyone else than you
		[parseText format ["<t color='#384bc7'>%1</t>'s uniform has been torn to pieces.", name _target], false, 15, 3] call ace_common_fnc_displayText;
		
		if (isPlayer _target) then {
			// Target is non-local player, send message over network
			[parseText "<t color='#384bc7'>Your</t> uniform was torn to pieces.", false, 15, 3] remoteExec ["ace_common_fnc_displayText", _target];
		};
	};
	
	
} else {
	// Warn if this uniform is just about to break..
	if (_fabric_torn_times isEqualTo (GVAR(tearFrabric_tearingTimesUntilDepleted)- 1)) then {
		if (_target isEqualTo ACE_player) then {
			// You tore your own shirt
			[parseText "<t color='#384bc7'>Your</t> uniform is starting to look quite torn..", false, 15, 3] remoteExec ["ace_common_fnc_displayText", _target];
			
		} else {
			// You tore someone else's shirt
			[parseText format ["<t color='#384bc7'>%1</t>'s uniform is starting to look quite torn..", name _target], false, 15, 3] call ace_common_fnc_displayText;
			
			if (isPlayer _target) then {
				// You tore some other player's shirt
				[parseText "<t color='#384bc7'>Your</t> uniform is starting to look quite torn..", false, 15, 3] remoteExec ["ace_common_fnc_displayText", _target];
			};
		};
	};
	_target setVariable [QGVAR(tear_fabric_times), _fabric_torn_times + 1, true];
	
};
_target setVariable [QGVAR(tear_fabric_uniformClass), uniform _target, true];

if !(_success) then {
	[COMPONENT, GVAR(debug), "INFO", format ["Failed to add item to inventory!"]] call EFUNC(common,debugNew);
};
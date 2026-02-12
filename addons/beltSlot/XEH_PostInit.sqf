#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */








	// Client-side
if (hasInterface) then {
	
	
	// Handle auto-moving bottles to belt if enabled in setting
	// Wih delay to allow other scripts to spawn those bottles
	if (GVAR(enabled) && GVAR(autoMoveBottlesToBelt)) then {
		[	{
				execVM QPATHTOF(scripts\beltSlot_onMissionStart.sqf)
			}, [],
			5
		] call CBA_fnc_waitAndExecute;
	};
	
	/*		DISABLED since Arma 2.10 update enabled attached objects staying attached when entering vehicle
	// Add EH for get in/ get out of vehicles to hide bottle 3d models
	player addEventHandler ["GetInMan", {
		[_this select 0, true] call FUNC(beltSlot_onMountingVehicle);
	}];
	
	player addEventHandler ["GetOutMan", {
		[_this select 0, false] call FUNC(beltSlot_onMountingVehicle);
	}];
	*/
	
	
	// Inventory EH for beltSlot drag-and-drop system
	player addEventHandler ["InventoryOpened", {
		params ["_unit", "_container"];
		ace_player setVariable [QGVAR(beltSlot_openedContainer), _container];
	}];
	
	player addEventHandler ["InventoryClosed", {
		params ["_unit", "_container"];
		ace_player setVariable [QGVAR(beltSlot_openedContainer), objNull];
	}];
	
	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		call FUNC(onRespawn);
	}];

	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		call FUNC(onRespawn);
	}];
	
};



	// Server-side
if (isServer) then {
	
	// Fix for zeus' Belt items floating in air
	["zen_common_hideObjectGlobal", {
		params ["_object", "_hide"];
	//	_object hideObjectGlobal _hide;
	//	[_object, _hide] call FUNC(beltSlot_onMountingVehicle);
		[_object, _hide] remoteExec [QFUNC(beltSlot_onMountingVehicle), _object];
		// This is activaed on server, then remoteExec'd to client, who remoteExecs to everyone
		// Ineffecient, but best way I can think of to detect when Zeus goes invisible
		// (Uses ZEN event, which is only activated on server, while beltItems is client-side only)
		
	}] call CBA_fnc_addEventHandler;
	
	// Delete belt items if player is disconnected from server
	addMissionEventHandler ["HandleDisconnect", {
		if (GVAR(enabled)) then {
			params ["_unit", "_id", "_uid", "_name"];
			private _data = _unit getVariable [QGVAR(data), []];
			if (_data isNotEqualTo []) then {
				{
					deleteVehicle (_this param [3, objNull]);
				} forEach _data;
			};
		};
	}];
};





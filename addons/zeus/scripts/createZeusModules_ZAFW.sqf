#include "script_component.hpp"
/* File: createZeusModules_ZAFW.sqf
 * Author(s): riksuFIN
 * Description: Create Zeus modules that require Zantzan's Mission Making Framework to work
 *
 * Called from: XEH_PostInit
 * Local to: Client
 * Parameter(s): None
 *
 Returns:Nothing
 *
 */




if (zafw_resupply_enabled) then {
	if (isNil "RAA_zeus_zafw_refreshLoadouts") then {
		RAA_zeus_zafw_refreshLoadouts = false;
	};
	
	
	["ZAFW", "Fill crate with supplies", {
		params ["", "_object"];
		
		if ((maxLoad _object) isEqualTo 0) exitWith {
			["Must be placed on object with inventory storage!"] call zen_common_fnc_showMessage;
		};
		
		
		private _resupplyRefreshed = false;
		if ((RAA_zeus_zafw_refreshLoadouts isEqualTo true) && (isNil "zafw_resupply_magstoadd")) exitWith {
			[false] remoteExec ['zafw_fnc_resupply_inventoryinit', 0];
			["Resupply inventory refreshed! Replace module"] call zen_common_fnc_showMessage;
			systemChat "Gathering resupply inventory!";
			RAA_zeus_zafw_refreshLoadouts = false;
			[	{		// Condition
					!(isNil "zafw_resupply_magstoadd")
				}, {	// Code
					//	[_this select 0] call RAA_zeus_fnc_zafw_addSupplies;
						[_this select 0] call FUNC(createDialog_zafw_addSupplies);
				}, [	// Params
					_object
				],		// Timeout
				15,
				{		// Timeout code
				}
			] call CBA_fnc_waitUntilAndExecute;
		};
		
		
		if (isNil "zafw_resupply_magstoadd") exitWith {
			["Resupply inventory does not exist!"] call zen_common_fnc_showMessage;
			systemChat "Resupply inventory does not exist! Check that players have correct final loadouts and re-place module.";
			RAA_zeus_zafw_refreshLoadouts = true;	// Mark resupply inventory to be refreshed when module is placed next time
		};
		
		// Create dialog
	//	[_object] call RAA_zeus_fnc_zafw_createDialog_addSupplies;
		[_object] call FUNC(createDialog_zafw_addSupplies);
		
	},
//	"\r\misc\addons\RAA_zeus\pics\icon_supplies.paa"
	QPATHTOF(pics\icon_supplies.paa)
	] call zen_custom_modules_fnc_register;

};
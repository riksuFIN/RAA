#include "script_component.hpp"
/* File: fixMapMarkers.sqf
 * Author(s): riksuFIN
 * Description: Adds EventHandlers to update Zeus-placed markers.
 				Ducktape fix untill real culcript is found why 
				marker directions dont update to clients
 *
 * Called from: XEH_postInit.sqf
 * Local to: 	Client
 * Parameter(s):
 0:		
 1: 	
 2: 	
 *
 Returns:
 *
 * Example:	[] execVM fixMapMarker
 */

// params ["_unit", "_food"];


if !(hasInterface) exitWith {};


{
	_x addEventHandler ["CuratorMarkerPlaced", {
		params ["_curator", "_marker"];
		
		[	{
			params ["_marker"];
			_marker setMarkerDir (MarkerDir _marker);
			if (GVAR(debug)) then {systemChat "[RAA_zeus] Synced marker to other clients";};
			}, [
				_marker
			],
			1
		] call CBA_fnc_waitAndExecute;
		
	}];


	_x addEventHandler ["CuratorMarkerEdited", {
		params ["_curator", "_marker"];
		
		[	{
			params ["_marker"];
			_marker setMarkerDir (MarkerDir _marker);
			if (GVAR(debug)) then {systemChat "[RAA_zeus] Synced marker to other clients";};
			}, [
				_marker
			],
			1
		] call CBA_fnc_waitAndExecute;
	}];
	
} forEach allCurators;
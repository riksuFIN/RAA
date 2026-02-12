#include "script_component.hpp"
/* File:	fnc_teleportVehicle.sqf
 * Author: 	riksuFIN
 * Description:	Teleports given object(s) to cursor-selected position
 *						If only one object give, precise location is used.
 						If there are several objects they will be scattered nearby
 * Called from:	Various
 * Local to: 		Client
 * Parameter(s):
 0:	_objects		<ARRAY>		List of selected objects
 1:	
 2:	
 Returns:		Nothing
 * 
 * Example:
 */

params ["_objects"];

if (count _objects isEqualTo 0) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] No objects selected";};
};



titleText ["SELECT LOCATION\nShift: Teleport object 1 meter above surface\nALT: Flip object upright\nCTRL: Ignore collision avoidance", "PLAIN DOWN"];


[_objects, {	// Source object
	params ["_success","_objects","_pos", "_args", "_shiftState", "_controlState", "_altState"];
	if (_success) then {
		
		titleText ["", "PLAIN DOWN"];	// Clear text from screen
		
		{
			if (isDamageAllowed _x) then {
				_x allowDamage false;
				_x setVariable [QGVAR(damageAllowed), true];
			};
		} forEach _objects;
		
		// Flip objects upright if ALT is held
		if (_altState) then {
			{
				_x setVectorUp [0,0,1]
			} forEach _objects;
		};
		
		////////////////////////
		// If unit in vehicle is selected teleport that entire vehicle instead of single unit.
		
		
		
		
		
		
		
		////////////////////
		
		if (count _objects > 1) then {
			// Multiple objects are selected
			
			if (_controlState) then {
				// If ctrl is held while teleporting TP everything to same exact location without collision avoidance
				{
					
					_x setVelocity [0,0,0];
					_x setPosASL _pos;
					
				} forEach _objects;
				
			} else {
				_pos = ASLToATL _pos;	// Cursor-select location is in wrong format
				
				{	// Loop to teleport all objects
					_x setVelocity [0,0,0];
					_x setVehiclePosition [_pos, [], 0, "NONE"];
				} forEach _objects;
				
			};
		
		} else {
			// precisely place single object
			
			if (_shiftState) then {
				// If shift is pushed bring teleport pos of object up
				private _temp = _pos select 2;
				_temp = _temp + 1;
				_pos set [2, _temp];
			};
			
			(_objects select 0) setVelocity [0,0,0];
			(_objects select 0) setPosASL _pos;
		};
		
		
		
		
		// After teleport check each object's damage and repair if something took damage. Hopefully it's not too late yet
		[	{
				
				if (RAA_zeus_debug) then {systemChat format ["[RAA_zeus] Checking %1", _this];};
				{
					// In case object is sent flying, stop it. It's having way too much fun
					_x setVelocity [0,0,0];
					
					// Before teleporting taking damage was disabled as precaution
					if (_x getVariable [QGVAR(damageAllowed), false]) then {
						_x allowDamage true;
						_x setVariable [QGVAR(damageAllowed), nil];
					};
					
					
					/*
					// Go through all teleported objects and see if they took damage during tp
					if (damage _x > _x getVariable [QGVAR(damageBeforeTP), 0]) then {
						_x setDamage (_x getVariable [QGVAR(damageBeforeTP), 0]);
						_x setVariable [QGVAR(damageBeforeTP), nil];
						_x allowDamage true;
						systemChat format ["%1 took damage from teleport, repairing", _x];
					};
					*/
				} forEach _this;
			}, 
			_objects,
			2
		] call CBA_fnc_waitAndExecute;
		
		
		
		
		
		
		
		
		
		
		
		
		
	};
}, [], "Target Location"] call zen_common_fnc_selectPosition;


#include "script_component.hpp"
/* File: fnc_remoteControl_getChildrens.sqf
 * Author(s): riksuFIN
 * Description: Returns array for creating children options to Zeus' Remote Control Context menu
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	Objects selected <ARRAY>
 *
 Returns:	Array of controllable AI units <ARRAY>
 *
 * Example:	[_objects] call RAA_zeus_fnc_remoteControl_getChildrens
*/

params ["_objects", "_hoveredEntity"];

if (count _objects isEqualTo 1) then {
	_objects = [];	// Because cursor unit is always added via crew
};


// Add crew of hovered vehicle to list of units
{
	_objects pushBackUnique _x;
	
} forEach (crew _hoveredEntity);


private _actions = [];

// If only one unit is selected do not create childs
if ((count _objects isEqualTo 0) || (count _objects isEqualTo 1)) exitWith {[]};

{
	if ([_x] call zen_remote_control_fnc_canControl && _x isKindOf "CAManBase") then {
		
	//	private _name = name _x;
		private _name = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
		_name = format ["%1 (%2)", _name, name _x];
		
		private _icon = "";
		private _vehicle = vehicle _x;
		if !(_vehicle isEqualTo _x) then {
			// This unit is inside vehicle, lets check his role in it
			
			// TODO: Add code here to detect crew role of this unit and assign icon accordingly
			
			
			// Assign icon for crew roles
			switch (true) do {
				case ((commander _vehicle) isEqualTo _x): {
					_icon = "\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa";
				};
				case ((driver _vehicle) isEqualTo _x): {
					_icon = "\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
				};
				case ((gunner _vehicle) isEqualTo _x): {
					_icon = "\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa";
				};
				default { _icon = "\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa"};
			};
			
			
			
			
			/*
			\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa
			\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa
			\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa
			\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa
			
			
			\A3\Armor_F_Gamma\MBT_01\Data\UI\Slammer_Scorcher_M4_Base_ca.paa
			*/
		};
		
		
		
		
		
		private _action = [
			str _x,	// ActionName
			_name,		// DisplayName
			_icon,		// IconAndColor
			{				// Statement
				[_args] call zen_remote_control_fnc_start;
			},
			{true},		// Condition
			_x	// Arguments
		 ] call zen_context_menu_fnc_createAction;
		
		_actions pushBack [_action, [], 0];
	};
} forEach _objects;


_actions



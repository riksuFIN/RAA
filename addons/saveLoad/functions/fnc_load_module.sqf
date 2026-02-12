#include "script_component.hpp"
/* File: fnc_load_module.sqf
 * Author(s): riksuFIN
 * Description: Sanity checks load modules to make sure they're correct at mission start, to avoid any suprises when it's time to actually use them and something is missing
 *
 * Called from: module RAA_saveLoad_load_main
 * Local to:	Server
 * Parameter(s):
 * 0:	Module <OBJECT>
 * 1:	Nil
 * 2:	Nil
 * 3:	Do Load <BOOL, default true>		Set to false to only do sanity check without actually loading anything
 *
 Returns:  Nothing
 *
 * Example:	
 *	[] call RAA_saveLoad_fnc_load_module
*/
params [["_module", objNull], "", "", ["_doLoad", true]];

[COMPNAME, GVAR(debug), "INFO", format ["fnc_load_module executed with: %1", _this]] call EFUNC(common,debugNew);

if (isNull _module || typeOf _module isNotEqualTo QGVAR(module_load_main)) then {
	_module = entities QGVAR(module_load_main) param [0, objNull];
};

if (isNull _module || _module getVariable [QGVAR(save_key), ""] isEqualTo "") exitWith {
	[COMPNAME, true, "ERROR_G", format ["[DoLoad Sanity Check] ! FAIL ! (module not found or is invalid! %1)", _module], [true, true, true, true]] call EFUNC(common,debugNew);
};


if (count (entities QGVAR(module_load_main)) > 1) exitWith {
	[COMPNAME, true, "ERROR_G", format ["[DoLoad Sanity Check] ! FAIL ! (only one Load module is allowed! There are %1 modules)", count (entities QGVAR(load_main))]] call EFUNC(common,debugNew);
};


// Check blacklist modules
call FUNC(blacklist);


if (is3DENPreview || GVAR(debug)) then {systemChat "[RAA_SaveLoad] Load Sanity Check: SUCCESS!";};


if (_doLoad) then {
	// To avoid any potential conflicts with other scripts spawning stuff at very start of mission we delay ours a little
	[	{
			_this call FUNC(doLoad);
		}, 
			_module
		,
		8
	] call CBA_fnc_waitAndExecute;
	
	/*		DELETE THIS BLOCK
	[	{		// Condition
			time > 8
		}, {	// Code
			_this call FUNC(doLoad);
		}, 	// Params
			_module
		,		// Timeout
			-1,
		{		// Timeout code
			
		}
	] call CBA_fnc_waitUntilAndExecute;
	*/
};
#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description:

 * Called from: config.cpp/ XEH_postInit
 * Local to: Client
 * Scheduled
 */




// Create global variables
GVAR(allConvoys) = [];
GVAR(logicGroup) = grpNull;

//-------------------- Create Zeus modules ----------------------------------

["Convoy", "Create/ modify Convoy", {
	params ["_pos","_object"];
	
	[FUNC(createDialog_initConvoy)] call FUNC(createDialog_selectConvoy);
	
	
	
	
	//call FUNC(createDialog_initConvoy);
}

] call zen_custom_modules_fnc_register;






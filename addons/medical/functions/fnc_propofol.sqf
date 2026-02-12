#include "script_component.hpp"
/* File: fnc_propofol.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to:	
 * Parameter(s):
 * 0:	
 * 1:	
 * 2:	
 * 3:	
 * 4:	
 *
 Returns: 
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_propofol
*/

params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

_this remoteExec [QFUNC(propofol_local), _target];

[_target, "activity", format ["%1 used Propofol Syringe", name _caller], []] call ace_medical_treatment_fnc_addToLog;


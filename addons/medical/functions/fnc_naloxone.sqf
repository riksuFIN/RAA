#include "script_component.hpp"
/* File: fileName.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: 
 * Local to: 
 * Parameter(s):
 0:	
 1:	
 2:	
 3:	
 4:	
 *
 Returns:
 *
 * Example:	[] call fileName
*/
params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

_this remoteExec ["RAA_fnc_ACEA_naloxone_local", _target];

[_target, "activity", format ["%1 used Naloxone Autoinjector", name _caller], []] call ace_medical_treatment_fnc_addToLog;
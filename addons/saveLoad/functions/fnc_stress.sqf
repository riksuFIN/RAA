#include "script_component.hpp"
/* File: fnc_stress.sqf
 * Author(s): riksuFIN
 * Description: Stresstest
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
 *	[] call fileName
*/
params ["_loops"];

private _startTime = diag_tickTime;
diag_log format ["[RAA] STRESSTEST FNC STARTED AT %1", diag_tickTime];

for "_i" from 0 to _loops do {
	
	
	private _result = count (1 allObjects 0);
//	systemChat format ["%1 Execution #%2", diag_tickTime, _i, _result];
	diag_log format ["[RAA STRESSTEST] %1 Execution #%2 (result %3)", diag_tickTime, _i, _result];
};


systemChat format ["%3 STRESSTEST END, %1 loops took %2 seconds", _loops, diag_tickTime - _startTime, diag_tickTime];
diag_log format ["[RAA] STRESSTEST END, %1 loops took %2 seconds", _loops, diag_tickTime - _startTime];

#include "script_component.hpp"
/* File: fnc_beltSlot_redirect.sqf
 * Author(s): riksuFIN
 * Description: Redirects fnc call for old fnc RAA_misc_fnc_beltSlot_doMoveToBelt to new name RAA_beltSlot_fnc_beltSlot_doMoveToBelt
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
diag_log "[RAA_BeltSlot] Used depreciated function RAA_misc_fnc_beltSlot_doMoveToBelt. New function: RAA_beltSlot_fnc_beltSlot_doMoveToBelt";

if (GVAR(debug)) then {systemChat format ["[RAA_BeltSlot] Redirected RAA_misc_fnc_beltSlot_doMoveToBelt with %1", _this];};

_this call FUNC(beltSlot_doMoveToBelt);
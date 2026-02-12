#include "script_component.hpp"
/* File: fnc_clearAndRetry.sqf
 * Author(s): riksuFIN
 * Description: When everything breaks, run this and you have empty table of fire supports in front of you you can try to re-fill
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
 * Example:	[] call RAA_firesA_fnc_clearAndRetry
*/




RAA_firesA_gunTypes_west = [0,0,0,0,0];
RAA_firesA_gunTypes_east = [0,0,0,0,0];
RAA_firesA_gunTypes_resistance = [0,0,0,0,0];
RAA_firesA_gunTypes_civilian = [0,0,0,0,0];
RAA_firesA_customGunsAdded = false;	// This will be changed to true once pre-placed arty moduels are deleted (if there is any)
RAA_firesA_ammoModules_west = [];	// Will be format: [[[Ammo1ForGun1, ammoID], [Ammo2ForGun1, ammoID]], [[Ammo1ForGun2, ammoID], [Ammo2ForGun2, ammoID]]]  etc
RAA_firesA_ammoModules_east = [];
RAA_firesA_ammoModules_resistance = [];
RAA_firesA_ammoModules_civilian = [];

RAA_firesA_group_artyLogics = grpNull;	// This group will be used to spawn all gun and ammo modules

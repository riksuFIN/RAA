/* File: fnc_intel_dialogHandle_new.sqf
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
 * Example:	[] call RAA_zeus_fnc_intel_dialogHandle_new
 */

params ["_object", "_module_pos", "_dialogValues"];
_dialogValues params ["_faceToUse", "_requiredItem", "_requiredPlayer", "_failChance", "_intel_title", "_intel_text", "_retrievalType", "_intelSharedWith"];



// Set all variables to object and sync them in network
_object setVariable ["RAA_zeus_intel_requiredItem", _requiredItem, true];
_object setVariable ["RAA_zeus_intel_requiredPlayer", _requiredPlayer, true];
_object setVariable ["RAA_zeus_intel_failChance", _failChance, true];
_object setVariable ["RAA_zeus_intel_title", _intel_title, true];
_object setVariable ["RAA_zeus_intel_text", _intel_text, true];
_object setVariable ["RAA_zeus_intel_retrievalType", _retrievalType, true];
_object setVariable ["RAA_zeus_intel_sharedWith", _intelSharedWith, true];






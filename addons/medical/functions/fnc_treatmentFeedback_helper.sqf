#include "script_component.hpp"
/* File: fnc_treatmentFeedback_helper.sqf
 * Author(s): riksuFIN
 * Description: First part of letting uncon player know when they're being treated.
 						This file is run on treater's side.
 *
 * Called from: CBA EventHandler "ace_treatmentStarted", set up from CBA_Settings
 * Local to:	Client (who's treating people)
 * Parameter(s):
 * 	Data from EH
 *
 Returns: Nothing
 *
 * Example:	
 *	[] call RAA_ACEA_fnc_treatmentFeedback_helper
*/

params ["_caller", "_target"];
// [zeus,B Alpha 1-5:2,"rightarm","ApplyTourniquet",zeus,"ACE_tourniquet"]

// This fnc will run every time someone is being treated, so kick out AI patients
if !(isPlayer _target) exitWith {};

// Conscious players dont see dreams
if (_target call ace_common_fnc_isAwake) exitWith {};



// Move over to next funcion, which is local to patient
[QGVAR(treatmentFeedback_patient), _this, _target] call CBA_fnc_targetEvent;

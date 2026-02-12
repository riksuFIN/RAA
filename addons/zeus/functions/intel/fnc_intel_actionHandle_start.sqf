/* File: fnc_actionHandle_start.sqf
 * Author(s): riksuFIN
 * Description: ACE action calls this to start intel gathering sequence
 *						THIS SCRIPT IS CLIENT-SIDE
 
 * Called from: ACE action
 * Local to: 		CLIENT
 * Parameter(s):
 0:	Object containing intel <OBJECT>
 1:	player to call this fnc <OBJECT>
 2:	
 3:	
 *
 Returns:
 *
 * Example:	[_cursorObject, player] call RAA_zeus_fnc_intel_handleAction_start
*/

if !(hasInterface) exitWith {};

params ["_object", "_player"];


private _requiredItem = _object getVariable ["RAA_zeus_intel_requiredItem", ""];
private _requiredPlayer = _object getVariable ["RAA_zeus_intel_requiredPlayer", ""];

// Check that player has required skill to do this
private _failed = false;
private _message = "";
// Failsafe in case required player disconnects
if !(_requiredPlayer in allPlayers) then {
	if (_requiredPlayer isEqualTo _player) then {
		_failed = true;
		_message = selectRandom [
			"You try, but you have no clue where to even begin. Perhaps %1 would be more skilled than you?",
			"You feel like you're not up for this job",
			"You're not confident enough to even give this a try. Just leave it in %1's good hands.",
			"You fail to locate power button. Perhaps %1 else might have better luck?",
			"You try but computer constantly keeps mocking you. And %1 as well.",
			"Your last experience with computers was in '90s, and now you want to do this? Perhaps better to leave it for %1",
			"%1 keeps looking over your shoulder, thinking they'd fare better than you. Perhaps that's true?",
			"if (youReadThis) then {your_missing_required_skill = true && %1_isRequired = true}"
		];
	};
} else {

	if !([_object, _requiredItem] call BIS_fnc_hasItem) then {
		_failed = true;
		_message = selectRandom [
			"It feels like you're missing a key piece... %2, perhaps?",
			"Wait, you forgot %2. You can't proceed without it!",
			"You realize you're missing %2 without which you cannot complete this operation",
			"if (youReadThis) then {error: %2 missing at line 53}",
			"You get this familiar feeling in your stomach.... You forgot %2",
			"%2 is missing! You cannot complete this operation without it!",
			"Required item %2 is missing from your inventory. Please find it and try again",
			"Now don't tell this to anyone but... You forgot %2 again. Better find it quick"
		];
	};
};


if (_failed) exitWith {
	if (RAA_zeus_debug) then {systemChat "[RAA_zeus] ActionHandle_start: Failed Requirements to start action";};
	systemChat format [_message, name _requiredPlayer, _requiredItem];
};







/*
_object setVariable ["RAA_zeus_intel_created", true, true];
_object setVariable ["RAA_zeus_intel_started", false, true];
_object setVariable ["RAA_zeus_intel_requiredItem", _requiredItem, true];
_object setVariable ["RAA_zeus_intel_requiredPlayer", _requiredPlayer, true];
_object setVariable ["RAA_zeus_intel_animation", _animation, true];
_object setVariable ["RAA_zeus_intel_retrievalTime_total", _retrievalTime, true];
_object setVariable ["RAA_zeus_intel_retrievalTime_remaining", _retrievalTime, true];
_object setVariable ["RAA_zeus_intel_title", _intel_title, true];
_object setVariable ["RAA_zeus_intel_text", _intel_text, true];
_object setVariable ["RAA_zeus_intel_retrievalType", _retrievalType, true];
_object setVariable ["RAA_zeus_intel_sharedWith", _intelSharedWith, true];
_object setVariable ["RAA_zeus_intel_isInterrupted", false, true];
_object setVariable ["RAA_zeus_intel_interruped_actionName", "Fix problem", true];
*/




// We made it this far, therefore we can start



[_object] remoteExec ["RAA_zeus_fnc_intel_mainLoop", 2];





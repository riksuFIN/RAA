/* File: fnc_intel_dialogHandle_new.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from:  fnc_intel_dialogCreate_new via remoteExec 2
 * Local to: 	SERVER
 * Parameter(s):
 0:	Object
 1: 	Position
 2: 	DialogValues (from Zeus' dialog)
 3: 
 4:
 *
 Returns:
 *
 * Example:	[] call RAA_zeus_fnc_intel_dialogHandle_new
 */

params ["_object", "_module_pos", "_dialogValues"];
_dialogValues params ["_dialog1", "_requiredItem", "_requiredPlayer", "_animation", "_retrievalTime", "_failChance", "_intel_title", "_intel_text", "_retrievalType", "_intelSharedWith"];

if !(isServer) exitWith {
	systemChat "[RAA_zeus] ERROR: fnc_intel_dialogHandle_new executed outside server";
};




private _face = 0;
// First variable can either define face to use, or object to use based on if "object" is defined or not
switch (typeName _object) do {
	case ("OBJECT"): {
		// We were given object reference, so we need to figure out correct face to use
		switch (_dialog1) do {
			case ("Land_Laptop_unfolded_F"): {_face = 0};
			case ("Land_Laptop_03_black_F"): {_face = 1};
			case ("Land_Laptop_03_olive_F"): {_face = 1};
			case ("Land_PCSet_01_screen_F"): {_face = 0};
			case ("Land_FlatTV_01_F"): {_face = 0};
			case ("Item_SmartPhone"): {_face = 0};
			case ("Land_Tablet_01_F"): {_face = 0};
			case ("Land_Tablet_02_F"): {_face = 0};
			case ("Land_MultiScreenComputer_01_olive_F"): {_face = 2};
			case ("Land_TripodScreen_01_large_black_F"): {_face = 0};
			case ("Land_TripodScreen_01_dual_v2_black_F"): {_face = 0};
		};
		// We also need to create that object to use face on
		_object = _dialog1 createVehicle _module_pos;
	};
	case ("SCALAR"): {
		// dialog1 is face, so object already exists
		_face = _dialog1;
	};
};



// If some item is required to hack intel add that to crate nearby
// This item MUST be type magazine
private _requiredItem_crate = "";
if !(_requiredItem == "NONE") then {
	
	_requiredItem_crate = "Land_PaperBox_01_small_closed_brown_F" createVehicle (getPos _object);
	_requiredItem_crate addMagazineCargoGlobal [_requiredItem, 1];
};




private _animArray = [_animation] call RAA_zeus_fnc_animScreen_getAnimArray;





/*
 * Argument:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon <STRING>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (Optional)
 * 6: Action parameters <ANY> (Optional)
 * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
 * 8: Distance <NUMBER> (Optional)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
 * 10: Modifier function <CODE> (Optional)
 */
/*
private _action = [
"VulcanPinch",		// Action name <STRING>
"Vulcan Pinch",	// Name of the action shown in the menu <STRING>
"",					// Icon <STRING>
{_target setDamage 1;},	// Statement <CODE>
{true},				// Condition <CODE>
{},					// Insert children code <CODE> (Optional)
[parameters],		// Action parameters <ANY> (Optional)
[0,0,0],				// Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
100					// Distance <NUMBER> (Optional)
						// Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
] call ace_interact_menu_fnc_createAction;
[cursorTarget, 0, ["ACE_TapShoulderRight"], _action] call ace_interact_menu_fnc_addActionToObject;
*/

private _remoteExecTarget = -2;
if !(isMultiplayer) then {
	_remoteExecTarget = 0;	// Make sure actions show correctly when testing in SP
};


// ACE action: start
private _action = [
	"RAA_intel_start",		// Action name <STRING>
	"Start collecting intel",	// Name of the action shown in the menu <STRING>
	"",					// Icon <STRING>
	{						// Statement <CODE>
		params ["_target", "_player", "_params"];
		[_target, _player] call RAA_zeus_fnc_intel_handleAction_start;
	},	
	{						// Condition <CODE>
		params ["_target", "_player", "_params"];
		!(_target getVariable ["RAA_zeus_intel_started", false]);
	},				
	{},					// Insert children code <CODE> (Optional)
	[],		// Action parameters <ANY> (Optional)
	[0,0,0],				// Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
	2					// Distance <NUMBER> (Optional)
							// Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
] call ace_interact_menu_fnc_createAction;

[_object, 	// Object the action should be assigned to <OBJECT>
0,						// Type of action, 0 for actions, 1 for self-actions <NUMBER>
["ACE_Actions"], 	// Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
_action] remoteExec ["ace_interact_menu_fnc_addActionToObject", _remoteExecTarget];


// ACE action: pause
_action = [
	"RAA_intel_pause",		// Action name <STRING>
	"Pause intel collection",	// Name of the action shown in the menu <STRING>
	"",					// Icon <STRING>
	{						// Statement <CODE>
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["RAA_zeus_fnc_intel_handleInterruption", 2];
	},	
	{						// Condition <CODE>
		params ["_target", "_player", "_params"];
		_target getVariable ["RAA_zeus_intel_started", false];		// Only show if intel collection already started
	},				
	{},					// Insert children code <CODE> (Optional)
	[],		// Action parameters <ANY> (Optional)
	[0,0,0],				// Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
	2					// Distance <NUMBER> (Optional)
							// Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
] call ace_interact_menu_fnc_createAction;

[_object, 	// Object the action should be assigned to <OBJECT>
0,						// Type of action, 0 for actions, 1 for self-actions <NUMBER>
["ACE_Actions"], 	// Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
_action] remoteExec ["ace_interact_menu_fnc_addActionToObject", _remoteExecTarget];



// ACE action: speed up
_action = [
	"RAA_intel_pause",		// Action name <STRING>
	"Pause intel collection",	// Name of the action shown in the menu <STRING>
	"",					// Icon <STRING>
	{						// Statement <CODE>
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["RAA_zeus_fnc_intel_handleSpeedUp", 2];
	},	
	{						// Condition <CODE>
		params ["_target", "_player", "_params"];
		_target getVariable ["RAA_zeus_intel_started", false];		// Only show if intel collection already started
	},				
	{},					// Insert children code <CODE> (Optional)
	[],		// Action parameters <ANY> (Optional)
	[0,0,0],				// Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
	2					// Distance <NUMBER> (Optional)
							// Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
] call ace_interact_menu_fnc_createAction;

[_object, 	// Object the action should be assigned to <OBJECT>
0,						// Type of action, 0 for actions, 1 for self-actions <NUMBER>
["ACE_Actions"], 	// Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
_action] remoteExec ["ace_interact_menu_fnc_addActionToObject", _remoteExecTarget];



// ACE action: Solve Interruption


_action = [
	"RAA_intel_interruptionSolve",		// Action name <STRING>
	"Pause intel collection",	// Name of the action shown in the menu <STRING>
	"",					// Icon <STRING>
	{						// Statement <CODE>
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["RAA_zeus_fnc_intel_handleSpeedUp", 2];
	},	
	{						// Condition <CODE>
		params ["_target", "_player", "_params"];
		_target getVariable ["RAA_zeus_intel_isInterrupted", false];		// Only show if intel collection already started
	},				
	{},					// Insert children code <CODE> (Optional)
	[],		// Action parameters <ANY> (Optional)
	[0,0,0],				// Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
	2,					// Distance <NUMBER> (Optional)
	[false, false, false, true, false],						// Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
	{	// Modifier function
		params ["_target", "_player", "_params", "_actionData"];

		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, _target getVariable ["RAA_zeus_intel_interruped_actionName", "Restart"]];
		
	}
] call ace_interact_menu_fnc_createAction;

[	_object, 	// Object the action should be assigned to <OBJECT>
	0,						// Type of action, 0 for actions, 1 for self-actions <NUMBER>
	["RAA_intel_pause"], 	// Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
_action] remoteExec ["ace_interact_menu_fnc_addActionToObject", _remoteExecTarget];














private _animInterval = _retrievalTime / (count _animArray);


// Set all variables to object and sync them in network
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

// These are technical stuff that only server needs to know
_object setVariable ["RAA_zeus_intel_remainingFrames", _animArray];
_object setVariable ["RAA_zeus_intel_animIntervals", _animInterval];
_object setVariable ["RAA_zeus_intel_failChance", _failChance];
_object setVariable ["RAA_zeus_intel_face", _face];











/*
Item_Laptop_Unfolded
Item_Laptop_closed
Item_FlashDisk
UMI_Item_Land_Tablet_F"
UMI_Item_Land_Tablet_Rugged_F
UMI_Item_Land_Tablet_Rugged_F


// ITEMS
"UMI_Land_Tablet_Rugged_F","UMI_Land_Tablet_F"

MAGAZINES
["SmartPhone","Laptop_Closed","Laptop_Unfolded"]



Land_FlatTV_01_F
Land_PCSet_01_screen_F
Land_MultiScreenComputer_01_olive_F
Land_TripodScreen_01_large_black_F
Land_TripodScreen_01_dual_v1_F

*/


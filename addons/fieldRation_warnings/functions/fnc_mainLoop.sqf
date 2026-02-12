#include "../script_component.hpp"
/* File: fnc_mainLoop.sqf
 * Authors: riksuFIN
 * Description: Main loop to check player's hunger and thirst and do effects
 *
 * Called from: XEH_PostInit.sqf// CBA_fnc_waitUntilAndExecute
 * Parameter(s):
 0:
 1: 
 2: 
 3: 
 4:
 *
 Returns: 
 
 */

// This script should be executed only after player already exists




if (!RAA_FRW_MasterEnable || !hasInterface) exitWith {
	if (GVAR(debug)) then {
		systemChat "[RAA_FRW] MainLoop run, but immediately exited";
	};
};		// Exit if addon was disabled via CBA setting or is not ran on real player


	// Exit if player is dead or unconscious
if (!(alive player) || (player getVariable ["ace_isunconscious",false])) exitWith {
	if (GVAR(debug)) then {systemChat "[RAA_FRW] MainLoop: Exited because player is dead/ uncon";};
};


private _thirst = player getVariable ["acex_field_rations_thirst",0];
private _hunger = player getVariable ["acex_field_rations_hunger",0];


	// HUNGER -----------------------------------
if (_hunger > RAA_FRW_hungerWarningTreshold) then {
	if (_hunger > 80) exitWith {		// Close to going unconscious, give severe warning
		if (RAA_FRW_enableHungerSound) then {	// Run sound only if it's enabled in CBA setting
			[0, 1, _hunger, player] call FUNC(playSound); 
		};
		
		if (RAA_FRW_HungerVisualWarningType > 0) then { // Do text- based warning
			["Starving", _hunger, true] call FUNC(showVisualWarnings);
		};
	};


	private _warningMedTreshold = (80 - RAA_FRW_hungerWarningTreshold) / 2 + RAA_FRW_hungerWarningTreshold;
	if (_hunger > _warningMedTreshold) exitWith {		// Hunger > 70, play strong stomach growling sound
		[0, 1, _hunger, player] call FUNC(playSound);	//  and exit hunger loop
	//	if (GVAR(debug)) then {systemChat "[RAA_FRW] MainLoop: Hunger > 70, play severe sound";};
	
		if (RAA_FRW_HungerVisualWarningType > 0) then { // Do text- based warning
			["Your stomach is rumbling", _hunger, true] call FUNC(showVisualWarnings);
		};
	};

	// Mild warning
	if (RAA_FRW_enableHungerSound) then {
		[0, 0, _hunger/2, player] call FUNC(playSound);	// Hunger > 50 && < 70, play normal stomach growling sound
	};
	if (RAA_FRW_HungerVisualWarningType > 0) then { // Do text- based warning
		["Starting to feel a little hungry", _hunger, true] call FUNC(showVisualWarnings);
	};
};



	// THIRST -----------------------------
if (_thirst > RAA_FRW_thirstWarningTreshold) then {
	if (_thirst > 80) exitWith {		// Close to going unconscious, give severe warning
		if (RAA_FRW_enableThirstSound) then {	// Run sound only if it's enabled in CBA setting
			[1, 1, _thirst, player] call FUNC(playSound); 
		};
		
		if (RAA_FRW_ThirstVisualWarningType > 0) then {		// Do text- based warning
			["You're feeling desperate for water", 80, false] call FUNC(showVisualWarnings);
		};
		
	//	if (GVAR(debug)) then {systemChat "[RAA_FRW] MainLoop: Thirst > 80, play severe sound and show text";};
	};

	private _warningMedTreshold = (80 - RAA_FRW_thirstWarningTreshold) / 2 + RAA_FRW_thirstWarningTreshold;
	if (_thirst > _warningMedTreshold) exitWith {		// > 70, play strong sound
		if (RAA_FRW_enableThirstSound) then {
			[1, 1, _thirst, player] call FUNC(playSound);	// and exit loop
		};

		if (RAA_FRW_ThirstVisualWarningType > 0) then {
			["Your throat is feeling very dry", _thirst, false] call FUNC(showVisualWarnings);
		};
	};

		// Mild warning
	if (RAA_FRW_enableThirstSound) then {
		[1, 0, _thirst/2, player] call FUNC(playSound);	// > 50 && < 70, play normal sound
	};
	
	if (RAA_FRW_ThirstVisualWarningType > 0) then {
		["Getting thirsty", _thirst, false] call FUNC(showVisualWarnings);
	};
};










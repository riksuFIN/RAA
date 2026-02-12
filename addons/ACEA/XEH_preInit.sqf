#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "CBA_Settings.inc.sqf"

ADDON = true;

// CONVERSION_TO_CBA: No need to touch this file











// Add EH hooks to detect when arsenal is opened/ closed. Used by inventory overView feature
["ace_arsenal_displayOpened", {
	params ["_display"];
	//_this call FUNC(arsenal_overview_update);
	
	if (GVAR(arsenal_overview)) then {
		SETUVAR(arsenalOverView_display,_display);
		
		if (!(isNull curatorCamera) || is3DEN) then {
			// Player is either in curator OR editor, therefore able to touch other unit's inventories than just himself
			// That requires special handling, since CBA EH "loadout" only works for players
			// PerFrameHandlers and waitUntillAndExecute also don't work in 3DEN
			
			// We use spawn to break away from this EH
			[] spawn {
				if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Added update loop";};
				// Then use old-fashioned loop since CBA's solutions are not an option
				while {!isNil "ace_arsenal_center"} do {
					[] call FUNC(arsenal_overview_update);
					sleep 1;
				};
			};
		} else {
			// Normal players can have much more responsive and clean solution to problem
			if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Added EH";};
			
			GVAR(arsenalOverview_eh) = ["loadout", {[] call FUNC(arsenal_overview_update)}, true] call CBA_fnc_addPlayerEventHandler;
			
		};
	} else {
		// User has disabled menu in CBA settings
		{
			private _ctrl = _display displayctrl _x;	// Overview control
			_ctrl ctrlshow false;
			_ctrl ctrlcommit 0.15;
		} forEach [5687, 1099];
	};
	
	// Setup Arsenal Description
	if (GVAR(arsenal_description)) then {
//	if !(GVAR(arsenal_description)) then {
	
		GVAR(arsenal_description_EH) = ["ace_arsenal_displayStats", {
			_this call FUNC(arsenal_description);
		}] call CBA_fnc_addEventHandler;
	} else {
		// Use has disabled Arsenal Description on CBA settings
		private _ctrl = _display displayctrl 5097;	// Overview control
		_ctrl ctrlshow false;
		_ctrl ctrlcommit 0.15;
	};
	
	
}] call CBA_fnc_addEventHandler;

// Remove EH
["ace_arsenal_displayClosed", {
	//[GVAR(arsenalPFH)] call CBA_fnc_removePerFrameHandler;
	if !(isNil QGVAR(arsenalOverview_eh)) then {
		["loadout", GVAR(arsenalOverview_eh)] call CBA_fnc_removePlayerEventHandler;
		GVAR(arsenalOverview_eh) = nil;
	};
	if !(isNil QGVAR(arsenal_description_EH)) then {
		["ace_arsenal_displayStats", GVAR(arsenal_description_EH)] call CBA_fnc_removePlayerEventHandler;
		GVAR(arsenal_description_EH) = nil;
	};
	
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Removed Arsenal EH";};
	
}] call CBA_fnc_addEventHandler;


["ace_arsenal_statsToggle", {
	params ["_display", "_toggle"];
	
	if (GVAR(arsenal_overview)) then {
		private _showToggle = !ctrlShown (_display displayCtrl 5687);
		private _ctrl = controlNull;
		{
			_ctrl = _display displayctrl _x;	// Overview control
			_ctrl ctrlshow _showToggle;
			_ctrl ctrlcommit 0.15;
		} forEach [5687, 1099, 5097];
	};
	
	
	if (RAA_ACEA_debug) then {systemChat "[RAA_ACEA] Arsenal Hid/ Unhid";};
	
}] call CBA_fnc_addEventHandler;






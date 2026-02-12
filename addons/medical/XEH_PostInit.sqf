#include "script_component.hpp"
/* File: XEH_postInit.sqf
 * Authors: riksuFIN
 * Description: 

 * Called from: config.cpp/ XEH_postInit
 * Local to: 
 * Scheduled
 */





// Compile functions
// CONVERSION TO CBA: These are named incorrectly, too much trouble converting these. New functions should use PREP rather than this method
RAA_fnc_ACEA_checkHunger	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_checkHunger.sqf";
RAA_fnc_ACEA_forceFeed	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_forceFeed.sqf";
RAA_fnc_ACEA_onMedicalAction	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_onMedicalAction.sqf";

RAA_fnc_ACEA_naloxone	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_naloxone.sqf";
RAA_fnc_ACEA_naloxone_local	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_naloxone_local.sqf";

RAA_fnc_ACEA_AED_deployitem	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_deployAED.sqf";
RAA_fnc_ACEA_AED_pickUpItem	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_pickUpAED.sqf";

RAA_fnc_ACEA_defib_success	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_defib_success.sqf";
RAA_fnc_ACEA_defib_doDamage_local	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_defib_doDamage_local.sqf";
RAA_fnc_ACEA_AED_canUse	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_AED_canUse.sqf";
RAA_fnc_ACEA_AED_start	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_AED_start.sqf";
RAA_fnc_ACEA_AED_middle	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_AED_middle.sqf";
RAA_fnc_ACEA_AED_doShock	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_AED_doShock.sqf";
RAA_fnc_ACEA_AED_afterShock	= compileFinal preprocessFileLineNumbers "\r\RAA\addons\medical\functions\fnc_AED_afterShock.sqf";






if (hasInterface) then {
	
	// AED pick-up
	private _action = [
		"AED_pick_up",
		"Pick Up AED",
		"",
	//	{deleteVehicle _target; _player addItem 'RAA_AED'},
		{[_target, _player] call RAA_fnc_ACEA_AED_pickUpItem},
	//	{!(_target getVariable ["RAA_AED_inUse", false]) && (_player canAdd "RAA_AED")}
		{true}
	] call ace_interact_menu_fnc_createAction;
	
	[
		"RAA_Item_AED", 
		0, 
		["ACE_MainActions"], 
		_action
	] call ace_interact_menu_fnc_addActionToClass;
	
	
	
	
	// Spawn defib or AED if enabled in CBA setting AND player is medic AND does not already have one
	[	{
			if ([player] call ace_medical_treatment_fnc_isMedic) then {
				
				[player] call compile preprocessFileLineNumbers QPATHTOF(scripts\spawnMedicItems.sqf);
			};
		}, [
			
		],
		8
	] call CBA_fnc_waitAndExecute;
	
	
	
	// Prepare CBA Event for treatmentFeedback
	[QGVAR(treatmentFeedback_patient), LINKFUNC(treatmentFeedback_patient)] call CBA_fnc_addEventHandler;
	
	
	
};


// NOTE TO SELF: THIS LINE HERE IS FATAL AND WILL CAUSE EVERYTHING TO BREAK HOOOOORRIBLY
//if ({alive _x} count allPlayers == 0) then {[5] spawn zafw_fnc_endmission;}
// NEVER, EVER, EVER REMOVE COMMENT FROM THIS!!!

//["ace_treatmentSucceded", {[_this] call RAA_fnc_ACEA_onMedicalAction}] call CBA_fnc_addEventHandler;

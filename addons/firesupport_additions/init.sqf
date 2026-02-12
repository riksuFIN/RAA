#include "script_component.hpp"
/* File: init.sqf
 * Author(s): riksuFIN
 * Description: description
 *
 * Called from: XEH_postInit
 * Local to: 
 * Parameter(s):
 0:		
 *
 Returns:
 *
 * Example:	[true] execVM "\r\misc\addons\RAA_firesupport_additions\init.sqf";
*/
params [["_alreadyDone", false]];


// Define all pre-defined arty types
// Format:
// ["classname", ["prettyName", nameColor], prepTime, reloadingTime, accuracyMin, minRange, maxRange, defaultAmmoCount]
RAA_firesA_artyTypeSettings = [
	// Mortars
	["NONE", [""]],
	["NDS_M224_mortar", ["60mm M224 Mortar", [1,1,1,1]],								15, 2, 10, 75, 35000, 50, "M224"],
	
	["B_Mortar_01_F", ["82mm M252 Mortar", [1,1,1,1]],									20, 4, 10, 100, 50000, 100, "M252"],
	["B_Mortar_01_F", ["82mm 2B14 Podnos Mortar", [1,1,1,1]],						20, 3, 10, 80, 42700, 100, "2B14"],
	
	// Towed guns
	["RHS_M119_D", ["155 K 83-97 Howitzer (Sustained)", [1,1,1,1]], 				120,	20, 50, 100, 280000, 80, "K 83"],
	["RHS_M119_D", ["155 K 83-97 Howitzer (Burst)", [0.5,0.25,0,1]],				140, 	7, 50, 100, 280000, 6, "K 83"],
	["RHS_M119_D", ["105mm M119 Howitzer (Sustained)", [1,1,1,1]], 				120, 	20, 50, 100, 175000, 100, "M119"],
	["RHS_M119_D", ["105mm M119 Howitzer (Burst)", [0.5,0.25,0,1]], 				120, 	8, 50, 100, 175000, 6, "M119"],
	
	["RHS_M119_D", ["155mm M777 Howitzer (Sustained)", [1,1,1,1]], 				100, 30, 50, 100, 21000, 100, "M777"],
	
	["rhs_D30_vmf", ["122mm D30 Howitzer (Sustained)", [1,1,1,1]], 				140, 	20, 50, 100, 154000, 100, "D30"],
	["rhs_D30_vmf", ["122mm D30 Howitzer (Burst)", [0.5,0.25,0,1]], 				140, 	7, 50, 100, 154000, 6, "D30"],
	
	// SPG's
	["rhsusf_m109_usarmy", ["155mm M109 Paladin SPG (Sustained)", [1,1,1,1]],	100, 	50, 40, 200, 210000, 36, "M109"],
	["B_MBT_01_arty_F", ["155mm K9 Thunder SPG (Sustained)", [1,1,1,1]], 		100,	10, 50, 180, 300000, 48, "K9"],
	["B_MBT_01_arty_F", ["155mm K9 Thunder SPG (Burst)", [0.5,0.25,0,1]],		140, 	5, 50, 200, 180000, 3, "K9"],
	["B_MBT_01_arty_F", ["155mm PzH 2000 SPG (Sustained)", [1,1,1,1]], 			70, 	6, 50, 100, 300000, 60, "PzH2000"],
	["B_MBT_01_arty_F", ["155mm PzH 2000 SPG (Burst)", [0.5,0.25,0,1]],		 	110, 	9, 3, 100, 300000, 3, "PzH2000"],
	["rhs_2s1_tv", ["122mm 2S1 Gvodzika SPG (Sustained)", [1,1,1,1]], 			140, 	40, 50, 100, 150000, 40, "2S1"],
	["rhs_2s1_tv", ["122mm 2S1 Gvodzika SPG (Burst)", [0.5,0.25,0,1]], 			140, 	12, 50, 100, 150000, 3, "2S1"],
	["rhs_2s3_tv", ["154.4mm 2S3 Akatsiya SPG (Sustained)", [1,1,1,1]], 			130, 	60, 50, 100, 180000, 46, "2S3"],
	["rhs_2s3_tv", ["154.4mm 2S3 Akatsiya SPG (Burst)", [0.5,0.25,0,1]], 		150, 	15, 50, 100, 180000, 3, "2S3"],
	["O_MBT_02_arty_F", ["154.4mm 2S19 Msta SPG (Sustained)", [1,1,1,1]], 		120, 	7, 50, 100, 250000, 50, "2S19"],
	
	["O_MBT_02_arty_F", ["152mm PLZ-05A (Type-5) SPG (Sustained)", [1,1,1,1]], 120, 	7.5, 50, 100, 390000, 50, "PLZ-05A"],
	["O_MBT_02_arty_F", ["152mm PLZ-05A (Type-5) SPG (Burst)", [0.5,0.25,0,1]],120, 	5, 50, 100, 390000, 3, "PLZ-05A"],
	["O_MBT_02_arty_F", ["122mm PLZ-07 (Type-7) SPG (Sustained)", [1,1,1,1]], 	110, 	8.57, 50, 100, 220000, 40, "PLZ-07"],
	
	["B_Ship_Gun_01_F", ["127mm Mk45 Naval Gun (US)", [1,1,1,1]], 					45, 	3, 50, 100, 370000, 100, "Mk45"],
	["B_Ship_Gun_01_F", ["100mm Modèle 68 CADAM Naval Gun (FR)", [1,1,1,1]], 	45, 	0.77, 50, 100, 120000, 200, "Mod 68"],
	["B_Ship_Gun_01_F", ["130mm AK-130 Naval Gun (RU)", [1,1,1,1]], 				75, 	2, 50, 100, 200000, 100, "AK-130"]
];

// Array of all ammo types (class name) available to correspoding gun at same index in above array
// Pretty names come from config
//	["CLASSNAME"],
RAA_firesA_artyAmmoTypes = [
//	["NONE"],	// Gun Unassigned
	["NDS_M_6Rnd_60mm_HE", "8Rnd_82mm_Mo_Smoke_white", "RAA_mag_mortar_illum"],	// 225	, "8Rnd_82mm_Mo_Flare_white"
	["rhs_12Rnd_m821_HE", "8Rnd_82mm_Mo_Smoke_white", "RAA_mag_mortar_illum", "RAA_mag_arty_illum_IR"],	// 252	, "8Rnd_82mm_Mo_Flare_white"
	["rhs_mag_3vo18_10", "rhs_mag_d832du_10", "RAA_mag_mortar_illum"],	// podnos	, "rhs_mag_3vs25m_10"
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// 155
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// 155
	["RHS_mag_m1_he_12", "rhs_mag_m60a2_smoke_4", "RAA_mag_arty_illum", "RAA_mag_arty_illum_IR"],	// 119	, "rhs_mag_m314_ilum_4"
	["RHS_mag_m1_he_12", "rhs_mag_m60a2_smoke_4", "RAA_mag_arty_illum", "RAA_mag_arty_illum_IR"],	// 119	, "rhs_mag_m314_ilum_4"
	["RHS_mag_m1_he_12", "rhs_mag_m60a2_smoke_4", "RAA_mag_arty_illum", "RAA_mag_arty_illum_IR", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"],	// M777
	["rhs_mag_3of56_10", "rhs_mag_d462_2", "RAA_mag_arty_illum"],	// d30	, "rhs_mag_s463_2"
	["rhs_mag_3of56_10", "rhs_mag_d462_2", "RAA_mag_arty_illum"],	// d30	, "rhs_mag_s463_2"
	["rhs_mag_155mm_m795_28", "rhs_mag_155mm_m825a1_2", "rhs_mag_155mm_m864_3", "RAA_mag_arty_illum", "RAA_mag_arty_illum_IR", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"],	// palad	, "rhs_mag_155mm_485_2", "rhs_mag_155mm_m712_2", "rhs_mag_155mm_m731_1", "rhs_mag_155mm_raams_1"
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// k9	, "2Rnd_155mm_Mo_LG", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// k9	, "2Rnd_155mm_Mo_LG", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// k9	, "2Rnd_155mm_Mo_LG", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"
	["32Rnd_155mm_Mo_shells", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_Cluster", "RAA_mag_arty_illum"],	// k9	, "2Rnd_155mm_Mo_LG", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine"
	["rhs_mag_3of56_35"],	// gvod	, "rhs_mag_bk13_5"
	["rhs_mag_3of56_35"],	// gvod	, "rhs_mag_bk13_5"
	["rhs_mag_HE_2a33", "rhs_mag_WP_2a33", "rhs_mag_SMOKE_2a33", "RAA_mag_arty_illum"],	// aka	, "rhs_mag_ILLUM_2a33", "rhs_mag_LASER_2a33"
	["rhs_mag_HE_2a33", "rhs_mag_WP_2a33", "rhs_mag_SMOKE_2a33", "RAA_mag_arty_illum"],	// aka	, "rhs_mag_ILLUM_2a33", "rhs_mag_LASER_2a33"
	["32Rnd_155mm_Mo_shells_O", "6Rnd_155mm_Mo_smoke_O", "2Rnd_155mm_Mo_Cluster_O", "RAA_mag_arty_illum"],	// msta	, "rhs_mag_ILLUM_2a33", "4Rnd_155mm_Mo_LG_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "6Rnd_155mm_Mo_AT_mine_O"

	["32Rnd_155mm_Mo_shells_O", "6Rnd_155mm_Mo_smoke_O", "2Rnd_155mm_Mo_Cluster_O", "RAA_mag_arty_illum"],	// Type-5	, "rhs_mag_ILLUM_2a33", "4Rnd_155mm_Mo_LG_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "6Rnd_155mm_Mo_AT_mine_O"
	["32Rnd_155mm_Mo_shells_O", "6Rnd_155mm_Mo_smoke_O", "2Rnd_155mm_Mo_Cluster_O", "RAA_mag_arty_illum"],	// Type-5	, "rhs_mag_ILLUM_2a33", "4Rnd_155mm_Mo_LG_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "6Rnd_155mm_Mo_AT_mine_O"
	["32Rnd_155mm_Mo_shells_O", "6Rnd_155mm_Mo_smoke_O", "2Rnd_155mm_Mo_Cluster_O", "RAA_mag_arty_illum"],	// Type-7	, "rhs_mag_ILLUM_2a33", "4Rnd_155mm_Mo_LG_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "6Rnd_155mm_Mo_AT_mine_O"
	
	["magazine_ShipCannon_120mm_HE_shells_x32"],	// Mk45 Ship Gun
	["magazine_ShipCannon_120mm_HE_shells_x32"],	// CADAM
	["magazine_ShipCannon_120mm_HE_shells_x32"]	// AK-130
	
];


//getText (configFile >> "CfgMagazines" >> "rhs_mag_3vs25m_10" >> "displayName")
// displayName = "Flare (White)";





// These arrays tell this module what gun is designated at each slot. Number is index of above arrays
// NOTE added at later date:
// This solution can be replaced with much better one by adding information from these arrays
// directly as variable to each gun module and read from there
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

RAA_firesA_test_setGlobalVariables = false;	 // This is used for debug testing

if (_alreadyDone) exitWith {
	systemChat "[FiresA] Init re-executed to clean up everything";
};


["Fire Support", "Tun Artillery: Add/ Edit Battery", {
	params ["_pos","_object"];
	
	if (RAA_firesA_customGunsAdded) then {
	//	[RAA_firesA_fnc_createDialog_editGun, _pos, true] call RAA_firesA_fnc_createDialog_selectSide;
		[FUNC(createDialog_editGun), _pos, true] call FUNC(createDialog_selectSide);
		
	} else {
		// If no guns are defined in editor go right ahead. Otherwise warn about deleting pre-defined guns
		if ((count tun_firesupport_guns_west == 0) && (count tun_firesupport_guns_east == 0) && (count tun_firesupport_guns_resistance == 0) && (count tun_firesupport_guns_civilian == 0)) then {
			RAA_firesA_customGunsAdded = true;
			publicVariable "RAA_firesA_customGunsAdded";
			[FUNC(createDialog_editGun), _pos, true] call FUNC(createDialog_selectSide);
			
		} else {
			// There is at least one gun defined via pre-placed modules.
			// Those are not supported and will be deleted if Zeus module is used
			
			
			playSound "RscDisplayCurator_error01";
			
			["PRE-PLACED GUN MODULES WILL BE DELETED",
				[ // CONTENT
					["TOOLBOX:YESNO",
					["Are you sure you wish to proceed?", "Gun modules placed by mission maker are not supported\nby this Zeus module and will be deleted"],
						[	// Values
							false
						]
					]
					
				], { // ON CONFIRM CODE
					(_this select 0) params ["_dialog1"];
					(_this select 1) params ["_module_pos"];
					
					// Accepted, we will delete pre-defined guns and make our own ones
					if (_dialog1) then {
						
						// Delete all pre-placed modules
						private _allModules = tun_firesupport_guns_west + tun_firesupport_guns_east + tun_firesupport_guns_resistance + tun_firesupport_guns_civilian;
						{
							// Delete all synchronized ammo modules
							{
								deleteVehicle _x;
							} forEach synchronizedObjects _x;
							
							// Now delete gun module itself
							deleteVehicle _x;
							
						} forEach _allModules;
						
						// Clean arrays as they now return objNull
						tun_firesupport_guns_west = [];
						publicVariable "tun_firesupport_guns_west";
						tun_firesupport_guns_east = [];
						publicVariable "tun_firesupport_guns_east";
						tun_firesupport_guns_resistance = [];
						publicVariable "tun_firesupport_guns_resistance";
						tun_firesupport_guns_civilian = [];
						publicVariable "tun_firesupport_guns_civilian";
						
						RAA_firesA_customGunsAdded = true;
						publicVariable "RAA_firesA_customGunsAdded";
						
						[FUNC(createDialog_editGun), _module_pos, true] call FUNC(createDialog_selectSide);
						
						if (RAA_firesA_debug) then {systemChat "[RAA_firesA] Deleted pre-placed gun modules";};
					};
					
					
				},{	// On cancel code
				},[	// Arguments
				_pos
				]
			] call zen_dialog_fnc_create;
			
			
			
		};
	};
	
},
"\A3\Armor_F_Gamma\MBT_01\Data\UI\Slammer_Scorcher_M4_Base_ca.paa"
] call zen_custom_modules_fnc_register;




["Fire Support", "Tun Artillery: Add/ Edit Ammo", {
	params ["_pos","_object"];
	
	if (RAA_firesA_customGunsAdded) then {
		[FUNC(createDialog_editAmmo), _pos, true] call FUNC(createDialog_selectSide);
		
	} else {
		["Battery must be first created using Tun Artillery Add/ Edit Battery!"] call zen_common_fnc_showMessage;
	};
	
	
},
"\A3\Armor_F_Gamma\MBT_01\Data\UI\Slammer_Scorcher_M4_Base_ca.paa"
] call zen_custom_modules_fnc_register;
